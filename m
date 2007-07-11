From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] pata_hpt3x3: DMA Kconfig fix
Date: Tue, 10 Jul 2007 21:37:38 -0400
Message-ID: <20070711013738.GA27994@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:35589 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754703AbXGKBhl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Jul 2007 21:37:41 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>


commit 790956e7bbf0a7b73e72b04d3bd63d974c7e29bb
Author: Jeff Garzik <jeff@garzik.org>
Date:   Tue Jul 10 21:36:13 2007 -0400

    pata_hpt3x3: fix DMA Kconfig option to actually have a hope of working
    
    The hook that set DMA mode was accidentally deleted in the original patch.
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

790956e7bbf0a7b73e72b04d3bd63d974c7e29bb
diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index a66e2c3..be0f05e 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -52,6 +52,7 @@ static void hpt3x3_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	pci_write_config_dword(pdev, 0x48, r2);
 }
 
+#if defined(CONFIG_PATA_HPT3X3_DMA)
 /**
  *	hpt3x3_set_dmamode		-	DMA timing setup
  *	@ap: ATA interface
@@ -86,6 +87,7 @@ static void hpt3x3_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 	pci_write_config_dword(pdev, 0x44, r1);
 	pci_write_config_dword(pdev, 0x48, r2);
 }
+#endif /* CONFIG_PATA_HPT3X3_DMA */
 
 /**
  *	hpt3x3_atapi_dma	-	ATAPI DMA check
@@ -120,6 +122,9 @@ static struct scsi_host_template hpt3x3_sht = {
 static struct ata_port_operations hpt3x3_port_ops = {
 	.port_disable	= ata_port_disable,
 	.set_piomode	= hpt3x3_set_piomode,
+#if defined(CONFIG_PATA_HPT3X3_DMA)
+	.set_dmamode	= hpt3x3_set_dmamode,
+#endif
 	.mode_filter	= ata_pci_default_filter,
 
 	.tf_load	= ata_tf_load,
