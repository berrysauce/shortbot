# shortbot
Short Links via Discord 🔗✨

## FAQ
https://brry.cc/shortbot

## Usage & Development
This project is licensed under the MIT License. Please refer to this Email (support@berrysauce.me) to get a permission to redistribute (download and make publicly available or host) this code. You are free to use the code for development purposes without a permission.

## Development
1. Install this Bot by downloading and extracting the files (or using `git clone <URL>`). 
2. Then, create a `.env` file and fill it with the following content:
```
DISCORD=<DISCORD TOKEN>
REBRANDLY=<REBRANDLY TOKEN>
VERSION=<CURRENT VERSION>
```
3. Go into the code and change the Domain ID to your Rebrandly domain.
```
request.body = "{\"domain\":{\"id\":\"<DOMAIN ID>\"},\"destination\":\"#{longurl}\"}"
```
Note: Delete the `<>` in the Placeholders.

4. Install all dependencies.
```
gem install discordrb
gem install json
gem install uri
gem install net/http
gem install openssl
```
5. Run the code.
`ruby main.rb`
