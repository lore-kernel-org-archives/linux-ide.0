From: richard kennedy <richard@rsk.demon.co.uk>
Subject: Re: pata_via cd/dvd timeout problems
Date: Tue, 23 Oct 2007 10:24:07 +0100
Message-ID: <1193131447.3061.17.camel@castor.rsk.org>
References: <124748.3608.qm@web54408.mail.yahoo.com>
	 <1188982210.3075.9.camel@castor.rsk.org>
	 <20070906013347.1f588dc4@the-village.bc.nu>
	 <1190364785.3121.10.camel@castor.rsk.org>
	 <20070921162414.7ac2606a@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:4181 "EHLO
	anchor-post-30.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751462AbXJWJYM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Oct 2007 05:24:12 -0400
In-Reply-To: <20070921162414.7ac2606a@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Fri, 2007-09-21 at 16:24 +0100, Alan Cox wrote:
> On Fri, 21 Sep 2007 09:53:05 +0100
> richard kennedy <richard@rsk.demon.co.uk> wrote:
> 
> > On Thu, 2007-09-06 at 01:33 +0100, Alan Cox wrote:
> > 
> > > Probably. If you can file a bug in bugzilla and assign it to me I'll take
> > > a look at this after the kernel summit. There are one or two reports with
> > > pata_via and ATAPI (ie CD) that look similar.
> > 
> > Hi Alan,
> > your [PATCH] libata: Set transfer sizes properly for ATAPI fixes this
> > for me.
> 
> Yay - thanks for letting me know and for testing it.
> 
> Alan
Hi Alan,
I've just been testing the git head v2.6.23-6636-g557ebb7 and there's
still a problem with this.

if I don't mount a disk I start getting timeout messages approximately 1
hour after boot :-
...
Oct 22 15:08:31 castor kernel: pata_via 0000:00:0f.1: version 0.3.2
Oct 22 15:08:31 castor kernel: scsi2 : pata_via
Oct 22 15:08:31 castor kernel: scsi3 : pata_via
...
Oct 22 15:08:31 castor kernel: ata4.00: ATAPI: _NEC DVD_RW ND-3520A, 1.04, max UDMA/33
Oct 22 15:08:31 castor kernel: ata4.01: ATAPI: TSSTcorpDVD-ROM TS-H352A, TS03, max UDMA/33
Oct 22 15:08:32 castor kernel: ata4.00: configured for UDMA/33
Oct 22 15:08:32 castor kernel: ata4.01: configured for UDMA/33
...
Oct 22 15:59:10 castor kernel: ata4.01: qc timeout (cmd 0xa0)
Oct 22 15:59:10 castor kernel: ata4.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Oct 22 15:59:10 castor kernel: ata4.01: cmd a0/00:00:00:08:00/00:00:00:00:00/b0 tag 0 cdb 0x25 data 8 in
Oct 22 15:59:10 castor kernel:          res 51/20:03:00:00:00/00:00:00:00:00/b0 Emask 0x5 (timeout)
Oct 22 15:59:10 castor kernel: ata4.01: status: { DRDY ERR }
Oct 22 15:59:10 castor kernel: ata4: soft resetting link
Oct 22 15:59:11 castor kernel: ata4.00: configured for UDMA/33
Oct 22 15:59:11 castor kernel: ata4.01: configured for UDMA/33
Oct 22 15:59:11 castor kernel: ata4: EH complete

then repeats 

Oct 22 16:09:57 castor kernel: ata4.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Oct 22 16:09:57 castor kernel: ata4.01: cmd a0/00:00:00:00:00/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0 
Oct 22 16:09:57 castor kernel:          res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Oct 22 16:09:57 castor kernel: ata4.01: status: { DRDY }
Oct 22 16:09:57 castor kernel: ata4: soft resetting link
Oct 22 16:09:57 castor kernel: ata4.00: configured for UDMA/33
Oct 22 16:09:58 castor kernel: ata4.01: configured for UDMA/33
Oct 22 16:09:58 castor kernel: ata4: EH complete

and keeps on getting reset trying different speeds

Oct 22 17:37:57 castor kernel: ata4.00: limiting speed to PIO0
Oct 22 17:37:57 castor kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Oct 22 17:37:57 castor kernel: ata4.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
Oct 22 17:37:57 castor kernel:          res 40/00:03:00:00:00/00:00:00:00:00/b0 Emask 0x4 (timeout)
Oct 22 17:37:57 castor kernel: ata4.00: status: { DRDY }
Oct 22 17:37:57 castor kernel: ata4: soft resetting link
Oct 22 17:37:57 castor kernel: ata4.00: configured for PIO0
Oct 22 17:37:57 castor kernel: ata4.01: configured for UDMA/25
Oct 22 17:37:57 castor kernel: ata4: EH complete

On a fresh boot if I mount a cd access it then unmount it, the timeouts
start within about 5 minutes of the unmount

Oct 23 09:11:46 castor hald: unmounted /dev/scd0 from '/media/Disgo' on behalf of uid 500
Oct 23 09:16:52 castor kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Oct 23 09:16:52 castor kernel: ata4.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
Oct 23 09:16:52 castor kernel:          res 40/00:03:00:00:00/00:00:00:00:00/b0 Emask 0x4 (timeout)
Oct 23 09:16:52 castor kernel: ata4.00: status: { DRDY }
Oct 23 09:16:52 castor kernel: ata4: soft resetting link
Oct 23 09:16:53 castor kernel: ata4.00: configured for UDMA/33
Oct 23 09:16:53 castor kernel: ata4.01: configured for UDMA/33
Oct 23 09:16:53 castor kernel: ata4: EH complete
Oct 23 09:19:38 castor kernel: ata4.00: qc timeout (cmd 0xa0)
Oct 23 09:19:39 castor kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Oct 23 09:19:39 castor kernel: ata4.00: cmd a0/00:00:00:0c:00/00:00:00:00:00/a0 tag 0 cdb 0x43 data 12 in
Oct 23 09:19:39 castor kernel:          res 51/24:03:00:0c:00/00:00:00:00:00/a0 Emask 0x5 (timeout)
Oct 23 09:19:39 castor kernel: ata4.00: status: { DRDY ERR }
Oct 23 09:19:39 castor kernel: ata4: soft resetting link
Oct 23 09:19:39 castor kernel: ata4.00: configured for UDMA/33
Oct 23 09:19:39 castor kernel: ata4.01: configured for UDMA/33
Oct 23 09:19:39 castor kernel: ata4: EH complete
etc


Richard


