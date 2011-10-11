From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_scc: add proper cable detection method
Date: Tue, 11 Oct 2011 20:07:24 +0200
Message-ID: <201110112007.24530.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_scc: add proper cable detection method

Use standard ata_cable_80wire() method for the cable detection,
as a bonus this allows us to use the default ->prereset method.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
earlier references:
https://lkml.org/lkml/2009/11/25/373

 drivers/ata/pata_scc.c |   14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

Index: b/drivers/ata/pata_scc.c
===================================================================
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -827,18 +827,6 @@ static unsigned int scc_data_xfer (struc
 }
 
 /**
- *	scc_pata_prereset - prepare for reset
- *	@ap: ATA port to be reset
- *	@deadline: deadline jiffies for the operation
- */
-
-static int scc_pata_prereset(struct ata_link *link, unsigned long deadline)
-{
-	link->ap->cbl = ATA_CBL_PATA80;
-	return ata_sff_prereset(link, deadline);
-}
-
-/**
  *	scc_postreset - standard postreset callback
  *	@ap: the target ata_port
  *	@classes: classes of attached devices
@@ -947,7 +935,7 @@ static struct ata_port_operations scc_pa
 	.bmdma_status		= scc_bmdma_status,
 	.sff_data_xfer		= scc_data_xfer,
 
-	.prereset		= scc_pata_prereset,
+	.cable_detect		= ata_cable_80wire,
 	.softreset		= scc_softreset,
 	.postreset		= scc_postreset,
 
