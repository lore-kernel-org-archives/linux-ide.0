From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PROPOSAL] ata: Report 16/32bit PIO as best we can
Date: Thu, 09 Apr 2009 17:31:17 +0100
Message-ID: <20090409163107.3744.14309.stgit@t61.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52634 "EHLO
	t61.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933789AbZDIPc3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Apr 2009 11:32:29 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org

The legacy old IDE API for this is a bit primitive so we try and map stuff
sensibly onto it.

- Set PIO over DMA devices to report 32bit
- Add ability to change the PIO32 settings if the controller permits it
- Add that functionality into the sff drivers
- Add that functionality into the VLB legacy driver
- Turn on the 32bit PIO on the ninja32 and add support there

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/ata/libata-scsi.c  |   30 ++++++++++++++++++++++++++----
 drivers/ata/libata-sff.c   |   27 +++++++++++++++++++++++++++
 drivers/ata/pata_legacy.c  |   33 ++++++++++++++++++++-------------
 drivers/ata/pata_ninja32.c |    4 +++-
 include/linux/libata.h     |    8 ++++++++
 5 files changed, 84 insertions(+), 18 deletions(-)


diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b9747fa..2733b0c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -647,23 +647,45 @@ int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg)
 	return rc;
 }
 
+static int ata_ioc32(struct ata_port *ap)
+{
+	if (ap->flags & ATA_FLAG_PIO_DMA)
+		return 1;
+	if (ap->pflags & ATA_PFLAG_PIO32)
+		return 1;
+	return 0;
+}
+
 int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *scsidev,
 		     int cmd, void __user *arg)
 {
 	int val = -EINVAL, rc = -EINVAL;
+	unsigned long flags;
 
 	switch (cmd) {
 	case ATA_IOC_GET_IO32:
-		val = 0;
+		spin_lock_irqsave(ap->lock, flags);
+		val = ata_ioc32(ap);
+		spin_unlock_irqrestore(ap->lock, flags);
 		if (copy_to_user(arg, &val, 1))
 			return -EFAULT;
 		return 0;
 
 	case ATA_IOC_SET_IO32:
 		val = (unsigned long) arg;
-		if (val != 0)
-			return -EINVAL;
-		return 0;
+		rc = 0;
+		spin_lock_irqsave(ap->lock, flags);
+		if (ap->pflags & ATA_PFLAG_PIO32CHANGE) {
+			if (val)
+				ap->pflags |= ATA_PFLAG_PIO32;
+			else
+				ap->pflags &= ~ATA_PFLAG_PIO32;
+		} else {
+			if (val != ata_ioc32(ap))
+				rc = -EINVAL;
+		}
+		spin_unlock_irqrestore(ap->lock, flags);
+		return rc;
 
 	case HDIO_GET_IDENTITY:
 		return ata_get_identity(ap, scsidev, arg);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 8332e97..bb18415 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -87,6 +87,7 @@ const struct ata_port_operations ata_bmdma32_port_ops = {
 	.inherits		= &ata_bmdma_port_ops,
 
 	.sff_data_xfer		= ata_sff_data_xfer32,
+	.port_start		= ata_sff_port_start32,
 };
 EXPORT_SYMBOL_GPL(ata_bmdma32_port_ops);
 
@@ -769,6 +770,9 @@ unsigned int ata_sff_data_xfer32(struct ata_device *dev, unsigned char *buf,
 	void __iomem *data_addr = ap->ioaddr.data_addr;
 	unsigned int words = buflen >> 2;
 	int slop = buflen & 3;
+	
+	if (!(ap->pflags & ATA_PFLAG_PIO32))
+		return ata_sff_data_xfer(dev, buf, buflen, rw);
 
 	/* Transfer multiple of 4 bytes */
 	if (rw == READ)
@@ -2402,6 +2406,29 @@ int ata_sff_port_start(struct ata_port *ap)
 EXPORT_SYMBOL_GPL(ata_sff_port_start);
 
 /**
+ *	ata_sff_port_start32 - Set port up for dma.
+ *	@ap: Port to initialize
+ *
+ *	Called just after data structures for each port are
+ *	initialized.  Allocates space for PRD table if the device
+ *	is DMA capable SFF.
+ *
+ *	May be used as the port_start() entry in ata_port_operations for
+ *	devices that are capable of 32bit PIO.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+int ata_sff_port_start32(struct ata_port *ap)
+{
+	ap->pflags |= ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32CHANGE;
+	if (ap->ioaddr.bmdma_addr)
+		return ata_port_start(ap);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ata_sff_port_start32);
+
+/**
  *	ata_sff_std_ports - initialize ioaddr with standard port offsets.
  *	@ioaddr: IO address structure to be initialized
  *
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 3f830f0..41730da 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -108,6 +108,7 @@ struct legacy_controller {
 	struct ata_port_operations *ops;
 	unsigned int pio_mask;
 	unsigned int flags;
+	unsigned int pflags;
 	int (*setup)(struct platform_device *, struct legacy_probe *probe,
 		struct legacy_data *data);
 };
@@ -285,7 +286,8 @@ static unsigned int pdc_data_xfer_vlb(struct ata_device *dev,
 {
 	int slop = buflen & 3;
 	/* 32bit I/O capable *and* we need to write a whole number of dwords */
-	if (ata_id_has_dword_io(dev->id) && (slop == 0 || slop == 3)) {
+	if (ata_id_has_dword_io(dev->id) && (slop == 0 || slop == 3)
+					&& (ap->pflags & ATA_PFLAG_PIO32)) {
 		struct ata_port *ap = dev->link->ap;
 		unsigned long flags;
 
@@ -736,7 +738,8 @@ static unsigned int vlb32_data_xfer(struct ata_device *adev, unsigned char *buf,
 	struct ata_port *ap = adev->link->ap;
 	int slop = buflen & 3;
 
-	if (ata_id_has_dword_io(adev->id) && (slop == 0 || slop == 3)) {
+	if (ata_id_has_dword_io(adev->id) && (slop == 0 || slop == 3)
+					&& (ap->pflags & ATA_PFLAG_PIO32)) {
 		if (rw == WRITE)
 			iowrite32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
 		else
@@ -858,27 +861,30 @@ static struct ata_port_operations winbond_port_ops = {
 
 static struct legacy_controller controllers[] = {
 	{"BIOS",	&legacy_port_ops, 	0x1F,
-						ATA_FLAG_NO_IORDY,	NULL },
+			ATA_FLAG_NO_IORDY,	0,			NULL },
 	{"Snooping", 	&simple_port_ops, 	0x1F,
-						0	       ,	NULL },
+			0,			0,			NULL },
 	{"PDC20230",	&pdc20230_port_ops,	0x7,
-						ATA_FLAG_NO_IORDY,	NULL },
+			ATA_FLAG_NO_IORDY,
+			ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32_CHANGE,	NULL },
 	{"HT6560A",	&ht6560a_port_ops,	0x07,
-						ATA_FLAG_NO_IORDY,	NULL },
+			ATA_FLAG_NO_IORDY,	0,			NULL },
 	{"HT6560B",	&ht6560b_port_ops,	0x1F,
-						ATA_FLAG_NO_IORDY,	NULL },
+			ATA_FLAG_NO_IORDY,	0,			NULL },
 	{"OPTI82C611A",	&opti82c611a_port_ops,	0x0F,
-						0	       ,	NULL },
+			0,			0,			NULL },
 	{"OPTI82C46X",	&opti82c46x_port_ops,	0x0F,
-						0	       ,	NULL },
+			0,			0,			NULL },
 	{"QDI6500",	&qdi6500_port_ops,	0x07,
-					ATA_FLAG_NO_IORDY,	qdi_port },
+			ATA_FLAG_NO_IORDY,
+			ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32_CHANGE,    qdi_port },
 	{"QDI6580",	&qdi6580_port_ops,	0x1F,
-					0	       ,	qdi_port },
+			0, ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32_CHANGE, qdi_port },
 	{"QDI6580DP",	&qdi6580dp_port_ops,	0x1F,
-					0	       ,	qdi_port },
+			0, ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32_CHANGE, qdi_port },
 	{"W83759A",	&winbond_port_ops,	0x1F,
-					0	       ,	winbond_port }
+			0, ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32_CHANGE,
+								winbond_port }
 };
 
 /**
@@ -1008,6 +1014,7 @@ static __init int legacy_init_one(struct legacy_probe *probe)
 	ap->ops = ops;
 	ap->pio_mask = pio_modes;
 	ap->flags |= ATA_FLAG_SLAVE_POSS | iordy;
+	ap->pflags |= controller->pflags;
 	ap->ioaddr.cmd_addr = io_addr;
 	ap->ioaddr.altstatus_addr = ctrl_addr;
 	ap->ioaddr.ctl_addr = ctrl_addr;
diff --git a/drivers/ata/pata_ninja32.c b/drivers/ata/pata_ninja32.c
index 0fb6b1b..dd53a66 100644
--- a/drivers/ata/pata_ninja32.c
+++ b/drivers/ata/pata_ninja32.c
@@ -44,7 +44,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_ninja32"
-#define DRV_VERSION "0.1.3"
+#define DRV_VERSION "0.1.5"
 
 
 /**
@@ -86,6 +86,7 @@ static struct ata_port_operations ninja32_port_ops = {
 	.sff_dev_select = ninja32_dev_select,
 	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= ninja32_set_piomode,
+	.sff_data_xfer	= ata_sff_data_xfer32
 };
 
 static void ninja32_program(void __iomem *base)
@@ -144,6 +145,7 @@ static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	ap->ioaddr.altstatus_addr = base + 0x1E;
 	ap->ioaddr.bmdma_addr = base;
 	ata_sff_std_ports(&ap->ioaddr);
+	ap->pflags = ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32CHANGE;
 
 	ninja32_program(base);
 	/* FIXME: Should we disable them at remove ? */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b450a26..3d501db 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -209,6 +209,7 @@ enum {
 
 	/* bits 24:31 of ap->flags are reserved for LLD specific flags */
 
+
 	/* struct ata_port pflags */
 	ATA_PFLAG_EH_PENDING	= (1 << 0), /* EH pending */
 	ATA_PFLAG_EH_IN_PROGRESS = (1 << 1), /* EH in progress */
@@ -225,6 +226,9 @@ enum {
 	ATA_PFLAG_PM_PENDING	= (1 << 18), /* PM operation pending */
 	ATA_PFLAG_INIT_GTM_VALID = (1 << 19), /* initial gtm data valid */
 
+	ATA_PFLAG_PIO32		= (1 << 20),  /* 32bit PIO */
+	ATA_PFLAG_PIO32CHANGE	= (1 << 21),  /* 32bit PIO can be turned on/off */
+
 	/* struct ata_queued_cmd flags */
 	ATA_QCFLAG_ACTIVE	= (1 << 0), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_DMAMAP	= (1 << 1), /* SG table is DMA mapped */
@@ -689,7 +693,10 @@ struct ata_port {
 	struct Scsi_Host	*scsi_host; /* our co-allocated scsi host */
 	struct ata_port_operations *ops;
 	spinlock_t		*lock;
+	/* Flags owned by the EH context. Only EH should touch these once the
+	   port is active */
 	unsigned long		flags;	/* ATA_FLAG_xxx */
+	/* Flags that change dynamically, protected by ap->lock */
 	unsigned int		pflags; /* ATA_PFLAG_xxx */
 	unsigned int		print_id; /* user visible unique port ID */
 	unsigned int		port_no; /* 0 based port no. inside the host */
@@ -1595,6 +1602,7 @@ extern void ata_sff_drain_fifo(struct ata_queued_cmd *qc);
 extern void ata_sff_error_handler(struct ata_port *ap);
 extern void ata_sff_post_internal_cmd(struct ata_queued_cmd *qc);
 extern int ata_sff_port_start(struct ata_port *ap);
+extern int ata_sff_port_start32(struct ata_port *ap);
 extern void ata_sff_std_ports(struct ata_ioports *ioaddr);
 extern unsigned long ata_bmdma_mode_filter(struct ata_device *dev,
 					   unsigned long xfer_mask);

