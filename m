From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes 3/3] pata_hpt366: update mode programming
Date: Mon, 08 Dec 2008 19:01:23 +0900
Message-ID: <493CF073.7030809@kernel.org>
References: <493CED7A.2010505@kernel.org> <493CEE74.3060601@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37337 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbYLHKBm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Dec 2008 05:01:42 -0500
In-Reply-To: <493CEE74.3060601@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, rob.opensuse.linux@googlemail.com

Update mode programming logic of pata_hpt366 such that it's identical
to that of IDE hpt366 driver.  The differences were...

* pata_hpt366 used 0xCFFF8FFFF to mask pio modes and 0x3FFFFFFF dma
  modes.  IDE hpt366 uses 0xC1F8FFFF for PIO, 0x303800FF for MWDMA and
  0x30070000 for UDMA.

* pata_hpt366 doesn't set 0x08000000 for PIO unless it's already set
  and always turns it on for MWDMA/UDMA.  IDE hpt366 doesn't bother
  with the bit.  It always uses what was there.

* IDE hpt366 always clears 0xC0000000.  pata_hpt366 doesn't.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---

Alan, can you please ack this if you think it's okay.  Jeff, please
don't commit till Alan acks.  Thanks.

 drivers/ata/pata_hpt366.c |   50 ++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

Index: work/drivers/ata/pata_hpt366.c
===================================================================
--- work.orig/drivers/ata/pata_hpt366.c
+++ work/drivers/ata/pata_hpt366.c
@@ -188,25 +188,41 @@ static unsigned long hpt366_filter(struc
 }
 
 /**
- *	hpt36x_find_mode	-	reset the hpt36x bus
+ *	hpt36x_calc_timing	-	calculate timing value for transfer mode
  *	@ap: ATA port
- *	@speed: transfer mode
+ *	@cur_timing: current timing value
+ *	@speed: target transfer mode
  *
  *	Return the 32bit register programming information for this channel
  *	that matches the speed provided.
  */
 
-static u32 hpt36x_find_mode(struct ata_port *ap, int speed)
+static u32 hpt36x_calc_timing(struct ata_port *ap, u32 cur_timing, int speed)
 {
 	struct hpt_clock *clocks = ap->host->private_data;
+	u32 mask;
 
-	while(clocks->xfer_speed) {
+	if (speed < XFER_MW_DMA_0)
+		mask = 0xc1f8ffff;
+	else if (speed < XFER_UDMA_0)
+		mask = 0x303800ff;
+	else
+		mask = 0x30070000;
+
+	while (clocks->xfer_speed) {
 		if (clocks->xfer_speed == speed)
-			return clocks->timing;
+			break;
 		clocks++;
 	}
-	BUG();
-	return 0xffffffffU;	/* silence compiler warning */
+	if (!clocks->xfer_speed)
+		BUG();
+
+	/*
+	 * Combine new mode bits with old config bits and disable
+	 * on-chip PIO FIFO/buffer (and PIO MST mode as well) to avoid
+	 * problems handling I/O errors later.
+	 */
+	return ((cur_timing & ~mask) | (clocks->timing & mask)) & ~0xc0000000;
 }
 
 static int hpt36x_cable_detect(struct ata_port *ap)
@@ -232,8 +248,7 @@ static void hpt366_set_piomode(struct at
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 addr1, addr2;
-	u32 reg;
-	u32 mode;
+	u32 reg, timing;
 	u8 fast;
 
 	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
@@ -247,11 +262,8 @@ static void hpt366_set_piomode(struct at
 	}
 
 	pci_read_config_dword(pdev, addr1, &reg);
-	mode = hpt36x_find_mode(ap, adev->pio_mode);
-	mode &= ~0x8000000;	/* No FIFO in PIO */
-	mode &= ~0x30070000;	/* Leave config bits alone */
-	reg &= 0x30070000;	/* Strip timing bits */
-	pci_write_config_dword(pdev, addr1, reg | mode);
+	timing = hpt36x_calc_timing(ap, reg, adev->pio_mode);
+	pci_write_config_dword(pdev, addr1, timing);
 }
 
 /**
@@ -267,8 +279,7 @@ static void hpt366_set_dmamode(struct at
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 addr1, addr2;
-	u32 reg;
-	u32 mode;
+	u32 reg, timing;
 	u8 fast;
 
 	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
@@ -282,11 +293,8 @@ static void hpt366_set_dmamode(struct at
 	}
 
 	pci_read_config_dword(pdev, addr1, &reg);
-	mode = hpt36x_find_mode(ap, adev->dma_mode);
-	mode |= 0x8000000;	/* FIFO in MWDMA or UDMA */
-	mode &= ~0xC0000000;	/* Leave config bits alone */
-	reg &= 0xC0000000;	/* Strip timing bits */
-	pci_write_config_dword(pdev, addr1, reg | mode);
+	timing = hpt36x_calc_timing(ap, reg, adev->dma_mode);
+	pci_write_config_dword(pdev, addr1, timing);
 }
 
 static struct scsi_host_template hpt36x_sht = {
