# Telegram app for Sailfish OS

Depecher - telegram client for Sailfish OS based on [tdlib library](https://github.com/blacksailer/td/tree/cmake)

Features:
- Send/View/Delete messages
- View photos
- View stickers
- Uploading/Downloading photos/docs
- Receive notifications
- 2FA authorization enabled

## TODO
- [x] smooth scrolling
- [x] emoji support (WIP)
- [x] chat selection (WIP)
- [ ] fix voice notes bug for ios users
- [ ] update tdlib
- [ ] enable call and animated stickers

#### Want to contribute?

- Review code!
- Create issue for missing features!
- Do something really cool!

### To build this app required:

## Installing dependencies

Enter the sailfish os build machine (Start it from Tools/Options/Sailfish OS/Start Virtual Machine)
```
ssh -p 2222 -i ~/SailfishOS/vmshare/ssh/private_keys/engine/mersdk mersdk@localhost
```
Enter the Kit you want to use (use the arm)
```
sb2 -m sdk-install -R -t SailfishOS-3.2.1.20-armv7hl
    
```
Add the tdlibjson repo
```
zypper ar http://repo.merproject.org/obs/home:/blacksailer:/branches:/home:/blacksailer/sailfish_latest_armv7hl/ tdlibsjon 
    
```
Refresh zypper repos
```
zypper ref  
```
Install dependencies
```
zypper install tdlibjson tdlibjson-devel  
```

1. tdlibjson tdlibjson-devel [rpm](https://openrepos.net/content/blacksailer/tdlibjson) package installed 
2. APP_ID and APP_HASH changed in tdlibjson_wrapper.pro


