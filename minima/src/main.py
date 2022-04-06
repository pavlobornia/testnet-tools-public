import requests
import time
import telebot
import config
from datetime import datetime, timedelta, timezone

token = config.token
chat_id = config.chat_id
file = config.file
bot = telebot.TeleBot(token=token)

def rewards_info(username, password):
    while True:
        # Start the session
        session = requests.Session()
        # Create the payload
        payload = {'username': username, 'password': password}
        # Post the payload to the site to log in
        s = session.post("https://incentivecash.minima.global/api/login", data=payload)
        # Navigate to the next page and scrape the data
        s = session.get('https://incentivecash.minima.global/api/rewards')
        # Create json object with a rewards data
        if s.status_code != 200:
            bot.send_message(chat_id, text=f'{username}\n'
                                           f'Сonnection Error {s.status_code}. Will try in 10 min..')
            session.close
            time.sleep(600)
        elif s.status_code == 200:
            json_obj = s.json()
            session.close
            break
    return(json_obj)

# Parse rewards information
def parse_rewards(json_obj):
    lastPingDatetime = datetime.strptime((json_obj.get('lastPing')), '%Y-%m-%dT%H:%M:%S.%f%z')
    lastPing = lastPingDatetime.strftime("%d %B %Y %H:%M:%S")
    dailyRewards = str(json_obj.get('rewards').get('dailyRewards'))
    previousRewards = str(json_obj.get('rewards').get('previousRewards'))
    return lastPing, lastPingDatetime, dailyRewards, previousRewards

# Send notification to Telegram
def send_notification(lastPing, lastPingDatetime, dailyRewards, previousRewards):
    # Check if Last Ping not exceeds 24 hours and send message
    if (datetime.now(tz=timezone.utc) - lastPingDatetime) > timedelta(1): 
        bot.send_message(chat_id, text=f'\U0001F198 {username}\n'
                                       f'Last Ping: {lastPing}\n'
                                       f'Daily Rewards: {dailyRewards}\n'
                                       f'Previous Rewards: {previousRewards}\n')
    else:
        bot.send_message(chat_id, text=f'\u2705 {username}\n'
                                       f'Last Ping: {lastPing}\n'
                                       f'Daily Rewards: {dailyRewards}\n'
                                       f'Previous Rewards: {previousRewards}\n')

# Open login:password file
with open(file, 'r') as accounts:
    for line in accounts:
        lst = line.split(':')
        username = lst[0]
        password = lst[1].strip()
        send_notification(*parse_rewards(rewards_info(username,password)))
