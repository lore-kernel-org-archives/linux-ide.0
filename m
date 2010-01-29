From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 27/68] slc90e66: always program control bits
Date: Fri, 29 Jan 2010 17:06:03 +0100
Message-ID: <20100129160603.21495.85374.sendpatchset@localhost>
References: <20100129160308.21495.14120.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752304Ab0A2QSG@vger.kernel.org>
In-Reply-To: <20100129160308.21495.14120.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] slc90e66: always program control bits

This matches behavior of libata pata_efar host driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/slc90e66.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

Index: b/drivers/ide/slc90e66.c
===================================================================
--- a/drivers/ide/slc90e66.c
+++ b/drivers/ide/slc90e66.c
@@ -50,20 +50,16 @@ static void slc90e66_set_pio_mode(ide_hw
 	if (is_slave) {
 		master_data |=  0x4000;
 		master_data &= ~0x0070;
-		if (pio > 1) {
-			/* Set PPE, IE and TIME */
-			master_data |= control << 4;
-		}
+		/* Set PPE, IE and TIME */
+		master_data |= control << 4;
 		pci_read_config_byte(dev, slave_port, &slave_data);
 		slave_data &= hwif->channel ? 0x0f : 0xf0;
 		slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) <<
 			       (hwif->channel ? 4 : 0);
 	} else {
 		master_data &= ~0x3307;
-		if (pio > 1) {
-			/* enable PPE, IE and TIME */
-			master_data |= control;
-		}
+		/* enable PPE, IE and TIME */
+		master_data |= control;
 		master_data |= (timings[pio][0] << 12) | (timings[pio][1] << 8);
 	}
 	pci_write_config_word(dev, master_port, master_data);
