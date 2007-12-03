From: Hein-Pieter van Braam <hp@syntomax.com>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Mon, 03 Dec 2007 21:11:01 +0100
Message-ID: <1196712661.6362.5.camel@liza>
References: <4751A2DA.6030403@rtr.ca>
	 <BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com>
	 <20071203154749.6lah7pulw8ow0s84@email.syntomax.com>
	 <47543C58.4040106@rtr.ca> <475447A0.2010101@rtr.ca>
	 <47544B3C.2010901@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a80-126-0-120.adsl.xs4all.nl ([80.126.0.120]:42478 "EHLO
	ifolder.erca.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbXLCUSI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2007 15:18:08 -0500
In-Reply-To: <47544B3C.2010901@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: "Morrison, Tom" <tmorrison@empirix.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

On Mon, 2007-12-03 at 13:30 -0500, Mark Lord wrote:
> Mark Lord wrote:
> ...
> 
> > Okay, I've attempted to boot from the RocketRAID 2300 card
> > using a known-good boot hard disk.
> > 
> > No such luck.
> > 
> > The BIOS on the Highpoint RR 2300 *corrupts* the GRUB image,
> > so GRUB won't boot for me there.  I actually have to re-install
> > GRUB after each attempt so that the drive is usable again
> > with the onboard Intel (ahci) ports.
> > 
> > So one then wonders exactly what the Highpoint BIOS is overwriting,
> > and how that might affect your particular configuration..
> > 
> > ???
> > 
> > I'll try booting from another (non-Highpoint) 7042 board next.
> > After I repair GRUB again, that is.
> ...
> 
> No joy.  My other 7042 and 6042 cards do not have bootable BIOSs.
> 
> So to boot from a 7042 the only theoretical choice is the Highpoint board,
> and for that we need to somehow coax it into not overwriting GRUB
> every time the onboard BIOS reinitializes.
> 
> Tricky to arrange, that.
> 
> How are you doing it ?

Personally, I put all the disks in JBOD mode, but I never had these
disks connected to anything but my highpoint cards. Perhaps I should
tell you what my setup's like:

* In the system I've put 3 Highpoint RocketRaid 2300 cards.
* Two of the cards each have 4 Hitachi 750GB disks
* Each disk is put into JBOD mode in the 'Raid' Bios of the 2300
* On the drives I have 2 partitions, one 200MB partition and a partition
spanning the rest of the 750GB
* Both partitions are linux softraid
* /dev/md0 is a mirror of all 8 disks and serves as /boot (200MB)
* /dev/md1 contains an LVM volume that houses my other paritions (4.7TB)

Right now with 2.6.23.9 + patched sata_mv the softraid seems to come up
just fine but I pvscan is unable to locate the pv located on md1.

I'll try and make a bootable USB stick with my patched 2.6.23.9 and see
what the results are then.



-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.

