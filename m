From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 17/64] pata_efar: add locking for parallel scanning
Date: Mon, 18 Jan 2010 18:16:11 +0100
Message-ID: <20100118171611.14623.45198.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754799Ab0ARRRk@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_efar: add locking for parallel scanning

Add clearing of UDMA enable bit also for PIO modes and then add
an extra locking for parallel scanning.

This is similar change as commit 60c3be3 for ata_piix host driver
and while pata_efar doesn't enable parallel scan yet the race could
probably also be triggered by requesting re-scanning of both ports
at the same time using SCSI sysfs interface.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_efar.c |   29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

Index: b/drivers/ata/pata_efar.c
===================================================================
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -68,14 +68,18 @@ static int efar_cable_detect(struct ata_
 	return ATA_CBL_PATA80;
 }
 
+static DEFINE_SPINLOCK(efar_lock);
+
 static void efar_set_timings(struct ata_port *ap, struct ata_device *adev,
 			     u8 pio, bool use_mwdma)
 {
 	struct pci_dev *dev	= to_pci_dev(ap->host->dev);
+	unsigned long flags;
 	unsigned int is_slave	= (adev->devno != 0);
 	u8 master_port		= ap->port_no ? 0x42 : 0x40;
 	u16 master_data;
 	u8 slave_data;
+	u8 udma_enable;
 	int control = 0;
 
 	/*
@@ -103,6 +107,8 @@ static void efar_set_timings(struct ata_
 		/* Enable DMA timing only */
 		control |= 8;	/* PIO cycles in PIO0 */
 
+	spin_lock_irqsave(&efar_lock, flags);
+
 	pci_read_config_word(dev, master_port, &master_data);
 
 	/* Set PPE, IE, and TIME as appropriate */
@@ -127,6 +133,12 @@ static void efar_set_timings(struct ata_
 	pci_write_config_word(dev, master_port, master_data);
 	if (is_slave)
 		pci_write_config_byte(dev, 0x44, slave_data);
+
+	pci_read_config_byte(dev, 0x48, &udma_enable);
+	udma_enable &= ~(1 << (2 * ap->port_no + adev->devno));
+	pci_write_config_byte(dev, 0x48, udma_enable);
+
+	spin_unlock_irqrestore(&efar_lock, flags);
 }
 
 /**
@@ -159,16 +171,19 @@ static void efar_set_piomode(struct ata_
 static void efar_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 {
 	struct pci_dev *dev	= to_pci_dev(ap->host->dev);
+	unsigned long flags;
 	u8 speed		= adev->dma_mode;
 	int devid		= adev->devno + 2 * ap->port_no;
 	u8 udma_enable;
 
-	pci_read_config_byte(dev, 0x48, &udma_enable);
-
 	if (speed >= XFER_UDMA_0) {
 		unsigned int udma = speed - XFER_UDMA_0;
 		u16 udma_timing;
 
+		spin_lock_irqsave(&efar_lock, flags);
+
+		pci_read_config_byte(dev, 0x48, &udma_enable);
+
 		udma_enable |= (1 << devid);
 
 		/* Load the UDMA mode number */
@@ -176,13 +191,13 @@ static void efar_set_dmamode (struct ata
 		udma_timing &= ~(7 << (4 * devid));
 		udma_timing |= udma << (4 * devid);
 		pci_write_config_word(dev, 0x4A, udma_timing);
-	} else {
+
+		pci_write_config_byte(dev, 0x48, udma_enable);
+
+		spin_unlock_irqrestore(&efar_lock, flags);
+	} else
 		/* MWDMA is driven by the PIO timings. */
 		efar_set_timings(ap, adev, ata_mwdma_to_pio(speed), 1);
-
-		udma_enable &= ~(1 << devid);
-	}
-	pci_write_config_byte(dev, 0x48, udma_enable);
 }
 
 static struct scsi_host_template efar_sht = {
