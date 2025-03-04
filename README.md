# Automate SSL-Certification

**1. Install Certbot**

```python
sudo apt update && sudo apt install certbot python3-certbot-nginx -y

```

2. Obtain an SSL Certificate

```python
#for nginx
sudo certbot --nginx -d example.com -d www.example.com

#for apache
sudo certbot --apache -d example.com -d www.example.com

```

3. Set Up Automatic Renewal

```python
#To check if renewal works:
sudo certbot renew --dry-run

#To automate renewal, add a cron job:
sudo crontab -e

#Add this line to run renewal every day at midnight:
#for nginx
0 0 * * * certbot renew --quiet --post-hook "systemctl reload nginx"
#for apache
0 0 * * * certbot renew --quiet --post-hook "systemctl reload apache2"

```

4. Verify Renewal

```python
sudo openssl x509 -noout -dates -in /etc/letsencrypt/live/example.com/fullchain.pem

```

**Optinal For Docker Based Auto renewal**

```python
version: '3.7'
services:
  certbot:
    image: certbot/certbot
    volumes:
      - ./letsencrypt:/etc/letsencrypt
      - ./varlib:/var/lib/letsencrypt
    command: renew --noninteractive --agree-tos --post-hook "nginx -s reload"

```

command to run

```python
docker-compose run certbot

```