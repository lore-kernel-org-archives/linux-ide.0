From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCHES] 2.6.x libata update
Date: Thu, 16 Sep 2004 03:10:09 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040916071009.GA23725@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [69.28.190.101] ([69.28.190.101]:48308 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S267602AbUIPHKL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Sep 2004 03:10:11 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org



Please do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/ata_piix.c     |   26 +--
 drivers/scsi/libata-core.c  |  370 +++++++++++++++++++++++++++-----------------
 drivers/scsi/sata_nv.c      |   67 ++-----
 drivers/scsi/sata_promise.c |    9 -
 drivers/scsi/sata_sil.c     |   13 -
 drivers/scsi/sata_sis.c     |   59 ++-----
 drivers/scsi/sata_svw.c     |   75 ++++++++
 drivers/scsi/sata_sx4.c     |   11 -
 drivers/scsi/sata_via.c     |   54 ++----
 drivers/scsi/sata_vsc.c     |    9 -
 include/linux/libata.h      |   27 +--
 11 files changed, 418 insertions(+), 302 deletions(-)

through these ChangeSets:

<jgarzik@pobox.com> (04/09/16 1.1903)
   [libata] add hook, and export functions needed for sata2 drivers
   
   * add dev_select hook, and default/noop implementations
   * export ata_dev_classify
   * fix a couple bugs that cropped up when building with
     ATA_VERBOSE_DEBUG
   * export __sata_phy_reset, a variant that does not call
     ata_bus_reset

<ananth@broadcom.com> (04/09/14 1.1867.6.5)
   [libata sata_svw] race condition fix, new device support
   
   * address race condition WRT order of DMA-start and ATA command issue
     (see code comment for more details)
   
   * Add support for Frodo 4/8

<jgarzik@pobox.com> (04/09/14 1.1867.6.4)
   [libata] minor comment updates, preparing for iomap merge

<jgarzik@pobox.com> (04/09/13 1.1867.6.3)
   [libata] consolidate legacy/native mode init code into helpers
   
   Eliminates duplicate code in sata_nv, sata_sis, and sata_via.

<jgarzik@pobox.com> (04/09/13 1.1867.6.2)
   [libata] remove distinction between MMIO/PIO helper functions
   
   Prepare for use of new generic iomap API.

<jgarzik@pobox.com> (04/09/13 1.1867.6.1)
   [libata sata_nv] sync with 2.4
   
   Driver should be using LIBATA_MAX_PRD not ATA_MAX_PRD,
   due to iommu layer splitting.

diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c	2004-09-16 03:05:09 -04:00
+++ b/drivers/scsi/ata_piix.c	2004-09-16 03:05:09 -04:00
@@ -125,15 +125,16 @@
 	.set_piomode		= piix_set_piomode,
 	.set_dmamode		= piix_set_dmamode,
 
-	.tf_load		= ata_tf_load_pio,
-	.tf_read		= ata_tf_read_pio,
-	.check_status		= ata_check_status_pio,
-	.exec_command		= ata_exec_command_pio,
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
 
 	.phy_reset		= piix_pata_phy_reset,
 
-	.bmdma_setup		= ata_bmdma_setup_pio,
-	.bmdma_start		= ata_bmdma_start_pio,
+	.bmdma_setup		= ata_bmdma_setup,
+	.bmdma_start		= ata_bmdma_start,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
@@ -149,15 +150,16 @@
 static struct ata_port_operations piix_sata_ops = {
 	.port_disable		= ata_port_disable,
 
-	.tf_load		= ata_tf_load_pio,
-	.tf_read		= ata_tf_read_pio,
-	.check_status		= ata_check_status_pio,
-	.exec_command		= ata_exec_command_pio,
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
 
 	.phy_reset		= piix_sata_phy_reset,
 
-	.bmdma_setup		= ata_bmdma_setup_pio,
-	.bmdma_start		= ata_bmdma_start_pio,
+	.bmdma_setup		= ata_bmdma_setup,
+	.bmdma_start		= ata_bmdma_start,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-09-16 03:05:09 -04:00
+++ b/drivers/scsi/libata-core.c	2004-09-16 03:05:09 -04:00
@@ -50,7 +50,6 @@
 static unsigned int ata_busy_sleep (struct ata_port *ap,
 				    unsigned long tmout_pat,
 			    	    unsigned long tmout);
-static void __ata_dev_select (struct ata_port *ap, unsigned int device);
 static void ata_set_mode(struct ata_port *ap);
 static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev);
 static unsigned int ata_get_mode_mask(struct ata_port *ap, int shift);
@@ -68,17 +67,17 @@
 MODULE_LICENSE("GPL");
 
 /**
- *	ata_tf_load_pio - send taskfile registers to host controller
+ *	ata_tf_load - send taskfile registers to host controller
  *	@ap: Port to which output is sent
  *	@tf: ATA taskfile register set
  *
- *	Outputs ATA taskfile to standard ATA host controller using PIO.
+ *	Outputs ATA taskfile to standard ATA host controller.
  *
  *	LOCKING:
  *	Inherited from caller.
  */
 
-void ata_tf_load_pio(struct ata_port *ap, struct ata_taskfile *tf)
+static void ata_tf_load_pio(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
@@ -136,7 +135,7 @@
  *	Inherited from caller.
  */
 
-void ata_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf)
+static void ata_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
@@ -183,19 +182,27 @@
 	ata_wait_idle(ap);
 }
 
+void ata_tf_load(struct ata_port *ap, struct ata_taskfile *tf)
+{
+	if (ap->flags & ATA_FLAG_MMIO)
+		ata_tf_load_mmio(ap, tf);
+	else
+		ata_tf_load_pio(ap, tf);
+}
+
 /**
- *	ata_exec_command_pio - issue ATA command to host controller
+ *	ata_exec_command - issue ATA command to host controller
  *	@ap: port to which command is being issued
  *	@tf: ATA taskfile register set
  *
- *	Issues PIO write to ATA command register, with proper
+ *	Issues PIO/MMIO write to ATA command register, with proper
  *	synchronization with interrupt handler / other threads.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_exec_command_pio(struct ata_port *ap, struct ata_taskfile *tf)
+static void ata_exec_command_pio(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	DPRINTK("ata%u: cmd 0x%X\n", ap->id, tf->command);
 
@@ -216,7 +223,7 @@
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf)
+static void ata_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	DPRINTK("ata%u: cmd 0x%X\n", ap->id, tf->command);
 
@@ -224,12 +231,20 @@
 	ata_pause(ap);
 }
 
+void ata_exec_command(struct ata_port *ap, struct ata_taskfile *tf)
+{
+	if (ap->flags & ATA_FLAG_MMIO)
+		ata_exec_command_mmio(ap, tf);
+	else
+		ata_exec_command_pio(ap, tf);
+}
+
 /**
  *	ata_exec - issue ATA command to host controller
  *	@ap: port to which command is being issued
  *	@tf: ATA taskfile register set
  *
- *	Issues PIO write to ATA command register, with proper
+ *	Issues PIO/MMIO write to ATA command register, with proper
  *	synchronization with interrupt handler / other threads.
  *
  *	LOCKING:
@@ -252,7 +267,7 @@
  *	@tf: ATA taskfile register set
  *
  *	Issues ATA taskfile register set to ATA host controller,
- *	via PIO, with proper synchronization with interrupt handler and
+ *	with proper synchronization with interrupt handler and
  *	other threads.
  *
  *	LOCKING:
@@ -272,7 +287,7 @@
  *	@tf: ATA taskfile register set
  *
  *	Issues ATA taskfile register set to ATA host controller,
- *	via PIO, with proper synchronization with interrupt handler and
+ *	with proper synchronization with interrupt handler and
  *	other threads.
  *
  *	LOCKING:
@@ -286,18 +301,18 @@
 }
 
 /**
- *	ata_tf_read_pio - input device's ATA taskfile shadow registers
+ *	ata_tf_read - input device's ATA taskfile shadow registers
  *	@ap: Port from which input is read
  *	@tf: ATA taskfile register set for storing input
  *
  *	Reads ATA taskfile registers for currently-selected device
- *	into @tf via PIO.
+ *	into @tf.
  *
  *	LOCKING:
  *	Inherited from caller.
  */
 
