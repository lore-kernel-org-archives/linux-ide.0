From: Erik Benada <erikbenada@yahoo.ca>
Subject: [PATCH/RFC] PATA port on SATA controllers
Date: Sat, 2 Oct 2004 23:47:52 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041003034752.55539.qmail@web60306.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web60306.mail.yahoo.com ([216.109.118.117]:60813 "HELO
	web60306.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267708AbUJCDrx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 2 Oct 2004 23:47:53 -0400
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi Jeff,

this is the first attempt to properly support SATA and PATA ports on the same controller.
Patch is against 2.6.9-rc3.

Changes:
- ata_probe_ent: multiple ata_port_operations, per port flags
- libata-core.c: changes for new ata_probe_ent + minor cleanups (mostly in comments)
- sata_promise.c: PATA port support using new infrastructure

Tested on my PDC20378.

Any suggestions, comments?

Questions:
-----------
1. In your e-mail outlining steps required to properly support PATA port on SATA controller
you mentioned ata_host_set structure. Why do we need multiple ata_port_operations in there? I
couldn't find any code that uses anything but irq_handler, irq_clear and host_stop.

2. Would it make sense to create ata_host_ops structure to move host related operations (like
irq_handler, irq_clear, host_stop) from ata_port_operations and replace ata_host_set->ops with it?

3. ata_port_info structure - is it intended to describe just 1 port or should it now support
multiple ports (by adding n_ports and multiple ata_port_operations)?


Thanks,

  Erik

Signed-off-by: Erik Benada <erikbenada@yahoo.ca>

 drivers/scsi/libata-core.c  |   33 ++++++-----
 drivers/scsi/sata_promise.c |  124 +++++++++++++++++++++++++++++++++++---------
 include/linux/libata.h      |    3 -
 3 files changed, 121 insertions(+), 39 deletions(-)


diff -uprN -X dontdiff linux-2.6.9-rc3/drivers/scsi/libata-core.c
linux-pata/drivers/scsi/libata-core.c
--- linux-2.6.9-rc3/drivers/scsi/libata-core.c	2004-09-30 20:00:31.000000000 -0400
+++ linux-pata/drivers/scsi/libata-core.c	2004-10-02 22:36:04.000000000 -0400
@@ -191,11 +191,11 @@ void ata_tf_load(struct ata_port *ap, st
 }
 
 /**
- *	ata_exec_command - issue ATA command to host controller
+ *	ata_exec_command_pio - issue ATA command to host controller
  *	@ap: port to which command is being issued
  *	@tf: ATA taskfile register set
  *
- *	Issues PIO/MMIO write to ATA command register, with proper
+ *	Issues PIO write to ATA command register, with proper
  *	synchronization with interrupt handler / other threads.
  *
  *	LOCKING:
@@ -271,7 +271,7 @@ static inline void ata_exec(struct ata_p
  *	other threads.
  *
  *	LOCKING:
- *	Obtains host_set lock.
+ *	FIXME: Obtains host_set lock.
  */
 
 static void ata_tf_to_host(struct ata_port *ap, struct ata_taskfile *tf)
@@ -306,7 +306,7 @@ void ata_tf_to_host_nolock(struct ata_po
  *	@tf: ATA taskfile register set for storing input
  *
  *	Reads ATA taskfile registers for currently-selected device
- *	into @tf.
+ *	into @tf via PIO.
  *
  *	LOCKING:
  *	Inherited from caller.
@@ -377,7 +377,7 @@ void ata_tf_read(struct ata_port *ap, st
  *	@ap: port where the device is
  *
  *	Reads ATA taskfile status register for currently-selected device
- *	and return it's value. This also clears pending interrupts
+ *	via PIO and return it's value. This also clears pending interrupts
  *      from this device
  *
  *	LOCKING:
@@ -486,7 +486,7 @@ void ata_tf_from_fis(u8 *fis, struct ata
 /**
  *	ata_prot_to_cmd - determine which read/write opcodes to use
  *	@protocol: ATA_PROT_xxx taskfile protocol
- *	@lba48: true is lba48 is present
+ *	@lba48: true if lba48 is present
  *
  *	Given necessary input, determine which read/write commands
  *	to use to transfer data.
@@ -1265,7 +1265,7 @@ void __sata_phy_reset(struct ata_port *a
 }
 
 /**
- *	__sata_phy_reset -
+ *	sata_phy_reset -
  *	@ap:
  *
  *	LOCKING:
@@ -1426,7 +1426,7 @@ static void ata_set_mode(struct ata_port
 	if (ap->ops->post_set_mode)
 		ap->ops->post_set_mode(ap);
 
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
 		ata_dev_set_protocol(dev);
 	}
@@ -2235,7 +2235,7 @@ err_out:
 }
 
 /**
- *	ata_pio_sector -
+ *	ata_pio_block -
  *	@ap:
  *
  *	LOCKING:
@@ -3036,7 +3036,8 @@ static void ata_host_init(struct ata_por
 	ap->mwdma_mask = ent->mwdma_mask;
 	ap->udma_mask = ent->udma_mask;
 	ap->flags |= ent->host_flags;
-	ap->ops = ent->port_ops;
+	ap->flags |= ent->port_flags[port_no];
+	ap->ops = ent->port_ops[port_no];
 	ap->cbl = ATA_CBL_NONE;
 	ap->active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
@@ -3125,7 +3126,8 @@ int ata_device_add(struct ata_probe_ent 
 	host_set->irq = ent->irq;
 	host_set->mmio_base = ent->mmio_base;
 	host_set->private_data = ent->private_data;
-	host_set->ops = ent->port_ops;
+	/* FIXME: should we have separate ata_host_ops structure ? */
+	host_set->ops = ent->port_ops[0];
 
 	/* register each port bound to this device */
 	for (i = 0; i < ent->n_ports; i++) {
@@ -3153,7 +3155,7 @@ int ata_device_add(struct ata_probe_ent 
 	       		ent->irq);
 
 		ata_chk_status(ap);
-		host_set->ops->irq_clear(ap);
+		ap->ops->irq_clear(ap);
 		count++;
 	}
 
@@ -3163,7 +3165,7 @@ int ata_device_add(struct ata_probe_ent 
 	}
 
 	/* obtain irq, that is shared between channels */
-	if (request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
+	if (request_irq(ent->irq, ent->port_ops[0]->irq_handler, ent->irq_flags,
 			DRV_NAME, host_set))
 		goto err_out;
 
@@ -3292,7 +3294,6 @@ ata_probe_ent_alloc(int n, struct pci_de
 		probe_ent[i].pio_mask = port[i]->pio_mask;
 		probe_ent[i].mwdma_mask = port[i]->mwdma_mask;
 		probe_ent[i].udma_mask = port[i]->udma_mask;
-		probe_ent[i].port_ops = port[i]->port_ops;
 
 	}
 
@@ -3315,12 +3316,14 @@ ata_pci_init_native_mode(struct pci_dev 
 	probe_ent->port[0].ctl_addr =
 		pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
 	probe_ent->port[0].bmdma_addr = pci_resource_start(pdev, 4);
+	probe_ent->port_ops[0] = port[0]->port_ops;
 
 	probe_ent->port[1].cmd_addr = pci_resource_start(pdev, 2);
 	probe_ent->port[1].altstatus_addr =
 	probe_ent->port[1].ctl_addr =
 		pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
 	probe_ent->port[1].bmdma_addr = pci_resource_start(pdev, 4) + 8;
+	probe_ent->port_ops[1] = port[0]->port_ops;
 
 	ata_std_ports(&probe_ent->port[0]);
 	ata_std_ports(&probe_ent->port[1]);
@@ -3345,11 +3348,13 @@ ata_pci_init_legacy_mode(struct pci_dev 
 	probe_ent[0].port[0].altstatus_addr =
 	probe_ent[0].port[0].ctl_addr = 0x3f6;
 	probe_ent[0].port[0].bmdma_addr = pci_resource_start(pdev, 4);
+	probe_ent[0].port_ops[0] = port[0]->port_ops;
 
 	probe_ent[1].port[0].cmd_addr = 0x170;
 	probe_ent[1].port[0].altstatus_addr =
 	probe_ent[1].port[0].ctl_addr = 0x376;
 	probe_ent[1].port[0].bmdma_addr = pci_resource_start(pdev, 4)+8;
+	probe_ent[1].port_ops[0] = port[1]->port_ops;
 
 	ata_std_ports(&probe_ent[0].port[0]);
 	ata_std_ports(&probe_ent[1].port[0]);
diff -uprN -X dontdiff linux-2.6.9-rc3/drivers/scsi/sata_promise.c
linux-pata/drivers/scsi/sata_promise.c
--- linux-2.6.9-rc3/drivers/scsi/sata_promise.c	2004-09-30 20:00:31.000000000 -0400
+++ linux-pata/drivers/scsi/sata_promise.c	2004-10-02 22:36:55.000000000 -0400
@@ -63,6 +63,9 @@ enum {
 	PDC_HAS_PATA		= (1 << 1), /* PDC20375 has PATA */
 
 	PDC_RESET		= (1 << 11), /* HDMA reset */
+
+	PDC_SATA_OPS		= 0,	/* SATA port operations */
+	PDC_PATA_OPS		= 1,	/* PATA port operations */
 };
 
 
@@ -78,7 +81,9 @@ static irqreturn_t pdc_interrupt (int ir
 static void pdc_eng_timeout(struct ata_port *ap);
 static int pdc_port_start(struct ata_port *ap);
 static void pdc_port_stop(struct ata_port *ap);
-static void pdc_phy_reset(struct ata_port *ap);
+static void pdc_sata_phy_reset(struct ata_port *ap);
+static void pdc_pata_phy_reset(struct ata_port *ap);
+static void pdc_pata_cbl_detect(struct ata_port *ap);
 static void pdc_qc_prep(struct ata_queued_cmd *qc);
 static void pdc_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf);
@@ -104,35 +109,55 @@ static Scsi_Host_Template pdc_sata_sht =
 	.bios_param		= ata_std_bios_param,
 };
 
-static struct ata_port_operations pdc_sata_ops = {
-	.port_disable		= ata_port_disable,
-	.tf_load		= pdc_tf_load_mmio,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
-	.exec_command		= pdc_exec_command_mmio,
-	.dev_select		= ata_std_dev_select,
-	.phy_reset		= pdc_phy_reset,
-	.qc_prep		= pdc_qc_prep,
-	.qc_issue		= pdc_qc_issue_prot,
-	.eng_timeout		= pdc_eng_timeout,
-	.irq_handler		= pdc_interrupt,
-	.irq_clear		= pdc_irq_clear,
-	.scr_read		= pdc_sata_scr_read,
-	.scr_write		= pdc_sata_scr_write,
-	.port_start		= pdc_port_start,
-	.port_stop		= pdc_port_stop,
+static struct ata_port_operations pdc_port_ops[] = {
+	{	/* SATA port operations */
+		.port_disable		= ata_port_disable,
+		.tf_load		= pdc_tf_load_mmio,
+		.tf_read		= ata_tf_read,
+		.check_status		= ata_check_status,
+		.exec_command		= pdc_exec_command_mmio,
+		.dev_select		= ata_std_dev_select,
+		.phy_reset		= pdc_sata_phy_reset,
+		.qc_prep		= pdc_qc_prep,
+		.qc_issue		= pdc_qc_issue_prot,
+		.eng_timeout		= pdc_eng_timeout,
+		.irq_handler		= pdc_interrupt,
+		.irq_clear		= pdc_irq_clear,
+		.scr_read		= pdc_sata_scr_read,
+		.scr_write		= pdc_sata_scr_write,
+		.port_start		= pdc_port_start,
+		.port_stop		= pdc_port_stop,
+	},
+	{	/* PATA port operations */
+		.port_disable		= ata_port_disable,
+		.tf_load		= pdc_tf_load_mmio,
+		.tf_read		= ata_tf_read,
+		.check_status		= ata_check_status,
+		.exec_command		= pdc_exec_command_mmio,
+		.dev_select		= ata_std_dev_select,
+		.phy_reset		= pdc_pata_phy_reset,
+		.qc_prep		= pdc_qc_prep,
+		.qc_issue		= pdc_qc_issue_prot,
+		.eng_timeout		= pdc_eng_timeout,
+		.irq_handler		= pdc_interrupt,
+		.irq_clear		= pdc_irq_clear,
+		.scr_read		= pdc_sata_scr_read,
+		.scr_write		= pdc_sata_scr_write,
+		.port_start		= pdc_port_start,
+		.port_stop		= pdc_port_stop,
+	},
 };
 
 static struct ata_port_info pdc_port_info[] = {
 	/* board_2037x */
 	{
 		.sht		= &pdc_sata_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+		.host_flags	= /* ATA_FLAG_SATA | */ ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
-		.port_ops	= &pdc_sata_ops,
+		.port_ops	= &pdc_port_ops[PDC_SATA_OPS],
 	},
 
 	/* board_20319 */
@@ -143,7 +168,7 @@ static struct ata_port_info pdc_port_inf
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
-		.port_ops	= &pdc_sata_ops,
+		.port_ops	= &pdc_port_ops[PDC_SATA_OPS],
 	},
 };
 
@@ -241,12 +266,37 @@ static void pdc_reset_port(struct ata_po
 	readl(mmio);	/* flush */
 }
 
-static void pdc_phy_reset(struct ata_port *ap)
+static void pdc_sata_phy_reset(struct ata_port *ap)
 {
 	pdc_reset_port(ap);
 	sata_phy_reset(ap);
 }
 
+static void pdc_pata_phy_reset(struct ata_port *ap)
+{
+	pdc_pata_cbl_detect(ap);
+
+	ata_port_probe(ap);
+
+	ata_bus_reset(ap);
+}
+
+static void pdc_pata_cbl_detect(struct ata_port *ap)
+{
+	u8 tmp;
+	void *mmio = (void *) ap->ioaddr.cmd_addr + PDC_CTLSTAT + 3;
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
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
 	if (sc_reg > SCR_CONTROL)
@@ -547,6 +597,7 @@ static int pdc_sata_init_one (struct pci
 	void *mmio_base;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 	int rc;
+	u8 tmp;
 
 	if (!printed_version++)
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
@@ -593,8 +644,13 @@ static int pdc_sata_init_one (struct pci
 	probe_ent->pio_mask	= pdc_port_info[board_idx].pio_mask;
 	probe_ent->mwdma_mask	= pdc_port_info[board_idx].mwdma_mask;
 	probe_ent->udma_mask	= pdc_port_info[board_idx].udma_mask;
-	probe_ent->port_ops	= pdc_port_info[board_idx].port_ops;
 
+	probe_ent->port_ops[0]	= &pdc_port_ops[PDC_SATA_OPS];
+	probe_ent->port_ops[1]	= &pdc_port_ops[PDC_SATA_OPS];
+	
+	probe_ent->port_flags[0] |= ATA_FLAG_SATA;
+	probe_ent->port_flags[1] |= ATA_FLAG_SATA;
+	
        	probe_ent->irq = pdev->irq;
        	probe_ent->irq_flags = SA_SHIRQ;
 	probe_ent->mmio_base = mmio_base;
@@ -610,6 +666,12 @@ static int pdc_sata_init_one (struct pci
 	case board_20319:
        		probe_ent->n_ports = 4;
 
+		probe_ent->port_ops[2]	= &pdc_port_ops[PDC_SATA_OPS];
+		probe_ent->port_ops[3]	= &pdc_port_ops[PDC_SATA_OPS];
+	
+		probe_ent->port_flags[2] |= ATA_FLAG_SATA;
+		probe_ent->port_flags[3] |= ATA_FLAG_SATA;
+	
 		pdc_sata_setup_port(&probe_ent->port[2], base + 0x300);
 		pdc_sata_setup_port(&probe_ent->port[3], base + 0x380);
 
@@ -617,7 +679,21 @@ static int pdc_sata_init_one (struct pci
 		probe_ent->port[3].scr_addr = base + 0x700;
 		break;
 	case board_2037x:
-       		probe_ent->n_ports = 2;
+		/* Some boards have also PATA port */
+		tmp = readb(mmio_base + PDC_FLASH_CTL+1);
+		if (!(tmp & 0x80))
+		{
+			probe_ent->n_ports = 3;
+			
+			probe_ent->port_ops[2] = &pdc_port_ops[PDC_PATA_OPS];
+			
+			pdc_sata_setup_port(&probe_ent->port[2], base + 0x300);
+
+			probe_ent->port_flags[2] |= ATA_FLAG_SLAVE_POSS;
+			printk(KERN_INFO DRV_NAME " PATA port found\n");
+		}
+		else
+			probe_ent->n_ports = 2;
 		break;
 	default:
 		BUG();
diff -uprN -X dontdiff linux-2.6.9-rc3/include/linux/libata.h linux-pata/include/linux/libata.h
--- linux-2.6.9-rc3/include/linux/libata.h	2004-09-30 20:00:31.000000000 -0400
+++ linux-pata/include/linux/libata.h	2004-10-02 23:13:17.843585520 -0400
@@ -185,7 +185,7 @@ struct ata_ioports {
 struct ata_probe_ent {
 	struct list_head	node;
 	struct pci_dev		*pdev;
-	struct ata_port_operations	*port_ops;
+	struct ata_port_operations	*port_ops[ATA_MAX_PORTS];
 	Scsi_Host_Template	*sht;
 	struct ata_ioports	port[ATA_MAX_PORTS];
 	unsigned int		n_ports;
@@ -196,6 +196,7 @@ struct ata_probe_ent {
 	unsigned long		irq;
 	unsigned int		irq_flags;
 	unsigned long		host_flags;
+	unsigned long		port_flags[ATA_MAX_PORTS];
 	void __iomem		*mmio_base;
 	void			*private_data;
 };




______________________________________________________________________ 
Post your free ad now! http://personals.yahoo.ca
