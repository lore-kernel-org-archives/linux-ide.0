From: Tejun Heo <htejun@gmail.com>
Subject: Re: Scary Intel SATA problem: "frozen"
Date: Wed, 29 Nov 2006 16:29:03 +0900
Message-ID: <456D36BF.1060809@gmail.com>
References: <456CB72A.3010004@local.se> <456CDB06.40806@gmail.com> <456D3370.5050003@local.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:36387 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S935441AbWK2H3N (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Nov 2006 02:29:13 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1708675uga
        for <linux-ide@vger.kernel.org>; Tue, 28 Nov 2006 23:29:10 -0800 (PST)
In-Reply-To: <456D3370.5050003@local.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jonas@local.se
Cc: linux-ide@vger.kernel.org, torvalds@osdl.org

Jonas Lundgren wrote:
>> Also, does 'mount -o remount,barrier=0 /' change anything?
> 
> I will post this info as soon as I can "reproduce" the error.

If it doesn't occur as soon as you boot, it's probably irrelevant.

> Atm I run the ICH8 SATA ports in AHCI mode with "IDE bus master"(To be
> honest I don't really know what this option does, no info about it in
> the BIOS nor the mobo manual) turned off in BIOS. The drives are
> connected to port 1, 3, 6 and 8 (raptor+raptor on 1+3, and WD 250G + WD
> 250G (also a raid0) on ports 6+8)

I guess that's just your mobo's way of telling that ahci mode is active.

[--snip--]
>> Please full dmesg after your computer got really slow.  I suspect libata
>> decided to switch to PIO mode.
> 
> If that's so, how come I still get good read speeds? o.O

Yeah, if you're still getting good read speed, PIO mode hasn't kicked in.

>>> I don't know what causes it, but most of the times when I've gotten it
>>> my system has been under heavy load (compiling, downloading torrents in
>>> 11mb/sec etc). Please let me know if you want any additional info, want
>>> me to try something out, or whatever. My recent hardware upgrade for
>>> around $1200 (to a core2duo system, i965 mobo) is just going to waste
>>> because of this problem. :/
>> Heh, nice machine you got there.  When you look at the dmesg, do the
>> error messages occur only on one of the two drives?  Or are both
>> affected?  If only one is affected,
> 
> IIRC only sda is affected, and later today I'm gonna switch back to
> non-AHCI mode and try to reproduce this error (This might be my
> imagination, but it feels like I get the error more frequently if I
> don't run the ports in AHCI mode..) so I can try out the things you've
> listed here.. Would suck if there's a hardware problem with one of my
> disks, but I guess it's possible.

Cabling/power issue is more likely than faulty hard drive, I think. 
Interestingly, you're more likely to encounter insufficient power 
problem if you have multi-lane power supply (most high-powered ones are 
multi-lane these days) because they have less power per lane.

e.g. Single-lane 350w power supply won't have problem powering 5 drives 
no matter how you connect them but if you somehow hook up five drives to 
a single lane in 450w multi-lane power, you're screwed.  Furthermore, 
it's not always clear which cable belongs to which power lane.

>> 1. swap the two.  you'll probably have to dance a little bit with boot
>> loader but md should handle that fine once the kernel is loaded.  does
>> the errors persist?  on which device do they occur?  do they follow the
>> drive or stay on the mobo port?
> 
> (I'm running my /boot on a raid1, so switching drives should require no
> reconfiguration at all :)
> 
>> 2. try different cable / port.  if you change port, again, you need to
>> dance w/ boot loader.  who's carrying the error messages with it?
>>
>> 3. try different power plug from different power lane.
>>
>>> I just got so glad when I saw the post of this on linux-ide, I've been
>>> searching like crazy to find another person having the same problem (and
>>> possibly a solution) for the past 2-3 weeks or so.
>> My first guess is frequent transmission errors.  Please report the test
>> results.  Thanks.
>>
> 
> I've pushing my system really hard for half an hour or so to reproduce
> this problem, and I got something else (no write speed slowdown, but
> some page allocation errors, no idea if this has something to do with
> anything, but I'll post it anyways)

You pushed your box really hard and the kernel can't get the memory it 
wants.  Not really relevant to SATA problem.

-- 
tejun