-void ata_tf_read_pio(struct ata_port *ap, struct ata_taskfile *tf)
+static void ata_tf_read_pio(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
@@ -329,7 +344,7 @@
  *	Inherited from caller.
  */
 
-void ata_tf_read_mmio(struct ata_port *ap, struct ata_taskfile *tf)
+static void ata_tf_read_mmio(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
@@ -349,18 +364,26 @@
 	}
 }
 
+void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
+{
+	if (ap->flags & ATA_FLAG_MMIO)
+		ata_tf_read_mmio(ap, tf);
+	else
+		ata_tf_read_pio(ap, tf);
+}
+
 /**
- *	ata_check_status_pio - Read device status reg & clear interrupt
+ *	ata_check_status - Read device status reg & clear interrupt
  *	@ap: port where the device is
  *
  *	Reads ATA taskfile status register for currently-selected device
- *	via PIO and return it's value. This also clears pending interrupts
+ *	and return it's value. This also clears pending interrupts
  *      from this device
  *
  *	LOCKING:
  *	Inherited from caller.
  */
-u8 ata_check_status_pio(struct ata_port *ap)
+static u8 ata_check_status_pio(struct ata_port *ap)
 {
 	return inb(ap->ioaddr.status_addr);
 }
@@ -376,11 +399,18 @@
  *	LOCKING:
  *	Inherited from caller.
  */
-u8 ata_check_status_mmio(struct ata_port *ap)
+static u8 ata_check_status_mmio(struct ata_port *ap)
 {
        	return readb((void __iomem *) ap->ioaddr.status_addr);
 }
 
+u8 ata_check_status(struct ata_port *ap)
+{
+	if (ap->flags & ATA_FLAG_MMIO)
+		return ata_check_status_mmio(ap);
+	return ata_check_status_pio(ap);
+}
+
 /**
  *	ata_tf_to_fis - Convert ATA taskfile to SATA FIS structure
  *	@tf: Taskfile to convert
@@ -606,7 +636,7 @@
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	u8 nsect, lbal;
 
-	__ata_dev_select(ap, device);
+	ap->ops->dev_select(ap, device);
 
 	outb(0x55, ioaddr->nsect_addr);
 	outb(0xaa, ioaddr->lbal_addr);
@@ -650,7 +680,7 @@
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	u8 nsect, lbal;
 
-	__ata_dev_select(ap, device);
+	ap->ops->dev_select(ap, device);
 
 	writeb(0x55, (void __iomem *) ioaddr->nsect_addr);
 	writeb(0xaa, (void __iomem *) ioaddr->lbal_addr);
@@ -671,7 +701,7 @@
 }
 
 /**
- *	ata_dev_devchk - PATA device presence detection
+ *	ata_devchk - PATA device presence detection
  *	@ap: ATA channel to examine
  *	@device: Device to examine (starting at zero)
  *
@@ -683,7 +713,7 @@
  *	caller.
  */
 
