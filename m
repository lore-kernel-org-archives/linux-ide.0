From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 12/20] pata_rdc: parallel scanning needs an extra locking
Date: Tue, 08 Feb 2011 13:25:02 +0100
Message-ID: <20110208122502.19110.28978.sendpatchset@linux-mhg7.site>
References: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

>From 540001238b8ebbc4bedd46ca4e2672fcf3787998 Mon Sep 17 00:00:00 2001
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Tue, 8 Feb 2011 12:39:27 +0100
Subject: [PATCH 12/20] pata_rdc: parallel scanning needs an extra locking

This is similar change as commit 60c3be3 for ata_piix host driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_rdc.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/pata_rdc.c b/drivers/ata/pata_rdc.c
index d32b252..f55ff82 100644
--- a/drivers/ata/pata_rdc.c
+++ b/drivers/ata/pata_rdc.c
@@ -86,10 +86,13 @@ static int rdc_pata_prereset(struct ata_link *link, unsigned long deadline)
 	return ata_sff_prereset(link, deadline);
 }
 
+static DEFINE_SPINLOCK(rdc_lock);
+
 static void rdc_set_timings(struct ata_port *ap, struct ata_device *adev,
 			    u8 pio, bool use_mwdma)
 {
 	struct pci_dev *dev	= to_pci_dev(ap->host->dev);
+	unsigned long flags;
 	unsigned int is_slave	= (adev->devno != 0);
 	unsigned int master_port= ap->port_no ? 0x42 : 0x40;
 	unsigned int slave_port	= 0x44;
@@ -117,6 +120,8 @@ static void rdc_set_timings(struct ata_port *ap, struct ata_device *adev,
 		/* Enable DMA timing only */
 		control |= 8;	/* PIO cycles in PIO0 */
 
+	spin_lock_irqsave(&rdc_lock, flags);
+
 	/* PIO configuration clears DTE unconditionally.  It will be
 	 * programmed in set_dmamode which is guaranteed to be called
 	 * after set_piomode if any DMA mode is available.
@@ -154,6 +159,8 @@ static void rdc_set_timings(struct ata_port *ap, struct ata_device *adev,
 	pci_read_config_byte(dev, 0x48, &udma_enable);
 	udma_enable &= ~(1 << (2 * ap->port_no + adev->devno));
 	pci_write_config_byte(dev, 0x48, udma_enable);
+
+	spin_unlock_irqrestore(&rdc_lock, flags);
 }
 
 /**
@@ -186,6 +193,7 @@ static void rdc_set_piomode(struct ata_port *ap, struct ata_device *adev)
 static void rdc_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
 	struct pci_dev *dev	= to_pci_dev(ap->host->dev);
+	unsigned long flags;
 	u8 speed		= adev->dma_mode;
 	int devid		= adev->devno + 2 * ap->port_no;
 	u8 udma_enable		= 0;
@@ -196,6 +204,8 @@ static void rdc_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 		u16 ideconf;
 		int u_clock, u_speed;
 
+		spin_lock_irqsave(&rdc_lock, flags);
+
 		pci_read_config_byte(dev, 0x48, &udma_enable);
 
 		/*
@@ -228,6 +238,8 @@ static void rdc_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 		pci_write_config_word(dev, 0x54, ideconf);
 
 		pci_write_config_byte(dev, 0x48, udma_enable);
+
+		spin_unlock_irqrestore(&rdc_lock, flags);
 	} else {
 		/* MWDMA is driven by the PIO timings. */
 		unsigned int mwdma = speed - XFER_MW_DMA_0;
-- 
1.7.1
