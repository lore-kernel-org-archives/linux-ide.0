From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev#upstream 2/2] pata_amd: don't configure udma mode faster than BIOS did
Date: Mon, 5 Feb 2007 17:08:01 +0900
Message-ID: <20070205080801.GJ1625@htj.dyndns.org>
References: <20070205080518.GI1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:10073 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbXBEIIH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 03:08:07 -0500
Received: by an-out-0708.google.com with SMTP id b33so963890ana
        for <linux-ide@vger.kernel.org>; Mon, 05 Feb 2007 00:08:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20070205080518.GI1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On many nvidia boards, BIOSen often set CABLE bit in EIDE Controller
Configuration Register even when 40c cable is attached but configures
transfer mode correctly (<= udma33).  As pata_amd depends on the CABLE
bit to determine the cable type and thus the highest allowed udma
mode, this often results in incorrectly configured device resulting in
CRC errors and DMA disabling.

This patch implements mode_filter for pata_amd which makes it avoid
configuring udma mode higher than BIOS did.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Equivalent patch posted for drivers/ide/amd74xx.c too.

 drivers/ata/pata_amd.c |   80 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 9 deletions(-)

Index: work/drivers/ata/pata_amd.c
===================================================================
--- work.orig/drivers/ata/pata_amd.c
+++ work/drivers/ata/pata_amd.c
@@ -27,6 +27,44 @@
 #define DRV_NAME "pata_amd"
 #define DRV_VERSION "0.2.7"
 
+static unsigned long amd_nv_mode_filter(const struct ata_port *ap,
+					struct ata_device *adev,
+					unsigned long xfer_mask)
+{
+	static const unsigned int udma_mask_map[] =
+		{ ATA_UDMA2, ATA_UDMA1, ATA_UDMA0, 0,
+		  ATA_UDMA3, ATA_UDMA4, ATA_UDMA5, ATA_UDMA6 };
+	u32 udma = (unsigned long)ap->host->private_data;
+	unsigned int pio_mask, mwdma_mask, udma_mask, limit;
+
+	/* Cable detection is horrible on these controllers.  Don't
+	 * configure UDMA mode faster than BIOS did.
+	 */
+	if (ap->port_no == 0)
+		udma >>= 16;
+	if (adev->devno == 0)
+		udma >>= 8;
+
+	/* if BIOS didn't configure UDMA, don't filter */
+	if ((udma & 0xc0) != 0xc0)
+		return xfer_mask;
+
+	/* determine limit, don't go below UDMA2 */
+	limit = udma_mask_map[udma & 0x07] | ATA_UDMA2;
+
+	/* limit xfer_mask */
+	ata_unpack_xfermask(xfer_mask, &pio_mask, &mwdma_mask, &udma_mask);
+	if (!(udma_mask & ~limit))
+		return xfer_mask;
+
+	udma_mask &= limit;
+	xfer_mask = ata_pack_xfermask(pio_mask, mwdma_mask, udma_mask);
+	ata_dev_printk(adev, KERN_INFO,
+		       "speed limited to %s to honor BIOS limit\n",
+		       ata_mode_string(xfer_mask));
+	return xfer_mask;
+}
+
 /**
  *	timing_setup		-	shared timing computation and load
  *	@ap: ATA port being set up
@@ -374,7 +412,7 @@ static struct ata_port_operations amd66_
 	.port_disable	= ata_port_disable,
 	.set_piomode	= amd66_set_piomode,
 	.set_dmamode	= amd66_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
+	.mode_filter	= amd_nv_mode_filter,
 	.tf_load	= ata_tf_load,
 	.tf_read	= ata_tf_read,
 	.check_status 	= ata_check_status,
@@ -406,7 +444,7 @@ static struct ata_port_operations amd100
 	.port_disable	= ata_port_disable,
 	.set_piomode	= amd100_set_piomode,
 	.set_dmamode	= amd100_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
+	.mode_filter	= amd_nv_mode_filter,
 	.tf_load	= ata_tf_load,
 	.tf_read	= ata_tf_read,
 	.check_status 	= ata_check_status,
@@ -438,7 +476,7 @@ static struct ata_port_operations amd133
 	.port_disable	= ata_port_disable,
 	.set_piomode	= amd133_set_piomode,
 	.set_dmamode	= amd133_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
+	.mode_filter	= amd_nv_mode_filter,
 	.tf_load	= ata_tf_load,
 	.tf_read	= ata_tf_read,
 	.check_status 	= ata_check_status,
@@ -470,7 +508,7 @@ static struct ata_port_operations nv100_
 	.port_disable	= ata_port_disable,
 	.set_piomode	= nv100_set_piomode,
 	.set_dmamode	= nv100_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
+	.mode_filter	= amd_nv_mode_filter,
 	.tf_load	= ata_tf_load,
 	.tf_read	= ata_tf_read,
 	.check_status 	= ata_check_status,
@@ -502,7 +540,7 @@ static struct ata_port_operations nv133_
 	.port_disable	= ata_port_disable,
 	.set_piomode	= nv133_set_piomode,
 	.set_dmamode	= nv133_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
+	.mode_filter	= amd_nv_mode_filter,
 	.tf_load	= ata_tf_load,
 	.tf_read	= ata_tf_read,
 	.check_status 	= ata_check_status,
@@ -614,9 +652,10 @@ static int amd_init_one(struct pci_dev *
 			.port_ops = &amd100_port_ops
 		}
 	};
-	static struct ata_port_info *port_info[2];
 	static int printed_version;
+	struct ata_port_info pinfo, *port_info[2];
 	int type = id->driver_data;
+	u32 udma = 0;
 	u8 rev;
 	u8 fifo;
 
@@ -645,12 +684,35 @@ static int amd_init_one(struct pci_dev *
 	if (type < 3)
 		ata_pci_clear_simplex(pdev);
 
-	/* And fire it up */
+	/* Cache BIOS configured mode in host private_data, will be
+	 * used to limit UDMA transfer mode.
+	 */
+	if (pdev->vendor == PCI_VENDOR_ID_AMD)
+		pci_read_config_dword(pdev, 0x50, &udma);
+	else
+		pci_read_config_dword(pdev, 0x60, &udma);
 
-	port_info[0] = port_info[1] = &info[type];
+	/* And fire it up */
+	pinfo = info[type];
+	pinfo.private_data = (void *)(unsigned long)udma;
+	port_info[0] = port_info[1] = &pinfo;
 	return ata_pci_init_one(pdev, port_info, 2);
 }
 
+static void amd_remove_one(struct pci_dev *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	u32 udma = (unsigned long)host->private_data;
+
+	/* restore BIOS configured mode */
+	if (pdev->vendor == PCI_VENDOR_ID_AMD)
+		pci_write_config_dword(pdev, 0x50, udma);
+	else
+		pci_write_config_dword(pdev, 0x60, udma);
+
+	return ata_pci_remove_one(pdev);
+}
+
 static int amd_reinit_one(struct pci_dev *pdev)
 {
 	if (pdev->vendor == PCI_VENDOR_ID_AMD) {
@@ -695,7 +757,7 @@ static struct pci_driver amd_pci_driver 
 	.name 		= DRV_NAME,
 	.id_table	= amd,
 	.probe 		= amd_init_one,
-	.remove		= ata_pci_remove_one,
+	.remove		= amd_remove_one,
 	.suspend	= ata_pci_device_suspend,
 	.resume		= amd_reinit_one,
 };
