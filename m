From: Jaswinder Singh Rajput <jaswinderlinux@gmail.com>
Subject: Re: How to determine the information about SATA controller
Date: Sun, 12 Sep 2010 12:33:22 +0530
Message-ID: <AANLkTin8F3=VJ1yoOrNR_hP+52ReYCdL7+LCFBjCEv5D@mail.gmail.com>
References: <AANLkTimMxQXxC354V=qVOrdUYFSrpJ-RZeKJfQEx0KPN@mail.gmail.com>
	<19595.23873.90306.656565@pilspetsen.it.uu.se>
	<AANLkTinQVQsjxJLpZQiP5V56o7quGPY6G0ZOnvwPAKbx@mail.gmail.com>
	<19595.34143.859553.402816@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <19595.34143.859553.402816@pilspetsen.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

> =A0> >
> =A0>
> =A0> In my case, BIOS options are enhanced / legacy / disabled. I tri=
ed all
> =A0> but of no use. So I am using enhanced to boot Fedora 13 kernel.
>
> We need to see the complete kernel messages from a failed boot to
> determine the root cause of that missing root device failure.
>
> I suggest hooking up a null-modem serial cable to a second machine
> and run minicom on that one to capture boot messages, but there may
> be other ways to capture boot messages: netconsole? firewire?
>

Netbook is also using SATA Intel controller :
http://userweb.kernel.org/~jaswinder/acer_netbook/config-2636rc3-netboo=
k.txt

I used netbook config and with little bit modification as CPU and
network device is changed, I am able to boot the kernel :

dmesg :
http://userweb.kernel.org/~jaswinder/P4_HT/dmesg_2636_test_netbook.txt

config:
http://userweb.kernel.org/~jaswinder/P4_HT/config-ht-test-netbook.txt

Thanks for your help,
--
Jaswinder Singh.
