From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCH] 2.6.x libata fix combined mode
Date: Tue, 12 Oct 2004 01:35:58 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041012053558.GA3800@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:56207 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S269467AbUJLFgk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Oct 2004 01:36:40 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>


Please do a

	bk pull bk://gkernel.bkbits.net/misc-2.6

This will update the following files:

 drivers/scsi/ata_piix.c    |   20 ++++++++++----------
 drivers/scsi/libata-core.c |    8 ++++++++
 include/linux/libata.h     |    2 ++
 3 files changed, 20 insertions(+), 10 deletions(-)

through these ChangeSets:

<bzolnier@elka.pw.edu.pl> (04/10/11 1.2165)
   [PATCH] libata: PCI IDE legacy mode fix
   
   In PCI IDE legacy mode ap->port_no is incorrectly set to zero for
   the second port.  Fix it by adding ->hard_port_no to struct ata_probe_ent
   and struct ata_port (per Jeff's suggestion) and teaching ata_piix.c
   to use it instead of ->port_no.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c	2004-10-12 01:34:53 -04:00
+++ b/drivers/scsi/ata_piix.c	2004-10-12 01:34:53 -04:00
@@ -268,7 +268,7 @@
 		goto cbl40;
 
 	/* check BIOS cable detect results */
-	mask = ap->port_no == 0 ? PIIX_80C_PRI : PIIX_80C_SEC;
+	mask = ap->hard_port_no == 0 ? PIIX_80C_PRI : PIIX_80C_SEC;
 	pci_read_config_byte(pdev, PIIX_IOCFG, &tmp);
 	if ((tmp & mask) == 0)
 		goto cbl40;
@@ -294,7 +294,7 @@
 static void piix_pata_phy_reset(struct ata_port *ap)
 {
 	if (!pci_test_config_bits(ap->host_set->pdev,
-				  &piix_enable_bits[ap->port_no])) {
+				  &piix_enable_bits[ap->hard_port_no])) {
 		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
 		return;
@@ -327,8 +327,8 @@
 	int orig_mask, mask, i;
 	u8 pcs;
 
-	mask = (PIIX_PORT_PRESENT << ap->port_no) |
-	       (PIIX_PORT_ENABLED << ap->port_no);
+	mask = (PIIX_PORT_PRESENT << ap->hard_port_no) |
+	       (PIIX_PORT_ENABLED << ap->hard_port_no);
 
 	pci_read_config_byte(pdev, ICH5_PCS, &pcs);
 	orig_mask = (int) pcs & 0xff;
@@ -345,7 +345,7 @@
 		mask = (PIIX_PORT_PRESENT << i) | (PIIX_PORT_ENABLED << i);
 
 		if ((orig_mask & mask) == mask)
-			if (combined || (i == ap->port_no))
+			if (combined || (i == ap->hard_port_no))
 				return 1;
 	}
 
@@ -394,7 +394,7 @@
 	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
 	struct pci_dev *dev	= ap->host_set->pdev;
 	unsigned int is_slave	= (adev->devno != 0);
-	unsigned int master_port= ap->port_no ? 0x42 : 0x40;
+	unsigned int master_port= ap->hard_port_no ? 0x42 : 0x40;
 	unsigned int slave_port	= 0x44;
 	u16 master_data;
 	u8 slave_data;
@@ -412,10 +412,10 @@
 		/* enable PPE, IE and TIME */
 		master_data |= 0x0070;
 		pci_read_config_byte(dev, slave_port, &slave_data);
-		slave_data &= (ap->port_no ? 0x0f : 0xf0);
+		slave_data &= (ap->hard_port_no ? 0x0f : 0xf0);
 		slave_data |=
 			(timings[pio][0] << 2) |
-			(timings[pio][1] << (ap->port_no ? 4 : 0));
+			(timings[pio][1] << (ap->hard_port_no ? 4 : 0));
 	} else {
 		master_data &= 0xccf8;
 		/* enable PPE, IE and TIME */
@@ -445,9 +445,9 @@
 {
 	unsigned int udma	= adev->dma_mode; /* FIXME: MWDMA too */
 	struct pci_dev *dev	= ap->host_set->pdev;
-	u8 maslave		= ap->port_no ? 0x42 : 0x40;
+	u8 maslave		= ap->hard_port_no ? 0x42 : 0x40;
 	u8 speed		= udma;
-	unsigned int drive_dn	= (ap->port_no ? 2 : 0) + adev->devno;
+	unsigned int drive_dn	= (ap->hard_port_no ? 2 : 0) + adev->devno;
 	int a_speed		= 3 << (drive_dn * 4);
 	int u_flag		= 1 << drive_dn;
 	int v_flag		= 0x01 << drive_dn;
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-10-12 01:34:53 -04:00
+++ b/drivers/scsi/libata-core.c	2004-10-12 01:34:53 -04:00
@@ -3032,6 +3032,8 @@
 	ap->ctl = ATA_DEVCTL_OBS;
 	ap->host_set = host_set;
 	ap->port_no = port_no;
+	ap->hard_port_no =
+		ent->legacy_mode ? ent->hard_port_no : port_no;
 	ap->pio_mask = ent->pio_mask;
 	ap->mwdma_mask = ent->mwdma_mask;
 	ap->udma_mask = ent->udma_mask;
@@ -3338,8 +3340,14 @@
 	probe_ent[0].n_ports = 1;
 	probe_ent[0].irq = 14;
 
+	probe_ent[0].hard_port_no = 0;
+	probe_ent[0].legacy_mode = 1;
+
 	probe_ent[1].n_ports = 1;
 	probe_ent[1].irq = 15;
+
+	probe_ent[1].hard_port_no = 1;
+	probe_ent[1].legacy_mode = 1;
 
 	probe_ent[0].port[0].cmd_addr = 0x1f0;
 	probe_ent[0].port[0].altstatus_addr =
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-10-12 01:34:53 -04:00
+++ b/include/linux/libata.h	2004-10-12 01:34:53 -04:00
@@ -189,6 +189,7 @@
 	Scsi_Host_Template	*sht;
 	struct ata_ioports	port[ATA_MAX_PORTS];
 	unsigned int		n_ports;
+	unsigned int		hard_port_no;
 	unsigned int		pio_mask;
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
@@ -273,6 +274,7 @@
 	unsigned long		flags;	/* ATA_FLAG_xxx */
 	unsigned int		id;	/* unique id req'd by scsi midlyr */
 	unsigned int		port_no; /* unique port #; from zero */
+	unsigned int		hard_port_no;	/* hardware port #; from zero */
 
 	struct ata_prd		*prd;	 /* our SG list */
 	dma_addr_t		prd_dma; /* and its DMA mapping */
