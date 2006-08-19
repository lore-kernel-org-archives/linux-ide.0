From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/20] libata: kill unused ->host_stop() operation and related functions
Date: Sat, 19 Aug 2006 17:59:32 +0900
Message-ID: <11559779722266-git-send-email-htejun@gmail.com>
References: <11559778241753-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:35163 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751674AbWHSJ1k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Aug 2006 05:27:40 -0400
Received: by py-out-1112.google.com with SMTP id n25so1477492pyg
        for <linux-ide@vger.kernel.org>; Sat, 19 Aug 2006 02:27:39 -0700 (PDT)
In-Reply-To: <11559778241753-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Now that ata_port_operations->host_stop() is replaced by
pci_driver->remove_one(), kill the method and related functions.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    9 ---------
 include/linux/libata.h    |    3 ---
 2 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1778256..4b85c88 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6146,14 +6146,6 @@ void ata_std_ports(struct ata_ioports *i
 
 
 #ifdef CONFIG_PCI
-
-void ata_pci_host_stop (struct ata_host *host)
-{
-	struct pci_dev *pdev = to_pci_dev(host->dev);
-
-	pci_iounmap(pdev, host->mmio_base);
-}
-
 /* move to PCI subsystem */
 int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits)
 {
@@ -6460,7 +6452,6 @@ EXPORT_SYMBOL_GPL(ata_timing_merge);
 
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
-EXPORT_SYMBOL_GPL(ata_pci_host_stop);
 EXPORT_SYMBOL_GPL(ata_pci_device_do_suspend);
 EXPORT_SYMBOL_GPL(ata_pci_device_do_resume);
 EXPORT_SYMBOL_GPL(ata_pci_device_suspend);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e274121..c5200c0 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -647,8 +647,6 @@ struct ata_port_operations {
 	int (*port_start) (struct ata_port *ap);
 	void (*port_stop) (struct ata_port *ap);
 
-	void (*host_stop) (struct ata_host *host);
-
 	void (*bmdma_stop) (struct ata_queued_cmd *qc);
 	u8   (*bmdma_status) (struct ata_port *ap);
 };
@@ -898,7 +896,6 @@ struct pci_bits {
 	unsigned long		val;
 };
 
-extern void ata_pci_host_stop (struct ata_host *host);
 extern int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits);
 extern unsigned long ata_pci_default_filter(const struct ata_port *, struct ata_device *, unsigned long);
 #endif /* CONFIG_PCI */
-- 
1.4.1.1


