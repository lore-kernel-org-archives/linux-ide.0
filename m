From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 00:32:22 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200403280032.22180.bzolnier@elka.pw.edu.pl>
References: <4066021A.20308@pobox.com> <40660877.3090302@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:51624 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261967AbUC0XXQ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Mar 2004 18:23:16 -0500
In-Reply-To: <40660877.3090302@stesmi.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Stefan Smietanowski <stesmi@stesmi.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Sunday 28 of March 2004 00:04, Stefan Smietanowski wrote:
> Hi Jeff.
>
> > The "lba48" feature in ATA allows for addressing of sectors > 137GB, and
> > also allows for transfers of up to 64K sector, instead of the
> > traditional 256 sectors in older ATA.
> >
> > libata simply limited all transfers to a 200 sectors (just under the 256
> > sector limit).  This was mainly being careful, and making sure I had a
> > solution that worked everywhere.  I also wanted to see how the iommu S/G
> > stuff would shake out.
> >
> > Things seem to be looking pretty good, so it's now time to turn on
> > lba48-sized transfers.  Most SATA disks will be lba48 anyway, even the
> > ones smaller than 137GB, for this and other reasons.
> >
> > With this simple patch, the max request size goes from 128K to 32MB...
> > so you can imagine this will definitely help performance.  Throughput
> > goes up.  Interrupts go down.  Fun for the whole family.

What about latency?

What about recently discussed PRD table "limit" of 256 entries?

AFAIR these are the reasons why IDE driver is currently
limiting max request size to 1024K on LBA48 disks.

> What will happen when a PATA disk lies behind a Marvel(ous) bridge, as
> in most SATA disks today?

Most modern PATA disks support LBA48 and IDE driver has been using
large transfers for some time. :-)

> Is large transfers mandatory in the LBA48 spec and is LBA48 really
> mandatory in SATA?

large transfers are part of LBA48 spec

> And yes, I saw that the dmesg showed a Maxtor drive, but I'm uncertain
> if that disk of yours has a Marvel chip on or not, since newer Maxtors
> might (have) come out (already) without a Marvel chip, I just don't
> know.

Regards,
Bartlomiej

