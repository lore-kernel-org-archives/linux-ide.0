From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [RFC][PATCH] 2.4 IDE Serverworks OSB4 DMA patch
Date: Fri, 30 Apr 2004 00:37:10 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404300037.10054.bzolnier@elka.pw.edu.pl>
References: <Pine.LNX.4.58.0404291130420.19527@bern.wildisoft.net> <200404292132.26039.bzolnier@elka.pw.edu.pl> <Pine.LNX.4.58.0404291455480.13881@bern.wildisoft.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:28655 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265012AbUD2Wgx
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Apr 2004 18:36:53 -0400
In-Reply-To: <Pine.LNX.4.58.0404291455480.13881@bern.wildisoft.net>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Patrick Wildi <patrick@wildi.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, andre@linux-ide.org

On Friday 30 of April 2004 00:09, Patrick Wildi wrote:
> On Thu, 29 Apr 2004, Bartlomiej Zolnierkiewicz wrote:
> > On Thursday 29 of April 2004 21:04, Patrick Wildi wrote:
> > > I have been using a OSB4 chipset based system with a CompactFlash
> > > that supports PIO only and a laptop IBM/Hitachi Travelstar HDD
> > > that supports UDMA.
> > > For both drives, the serverworks code misconfigures the drives:
> > >
> > > - for the CF (hooked up as /dev/hda), svwks_config_drive_xfer_rate()
> > >   will not match any tests (drive->autodma = 0, id->capability = 2,
> > >   id->field_valid = 1), but the function will then call
> > >   hwif->ide_dma_on(drive), which it should not do for this drive.
> > >   This patch moves the enabling of DMA up into the DMA section of
> > >   the code.
> >
> > Yep, known bug, it is fixed in 2.6.
> >
> > It is present in many other drivers, my 2.6 patch needs to be backported.
>
> Are you the maintainer for 2.4 or to whom should I send the changes?

Send them to me.

> > > - for the Travelstart HDD, the settings coming into
> > >   svwks_config_drive_xfer_rate() are: drive->autodma = 32,
> > >   id->capability = 15, id->field_valid = 7, id->dma_ultra = 0x43f.
> > >   But as this is an OSB4, the hwif->ultra_mask is set to not support
> > >   UDMA. Unfortunately in that case svwks_config_drive_xfer_rate()
> > >   falls through to the end of the function, instead of trying
> > >   other DMA modes.
> >
> > Good catch.
> >
> > It seems the same bug can be present in other drivers too (hint, hint).
> > ;)
>
> I noticed that the piix driver uses the exact same logic. I could
> replicate this part of the patch for other 2.4 drivers. I have no
> way of testing them.
> I can send you a combined patch for 2.4. I am not yet using 2.6.

No problem. :)

Thanks!
Bartlomiej

