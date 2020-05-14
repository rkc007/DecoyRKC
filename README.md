# Decoy Routing with Email as Covert Channel

Decoy Routing (DR), a promising approach to censorship circumvention, uses routers (rather than end hosts) as proxy servers.
Users of censored networks, who wish to use DR, send specially crafted packets, nominally addressed to an uncensored website.
This project is based on implementing Decoy Routing from scratch using Email as Covert Channel. 

This major components of this repository are:
1. _Client_, who wishes to use Decoy Routing and reach a censored website.
2. _Overt-destination_, a website, which censor thinks client wants to visit.
3. _Covert-destination_, a website, which client **really** wants to visit.
4. _Proxy_, a machine, who proxies client's traffic and fetches covert-destination for it.
5. _SDN Controller_, which installs relevant redirection rules on SDN switches.
                                                             

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on system.

### Prerequisites

These steps are for Ubuntu 18.04 and derivatives.

### Installing
---
#### Option 1

Clone a fresh copy of code. Install Dependencies and Build Code.
1. `https://github.com/rkc007/DecoyRKC.git`
2. `chmod +x build_dependencies.sh && chmod +x build_code.sh`
3. `./build_dependencies.sh && ./build_code.sh`
---
#### Option 2

Install all dependencies and code one by one.
###### Install Generic Dependencies
1. `sudo apt update && sudo apt install gcc make python-minimal libssl-dev git python-pip`
###### Install Seccure
1. `sudo apt install libgmp-dev build-essential python-dev python-pip libmpfr-dev libmpc-dev`
2. `pip install seccure`
###### Install Ryu
1. `pip install ryu`
###### Install libpcap
1. `sudo apt install libpcap-dev`
###### Build Signalling Mechanism
There are two signaling mechanisms in place - "smtplib/imap" and webmail. "smtplib/imap" is written in python for sending emails, when invoked by client code. Any of them can be used with client's c code.

###### Install webmail dependencies
1. Install [Chrome](https://www.google.com/chrome/)
2. Install [ChromeDriver](https://sites.google.com/a/chromium.org/chromedriver/)
3. Test whether chromedriver works by typing `$ chromedriver` in terminal.
4. `pip install scapy selenium`

###### Install "smtplib/imap" dependencies
1. `pip install scapy easyimap`

###### Build "C" Code
###### Build Client
1. `cd ./client/c`
2. `make`
3. `cd ../../`
###### Build proxy
1. `cd ./proxy/`
2. `make center`
3. `make single_conn`
4. `cd ../`
---
## Deployment
#### As a Client
1. `cd <repo_path>/client/c`
2. `sudo ./client.o OD_IP 443 URL TIMEOUT`
3. Example Usage : `sudo ./client.o https://allowed_site.com 443 https://censored_site.com 40`
4. By default, webmail singalling mechanism is used. This can be changed to "smtp/imap" based signaling in [client.c](https://github.com/rkc007/DecoyRKC/blob/master/client/c/client.c#L155) by changing 'client_email.py' to '[smtp_client_send.py](https://github.com/rkc007/DecoyRKC/blob/master/client/smtp/smtp_client_send.py)'

#### As a Proxy
1. `cd <repo_path>/main/proxy/`
2. `sudo ./center.o`

#### As a Controller
1. `cd <repo_path>/controller/`
2. `ryu-manager controller_HP.py`
3. Depending upon which signalling mechanism used in client setup, run corresponding email receiver in controller system.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details


## Acknowledgements:
1. base64.h used from https://github.com/superwills/NibbleAndAHalf


