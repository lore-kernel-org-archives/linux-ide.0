From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/4] ide-pmac: media-bay support fixes
Date: Tue, 24 Jun 2008 20:55:11 +0200
Message-ID: <200806242055.12042.bzolnier@gmail.com>
References: <200806162124.43005.bzolnier@gmail.com> <1214303693.8011.345.camel@pasglop> <200806242051.22207.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:29127 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbYFXSxj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jun 2008 14:53:39 -0400
Received: by yx-out-2324.google.com with SMTP id 31so567238yxl.1
        for <linux-ide@vger.kernel.org>; Tue, 24 Jun 2008 11:53:38 -0700 (PDT)
In-Reply-To: <200806242051.22207.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 24 June 2008, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 24 June 2008, Benjamin Herrenschmidt wrote:
> > 
> > > Build error and/or your build fix would be useful here.
> > 
> > Sorry. Fix was a quick hack. There is a check_media_bay() followed by a
> > break; outside of a break-able construct in there (off memory, I'm not
> > in front of the dev box right now).
> 
> Thanks, 'take 3' follows.
> 
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide-pmac: media-bay support fixes (take 3)

[...]

and patch #2/4 required a trivial fix for a reject

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-pmac: add ->init_dev method (take 3)

v2/3:
* Build fixes from Stephen Rothwell.

There should be no functional changes caused by this patch.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ppc/pmac.c |   29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -941,7 +941,23 @@ static u8 pmac_ide_cable_detect(ide_hwif
 	return ATA_CBL_PATA40;
 }
 
+static void pmac_ide_init_dev(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	pmac_ide_hwif_t *pmif =
+		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
+
+	if (pmif->mediabay) {
+#ifdef CONFIG_PMAC_MEDIABAY
+		if (check_media_bay(pmif->node->parent, MB_CD) == -ENODEV)
+			return;
+#endif
+		drive->noprobe = 1;
+	}
+}
+
 static const struct ide_port_ops pmac_ide_ata6_port_ops = {
+	.init_dev		= pmac_ide_init_dev,
 	.set_pio_mode		= pmac_ide_set_pio_mode,
 	.set_dma_mode		= pmac_ide_set_dma_mode,
 	.selectproc		= pmac_ide_kauai_selectproc,
@@ -949,6 +965,7 @@ static const struct ide_port_ops pmac_id
 };
 
 static const struct ide_port_ops pmac_ide_ata4_port_ops = {
+	.init_dev		= pmac_ide_init_dev,
 	.set_pio_mode		= pmac_ide_set_pio_mode,
 	.set_dma_mode		= pmac_ide_set_dma_mode,
 	.selectproc		= pmac_ide_selectproc,
@@ -956,6 +973,7 @@ static const struct ide_port_ops pmac_id
 };
 
 static const struct ide_port_ops pmac_ide_port_ops = {
+	.init_dev		= pmac_ide_init_dev,
 	.set_pio_mode		= pmac_ide_set_pio_mode,
 	.set_dma_mode		= pmac_ide_set_dma_mode,
 	.selectproc		= pmac_ide_selectproc,
@@ -1065,17 +1083,6 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
 	       hwif->index, model_name[pmif->kind], pmif->aapl_bus_id,
 	       pmif->mediabay ? " (mediabay)" : "", hwif->irq);
 
-	if (pmif->mediabay) {
-#ifdef CONFIG_PMAC_MEDIABAY
-		if (check_media_bay(np->parent, MB_CD) != -ENODEV) {
-#else
-		if (1) {
-#endif
-			hwif->drives[0].noprobe = 1;
-			hwif->drives[1].noprobe = 1;
-		}
-	}
-
 	idx[0] = hwif->index;
 
 	ide_device_add(idx, &d);
