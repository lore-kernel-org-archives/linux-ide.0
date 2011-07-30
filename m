From: Ryan Castellucci <ryan.castellucci@gmail.com>
Subject: Re: "device error via D2H FIS" w/ Samsung drive and Si3726
Date: Sat, 30 Jul 2011 11:16:14 -0700
Message-ID: <CAO+W5ho__d_mEfttna8kYC-1zbD06P8B6ejrpxRkb0dxZU=REA@mail.gmail.com>
References: <CAO+W5hp61FEEz1gks-=uYfNB4L=Fw6UWU1r4tOUALLZfXrVufg@mail.gmail.com>
 <20110730125553.GO2622@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35155 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271Ab1G3SQz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jul 2011 14:16:55 -0400
Received: by yxi11 with SMTP id 11so2694446yxi.19
        for <linux-ide@vger.kernel.org>; Sat, 30 Jul 2011 11:16:54 -0700 (PDT)
In-Reply-To: <20110730125553.GO2622@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Sat, Jul 30, 2011 at 5:55 AM, Tejun Heo <tj@kernel.org> wrote:
> On Tue, Jul 26, 2011 at 08:59:39PM -0700, Ryan Castellucci wrote:
>> I've got a eight bay RAID enclosure with two Si3726 based port
>> multipliers. I have some Seagate ST31500341AS drives which work fine=
,
>> but my Samsung HD204UI do not like this. =A0I've tried swapping the
>> cable. =A0I've tried both with a on-board JMB362 AHCI and a Si3132 a=
nd
>> get similar errors. =A0On the Si3132 (with latest non-raid firmware)=
:
>>
>> I have eight of these Samsung drives and they all do the same thing,
>> but work fine when direct attached.
>>
>> Here's what spews into the kernel log:
>
> Can you please attach full dmesg output? =A0The log you posted is too
> incomplete to tell what's going on.

Thanks for responding... I seem to not be getting emails from the list
- maybe majordomo doesn't like me? (i tried to subscribe...)

I eventually figured out that I was having pretty much the exact same
problem as the guy in this thread:

http://www.spinics.net/lists/linux-ide/msg38500.html

The unlock command[1] there worked once the disks settled... and my
claim of them working fine direct attached was based on an identical
disk that hadn't been molested by the 3ware controller.

Having the kernel detect a 'drive is locked' condition and give an
error about that (as suggested in the other thread) would have saved
me a few hours of troubleshooting. It looks like some work was done on
a patch to implement that functionality[2] but I'm not sure what
became of it - this particular box has 2.6.38 on it which hasn't
implemented that.
If you would still like the full dmesg output let me know and I'll dig
up my logs and attach them.

1. hdparm --user-master u --security-disable "3wareUserPassword
       " /dev/sdX
2. http://www.spinics.net/lists/linux-ide/msg38566.html
--=20
Ryan Castellucci http://ryanc.org/
