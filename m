From: achew <achew@nvidia.com>
Subject: [PATCH} sata_nv: enable generic class support for future NVIDIA SATA
 controllers
Date: Thu, 20 Jan 2005 15:19:20 -0800
Message-ID: <41F03C78.2080707@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate01.nvidia.com ([216.228.112.170]:29499 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S261634AbVATXSd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Jan 2005 18:18:33 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

This patch adds a new entry in the pci_device_id table that filters by class code, in order to cause unlisted NVIDIA SATA
controllers to be probed.  In the probe function, we determine whether the device is a SATA or IDE controller by checking the
device's bars (NVIDIA SATA controllers will always have 6 bars).  Bar5 I/O mapped vs. memory mapped is now determined
programmatically by looking at the resource flags of the bar.

Signed-off-by: Andrew Chew <achew@nvidia.com>




diff -ru linux-2.6.11-rc1-bk5/drivers/scsi/sata_nv.c linux/drivers/scsi/sata_nv.c
--- linux-2.6.11-rc1-bk5/drivers/scsi/sata_nv.c	2004-12-24 13:34:26.000000000 -0800
+++ linux/drivers/scsi/sata_nv.c	2005-01-20 14:39:17.000000000 -0800
@@ -20,6 +20,10 @@
  *  If you do not delete the provisions above, a recipient may use your
  *  version of this file under either the OSL or the GPL.
  *
+ *  0.06
+ *     - Added generic SATA support by using a pci_device_id that filters on
+ *       the IDE storage class code.
+ *
  *  0.03
  *     - Fixed a bug where the hotplug handlers for non-CK804/MCP04 were using
  *       mmio_base, which is only set for the CK804/MCP04 case.
@@ -44,7 +48,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME			"sata_nv"
-#define DRV_VERSION			"0.5"
+#define DRV_VERSION			"0.6"
 
 #define NV_PORTS			2
 #define NV_PIO_MASK			0x1f
@@ -108,6 +112,7 @@
 
 enum nv_host_type
 {
+	GENERIC,
 	NFORCE2,
 	NFORCE3,
 	CK804
@@ -128,6 +133,9 @@
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
+		PCI_ANY_ID, PCI_ANY_ID,
+		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
 	{ 0, } /* terminate list */
 };
 
@@ -136,7 +144,6 @@
 struct nv_host_desc
 {
 	enum nv_host_type	host_type;
-	unsigned long		host_flags;
 	void			(*enable_hotplug)(struct ata_probe_ent *probe_ent);
 	void			(*disable_hotplug)(struct ata_host_set *host_set);
 	void			(*check_hotplug)(struct ata_host_set *host_set);
@@ -144,21 +151,24 @@
 };
 static struct nv_host_desc nv_device_tbl[] = {
 	{
+		.host_type	= GENERIC,
+		.enable_hotplug	= NULL,
+		.disable_hotplug= NULL,
+		.check_hotplug	= NULL,
+	},
+	{
 		.host_type	= NFORCE2,
-		.host_flags	= 0x00000000,
 		.enable_hotplug	= nv_enable_hotplug,
 		.disable_hotplug= nv_disable_hotplug,
 		.check_hotplug	= nv_check_hotplug,
 	},
 	{
 		.host_type	= NFORCE3,
-		.host_flags	= 0x00000000,
 		.enable_hotplug	= nv_enable_hotplug,
 		.disable_hotplug= nv_disable_hotplug,
 		.check_hotplug	= nv_check_hotplug,
 	},
 	{	.host_type	= CK804,
-		.host_flags	= NV_HOST_FLAGS_SCR_MMIO,
 		.enable_hotplug	= nv_enable_hotplug_ck804,
 		.disable_hotplug= nv_disable_hotplug_ck804,
 		.check_hotplug	= nv_check_hotplug_ck804,
@@ -168,6 +178,7 @@
 struct nv_host
 {
 	struct nv_host_desc	*host_desc;
+	unsigned long		host_flags;
 };
 
 static struct pci_driver nv_pci_driver = {
@@ -284,8 +295,8 @@
 	if (sc_reg > SCR_CONTROL)
 		return 0xffffffffU;
 
-	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO)
-		return readl(ap->ioaddr.scr_addr + (sc_reg * 4));
+	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO)
+		return readl((void*)ap->ioaddr.scr_addr + (sc_reg * 4));
 	else
 		return inl(ap->ioaddr.scr_addr + (sc_reg * 4));
 }
@@ -298,8 +309,8 @@
 	if (sc_reg > SCR_CONTROL)
 		return;
 
-	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO)
-		writel(val, ap->ioaddr.scr_addr + (sc_reg * 4));
+	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO)
+		writel(val, (void*)ap->ioaddr.scr_addr + (sc_reg * 4));
 	else
 		outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
 }
@@ -322,6 +333,14 @@
 	struct ata_port_info *ppi;
 	struct ata_probe_ent *probe_ent;
 	int rc;
+	u32 bar;
+
+        // Make sure this is a SATA controller by counting the number of bars
+        // (NVIDIA SATA controllers will always have six bars).  Otherwise,
+        // it's an IDE controller and we ignore it.
+	for (bar=0; bar<6; bar++)
+		if (pci_resource_start(pdev, bar) == 0)
+			return -ENODEV;
 
 	if (!printed_version++)
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
@@ -352,11 +371,15 @@
 	if (!host)
 		goto err_out_free_ent;
 
+	memset(host, 0, sizeof(struct nv_host));
 	host->host_desc = &nv_device_tbl[ent->driver_data];
 
 	probe_ent->private_data = host;
 
-	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO) {
+	if (pci_resource_flags(pdev, 5) & IORESOURCE_MEM)
+		host->host_flags |= NV_HOST_FLAGS_SCR_MMIO;
+
+	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO) {
 		unsigned long base;
 
 		probe_ent->mmio_base = ioremap(pci_resource_start(pdev, 5),
@@ -395,7 +418,7 @@
 	return 0;
 
 err_out_iounmap:
-	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO)
+	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO)
 		iounmap(probe_ent->mmio_base);
 err_out_free_host:
 	kfree(host);


