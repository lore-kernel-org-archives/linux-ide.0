From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCHES] 2.4.28-pre libata updates
Date: Tue, 14 Sep 2004 23:50:17 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040915035017.GA28252@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [69.28.190.101] ([69.28.190.101]:61315 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S267184AbUIODuS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Sep 2004 23:50:18 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org


Please do a

	bk pull bk://kernel.bkbits.net/jgarzik/libata-upstream-2.4

This will update the following files:

 drivers/scsi/ata_piix.c     |   26 +-
 drivers/scsi/libata-core.c  |  401 ++++++++++++++++++++++++++------------------
 drivers/scsi/sata_nv.c      |   66 ++-----
 drivers/scsi/sata_promise.c |   10 -
 drivers/scsi/sata_sil.c     |   14 -
 drivers/scsi/sata_sis.c     |   60 ++----
 drivers/scsi/sata_svw.c     |   76 +++++++-
 drivers/scsi/sata_sx4.c     |   10 -
 drivers/scsi/sata_via.c     |   55 ++----
 drivers/scsi/sata_vsc.c     |   10 -
 include/linux/compiler.h    |    1 
 include/linux/libata.h      |   40 ++--
 12 files changed, 428 insertions(+), 341 deletions(-)

through these ChangeSets:

<ananth@broadcom.com> (04/09/14 1.1543.1.7)
   [libata sata_svw] race condition fix, new device support
   
   * address race condition WRT order of DMA-start and ATA command issue
     (see code comment for more details)
   
   * Add support for Frodo 4/8

<jgarzik@pobox.com> (04/09/14 1.1543.1.6)
   [libata] minor comment updates, preparing for iomap merge

<jgarzik@pobox.com> (04/09/13 1.1543.1.5)
   [libata] consolidate legacy/native mode init code into helpers
   
   Eliminates duplicate code in sata_nv, sata_sis, and sata_via.

<jgarzik@pobox.com> (04/09/13 1.1543.1.4)
   [libata] remove distinction between MMIO/PIO helper functions
   
   Prepare for use of new generic iomap API.

<jgarzik@pobox.com> (04/09/13 1.1543.1.3)
   [libata] resync with 2.6.x
   
   Only whitespace changes.

<jgarzik@pobox.com> (04/09/13 1.1543.1.2)
   linux/compiler.h: dummy __iomem macro (an sparse annotation)

<torvalds@ppc970.osdl.org> (04/09/13 1.1543.1.1)
   libata: initial PCI memory annotations

diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c	2004-09-14 23:49:17 -04:00
+++ b/drivers/scsi/ata_piix.c	2004-09-14 23:49:17 -04:00
@@ -106,7 +106,7 @@
 	.name			= DRV_NAME,
 	.detect			= ata_scsi_detect,
 	.release		= ata_scsi_release,
-	.ioctl                  = ata_scsi_ioctl,
+	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
@@ -126,15 +126,15 @@
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
 
 	.phy_reset		= piix_pata_phy_reset,
 
-	.bmdma_setup		= ata_bmdma_setup_pio,
-	.bmdma_start		= ata_bmdma_start_pio,
+	.bmdma_setup		= ata_bmdma_setup,
+	.bmdma_start		= ata_bmdma_start,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
@@ -150,15 +150,15 @@
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
 
 	.phy_reset		= piix_sata_phy_reset,
 
-	.bmdma_setup		= ata_bmdma_setup_pio,
-	.bmdma_start		= ata_bmdma_start_pio,
+	.bmdma_setup		= ata_bmdma_setup,
+	.bmdma_start		= ata_bmdma_start,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-09-14 23:49:17 -04:00
+++ b/drivers/scsi/libata-core.c	2004-09-14 23:49:17 -04:00
@@ -90,17 +90,17 @@
 }
 
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
@@ -158,23 +158,23 @@
  *	Inherited from caller.
  */
 
