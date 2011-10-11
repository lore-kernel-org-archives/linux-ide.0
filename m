From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/3] pata_sil680: constify tables
Date: Tue, 11 Oct 2011 20:20:28 +0200
Message-ID: <201110112020.28868.bzolnier@gmail.com>
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
Subject: [PATCH] pata_sil680: constify tables

Constify tables in sil680_set_[pio,dma]mode().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_sil680.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

Index: b/drivers/ata/pata_sil680.c
===================================================================
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -105,8 +105,12 @@ static int sil680_cable_detect(struct at
 
 static void sil680_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
-	static u16 speed_p[5] = { 0x328A, 0x2283, 0x1104, 0x10C3, 0x10C1 };
-	static u16 speed_t[5] = { 0x328A, 0x2283, 0x1281, 0x10C3, 0x10C1 };
+	static const u16 speed_p[5] = {
+		0x328A, 0x2283, 0x1104, 0x10C3, 0x10C1
+	};
+	static const u16 speed_t[5] = {
+		0x328A, 0x2283, 0x1281, 0x10C3, 0x10C1
+	};
 
 	unsigned long tfaddr = sil680_selreg(ap, 0x02);
 	unsigned long addr = sil680_seldev(ap, adev, 0x04);
@@ -153,11 +157,11 @@ static void sil680_set_piomode(struct at
 
 static void sil680_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
-	static u8 ultra_table[2][7] = {
+	static const u8 ultra_table[2][7] = {
 		{ 0x0C, 0x07, 0x05, 0x04, 0x02, 0x01, 0xFF },	/* 100MHz */
 		{ 0x0F, 0x0B, 0x07, 0x05, 0x03, 0x02, 0x01 },	/* 133Mhz */
 	};
-	static u16 dma_table[3] = { 0x2208, 0x10C2, 0x10C1 };
+	static const u16 dma_table[3] = { 0x2208, 0x10C2, 0x10C1 };
 
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	unsigned long ma = sil680_seldev(ap, adev, 0x08);
