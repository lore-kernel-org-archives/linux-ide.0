From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: SiS 180 pata
Date: Wed, 7 Jul 2004 12:02:55 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200407071202.55091.bzolnier@elka.pw.edu.pl>
References: <200407051253.47003.ivololeribar@yahoo.it> <40EB8BED.4070002@pobox.com> <200407071154.48626.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:44161 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265029AbUGGJ5Z
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Jul 2004 05:57:25 -0400
In-Reply-To: <200407071154.48626.bzolnier@elka.pw.edu.pl>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Nicola <ivololeribar@yahoo.it>
Cc: Uwe Koziolek <uwe.koziolek@gmx.net>, linux-ide@vger.kernel.org

On Wednesday 07 of July 2004 11:54, Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 07 of July 2004 07:36, Jeff Garzik wrote:
> > Nicola wrote:
> > > 00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
> > > (prog-if 80 [Master]) Subsystem: Silicon Integrated Systems [SiS]
> > > SiS5513 EIDE Controller (A,B step) Control: I/O+ Mem- BusMaster+
> > > SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- Status:
> > > Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
> > > <MAbort- >SERR- <PERR-
> > >
> > > 00:0c.0 RAID bus controller: Silicon Integrated Systems [SiS]: Unknown
> > > device 0180 (prog-if 85) Subsystem: Silicon Integrated Systems [SiS]:
> > > Unknown device 0180 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
> > > VGASnoop- ParErr- Stepping- SERR- FastB2B- Status: Cap- 66Mhz+ UDF-
> > > FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >
> > It certainly looks like IDE and SATA devices are separate to me?
>
> there are 4 IDE ports on this motherboard...

eh, 3 not 4 - 2 from SiS5513 and 1 from SiS180
(http://www.jetway.com.tw/evisn/product/amd/S755MAX/S755MAX.jpg)

