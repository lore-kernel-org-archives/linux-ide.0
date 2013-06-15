From: Gene Heskett <gheskett@wdtv.com>
Subject: Re: troubleshoot disk problems / libata error messages
Date: Sat, 15 Jun 2013 04:42:37 -0400
Message-ID: <201306150442.37242.gheskett@wdtv.com>
References: <kpgpst$fh8$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.wdtv.com ([66.118.69.84]:56427 "EHLO mail.wdtv.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752920Ab3FOIuG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Jun 2013 04:50:06 -0400
In-Reply-To: <kpgpst$fh8$1@ger.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Saturday 15 June 2013 04:08:13 scar did opine:

> hello, not sure if this is best place to seek help but i couldn't seem
> to find any more appropriate mailing lists...
> 
> i've been having HDD issues lately, and the issues have persisted across
> two different disks and two different SATA ports on the motherboard
> 
> system is running Ubuntu 10.04 Linux 2.6.32-47-generic #109-Ubuntu SMP
> Tue May 7 02:02:22 UTC 2013
> 
> at first, i was getting messages related to a Western Digital 300 GB
> drive that houses /boot and root file systems.  unfortunately i lost my
> dmesg from that time but i remember receiving a lot of "SError: {
> HostInt <one other SError too> }"  errors.  also things like "hard
> resetting link", "softreset failed (device not ready)", "applying SB600
> PMP SRST workaround and retrying", "SATA link up 3.0 Gbps (SStatus 123
> SControl 300)" were prominent in dmesg.  i noticed the SATA link would
> be dropped to 1.5 Gbps too.  eventually the system became unusable and
> unbootable, as well as filesystem corrupted.  fsck fixed it and system
> was up and running again.
> 
> smartctl for the drive showed good health (i believe)[1] so i moved the
> drive to another port on the motherboard (currently ata3.00 to libata).
>  so far libata has not produced any errors related to the drive but i
> just heard a knocking sound and this logged in dmesg[2].  ata4 has
> another disk drive, another port, and also different error messages.
> smtartctl for this drive also shows good health[3].
> 
> so since i have been having issues with two disks and two ports i am
> thinking it is something further up the cable?  like power or SATA cable
> issue, power supply issue, or motherboard issue... what say you? thanks

That hot red plastic die used to color MOST sata cables is a time bomb.  
That particular red die causes the copper in the cables to embrittle and 
connectivity goes away, like its some sort of acid.  Some cable makers are 
aware of that and silver plate the wire, so it lasts another year perhaps.  
I was first made aware of the connection between the color and the early 
failures back in the 70's while doing CB radio service, American coiled 
mike cables were subject to flex failures at the expected rates, but when 
the J.A.Pan company flooded the market with a more flexible cable, the red 
wire in those cables failure rate skyrocketed.

When it happened, one would normally try to strip back another 1/2" of wire 
& re-solder it, (I am a C.E.T. with nearly 65 years experience, so I know 
which end of a soldering iron gets hot) but the red wires copper conductor 
was very effectively destroyed, often literally falling out of the short 
tube of plastic you stripped off thinking that should leave the wire, ready 
to solder projecting out, but it wasn't there, and a sorta reddish oxidized 
copper powder could be teased out of the short piece stripped off.

I built this big tower when the AMD phenom's first came out, which gives 
you an idea how old this machine is, and I have now collected 7 of those 
red drive cables that if placed in the machine, will cause all sorts of 
hell to be raised in the dmesg output if touched by a finger.

So I started shopping for cables that weren't red, grabbing them when I 
came across them.  Right now there are three black ones, a yellow one and 2 
tan ones in this box and I've had zero trouble in about 2 years.

Ditch the hot red colored cables.  They are a time bomb that WILL go off, 
sooner rather than later.  If red ones are all your local Staples has, 
leave them hanging, go on-line, get phone numbers from candidate web sites 
and make sure the ones you order to replace that crap ARE NOT RED.  Stop 
the card charge if they are red when they hit your front porch.  I have 
done exactly that.

Cheers, Gene
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
My web page: <http://coyoteden.dyndns-free.com:85/gene> is up!
My views 
<http://www.armchairpatriot.com/What%20Has%20America%20Become.shtml>
If you don't have a nasty obituary you probably didn't matter.
		-- Freeman Dyson
A pen in the hand of this president is far more
dangerous than 200 million guns in the hands of
         law-abiding citizens.
