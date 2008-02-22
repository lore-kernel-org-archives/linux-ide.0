From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: remove stale comments from ide-dma.c
Date: Fri, 22 Feb 2008 23:54:11 +0100
Message-ID: <200802222354.11953.bzolnier@gmail.com>
References: <200802222224.53642.bzolnier@gmail.com> <47BF4043.8080802@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:40288 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754773AbYBVWll (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Feb 2008 17:41:41 -0500
Received: by ug-out-1314.google.com with SMTP id z38so7518ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 22 Feb 2008 14:41:40 -0800 (PST)
In-Reply-To: <47BF4043.8080802@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 22 February 2008, Mark Lord wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > - ide-dma.c is not a separate module
> > 
> > - ide-dma.c is not PCI specific anymore
> > 
> > - DMA is enabled by default nowadays
> > 
> > - link for Intel Zappa BIOS is dead
> > 
> > etc.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> >  drivers/ide/ide-dma.c |   48 ------------------------------------------------
> >  1 file changed, 48 deletions(-)
> > 
> > Index: b/drivers/ide/ide-dma.c
> > ===================================================================
> > --- a/drivers/ide/ide-dma.c
> > +++ b/drivers/ide/ide-dma.c
> > @@ -11,49 +11,6 @@
> >   */
> >  
> >  /*
> > - * This module provides support for the bus-master IDE DMA functions
> > - * of various PCI chipsets, including the Intel PIIX (i82371FB for
> > - * the 430 FX chipset), the PIIX3 (i82371SB for the 430 HX/VX and 
> > - * 440 chipsets), and the PIIX4 (i82371AB for the 430 TX chipset)
> > - * ("PIIX" stands for "PCI ISA IDE Xcellerator").
> > - *
> > - * Pretty much the same code works for other IDE PCI bus-mastering chipsets.
> > - *
> > - * DMA is supported for all IDE devices (disk drives, cdroms, tapes, floppies).
> ..
> 
> Those top comments still look relevant, or at least as relevant
> as the rest of the file (and subsystem) itself.  :)
> 
> Sigh.

ide-dma.c supports _much_ more than IDE PCI BM-DMA nowadays :)

[ hmm, it probably makes sense to split CONFIG_BLK_DEV_IDEDMA_SFF code
  to a separate file (ide-dma-sff.c?) so ide-dma.c would contain only
  generic code ]

anyway here goes "take 2":

[...]
v2:
* Some comments should be preserved. (Noticed by Mark Lord)

Cc: Mark Lord <liml@rtr.ca>
[...]

interdiff:

diff -u b/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- b/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -1,9 +1,13 @@
 /*
+ *  IDE DMA support (including IDE PCI BM-DMA).
+ *
  *  Copyright (C) 1995-1998   Mark Lord
  *  Copyright (C) 1999-2000   Andre Hedrick <andre@linux-ide.org>
  *  Copyright (C) 2004, 2007  Bartlomiej Zolnierkiewicz
  *
  *  May be copied or modified under the terms of the GNU General Public License
+ *
+ *  DMA is supported for all IDE devices (disk drives, cdroms, tapes, floppies).
  */
 
 /*
