From: Gavin Cameron <gavin@gavsworld.net>
Subject: Re: Frequent Head Unload Problem
Date: Wed, 15 Apr 2009 23:58:58 +0100
Message-ID: <49E666B2.6090708@gavsworld.net>
References: <49E4BF3E.9040105@gavsworld.net> <49E537F4.8000807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay.pcl-ipout01.plus.net ([212.159.7.99]:14673 "EHLO
	relay.pcl-ipout01.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752138AbZDOW7K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Apr 2009 18:59:10 -0400
In-Reply-To: <49E537F4.8000807@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Hi Robert,

Thanks for the quick reply ... comments below.

Robert Hancock wrote:
> Gavin Cameron wrote:
>> Hi,
>>
>> It's been a while since I've been in touch. I previously had 2 problems:
>> 1. PATA DVD writer not working
>> 2. Frequent HDD head unloads
>>
>> I eventually caved in and replaced the PATA DVD drive with a SATA and 
>> that works perfectly. However, this head unloading is really annoying 
>> primarily because the noise the drives makes just doens't sound 
>> healthy - it's a high pitch squeal and then a couple of clicks.
> 
> Can you tell which drive is doing it? I'm assuming it's not both.. If 
> you can figure out which one you can try some different APM values to 
> see if that helps anything. You could also try disabling the standby 
> timer in case that's doing it, with "hdparm -S 0".
> 
> If none of those help, there may not be a lot else you can do about it. 
> The OS really has no control over when the drive decides to unload, 
> other than those settings..

I can't be sure which drive is making the noise - it may be hard to find 
out as one drive is the root file system and the other is /home so both 
are normally needed (unless I do a bit of hacking). The noise is the 
same every time, so it may be just one of them. As it happens, /dev/sdb 
(the drive allocated to /home) is the older of the two drives.

The unloading itself is very predominant within the first 15 minutes of 
the PC being powered - happening between 1 and 3 times a minute. 
However, eventually it decreases to perhaps once every half hour. It 
often happens twice in succession too.

I've tried the following with no success:
sudo hdparm -S 0 /dev/sda
sudo hdparm -S 0 /dev/sdb
sudo /sbin/hdparm -B 253 /dev/sda
sudo /sbin/hdparm -B 253 /dev/sdb
sudo /sbin/hdparm -B 128 /dev/sda
sudo /sbin/hdparm -B 128 /dev/sdb
( as well as 254 and 255)

I know you're saying that there's not much else can be done from an OS 
point of view, however ... this particular PC didn't make this noise 
until kernel 2.6.19 (I think it was) that started using libata. Also, 
it's a dual boot machine (although I hate admitting that to people - but 
still need it for gadget firmware updates) ... and when it runs XP, the 
drives never make a noise. Not that I'm trying to say that Windows is 
any good for anything ... it's just an observation.

There was also the previous problem with the PATA DVD drive not working. 
So I still believe that the libata kernel module has some problems with 
this chip set (perhaps combined with particular drive usage, I'm not sure).

Hopefully, there may be some other file or command output that I can 
provide to you that will help to diagnose this. If so, please let me 
know and I'll gladly provide it :-)

Best regards,
Gavin.

> 
>>
>> Anyway, a reminder of the basic system:
>>     * ASUS M2V M/B (VIA K8T890 / VIA VT8237A chipset)
>>     * AMD Athlon 64 X2 6000+
>>     * SATA LiteOn DVD RAM/RW
>>     * Ubuntu 9.04 (Beta) - kernel 2.6.28-11-generic
>>
>> Since I last was in touch, I've converted the system to Ubuntu (I was 
>> hoping that it was a Fedora quirk) with no change in head unloads with 
>> either 8.10 or 9.04.
>>
>> I've tried the following in /etc/rc.local :
>> /sbin/hdparm -B 254 /dev/sda
>> /sbin/hdparm -B 254 /dev/sdb
>>
>> Which makes no difference at all. Also, I tried setting 255, but that 
>> also had no affect.
>>
>> I've included all of the normal files that I think you may need:
>>
>> sudo dmidecode > dmidecode.txt
>> sudo hdparm -I /dev/sda > hdparm-sda.txt
>> sudo hdparm -I /dev/sdb > hdparm-sdb.txt
>> sudo smartctl -a /dev/sda > smartctl-sda.txt
>> sudo smartctl -a /dev/sdb > smartctl-sdb.txt
>> lsmod > lsmod.txt
>>
>> Hopefully you can find the root of the problem.
>>
>> Best regards,
>> Gavin.
>>
> 
> 

