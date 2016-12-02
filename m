From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/3] nvme: move NVMe class code to pci_ids.h
Date: Fri,  2 Dec 2016 19:31:01 +0100
Message-ID: <1480703463-17489-2-git-send-email-hch@lst.de>
References: <1480703463-17489-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:35168 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755170AbcLBSbP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 2 Dec 2016 13:31:15 -0500
In-Reply-To: <1480703463-17489-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: dan.j.williams@intel.com, linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org

We'll need to check for it in the AHCI drivers (yes, really) soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 3 ---
 include/linux/pci_ids.h | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0fc99f0..2c58f15 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2064,9 +2064,6 @@ static const struct pci_error_handlers nvme_err_handler = {
 	.reset_notify	= nvme_reset_notify,
 };
 
-/* Move to pci_ids.h later */
-#define PCI_CLASS_STORAGE_EXPRESS	0x010802
-
 static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x0953),
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index c58752f..a5e6c7b 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -23,8 +23,10 @@
 #define PCI_CLASS_STORAGE_SATA		0x0106
 #define PCI_CLASS_STORAGE_SATA_AHCI	0x010601
 #define PCI_CLASS_STORAGE_SAS		0x0107
+#define PCI_CLASS_STORAGE_EXPRESS	0x010802
 #define PCI_CLASS_STORAGE_OTHER		0x0180
 
+
 #define PCI_BASE_CLASS_NETWORK		0x02
 #define PCI_CLASS_NETWORK_ETHERNET	0x0200
 #define PCI_CLASS_NETWORK_TOKEN_RING	0x0201
-- 
2.1.4

