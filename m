From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Promise PDC20269 - PIO Only?
Date: Tue, 21 Oct 2003 23:28:36 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200310212328.36751.bzolnier@elka.pw.edu.pl>
References: <200310181819.08930.jeremyhu@uclink4.berkeley.edu> <200310211627.08401.bzolnier@elka.pw.edu.pl> <1066769751.4506.12.camel@eradicator.outersquare.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:18679 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263329AbTJUVYQ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Oct 2003 17:24:16 -0400
In-Reply-To: <1066769751.4506.12.camel@eradicator.outersquare.org>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeremy Huddleston <jeremy@outersquare.org>
Cc: linux-ide@vger.kernel.org

On Tuesday 21 of October 2003 22:55, Jeremy Huddleston wrote:
> Hmm... I still think there's a bug here because similarly, the bios for
> my PDC2067 (FastTrak 100) says my drives are operating in UDMA Mode 5.
> To see this, I press ctr-f to enter the fasttrak configuration utility
> and goto the drive info page...

I think that BIOS says that they are UDMA5 _capable_.

> But when linux starts, it shows:
> Oct 21 13:41:07 terminator PDC20267: IDE controller at PCI slot 01:0a.0
> Oct 21 13:41:07 terminator PDC20267: chipset revision 2
> Oct 21 13:41:07 terminator PDC20267: not 100% native mode: will probe
> irqs later
> Oct 21 13:41:07 terminator PDC20267: (U)DMA Burst Bit ENABLED Primary
> MASTER Mode Secondary MASTER Mode.
> Oct 21 13:41:07 terminator ide2: BM-DMA at 0xd800-0xd807, BIOS settings:
> hde:pio, hdf:pio
> Oct 21 13:41:07 terminator ide3: BM-DMA at 0xd808-0xd80f, BIOS settings:
> hdg:pio, hdh:pio
> ...
> Oct 21 13:41:07 terminator hde: attached ide-disk driver.
> Oct 21 13:41:07 terminator hde: host protected area => 1
> Oct 21 13:41:07 terminator hde: 195371568 sectors (100030 MB) w/2048KiB
> Cache, CHS=193821/16/63, UDMA(100)
> Oct 21 13:41:07 terminator hdg: attached ide-disk driver.
> Oct 21 13:41:07 terminator hdg: host protected area => 1
> Oct 21 13:41:07 terminator hdg: 195371568 sectors (100030 MB) w/2048KiB
> Cache, CHS=193821/16/63, UDMA(100)
>
> Which do I believe?  Promise's BIOS setup utility is reporting UDMA5,
> but linux says BIOS is reporting PIO... How are the linux drivers
> determining that it is operating in pio mode?  It is actually fairly

Look at ide_setup_dma() in drivers/ide/ide-dma.c.

> important to me that my drives start in UDMA5 mode rather than waiting
> for hdparm to run in my init scripts because of raid (linux md)
> reconstruction and filesystem checking that happens after a crash or
> power failure...

You don't wait for hdparm, IDE driver _enables_ DMA _before_ RAID is mounted
and _before_ user-space applications (such as hdparm) can be executed.

"hdg: 195371568 sectors (100030 MB) w/2048KiB Cache, CHS=193821/16/63,
UDMA(100)"
^^^^^^^^^

--bartlomiej

> On Tue, 2003-10-21 at 07:27, Bartlomiej Zolnierkiewicz wrote:
> > DMA is enabled correctly on all drives by Linux IDE driver,
> > (please note that BIOS leaved them in PIO).
> >
> > --bartlomiej
> >
> > > Oct 20 18:32:04 eradicator hde: attached ide-disk driver.
> > > Oct 20 18:32:04 eradicator hde: host protected area => 1
> > > Oct 20 18:32:04 eradicator hde: 240121728 sectors (122942 MB) w/7936KiB
> > > Cache, CHS=238216/16/63, UDMA(133)
> > > Oct 20 18:32:04 eradicator hdg: attached ide-disk driver.
> > > Oct 20 18:32:04 eradicator hdg: host protected area => 1
> > > Oct 20 18:32:04 eradicator hdg: 240121728 sectors (122942 MB) w/7936KiB
> > > Cache, CHS=238216/16/63, UDMA(133)
> > > Oct 20 18:32:04 eradicator hdh: attached ide-disk driver.
> > > Oct 20 18:32:04 eradicator hdh: host protected area => 1
> > > Oct 20 18:32:04 eradicator hdh: 240121728 sectors (122942 MB) w/2048KiB
> > > Cache, CHS=14946/255/63, UDMA(133)
> > > Oct 20 18:32:04 eradicator hdi: attached ide-disk driver.
> > > Oct 20 18:32:04 eradicator hdi: host protected area => 1
> > > Oct 20 18:32:04 eradicator hdi: 320173056 sectors (163929 MB) w/7936KiB
> > > Cache, CHS=19929/255/63, UDMA(133)
> > > Oct 20 18:32:04 eradicator hdk: attached ide-disk driver.
> > > Oct 20 18:32:04 eradicator hdk: host protected area => 1
> > > Oct 20 18:32:04 eradicator hdk: 320173056 sectors (163929 MB) w/7936KiB
> > > Cache, CHS=19929/255/63, UDMA(133)

