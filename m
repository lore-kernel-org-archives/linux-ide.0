From: Kanniball <kanniball@zmail.pt>
Subject: Re: Silicon Image 3114 and Seagate disks
Date: Fri, 22 Jul 2005 15:00:26 +0100
Message-ID: <200507221500.26152.kanniball@zmail.pt>
References: <EXCHG2003pDS7hx27kB00000473@EXCHG2003.microtech-ks.com>
Reply-To: kanniball@zmail.pt
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.92.212.1] ([81.92.212.1]:27154 "EHLO zmail.pt")
	by vger.kernel.org with ESMTP id S262087AbVGVN74 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Jul 2005 09:59:56 -0400
Received: from 80.172.45.45
	by zmail.pt
	(MDaemon.PRO.v6.8.4.R)
	with ESMTP id 29-md50000000001.tmp
	for <linux-ide@vger.kernel.org>; Fri, 22 Jul 2005 14:57:59 +0100
In-Reply-To: <EXCHG2003pDS7hx27kB00000473@EXCHG2003.microtech-ks.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I've debated this issue before here.
Althoug I've found no solution, I would like to try removing my seagate drive 
and make some tests, but I only have that drive, and I can't afford one now.
I've tried the patch from Tejun Heo and one patch from Silicon Image:
[http://marc.theaimsgroup.com/?l=linux-kernel&m=111173514717575&w=2]
[http://marc.theaimsgroup.com/?l=linux-ide&m=111260146423451&w=2]

and get better read performance, although I don't see any improvment in the 
write performance (I think Tejun said that).
You can try those patches and test them. I'm not sure, but I think the one 
from Silicon Image has been integrated in the latest kernel release.

When I can afford a new disk I will make some tests and then go to the store 
and claim for a new drive (even if I had to make some trick to get the drive 
faulty, while I have warranty).

By the way my controller is a Sil3112.

Regards,
Paulo Fidalgo

On Friday 22 July 2005 14:42, Roger Heflin wrote:
> Hi Steve,
>
> I saw the same thing with a tyan mb and a different Seagate disk,
> removing from the blacklist sped things up a lot, and fixed some
> bad kernel response issues (bad response was only with SMP,
> not with single cpu).     I send an email about it several
> weeks ago to this list detailing what I found.
>
>                     Roger
>
> > -----Original Message-----
> > From: linux-ide-owner@vger.kernel.org
> > [mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Steve Sutphen
> > Sent: Friday, July 22, 2005 6:55 AM
> > To: Jeff Garzik
> > Cc: linux-ide@vger.kernel.org
> > Subject: Silicon Image 3114 and Seagate disks
> >
> >
> > I have a system with a Tyan S2882 mother board that has a
> > Silicon Image
> > Si3114 SATA controller that I would like to use one of the
> > "blacklisted"
> > Seagate drives on.  As has been discussed in this mailing
> > list, when one uses the current driver performance is poor on
> > this combination (I see around 14MB/s using hdparm's buffered
> > read test--Bonnie++ confirms that).
> >
> > I was hunting around to see if there might be a better
> > driver, and came across this note in the Release notes for the:
> >
> > SiI SATARaid Linux device driver ver 1.0.0.20 Release
> >
> > Both the Tyan support download driver and the one from
> > SiliconImage have the following "Limitation" listed:
> >
> > 3. Mod15Write fix for Seagate Drives (for chip-set versions
> > 3112 1.21 or older)
> >
> > It seems that this driver may treat the 3114 and the 3112 the
> > same way, and that at least in the 3112 code the Seagate
> > problem may not exist on newer versions of the SI chip.
> > Lspci thinks that I have a Rev.2 chip/firmware:
> > 04:05.0 Unknown mass storage controller: Silicon Image, Inc.
> > SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)
> >
> > The SI firmware version that my SI chip is running is 5.0.48.
> >
> > My question is--is it possible that my ST3120026AS Seagate
> > drive might work without the "blacklisting"?  Should I try
> > it?  If so, what is a good test--will it lock up, or corrupt data?
> >
> > If not with the current driver, then is there a new driver
> > that is coming down the pipe that will fix this in the
> > reasonably near term?
> >
> > Thank you,
> > 	steve@cs.ualberta.ca
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-ide" in the body of a message to
> > majordomo@vger.kernel.org More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

