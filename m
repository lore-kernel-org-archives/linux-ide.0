From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/4] ide-pmac: add ->init_dev method (take 2)
Date: Tue, 17 Jun 2008 22:43:31 +0200
Message-ID: <200806172243.32854.bzolnier@gmail.com>
References: <200806162124.48029.bzolnier@gmail.com> <20080617104546.3b4535c9.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:5053 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755071AbYFQUpA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jun 2008 16:45:00 -0400
Received: by an-out-0708.google.com with SMTP id d40so1353373and.103
        for <linux-ide@vger.kernel.org>; Tue, 17 Jun 2008 13:44:59 -0700 (PDT)
In-Reply-To: <20080617104546.3b4535c9.sfr@canb.auug.org.au>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Tuesday 17 June 2008, Stephen Rothwell wrote:
> Hi Bart,
> 
> On Mon, 16 Jun 2008 21:24:47 +0200 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> >
> > +static void pmac_ide_init_dev(ide_drive_t *drive)
> > +{
> > +	ide_hwif_t *hwif = drive->hwif;
> > +	pmac_ide_hwif_t *pmif =
> > +		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
> > +
> > +	if (pmif->mediabay) {
> > +#ifdef CONFIG_PMAC_MEDIABAY
> > +		if (check_media_bay(np->parent, MB_CD) == -ENODEV)
>                                     ^^
> "np" doesn't exist here.

uh, it should be pmif->node there... take 3...

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-pmac: add ->init_dev method (take 3)

v2/3:
* Build fixes from Stephen Rothwell.

There should be no functional changes caused by this patch.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ppc/pmac.c |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

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
@@ -1065,15 +1083,6 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
 	       hwif->index, model_name[pmif->kind], pmif->aapl_bus_id,
 	       pmif->mediabay ? " (mediabay)" : "", hwif->irq);
 
-	if (pmif->mediabay) {
-#ifdef CONFIG_PMAC_MEDIABAY
-		if (check_media_bay(np->parent, MB_CD) == -ENODEV)
-			break;
-#endif
-		hwif->drives[0].noprobe = 1;
-		hwif->drives[1].noprobe = 1;
-	}
-
 	idx[0] = hwif->index;
 
 	ide_device_add(idx, &d);