-static unsigned int ata_dev_devchk(struct ata_port *ap,
+static unsigned int ata_devchk(struct ata_port *ap,
 				    unsigned int device)
 {
 	if (ap->flags & ATA_FLAG_MMIO)
@@ -707,7 +737,7 @@
  *	the event of failure.
  */
 
-static unsigned int ata_dev_classify(struct ata_taskfile *tf)
+unsigned int ata_dev_classify(struct ata_taskfile *tf)
 {
 	/* Apple's open source Darwin code hints that some devices only
 	 * put a proper signature into the LBA mid/high registers,
@@ -755,7 +785,7 @@
 	unsigned int class;
 	u8 err;
 
-	__ata_dev_select(ap, device);
+	ap->ops->dev_select(ap, device);
 
 	memset(&tf, 0, sizeof(tf));
 
@@ -818,8 +848,12 @@
 	}
 }
 
+void ata_noop_dev_select (struct ata_port *ap, unsigned int device)
+{
+}
+
 /**
- *	__ata_dev_select - Select device 0/1 on ATA bus
+ *	ata_std_dev_select - Select device 0/1 on ATA bus
  *	@ap: ATA channel to manipulate
  *	@device: ATA device (numbered from zero) to select
  *
@@ -831,7 +865,7 @@
  *	caller.
  */
 
-static void __ata_dev_select (struct ata_port *ap, unsigned int device)
+void ata_std_dev_select (struct ata_port *ap, unsigned int device)
 {
 	u8 tmp;
 
@@ -859,7 +893,7 @@
  *	make either device 0, or device 1, active on the
  *	ATA channel.
  *
- *	This is a high-level version of __ata_dev_select(),
+ *	This is a high-level version of ata_std_dev_select(),
  *	which additionally provides the services of inserting
  *	the proper pauses and status polling, where needed.
  *
@@ -876,7 +910,7 @@
 	if (wait)
 		ata_wait_idle(ap);
 
-	__ata_dev_select(ap, device);
+	ap->ops->dev_select(ap, device);
 
 	if (wait) {
 		if (can_sleep && ap->device[device].class == ATA_DEV_ATAPI)
@@ -1183,13 +1217,13 @@
 }
 
 /**
- *	sata_phy_reset -
+ *	__sata_phy_reset -
  *	@ap:
  *
  *	LOCKING:
  *
  */
-void sata_phy_reset(struct ata_port *ap)
+void __sata_phy_reset(struct ata_port *ap)
 {
 	u32 sstatus;
 	unsigned long timeout = jiffies + (HZ * 5);
@@ -1227,6 +1261,21 @@
 		return;
 	}
 
+	ap->cbl = ATA_CBL_SATA;
+}
+
+/**
+ *	__sata_phy_reset -
+ *	@ap:
+ *
+ *	LOCKING:
+ *
+ */
+void sata_phy_reset(struct ata_port *ap)
+{
+	__sata_phy_reset(ap);
+	if (ap->flags & ATA_FLAG_PORT_DISABLED)
+		return;
 	ata_bus_reset(ap);
 }
 
@@ -1439,20 +1488,20 @@
 	unsigned int dev1 = devmask & (1 << 1);
 	unsigned long timeout;
 
-	/* if device 0 was found in ata_dev_devchk, wait for its
+	/* if device 0 was found in ata_devchk, wait for its
 	 * BSY bit to clear
 	 */
 	if (dev0)
 		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
 
-	/* if device 1 was found in ata_dev_devchk, wait for
+	/* if device 1 was found in ata_devchk, wait for
 	 * register access, then wait for BSY to clear
 	 */
 	timeout = jiffies + ATA_TMOUT_BOOT;
 	while (dev1) {
 		u8 nsect, lbal;
 
-		__ata_dev_select(ap, 1);
+		ap->ops->dev_select(ap, 1);
 		if (ap->flags & ATA_FLAG_MMIO) {
 			nsect = readb((void __iomem *) ioaddr->nsect_addr);
 			lbal = readb((void __iomem *) ioaddr->lbal_addr);
@@ -1472,11 +1521,11 @@
 		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
 
 	/* is all this really necessary? */
-	__ata_dev_select(ap, 0);
+	ap->ops->dev_select(ap, 0);
 	if (dev1)
-		__ata_dev_select(ap, 1);
+		ap->ops->dev_select(ap, 1);
 	if (dev0)
-		__ata_dev_select(ap, 0);
+		ap->ops->dev_select(ap, 0);
 }
 
 /**
@@ -1580,9 +1629,9 @@
 	if (ap->flags & ATA_FLAG_SATA_RESET)
 		dev0 = 1;
 	else {
-		dev0 = ata_dev_devchk(ap, 0);
+		dev0 = ata_devchk(ap, 0);
 		if (slave_possible)
-			dev1 = ata_dev_devchk(ap, 1);
+			dev1 = ata_devchk(ap, 1);
 	}
 
 	if (dev0)
@@ -1591,7 +1640,7 @@
 		devmask |= (1 << 1);
 
 	/* select device 0 again */
-	__ata_dev_select(ap, 0);
+	ap->ops->dev_select(ap, 0);
 
 	/* issue bus reset */
 	if (ap->flags & ATA_FLAG_SRST)
@@ -1620,9 +1669,9 @@
 
 	/* is double-select really necessary? */
 	if (ap->device[1].class != ATA_DEV_NONE)
-		__ata_dev_select(ap, 1);
+		ap->ops->dev_select(ap, 1);
 	if (ap->device[0].class != ATA_DEV_NONE)
-		__ata_dev_select(ap, 0);
+		ap->ops->dev_select(ap, 0);
 
 	/* if no devices were detected, disable this port */
 	if ((ap->device[0].class == ATA_DEV_NONE) &&
@@ -2135,9 +2184,7 @@
 		qc->cursg_ofs = 0;
 	}
 
-	DPRINTK("data %s, drv_stat 0x%X\n",
-		qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read",
-		status);
+	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
 
 	/* do the actual data transfer */
 	do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
@@ -2162,7 +2209,7 @@
 	/* shall be cleared to zero, indicating xfer of data */
 	if (ireason & (1 << 0))
 		goto err_out;
-	
+
 	/* make sure transfer direction matches expected */
 	i_write = ((ireason & (1 << 1)) == 0) ? 1 : 0;
 	if (do_write != i_write)
@@ -2178,7 +2225,7 @@
 
 	for (i = 0; i < (bytes >> 9); i++)
 		ata_pio_sector(qc);
-	
+
 	return;
 
 err_out:
@@ -2606,14 +2653,14 @@
 }
 
 /**
- *	ata_bmdma_setup_mmio - Set up PCI IDE BMDMA transaction (MMIO)
+ *	ata_bmdma_setup - Set up PCI IDE BMDMA transaction
  *	@qc: Info associated with this ATA transaction.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_bmdma_setup_mmio (struct ata_queued_cmd *qc)
+static void ata_bmdma_setup_mmio (struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
@@ -2636,14 +2683,14 @@
 }
 
 /**
- *	ata_bmdma_start_mmio - Start a PCI IDE BMDMA transaction (MMIO)
+ *	ata_bmdma_start - Start a PCI IDE BMDMA transaction
  *	@qc: Info associated with this ATA transaction.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_bmdma_start_mmio (struct ata_queued_cmd *qc)
+static void ata_bmdma_start_mmio (struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
@@ -2674,7 +2721,7 @@
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_bmdma_setup_pio (struct ata_queued_cmd *qc)
+static void ata_bmdma_setup_pio (struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
@@ -2702,7 +2749,7 @@
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_bmdma_start_pio (struct ata_queued_cmd *qc)
+static void ata_bmdma_start_pio (struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	u8 dmactl;
@@ -2713,6 +2760,22 @@
 	     ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 }
 
+void ata_bmdma_start(struct ata_queued_cmd *qc)
+{
+	if (qc->ap->flags & ATA_FLAG_MMIO)
+		ata_bmdma_start_mmio(qc);
+	else
+		ata_bmdma_start_pio(qc);
+}
+
+void ata_bmdma_setup(struct ata_queued_cmd *qc)
+{
+	if (qc->ap->flags & ATA_FLAG_MMIO)
+		ata_bmdma_setup_mmio(qc);
+	else
+		ata_bmdma_setup_pio(qc);
+}
+
 void ata_bmdma_irq_clear(struct ata_port *ap)
 {
 	ata_bmdma_ack_irq(ap);
@@ -3205,6 +3268,95 @@
 	ioaddr->command_addr = ioaddr->cmd_addr + ATA_REG_CMD;
 }
 
+static struct ata_probe_ent *
+ata_probe_ent_alloc(int n, struct pci_dev *pdev, struct ata_port_info **port)
+{
+	struct ata_probe_ent *probe_ent;
+	int i;
+
+	probe_ent = kmalloc(sizeof(*probe_ent) * n, GFP_KERNEL);
+	if (!probe_ent) {
+		printk(KERN_ERR DRV_NAME "(%s): out of memory\n",
+		       pci_name(pdev));
+		return NULL;
+	}
+
+	memset(probe_ent, 0, sizeof(*probe_ent) * n);
+
+	for (i = 0; i < n; i++) {
+		INIT_LIST_HEAD(&probe_ent[i].node);
+		probe_ent[i].pdev = pdev;
+
+		probe_ent[i].sht = port[i]->sht;
+		probe_ent[i].host_flags = port[i]->host_flags;
+		probe_ent[i].pio_mask = port[i]->pio_mask;
+		probe_ent[i].mwdma_mask = port[i]->mwdma_mask;
+		probe_ent[i].udma_mask = port[i]->udma_mask;
+		probe_ent[i].port_ops = port[i]->port_ops;
+
+	}
+
+	return probe_ent;
+}
+
+struct ata_probe_ent *
+ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port)
+{
+	struct ata_probe_ent *probe_ent = ata_probe_ent_alloc(1, pdev, port);
+	if (!probe_ent)
+		return NULL;
+
+	probe_ent->n_ports = 2;
+	probe_ent->irq = pdev->irq;
+	probe_ent->irq_flags = SA_SHIRQ;
+
+	probe_ent->port[0].cmd_addr = pci_resource_start(pdev, 0);
+	probe_ent->port[0].altstatus_addr =
+	probe_ent->port[0].ctl_addr =
+		pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
+	probe_ent->port[0].bmdma_addr = pci_resource_start(pdev, 4);
+
+	probe_ent->port[1].cmd_addr = pci_resource_start(pdev, 2);
+	probe_ent->port[1].altstatus_addr =
+	probe_ent->port[1].ctl_addr =
+		pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
+	probe_ent->port[1].bmdma_addr = pci_resource_start(pdev, 4) + 8;
+
+	ata_std_ports(&probe_ent->port[0]);
+	ata_std_ports(&probe_ent->port[1]);
+
+	return probe_ent;
+}
+
+struct ata_probe_ent *
+ata_pci_init_legacy_mode(struct pci_dev *pdev, struct ata_port_info **port)
+{
+	struct ata_probe_ent *probe_ent = ata_probe_ent_alloc(2, pdev, port);
+	if (!probe_ent)
+		return NULL;
+
+	probe_ent[0].n_ports = 1;
+	probe_ent[0].irq = 14;
+
+	probe_ent[1].n_ports = 1;
+	probe_ent[1].irq = 15;
+
+	probe_ent[0].port[0].cmd_addr = 0x1f0;
+	probe_ent[0].port[0].altstatus_addr =
+	probe_ent[0].port[0].ctl_addr = 0x3f6;
+	probe_ent[0].port[0].bmdma_addr = pci_resource_start(pdev, 4);
+
+	probe_ent[1].port[0].cmd_addr = 0x170;
+	probe_ent[1].port[0].altstatus_addr =
+	probe_ent[1].port[0].ctl_addr = 0x376;
+	probe_ent[1].port[0].bmdma_addr = pci_resource_start(pdev, 4)+8;
+
+	ata_std_ports(&probe_ent[0].port[0]);
+	ata_std_ports(&probe_ent[1].port[0]);
+
+	return probe_ent;
+}
+
 /**
  *	ata_pci_init_one - Initialize/register PCI IDE host controller
  *	@pdev: Controller to be initialized
@@ -3222,20 +3374,20 @@
 		      unsigned int n_ports)
 {
 	struct ata_probe_ent *probe_ent, *probe_ent2 = NULL;
-	struct ata_port_info *port0, *port1;
+	struct ata_port_info *port[2];
 	u8 tmp8, mask;
 	unsigned int legacy_mode = 0;
 	int rc;
 
 	DPRINTK("ENTER\n");
 
-	port0 = port_info[0];
+	port[0] = port_info[0];
 	if (n_ports > 1)
-		port1 = port_info[1];
+		port[1] = port_info[1];
 	else
-		port1 = port0;
+		port[1] = port[0];
 
-	if ((port0->host_flags & ATA_FLAG_NO_LEGACY) == 0) {
+	if ((port[0]->host_flags & ATA_FLAG_NO_LEGACY) == 0) {
 		/* TODO: support transitioning to native mode? */
 		pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
 		mask = (1 << 2) | (1 << 0);
@@ -3296,77 +3448,17 @@
 	if (rc)
 		goto err_out_regions;
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	if (legacy_mode) {
+		probe_ent = ata_pci_init_legacy_mode(pdev, port);
+		if (probe_ent)
+			probe_ent2 = &probe_ent[1];
+	} else
+		probe_ent = ata_pci_init_native_mode(pdev, port);
 	if (!probe_ent) {
 		rc = -ENOMEM;
 		goto err_out_regions;
 	}
 
-	memset(probe_ent, 0, sizeof(*probe_ent));
-	probe_ent->pdev = pdev;
-	INIT_LIST_HEAD(&probe_ent->node);
-
-	if (legacy_mode) {
-		probe_ent2 = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
-		if (!probe_ent2) {
-			rc = -ENOMEM;
-			goto err_out_free_ent;
-		}
-
-		memset(probe_ent2, 0, sizeof(*probe_ent));
-		probe_ent2->pdev = pdev;
-		INIT_LIST_HEAD(&probe_ent2->node);
-	}
-
-	probe_ent->port[0].bmdma_addr = pci_resource_start(pdev, 4);
-	probe_ent->sht = port0->sht;
-	probe_ent->host_flags = port0->host_flags;
-	probe_ent->pio_mask = port0->pio_mask;
-	probe_ent->mwdma_mask = port0->mwdma_mask;
-	probe_ent->udma_mask = port0->udma_mask;
-	probe_ent->port_ops = port0->port_ops;
-
-	if (legacy_mode) {
-		probe_ent->port[0].cmd_addr = 0x1f0;
-		probe_ent->port[0].altstatus_addr =
-		probe_ent->port[0].ctl_addr = 0x3f6;
-		probe_ent->n_ports = 1;
-		probe_ent->irq = 14;
-		ata_std_ports(&probe_ent->port[0]);
-
-		probe_ent2->port[0].cmd_addr = 0x170;
-		probe_ent2->port[0].altstatus_addr =
-		probe_ent2->port[0].ctl_addr = 0x376;
-		probe_ent2->port[0].bmdma_addr = pci_resource_start(pdev, 4)+8;
-		probe_ent2->n_ports = 1;
-		probe_ent2->irq = 15;
-		ata_std_ports(&probe_ent2->port[0]);
-
-		probe_ent2->sht = port1->sht;
-		probe_ent2->host_flags = port1->host_flags;
-		probe_ent2->pio_mask = port1->pio_mask;
-		probe_ent2->mwdma_mask = port1->mwdma_mask;
-		probe_ent2->udma_mask = port1->udma_mask;
-		probe_ent2->port_ops = port1->port_ops;
-	} else {
-		probe_ent->port[0].cmd_addr = pci_resource_start(pdev, 0);
-		ata_std_ports(&probe_ent->port[0]);
-		probe_ent->port[0].altstatus_addr =
-		probe_ent->port[0].ctl_addr =
-			pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
-
-		probe_ent->port[1].cmd_addr = pci_resource_start(pdev, 2);
-		ata_std_ports(&probe_ent->port[1]);
-		probe_ent->port[1].altstatus_addr =
-		probe_ent->port[1].ctl_addr =
-			pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
-		probe_ent->port[1].bmdma_addr = pci_resource_start(pdev, 4) + 8;
-
-		probe_ent->n_ports = 2;
-		probe_ent->irq = pdev->irq;
-		probe_ent->irq_flags = SA_SHIRQ;
-	}
-
 	pci_set_master(pdev);
 
 	/* FIXME: check ata_device_add return */
@@ -3375,17 +3467,13 @@
 			ata_device_add(probe_ent);
 		if (legacy_mode & (1 << 1))
 			ata_device_add(probe_ent2);
-		kfree(probe_ent2);
 	} else {
 		ata_device_add(probe_ent);
-		assert(probe_ent2 == NULL);
 	}
 	kfree(probe_ent);
 
 	return 0;
 
-err_out_free_ent:
-	kfree(probe_ent);
 err_out_regions:
 	if (legacy_mode & (1 << 0))
 		release_region(0x1f0, 8);
@@ -3535,27 +3623,26 @@
 EXPORT_SYMBOL_GPL(ata_qc_complete);
 EXPORT_SYMBOL_GPL(ata_qc_issue_prot);
 EXPORT_SYMBOL_GPL(ata_eng_timeout);
-EXPORT_SYMBOL_GPL(ata_tf_load_pio);
-EXPORT_SYMBOL_GPL(ata_tf_load_mmio);
-EXPORT_SYMBOL_GPL(ata_tf_read_pio);
-EXPORT_SYMBOL_GPL(ata_tf_read_mmio);
+EXPORT_SYMBOL_GPL(ata_tf_load);
+EXPORT_SYMBOL_GPL(ata_tf_read);
+EXPORT_SYMBOL_GPL(ata_noop_dev_select);
+EXPORT_SYMBOL_GPL(ata_std_dev_select);
 EXPORT_SYMBOL_GPL(ata_tf_to_fis);
 EXPORT_SYMBOL_GPL(ata_tf_from_fis);
-EXPORT_SYMBOL_GPL(ata_check_status_pio);
-EXPORT_SYMBOL_GPL(ata_check_status_mmio);
-EXPORT_SYMBOL_GPL(ata_exec_command_pio);
-EXPORT_SYMBOL_GPL(ata_exec_command_mmio);
+EXPORT_SYMBOL_GPL(ata_pci_init_legacy_mode);
+EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
+EXPORT_SYMBOL_GPL(ata_check_status);
+EXPORT_SYMBOL_GPL(ata_exec_command);
 EXPORT_SYMBOL_GPL(ata_port_start);
 EXPORT_SYMBOL_GPL(ata_port_stop);
 EXPORT_SYMBOL_GPL(ata_interrupt);
 EXPORT_SYMBOL_GPL(ata_qc_prep);
-EXPORT_SYMBOL_GPL(ata_bmdma_setup_pio);
-EXPORT_SYMBOL_GPL(ata_bmdma_start_pio);
-EXPORT_SYMBOL_GPL(ata_bmdma_setup_mmio);
-EXPORT_SYMBOL_GPL(ata_bmdma_start_mmio);
+EXPORT_SYMBOL_GPL(ata_bmdma_setup);
+EXPORT_SYMBOL_GPL(ata_bmdma_start);
 EXPORT_SYMBOL_GPL(ata_bmdma_irq_clear);
 EXPORT_SYMBOL_GPL(ata_port_probe);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
+EXPORT_SYMBOL_GPL(__sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
 EXPORT_SYMBOL_GPL(ata_port_disable);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
@@ -3566,4 +3653,5 @@
 EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
 EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
+EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_id_string);
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2004-09-16 03:05:09 -04:00
+++ b/drivers/scsi/sata_nv.c	2004-09-16 03:05:09 -04:00
@@ -50,8 +50,6 @@
 #define NV_PIO_MASK			0x1f
 #define NV_MWDMA_MASK			0x07
 #define NV_UDMA_MASK			0x7f
-#define NV_PORT0_BMDMA_REG_OFFSET	0x00
-#define NV_PORT1_BMDMA_REG_OFFSET	0x08
 #define NV_PORT0_SCR_REG_OFFSET		0x00
 #define NV_PORT1_SCR_REG_OFFSET		0x40
 
@@ -187,7 +185,7 @@
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= ATA_MAX_PRD,
+	.sg_tablesize		= LIBATA_MAX_PRD,
 	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
@@ -200,13 +198,14 @@
 
 static struct ata_port_operations nv_ops = {
 	.port_disable		= ata_port_disable,
-	.tf_load		= ata_tf_load_pio,
-	.tf_read		= ata_tf_read_pio,
-	.exec_command		= ata_exec_command_pio,
-	.check_status		= ata_check_status_pio,
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.exec_command		= ata_exec_command,
+	.check_status		= ata_check_status,
+	.dev_select		= ata_std_dev_select,
 	.phy_reset		= sata_phy_reset,
-	.bmdma_setup		= ata_bmdma_setup_pio,
-	.bmdma_start		= ata_bmdma_start_pio,
+	.bmdma_setup		= ata_bmdma_setup,
+	.bmdma_start		= ata_bmdma_start,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
@@ -219,6 +218,18 @@
 	.host_stop		= nv_host_stop,
 };
 
+static struct ata_port_info nv_port_info = {
+	.sht		= &nv_sht,
+	.host_flags	= ATA_FLAG_SATA |
+			  ATA_FLAG_SATA_RESET |
+			  ATA_FLAG_SRST |
+			  ATA_FLAG_NO_LEGACY,
+	.pio_mask	= NV_PIO_MASK,
+	.mwdma_mask	= NV_MWDMA_MASK,
+	.udma_mask	= NV_UDMA_MASK,
+	.port_ops	= &nv_ops,
+};
+
 MODULE_AUTHOR("NVIDIA");
 MODULE_DESCRIPTION("low-level driver for NVIDIA nForce SATA controller");
 MODULE_LICENSE("GPL");
@@ -299,6 +310,7 @@
 {
 	static int printed_version = 0;
 	struct nv_host *host;
+	struct ata_port_info *ppi;
 	struct ata_probe_ent *probe_ent = NULL;
 	int rc;
 
@@ -320,7 +332,8 @@
 	if (rc)
 		goto err_out_regions;
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	ppi = &nv_port_info;
+	probe_ent = ata_pci_init_native_mode(pdev, &ppi);
 	if (!probe_ent) {
 		rc = -ENOMEM;
 		goto err_out_regions;
@@ -333,40 +346,6 @@
 	}
 
 	host->host_desc = &nv_device_tbl[ent->driver_data];
-
-	memset(probe_ent, 0, sizeof(*probe_ent));
-	INIT_LIST_HEAD(&probe_ent->node);
-
-	probe_ent->pdev = pdev;
-	probe_ent->sht = &nv_sht;
-	probe_ent->host_flags = ATA_FLAG_SATA |
-				ATA_FLAG_SATA_RESET |
-				ATA_FLAG_SRST |
-				ATA_FLAG_NO_LEGACY;
-
-	probe_ent->port_ops = &nv_ops;
-	probe_ent->n_ports = NV_PORTS;
-	probe_ent->irq = pdev->irq;
-	probe_ent->irq_flags = SA_SHIRQ;
-	probe_ent->pio_mask = NV_PIO_MASK;
-	probe_ent->mwdma_mask = NV_MWDMA_MASK;
-	probe_ent->udma_mask = NV_UDMA_MASK;
-
-	probe_ent->port[0].cmd_addr = pci_resource_start(pdev, 0);
-	ata_std_ports(&probe_ent->port[0]);
-	probe_ent->port[0].altstatus_addr =
-	probe_ent->port[0].ctl_addr =
-		pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
-	probe_ent->port[0].bmdma_addr =
-		pci_resource_start(pdev, 4) | NV_PORT0_BMDMA_REG_OFFSET;
-
-	probe_ent->port[1].cmd_addr = pci_resource_start(pdev, 2);
-	ata_std_ports(&probe_ent->port[1]);
-	probe_ent->port[1].altstatus_addr =
-	probe_ent->port[1].ctl_addr =
-		pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
-	probe_ent->port[1].bmdma_addr =
-		pci_resource_start(pdev, 4) | NV_PORT1_BMDMA_REG_OFFSET;
 
 	probe_ent->private_data = host;
 
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	2004-09-16 03:05:09 -04:00
+++ b/drivers/scsi/sata_promise.c	2004-09-16 03:05:09 -04:00
@@ -107,9 +107,10 @@
 static struct ata_port_operations pdc_sata_ops = {
 	.port_disable		= ata_port_disable,
 	.tf_load		= pdc_tf_load_mmio,
-	.tf_read		= ata_tf_read_mmio,
-	.check_status		= ata_check_status_mmio,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
 	.exec_command		= pdc_exec_command_mmio,
+	.dev_select		= ata_std_dev_select,
 	.phy_reset		= pdc_phy_reset,
 	.qc_prep		= pdc_qc_prep,
 	.qc_issue		= pdc_qc_issue_prot,
@@ -468,7 +469,7 @@
 {
 	WARN_ON (tf->protocol == ATA_PROT_DMA ||
 		 tf->protocol == ATA_PROT_NODATA);
-	ata_tf_load_mmio(ap, tf);
+	ata_tf_load(ap, tf);
 }
 
 
@@ -476,7 +477,7 @@
 {
 	WARN_ON (tf->protocol == ATA_PROT_DMA ||
 		 tf->protocol == ATA_PROT_NODATA);
-	ata_exec_command_mmio(ap, tf);
+	ata_exec_command(ap, tf);
 }
 
 
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2004-09-16 03:05:09 -04:00
+++ b/drivers/scsi/sata_sil.c	2004-09-16 03:05:09 -04:00
@@ -125,14 +125,15 @@
 static struct ata_port_operations sil_ops = {
 	.port_disable		= ata_port_disable,
 	.dev_config		= sil_dev_config,
-	.tf_load		= ata_tf_load_mmio,
-	.tf_read		= ata_tf_read_mmio,
-	.check_status		= ata_check_status_mmio,
-	.exec_command		= ata_exec_command_mmio,
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
 	.phy_reset		= sata_phy_reset,
 	.post_set_mode		= sil_post_set_mode,
-	.bmdma_setup            = ata_bmdma_setup_mmio,
-	.bmdma_start            = ata_bmdma_start_mmio,
+	.bmdma_setup            = ata_bmdma_setup,
+	.bmdma_start            = ata_bmdma_start,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
diff -Nru a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c	2004-09-16 03:05:09 -04:00
+++ b/drivers/scsi/sata_sis.c	2004-09-16 03:05:09 -04:00
@@ -94,13 +94,14 @@
 
 static struct ata_port_operations sis_ops = {
 	.port_disable		= ata_port_disable,
-	.tf_load		= ata_tf_load_pio,
-	.tf_read		= ata_tf_read_pio,
-	.check_status		= ata_check_status_pio,
-	.exec_command		= ata_exec_command_pio,
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
 	.phy_reset		= sata_phy_reset,
-	.bmdma_setup            = ata_bmdma_setup_pio,
-	.bmdma_start            = ata_bmdma_start_pio,
+	.bmdma_setup            = ata_bmdma_setup,
+	.bmdma_start            = ata_bmdma_start,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
@@ -112,6 +113,16 @@
 	.port_stop		= ata_port_stop,
 };
 
+static struct ata_port_info sis_port_info = {
+	.sht		= &sis_sht,
+	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
+			  ATA_FLAG_NO_LEGACY,
+	.pio_mask	= 0x1f,
+	.mwdma_mask	= 0x7,
+	.udma_mask	= 0x7f,
+	.port_ops	= &sis_ops,
+};
+
 
 MODULE_AUTHOR("Uwe Koziolek");
 MODULE_DESCRIPTION("low-level driver for Silicon Integratad Systems SATA controller");
@@ -185,6 +196,7 @@
 	struct ata_probe_ent *probe_ent = NULL;
 	int rc;
 	u32 genctl;
+	struct ata_port_info *ppi;
 
 	rc = pci_enable_device(pdev);
 	if (rc)
@@ -201,20 +213,13 @@
 	if (rc)
 		goto err_out_regions;
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	ppi = &sis_port_info;
+	probe_ent = ata_pci_init_native_mode(pdev, &ppi);
 	if (!probe_ent) {
 		rc = -ENOMEM;
 		goto err_out_regions;
 	}
 
-	memset(probe_ent, 0, sizeof(*probe_ent));
-	probe_ent->pdev = pdev;
-	INIT_LIST_HEAD(&probe_ent->node);
-
-	probe_ent->sht = &sis_sht;
-	probe_ent->host_flags = ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
-				ATA_FLAG_NO_LEGACY;
-
 	/* check and see if the SCRs are in IO space or PCI cfg space */
 	pci_read_config_dword(pdev, SIS_GENCTL, &genctl);
 	if ((genctl & GENCTL_IOMAPPED_SCR) == 0)
@@ -231,32 +236,12 @@
 		probe_ent->host_flags |= SIS_FLAG_CFGSCR;
 	}
 
-	probe_ent->pio_mask = 0x1f;
-	probe_ent->mwdma_mask = 0x7;
-	probe_ent->udma_mask = 0x7f;
-	probe_ent->port_ops = &sis_ops;
-
-	probe_ent->port[0].cmd_addr = pci_resource_start(pdev, 0);
-	ata_std_ports(&probe_ent->port[0]);
-	probe_ent->port[0].ctl_addr =
-		pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
-	probe_ent->port[0].bmdma_addr = pci_resource_start(pdev, 4);
-	if (!(probe_ent->host_flags & SIS_FLAG_CFGSCR))
+	if (!(probe_ent->host_flags & SIS_FLAG_CFGSCR)) {
 		probe_ent->port[0].scr_addr =
 			pci_resource_start(pdev, SIS_SCR_PCI_BAR);
-
-	probe_ent->port[1].cmd_addr = pci_resource_start(pdev, 2);
-	ata_std_ports(&probe_ent->port[1]);
-	probe_ent->port[1].ctl_addr =
-		pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
-	probe_ent->port[1].bmdma_addr = pci_resource_start(pdev, 4) + 8;
-	if (!(probe_ent->host_flags & SIS_FLAG_CFGSCR))
 		probe_ent->port[1].scr_addr =
 			pci_resource_start(pdev, SIS_SCR_PCI_BAR) + 64;
-
-	probe_ent->n_ports = 2;
-	probe_ent->irq = pdev->irq;
-	probe_ent->irq_flags = SA_SHIRQ;
+	}
 
 	pci_set_master(pdev);
 	pci_enable_intx(pdev);
diff -Nru a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	2004-09-16 03:05:09 -04:00
+++ b/drivers/scsi/sata_svw.c	2004-09-16 03:05:09 -04:00
@@ -148,7 +148,73 @@
         }
 }
 
+/**
+ *	k2_bmdma_setup_mmio - Set up PCI IDE BMDMA transaction (MMIO)
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+void k2_bmdma_setup_mmio (struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
+	u8 dmactl;
+	void *mmio = (void *) ap->ioaddr.bmdma_addr;
+	/* load PRD table addr. */
+	mb();	/* make sure PRD table writes are visible to controller */
+	writel(ap->prd_dma, mmio + ATA_DMA_TABLE_OFS);
+
+	/* specify data direction, triple-check start bit is clear */
+	dmactl = readb(mmio + ATA_DMA_CMD);
+	dmactl &= ~(ATA_DMA_WR | ATA_DMA_START);
+	if (!rw)
+		dmactl |= ATA_DMA_WR;
+	writeb(dmactl, mmio + ATA_DMA_CMD);
+
+	/* issue r/w command if this is not a ATA DMA command*/
+	if (qc->tf.protocol != ATA_PROT_DMA)
+		ap->ops->exec_command(ap, &qc->tf);
+}
+
+/**
+ *	k2_bmdma_start_mmio - Start a PCI IDE BMDMA transaction (MMIO)
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+void k2_bmdma_start_mmio (struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	void *mmio = (void *) ap->ioaddr.bmdma_addr;
+	u8 dmactl;
+
+	/* start host DMA transaction */
+	dmactl = readb(mmio + ATA_DMA_CMD);
+	writeb(dmactl | ATA_DMA_START, mmio + ATA_DMA_CMD);
+	/* There is a race condition in certain SATA controllers that can 
+	   be seen when the r/w command is given to the controller before the 
+	   host DMA is started. On a Read command, the controller would initiate
+	   the command to the drive even before it sees the DMA start. When there
+	   are very fast drives connected to the controller, or when the data request 
+	   hits in the drive cache, there is the possibility that the drive returns a part
+	   or all of the requested data to the controller before the DMA start is issued.
+	   In this case, the controller would become confused as to what to do with the data.
+	   In the worst case when all the data is returned back to the controller, the
+	   controller could hang. In other cases it could return partial data returning
+	   in data corruption. This problem has been seen in PPC systems and can also appear
+	   on an system with very fast disks, where the SATA controller is sitting behind a 
+	   number of bridges, and hence there is significant latency between the r/w command
+	   and the start command. */
+	/* issue r/w command if the access is to ATA*/
+	if (qc->tf.protocol == ATA_PROT_DMA)
+		ap->ops->exec_command(ap, &qc->tf);
+}
 
