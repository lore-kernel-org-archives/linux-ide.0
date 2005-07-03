From: Daniel Drake <dsd@gentoo.org>
Subject: [PATCH] sata_nv: Support MCP51/MCP55 device IDs
Date: Sun, 03 Jul 2005 13:44:39 +0100
Message-ID: <42C7DDB7.50201@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050705040401030108050706"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:4982 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261413AbVGCMn4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Jul 2005 08:43:56 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, rpunkunus@nvidia.com

This is a multi-part message in MIME format.
--------------050705040401030108050706
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

From: Rob Punkunus <rpunkunus@nvidia.com>

Rob Punkunus recently submitted a patch to enable support for MCP51/MCP55 in
the sata_nv driver. This patch was whitespace-corrupted.

Gentoo would like to support this hardware for our upcoming release media, so
I fixed the patch, and here it is :)

Due to the pci_ids.h diff, this depends on the amd74xx patch I sent in
previously to this one.

Signed-off-by: Daniel Drake <dsd@gentoo.org>


--------------050705040401030108050706
Content-Type: text/x-patch;
 name="4340_sata-nv-mcp5x.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="4340_sata-nv-mcp5x.patch"

--- linux-2.6.12/drivers/scsi/sata_nv.c	2005-06-17 20:48:29.000000000 +0100
+++ linux-dsd/drivers/scsi/sata_nv.c	2005-06-27 18:58:10.000000000 +0100
@@ -20,6 +20,12 @@
  *  If you do not delete the provisions above, a recipient may use your
  *  version of this file under either the OSL or the GPL.
  *
+ *  0.08
+ *     - Added support for MCP51 and MCP55.
+ *
+ *  0.07
+ *     - Added support for RAID class code.
+ *
  *  0.06
  *     - Added generic SATA support by using a pci_device_id that filters on
  *       the IDE storage class code.
@@ -48,7 +54,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME			"sata_nv"
-#define DRV_VERSION			"0.6"
+#define DRV_VERSION			"0.8"
 
 #define NV_PORTS			2
 #define NV_PIO_MASK			0x1f
@@ -116,7 +122,9 @@ enum nv_host_type
 	GENERIC,
 	NFORCE2,
 	NFORCE3,
-	CK804
+	CK804,
+	MCP51,
+	MCP55
 };
 
 static struct pci_device_id nv_pci_tbl[] = {
@@ -134,9 +142,18 @@ static struct pci_device_id nv_pci_tbl[]
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP51 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP51 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP55 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
+		PCI_ANY_ID, PCI_ANY_ID,
+		PCI_CLASS_STORAGE_RAID<<8, 0xffff00, GENERIC },
 	{ 0, } /* terminate list */
 };
 
--- linux-2.6.12/include/linux/pci_ids.h	2005-06-27 18:54:57.000000000 +0100
+++ linux-dsd/include/linux/pci_ids.h	2005-06-27 18:59:42.000000000 +0100
@@ -1235,6 +1235,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA	0x0266
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2	0x0267
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE	0x036E
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA	0x036F
 #define PCI_DEVICE_ID_NVIDIA_NVENET_12		0x0268
 #define PCI_DEVICE_ID_NVIDIA_NVENET_13		0x0269
 #define PCI_DEVICE_ID_NVIDIA_MCP51_AUDIO	0x026B

--------------050705040401030108050706--
