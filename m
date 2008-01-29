From: Gene Heskett <gene.heskett@gmail.com>
Subject: Re: Problem with ata layer in 2.6.24
Date: Mon, 28 Jan 2008 23:49:11 -0500
Message-ID: <200801282349.11696.gene.heskett@gmail.com>
References: <200801272122.21823.gene.heskett@gmail.com>
 <200801281135.14555.gene.heskett@gmail.com>
 <1201580616.12795.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:53370 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbYA2Ete (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jan 2008 23:49:34 -0500
In-reply-to: <1201580616.12795.2.camel@localhost>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: Mikael Pettersson <mikpe@it.uu.se>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ide Mailing list <linux-ide@vger.kernel.org>

On Monday 28 January 2008, Kasper Sandberg wrote:
 [...]
>> >We have no way of debugging that module, so please try 2.6.24 without it.
>>
>> Sorry, I can't do this and have a working machine.  The nv driver has
>> suffered bit rot or something since the FC2 days when it COULD run a 19"
>> crt at 1600x1200, and will not drive this 20" wide screen lcd 1680x1050
>> monitor at more than 800x600, which is absolutely butt ugly fuzzy, looking
>> like a jpg compressed to 10%.  The system is not usable on a day to basis
>> without the nvidia driver.
>>
>> Fix the nv driver so it will run this screen at its native resolution and
>> I'll be glad to run it even if it won't run google earth, which I do use
>> from time to time.  Now, if in all the hits you can get from google on
>> this, currently 14,800 just for 'exception Emask', apparently caused by a
>> timeout, if 100% of the complainers are running nvidia drivers also, then
>> I see a legit
>
>I can invalidate this theory...
>i helped a guy on irc debug this problem, and he had ati. I tried having
>him stop using fglrx, and go to r300.. same problem, and same problem
>even with vesa.. :)
>
No Kasper, you are validating it, that it is not nvidia related, which is what 
I was also saying.

>also, i have this on my fileserver with .20, which doesent even run X,
>or module support in kernel :)

That far back?  Although ISTR I saw it happen once only when I was running 
2.6.18-somethingorother.

>> complaint.  Again, fix the nv driver so it will run my screen & I'll be
>> glad to switch.  I can see the reason, sure, but the machine must be
>> capable of doing its common day to day stuff, while using that driver,
>> like running kde for kmail, and browsers that work.
>>
>> >If the problems persist, please try to capture a complete log from the
>> >failing kernel -- the interesting bits are everything from initial boot
>> >up to and including the first few errors. You may need to increase the
>> >kernel's log buffer size if the log gets truncated
>> > (CONFIG_LOG_BUF_SHIFT).
>>
>> If by log you mean /var/log/messages, I have several megabytes of those.
>> If you mean a live dmesg capture taken right now, its attached. It
>> contains several of these at the bottom.  I long ago made the kernel log
>> buffer bigger, cuz it couldn't even show the start immediately after the
>> boot, and even the dump to syslog was truncated.
>>
>> >There are no pata_amd changes from 2.6.24-rc7 to 2.6.24 final.
>>
>> That is what I was afraid of.  I've done some limited grepping in that
>> branch of the kernel tree, and cannot seem to locate where this EH handler
>> is being invoked from.
>>
>> There is 2 lines of interest in the dmesg:
>>
>> [    0.000000] Nvidia board detected. Ignoring ACPI timer override.
>> [    0.000000] If you got timer trouble try acpi_use_timer_override
>>
>> But I have NDI what it means, kernel argument/xconfig option?
>>
>> I've also done some googling, and it appears this problem is fairly
>> widespread since the switchover to libata was encouraged.  A stock fedora
>> F8 kernel suffers the same freezes and eventually locks up, but does it
>> without the error messages being logged, it just freezes, feeling
>> identical to this in the minutes before the total freeze.  I've tried 2 of
>> those too, but the newest one won't even run X.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
bureaucrat, n:
	A politician who has tenure.
