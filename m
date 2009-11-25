From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 70/86] pata_scc: add proper cable detection method
Date: Wed, 25 Nov 2009 18:10:46 +0100
Message-ID: <20091125171046.5446.49179.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934727AbZKYRLg@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_scc: add proper cable detection method

Use standard ata_cable_80wire() method for the cable detection,
as a bonus this allows us to use the default ->prereset method.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_scc.c |   14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

Index: b/drivers/ata/pata_scc.c
===================================================================
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -865,18 +865,6 @@ static void scc_freeze (struct ata_port
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
@@ -986,7 +974,7 @@ static struct ata_port_operations scc_pa
 	.sff_data_xfer		= scc_data_xfer,
 
 	.freeze			= scc_freeze,
-	.prereset		= scc_pata_prereset,
+	.cable_detect		= ata_cable_80wire,
 	.softreset		= scc_softreset,
 	.postreset		= scc_postreset,
 	.post_internal_cmd	= scc_bmdma_stop,
