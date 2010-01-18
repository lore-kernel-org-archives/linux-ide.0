From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/64] pata_cmd64x: remove unused definitions
Date: Mon, 18 Jan 2010 18:15:18 +0100
Message-ID: <20100118171518.14623.13340.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754261Ab0ARRQr@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_cmd64x: remove unused definitions

s/ARTIM2/ARTTIM23/ in cmd648_bmdma_stop() while at it

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_cmd64x.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

Index: b/drivers/ata/pata_cmd64x.c
===================================================================
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -41,10 +41,6 @@
 enum {
 	CFR 		= 0x50,
 		CFR_INTR_CH0  = 0x04,
-	CNTRL 		= 0x51,
-		CNTRL_DIS_RA0 = 0x40,
-		CNTRL_DIS_RA1 = 0x80,
-		CNTRL_ENA_2ND = 0x08,
 	CMDTIM 		= 0x52,
 	ARTTIM0 	= 0x53,
 	DRWTIM0 	= 0x54,
@@ -54,9 +50,6 @@ enum {
 		ARTTIM23_DIS_RA2  = 0x04,
 		ARTTIM23_DIS_RA3  = 0x08,
 		ARTTIM23_INTR_CH1 = 0x10,
-	ARTTIM2 	= 0x57,
-	ARTTIM3 	= 0x57,
-	DRWTIM23	= 0x58,
 	DRWTIM2 	= 0x58,
 	BRST 		= 0x59,
 	DRWTIM3 	= 0x5b,
@@ -64,14 +57,11 @@ enum {
 	MRDMODE		= 0x71,
 		MRDMODE_INTR_CH0 = 0x04,
 		MRDMODE_INTR_CH1 = 0x08,
-		MRDMODE_BLK_CH0  = 0x10,
-		MRDMODE_BLK_CH1	 = 0x20,
 	BMIDESR0	= 0x72,
 	UDIDETCR0	= 0x73,
 	DTPR0		= 0x74,
 	BMIDECR1	= 0x78,
 	BMIDECSR	= 0x79,
-	BMIDESR1	= 0x7A,
 	UDIDETCR1	= 0x7B,
 	DTPR1		= 0x7C
 };
@@ -282,7 +272,7 @@ static void cmd648_bmdma_stop(struct ata
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 dma_intr;
 	int dma_mask = ap->port_no ? ARTTIM23_INTR_CH1 : CFR_INTR_CH0;
-	int dma_reg = ap->port_no ? ARTTIM2 : CFR;
+	int dma_reg = ap->port_no ? ARTTIM23 : CFR;
 
 	ata_bmdma_stop(qc);
 