+									      
 static u8 k2_stat_check_status(struct ata_port *ap)
 {
        	return readl((void *) ap->ioaddr.status_addr);
@@ -230,10 +296,11 @@
 	.tf_load		= k2_sata_tf_load,
 	.tf_read		= k2_sata_tf_read,
 	.check_status		= k2_stat_check_status,
-	.exec_command		= ata_exec_command_mmio,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
 	.phy_reset		= sata_phy_reset,
-	.bmdma_setup            = ata_bmdma_setup_mmio,
-	.bmdma_start            = ata_bmdma_start_mmio,
+	.bmdma_setup		= k2_bmdma_setup_mmio,
+	.bmdma_start		= k2_bmdma_start_mmio,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
@@ -373,6 +440,8 @@
 
 static struct pci_device_id k2_sata_pci_tbl[] = {
 	{ 0x1166, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0x1166, 0x0241, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0x1166, 0x0242, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ }
 };
 
diff -Nru a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c	2004-09-16 03:05:09 -04:00
+++ b/drivers/scsi/sata_sx4.c	2004-09-16 03:05:09 -04:00
@@ -193,9 +193,10 @@
 static struct ata_port_operations pdc_20621_ops = {
 	.port_disable		= ata_port_disable,
 	.tf_load		= pdc_tf_load_mmio,
-	.tf_read		= ata_tf_read_mmio,
-	.check_status		= ata_check_status_mmio,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
 	.exec_command		= pdc_exec_command_mmio,
+	.dev_select		= ata_std_dev_select,
 	.phy_reset		= pdc_20621_phy_reset,
 	.qc_prep		= pdc20621_qc_prep,
 	.qc_issue		= pdc20621_qc_issue_prot,
@@ -533,7 +534,7 @@
 
 	readl(dimm_mmio);	/* MMIO PCI posting flush */
 
-	VPRINTK("ata pkt buf ofs %u, prd size %u, mmio copied\n", i, sgt_len);
+	VPRINTK("ata pkt buf ofs %u, mmio copied\n", i);
 }
 
 static void pdc20621_qc_prep(struct ata_queued_cmd *qc)
@@ -887,7 +888,7 @@
 {
 	WARN_ON (tf->protocol == ATA_PROT_DMA ||
 		 tf->protocol == ATA_PROT_NODATA);
-	ata_tf_load_mmio(ap, tf);
+	ata_tf_load(ap, tf);
 }
 
 
@@ -895,7 +896,7 @@
 {
 	WARN_ON (tf->protocol == ATA_PROT_DMA ||
 		 tf->protocol == ATA_PROT_NODATA);
-	ata_exec_command_mmio(ap, tf);
+	ata_exec_command(ap, tf);
 }
 
 
diff -Nru a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c	2004-09-16 03:05:09 -04:00
+++ b/drivers/scsi/sata_via.c	2004-09-16 03:05:09 -04:00
@@ -100,15 +100,16 @@
 static struct ata_port_operations svia_sata_ops = {
 	.port_disable		= ata_port_disable,
 
-	.tf_load		= ata_tf_load_pio,
-	.tf_read		= ata_tf_read_pio,
-	.check_status		= ata_check_status_pio,
-	.exec_command		= ata_exec_command_pio,
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
 
 	.phy_reset		= sata_phy_reset,
 
-	.bmdma_setup            = ata_bmdma_setup_pio,
-	.bmdma_start            = ata_bmdma_start_pio,
+	.bmdma_setup            = ata_bmdma_setup,
+	.bmdma_start            = ata_bmdma_start,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
@@ -124,6 +125,15 @@
 	.port_stop		= ata_port_stop,
 };
 
+static struct ata_port_info svia_port_info = {
+	.sht		= &svia_sht,
+	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST | ATA_FLAG_NO_LEGACY,
+	.pio_mask	= 0x1f,
+	.mwdma_mask	= 0x07,
+	.udma_mask	= 0x7f,
+	.port_ops	= &svia_sata_ops,
+};
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("SCSI low-level driver for VIA SATA controllers");
 MODULE_LICENSE("GPL");
@@ -157,6 +167,7 @@
 	static int printed_version;
 	unsigned int i;
 	int rc;
+	struct ata_port_info *ppi;
 	struct ata_probe_ent *probe_ent;
 	u8 tmp8;
 
@@ -197,42 +208,17 @@
 	if (rc)
 		goto err_out_regions;
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	ppi = &svia_port_info;
+	probe_ent = ata_pci_init_native_mode(pdev, &ppi);
 	if (!probe_ent) {
 		printk(KERN_ERR DRV_NAME "(%s): out of memory\n",
 		       pci_name(pdev));
 		rc = -ENOMEM;
 		goto err_out_regions;
 	}
-	memset(probe_ent, 0, sizeof(*probe_ent));
-	INIT_LIST_HEAD(&probe_ent->node);
-	probe_ent->pdev = pdev;
-	probe_ent->sht = &svia_sht;
-	probe_ent->host_flags = ATA_FLAG_SATA | ATA_FLAG_SRST |
-				ATA_FLAG_NO_LEGACY;
-	probe_ent->port_ops = &svia_sata_ops;
-	probe_ent->n_ports = 2;
-	probe_ent->irq = pdev->irq;
-	probe_ent->irq_flags = SA_SHIRQ;
-	probe_ent->pio_mask = 0x1f;
-	probe_ent->mwdma_mask = 0x07;
-	probe_ent->udma_mask = 0x7f;
-
-	probe_ent->port[0].cmd_addr = pci_resource_start(pdev, 0);
-	ata_std_ports(&probe_ent->port[0]);
-	probe_ent->port[0].altstatus_addr =
-	probe_ent->port[0].ctl_addr =
-		pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
-	probe_ent->port[0].bmdma_addr = pci_resource_start(pdev, 4);
+
 	probe_ent->port[0].scr_addr =
 		svia_scr_addr(pci_resource_start(pdev, 5), 0);
-
-	probe_ent->port[1].cmd_addr = pci_resource_start(pdev, 2);
-	ata_std_ports(&probe_ent->port[1]);
-	probe_ent->port[1].altstatus_addr =
-	probe_ent->port[1].ctl_addr =
-		pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
-	probe_ent->port[1].bmdma_addr = pci_resource_start(pdev, 4) + 8;
 	probe_ent->port[1].scr_addr =
 		svia_scr_addr(pci_resource_start(pdev, 5), 1);
 
diff -Nru a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	2004-09-16 03:05:09 -04:00
+++ b/drivers/scsi/sata_vsc.c	2004-09-16 03:05:09 -04:00
@@ -211,11 +211,12 @@
 	.port_disable		= ata_port_disable,
 	.tf_load		= vsc_sata_tf_load,
 	.tf_read		= vsc_sata_tf_read,
-	.exec_command		= ata_exec_command_mmio,
-	.check_status		= ata_check_status_mmio,
+	.exec_command		= ata_exec_command,
+	.check_status		= ata_check_status,
+	.dev_select		= ata_std_dev_select,
 	.phy_reset		= sata_phy_reset,
-	.bmdma_setup            = ata_bmdma_setup_mmio,
-	.bmdma_start            = ata_bmdma_start_mmio,
+	.bmdma_setup            = ata_bmdma_setup,
+	.bmdma_start            = ata_bmdma_start,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-09-16 03:05:09 -04:00
+++ b/include/linux/libata.h	2004-09-16 03:05:09 -04:00
@@ -320,6 +320,7 @@
 
 	void (*exec_command)(struct ata_port *ap, struct ata_taskfile *tf);
 	u8   (*check_status)(struct ata_port *ap);
+	void (*dev_select)(struct ata_port *ap, unsigned int device);
 
 	void (*phy_reset) (struct ata_port *ap);
 	void (*post_set_mode) (struct ata_port *ap);
@@ -362,6 +363,7 @@
 };
 
 extern void ata_port_probe(struct ata_port *);
