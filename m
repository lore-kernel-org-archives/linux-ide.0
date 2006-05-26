From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 2/2] libata: replace ap->hard_port_no with ap->port_no
Date: Fri, 26 May 2006 14:33:25 +0800
Message-ID: <4476A135.2060302@tw.ibm.com>
References: <20060524165006.GC12022@harddisk-recovery.com> <4476947A.3020003@tw.ibm.com> <4476991E.5060506@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:53979 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751298AbWEZGdY
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 May 2006 02:33:24 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4Q6XNQc003021
	for <linux-ide@vger.kernel.org>; Fri, 26 May 2006 02:33:23 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4Q6XNjP267294
	for <linux-ide@vger.kernel.org>; Fri, 26 May 2006 00:33:23 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k4Q6XMiQ027413
	for <linux-ide@vger.kernel.org>; Fri, 26 May 2006 00:33:23 -0600
In-Reply-To: <4476991E.5060506@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Erik Mouw <erik@harddisk-recovery.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, rene.herman@keyaccess.nl, Unicorn Chang <uchang@tw.ibm.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

Patch 2/2:
replace ap->hard_port_no with ap->port_no.

Signed-off-by: Unicorn Chang <uchang@tw.ibm.com>
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

Since now ap->port_no == ap->hard_port_no.
Replace/remove ap->hard_port_no.

--- 1_legacy_irq/include/linux/libata.h	2006-05-26 09:19:40.000000000 +0800
+++ 2_remove_hardport/include/linux/libata.h	2006-05-26 09:20:01.000000000 +0800
@@ -449,7 +449,6 @@ struct ata_port {
 	unsigned long		flags;	/* ATA_FLAG_xxx */
 	unsigned int		id;	/* unique id req'd by scsi midlyr */
 	unsigned int		port_no; /* unique port #; from zero */
-	unsigned int		hard_port_no;	/* hardware port #; from zero */
 
 	struct ata_prd		*prd;	 /* our SG list */
 	dma_addr_t		prd_dma; /* and its DMA mapping */
--- 1_legacy_irq/drivers/scsi/libata-core.c	2006-05-26 09:19:40.000000000 +0800
+++ 2_remove_hardport/drivers/scsi/libata-core.c	2006-05-26 09:20:01.000000000 +0800
@@ -5173,7 +5173,6 @@ static void ata_host_init(struct ata_por
 	ap->host_set = host_set;
 	ap->dev = ent->dev;
 	ap->port_no = port_no;
-	ap->hard_port_no = port_no;
 	ap->pio_mask = ent->pio_mask;
 	ap->mwdma_mask = ent->mwdma_mask;
 	ap->udma_mask = ent->udma_mask;
--- 0_piix/drivers/scsi/ata_piix.c	2006-05-26 13:23:55.000000000 +0800
+++ 2_remove_hardport/drivers/scsi/ata_piix.c	2006-05-26 13:26:38.000000000 +0800
@@ -451,7 +451,7 @@ static void piix_pata_cbl_detect(struct 
 		goto cbl40;
 
 	/* check BIOS cable detect results */
-	mask = ap->hard_port_no == 0 ? PIIX_80C_PRI : PIIX_80C_SEC;
+	mask = ap->port_no == 0 ? PIIX_80C_PRI : PIIX_80C_SEC;
 	pci_read_config_byte(pdev, PIIX_IOCFG, &tmp);
 	if ((tmp & mask) == 0)
 		goto cbl40;
@@ -493,7 +493,7 @@ static int piix_pata_probe_reset(struct 
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 
-	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->hard_port_no])) {
+	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->port_no])) {
 		ata_port_printk(ap, KERN_INFO, "port disabled. ignoring.\n");
 		return 0;
 	}
@@ -521,7 +521,7 @@ static unsigned int piix_sata_probe (str
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	const unsigned int *map = ap->host_set->private_data;
-	int base = 2 * ap->hard_port_no;
+	int base = 2 * ap->port_no;
 	unsigned int present_mask = 0;
 	int port, i;
 	u8 pcs;
@@ -600,7 +600,7 @@ static void piix_set_piomode (struct ata
 	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
 	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
 	unsigned int is_slave	= (adev->devno != 0);
-	unsigned int master_port= ap->hard_port_no ? 0x42 : 0x40;
+	unsigned int master_port= ap->port_no ? 0x42 : 0x40;
 	unsigned int slave_port	= 0x44;
 	u16 master_data;
 	u8 slave_data;
@@ -618,10 +618,10 @@ static void piix_set_piomode (struct ata
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
@@ -651,9 +651,9 @@ static void piix_set_dmamode (struct ata
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


