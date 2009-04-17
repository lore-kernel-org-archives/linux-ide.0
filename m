From: Gavin Cameron <gavin@gavsworld.net>
Subject: Re: Frequent Head Unload Problem
Date: Fri, 17 Apr 2009 18:50:05 +0100
Message-ID: <49E8C14D.7020907@gavsworld.net>
References: <49E4BF3E.9040105@gavsworld.net> <49E537F4.8000807@gmail.com> <49E666B2.6090708@gavsworld.net> <49E67576.8070704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:24191 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758961AbZDQRuK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Apr 2009 13:50:10 -0400
In-Reply-To: <49E67576.8070704@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Robert Hancock wrote:
> Gavin Cameron wrote:
>> Hi Robert,
>>
>> Thanks for the quick reply ... comments below.
>>
>> Robert Hancock wrote:
>>> Gavin Cameron wrote:
>>>> Hi,
>>>>
>>>> It's been a while since I've been in touch. I previously had 2 
>>>> problems:
>>>> 1. PATA DVD writer not working
>>>> 2. Frequent HDD head unloads
>>>>
>>>> I eventually caved in and replaced the PATA DVD drive with a SATA 
>>>> and that works perfectly. However, this head unloading is really 
>>>> annoying primarily because the noise the drives makes just doens't 
>>>> sound healthy - it's a high pitch squeal and then a couple of clicks.
>>>
>>> Can you tell which drive is doing it? I'm assuming it's not both.. If 
>>> you can figure out which one you can try some different APM values to 
>>> see if that helps anything. You could also try disabling the standby 
>>> timer in case that's doing it, with "hdparm -S 0".
>>>
>>> If none of those help, there may not be a lot else you can do about 
>>> it. The OS really has no control over when the drive decides to 
>>> unload, other than those settings..
>>
>> I can't be sure which drive is making the noise - it may be hard to 
>> find out as one drive is the root file system and the other is /home 
>> so both are normally needed (unless I do a bit of hacking). The noise 
>> is the same every time, so it may be just one of them. As it happens, 
>> /dev/sdb (the drive allocated to /home) is the older of the two drives.
>>
>> The unloading itself is very predominant within the first 15 minutes 
>> of the PC being powered - happening between 1 and 3 times a minute. 
>> However, eventually it decreases to perhaps once every half hour. It 
>> often happens twice in succession too.
> 
> Can you try doing smartctl -a on both drives before and after you hear 
> the noise and see if it seems to match up with any of the counters 
> changing?

Here's the build up:
sudo smartctl -a /dev/sda > sda_start
sudo smartctl -a /dev/sdb > sdb_start
... a few mins while noises go on ...
sudo smartctl -a /dev/sda > sda_end
sudo smartctl -a /dev/sdb > sdb_end

Here are the results:
diff sda_start sda_end
13c13
< Local Time is:    Fri Apr 17 16:03:40 2009 BST
---
 > Local Time is:    Fri Apr 17 16:17:20 2009 BST
66c66
< 194 Temperature_Celsius     0x0002   253   253   000    Old_age 
Always       -       17 (Lifetime Min/Max 9/38)
---
 > 194 Temperature_Celsius     0x0002   240   240   000    Old_age 
Always       -       25 (Lifetime Min/Max 9/38)
88a89
 >

So nothing there apart from the temperature. However:
diff sdb_start sdb_end
13c13
< Local Time is:    Fri Apr 17 16:03:42 2009 BST
---
 > Local Time is:    Fri Apr 17 16:17:26 2009 BST
57,59c57,59
<   7 Seek_Error_Rate         0x000a   199   199   000    Old_age 
Always       -       80
<   8 Seek_Time_Performance   0x0027   246   238   187    Pre-fail 
Always       -       39281
<   9 Power_On_Minutes        0x0032   229   229   000    Old_age 
Always       -       710h+53m
---
 >   7 Seek_Error_Rate         0x000a   199   198   000    Old_age 
Always       -       43
 >   8 Seek_Time_Performance   0x0027   246   238   187    Pre-fail 
Always       -       45449
 >   9 Power_On_Minutes        0x0032   229   229   000    Old_age 
