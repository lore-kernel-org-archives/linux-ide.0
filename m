From: Tim Small <tim@buttersideup.com>
Subject: Re: [smartmontools-support] SATA drive reset/disable events on ICH7
 ata_piix when polling SMART info
Date: Sat, 06 Feb 2010 15:26:10 +0000
Message-ID: <4B6D8A12.70200@buttersideup.com>
References: <4B6C2635.105@buttersideup.com> <alpine.DEB.2.00.1002050911500.7774@p34.internal.lan> <4B6C2BC8.7000609@buttersideup.com> <4B6C91F3.5090809@teksavvy.com> <4B6CE473.7060901@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([63.246.152.102]:38235 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997Ab0BFP0v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Feb 2010 10:26:51 -0500
In-Reply-To: <4B6CE473.7060901@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mark Lord <kernel@teksavvy.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, "smartmontools-support@lists.sourceforge.net" <smartmontools-support@lists.sourceforge.net>, linux-ide@vger.kernel.org

Tejun Heo wrote:
>> The only constants seem to be libata and ICH7/8.
>> We must have a bug somewhere in there.
>>     
>
> In piix mode or ahci mode?  If in piix mode, ich7 and 8 would behave
> quite differently.  ICH8 has SIDPR so it can hardreset while 7 can't.
> ICH SIDPR access had a hardware problem where write to SControl to
> clear DET is sometimes ignored which led to occassional hardreset
> failure which got fixed recently.  The reason why ich's are involved
> in those incidents could just be that they are extremely popular.
>   

It's a non-AHCI capable ICH7, so it's in piix mode.

> Things to try after such completely drive shutdown are...
>   

Unfortunately I can't do much with this box, as it's a rented box in a
datacentre, however....

> * Soft reset the machine.  Can BIOS recognize the drive?
>   

Yes, if I either 'echo b > /proc/sysrq-trigger', then the BIOS
recognises the drive, and the box reboot normally.

> In many cases I've seen, it's usually that the drive's firmware is
> completely hung and only power cycling the drive brought it back.  But
> then again, there have been some number of cases which didn't get
> diagnosed properly, so it's definitely possible that we're doing
> something wrong in the driver.
>
> Anyways, if it happens again, please try the above and try to find out
> whether the controller or the drive is hung.  Also, please keep in
> mind that timeouts on 0xEA (flush) is very often indicative of power
>   

OK, I didn't think I was seeing those - is it possible to tell from the
detail which I posted in my original message?  As for the potential for
PSU shenanigans - I don't have access to the box to fiddle with that,
unfortunately, but I believe I can stress the I/O subsystem quite
heavily with dd and/or bonnie, but it's only when polling for SMART
status that these errors show up.  I've just started dd (to RAID mirror)
+ hdparm -I again to check...

Do the SMART error counters in the OP make this suspicious?  Is there
likely to be any different between running smartctl -a and hdparm -I  in
terms of code path taken though the kernel, or timings on the hardware,
as far as you know?

Cheers,

Tim.