+extern void __sata_phy_reset(struct ata_port *ap);
 extern void sata_phy_reset(struct ata_port *ap);
 extern void ata_bus_reset(struct ata_port *ap);
 extern void ata_port_disable(struct ata_port *);
@@ -379,31 +381,32 @@
 /*
  * Default driver ops implementations
  */
-extern void ata_tf_load_pio(struct ata_port *ap, struct ata_taskfile *tf);
-extern void ata_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf);
-extern void ata_tf_read_pio(struct ata_port *ap, struct ata_taskfile *tf);
-extern void ata_tf_read_mmio(struct ata_port *ap, struct ata_taskfile *tf);
+extern void ata_tf_load(struct ata_port *ap, struct ata_taskfile *tf);
+extern void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 extern void ata_tf_to_fis(struct ata_taskfile *tf, u8 *fis, u8 pmp);
 extern void ata_tf_from_fis(u8 *fis, struct ata_taskfile *tf);
-extern u8 ata_check_status_pio(struct ata_port *ap);
-extern u8 ata_check_status_mmio(struct ata_port *ap);
-extern void ata_exec_command_pio(struct ata_port *ap, struct ata_taskfile *tf);
-extern void ata_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf);
+extern void ata_noop_dev_select (struct ata_port *ap, unsigned int device);
+extern void ata_std_dev_select (struct ata_port *ap, unsigned int device);
+extern u8 ata_check_status(struct ata_port *ap);
+extern void ata_exec_command(struct ata_port *ap, struct ata_taskfile *tf);
 extern int ata_port_start (struct ata_port *ap);
 extern void ata_port_stop (struct ata_port *ap);
 extern irqreturn_t ata_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