-void ata_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf)
+static void ata_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
 
 	if (tf->ctl != ap->last_ctl) {
-		writeb(tf->ctl, ap->ioaddr.ctl_addr);
+		writeb(tf->ctl, (void __iomem *) ap->ioaddr.ctl_addr);
 		ap->last_ctl = tf->ctl;
 		ata_wait_idle(ap);
 	}
 
 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
-		writeb(tf->hob_feature, (void *) ioaddr->feature_addr);
-		writeb(tf->hob_nsect, (void *) ioaddr->nsect_addr);
-		writeb(tf->hob_lbal, (void *) ioaddr->lbal_addr);
-		writeb(tf->hob_lbam, (void *) ioaddr->lbam_addr);
-		writeb(tf->hob_lbah, (void *) ioaddr->lbah_addr);
+		writeb(tf->hob_feature, (void __iomem *) ioaddr->feature_addr);
+		writeb(tf->hob_nsect, (void __iomem *) ioaddr->nsect_addr);
+		writeb(tf->hob_lbal, (void __iomem *) ioaddr->lbal_addr);
+		writeb(tf->hob_lbam, (void __iomem *) ioaddr->lbam_addr);
+		writeb(tf->hob_lbah, (void __iomem *) ioaddr->lbah_addr);
 		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
 			tf->hob_feature,
 			tf->hob_nsect,
@@ -184,11 +184,11 @@
 	}
 
 	if (is_addr) {
-		writeb(tf->feature, (void *) ioaddr->feature_addr);
-		writeb(tf->nsect, (void *) ioaddr->nsect_addr);
-		writeb(tf->lbal, (void *) ioaddr->lbal_addr);
-		writeb(tf->lbam, (void *) ioaddr->lbam_addr);
-		writeb(tf->lbah, (void *) ioaddr->lbah_addr);
+		writeb(tf->feature, (void __iomem *) ioaddr->feature_addr);
+		writeb(tf->nsect, (void __iomem *) ioaddr->nsect_addr);
+		writeb(tf->lbal, (void __iomem *) ioaddr->lbal_addr);
+		writeb(tf->lbam, (void __iomem *) ioaddr->lbam_addr);
+		writeb(tf->lbah, (void __iomem *) ioaddr->lbah_addr);
 		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
 			tf->feature,
 			tf->nsect,
@@ -198,26 +198,34 @@
 	}
 
 	if (tf->flags & ATA_TFLAG_DEVICE) {
-		writeb(tf->device, (void *) ioaddr->device_addr);
+		writeb(tf->device, (void __iomem *) ioaddr->device_addr);
 		VPRINTK("device 0x%X\n", tf->device);
 	}
 
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
 
@@ -238,20 +246,28 @@
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf)
+static void ata_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	DPRINTK("ata%u: cmd 0x%X\n", ap->id, tf->command);
 
-       	writeb(tf->command, (void *) ap->ioaddr.command_addr);
+       	writeb(tf->command, (void __iomem *) ap->ioaddr.command_addr);
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
@@ -274,7 +290,7 @@
  *	@tf: ATA taskfile register set
  *
  *	Issues ATA taskfile register set to ATA host controller,
- *	via PIO, with proper synchronization with interrupt handler and
+ *	with proper synchronization with interrupt handler and
  *	other threads.
  *
  *	LOCKING:
@@ -294,7 +310,7 @@
  *	@tf: ATA taskfile register set
  *
  *	Issues ATA taskfile register set to ATA host controller,
- *	via PIO, with proper synchronization with interrupt handler and
+ *	with proper synchronization with interrupt handler and
  *	other threads.
  *
  *	LOCKING:
@@ -308,18 +324,18 @@
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
 
@@ -351,38 +367,46 @@
  *	Inherited from caller.
  */
 
