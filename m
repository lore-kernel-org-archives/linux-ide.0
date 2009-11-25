From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 27/86] pata_cs5535: no need to program PIO0 timings during device init
Date: Wed, 25 Nov 2009 18:05:32 +0100
Message-ID: <20091125170532.5446.3009.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759293AbZKYRGW@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_cs5535: no need to program PIO0 timings during device init

Core libata code takes care of it nowadays.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_cs5535.c |   12 ------------
 1 file changed, 12 deletions(-)

Index: b/drivers/ata/pata_cs5535.c
===================================================================
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -67,8 +67,6 @@
 
 #define CS5535_CABLE_DETECT    0x48
 
-#define CS5535_BAD_PIO(timings) ( (timings&~0x80000000UL)==0x00009172 )
-
 /**
  *	cs5535_cable_detect	-	detect cable type
  *	@ap: Port to detect on
@@ -188,16 +186,6 @@ static int cs5535_init_one(struct pci_de
 	};
 	const struct ata_port_info *ppi[] = { &info, &ata_dummy_port_info };
 
-	u32 timings, dummy;
-
-	/* Check the BIOS set the initial timing clock. If not set the
-	   timings for PIO0 */
-	rdmsr(ATAC_CH0D0_PIO, timings, dummy);
-	if (CS5535_BAD_PIO(timings))
-		wrmsr(ATAC_CH0D0_PIO, 0xF7F4F7F4UL, 0);
-	rdmsr(ATAC_CH0D1_PIO, timings, dummy);
-	if (CS5535_BAD_PIO(timings))
-		wrmsr(ATAC_CH0D1_PIO, 0xF7F4F7F4UL, 0);
 	return ata_pci_sff_init_one(dev, ppi, &cs5535_sht, NULL);
 }
 