+extern struct ata_probe_ent *
+ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port);
+extern struct ata_probe_ent *
+ata_pci_init_legacy_mode(struct pci_dev *pdev, struct ata_port_info **port);
 extern void ata_qc_prep(struct ata_queued_cmd *qc);
 extern int ata_qc_issue_prot(struct ata_queued_cmd *qc);
 extern void ata_sg_init_one(struct ata_queued_cmd *qc, void *buf,
 		unsigned int buflen);
 extern void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 		 unsigned int n_elem);
+extern unsigned int ata_dev_classify(struct ata_taskfile *tf);
 extern void ata_dev_id_string(struct ata_device *dev, unsigned char *s,
 			      unsigned int ofs, unsigned int len);
-extern void ata_bmdma_setup_mmio (struct ata_queued_cmd *qc);
-extern void ata_bmdma_start_mmio (struct ata_queued_cmd *qc);
-extern void ata_bmdma_setup_pio (struct ata_queued_cmd *qc);
-extern void ata_bmdma_start_pio (struct ata_queued_cmd *qc);
+extern void ata_bmdma_setup (struct ata_queued_cmd *qc);
+extern void ata_bmdma_start (struct ata_queued_cmd *qc);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
 extern int pci_test_config_bits(struct pci_dev *pdev, struct pci_bits *bits);
 extern void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat);