-void ata_tf_read_mmio(struct ata_port *ap, struct ata_taskfile *tf)
+static void ata_tf_read_mmio(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
-	tf->nsect = readb((void *)ioaddr->nsect_addr);
-	tf->lbal = readb((void *)ioaddr->lbal_addr);
-	tf->lbam = readb((void *)ioaddr->lbam_addr);
-	tf->lbah = readb((void *)ioaddr->lbah_addr);
-	tf->device = readb((void *)ioaddr->device_addr);
+	tf->nsect = readb((void __iomem *)ioaddr->nsect_addr);
+	tf->lbal = readb((void __iomem *)ioaddr->lbal_addr);
+	tf->lbam = readb((void __iomem *)ioaddr->lbam_addr);
+	tf->lbah = readb((void __iomem *)ioaddr->lbah_addr);
+	tf->device = readb((void __iomem *)ioaddr->device_addr);
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
-		writeb(tf->ctl | ATA_HOB, ap->ioaddr.ctl_addr);
-		tf->hob_feature = readb((void *)ioaddr->error_addr);
-		tf->hob_nsect = readb((void *)ioaddr->nsect_addr);
-		tf->hob_lbal = readb((void *)ioaddr->lbal_addr);
-		tf->hob_lbam = readb((void *)ioaddr->lbam_addr);
-		tf->hob_lbah = readb((void *)ioaddr->lbah_addr);
+		writeb(tf->ctl | ATA_HOB, (void __iomem *) ap->ioaddr.ctl_addr);
+		tf->hob_feature = readb((void __iomem *)ioaddr->error_addr);
+		tf->hob_nsect = readb((void __iomem *)ioaddr->nsect_addr);
+		tf->hob_lbal = readb((void __iomem *)ioaddr->lbal_addr);
+		tf->hob_lbam = readb((void __iomem *)ioaddr->lbam_addr);
+		tf->hob_lbah = readb((void __iomem *)ioaddr->lbah_addr);
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
@@ -398,9 +422,16 @@
  *	LOCKING:
  *	Inherited from caller.
  */
-u8 ata_check_status_mmio(struct ata_port *ap)
+static u8 ata_check_status_mmio(struct ata_port *ap)
 {
-       	return readb((void *) ap->ioaddr.status_addr);
+       	return readb((void __iomem *) ap->ioaddr.status_addr);
+}
+
+u8 ata_check_status(struct ata_port *ap)
+{
+	if (ap->flags & ATA_FLAG_MMIO)
+		return ata_check_status_mmio(ap);
+	return ata_check_status_pio(ap);
 }
 
 /**
@@ -674,17 +705,17 @@
 
 	__ata_dev_select(ap, device);
 
-	writeb(0x55, (void *) ioaddr->nsect_addr);
-	writeb(0xaa, (void *) ioaddr->lbal_addr);
+	writeb(0x55, (void __iomem *) ioaddr->nsect_addr);
+	writeb(0xaa, (void __iomem *) ioaddr->lbal_addr);
 
-	writeb(0xaa, (void *) ioaddr->nsect_addr);
-	writeb(0x55, (void *) ioaddr->lbal_addr);
+	writeb(0xaa, (void __iomem *) ioaddr->nsect_addr);
+	writeb(0x55, (void __iomem *) ioaddr->lbal_addr);
 
-	writeb(0x55, (void *) ioaddr->nsect_addr);
-	writeb(0xaa, (void *) ioaddr->lbal_addr);
+	writeb(0x55, (void __iomem *) ioaddr->nsect_addr);
+	writeb(0xaa, (void __iomem *) ioaddr->lbal_addr);
 
-	nsect = readb((void *) ioaddr->nsect_addr);
-	lbal = readb((void *) ioaddr->lbal_addr);
+	nsect = readb((void __iomem *) ioaddr->nsect_addr);
+	lbal = readb((void __iomem *) ioaddr->lbal_addr);
 
 	if ((nsect == 0x55) && (lbal == 0xaa))
 		return 1;	/* we found a device */
@@ -693,7 +724,7 @@
 }
 
 /**
- *	ata_dev_devchk - PATA device presence detection
+ *	ata_devchk - PATA device presence detection
  *	@ap: ATA channel to examine
  *	@device: Device to examine (starting at zero)
  *
@@ -705,7 +736,7 @@
  *	caller.
  */
 