Always       -       711h+07m
65,66c65,66
< 194 Temperature_Celsius     0x0032   037   253   000    Old_age 
Always       -       17
< 195 Hardware_ECC_Recovered  0x000a   253   251   000    Old_age 
Always       -       36907
---
 > 194 Temperature_Celsius     0x0032   037   253   000    Old_age 
Always       -       24
 > 195 Hardware_ECC_Recovered  0x000a   253   251   000    Old_age 
Always       -       31779
70c70
< 199 UDMA_CRC_Error_Count    0x0008   084   001   000    Old_age 
Offline      -       768
---
 > 199 UDMA_CRC_Error_Count    0x0008   100   001   000    Old_age 
Offline      -       768
72c72
< 201 Soft_Read_Error_Rate    0x000a   253   252   000    Old_age 
Always       -       0
---
 > 201 Soft_Read_Error_Rate    0x000a   253   252   000    Old_age 
Always       -       2
100a101
 >

Looks to me like this drive could well be on its way out! None of the 
counters (Start_Stop_Count for example) were changing, but lots of CRC 
and error counts are.

What do you think? Just a knackered drive and nothing to do with libata 
at all?

Regards,
Gavin.

> 
>>
>> I've tried the following with no success:
>> sudo hdparm -S 0 /dev/sda
>> sudo hdparm -S 0 /dev/sdb
>> sudo /sbin/hdparm -B 253 /dev/sda
>> sudo /sbin/hdparm -B 253 /dev/sdb
>> sudo /sbin/hdparm -B 128 /dev/sda
>> sudo /sbin/hdparm -B 128 /dev/sdb
>> ( as well as 254 and 255)
>>
>> I know you're saying that there's not much else can be done from an OS 
>> point of view, however ... this particular PC didn't make this noise 
>> until kernel 2.6.19 (I think it was) that started using libata. Also, 
>> it's a dual boot machine (although I hate admitting that to people - 
>> but still need it for gadget firmware updates) ... and when it runs 
>> XP, the drives never make a noise. Not that I'm trying to say that 
>> Windows is any good for anything ... it's just an observation.
>>
>> There was also the previous problem with the PATA DVD drive not 
>> working. So I still believe that the libata kernel module has some 
>> problems with this chip set (perhaps combined with particular drive 
>> usage, I'm not sure).
>>
>> Hopefully, there may be some other file or command output that I can 
>> provide to you that will help to diagnose this. If so, please let me 
>> know and I'll gladly provide it :-)
>>
>> Best regards,
>> Gavin.
>>
>>>
>>>>
>>>> Anyway, a reminder of the basic system:
>>>>     * ASUS M2V M/B (VIA K8T890 / VIA VT8237A chipset)
>>>>     * AMD Athlon 64 X2 6000+
>>>>     * SATA LiteOn DVD RAM/RW
>>>>     * Ubuntu 9.04 (Beta) - kernel 2.6.28-11-generic
>>>>
>>>> Since I last was in touch, I've converted the system to Ubuntu (I 
>>>> was hoping that it was a Fedora quirk) with no change in head 
>>>> unloads with either 8.10 or 9.04.
>>>>
>>>> I've tried the following in /etc/rc.local :
>>>> /sbin/hdparm -B 254 /dev/sda
>>>> /sbin/hdparm -B 254 /dev/sdb
>>>>
>>>> Which makes no difference at all. Also, I tried setting 255, but 
>>>> that also had no affect.
>>>>
>>>> I've included all of the normal files that I think you may need:
>>>>
>>>> sudo dmidecode > dmidecode.txt
>>>> sudo hdparm -I /dev/sda > hdparm-sda.txt
>>>> sudo hdparm -I /dev/sdb > hdparm-sdb.txt
>>>> sudo smartctl -a /dev/sda > smartctl-sda.txt
>>>> sudo smartctl -a /dev/sdb > smartctl-sdb.txt
>>>> lsmod > lsmod.txt
>>>>
>>>> Hopefully you can find the root of the problem.
>>>>
>>>> Best regards,
>>>> Gavin.
>>>>
>>>
>>>
>>
> 
> 

