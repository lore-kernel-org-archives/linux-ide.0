From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCHES] 2.6.x libata updates
Date: Wed, 02 Mar 2005 03:29:41 -0500
Message-ID: <42257975.1010806@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030909050502080502040709"
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24041 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262223AbVCBI34 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Mar 2005 03:29:56 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------030909050502080502040709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Minor stuff that was pending.


--------------030909050502080502040709
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"

Please do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/ahci.c       |   12 ++++++------
 drivers/scsi/sata_qstor.c |   20 ++++++++++----------
 drivers/scsi/sata_vsc.c   |    4 ++--
 3 files changed, 18 insertions(+), 18 deletions(-)

through these ChangeSets:

<tklauser:nuerscht.ch>:
  o drivers/scsi/ahci: Use the DMA_{64,32}BIT_MASK constants
  o drivers/scsi/sata_vsc: Use the DMA_{64,32}BIT_MASK constants

Jeff Garzik:
  o [libata ahci] Print out port id on error messages

Mark Lord:
  o [libata qstor] minor update per LKML comments


--------------030909050502080502040709
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c	2005-03-02 03:28:50 -05:00
+++ b/drivers/scsi/ahci.c	2005-03-02 03:28:50 -05:00
@@ -574,7 +574,7 @@
 	writel(tmp, port_mmio + PORT_CMD);
 	readl(port_mmio + PORT_CMD); /* flush */
 
-	printk(KERN_WARNING "ata%u: error occurred, port reset\n", ap->port_no);
+	printk(KERN_WARNING "ata%u: error occurred, port reset\n", ap->id);
 }
 
 static void ahci_eng_timeout(struct ata_port *ap)
@@ -766,10 +766,10 @@
 
 	using_dac = hpriv->cap & HOST_CAP_64;
 	if (using_dac &&
-	    !pci_set_dma_mask(pdev, 0xffffffffffffffffULL)) {
-		rc = pci_set_consistent_dma_mask(pdev, 0xffffffffffffffffULL);
+	    !pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
+		rc = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
 		if (rc) {
-			rc = pci_set_consistent_dma_mask(pdev, 0xffffffffULL);
+			rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 			if (rc) {
 				printk(KERN_ERR DRV_NAME "(%s): 64-bit DMA enable failed\n",
 					pci_name(pdev));
@@ -779,13 +779,13 @@
 
 		hpriv->flags |= HOST_CAP_64;
 	} else {
-		rc = pci_set_dma_mask(pdev, 0xffffffffULL);
+		rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 		if (rc) {
 			printk(KERN_ERR DRV_NAME "(%s): 32-bit DMA enable failed\n",
 				pci_name(pdev));
 			return rc;
 		}
-		rc = pci_set_consistent_dma_mask(pdev, 0xffffffffULL);
+		rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 		if (rc) {
 			printk(KERN_ERR DRV_NAME "(%s): 32-bit consistent DMA enable failed\n",
 				pci_name(pdev));
diff -Nru a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
--- a/drivers/scsi/sata_qstor.c	2005-03-02 03:28:50 -05:00
+++ b/drivers/scsi/sata_qstor.c	2005-03-02 03:28:50 -05:00
@@ -261,11 +261,11 @@
 		u32 len;
 
 		addr = sg_dma_address(sg);
-		*(u64 *)prd = cpu_to_le64(addr);
+		*(__le64 *)prd = cpu_to_le64(addr);
 		prd += sizeof(u64);
 
 		len = sg_dma_len(sg);
-		*(u32 *)prd = cpu_to_le32(len);
+		*(__le32 *)prd = cpu_to_le32(len);
 		prd += sizeof(u64);
 
 		VPRINTK("PRD[%u] = (0x%llX, 0x%X)\n", nelem,
@@ -298,10 +298,10 @@
 	/* host control block (HCB) */
 	buf[ 0] = QS_HCB_HDR;
 	buf[ 1] = hflags;
-	*(u32 *)(&buf[ 4]) = cpu_to_le32(qc->nsect * ATA_SECT_SIZE);
-	*(u32 *)(&buf[ 8]) = cpu_to_le32(qc->n_elem);
+	*(__le32 *)(&buf[ 4]) = cpu_to_le32(qc->nsect * ATA_SECT_SIZE);
+	*(__le32 *)(&buf[ 8]) = cpu_to_le32(qc->n_elem);
 	addr = ((u64)pp->pkt_dma) + QS_CPB_BYTES;
-	*(u64 *)(&buf[16]) = cpu_to_le64(addr);
+	*(__le64 *)(&buf[16]) = cpu_to_le64(addr);
 
 	/* device control block (DCB) */
 	buf[24] = QS_DCB_HDR;
@@ -566,10 +566,10 @@
 	int rc, have_64bit_bus = (bus_info & QS_HPHY_64BIT);
 
 	if (have_64bit_bus &&
-	    !pci_set_dma_mask(pdev, 0xffffffffffffffffULL)) {
-		rc = pci_set_consistent_dma_mask(pdev, 0xffffffffffffffffULL);
+	    !pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
+		rc = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
 		if (rc) {
-			rc = pci_set_consistent_dma_mask(pdev, 0xffffffffULL);
+			rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 			if (rc) {
 				printk(KERN_ERR DRV_NAME
 					"(%s): 64-bit DMA enable failed\n",
@@ -578,14 +578,14 @@
 			}
 		}
 	} else {
-		rc = pci_set_dma_mask(pdev, 0xffffffffULL);
+		rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 		if (rc) {
 			printk(KERN_ERR DRV_NAME
 				"(%s): 32-bit DMA enable failed\n",
 				pci_name(pdev));
 			return rc;
 		}
-		rc = pci_set_consistent_dma_mask(pdev, 0xffffffffULL);
+		rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 		if (rc) {
 			printk(KERN_ERR DRV_NAME
 				"(%s): 32-bit consistent DMA enable failed\n",
diff -Nru a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	2005-03-02 03:28:50 -05:00
+++ b/drivers/scsi/sata_vsc.c	2005-03-02 03:28:50 -05:00
@@ -285,10 +285,10 @@
 	/*
 	 * Use 32 bit DMA mask, because 64 bit address support is poor.
 	 */
-	rc = pci_set_dma_mask(pdev, 0xFFFFFFFFULL);
+	rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 	if (rc)
 		goto err_out_regions;
-	rc = pci_set_consistent_dma_mask(pdev, 0xFFFFFFFFULL);
+	rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 	if (rc)
 		goto err_out_regions;
 

--------------030909050502080502040709--
