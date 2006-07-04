From: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 08/24] pata_it821x: Fix pass through
Date: Tue, 4 Jul 2006 18:15:08 +0000 (UTC)
Message-ID: <11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361121401-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361123190-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk>
Reply-To: alan@lxorguk.ukuu.org.uk
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50062 "EHLO
	hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S932313AbWGDSOr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 14:14:47 -0400
Date: Maw, 04 Gor 2006 19:01:32 +0100
In-Reply-To: <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, root <root@hraefn.swansea.linux.org.uk>, Alan Cox <alan@redhat.com>

From: root <root@hraefn.swansea.linux.org.uk>

Pass through was lacking irq_clear and also had a problem with device
selection when a slave device is present

Signed-off-by: Alan Cox <alan@redhat.com>


---

 drivers/scsi/pata_it821x.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

fba593cdc70481724480df71f1a3136340bf0d95
diff --git a/drivers/scsi/pata_it821x.c b/drivers/scsi/pata_it821x.c
index 8282f78..b0ebf9c 100644
--- a/drivers/scsi/pata_it821x.c
+++ b/drivers/scsi/pata_it821x.c
@@ -80,7 +80,7 @@
 
 
 #define DRV_NAME "pata_it821x"
-#define DRV_VERSION "0.3.1"
+#define DRV_VERSION "0.3.2"
 
 struct it821x_dev
 {
@@ -419,6 +419,7 @@ void it821x_passthru_dev_select(struct a
 		it821x_program(ap, adev, itdev->pio[adev->devno]);
 		itdev->last_device = device;
 	}
+	ata_std_dev_select(ap, device);
 }
 
 /**
@@ -483,11 +484,13 @@ static unsigned int it821x_passthru_qc_i
  
 static void it821x_smart_set_mode(struct ata_port *ap)
 {
-	int dma_enabled;
+	int dma_enabled = 0;
 	int i;
 
 	/* Bits 5 and 6 indicate if DMA is active on master/slave */
-	dma_enabled = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	/* It is possible that BMDMA isn't allocated */
+	if (ap->ioaddr.bmdma_addr)
+		dma_enabled = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 	
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
@@ -737,7 +740,10 @@ static struct ata_port_operations it821x
 	.qc_issue	= it821x_passthru_qc_issue_prot,
 	.eng_timeout	= ata_eng_timeout,
 	.data_xfer	= ata_pio_data_xfer,
+
+	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_handler	= ata_interrupt,
+
 	.port_start	= it821x_port_start,
 	.port_stop	= it821x_port_stop,
 	.host_stop	= ata_host_stop
-- 
1.2.GIT

