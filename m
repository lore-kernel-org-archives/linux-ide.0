From: Tejun Heo <tj@kernel.org>
Subject: Re: [smartmontools-support] SATA drive reset/disable events on ICH7
 ata_piix when polling SMART info
Date: Mon, 08 Feb 2010 11:49:40 +0900
Message-ID: <4B6F7BC4.8090104@kernel.org>
References: <4B6C2635.105@buttersideup.com> <alpine.DEB.2.00.1002050911500.7774@p34.internal.lan> <4B6C2BC8.7000609@buttersideup.com> <4B6C91F3.5090809@teksavvy.com> <4B6CE473.7060901@kernel.org> <4B6D8A12.70200@buttersideup.com> <4B6DA74C.2040007@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53003 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753442Ab0BHCnl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Feb 2010 21:43:41 -0500
In-Reply-To: <4B6DA74C.2040007@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Tim Small <tim@buttersideup.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, "smartmontools-support@lists.sourceforge.net" <smartmontools-support@lists.sourceforge.net>, linux-ide@vger.kernel.org

Hello,

On 02/07/2010 02:30 AM, Mark Lord wrote:
>>> * Soft reset the machine.  Can BIOS recognize the drive?
>>
>> Yes, if I either 'echo b > /proc/sysrq-trigger', then the BIOS
>> recognises the drive, and the box reboot normally.

Hmmm... this means one of the followings.

1. The controller side is hung and needs some sort of reset or
   reinitialization to get working again.

2. The drive is hung requiring hardreset to continue.  ata_piix
   currently can't do hardresets on ich7 but resetting the machine
   will definitely generate hardrsets.

3. The BIOS actually power-cycles the machine when told to reboot.
   Some BIOSen do this.

No chance you can access the machine there?

>>> Anyways, if it happens again, please try the above and try to find out
>>> whether the controller or the drive is hung.  Also, please keep in
>>> mind that timeouts on 0xEA (flush) is very often indicative of power
>>>   
>>
>> OK, I didn't think I was seeing those - is it possible to tell from the
>> detail which I posted in my original message?  As for the potential for
>> PSU shenanigans - I don't have access to the box to fiddle with that,
>> unfortunately, but I believe I can stress the I/O subsystem quite
>> heavily with dd and/or bonnie, but it's only when polling for SMART
>> status that these errors show up.  I've just started dd (to RAID mirror)
>> + hdparm -I again to check...

Oh... if that's the case, PSU problem wouldn't be very probable.

>> Do the SMART error counters in the OP make this suspicious?  Is there
>> likely to be any different between running smartctl -a and hdparm -I  in
>> terms of code path taken though the kernel, or timings on the hardware,
>> as far as you know?

>From driver's POV, hdparm and smart commands behave pretty much the
same.  They travel through the same high/mid layer paths and gets
issued using the same command protocol.  From drive's POV, I imagine
it can be pretty different tho.

> My theory on the problem when I first had it here, was that doing
> a FLUSH_CACHE[_EXT] before any PIO command (eg. SMART) should prevent
> the problem.  This was never explored further (by me or others).

If that's the case, what would that mean?  Would it be some nasty
interaction inside the drive firmware?

Thanks.

-- 
tejun
