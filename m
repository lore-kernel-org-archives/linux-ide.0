From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/6] pdc202xx_old: remove no longer needed debugging code
Date: Thu, 03 Dec 2009 20:52:19 +0100
Message-ID: <20091203195219.9093.45804.sendpatchset@localhost>
References: <20091203195145.9093.88261.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756786AbZLCTxH@vger.kernel.org>
In-Reply-To: <20091203195145.9093.88261.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pdc202xx_old: remove no longer needed debugging code

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pdc202xx_old.c |   15 ---------------
 1 file changed, 15 deletions(-)

Index: b/drivers/ide/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pdc202xx_old.c
+++ b/drivers/ide/pdc202xx_old.c
@@ -21,8 +21,6 @@
 
 #define DRV_NAME "pdc202xx_old"
 
-#define PDC202XX_DEBUG_DRIVE_INFO	0
-
 static void pdc_old_disable_66MHz_clock(ide_hwif_t *);
 
 static void pdc202xx_set_mode(ide_drive_t *drive, const u8 speed)
@@ -34,11 +32,6 @@ static void pdc202xx_set_mode(ide_drive_
 	u8			AP = 0, BP = 0, CP = 0;
 	u8			TA = 0, TB = 0, TC = 0;
 
-#if PDC202XX_DEBUG_DRIVE_INFO
-	u32			drive_conf = 0;
-	pci_read_config_dword(dev, drive_pci, &drive_conf);
-#endif
-
 	/*
 	 * TODO: do this once per channel
 	 */
@@ -89,14 +82,6 @@ static void pdc202xx_set_mode(ide_drive_
 		pci_write_config_byte(dev, drive_pci + 1, BP | TB);
 		pci_write_config_byte(dev, drive_pci + 2, CP | TC);
 	}
-
-#if PDC202XX_DEBUG_DRIVE_INFO
-	printk(KERN_DEBUG "%s: %s drive%d 0x%08x ",
-		drive->name, ide_xfer_verbose(speed),
-		drive->dn, drive_conf);
-	pci_read_config_dword(dev, drive_pci, &drive_conf);
-	printk("0x%08x\n", drive_conf);
-#endif
 }
 
 static void pdc202xx_set_pio_mode(ide_drive_t *drive, const u8 pio)
