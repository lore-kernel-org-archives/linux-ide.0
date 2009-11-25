From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 15/86] pata_efar: fix wrong MWDMA timings being programmed
Date: Wed, 25 Nov 2009 18:04:08 +0100
Message-ID: <20091125170408.5446.92212.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759144AbZKYREt@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_efar: fix wrong MWDMA timings being programmed

Do not clear MWDMA timings for device on the other port when
programming slave device.

This change should be safe as this is how we have been doing
things in IDE slc90e66 host driver for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_efar.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_efar.c
===================================================================
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -201,7 +201,7 @@ static void efar_set_dmamode (struct ata
 			master_data &= 0xFF4F;  /* Mask out IORDY|TIME1|DMAONLY */
 			master_data |= control << 4;
 			pci_read_config_byte(dev, 0x44, &slave_data);
-			slave_data &= (0x0F + 0xE1 * ap->port_no);
+			slave_data &= ap->port_no ? 0x0F : 0xF0;
 			/* Load the matching timing */
 			slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << (ap->port_no ? 4 : 0);
 			pci_write_config_byte(dev, 0x44, slave_data);
