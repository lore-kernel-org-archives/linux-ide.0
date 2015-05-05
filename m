From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: imx6 sata cdrom driver issue
Date: Tue, 05 May 2015 12:48:09 +0200
Message-ID: <2901871.Bfl6KrJo7t@wuerfel>
References: <5539101D.1020909@lenbrook.com> <3757889.IHh7sEV0GH@wuerfel> <5547DEA7.8080009@lenbrook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:57993 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbbEEKsu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 May 2015 06:48:50 -0400
In-Reply-To: <5547DEA7.8080009@lenbrook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jonathan Bagg <jbagg@lenbrook.com>, linux-ide@vger.kernel.org

On Monday 04 May 2015 17:03:35 Jonathan Bagg wrote:
> On 15-05-04 02:37 PM, Arnd Bergmann wrote:
> > On Friday 01 May 2015 11:32:49 Jonathan Bagg wrote:
> >> On 15-04-24 03:58 AM, Arnd Bergmann wrote:
> >>> On Thursday 23 April 2015 11:30:37 Jonathan Bagg wrote:
> >>>
> >>> Do you have two SATA ports on one controller, with the other one being
> >>> conneced to a disk drive?
> >> Not when this error happened, but the CD-ROM was connected through a
> >> port multiplier.  One time I noticed sda device appear so I mounted it
> >> and it was the CD-ROM filesystem!
> > Very strange, I'm sure something went wrong there and either the SATA
> > host or the CDROM driver does not work well with a port multiplier.
> >
> > Is there a way for you to reproduce the problem without the multiplier?
> >
> >>> My best guess is that something in the error handling of
> >>> drivers/ata/ahci_imx.c causes a reset of the entire bus and that
> >>> triggers the other bugs. Can you instrument that error handling to
> >>> see what's going on?
> >>>
> >> Also tried a cubox
> >> <https://www.solid-run.com/products/cubox-i-mini-computer/>, (imx6)
> >> running  Linux OpenELEC 3.14.18 #1 SMP Sun Sep 14 12:22:14 EDT 2014
> >> armv7l GNU/Linux
> > Can you find out if there is a port multiplier in that machine?
> I've tried with and without a multiplier.  I have a port multiplier on a 
> development board that I can connect between the CDROM and Sabre SATA 
> port or connect the CDROM directly to the Sabre SATA port .
> > Does it list the sda device in /proc/partitions, or just the /dev/sr0?
> sda is only listed in /proc/partitions if I connect up a HDD.  The issue 
> where the CDROM filesystem mounting as sda1 has never reproduced.
> 
> I've also discovered, and it is 100% reproducible, that with the HDD and 
> CDROM connected using the port multiplier, the kernel never lists the 
> partition on the HDD.  If I connect the HDD directly to the Sabre or 
> connect the HDD to the Sabre using the multiplier without the CDROM, 
> /dev/sda1 will exist.

Ok, interesting. Does the same happen if you connect that port
multiplier to a PC?

> >> Most of the time mount /dev/sr0 /tmp/test succeeds with....
> >>
> >> [  954.355669] ISO 9660 Extensions: Microsoft Joliet Level 3
> >> [  954.530595] ISOFS: changing to secondary root
> >>
> >> one time once it succeed but needed to reset the link....
> >>
> >> [ 1272.000951] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
> >> frozen
> >> [ 1272.000969] ata1.00: failed command: IDENTIFY PACKET DEVICE
> >> [ 1272.000993] ata1.00: cmd a1/00:01:00:00:00/00:00:00:00:00/00 tag 2
> >> pio 512 in
> >> [ 1272.000993]          res 40/00:03:00:16:00/00:00:00:00:00/a0 Emask
> >> 0x4 (timeout)
> >> [ 1272.001004] ata1.00: status: { DRDY }
> >> [ 1272.001021] ata1: hard resetting link
> >> [ 1272.487628] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >> [ 1272.495523] ata1.00: configured for UDMA/100
> >> [ 1272.500917] ata1: EH complete
> >> [ 1290.746222] ISO 9660 Extensions: Microsoft Joliet Level 3
> >>
> >> rarely if fails with this....
> >>
> >> [  724.697232] ISO 9660 Extensions: Microsoft Joliet Level 3
> >> [  724.827435] ISOFS: changing to secondary root
> >> [  724.910232] isofs_fill_super: root inode is not a directory.
> >> Corrupted media?
> >> [  725.133516] UDF-fs: warning (device sr0): udf_fill_super: No
> >> partition found (2)
> >> [  725.351106] F2FS-fs (sr0): Magic Mismatch, valid(0xf2f52010) - read(0x0)
> >> [  725.351132] F2FS-fs (sr0): Can't find valid F2FS filesystem in 1th
> >> superblock
> >> [  725.352029] F2FS-fs (sr0): Magic Mismatch, valid(0xf2f52010) - read(0x0)
> >> [  725.352052] F2FS-fs (sr0): Can't find valid F2FS filesystem in 2th
> >> superblock
> >>
> >>
> >> Specifying read only (mount -o ro /dev/sr0 /tmp/test) has worked 100% of
> >> the time on both the cubox and sabre boards.
> > Interesting. That would indicate that something actually tries to write
> > to the device on normal mount.  Can you try if
> >
> > mount -t iso9660 /dev/sr0 /tmp/test
> >
> > avoids that problem as well? That file system should never attempt to write
> > to the device, so if it's the failed write that causes the host reset,
> > that should solve it too.
> With the CDROM connected directly to the imx6 Sabre board (no 
> multiplier), very rarely (~1 in 40) I would get...
> 
> mount -t iso9660 /dev/sr0 /tmp/test
> mount: mounting /dev/sr0 on /tmp/test failed: Invalid argument

Maybe there is just some hardware instability here? If you get occasional
bit flips in your setup (maybe not enough power for the multiplier, bad
connectors, or too long cables), that can probably explain all of the above.

If you run 'md5sum /dev/sr0' multiple times (remove the driver or the disk
between the runs), do you sometimes get different results?

	Arnd
