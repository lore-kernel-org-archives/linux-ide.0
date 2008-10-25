From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] sata_sil24: configure max read request size
 to 4k
Date: Sat, 25 Oct 2008 14:26:54 +0900
Message-ID: <4902AE1E.5020504@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57673 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbYJYF1I (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 25 Oct 2008 01:27:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pierre Ossman <drzeus-list@drzeus.cx>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Due to request posting limitations, bandwidth of sil3132 is limited to
around 120MB/s with the minimum pci-e payload size (128bytes) which is
used by most consumer systems.  However, write throughput can be
slightly (~3%) increased by increasing the max read requeset size.
Configure it to 4k which is the maximum supported.  This optimization
is also done by SIMG's windows driver.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/sata_sil24.c |    5 +++++
 1 file changed, 5 insertions(+)
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 4621807..ccee930 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -1329,6 +1329,11 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
+	/* Set max read request size to 4096.  This slightly increases
+	 * write throughput for pci-e variants.
+	 */
+	pcie_set_readrq(pdev, 4096);
+
 	sil24_init_controller(host);
 
 	pci_set_master(pdev);
