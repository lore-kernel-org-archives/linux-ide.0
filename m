From: Otavio Salvador <otavio@ossystems.com.br>
Subject: [PATCH 2/2] pata_amd: add support for CS5535 controllers
Date: Fri,  3 Jul 2009 11:22:43 -0300
Message-ID: <1246630963-5831-2-git-send-email-otavio@ossystems.com.br>
References: <1246630963-5831-1-git-send-email-otavio@ossystems.com.br>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f193.google.com ([209.85.222.193]:39604 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbZGCOWV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Jul 2009 10:22:21 -0400
Received: by pzk31 with SMTP id 31so914098pzk.33
        for <linux-ide@vger.kernel.org>; Fri, 03 Jul 2009 07:22:25 -0700 (PDT)
In-Reply-To: <1246630963-5831-1-git-send-email-otavio@ossystems.com.br>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Otavio Salvador <otavio@ossystems.com.br>


Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---
 drivers/ata/pata_amd.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 33a74f1..5d0a0a7 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -454,7 +454,7 @@ static void amd_clear_fifo(struct pci_dev *pdev)
 
 static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	static const struct ata_port_info info[10] = {
+	static const struct ata_port_info info[] = {
 		{	/* 0: AMD 7401 - no swdma */
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = ATA_PIO4,
@@ -518,7 +518,14 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 			.udma_mask = ATA_UDMA6,
 			.port_ops = &nv133_port_ops
 		},
-		{	/* 9: AMD CS5536 (Geode companion) */
+		{	/* 9: AMD CS5535 (Geode companion) */
+			.flags = ATA_FLAG_SLAVE_POSS,
+			.pio_mask = ATA_PIO4,
+			.mwdma_mask = ATA_MWDMA2,
+			.udma_mask = ATA_UDMA4,
+			.port_ops = &amd100_port_ops
+		},
+		{	/* 10: AMD CS5536 (Geode companion) */
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = ATA_PIO4,
 			.mwdma_mask = ATA_MWDMA2,
@@ -615,7 +622,8 @@ static const struct pci_device_id amd[] = {
 	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE),	8 },
 	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP73_IDE),	8 },
 	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP77_IDE),	8 },
-	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE),		9 },
+	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_CS5535_IDE),		9 },
+	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE),		10 },
 
 	{ },
 };
-- 
1.6.3.3.385.g60647

