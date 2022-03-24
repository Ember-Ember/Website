---
title: "How to Set Up Remark"
date: 2022-03-24T12:58:05+11:00
tags: [""]
author: ""
draft: false
showToc: true
url: "/remark-setup/"
TocOpen: false
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
comments: true
editPost:
    URL: "https://github.com/MagentaPuppy/MagentaSite/blob/main/content"
    Text: "Suggest Changes" # edit text
    appendFilePath: true # to append file path to Edit link
params:
    ShowShareButtons: true
---

## [This is not content made by myself](https://github.com/Hrothgar32/almoszediu-website/blob/master/content/posts/how-to-set-up-remark.md) {#disclaimer}

One of the challenges of starting a blog like this is to add a commenting
mechanism in order to connect with your audience. There are many options
available, but today I'll be explaining why I've chosen Remark, what are it's
particular advantages which make me choose it over other options, and how did I
set it up on my site. This
particular guide is aimed primarily toward fellow Hugo users, but I think it can
be followed by others as well, due to the way I hacked it into my blog.


## The competition {#the-competition}


### [Disqus](https://disqus.com) {#disqus}

Let's get the elephant out of the room, shall we? Disqus is easy to set up, easy to use, and comes built in with Hugo, moreover
you can set it up for free! Well, when something is too good to be true, it
usually isn't. Disqus comes with advertisements, which it displays on your
website and these ads may be totally out of touch with your actual content, for
example:
![](/images/disqus-ads.png)
Yikes, disques-sting! So yeah, your blog may be filled with tabloid crap,
unless you pay $10 a month, which for me, as a student, is a little bit much.
Moreover, Disqus not only shows ads to your readers, but [also tracks them in a
parasitic way to sell their data,](https://chrislema.com/killed-disqus-commenting/) and the gateway might be your blog.


### [Staticman](https://staticman.net/) {#staticman}

Staticman is a free and open source project which aims to bring form integration
to fully static websites. The cool thing about this is that you can
integrate it to your free to host GitHub pages site, because of the generous
support by [Snipcart](https://snipcart.com/). Because of it's open source nature, you can even host it on
your site if you're so inclined.
What's the deal breaker then? It's FOSS, it doesn't poke around in your
business, why didn't I choose this? Well, it seemed to me a bit... lacking, not
as pretty as Remark. It also lacks the social integration and avatars used
by other comment engines.

{{< figure src="/images/staticman.png" >}}


### [Utterances](https://utteranc.es) {#utterances}

"A lightweight comments widget built on GitHub issues." Sounds amazing! But not
so much for me. Don't get me wrong, I love you fellow nerds, but I think the
choice should be given to you, if you want the world to see your lovely face
next to your comment, or not. It might be useful for some of you though, who
want the advantages of GitHub pages with additional GitHub goodness. It's a
creative and elegant solution, I'll have to give it that.

{{< figure src="/images/utterances.png" >}}


### [Commento](https://commento.io/) {#commento}

Commento has a very nice business model, and I think it proves, that open-source
can be turned into a business just as easily as proprietary applications. It
also received $19,200 from the Mozzilla foundations, which shows its
seriousness, I think. This comment engine can also be self hosted with Docker so
I think it really comes down to personal preference, if you choose this or
Remark. I might try it out in the future, because it supports many of the
features, which were important to me. If you ask me, why I've chosen Remark, I
would say that because it gave me more Redditesque vibes, to be honest.

{{< figure src="/images/commento.png" >}}


## [Remark itself](https://github.com/umputun/remark42) {#remark-itself}

Well I've could have gone over the whole "Comments alternatives" part of the
Hugo docs, but I chose to cover just those which I was considering. The main
things, that ultimately lead me to choose Remark were:

-   it's free and open source
-   self-hosted option
-   OAuth2 features easily enabled through it's docker-compose file
-   RSS for you, flamewar warriors
-   it looks like Reddit

It's self-hosted which for me, as a do-everything-yourself, Emacs loving madman
is acceptable, even desirable, but you might have different needs, or don't want
to be bothered by hosting a blog on a VPS. I won't be going into VPS hosting,
because that is beyond the scope of this blogpost, just know, that the
alternatives listed above don't need self-hosting.
I won't be posting pictures about it, because you can check it out right under
the article.
Let's talk about how did I set it up though?


## Setup, part I:  your ingredients {#setup-part-i-your-ingredients}


### 1 teaspoon of Docker {#1-teaspoon-of-docker}

**Shell commands for Ubuntu-boys (also for Debian-boomers)**

I assume that you use version 16.04 or higher of Ubuntu or a distribution
based off of Ubuntu. My server runs on
version 18.04 which seems to be the most prevalent version in hosting as of
now.

```bash
sudo apt-get update
sudo apt-get install docker docker-compose
```

**Shell commands for Arch-mages**

Well I've done some toy projects on Arch Linux, but I don't know if it's very
suitable for server usage, because of it's bleeding edge nature.

```bash
sudo pacman -Sy
sudo pacman -S docker docker-compose
```

**Shell commands for Fedora-fanatics**

I'm not an expert on Fedora, but the Docker guys say, that you should have a
version of minimum Fedora 30. I mainly copied the commands from their site, so
you lazy bastards won't have to open another tab, so take these with a grain
of salt.

```bash
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-compose
```

The next step is to enable the Docker service through systemd:

```bash
sudo systemctl start docker
```

Another cool thing would be to add your user to the docker group. Without
this, you'd have to run docker commands with sudo, or worse, as the root user,
so I think it's time you show the server that you're a big boy now:

```bash
sudo usermod -aG docker *your_username*
```

After this, you should be able to use the docker commands which I'll be using.
Sweet!


### 1 cup of nginx {#1-cup-of-nginx}

Back when I started to play around with Python, I couldn't understand why
you'd need a reverse proxy, or a general purpose HTTP server for that matter.

Nginx does the wonderful thing of allowing multiple applications to connect
to the world using the same port. Why's that a good thing? It leaves fewer
points of attack for malicious users and other monsters under your bed, and
let's you easily configure subdomains for your various sites. Heck it even functions as a load balancer, to redirect traffic to other servers, if
you have the need (I don't. Yet.). I haven't used Apache, so I can't give
advice on that.

**Shell commands for Ubuntu-boys (also for Debian-boomers)**

```bash
    sudo apt-get update
    sudo apt-get install nginx
```

**Shell commands for Arch-wizards**

```bash
sudo pacman -Sy
sudo pacman -S nginx
```

**Shell commands for Fedora-fanatics**

```bash
sudo dnf install nginx
```

Now that the software is fine and dandy, it's time to enable it through good ol'
systemd:

```bash
sudo systemctl start nginx
sudo systemctl enable nginx
```

The latter command is for times when you want to reboot your server.

If we want to communicate with the outside world, we need to enable nginx on our
HTTP and HTTPS ports (assuming that you want to have/have an SSL certificate).
This can be done with the following command:

```bash
sudo ufw allow 'NGINX HTTP_ALL'
```

Doing this step on Arch might not be as trivial unfortunately, unless you did
the firewall setup. If you didn't you might want to check it out on the [Arch
Wiki](https://wiki.archlinux.org/index.php/Category:Firewalls), which does a way more detailed and practical guide on it, than I could.


### 1 gear of Certbot {#1-gear-of-certbot}

Well, you actually will need all of Certbot's capabilities here, but don't worry,
this one's pretty easy to install! This program will provide an SSL certificate
for your website and the Remark server, which are required especially if you
will have visitors sending comments to that server. Even if you already have an
SSL certificate for your main domain, the server needs to be under it as well,
otherwise  your browser will complain about the website operating with HTTPS and
HTTP together.

**Shell commands for Ubuntu-boys (Debian-boomers can skip the updating steps)**

```bash
    sudo apt-get update
    sudo apt-get install software-properties-common
    sudo add-apt-repository universe
    sudo add-apt-repository ppa:certbot/certbot
    sudo apt-get update
    sudo apt-get install certbot python3-certbot-nginx
```

**Shell commands for Arch-wizards**

```bash
sudo pacman -S certbot certbot-nginx
```

**Shell commands for Fedora-fanatics**

```bash
sudo dnf install certbot certbot-nginx
```


## Setup, part II: setting up the subdomain {#setup-part-ii-setting-up-the-subdomain}

Technically, you could set up Remark42 without a subdomain, the official method
is using one, and it actually isn't that difficult to set it up.
First, you need to go to your domain registrar's (the company from which you
bought your domain name) website, and on the page on which you can see your
settings for that particular domain, go to the DNS options.

{{< figure src="/images/namecheap.png" >}}

{{< figure src="/images/godaddy.png" >}}

On that page, you will want to add a new A record. For the "name" or "host"
option you want to change the default @ character to the name of your subdomain,
and in the "value" section you write the public IP address of your server.
![](/images/examople.png)


## Setup, part III: running Remark42 via docker {#setup-part-iii-running-remark42-via-docker}

First and foremost, you'll need a **docker-compose.yml** file. This basically
tells Docker what is the base program, and you will provide some details on how
to set it up. I will provide an example configuration here:

```yaml
version: '2'

services:
    remark:
        build: .
        image: umputun/remark42:latest
        container_name: "remark42"
        hostname: "remark42"
        restart: always

        logging:
            driver: json-file
            options:
                max-size: "10m"
                max-file: "5"

        # uncomment to expose directly (no proxy)
        #ports:
        #  - "80:8080"

        environment:
            - REMARK_URL=
            - SECRET=
            - SITE=
            - STORE_BOLT_PATH=/srv/var/db
            - BACKUP_PATH=/srv/var/backup
            - DEBUG=true
            - AUTH_GOOGLE_CID
            - AUTH_GOOGLE_CSEC
            - AUTH_GITHUB_CID=
            - AUTH_GITHUB_CSEC=
            - AUTH_FACEBOOK_CID
            - AUTH_FACEBOOK_CSEC
            - AUTH_DISQUS_CID
            - AUTH_DISQUS_CSEC
            # - ADMIN_PASSWD=password
        volumes:
            - ./var:/srv/var
```

You can leave most of these alone, but you **have to** give values to some
of these options:

-   REMARK\_URL

    This is the URL of the remark server, and it will be your domain name
    prefixed with your subdomain: <https://remark.exampledomain.com>
-   SECRET

    This has to be a unique string. Many backend applications have these for
    security reasons.
-   SITE

    This is the ID of your website, which runs Remark42, you just give it a
    string, which has to matched in your HTML snippet down to line: **example\_id**

Apart from these, you have to provide an authentication method by which your
user's can identify themselves. This can be done through Facebook, Disqus,
Google and GitHub. I'm going to show you how you can obtain GitHub OAuth
authentication, the process is similar other social media applications.

1.  Go to <https://github.com/settings/developers> and click on "New OAuth App"
    ![](/images/github-oauth.png)
2.  Fill in the form. Application name can be whatever your heart desires, the
    **Homepage URL** will take the form: <https://remark.exampledomain.com>.

    The **Application Callback URL** is the URL by which your Remark42 server
    authenticates to GitHub, and will take the form:
    <https://remark.exampledomain.com/auth/github/callback>
3.  After you've done this, you can access your application's **Client ID** and
    **Client Secret** copy these to their corresponding (**AUTH\_GITHUB\_CID**,
    **AUTH\_GITHUB\_CSEC**) properties in your **docker-compose.yaml** file.

The [Remark42 README file](https://github.com/umputun/remark42#github-auth-provider) is actually really easy to follow regarding OAuth
access, I just wrote the process here so you don't have to open other pages.
Regardless, we can finally start our Remark42 server with Docker!

```bash
docker-compose pull
docker-compose up -d
```

After this is done, you want to find out the IP address of your Docker container
to later forward to it the traffic coming from your subdomain.

```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' remark42
```


## Setup, part IV: nginx magic {#setup-part-iv-nginx-magic}

The default way to your nginx config is: **/etc/nginx/sites-available/default**.
Open it with your favorite text editor, (don't forget to sudo) and add a new
**server block** similar to this one:

```json
server {
   server_name remark.exampledomain.com;
   location / {
         proxy_pass http://your_docker_ip:8080;
   }
}
```

This tells nginx to reroute every incoming request to your docker container, which is a
wonderful thing, because you don't have to open additional ports on your
firewall.
After you edit and save your config file, restart nginx:

```bash
sudo systemctl restart nginx
```


## Setup, part V: Certbot certificates {#setup-part-v-certbot-certificates}

Now you will get SSL certificates for your Remark server, and if you haven't
done it yet, for your website as well.
It couldn't be any easier than typing in:

```bash
sudo certbot --nginx
```

Just follow it's instructions, they are really straightforward. I'd advice to
set rerouting to HTTPS by default.
After completing Cerbot's instructions, if you visit <https://remark.exampledomain.com/web>, you should see
something similar to this:
![](/images/demo.png)


## Setup, part VI: Getting it to the Front! {#setup-part-vi-getting-it-to-the-front}

We've done all this good work, now we just have to make it appear under our
posts! To do that, you'll have to visit your Hugo project's main folder (the one
with **config.toml** in it) and get the
**_themes_--your\_theme\_name--/layouts/posts/single.html** file (I assume every
Hugo themes directory structure's similar).
This is not a regular HTML file, but one with template engine markup. Don't get
intimidated by it, but copy in this snippet, BEFORE the final **{{- end -}}** tag:

```js
<script>
  var remark_config = {
    host: , // hostname of remark server, same as REMARK_URL in backend config,
    site_id: , //same as the ID you set in the docker-compose.yaml file
    components: ['embed'], // optional param; which components to load. default to ["embed"]
                    // to load all components define components as ['embed', 'last-comments', 'counter']
                    // available component are:
                    //     - 'embed': basic comments widget
                    //     - 'last-comments': last comments widget, see `Last Comments` section below
                    //     - 'counter': counter widget, see `Counter` section below
    max_shown_comments: 10, // optional param; if it isn't defined default value (15) will be used
    theme: 'dark', // optional param; if it isn't defined default value ('light') will be used
    locale: 'en' // set up locale and language, if it isn't defined default value ('en') will be used
  };

  (function(c) {
    for(var i = 0; i < c.length; i++){
      var d = document, s = d.createElement('script');
      s.src = remark_config.host + '/web/' +c[i] +'.js';
      s.defer = true;
      (d.head || d.body).appendChild(s);
    }
  })(remark_config.components || ['embed']);
</script>
```

Complete the **host** and **site\_id** sections with the instructions left in the comments.
Now you only have one last thing to do insert this little snippet of HTML where
you see fit on your HTML page:

```HTML
<div id="remark42"></div>
```


## Final thoughts {#final-thoughts}

If you've made it to the end of it, and now have a new shiny comment box under
your posts: congratulations! You've made another place on the interwebs to start
a flame war. All jokes aside, I hope I could help with this little tutorial. For
more details and documentation on Remark42 visit it's GitHub page: <https://github.com/umputun/remark42>.

