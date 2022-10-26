FROM theteamultroid/ultroid:main

# Install Dart
 RUN apt-get update > /dev/null 2>&1
 RUN apt-get install apt-transport-https > /dev/null 2>&1
 RUN sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' > /dev/null 2>&1
 RUN sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list' > /dev/null 2>&1
 RUN apt-get update > /dev/null 2>&1
 RUN apt-get install dart > /dev/null 2>&1

# Set Timezone
ENV TZ=Asia/Kolkata

RUN mkdir /root/TeamUltroid/
WORKDIR /root/TeamUltroid
# RUN wget -O .env https://raw.githubusercontent.com/Gajalshankar/Ultroid-workflow/main/.env

# CMD [ "dart", "main.dart" ]

# download the latest release from github
RUN ver=$(curl https://raw.githubusercontent.com/BLUE-DEVIL1134/UltroidCli/main/version.txt) && curl -L -o ultroid https://github.com/BLUE-DEVIL1134/UltroidCli/releases/download/$ver/ultroid-linux
RUN chmod u+x ultroid

RUN ./ultroid init

# Clone the repository and install the dependencies
RUN python -m pip install --upgrade pip	
RUN pip3 install --no-cache-dir -r ./TeamUltroid/requirements.txt
RUN pip3 install --no-cache-dir -r ./TeamUltroid/re*/st*/op*.txt
RUN wget -O .env https://raw.githubusercontent.com/Gajalshankar/Ultroid-workflow/main/.env

RUN ./ultroid env.get all
# Create a new [.env] file
RUN ./ultroid env.create new

# Set the Variables in [.env] file
RUN ./ultroid env.API_ID 15854543
RUN ./ultroid env.API_HASH b80056d505d60826de86c82a8c6c7264
RUN ./ultroid env.SESSION 1BVtsOGkBu8abSNMDmfO5P76ogDWavESCeUxyuXs77QvS_mUFLAxedKJKN-WjPcnWV-woaFuRsFg0IXIJNQolF_2rOwA9MMKyRdGibq3FOZyb-YvtTy1SwocwNC0vvLjytQOV2bRE-xeAfNHj_STMbMOIhg6YV7mmTmCq4JrImQn7la__FnYHDS4GvT-gnn4iAG_FZXjumx3H9AuU8FXrerfIoLb2-UvwBSdkcJU2B4MVMb-u1Qo2D0Kpuxs5phA2adSTaggkkmLdvJSInAD-nSAqhZJsHQL9LAyq-DuB61aham_jBMAmFBjP5vyWXCNdVid3d7yBSq4M4pO2JCXGvd7sRE7DTVM=
RUN ./ultroid env.REDIS_URI redis-15934.c90.us-east-1-3.ec2.cloud.redislabs.com:15934
RUN ./ultroid env.REDIS_PASSWORD aHm2cjamkuLnb8vB70jzQSbOl609o2vi
RUN ./ultroid env.LOG_CHANNEL -1001622457113
RUN ./ultroid env.BOT_TOKEN 5552978659:AAGiDSwd3ZMS30pHUPwiQyCr-dYgEH9fzds

# Print the versions
RUN ./ultroid version

# Run Ultroid
CMD ["./ultroid", "run"]
