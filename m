From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 7/8] ide: add struct ide_port_info instances to legacy host drivers
Date: Mon, 11 Feb 2008 00:16:07 +0100
Message-ID: <200802110016.08078.bzolnier@gmail.com>
References: <20080106170220.6861.4814.sendpatchset@localhost.localdomain> <20080211.010729.115910395.anemo@mba.ocn.ne.jp> <200802101804.49154.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:38697 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbYBJXQy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Feb 2008 18:16:54 -0500
Received: by fk-out-0910.google.com with SMTP id z23so4264011fkz.5
        for <linux-ide@vger.kernel.org>; Sun, 10 Feb 2008 15:16:50 -0800 (PST)
In-Reply-To: <200802101804.49154.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 10 February 2008, Bartlomiej Zolnierkiewicz wrote:
> On Sunday 10 February 2008, Atsushi Nemoto wrote:
> > On Sun, 06 Jan 2008 18:03:10 +0100, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > +	/* reset DMA masks only for SFF-style DMA controllers */
> > > +	if ((d->host_flags && IDE_HFLAG_NO_DMA) == 0 && hwif->dma_base == 0)
> > > +		hwif->swdma_mask = hwif->mwdma_mask = hwif->ultra_mask = 0;
> > 
> > It might be too late, but "host_flags && IDE_HFLAGS_NO_DMA" seems
> > wrong for me.
> 
> It is too late for -git but not too late for 2.6.25-rc1. ;-)
> 
> Could you make a patch please?

I went ahead and made a patch (sorry, I needed it for git pull request :).

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: ide_init_port() bugfix

On Sunday 10 February 2008, Atsushi Nemoto wrote:
> On Sun, 06 Jan 2008 18:03:10 +0100, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > +	/* reset DMA masks only for SFF-style DMA controllers */
> > +	if ((d->host_flags && IDE_HFLAG_NO_DMA) == 0 && hwif->dma_base == 0)
> > +		hwif->swdma_mask = hwif->mwdma_mask = hwif->ultra_mask = 0;
> 
> It might be too late, but "host_flags && IDE_HFLAGS_NO_DMA" seems
> wrong for me.

Fix regression caused by commmit c413b9b94d9a8e7548cc4b2e04b7df0439ce76fd
("ide: add struct ide_port_info instances to legacy host drivers").

Reported-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1355,7 +1355,7 @@ static void ide_init_port(ide_hwif_t *hw
 	hwif->ultra_mask = d->udma_mask;
 
 	/* reset DMA masks only for SFF-style DMA controllers */
-	if ((d->host_flags && IDE_HFLAG_NO_DMA) == 0 && hwif->dma_base == 0)
+	if ((d->host_flags & IDE_HFLAG_NO_DMA) == 0 && hwif->dma_base == 0)
 		hwif->swdma_mask = hwif->mwdma_mask = hwif->ultra_mask = 0;
 
 	if (d->host_flags & IDE_HFLAG_RQSIZE_256)

