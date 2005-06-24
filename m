From: Rob Punkunus <rpunkunus@nvidia.com>
Subject: [PATCH][2.6.11.12] sata_nv.c patch for new NVIDIA device IDs
Date: Thu, 23 Jun 2005 17:07:10 -0700
Message-ID: <1119571630.1819.18.camel@dhcp-174-26.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.112.143]:41736 "EHLO
	HQEMGATE03.nvidia.com") by vger.kernel.org with ESMTP
	id S262663AbVFWWET convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Jun 2005 18:04:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rpunkunus@nvidia.com, blazara@nvidia.com, acurrid@nvidia.com, achew@nvidia.com, bzolnier@gmail.com, vojtech@suse.cz, gregkh@suse.de, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Signed-off-by: Rob Punkunus <rpunkunus@nvidia.com>
---

Only in linux-2.6.11.12-sata: .config
diff -pur linux-2.6.11.12/drivers/scsi/sata_nv.c linux-2.6.11.12-sata/drivers/scsi/sata_nv.c
--- linux-2.6.11.12/drivers/scsi/sata_nv.c	2005-06-11 19:45:37.000000000 -0700
+++ linux-2.6.11.12-sata/drivers/scsi/sata_nv.c	2005-06-21 06:36:08.000000000 -0700
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
@@ -115,7 +121,9 @@ enum nv_host_type
 	GENERIC,
 	NFORCE2,
 	NFORCE3,
-	CK804
+	CK804,
+	MCP51,
+	MCP55
 };
 
 static struct pci_device_id nv_pci_tbl[] = {
@@ -133,9 +141,18 @@ static struct pci_device_id nv_pci_tbl[]
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
 
diff -pur linux-2.6.11.12/include/linux/pci_ids.h linux-2.6.11.12-sata/include/linux/pci_ids.h
--- linux-2.6.11.12/include/linux/pci_ids.h	2005-06-11 19:45:37.000000000 -0700
+++ linux-2.6.11.12-sata/include/linux/pci_ids.h	2005-06-20 09:12:48.000000000 -0700
@@ -1166,6 +1166,9 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_900XGL	0x0258
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_750XGL	0x0259
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL	0x025B
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA  0x0266
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2 0x0267
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA  0x036F
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5200	0x0329
 
 #define PCI_VENDOR_ID_IMS		0x10e0