-static unsigned int ata_dev_devchk(struct ata_port *ap,
+static unsigned int ata_devchk(struct ata_port *ap,
 				    unsigned int device)
 {
 	if (ap->flags & ATA_FLAG_MMIO)
@@ -863,7 +894,7 @@
 		tmp = ATA_DEVICE_OBS | ATA_DEV1;
 
 	if (ap->flags & ATA_FLAG_MMIO) {
-		writeb(tmp, (void *) ap->ioaddr.device_addr);
+		writeb(tmp, (void __iomem *) ap->ioaddr.device_addr);
 	} else {
 		outb(tmp, ap->ioaddr.device_addr);
 	}
@@ -1461,13 +1492,13 @@
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
@@ -1476,8 +1507,8 @@
 
 		__ata_dev_select(ap, 1);
 		if (ap->flags & ATA_FLAG_MMIO) {
-			nsect = readb((void *) ioaddr->nsect_addr);
-			lbal = readb((void *) ioaddr->lbal_addr);
+			nsect = readb((void __iomem *) ioaddr->nsect_addr);
+			lbal = readb((void __iomem *) ioaddr->lbal_addr);
 		} else {
 			nsect = inb(ioaddr->nsect_addr);
 			lbal = inb(ioaddr->lbal_addr);
@@ -1541,11 +1572,11 @@
 
 	/* software reset.  causes dev0 to be selected */
 	if (ap->flags & ATA_FLAG_MMIO) {
-		writeb(ap->ctl, ioaddr->ctl_addr);
+		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
 		udelay(20);	/* FIXME: flush */
-		writeb(ap->ctl | ATA_SRST, ioaddr->ctl_addr);
+		writeb(ap->ctl | ATA_SRST, (void __iomem *) ioaddr->ctl_addr);
 		udelay(20);	/* FIXME: flush */
-		writeb(ap->ctl, ioaddr->ctl_addr);
+		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
 	} else {
 		outb(ap->ctl, ioaddr->ctl_addr);
 		udelay(10);
@@ -1602,9 +1633,9 @@
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
@@ -1621,7 +1652,7 @@
 	else if ((ap->flags & ATA_FLAG_SATA_RESET) == 0) {
 		/* set up device control */
 		if (ap->flags & ATA_FLAG_MMIO)
-			writeb(ap->ctl, ioaddr->ctl_addr);
+			writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
 		else
 			outb(ap->ctl, ioaddr->ctl_addr);
 		rc = ata_bus_edd(ap);
@@ -1654,7 +1685,7 @@
 	if (ap->flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST)) {
 		/* set up device control for ATA_FLAG_SATA_RESET */
 		if (ap->flags & ATA_FLAG_MMIO)
-			writeb(ap->ctl, ioaddr->ctl_addr);
+			writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
 		else
 			outb(ap->ctl, ioaddr->ctl_addr);
 	}
@@ -2101,7 +2132,7 @@
 	unsigned int i;
 	unsigned int words = buflen >> 1;
 	u16 *buf16 = (u16 *) buf;
-	void *mmio = (void *)ap->ioaddr.data_addr;
+	void __iomem *mmio = (void __iomem *)ap->ioaddr.data_addr;
 
 	if (write_data) {
 		for (i = 0; i < words; i++)
@@ -2182,7 +2213,7 @@
 	/* shall be cleared to zero, indicating xfer of data */
 	if (ireason & (1 << 0))
 		goto err_out;
-	
+
 	/* make sure transfer direction matches expected */
 	i_write = ((ireason & (1 << 1)) == 0) ? 1 : 0;
 	if (do_write != i_write)
@@ -2198,7 +2229,7 @@
 
 	for (i = 0; i < (bytes >> 9); i++)
 		ata_pio_sector(qc);
-	
+
 	return;
 
 err_out:
@@ -2627,19 +2658,19 @@
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
 	u8 dmactl;
-	void *mmio = (void *) ap->ioaddr.bmdma_addr;
+	void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
 
 	/* load PRD table addr. */
 	mb();	/* make sure PRD table writes are visible to controller */
@@ -2657,17 +2688,17 @@
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
-	void *mmio = (void *) ap->ioaddr.bmdma_addr;
+	void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
 	u8 dmactl;
 
 	/* start host DMA transaction */
@@ -2695,7 +2726,7 @@
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_bmdma_setup_pio (struct ata_queued_cmd *qc)
+static void ata_bmdma_setup_pio (struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
@@ -2723,7 +2754,7 @@
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_bmdma_start_pio (struct ata_queued_cmd *qc)
+static void ata_bmdma_start_pio (struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	u8 dmactl;
@@ -2734,6 +2765,22 @@
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
@@ -3244,6 +3291,95 @@
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
@@ -3261,20 +3397,20 @@
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
@@ -3318,89 +3454,32 @@
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
 
 	spin_lock(&ata_module_lock);
 	if (legacy_mode) {
+		int free = 0;
 		if (legacy_mode & (1 << 0))
 			list_add_tail(&probe_ent->node, &ata_probe_list);
 		else
-			kfree(probe_ent);
+			free++;
 		if (legacy_mode & (1 << 1))
 			list_add_tail(&probe_ent2->node, &ata_probe_list);
 		else
-			kfree(probe_ent2);
+			free++;
+		if (free > 1)
+			kfree(probe_ent);
 	} else {
 		list_add_tail(&probe_ent->node, &ata_probe_list);
 	}
@@ -3408,8 +3487,6 @@
 
 	return 0;
 
-err_out_free_ent:
-	kfree(probe_ent);
 err_out_regions:
 	if (legacy_mode & (1 << 0))
 		release_region(0x1f0, 8);
@@ -3567,24 +3644,20 @@
 EXPORT_SYMBOL_GPL(ata_qc_complete);
 EXPORT_SYMBOL_GPL(ata_qc_issue_prot);
 EXPORT_SYMBOL_GPL(ata_eng_timeout);
-EXPORT_SYMBOL_GPL(ata_tf_load_pio);
-EXPORT_SYMBOL_GPL(ata_tf_load_mmio);
-EXPORT_SYMBOL_GPL(ata_tf_read_pio);
-EXPORT_SYMBOL_GPL(ata_tf_read_mmio);
+EXPORT_SYMBOL_GPL(ata_tf_load);
+EXPORT_SYMBOL_GPL(ata_tf_read);
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
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2004-09-14 23:49:17 -04:00
+++ b/drivers/scsi/sata_nv.c	2004-09-14 23:49:17 -04:00
@@ -50,8 +50,6 @@
 #define NV_PIO_MASK			0x1f
 #define NV_MWDMA_MASK			0x07
 #define NV_UDMA_MASK			0x7f
-#define NV_PORT0_BMDMA_REG_OFFSET	0x00
-#define NV_PORT1_BMDMA_REG_OFFSET	0x08
 #define NV_PORT0_SCR_REG_OFFSET		0x00
 #define NV_PORT1_SCR_REG_OFFSET		0x40
 
@@ -184,7 +182,7 @@
 	.name			= DRV_NAME,
 	.detect			= ata_scsi_detect,
 	.release		= ata_scsi_release,
-	.ioctl                  = ata_scsi_ioctl,
+	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
@@ -201,13 +199,13 @@
 
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
 	.phy_reset		= sata_phy_reset,
-	.bmdma_setup		= ata_bmdma_setup_pio,
-	.bmdma_start		= ata_bmdma_start_pio,
+	.bmdma_setup		= ata_bmdma_setup,
+	.bmdma_start		= ata_bmdma_start,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
@@ -220,6 +218,18 @@
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
@@ -300,6 +310,7 @@
 {
 	static int printed_version = 0;
 	struct nv_host *host;
+	struct ata_port_info *ppi;
 	struct ata_probe_ent *probe_ent = NULL;
 	int rc;
 
@@ -318,7 +329,8 @@
 	if (rc)
 		goto err_out_regions;
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	ppi = &nv_port_info;
+	probe_ent = ata_pci_init_native_mode(pdev, &ppi);
 	if (!probe_ent) {
 		rc = -ENOMEM;
 		goto err_out_regions;
@@ -331,40 +343,6 @@
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
--- a/drivers/scsi/sata_promise.c	2004-09-14 23:49:17 -04:00
+++ b/drivers/scsi/sata_promise.c	2004-09-14 23:49:17 -04:00
@@ -91,7 +91,7 @@
 	.name			= DRV_NAME,
 	.detect			= ata_scsi_detect,
 	.release		= ata_scsi_release,
-	.ioctl                  = ata_scsi_ioctl,
+	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
@@ -109,8 +109,8 @@
 static struct ata_port_operations pdc_sata_ops = {
 	.port_disable		= ata_port_disable,
 	.tf_load		= pdc_tf_load_mmio,
-	.tf_read		= ata_tf_read_mmio,
-	.check_status		= ata_check_status_mmio,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
 	.exec_command		= pdc_exec_command_mmio,
 	.phy_reset		= pdc_phy_reset,
 	.qc_prep		= pdc_qc_prep,
@@ -470,7 +470,7 @@
 {
 	WARN_ON (tf->protocol == ATA_PROT_DMA ||
 		 tf->protocol == ATA_PROT_NODATA);
-	ata_tf_load_mmio(ap, tf);
+	ata_tf_load(ap, tf);
 }
 
 
@@ -478,7 +478,7 @@
 {
 	WARN_ON (tf->protocol == ATA_PROT_DMA ||
 		 tf->protocol == ATA_PROT_NODATA);
-	ata_exec_command_mmio(ap, tf);
+	ata_exec_command(ap, tf);
 }
 
 
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2004-09-14 23:49:17 -04:00
+++ b/drivers/scsi/sata_sil.c	2004-09-14 23:49:17 -04:00
@@ -108,7 +108,7 @@
 	.name			= DRV_NAME,
 	.detect			= ata_scsi_detect,
 	.release		= ata_scsi_release,
-	.ioctl                  = ata_scsi_ioctl,
+	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
@@ -126,14 +126,14 @@
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
--- a/drivers/scsi/sata_sis.c	2004-09-14 23:49:17 -04:00
+++ b/drivers/scsi/sata_sis.c	2004-09-14 23:49:17 -04:00
@@ -78,7 +78,7 @@
 	.name			= DRV_NAME,
 	.detect			= ata_scsi_detect,
 	.release		= ata_scsi_release,
-	.ioctl                  = ata_scsi_ioctl,
+	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
@@ -95,13 +95,13 @@
 
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
 	.phy_reset		= sata_phy_reset,
-	.bmdma_setup            = ata_bmdma_setup_pio,
-	.bmdma_start            = ata_bmdma_start_pio,
+	.bmdma_setup            = ata_bmdma_setup,
+	.bmdma_start            = ata_bmdma_start,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
@@ -113,6 +113,16 @@
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
@@ -186,6 +196,7 @@
 	struct ata_probe_ent *probe_ent = NULL;
 	int rc;
 	u32 genctl;
+	struct ata_port_info *ppi;
 
 	rc = pci_enable_device(pdev);
 	if (rc)
@@ -199,20 +210,13 @@
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
@@ -229,32 +233,12 @@
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
--- a/drivers/scsi/sata_svw.c	2004-09-14 23:49:17 -04:00
+++ b/drivers/scsi/sata_svw.c	2004-09-14 23:49:17 -04:00
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
@@ -207,7 +273,7 @@
 	.name			= DRV_NAME,
 	.detect			= ata_scsi_detect,
 	.release		= ata_scsi_release,
-	.ioctl                  = ata_scsi_ioctl,
+	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
@@ -231,10 +297,10 @@
 	.tf_load		= k2_sata_tf_load,
 	.tf_read		= k2_sata_tf_read,
 	.check_status		= k2_stat_check_status,
-	.exec_command		= ata_exec_command_mmio,
+	.exec_command		= ata_exec_command,
 	.phy_reset		= sata_phy_reset,
-	.bmdma_setup            = ata_bmdma_setup_mmio,
-	.bmdma_start            = ata_bmdma_start_mmio,
+	.bmdma_setup		= k2_bmdma_setup_mmio,
+	.bmdma_start		= k2_bmdma_start_mmio,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
@@ -369,6 +435,8 @@
 
 static struct pci_device_id k2_sata_pci_tbl[] = {
 	{ 0x1166, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0x1166, 0x0241, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0x1166, 0x0242, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ }
 };
 
diff -Nru a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c	2004-09-14 23:49:17 -04:00
+++ b/drivers/scsi/sata_sx4.c	2004-09-14 23:49:17 -04:00
@@ -176,7 +176,7 @@
 	.name			= DRV_NAME,
 	.detect			= ata_scsi_detect,
 	.release		= ata_scsi_release,
-	.ioctl                  = ata_scsi_ioctl,
+	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
@@ -194,8 +194,8 @@
 static struct ata_port_operations pdc_20621_ops = {
 	.port_disable		= ata_port_disable,
 	.tf_load		= pdc_tf_load_mmio,
-	.tf_read		= ata_tf_read_mmio,
-	.check_status		= ata_check_status_mmio,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
 	.exec_command		= pdc_exec_command_mmio,
 	.phy_reset		= pdc_20621_phy_reset,
 	.qc_prep		= pdc20621_qc_prep,
@@ -888,7 +888,7 @@
 {
 	WARN_ON (tf->protocol == ATA_PROT_DMA ||
 		 tf->protocol == ATA_PROT_NODATA);
-	ata_tf_load_mmio(ap, tf);
+	ata_tf_load(ap, tf);
 }
 
 
@@ -896,7 +896,7 @@
 {
 	WARN_ON (tf->protocol == ATA_PROT_DMA ||
 		 tf->protocol == ATA_PROT_NODATA);
-	ata_exec_command_mmio(ap, tf);
+	ata_exec_command(ap, tf);
 }
 
 
diff -Nru a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c	2004-09-14 23:49:17 -04:00
+++ b/drivers/scsi/sata_via.c	2004-09-14 23:49:17 -04:00
@@ -83,7 +83,7 @@
 	.name			= DRV_NAME,
 	.detect			= ata_scsi_detect,
 	.release		= ata_scsi_release,
-	.ioctl                  = ata_scsi_ioctl,
+	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
@@ -101,15 +101,15 @@
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
 
 	.phy_reset		= sata_phy_reset,
 
-	.bmdma_setup            = ata_bmdma_setup_pio,
-	.bmdma_start            = ata_bmdma_start_pio,
+	.bmdma_setup            = ata_bmdma_setup,
+	.bmdma_start            = ata_bmdma_start,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
@@ -125,6 +125,15 @@
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
@@ -158,6 +167,7 @@
 	static int printed_version;
 	unsigned int i;
 	int rc;
+	struct ata_port_info *ppi;
 	struct ata_probe_ent *probe_ent;
 	u8 tmp8;
 
@@ -195,42 +205,17 @@
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
--- a/drivers/scsi/sata_vsc.c	2004-09-14 23:49:17 -04:00
+++ b/drivers/scsi/sata_vsc.c	2004-09-14 23:49:17 -04:00
@@ -192,7 +192,7 @@
 	.name			= DRV_NAME,
 	.detect			= ata_scsi_detect,
 	.release		= ata_scsi_release,
-	.ioctl                  = ata_scsi_ioctl,
+	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
@@ -212,11 +212,11 @@
 	.port_disable		= ata_port_disable,
 	.tf_load		= vsc_sata_tf_load,
 	.tf_read		= vsc_sata_tf_read,
-	.exec_command		= ata_exec_command_mmio,
-	.check_status		= ata_check_status_mmio,
+	.exec_command		= ata_exec_command,
+	.check_status		= ata_check_status,
 	.phy_reset		= sata_phy_reset,
-	.bmdma_setup            = ata_bmdma_setup_mmio,
-	.bmdma_start            = ata_bmdma_start_mmio,
+	.bmdma_setup            = ata_bmdma_setup,
+	.bmdma_start            = ata_bmdma_start,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
diff -Nru a/include/linux/compiler.h b/include/linux/compiler.h
--- a/include/linux/compiler.h	2004-09-14 23:49:17 -04:00
+++ b/include/linux/compiler.h	2004-09-14 23:49:17 -04:00
@@ -37,5 +37,6 @@
 
 /* no checker support, so we unconditionally define this as (null) */
 #define __user
+#define __iomem
 
 #endif /* __LINUX_COMPILER_H */
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-09-14 23:49:17 -04:00
+++ b/include/linux/libata.h	2004-09-14 23:49:17 -04:00
@@ -197,7 +197,7 @@
 	unsigned long		irq;
 	unsigned int		irq_flags;
 	unsigned long		host_flags;
-	void			*mmio_base;
+	void __iomem		*mmio_base;
 	void			*private_data;
 };
 
@@ -205,7 +205,7 @@
 	spinlock_t		lock;
 	struct pci_dev		*pdev;
 	unsigned long		irq;
-	void			*mmio_base;
+	void __iomem		*mmio_base;
 	unsigned int		n_ports;
 	void			*private_data;
 	struct ata_port_operations *ops;
@@ -380,19 +380,19 @@
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
@@ -401,10 +401,8 @@
 		 unsigned int n_elem);
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
@@ -433,7 +431,7 @@
 static inline u8 ata_chk_err(struct ata_port *ap)
 {
 	if (ap->flags & ATA_FLAG_MMIO) {
-		return readb((void *) ap->ioaddr.error_addr);
+		return readb((void __iomem *) ap->ioaddr.error_addr);
 	}
 	return inb(ap->ioaddr.error_addr);
 }
@@ -446,7 +444,7 @@
 static inline u8 ata_altstatus(struct ata_port *ap)
 {
 	if (ap->flags & ATA_FLAG_MMIO)
-		return readb(ap->ioaddr.altstatus_addr);
+		return readb((void __iomem *)ap->ioaddr.altstatus_addr);
 	return inb(ap->ioaddr.altstatus_addr);
 }
 
@@ -517,7 +515,7 @@
 	ap->last_ctl = ap->ctl;
 
 	if (ap->flags & ATA_FLAG_MMIO)
-		writeb(ap->ctl, ioaddr->ctl_addr);
+		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
 	else
 		outb(ap->ctl, ioaddr->ctl_addr);
 	tmp = ata_wait_idle(ap);
@@ -538,7 +536,7 @@
 
 	/* get controller status; clear intr, err bits */
 	if (ap->flags & ATA_FLAG_MMIO) {
-		void *mmio = (void *) ap->ioaddr.bmdma_addr;
+		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
 		host_stat = readb(mmio + ATA_DMA_STATUS);
 		writeb(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
 		       mmio + ATA_DMA_STATUS);
@@ -576,7 +574,7 @@
 static inline void ata_bmdma_stop(struct ata_port *ap)
 {
 	if (ap->flags & ATA_FLAG_MMIO) {
-		void *mmio = (void *) ap->ioaddr.bmdma_addr;
+		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
 
 		/* clear start/stop bit */
 		writeb(readb(mmio + ATA_DMA_CMD) & ~ATA_DMA_START,
@@ -594,7 +592,7 @@
 static inline void ata_bmdma_ack_irq(struct ata_port *ap)
 {
 	if (ap->flags & ATA_FLAG_MMIO) {
-		void *mmio = ((void *) ap->ioaddr.bmdma_addr) + ATA_DMA_STATUS;
+		void __iomem *mmio = ((void __iomem *) ap->ioaddr.bmdma_addr) + ATA_DMA_STATUS;
 		writeb(readb(mmio), mmio);
 	} else {
 		unsigned long addr = ap->ioaddr.bmdma_addr + ATA_DMA_STATUS;
@@ -606,7 +604,7 @@
 {
 	u8 host_stat;
 	if (ap->flags & ATA_FLAG_MMIO) {
-		void *mmio = (void *) ap->ioaddr.bmdma_addr;
+		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
 		host_stat = readb(mmio + ATA_DMA_STATUS);
 	} else
 		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
