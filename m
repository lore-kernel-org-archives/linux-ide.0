From: Erik Benada <erikbenada@yahoo.ca>
Subject: [PATCH] PATA port support for PDC2037x
Date: Wed, 29 Sep 2004 22:30:13 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040930023013.13192.qmail@web60304.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web60304.mail.yahoo.com ([216.109.118.115]:9902 "HELO
	web60304.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268526AbUI3CaO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Sep 2004 22:30:14 -0400
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Jeff,

included is patch to add support for PATA port on Promise PDC2037x controllers.
Patch is against 2.6.8.1 vanilla kernel.
I tested this patch on my PDC20378 on-board controller with 1 PATA drive attached.
I didn't do any large testing but my drive was detected properly and I was able to 
mount and use filesystem on it.

I tried to minimize changes to libata code. I just added flags for each port to ata_probe_ent
structure and modified ata_host_init() function. 

Promise SATA driver was changed to use new ata_probe_ent->port_flags, check for presence of
PATA port and pdc_phy_reset will use different reset code for PATA and SATA ports.

Any comments, suggestions?

  Erik

Signed-off-by: Erik Benada <erikbenada@yahoo.ca>


diff -uprN -X dontdiff linux-2.6.8.1-vanilla/drivers/scsi/libata-core.c
linux-2.6.8.1-PATA/drivers/scsi/libata-core.c
--- linux-2.6.8.1-vanilla/drivers/scsi/libata-core.c	2004-09-29 21:07:05.000000000 -0400
+++ linux-2.6.8.1-PATA/drivers/scsi/libata-core.c	2004-09-27 17:58:28.000000000 -0400
@@ -2806,6 +2806,7 @@ static void ata_host_init(struct ata_por
 	ap->pio_mask = ent->pio_mask;
 	ap->udma_mask = ent->udma_mask;
 	ap->flags |= ent->host_flags;
+	ap->flags |= ent->port_flags[port_no];
 	ap->ops = ent->port_ops;
 	ap->cbl = ATA_CBL_NONE;
 	ap->device[0].flags = ATA_DFLAG_MASTER;
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/drivers/scsi/sata_promise.c
linux-2.6.8.1-PATA/drivers/scsi/sata_promise.c
--- linux-2.6.8.1-vanilla/drivers/scsi/sata_promise.c	2004-09-29 21:07:05.000000000 -0400
+++ linux-2.6.8.1-PATA/drivers/scsi/sata_promise.c	2004-09-29 21:27:05.102266472 -0400
@@ -80,6 +80,8 @@ static void pdc_eng_timeout(struct ata_p
 static int pdc_port_start(struct ata_port *ap);
 static void pdc_port_stop(struct ata_port *ap);
 static void pdc_phy_reset(struct ata_port *ap);
+static void pdc_pata_phy_reset(struct ata_port *ap);
+static void pdc_pata_cbl_detect(struct ata_port *ap);
 static void pdc_qc_prep(struct ata_queued_cmd *qc);
 static void pdc_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf);
@@ -128,7 +130,7 @@ static struct ata_port_info pdc_port_inf
 	/* board_2037x */
 	{
 		.sht		= &pdc_sata_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+		.host_flags	= /* ATA_FLAG_SATA | */ ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
 		.pio_mask	= 0x03, /* pio3-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
@@ -243,7 +245,35 @@ static void pdc_reset_port(struct ata_po
 static void pdc_phy_reset(struct ata_port *ap)
 {
 	pdc_reset_port(ap);
-	sata_phy_reset(ap);
+	if (ap->flags & ATA_FLAG_SATA)
+		sata_phy_reset(ap);
+	else
+		pdc_pata_phy_reset(ap);
+}
+
+static void pdc_pata_cbl_detect(struct ata_port *ap)
+{
+	u8 tmp;
+	void *mmio = (void *) ap->ioaddr.cmd_addr + PDC_CTLSTAT + 0x03;
+
+	tmp = readb(mmio);
+	
+	if (tmp & 0x01)
+	{
+		ap->cbl = ATA_CBL_PATA40;
+		ap->udma_mask &= ATA_UDMA_MASK_40C;
+	}
+	else
+		ap->cbl = ATA_CBL_PATA80;
+}
+		
+static void pdc_pata_phy_reset(struct ata_port *ap)
+{
+	pdc_pata_cbl_detect(ap);
+
+	ata_port_probe(ap);
+	
+	ata_bus_reset(ap);
 }
 
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
@@ -557,6 +587,7 @@ static int pdc_sata_init_one (struct pci
 	void *mmio_base;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 	int rc;
+	u8 tmp;
 
 	if (!printed_version++)
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
@@ -614,6 +645,9 @@ static int pdc_sata_init_one (struct pci
 	probe_ent->port[0].scr_addr = base + 0x400;
 	probe_ent->port[1].scr_addr = base + 0x500;
 
+	probe_ent->port_flags[0] = ATA_FLAG_SATA;
+	probe_ent->port_flags[1] = ATA_FLAG_SATA;
+	
 	/* notice 4-port boards */
 	switch (board_idx) {
 	case board_20319:
@@ -624,9 +658,25 @@ static int pdc_sata_init_one (struct pci
 
 		probe_ent->port[2].scr_addr = base + 0x600;
 		probe_ent->port[3].scr_addr = base + 0x700;
+	
+		probe_ent->port_flags[2] = ATA_FLAG_SATA;
+		probe_ent->port_flags[3] = ATA_FLAG_SATA;
 		break;
 	case board_2037x:
-       		probe_ent->n_ports = 2;
+		/* Some boards have also PATA port */
+		tmp = readb(base + PDC_FLASH_CTL+1);
+		if (!(tmp & 0x80))
+		{
+			probe_ent->n_ports = 3;
+			
+			pdc_sata_setup_port(&probe_ent->port[2], base + 0x300);
+
+			probe_ent->port_flags[2] = ATA_FLAG_SLAVE_POSS;
+			
+			printk(KERN_INFO DRV_NAME " PATA port found\n");
+		}
+		else
+       			probe_ent->n_ports = 2;
 		break;
 	default:
 		BUG();
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/include/linux/libata.h
linux-2.6.8.1-PATA/include/linux/libata.h
--- linux-2.6.8.1-vanilla/include/linux/libata.h	2004-09-29 21:07:05.000000000 -0400
+++ linux-2.6.8.1-PATA/include/linux/libata.h	2004-09-27 22:36:43.000000000 -0400
@@ -193,6 +193,7 @@ struct ata_probe_ent {
 	unsigned long		irq;
 	unsigned int		irq_flags;
 	unsigned long		host_flags;
+	unsigned long		port_flags[ATA_MAX_PORTS];
 	void			*mmio_base;
 	void			*private_data;
 };



______________________________________________________________________ 
Post your free ad now! http://personals.yahoo.ca
