From: Unicorn Chang <uchang@tw.ibm.com>
Subject: [PATCH 2/2] libata: replace ap->hard_port_no with ap->port_no , take
 #2
Date: Tue, 20 Jun 2006 12:42:01 +0800
Message-ID: <44977C99.7040701@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:55699 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964929AbWFTElw
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jun 2006 00:41:52 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5K4fpH5005296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-ide@vger.kernel.org>; Tue, 20 Jun 2006 00:41:51 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5K4g18v099614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Mon, 19 Jun 2006 22:42:01 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5K4fpZw004859
	for <linux-ide@vger.kernel.org>; Mon, 19 Jun 2006 22:41:51 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Patch 2/2:
replace ap->hard_port_no with ap->port_no.

Signed-off-by: Unicorn Chang <uchang@tw.ibm.com>
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

Since now ap->port_no == ap->hard_port_no.
Replace/remove ap->hard_port_no.

--- a/drivers/scsi/ata_piix.c	2006-06-18 23:55:34.000000000 +0800
+++ b/drivers/scsi/ata_piix.c	2006-06-20 04:06:02.000000000 +0800
@@ -447,7 +447,7 @@ static void piix_pata_cbl_detect(struct 
 		goto cbl40;
 
 	/* check BIOS cable detect results */
-	mask = ap->hard_port_no == 0 ? PIIX_80C_PRI : PIIX_80C_SEC;
+	mask = ap->port_no == 0 ? PIIX_80C_PRI : PIIX_80C_SEC;
 	pci_read_config_byte(pdev, PIIX_IOCFG, &tmp);
 	if ((tmp & mask) == 0)
 		goto cbl40;
@@ -473,7 +473,7 @@ static int piix_pata_prereset(struct ata
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 
-	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->hard_port_no])) {
+	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->port_no])) {
 		ata_port_printk(ap, KERN_INFO, "port disabled. ignoring.\n");
 		ap->eh_context.i.action &= ~ATA_EH_RESET_MASK;
 		return 0;
@@ -509,7 +509,7 @@ static int piix_sata_prereset(struct ata
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	const unsigned int *map = ap->host_set->private_data;
-	int base = 2 * ap->hard_port_no;
+	int base = 2 * ap->port_no;
 	unsigned int present_mask = 0;
 	int port, i;
 	u8 pcs;
@@ -578,7 +578,7 @@ static void piix_set_piomode (struct ata
 	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
 	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
 	unsigned int is_slave	= (adev->devno != 0);
-	unsigned int master_port= ap->hard_port_no ? 0x42 : 0x40;
+	unsigned int master_port= ap->port_no ? 0x42 : 0x40;
 	unsigned int slave_port	= 0x44;
 	u16 master_data;
 	u8 slave_data;
@@ -596,10 +596,10 @@ static void piix_set_piomode (struct ata
 		/* enable PPE, IE and TIME */
 		master_data |= 0x0070;
 		pci_read_config_byte(dev, slave_port, &slave_data);
-		slave_data &= (ap->hard_port_no ? 0x0f : 0xf0);
+		slave_data &= (ap->port_no ? 0x0f : 0xf0);
 		slave_data |=
 			(timings[pio][0] << 2) |
-			(timings[pio][1] << (ap->hard_port_no ? 4 : 0));
+			(timings[pio][1] << (ap->port_no ? 4 : 0));
 	} else {
 		master_data &= 0xccf8;
 		/* enable PPE, IE and TIME */
@@ -629,9 +629,9 @@ static void piix_set_dmamode (struct ata
 {
 	unsigned int udma	= adev->dma_mode; /* FIXME: MWDMA too */
 	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
-	u8 maslave		= ap->hard_port_no ? 0x42 : 0x40;
+	u8 maslave		= ap->port_no ? 0x42 : 0x40;
 	u8 speed		= udma;
-	unsigned int drive_dn	= (ap->hard_port_no ? 2 : 0) + adev->devno;
+	unsigned int drive_dn	= (ap->port_no ? 2 : 0) + adev->devno;
 	int a_speed		= 3 << (drive_dn * 4);
 	int u_flag		= 1 << drive_dn;
 	int v_flag		= 0x01 << drive_dn;
--- a/drivers/scsi/libata-core.c	2006-06-19 08:45:42.000000000 +0800
+++ b/drivers/scsi/libata-core.c	2006-06-20 04:13:01.000000000 +0800
@@ -5216,7 +5216,6 @@ static void ata_host_init(struct ata_por
 	ap->host_set = host_set;
 	ap->dev = ent->dev;
 	ap->port_no = port_no;
-	ap->hard_port_no = port_no;
 	ap->pio_mask = ent->pio_mask;
 	ap->mwdma_mask = ent->mwdma_mask;
 	ap->udma_mask = ent->udma_mask;
--- a/include/linux/libata.h	2006-06-19 08:14:34.000000000 +0800
+++ b/include/linux/libata.h	2006-06-20 04:11:56.000000000 +0800
@@ -333,7 +333,6 @@ struct ata_probe_ent {
 	struct scsi_host_template *sht;
 	struct ata_ioports	port[ATA_MAX_PORTS];
 	unsigned int		n_ports;
-	unsigned int		hard_port_no;
 	unsigned int		pio_mask;
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
@@ -484,7 +483,6 @@ struct ata_port {
 	unsigned long		flags;	/* ATA_FLAG_xxx */
 	unsigned int		id;	/* unique id req'd by scsi midlyr */
 	unsigned int		port_no; /* unique port #; from zero */
-	unsigned int		hard_port_no;	/* hardware port #; from zero */
 
 	struct ata_prd		*prd;	 /* our SG list */
 	dma_addr_t		prd_dma; /* and its DMA mapping */ 




