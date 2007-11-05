From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_serverworks: Fix problem with some drive combinations
Date: Mon, 5 Nov 2007 15:04:40 +0000
Message-ID: <20071105150440.0469be7e@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37048 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751269AbXKEPEE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Nov 2007 10:04:04 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

The driver used the channel not the device number for deciding where to
load some timing parameters. Also change so that we clear the UDMA field
as the old driver did. Not believed neccessary but does no harm.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc1/drivers/ata/pata_serverworks.c linux-2.6.24-rc1/drivers/ata/pata_serverworks.c
--- linux.vanilla-2.6.24-rc1/drivers/ata/pata_serverworks.c	2007-11-01 11:41:54.000000000 +0000
+++ linux-2.6.24-rc1/drivers/ata/pata_serverworks.c	2007-11-02 17:25:41.000000000 +0000
@@ -274,28 +274,27 @@
 {
 	static const u8 dma_mode[] = { 0x77, 0x21, 0x20 };
 	int offset = 1 + 2 * ap->port_no - adev->devno;
-	int devbits = (2 * ap->port_no + adev->devno);
+	int devbits = 2 * ap->port_no + adev->devno;
 	u8 ultra;
 	u8 ultra_cfg;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	pci_read_config_byte(pdev, 0x54, &ultra_cfg);
+	pci_read_config_byte(pdev, 0x56 + ap->port_no, &ultra);
+	ultra &= ~(0x0F << (adev->devno * 4));
 
 	if (adev->dma_mode >= XFER_UDMA_0) {
 		pci_write_config_byte(pdev, 0x44 + offset,  0x20);
 
-		pci_read_config_byte(pdev, 0x56 + ap->port_no, &ultra);
-		ultra &= ~(0x0F << (ap->port_no * 4));
 		ultra |= (adev->dma_mode - XFER_UDMA_0)
-					<< (ap->port_no * 4);
-		pci_write_config_byte(pdev, 0x56 + ap->port_no, ultra);
-
+					<< (adev->devno * 4);
 		ultra_cfg |=  (1 << devbits);
 	} else {
 		pci_write_config_byte(pdev, 0x44 + offset,
 			dma_mode[adev->dma_mode - XFER_MW_DMA_0]);
 		ultra_cfg &= ~(1 << devbits);
 	}
+	pci_write_config_byte(pdev, 0x56 + ap->port_no, ultra);
 	pci_write_config_byte(pdev, 0x54, ultra_cfg);
 }
 
