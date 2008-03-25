From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/27] libata: reorganize SFF related stuff
Date: Tue, 25 Mar 2008 22:16:41 +0900
Message-ID: <12064510261929-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.183]:23108 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754671AbYCYNRi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:38 -0400
Received: by el-out-1112.google.com with SMTP id v27so1723848ele.17
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:36 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

* Move SFF related functions from libata-core.c to libata-sff.c.

  ata_[bmdma_]sff_port_ops, ata_devchk(), ata_dev_try_classify(),
  ata_std_dev_select(), ata_tf_to_host(), ata_busy_sleep(),
  ata_wait_after_reset(), ata_wait_ready(), ata_bus_post_reset(),
  ata_bus_softreset(), ata_bus_reset(), ata_std_softreset(),
  sata_std_hardreset(), ata_fill_sg(), ata_fill_sg_dumb(),
  ata_qc_prep(), ata_dump_qc_prep(), ata_data_xfer(),
  ata_data_xfer_noirq(), ata_pio_sector(), ata_pio_sectors(),
  atapi_send_cdb(), __atapi_pio_bytes(), atapi_pio_bytes(),
  ata_hsm_ok_in_wq(), ata_hsm_qc_complete(), ata_hsm_move(),
  ata_pio_task(), ata_qc_issue_prot(), ata_host_intr(),
  ata_interrupt(), ata_std_ports()

* Make ata_pio_queue_task() global as it's now called from
  libata-sff.c.

* Move SFF related stuff in include/linux/libata.h and
  drivers/ata/libata.h into one place.  While at it, move timing
  constants into the global enum definition and fortify comments a
  bit.

This patch strictly moves stuff around and as such doesn't cause any
functional difference.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c | 1884 +--------------------------------------------
 drivers/ata/libata-sff.c  | 1859 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/ata/libata.h      |    8 +-
 include/linux/libata.h    |  379 +++++-----
 4 files changed, 2060 insertions(+), 2070 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d7e7ac6..5209d49 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -46,7 +46,6 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/mm.h>
-#include <linux/highmem.h>
 #include <linux/spinlock.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
@@ -98,41 +97,6 @@ const struct ata_port_operations sata_pmp_port_ops = {
 	.error_handler		= sata_pmp_error_handler,
 };
 
-const struct ata_port_operations ata_sff_port_ops = {
-	.inherits		= &ata_base_port_ops,
-
-	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
-
-	.freeze			= ata_bmdma_freeze,
-	.thaw			= ata_bmdma_thaw,
-	.softreset		= ata_std_softreset,
-	.error_handler		= ata_bmdma_error_handler,
-	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-
-	.dev_select		= ata_std_dev_select,
-	.check_status		= ata_check_status,
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.exec_command		= ata_exec_command,
-	.data_xfer		= ata_data_xfer,
-	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_sff_port_start,
-};
-
-const struct ata_port_operations ata_bmdma_port_ops = {
-	.inherits		= &ata_sff_port_ops,
-
-	.mode_filter		= ata_pci_default_filter,
-
-	.bmdma_setup		= ata_bmdma_setup,
-	.bmdma_start		= ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
-	.bmdma_status		= ata_bmdma_status,
-	.irq_clear		= ata_bmdma_irq_clear,
-};
-
 static unsigned int ata_dev_init_params(struct ata_device *dev,
 					u16 heads, u16 sectors);
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
@@ -385,6 +349,14 @@ static void ata_force_horkage(struct ata_device *dev)
 }
 
 /**
+ *	ata_noop_irq_clear - Noop placeholder for irq_clear
+ *	@ap: Port associated with this ATA transaction.
+ */
+void ata_noop_irq_clear(struct ata_port *ap)
+{
+}
+
+/**
  *	ata_tf_to_fis - Convert ATA taskfile to SATA FIS structure
  *	@tf: Taskfile to convert
  *	@pmp: Port multiplier port
@@ -1064,50 +1036,6 @@ static void ata_lpm_disable(struct ata_host *host)
 }
 #endif	/* CONFIG_PM */
 
-
-/**
- *	ata_devchk - PATA device presence detection
- *	@ap: ATA channel to examine
- *	@device: Device to examine (starting at zero)
- *
- *	This technique was originally described in
- *	Hale Landis's ATADRVR (www.ata-atapi.com), and
- *	later found its way into the ATA/ATAPI spec.
- *
- *	Write a pattern to the ATA shadow registers,
- *	and if a device is present, it will respond by
- *	correctly storing and echoing back the
- *	ATA shadow register contents.
- *
- *	LOCKING:
- *	caller.
- */
-
-static unsigned int ata_devchk(struct ata_port *ap, unsigned int device)
-{
-	struct ata_ioports *ioaddr = &ap->ioaddr;
-	u8 nsect, lbal;
-
-	ap->ops->dev_select(ap, device);
-
-	iowrite8(0x55, ioaddr->nsect_addr);
-	iowrite8(0xaa, ioaddr->lbal_addr);
-
-	iowrite8(0xaa, ioaddr->nsect_addr);
-	iowrite8(0x55, ioaddr->lbal_addr);
-
-	iowrite8(0x55, ioaddr->nsect_addr);
-	iowrite8(0xaa, ioaddr->lbal_addr);
-
-	nsect = ioread8(ioaddr->nsect_addr);
-	lbal = ioread8(ioaddr->lbal_addr);
-
-	if ((nsect == 0x55) && (lbal == 0xaa))
-		return 1;	/* we found a device */
-
-	return 0;		/* nothing found */
-}
-
 /**
  *	ata_dev_classify - determine device type based on ATA-spec signature
  *	@tf: ATA taskfile register set for device to be identified
@@ -1168,75 +1096,6 @@ unsigned int ata_dev_classify(const struct ata_taskfile *tf)
 }
 
 /**
- *	ata_dev_try_classify - Parse returned ATA device signature
- *	@dev: ATA device to classify (starting at zero)
- *	@present: device seems present
- *	@r_err: Value of error register on completion
- *
- *	After an event -- SRST, E.D.D., or SATA COMRESET -- occurs,
- *	an ATA/ATAPI-defined set of values is placed in the ATA
- *	shadow registers, indicating the results of device detection
- *	and diagnostics.
- *
- *	Select the ATA device, and read the values from the ATA shadow
- *	registers.  Then parse according to the Error register value,
- *	and the spec-defined values examined by ata_dev_classify().
- *
- *	LOCKING:
- *	caller.
- *
- *	RETURNS:
- *	Device type - %ATA_DEV_ATA, %ATA_DEV_ATAPI or %ATA_DEV_NONE.
- */
-unsigned int ata_dev_try_classify(struct ata_device *dev, int present,
-				  u8 *r_err)
-{
-	struct ata_port *ap = dev->link->ap;
-	struct ata_taskfile tf;
-	unsigned int class;
-	u8 err;
-
-	ap->ops->dev_select(ap, dev->devno);
-
-	memset(&tf, 0, sizeof(tf));
-
-	ap->ops->tf_read(ap, &tf);
-	err = tf.feature;
-	if (r_err)
-		*r_err = err;
-
-	/* see if device passed diags: continue and warn later */
-	if (err == 0)
-		/* diagnostic fail : do nothing _YET_ */
-		dev->horkage |= ATA_HORKAGE_DIAGNOSTIC;
-	else if (err == 1)
-		/* do nothing */ ;
-	else if ((dev->devno == 0) && (err == 0x81))
-		/* do nothing */ ;
-	else
-		return ATA_DEV_NONE;
-
-	/* determine if device is ATA or ATAPI */
-	class = ata_dev_classify(&tf);
-
-	if (class == ATA_DEV_UNKNOWN) {
-		/* If the device failed diagnostic, it's likely to
-		 * have reported incorrect device signature too.
-		 * Assume ATA device if the device seems present but
-		 * device signature is invalid with diagnostic
-		 * failure.
-		 */
-		if (present && (dev->horkage & ATA_HORKAGE_DIAGNOSTIC))
-			class = ATA_DEV_ATA;
-		else
-			class = ATA_DEV_NONE;
-	} else if ((class == ATA_DEV_ATA) && (ata_chk_status(ap) == 0))
-		class = ATA_DEV_NONE;
-
-	return class;
-}
-
-/**
  *	ata_id_string - Convert IDENTIFY DEVICE page into string
  *	@id: IDENTIFY DEVICE results we will examine
  *	@s: string into which data is output
@@ -1559,73 +1418,6 @@ void ata_noop_dev_select(struct ata_port *ap, unsigned int device)
 {
 }
 
-
-/**
- *	ata_std_dev_select - Select device 0/1 on ATA bus
- *	@ap: ATA channel to manipulate
- *	@device: ATA device (numbered from zero) to select
- *
- *	Use the method defined in the ATA specification to
- *	make either device 0, or device 1, active on the
- *	ATA channel.  Works with both PIO and MMIO.
- *
- *	May be used as the dev_select() entry in ata_port_operations.
- *
- *	LOCKING:
- *	caller.
- */
-
-void ata_std_dev_select(struct ata_port *ap, unsigned int device)
-{
-	u8 tmp;
-
-	if (device == 0)
-		tmp = ATA_DEVICE_OBS;
-	else
-		tmp = ATA_DEVICE_OBS | ATA_DEV1;
-
-	iowrite8(tmp, ap->ioaddr.device_addr);
-	ata_pause(ap);		/* needed; also flushes, for mmio */
-}
-
-/**
- *	ata_dev_select - Select device 0/1 on ATA bus
- *	@ap: ATA channel to manipulate
- *	@device: ATA device (numbered from zero) to select
- *	@wait: non-zero to wait for Status register BSY bit to clear
- *	@can_sleep: non-zero if context allows sleeping
- *
- *	Use the method defined in the ATA specification to
- *	make either device 0, or device 1, active on the
- *	ATA channel.
- *
- *	This is a high-level version of ata_std_dev_select(),
- *	which additionally provides the services of inserting
- *	the proper pauses and status polling, where needed.
- *
- *	LOCKING:
- *	caller.
- */
-
-void ata_dev_select(struct ata_port *ap, unsigned int device,
-			   unsigned int wait, unsigned int can_sleep)
-{
-	if (ata_msg_probe(ap))
-		ata_port_printk(ap, KERN_INFO, "ata_dev_select: ENTER, "
-				"device %u, wait %u\n", device, wait);
-
-	if (wait)
-		ata_wait_idle(ap);
-
-	ap->ops->dev_select(ap, device);
-
-	if (wait) {
-		if (can_sleep && ap->link.device[device].class == ATA_DEV_ATAPI)
-			msleep(150);
-		ata_wait_idle(ap);
-	}
-}
-
 /**
  *	ata_dump_id - IDENTIFY DEVICE info debugging output
  *	@id: IDENTIFY DEVICE page to dump
@@ -1753,8 +1545,7 @@ unsigned long ata_id_xfermask(const u16 *id)
  *	LOCKING:
  *	Inherited from caller.
  */
-static void ata_pio_queue_task(struct ata_port *ap, void *data,
-			       unsigned long delay)
+void ata_pio_queue_task(struct ata_port *ap, void *data, unsigned long delay)
 {
 	ap->port_task_data = data;
 
@@ -3494,353 +3285,6 @@ int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
 }
 
 /**
- *	ata_tf_to_host - issue ATA taskfile to host controller
- *	@ap: port to which command is being issued
- *	@tf: ATA taskfile register set
- *
- *	Issues ATA taskfile register set to ATA host controller,
- *	with proper synchronization with interrupt handler and
- *	other threads.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-
-static inline void ata_tf_to_host(struct ata_port *ap,
-				  const struct ata_taskfile *tf)
-{
-	ap->ops->tf_load(ap, tf);
-	ap->ops->exec_command(ap, tf);
-}
-
-/**
- *	ata_busy_sleep - sleep until BSY clears, or timeout
- *	@ap: port containing status register to be polled
- *	@tmout_pat: impatience timeout
- *	@tmout: overall timeout
- *
- *	Sleep until ATA Status register bit BSY clears,
- *	or a timeout occurs.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep).
- *
- *	RETURNS:
- *	0 on success, -errno otherwise.
- */
-int ata_busy_sleep(struct ata_port *ap,
-		   unsigned long tmout_pat, unsigned long tmout)
-{
-	unsigned long timer_start, timeout;
-	u8 status;
-
-	status = ata_busy_wait(ap, ATA_BUSY, 300);
-	timer_start = jiffies;
-	timeout = timer_start + tmout_pat;
-	while (status != 0xff && (status & ATA_BUSY) &&
-	       time_before(jiffies, timeout)) {
-		msleep(50);
-		status = ata_busy_wait(ap, ATA_BUSY, 3);
-	}
-
-	if (status != 0xff && (status & ATA_BUSY))
-		ata_port_printk(ap, KERN_WARNING,
-				"port is slow to respond, please be patient "
-				"(Status 0x%x)\n", status);
-
-	timeout = timer_start + tmout;
-	while (status != 0xff && (status & ATA_BUSY) &&
-	       time_before(jiffies, timeout)) {
-		msleep(50);
-		status = ata_chk_status(ap);
-	}
-
-	if (status == 0xff)
-		return -ENODEV;
-
-	if (status & ATA_BUSY) {
-		ata_port_printk(ap, KERN_ERR, "port failed to respond "
-				"(%lu secs, Status 0x%x)\n",
-				tmout / HZ, status);
-		return -EBUSY;
-	}
-
-	return 0;
-}
-
-/**
- *	ata_wait_after_reset - wait before checking status after reset
- *	@ap: port containing status register to be polled
- *	@deadline: deadline jiffies for the operation
- *
- *	After reset, we need to pause a while before reading status.
- *	Also, certain combination of controller and device report 0xff
- *	for some duration (e.g. until SATA PHY is up and running)
- *	which is interpreted as empty port in ATA world.  This
- *	function also waits for such devices to get out of 0xff
- *	status.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep).
- */
-void ata_wait_after_reset(struct ata_port *ap, unsigned long deadline)
-{
-	unsigned long until = jiffies + ATA_TMOUT_FF_WAIT;
-
-	if (time_before(until, deadline))
-		deadline = until;
-
-	/* Spec mandates ">= 2ms" before checking status.  We wait
-	 * 150ms, because that was the magic delay used for ATAPI
-	 * devices in Hale Landis's ATADRVR, for the period of time
-	 * between when the ATA command register is written, and then
-	 * status is checked.  Because waiting for "a while" before
-	 * checking status is fine, post SRST, we perform this magic
-	 * delay here as well.
-	 *
-	 * Old drivers/ide uses the 2mS rule and then waits for ready.
-	 */
-	msleep(150);
-
-	/* Wait for 0xff to clear.  Some SATA devices take a long time
-	 * to clear 0xff after reset.  For example, HHD424020F7SV00
-	 * iVDR needs >= 800ms while.  Quantum GoVault needs even more
-	 * than that.
-	 *
-	 * Note that some PATA controllers (pata_ali) explode if
-	 * status register is read more than once when there's no
-	 * device attached.
-	 */
-	if (ap->flags & ATA_FLAG_SATA) {
-		while (1) {
-			u8 status = ata_chk_status(ap);
-
-			if (status != 0xff || time_after(jiffies, deadline))
-				return;
-
-			msleep(50);
-		}
-	}
-}
-
-/**
- *	ata_wait_ready - sleep until BSY clears, or timeout
- *	@ap: port containing status register to be polled
- *	@deadline: deadline jiffies for the operation
- *
- *	Sleep until ATA Status register bit BSY clears, or timeout
- *	occurs.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep).
- *
- *	RETURNS:
- *	0 on success, -errno otherwise.
- */
-int ata_wait_ready(struct ata_port *ap, unsigned long deadline)
-{
-	unsigned long start = jiffies;
-	int warned = 0;
-
-	while (1) {
-		u8 status = ata_chk_status(ap);
-		unsigned long now = jiffies;
-
-		if (!(status & ATA_BUSY))
-			return 0;
-		if (!ata_link_online(&ap->link) && status == 0xff)
-			return -ENODEV;
-		if (time_after(now, deadline))
-			return -EBUSY;
-
-		if (!warned && time_after(now, start + 5 * HZ) &&
-		    (deadline - now > 3 * HZ)) {
-			ata_port_printk(ap, KERN_WARNING,
-				"port is slow to respond, please be patient "
-				"(Status 0x%x)\n", status);
-			warned = 1;
-		}
-
-		msleep(50);
-	}
-}
-
-static int ata_bus_post_reset(struct ata_port *ap, unsigned int devmask,
-			      unsigned long deadline)
-{
-	struct ata_ioports *ioaddr = &ap->ioaddr;
-	unsigned int dev0 = devmask & (1 << 0);
-	unsigned int dev1 = devmask & (1 << 1);
-	int rc, ret = 0;
-
-	/* if device 0 was found in ata_devchk, wait for its
-	 * BSY bit to clear
-	 */
-	if (dev0) {
-		rc = ata_wait_ready(ap, deadline);
-		if (rc) {
-			if (rc != -ENODEV)
-				return rc;
-			ret = rc;
-		}
-	}
-
-	/* if device 1 was found in ata_devchk, wait for register
-	 * access briefly, then wait for BSY to clear.
-	 */
-	if (dev1) {
-		int i;
-
-		ap->ops->dev_select(ap, 1);
-
-		/* Wait for register access.  Some ATAPI devices fail
-		 * to set nsect/lbal after reset, so don't waste too
-		 * much time on it.  We're gonna wait for !BSY anyway.
-		 */
-		for (i = 0; i < 2; i++) {
-			u8 nsect, lbal;
-
-			nsect = ioread8(ioaddr->nsect_addr);
-			lbal = ioread8(ioaddr->lbal_addr);
-			if ((nsect == 1) && (lbal == 1))
-				break;
-			msleep(50);	/* give drive a breather */
-		}
-
-		rc = ata_wait_ready(ap, deadline);
-		if (rc) {
-			if (rc != -ENODEV)
-				return rc;
-			ret = rc;
-		}
-	}
-
-	/* is all this really necessary? */
-	ap->ops->dev_select(ap, 0);
-	if (dev1)
-		ap->ops->dev_select(ap, 1);
-	if (dev0)
-		ap->ops->dev_select(ap, 0);
-
-	return ret;
-}
-
-static int ata_bus_softreset(struct ata_port *ap, unsigned int devmask,
-			     unsigned long deadline)
-{
-	struct ata_ioports *ioaddr = &ap->ioaddr;
-
-	DPRINTK("ata%u: bus reset via SRST\n", ap->print_id);
-
-	/* software reset.  causes dev0 to be selected */
-	iowrite8(ap->ctl, ioaddr->ctl_addr);
-	udelay(20);	/* FIXME: flush */
-	iowrite8(ap->ctl | ATA_SRST, ioaddr->ctl_addr);
-	udelay(20);	/* FIXME: flush */
-	iowrite8(ap->ctl, ioaddr->ctl_addr);
-
-	/* wait a while before checking status */
-	ata_wait_after_reset(ap, deadline);
-
-	/* Before we perform post reset processing we want to see if
-	 * the bus shows 0xFF because the odd clown forgets the D7
-	 * pulldown resistor.
-	 */
-	if (ata_chk_status(ap) == 0xFF)
-		return -ENODEV;
-
-	return ata_bus_post_reset(ap, devmask, deadline);
-}
-
-/**
- *	ata_bus_reset - reset host port and associated ATA channel
- *	@ap: port to reset
- *
- *	This is typically the first time we actually start issuing
- *	commands to the ATA channel.  We wait for BSY to clear, then
- *	issue EXECUTE DEVICE DIAGNOSTIC command, polling for its
- *	result.  Determine what devices, if any, are on the channel
- *	by looking at the device 0/1 error register.  Look at the signature
- *	stored in each device's taskfile registers, to determine if
- *	the device is ATA or ATAPI.
- *
- *	LOCKING:
- *	PCI/etc. bus probe sem.
- *	Obtains host lock.
- *
- *	SIDE EFFECTS:
- *	Sets ATA_FLAG_DISABLED if bus reset fails.
- */
-
-void ata_bus_reset(struct ata_port *ap)
-{
-	struct ata_device *device = ap->link.device;
-	struct ata_ioports *ioaddr = &ap->ioaddr;
-	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
-	u8 err;
-	unsigned int dev0, dev1 = 0, devmask = 0;
-	int rc;
-
-	DPRINTK("ENTER, host %u, port %u\n", ap->print_id, ap->port_no);
-
-	/* determine if device 0/1 are present */
-	if (ap->flags & ATA_FLAG_SATA_RESET)
-		dev0 = 1;
-	else {
-		dev0 = ata_devchk(ap, 0);
-		if (slave_possible)
-			dev1 = ata_devchk(ap, 1);
-	}
-
-	if (dev0)
-		devmask |= (1 << 0);
-	if (dev1)
-		devmask |= (1 << 1);
-
-	/* select device 0 again */
-	ap->ops->dev_select(ap, 0);
-
-	/* issue bus reset */
-	if (ap->flags & ATA_FLAG_SRST) {
-		rc = ata_bus_softreset(ap, devmask, jiffies + 40 * HZ);
-		if (rc && rc != -ENODEV)
-			goto err_out;
-	}
-
-	/*
-	 * determine by signature whether we have ATA or ATAPI devices
-	 */
-	device[0].class = ata_dev_try_classify(&device[0], dev0, &err);
-	if ((slave_possible) && (err != 0x81))
-		device[1].class = ata_dev_try_classify(&device[1], dev1, &err);
-
-	/* is double-select really necessary? */
-	if (device[1].class != ATA_DEV_NONE)
-		ap->ops->dev_select(ap, 1);
-	if (device[0].class != ATA_DEV_NONE)
-		ap->ops->dev_select(ap, 0);
-
-	/* if no devices were detected, disable this port */
-	if ((device[0].class == ATA_DEV_NONE) &&
-	    (device[1].class == ATA_DEV_NONE))
-		goto err_out;
-
-	if (ap->flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST)) {
-		/* set up device control for ATA_FLAG_SATA_RESET */
-		iowrite8(ap->ctl, ioaddr->ctl_addr);
-	}
-
-	DPRINTK("EXIT\n");
-	return;
-
-err_out:
-	ata_port_printk(ap, KERN_ERR, "disabling port\n");
-	ata_port_disable(ap);
-
-	DPRINTK("EXIT\n");
-}
-
-/**
  *	sata_link_debounce - debounce SATA phy status
  *	@link: ATA link to debounce SATA phy status for
  *	@params: timing parameters { interval, duratinon, timeout } in msec
@@ -3996,66 +3440,6 @@ int ata_std_prereset(struct ata_link *link, unsigned long deadline)
 }
 
 /**
- *	ata_std_softreset - reset host port via ATA SRST
- *	@link: ATA link to reset
- *	@classes: resulting classes of attached devices
- *	@deadline: deadline jiffies for the operation
- *
- *	Reset host port using ATA SRST.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep)
- *
- *	RETURNS:
- *	0 on success, -errno otherwise.
- */
-int ata_std_softreset(struct ata_link *link, unsigned int *classes,
-		      unsigned long deadline)
-{
-	struct ata_port *ap = link->ap;
-	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
-	unsigned int devmask = 0;
-	int rc;
-	u8 err;
-
-	DPRINTK("ENTER\n");
-
-	if (ata_link_offline(link)) {
-		classes[0] = ATA_DEV_NONE;
-		goto out;
-	}
-
-	/* determine if device 0/1 are present */
-	if (ata_devchk(ap, 0))
-		devmask |= (1 << 0);
-	if (slave_possible && ata_devchk(ap, 1))
-		devmask |= (1 << 1);
-
-	/* select device 0 again */
-	ap->ops->dev_select(ap, 0);
-
-	/* issue bus reset */
-	DPRINTK("about to softreset, devmask=%x\n", devmask);
-	rc = ata_bus_softreset(ap, devmask, deadline);
-	/* if link is occupied, -ENODEV too is an error */
-	if (rc && (rc != -ENODEV || sata_scr_valid(link))) {
-		ata_link_printk(link, KERN_ERR, "SRST failed (errno=%d)\n", rc);
-		return rc;
-	}
-
-	/* determine by signature whether we have ATA or ATAPI devices */
-	classes[0] = ata_dev_try_classify(&link->device[0],
-					  devmask & (1 << 0), &err);
-	if (slave_possible && err != 0x81)
-		classes[1] = ata_dev_try_classify(&link->device[1],
-						  devmask & (1 << 1), &err);
-
- out:
-	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
-	return 0;
-}
-
-/**
  *	sata_link_hardreset - reset link via SATA phy reset
  *	@link: link to reset
  *	@timing: timing parameters { interval, duratinon, timeout } in msec
@@ -4116,74 +3500,6 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 }
 
 /**
- *	sata_std_hardreset - reset host port via SATA phy reset
- *	@link: link to reset
- *	@class: resulting class of attached device
- *	@deadline: deadline jiffies for the operation
- *
- *	SATA phy-reset host port using DET bits of SControl register,
- *	wait for !BSY and classify the attached device.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep)
- *
- *	RETURNS:
- *	0 on success, -errno otherwise.
- */
-int sata_std_hardreset(struct ata_link *link, unsigned int *class,
-		       unsigned long deadline)
-{
-	struct ata_port *ap = link->ap;
-	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
-	int rc;
-
-	DPRINTK("ENTER\n");
-
-	/* do hardreset */
-	rc = sata_link_hardreset(link, timing, deadline);
-	if (rc) {
-		ata_link_printk(link, KERN_ERR,
-				"COMRESET failed (errno=%d)\n", rc);
-		return rc;
-	}
-
-	/* TODO: phy layer with polling, timeouts, etc. */
-	if (ata_link_offline(link)) {
-		*class = ATA_DEV_NONE;
-		DPRINTK("EXIT, link offline\n");
-		return 0;
-	}
-
-	/* wait a while before checking status */
-	ata_wait_after_reset(ap, deadline);
-
-	/* If PMP is supported, we have to do follow-up SRST.  Note
-	 * that some PMPs don't send D2H Reg FIS after hardreset at
-	 * all if the first port is empty.  Wait for it just for a
-	 * second and request follow-up SRST.
-	 */
-	if (ap->flags & ATA_FLAG_PMP) {
-		ata_wait_ready(ap, jiffies + HZ);
-		return -EAGAIN;
-	}
-
-	rc = ata_wait_ready(ap, deadline);
-	/* link occupied, -ENODEV too is an error */
-	if (rc) {
-		ata_link_printk(link, KERN_ERR,
-				"COMRESET failed (errno=%d)\n", rc);
-		return rc;
-	}
-
-	ap->ops->dev_select(ap, 0);	/* probably unnecessary */
-
-	*class = ata_dev_try_classify(link->device, 1, NULL);
-
-	DPRINTK("EXIT, class=%u\n", *class);
-	return 0;
-}
-
-/**
  *	ata_std_postreset - standard postreset callback
  *	@link: the target ata_link
  *	@classes: classes of attached devices
@@ -4766,112 +4082,6 @@ void ata_sg_clean(struct ata_queued_cmd *qc)
 }
 
 /**
- *	ata_fill_sg - Fill PCI IDE PRD table
- *	@qc: Metadata associated with taskfile to be transferred
- *
- *	Fill PCI IDE PRD (scatter-gather) table with segments
- *	associated with the current disk command.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- *
- */
-static void ata_fill_sg(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	struct scatterlist *sg;
-	unsigned int si, pi;
-
-	pi = 0;
-	for_each_sg(qc->sg, sg, qc->n_elem, si) {
-		u32 addr, offset;
-		u32 sg_len, len;
-
-		/* determine if physical DMA addr spans 64K boundary.
-		 * Note h/w doesn't support 64-bit, so we unconditionally
-		 * truncate dma_addr_t to u32.
-		 */
-		addr = (u32) sg_dma_address(sg);
-		sg_len = sg_dma_len(sg);
-
-		while (sg_len) {
-			offset = addr & 0xffff;
-			len = sg_len;
-			if ((offset + sg_len) > 0x10000)
-				len = 0x10000 - offset;
-
-			ap->prd[pi].addr = cpu_to_le32(addr);
-			ap->prd[pi].flags_len = cpu_to_le32(len & 0xffff);
-			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", pi, addr, len);
-
-			pi++;
-			sg_len -= len;
-			addr += len;
-		}
-	}
-
-	ap->prd[pi - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
-}
-
-/**
- *	ata_fill_sg_dumb - Fill PCI IDE PRD table
- *	@qc: Metadata associated with taskfile to be transferred
- *
- *	Fill PCI IDE PRD (scatter-gather) table with segments
- *	associated with the current disk command. Perform the fill
- *	so that we avoid writing any length 64K records for
- *	controllers that don't follow the spec.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- *
- */
-static void ata_fill_sg_dumb(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	struct scatterlist *sg;
-	unsigned int si, pi;
-
-	pi = 0;
-	for_each_sg(qc->sg, sg, qc->n_elem, si) {
-		u32 addr, offset;
-		u32 sg_len, len, blen;
-
-		/* determine if physical DMA addr spans 64K boundary.
-		 * Note h/w doesn't support 64-bit, so we unconditionally
-		 * truncate dma_addr_t to u32.
-		 */
-		addr = (u32) sg_dma_address(sg);
-		sg_len = sg_dma_len(sg);
-
-		while (sg_len) {
-			offset = addr & 0xffff;
-			len = sg_len;
-			if ((offset + sg_len) > 0x10000)
-				len = 0x10000 - offset;
-
-			blen = len & 0xffff;
-			ap->prd[pi].addr = cpu_to_le32(addr);
-			if (blen == 0) {
-			   /* Some PATA chipsets like the CS5530 can't
-			      cope with 0x0000 meaning 64K as the spec says */
-				ap->prd[pi].flags_len = cpu_to_le32(0x8000);
-				blen = 0x8000;
-				ap->prd[++pi].addr = cpu_to_le32(addr + 0x8000);
-			}
-			ap->prd[pi].flags_len = cpu_to_le32(blen);
-			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", pi, addr, len);
-
-			pi++;
-			sg_len -= len;
-			addr += len;
-		}
-	}
-
-	ap->prd[pi - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
-}
-
-/**
  *	ata_check_atapi_dma - Check whether ATAPI DMA can be supported
  *	@qc: Metadata associated with taskfile to check
  *
@@ -4931,40 +4141,6 @@ int ata_std_qc_defer(struct ata_queued_cmd *qc)
 	return ATA_DEFER_LINK;
 }
 
-/**
- *	ata_qc_prep - Prepare taskfile for submission
- *	@qc: Metadata associated with taskfile to be prepared
- *
- *	Prepare ATA taskfile for submission.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-void ata_qc_prep(struct ata_queued_cmd *qc)
-{
-	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
-		return;
-
-	ata_fill_sg(qc);
-}
-
-/**
- *	ata_dumb_qc_prep - Prepare taskfile for submission
- *	@qc: Metadata associated with taskfile to be prepared
- *
- *	Prepare ATA taskfile for submission.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-void ata_dumb_qc_prep(struct ata_queued_cmd *qc)
-{
-	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
-		return;
-
-	ata_fill_sg_dumb(qc);
-}
-
 void ata_noop_qc_prep(struct ata_queued_cmd *qc) { }
 
 /**
@@ -5043,698 +4219,6 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
 }
 
 /**
- *	ata_data_xfer - Transfer data by PIO
- *	@dev: device to target
- *	@buf: data buffer
- *	@buflen: buffer length
- *	@rw: read/write
- *
- *	Transfer data from/to the device data register by PIO.
- *
- *	LOCKING:
- *	Inherited from caller.
- *
- *	RETURNS:
- *	Bytes consumed.
- */
-unsigned int ata_data_xfer(struct ata_device *dev, unsigned char *buf,
-			   unsigned int buflen, int rw)
-{
-	struct ata_port *ap = dev->link->ap;
-	void __iomem *data_addr = ap->ioaddr.data_addr;
-	unsigned int words = buflen >> 1;
-
-	/* Transfer multiple of 2 bytes */
-	if (rw == READ)
-		ioread16_rep(data_addr, buf, words);
-	else
-		iowrite16_rep(data_addr, buf, words);
-
-	/* Transfer trailing 1 byte, if any. */
-	if (unlikely(buflen & 0x01)) {
-		__le16 align_buf[1] = { 0 };
-		unsigned char *trailing_buf = buf + buflen - 1;
-
-		if (rw == READ) {
-			align_buf[0] = cpu_to_le16(ioread16(data_addr));
-			memcpy(trailing_buf, align_buf, 1);
-		} else {
-			memcpy(align_buf, trailing_buf, 1);
-			iowrite16(le16_to_cpu(align_buf[0]), data_addr);
-		}
-		words++;
-	}
-
-	return words << 1;
-}
-
-/**
- *	ata_data_xfer_noirq - Transfer data by PIO
- *	@dev: device to target
- *	@buf: data buffer
- *	@buflen: buffer length
- *	@rw: read/write
- *
- *	Transfer data from/to the device data register by PIO. Do the
- *	transfer with interrupts disabled.
- *
- *	LOCKING:
- *	Inherited from caller.
- *
- *	RETURNS:
- *	Bytes consumed.
- */
-unsigned int ata_data_xfer_noirq(struct ata_device *dev, unsigned char *buf,
-				 unsigned int buflen, int rw)
-{
-	unsigned long flags;
-	unsigned int consumed;
-
-	local_irq_save(flags);
-	consumed = ata_data_xfer(dev, buf, buflen, rw);
-	local_irq_restore(flags);
-
-	return consumed;
-}
-
-
-/**
- *	ata_pio_sector - Transfer a sector of data.
- *	@qc: Command on going
- *
- *	Transfer qc->sect_size bytes of data from/to the ATA device.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
-static void ata_pio_sector(struct ata_queued_cmd *qc)
-{
-	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
-	struct ata_port *ap = qc->ap;
-	struct page *page;
-	unsigned int offset;
-	unsigned char *buf;
-
-	if (qc->curbytes == qc->nbytes - qc->sect_size)
-		ap->hsm_task_state = HSM_ST_LAST;
-
-	page = sg_page(qc->cursg);
-	offset = qc->cursg->offset + qc->cursg_ofs;
-
-	/* get the current page and offset */
-	page = nth_page(page, (offset >> PAGE_SHIFT));
-	offset %= PAGE_SIZE;
-
-	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
-
-	if (PageHighMem(page)) {
-		unsigned long flags;
-
-		/* FIXME: use a bounce buffer */
-		local_irq_save(flags);
-		buf = kmap_atomic(page, KM_IRQ0);
-
-		/* do the actual data transfer */
-		ap->ops->data_xfer(qc->dev, buf + offset, qc->sect_size, do_write);
-
-		kunmap_atomic(buf, KM_IRQ0);
-		local_irq_restore(flags);
-	} else {
-		buf = page_address(page);
-		ap->ops->data_xfer(qc->dev, buf + offset, qc->sect_size, do_write);
-	}
-
-	qc->curbytes += qc->sect_size;
-	qc->cursg_ofs += qc->sect_size;
-
-	if (qc->cursg_ofs == qc->cursg->length) {
-		qc->cursg = sg_next(qc->cursg);
-		qc->cursg_ofs = 0;
-	}
-}
-
-/**
- *	ata_pio_sectors - Transfer one or many sectors.
- *	@qc: Command on going
- *
- *	Transfer one or many sectors of data from/to the
- *	ATA device for the DRQ request.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
-static void ata_pio_sectors(struct ata_queued_cmd *qc)
-{
-	if (is_multi_taskfile(&qc->tf)) {
-		/* READ/WRITE MULTIPLE */
-		unsigned int nsect;
-
-		WARN_ON(qc->dev->multi_count == 0);
-
-		nsect = min((qc->nbytes - qc->curbytes) / qc->sect_size,
-			    qc->dev->multi_count);
-		while (nsect--)
-			ata_pio_sector(qc);
-	} else
-		ata_pio_sector(qc);
-
-	ata_altstatus(qc->ap); /* flush */
-}
-
-/**
- *	atapi_send_cdb - Write CDB bytes to hardware
- *	@ap: Port to which ATAPI device is attached.
- *	@qc: Taskfile currently active
- *
- *	When device has indicated its readiness to accept
- *	a CDB, this function is called.  Send the CDB.
- *
- *	LOCKING:
- *	caller.
- */
-
-static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
-{
-	/* send SCSI cdb */
-	DPRINTK("send cdb\n");
-	WARN_ON(qc->dev->cdb_len < 12);
-
-	ap->ops->data_xfer(qc->dev, qc->cdb, qc->dev->cdb_len, 1);
-	ata_altstatus(ap); /* flush */
-
-	switch (qc->tf.protocol) {
-	case ATAPI_PROT_PIO:
-		ap->hsm_task_state = HSM_ST;
-		break;
-	case ATAPI_PROT_NODATA:
-		ap->hsm_task_state = HSM_ST_LAST;
-		break;
-	case ATAPI_PROT_DMA:
-		ap->hsm_task_state = HSM_ST_LAST;
-		/* initiate bmdma */
-		ap->ops->bmdma_start(qc);
-		break;
-	}
-}
-
-/**
- *	__atapi_pio_bytes - Transfer data from/to the ATAPI device.
- *	@qc: Command on going
- *	@bytes: number of bytes
- *
- *	Transfer Transfer data from/to the ATAPI device.
- *
- *	LOCKING:
- *	Inherited from caller.
- *
- */
-static int __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
-{
-	int rw = (qc->tf.flags & ATA_TFLAG_WRITE) ? WRITE : READ;
-	struct ata_port *ap = qc->ap;
-	struct ata_device *dev = qc->dev;
-	struct ata_eh_info *ehi = &dev->link->eh_info;
-	struct scatterlist *sg;
-	struct page *page;
-	unsigned char *buf;
-	unsigned int offset, count, consumed;
-
-next_sg:
-	sg = qc->cursg;
-	if (unlikely(!sg)) {
-		ata_ehi_push_desc(ehi, "unexpected or too much trailing data "
-				  "buf=%u cur=%u bytes=%u",
-				  qc->nbytes, qc->curbytes, bytes);
-		return -1;
-	}
-
-	page = sg_page(sg);
-	offset = sg->offset + qc->cursg_ofs;
-
-	/* get the current page and offset */
-	page = nth_page(page, (offset >> PAGE_SHIFT));
-	offset %= PAGE_SIZE;
-
-	/* don't overrun current sg */
-	count = min(sg->length - qc->cursg_ofs, bytes);
-
-	/* don't cross page boundaries */
-	count = min(count, (unsigned int)PAGE_SIZE - offset);
-
-	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
-
-	if (PageHighMem(page)) {
-		unsigned long flags;
-
-		/* FIXME: use bounce buffer */
-		local_irq_save(flags);
-		buf = kmap_atomic(page, KM_IRQ0);
-
-		/* do the actual data transfer */
-		consumed = ap->ops->data_xfer(dev,  buf + offset, count, rw);
-
-		kunmap_atomic(buf, KM_IRQ0);
-		local_irq_restore(flags);
-	} else {
-		buf = page_address(page);
-		consumed = ap->ops->data_xfer(dev,  buf + offset, count, rw);
-	}
-
-	bytes -= min(bytes, consumed);
-	qc->curbytes += count;
-	qc->cursg_ofs += count;
-
-	if (qc->cursg_ofs == sg->length) {
-		qc->cursg = sg_next(qc->cursg);
-		qc->cursg_ofs = 0;
-	}
-
-	/* consumed can be larger than count only for the last transfer */
-	WARN_ON(qc->cursg && count != consumed);
-
-	if (bytes)
-		goto next_sg;
-	return 0;
-}
-
-/**
- *	atapi_pio_bytes - Transfer data from/to the ATAPI device.
- *	@qc: Command on going
- *
- *	Transfer Transfer data from/to the ATAPI device.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
-static void atapi_pio_bytes(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	struct ata_device *dev = qc->dev;
-	struct ata_eh_info *ehi = &dev->link->eh_info;
-	unsigned int ireason, bc_lo, bc_hi, bytes;
-	int i_write, do_write = (qc->tf.flags & ATA_TFLAG_WRITE) ? 1 : 0;
-
-	/* Abuse qc->result_tf for temp storage of intermediate TF
-	 * here to save some kernel stack usage.
-	 * For normal completion, qc->result_tf is not relevant. For
-	 * error, qc->result_tf is later overwritten by ata_qc_complete().
-	 * So, the correctness of qc->result_tf is not affected.
-	 */
-	ap->ops->tf_read(ap, &qc->result_tf);
-	ireason = qc->result_tf.nsect;
-	bc_lo = qc->result_tf.lbam;
-	bc_hi = qc->result_tf.lbah;
-	bytes = (bc_hi << 8) | bc_lo;
-
-	/* shall be cleared to zero, indicating xfer of data */
-	if (unlikely(ireason & (1 << 0)))
-		goto atapi_check;
-
-	/* make sure transfer direction matches expected */
-	i_write = ((ireason & (1 << 1)) == 0) ? 1 : 0;
-	if (unlikely(do_write != i_write))
-		goto atapi_check;
-
-	if (unlikely(!bytes))
-		goto atapi_check;
-
-	VPRINTK("ata%u: xfering %d bytes\n", ap->print_id, bytes);
-
-	if (unlikely(__atapi_pio_bytes(qc, bytes)))
-		goto err_out;
-	ata_altstatus(ap); /* flush */
-
-	return;
-
- atapi_check:
-	ata_ehi_push_desc(ehi, "ATAPI check failed (ireason=0x%x bytes=%u)",
-			  ireason, bytes);
- err_out:
-	qc->err_mask |= AC_ERR_HSM;
-	ap->hsm_task_state = HSM_ST_ERR;
-}
-
-/**
- *	ata_hsm_ok_in_wq - Check if the qc can be handled in the workqueue.
- *	@ap: the target ata_port
- *	@qc: qc on going
- *
- *	RETURNS:
- *	1 if ok in workqueue, 0 otherwise.
- */
-
-static inline int ata_hsm_ok_in_wq(struct ata_port *ap, struct ata_queued_cmd *qc)
-{
-	if (qc->tf.flags & ATA_TFLAG_POLLING)
-		return 1;
-
-	if (ap->hsm_task_state == HSM_ST_FIRST) {
-		if (qc->tf.protocol == ATA_PROT_PIO &&
-		    (qc->tf.flags & ATA_TFLAG_WRITE))
-		    return 1;
-
-		if (ata_is_atapi(qc->tf.protocol) &&
-		    !(qc->dev->flags & ATA_DFLAG_CDB_INTR))
-			return 1;
-	}
-
-	return 0;
-}
-
-/**
- *	ata_hsm_qc_complete - finish a qc running on standard HSM
- *	@qc: Command to complete
- *	@in_wq: 1 if called from workqueue, 0 otherwise
- *
- *	Finish @qc which is running on standard HSM.
- *
- *	LOCKING:
- *	If @in_wq is zero, spin_lock_irqsave(host lock).
- *	Otherwise, none on entry and grabs host lock.
- */
-static void ata_hsm_qc_complete(struct ata_queued_cmd *qc, int in_wq)
-{
-	struct ata_port *ap = qc->ap;
-	unsigned long flags;
-
-	if (ap->ops->error_handler) {
-		if (in_wq) {
-			spin_lock_irqsave(ap->lock, flags);
-
-			/* EH might have kicked in while host lock is
-			 * released.
-			 */
-			qc = ata_qc_from_tag(ap, qc->tag);
-			if (qc) {
-				if (likely(!(qc->err_mask & AC_ERR_HSM))) {
-					ap->ops->irq_on(ap);
-					ata_qc_complete(qc);
-				} else
-					ata_port_freeze(ap);
-			}
-
-			spin_unlock_irqrestore(ap->lock, flags);
-		} else {
-			if (likely(!(qc->err_mask & AC_ERR_HSM)))
-				ata_qc_complete(qc);
-			else
-				ata_port_freeze(ap);
-		}
-	} else {
-		if (in_wq) {
-			spin_lock_irqsave(ap->lock, flags);
-			ap->ops->irq_on(ap);
-			ata_qc_complete(qc);
-			spin_unlock_irqrestore(ap->lock, flags);
-		} else
-			ata_qc_complete(qc);
-	}
-}
-
-/**
- *	ata_hsm_move - move the HSM to the next state.
- *	@ap: the target ata_port
- *	@qc: qc on going
- *	@status: current device status
- *	@in_wq: 1 if called from workqueue, 0 otherwise
- *
- *	RETURNS:
- *	1 when poll next status needed, 0 otherwise.
- */
-int ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
-		 u8 status, int in_wq)
-{
-	unsigned long flags = 0;
-	int poll_next;
-
-	WARN_ON((qc->flags & ATA_QCFLAG_ACTIVE) == 0);
-
-	/* Make sure ata_qc_issue_prot() does not throw things
-	 * like DMA polling into the workqueue. Notice that
-	 * in_wq is not equivalent to (qc->tf.flags & ATA_TFLAG_POLLING).
-	 */
-	WARN_ON(in_wq != ata_hsm_ok_in_wq(ap, qc));
-
-fsm_start:
-	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
-		ap->print_id, qc->tf.protocol, ap->hsm_task_state, status);
-
-	switch (ap->hsm_task_state) {
-	case HSM_ST_FIRST:
-		/* Send first data block or PACKET CDB */
-
-		/* If polling, we will stay in the work queue after
-		 * sending the data. Otherwise, interrupt handler
-		 * takes over after sending the data.
-		 */
-		poll_next = (qc->tf.flags & ATA_TFLAG_POLLING);
-
-		/* check device status */
-		if (unlikely((status & ATA_DRQ) == 0)) {
-			/* handle BSY=0, DRQ=0 as error */
-			if (likely(status & (ATA_ERR | ATA_DF)))
-				/* device stops HSM for abort/error */
-				qc->err_mask |= AC_ERR_DEV;
-			else
-				/* HSM violation. Let EH handle this */
-				qc->err_mask |= AC_ERR_HSM;
-
-			ap->hsm_task_state = HSM_ST_ERR;
-			goto fsm_start;
-		}
-
-		/* Device should not ask for data transfer (DRQ=1)
-		 * when it finds something wrong.
-		 * We ignore DRQ here and stop the HSM by
-		 * changing hsm_task_state to HSM_ST_ERR and
-		 * let the EH abort the command or reset the device.
-		 */
-		if (unlikely(status & (ATA_ERR | ATA_DF))) {
-			/* Some ATAPI tape drives forget to clear the ERR bit
-			 * when doing the next command (mostly request sense).
-			 * We ignore ERR here to workaround and proceed sending
-			 * the CDB.
-			 */
-			if (!(qc->dev->horkage & ATA_HORKAGE_STUCK_ERR)) {
-				ata_port_printk(ap, KERN_WARNING,
-						"DRQ=1 with device error, "
-						"dev_stat 0x%X\n", status);
-				qc->err_mask |= AC_ERR_HSM;
-				ap->hsm_task_state = HSM_ST_ERR;
-				goto fsm_start;
-			}
-		}
-
-		/* Send the CDB (atapi) or the first data block (ata pio out).
-		 * During the state transition, interrupt handler shouldn't
-		 * be invoked before the data transfer is complete and
-		 * hsm_task_state is changed. Hence, the following locking.
-		 */
-		if (in_wq)
-			spin_lock_irqsave(ap->lock, flags);
-
-		if (qc->tf.protocol == ATA_PROT_PIO) {
-			/* PIO data out protocol.
-			 * send first data block.
-			 */
-
-			/* ata_pio_sectors() might change the state
-			 * to HSM_ST_LAST. so, the state is changed here
-			 * before ata_pio_sectors().
-			 */
-			ap->hsm_task_state = HSM_ST;
-			ata_pio_sectors(qc);
-		} else
-			/* send CDB */
-			atapi_send_cdb(ap, qc);
-
-		if (in_wq)
-			spin_unlock_irqrestore(ap->lock, flags);
-
-		/* if polling, ata_pio_task() handles the rest.
-		 * otherwise, interrupt handler takes over from here.
-		 */
-		break;
-
-	case HSM_ST:
-		/* complete command or read/write the data register */
-		if (qc->tf.protocol == ATAPI_PROT_PIO) {
-			/* ATAPI PIO protocol */
-			if ((status & ATA_DRQ) == 0) {
-				/* No more data to transfer or device error.
-				 * Device error will be tagged in HSM_ST_LAST.
-				 */
-				ap->hsm_task_state = HSM_ST_LAST;
-				goto fsm_start;
-			}
-
-			/* Device should not ask for data transfer (DRQ=1)
-			 * when it finds something wrong.
-			 * We ignore DRQ here and stop the HSM by
-			 * changing hsm_task_state to HSM_ST_ERR and
-			 * let the EH abort the command or reset the device.
-			 */
-			if (unlikely(status & (ATA_ERR | ATA_DF))) {
-				ata_port_printk(ap, KERN_WARNING, "DRQ=1 with "
-						"device error, dev_stat 0x%X\n",
-						status);
-				qc->err_mask |= AC_ERR_HSM;
-				ap->hsm_task_state = HSM_ST_ERR;
-				goto fsm_start;
-			}
-
-			atapi_pio_bytes(qc);
-
-			if (unlikely(ap->hsm_task_state == HSM_ST_ERR))
-				/* bad ireason reported by device */
-				goto fsm_start;
-
-		} else {
-			/* ATA PIO protocol */
-			if (unlikely((status & ATA_DRQ) == 0)) {
-				/* handle BSY=0, DRQ=0 as error */
-				if (likely(status & (ATA_ERR | ATA_DF)))
-					/* device stops HSM for abort/error */
-					qc->err_mask |= AC_ERR_DEV;
-				else
-					/* HSM violation. Let EH handle this.
-					 * Phantom devices also trigger this
-					 * condition.  Mark hint.
-					 */
-					qc->err_mask |= AC_ERR_HSM |
-							AC_ERR_NODEV_HINT;
-
-				ap->hsm_task_state = HSM_ST_ERR;
-				goto fsm_start;
-			}
-
-			/* For PIO reads, some devices may ask for
-			 * data transfer (DRQ=1) alone with ERR=1.
-			 * We respect DRQ here and transfer one
-			 * block of junk data before changing the
-			 * hsm_task_state to HSM_ST_ERR.
-			 *
-			 * For PIO writes, ERR=1 DRQ=1 doesn't make
-			 * sense since the data block has been
-			 * transferred to the device.
-			 */
-			if (unlikely(status & (ATA_ERR | ATA_DF))) {
-				/* data might be corrputed */
-				qc->err_mask |= AC_ERR_DEV;
-
-				if (!(qc->tf.flags & ATA_TFLAG_WRITE)) {
-					ata_pio_sectors(qc);
-					status = ata_wait_idle(ap);
-				}
-
-				if (status & (ATA_BUSY | ATA_DRQ))
-					qc->err_mask |= AC_ERR_HSM;
-
-				/* ata_pio_sectors() might change the
-				 * state to HSM_ST_LAST. so, the state
-				 * is changed after ata_pio_sectors().
-				 */
-				ap->hsm_task_state = HSM_ST_ERR;
-				goto fsm_start;
-			}
-
-			ata_pio_sectors(qc);
-
-			if (ap->hsm_task_state == HSM_ST_LAST &&
-			    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
-				/* all data read */
-				status = ata_wait_idle(ap);
-				goto fsm_start;
-			}
-		}
-
-		poll_next = 1;
-		break;
-
-	case HSM_ST_LAST:
-		if (unlikely(!ata_ok(status))) {
-			qc->err_mask |= __ac_err_mask(status);
-			ap->hsm_task_state = HSM_ST_ERR;
-			goto fsm_start;
-		}
-
-		/* no more data to transfer */
-		DPRINTK("ata%u: dev %u command complete, drv_stat 0x%x\n",
-			ap->print_id, qc->dev->devno, status);
-
-		WARN_ON(qc->err_mask);
-
-		ap->hsm_task_state = HSM_ST_IDLE;
-
-		/* complete taskfile transaction */
-		ata_hsm_qc_complete(qc, in_wq);
-
-		poll_next = 0;
-		break;
-
-	case HSM_ST_ERR:
-		/* make sure qc->err_mask is available to
-		 * know what's wrong and recover
-		 */
-		WARN_ON(qc->err_mask == 0);
-
-		ap->hsm_task_state = HSM_ST_IDLE;
-
-		/* complete taskfile transaction */
-		ata_hsm_qc_complete(qc, in_wq);
-
-		poll_next = 0;
-		break;
-	default:
-		poll_next = 0;
-		BUG();
-	}
-
-	return poll_next;
-}
-
-static void ata_pio_task(struct work_struct *work)
-{
-	struct ata_port *ap =
-		container_of(work, struct ata_port, port_task.work);
-	struct ata_queued_cmd *qc = ap->port_task_data;
-	u8 status;
-	int poll_next;
-
-fsm_start:
-	WARN_ON(ap->hsm_task_state == HSM_ST_IDLE);
-
-	/*
-	 * This is purely heuristic.  This is a fast path.
-	 * Sometimes when we enter, BSY will be cleared in
-	 * a chk-status or two.  If not, the drive is probably seeking
-	 * or something.  Snooze for a couple msecs, then
-	 * chk-status again.  If still busy, queue delayed work.
-	 */
-	status = ata_busy_wait(ap, ATA_BUSY, 5);
-	if (status & ATA_BUSY) {
-		msleep(2);
-		status = ata_busy_wait(ap, ATA_BUSY, 10);
-		if (status & ATA_BUSY) {
-			ata_pio_queue_task(ap, qc, ATA_SHORT_PAUSE);
-			return;
-		}
-	}
-
-	/* move the HSM */
-	poll_next = ata_hsm_move(ap, qc, status, 1);
-
-	/* another command or interrupt handler
-	 * may be running at this point.
-	 */
-	if (poll_next)
-		goto fsm_start;
-}
-
-/**
  *	ata_qc_new - Request an available ATA command, for queueing
  *	@ap: Port associated with device @dev
  *	@dev: Device from whom we request an available command structure
@@ -6084,285 +4568,6 @@ err:
 }
 
 /**
- *	ata_qc_issue_prot - issue taskfile to device in proto-dependent manner
- *	@qc: command to issue to device
- *
- *	Using various libata functions and hooks, this function
- *	starts an ATA command.  ATA commands are grouped into
- *	classes called "protocols", and issuing each type of protocol
- *	is slightly different.
- *
- *	May be used as the qc_issue() entry in ata_port_operations.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- *
- *	RETURNS:
- *	Zero on success, AC_ERR_* mask on failure
- */
-
-unsigned int ata_qc_issue_prot(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-
-	/* Use polling pio if the LLD doesn't handle
-	 * interrupt driven pio and atapi CDB interrupt.
-	 */
-	if (ap->flags & ATA_FLAG_PIO_POLLING) {
-		switch (qc->tf.protocol) {
-		case ATA_PROT_PIO:
-		case ATA_PROT_NODATA:
-		case ATAPI_PROT_PIO:
-		case ATAPI_PROT_NODATA:
-			qc->tf.flags |= ATA_TFLAG_POLLING;
-			break;
-		case ATAPI_PROT_DMA:
-			if (qc->dev->flags & ATA_DFLAG_CDB_INTR)
-				/* see ata_dma_blacklisted() */
-				BUG();
-			break;
-		default:
-			break;
-		}
-	}
-
-	/* select the device */
-	ata_dev_select(ap, qc->dev->devno, 1, 0);
-
-	/* start the command */
-	switch (qc->tf.protocol) {
-	case ATA_PROT_NODATA:
-		if (qc->tf.flags & ATA_TFLAG_POLLING)
-			ata_qc_set_polling(qc);
-
-		ata_tf_to_host(ap, &qc->tf);
-		ap->hsm_task_state = HSM_ST_LAST;
-
-		if (qc->tf.flags & ATA_TFLAG_POLLING)
-			ata_pio_queue_task(ap, qc, 0);
-
-		break;
-
-	case ATA_PROT_DMA:
-		WARN_ON(qc->tf.flags & ATA_TFLAG_POLLING);
-
-		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
-		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
-		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
-		ap->hsm_task_state = HSM_ST_LAST;
-		break;
-
-	case ATA_PROT_PIO:
-		if (qc->tf.flags & ATA_TFLAG_POLLING)
-			ata_qc_set_polling(qc);
-
-		ata_tf_to_host(ap, &qc->tf);
-
-		if (qc->tf.flags & ATA_TFLAG_WRITE) {
-			/* PIO data out protocol */
-			ap->hsm_task_state = HSM_ST_FIRST;
-			ata_pio_queue_task(ap, qc, 0);
-
-			/* always send first data block using
-			 * the ata_pio_task() codepath.
-			 */
-		} else {
-			/* PIO data in protocol */
-			ap->hsm_task_state = HSM_ST;
-
-			if (qc->tf.flags & ATA_TFLAG_POLLING)
-				ata_pio_queue_task(ap, qc, 0);
-
-			/* if polling, ata_pio_task() handles the rest.
-			 * otherwise, interrupt handler takes over from here.
-			 */
-		}
-
-		break;
-
-	case ATAPI_PROT_PIO:
-	case ATAPI_PROT_NODATA:
-		if (qc->tf.flags & ATA_TFLAG_POLLING)
-			ata_qc_set_polling(qc);
-
-		ata_tf_to_host(ap, &qc->tf);
-
-		ap->hsm_task_state = HSM_ST_FIRST;
-
-		/* send cdb by polling if no cdb interrupt */
-		if ((!(qc->dev->flags & ATA_DFLAG_CDB_INTR)) ||
-		    (qc->tf.flags & ATA_TFLAG_POLLING))
-			ata_pio_queue_task(ap, qc, 0);
-		break;
-
-	case ATAPI_PROT_DMA:
-		WARN_ON(qc->tf.flags & ATA_TFLAG_POLLING);
-
-		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
-		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
-		ap->hsm_task_state = HSM_ST_FIRST;
-
-		/* send cdb by polling if no cdb interrupt */
-		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
-			ata_pio_queue_task(ap, qc, 0);
-		break;
-
-	default:
-		WARN_ON(1);
-		return AC_ERR_SYSTEM;
-	}
-
-	return 0;
-}
-
-/**
- *	ata_host_intr - Handle host interrupt for given (port, task)
- *	@ap: Port on which interrupt arrived (possibly...)
- *	@qc: Taskfile currently active in engine
- *
- *	Handle host interrupt for given queued command.  Currently,
- *	only DMA interrupts are handled.  All other commands are
- *	handled via polling with interrupts disabled (nIEN bit).
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- *
- *	RETURNS:
- *	One if interrupt was handled, zero if not (shared irq).
- */
-
-inline unsigned int ata_host_intr(struct ata_port *ap,
-				  struct ata_queued_cmd *qc)
-{
-	struct ata_eh_info *ehi = &ap->link.eh_info;
-	u8 status, host_stat = 0;
-
-	VPRINTK("ata%u: protocol %d task_state %d\n",
-		ap->print_id, qc->tf.protocol, ap->hsm_task_state);
-
-	/* Check whether we are expecting interrupt in this state */
-	switch (ap->hsm_task_state) {
-	case HSM_ST_FIRST:
-		/* Some pre-ATAPI-4 devices assert INTRQ
-		 * at this state when ready to receive CDB.
-		 */
-
-		/* Check the ATA_DFLAG_CDB_INTR flag is enough here.
-		 * The flag was turned on only for atapi devices.  No
-		 * need to check ata_is_atapi(qc->tf.protocol) again.
-		 */
-		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
-			goto idle_irq;
-		break;
-	case HSM_ST_LAST:
-		if (qc->tf.protocol == ATA_PROT_DMA ||
-		    qc->tf.protocol == ATAPI_PROT_DMA) {
-			/* check status of DMA engine */
-			host_stat = ap->ops->bmdma_status(ap);
-			VPRINTK("ata%u: host_stat 0x%X\n",
-				ap->print_id, host_stat);
-
-			/* if it's not our irq... */
-			if (!(host_stat & ATA_DMA_INTR))
-				goto idle_irq;
-
-			/* before we do anything else, clear DMA-Start bit */
-			ap->ops->bmdma_stop(qc);
-
-			if (unlikely(host_stat & ATA_DMA_ERR)) {
-				/* error when transfering data to/from memory */
-				qc->err_mask |= AC_ERR_HOST_BUS;
-				ap->hsm_task_state = HSM_ST_ERR;
-			}
-		}
-		break;
-	case HSM_ST:
-		break;
-	default:
-		goto idle_irq;
-	}
-
-	/* check altstatus */
-	status = ata_altstatus(ap);
-	if (status & ATA_BUSY)
-		goto idle_irq;
-
-	/* check main status, clearing INTRQ */
-	status = ata_chk_status(ap);
-	if (unlikely(status & ATA_BUSY))
-		goto idle_irq;
-
-	/* ack bmdma irq events */
-	ap->ops->irq_clear(ap);
-
-	ata_hsm_move(ap, qc, status, 0);
-
-	if (unlikely(qc->err_mask) && (qc->tf.protocol == ATA_PROT_DMA ||
-				       qc->tf.protocol == ATAPI_PROT_DMA))
-		ata_ehi_push_desc(ehi, "BMDMA stat 0x%x", host_stat);
-
-	return 1;	/* irq handled */
-
-idle_irq:
-	ap->stats.idle_irq++;
-
-#ifdef ATA_IRQ_TRAP
-	if ((ap->stats.idle_irq % 1000) == 0) {
-		ata_chk_status(ap);
-		ap->ops->irq_clear(ap);
-		ata_port_printk(ap, KERN_WARNING, "irq trap\n");
-		return 1;
-	}
-#endif
-	return 0;	/* irq not handled */
-}
-
-/**
- *	ata_interrupt - Default ATA host interrupt handler
- *	@irq: irq line (unused)
- *	@dev_instance: pointer to our ata_host information structure
- *
- *	Default interrupt handler for PCI IDE devices.  Calls
- *	ata_host_intr() for each port that is not disabled.
- *
- *	LOCKING:
- *	Obtains host lock during operation.
- *
- *	RETURNS:
- *	IRQ_NONE or IRQ_HANDLED.
- */
-
-irqreturn_t ata_interrupt(int irq, void *dev_instance)
-{
-	struct ata_host *host = dev_instance;
-	unsigned int i;
-	unsigned int handled = 0;
-	unsigned long flags;
-
-	/* TODO: make _irqsave conditional on x86 PCI IDE legacy mode */
-	spin_lock_irqsave(&host->lock, flags);
-
-	for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap;
-
-		ap = host->ports[i];
-		if (ap &&
-		    !(ap->flags & ATA_FLAG_DISABLED)) {
-			struct ata_queued_cmd *qc;
-
-			qc = ata_qc_from_tag(ap, ap->link.active_tag);
-			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
-			    (qc->flags & ATA_QCFLAG_ACTIVE))
-				handled |= ata_host_intr(ap, qc);
-		}
-	}
-
-	spin_unlock_irqrestore(&host->lock, flags);
-
-	return IRQ_RETVAL(handled);
-}
-
-/**
  *	sata_scr_valid - test whether SCRs are accessible
  *	@link: ATA link to test SCR accessibility for
  *
@@ -7394,33 +5599,6 @@ void ata_host_detach(struct ata_host *host)
 	ata_acpi_dissociate(host);
 }
 
-/**
- *	ata_std_ports - initialize ioaddr with standard port offsets.
- *	@ioaddr: IO address structure to be initialized
- *
- *	Utility function which initializes data_addr, error_addr,
- *	feature_addr, nsect_addr, lbal_addr, lbam_addr, lbah_addr,
- *	device_addr, status_addr, and command_addr to standard offsets
- *	relative to cmd_addr.
- *
- *	Does not set ctl_addr, altstatus_addr, bmdma_addr, or scr_addr.
- */
-
-void ata_std_ports(struct ata_ioports *ioaddr)
-{
-	ioaddr->data_addr = ioaddr->cmd_addr + ATA_REG_DATA;
-	ioaddr->error_addr = ioaddr->cmd_addr + ATA_REG_ERR;
-	ioaddr->feature_addr = ioaddr->cmd_addr + ATA_REG_FEATURE;
-	ioaddr->nsect_addr = ioaddr->cmd_addr + ATA_REG_NSECT;
-	ioaddr->lbal_addr = ioaddr->cmd_addr + ATA_REG_LBAL;
-	ioaddr->lbam_addr = ioaddr->cmd_addr + ATA_REG_LBAM;
-	ioaddr->lbah_addr = ioaddr->cmd_addr + ATA_REG_LBAH;
-	ioaddr->device_addr = ioaddr->cmd_addr + ATA_REG_DEVICE;
-	ioaddr->status_addr = ioaddr->cmd_addr + ATA_REG_STATUS;
-	ioaddr->command_addr = ioaddr->cmd_addr + ATA_REG_CMD;
-}
-
-
 #ifdef CONFIG_PCI
 
 /**
@@ -7852,12 +6030,9 @@ EXPORT_SYMBOL_GPL(sata_deb_timing_long);
 EXPORT_SYMBOL_GPL(ata_base_port_ops);
 EXPORT_SYMBOL_GPL(sata_port_ops);
 EXPORT_SYMBOL_GPL(sata_pmp_port_ops);
-EXPORT_SYMBOL_GPL(ata_sff_port_ops);
-EXPORT_SYMBOL_GPL(ata_bmdma_port_ops);
 EXPORT_SYMBOL_GPL(ata_dummy_port_ops);
 EXPORT_SYMBOL_GPL(ata_dummy_port_info);
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
-EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_host_init);
 EXPORT_SYMBOL_GPL(ata_host_alloc);
 EXPORT_SYMBOL_GPL(ata_host_alloc_pinfo);
@@ -7866,14 +6041,9 @@ EXPORT_SYMBOL_GPL(ata_host_register);
 EXPORT_SYMBOL_GPL(ata_host_activate);
 EXPORT_SYMBOL_GPL(ata_host_detach);
 EXPORT_SYMBOL_GPL(ata_sg_init);
-EXPORT_SYMBOL_GPL(ata_hsm_move);
 EXPORT_SYMBOL_GPL(ata_qc_complete);
 EXPORT_SYMBOL_GPL(ata_qc_complete_multiple);
-EXPORT_SYMBOL_GPL(ata_qc_issue_prot);
-EXPORT_SYMBOL_GPL(ata_tf_load);
-EXPORT_SYMBOL_GPL(ata_tf_read);
 EXPORT_SYMBOL_GPL(ata_noop_dev_select);
-EXPORT_SYMBOL_GPL(ata_std_dev_select);
 EXPORT_SYMBOL_GPL(sata_print_link_status);
 EXPORT_SYMBOL_GPL(ata_tf_to_fis);
 EXPORT_SYMBOL_GPL(ata_tf_from_fis);
@@ -7884,54 +6054,27 @@ EXPORT_SYMBOL_GPL(ata_xfer_mode2mask);
 EXPORT_SYMBOL_GPL(ata_xfer_mode2shift);
 EXPORT_SYMBOL_GPL(ata_mode_string);
 EXPORT_SYMBOL_GPL(ata_id_xfermask);
-EXPORT_SYMBOL_GPL(ata_check_status);
-EXPORT_SYMBOL_GPL(ata_altstatus);
-EXPORT_SYMBOL_GPL(ata_exec_command);
 EXPORT_SYMBOL_GPL(ata_port_start);
-EXPORT_SYMBOL_GPL(ata_sff_port_start);
-EXPORT_SYMBOL_GPL(ata_interrupt);
 EXPORT_SYMBOL_GPL(ata_do_set_mode);
-EXPORT_SYMBOL_GPL(ata_data_xfer);
-EXPORT_SYMBOL_GPL(ata_data_xfer_noirq);
 EXPORT_SYMBOL_GPL(ata_std_qc_defer);
-EXPORT_SYMBOL_GPL(ata_qc_prep);
-EXPORT_SYMBOL_GPL(ata_dumb_qc_prep);
 EXPORT_SYMBOL_GPL(ata_noop_qc_prep);
-EXPORT_SYMBOL_GPL(ata_bmdma_setup);
-EXPORT_SYMBOL_GPL(ata_bmdma_start);
-EXPORT_SYMBOL_GPL(ata_bmdma_irq_clear);
 EXPORT_SYMBOL_GPL(ata_noop_irq_clear);
-EXPORT_SYMBOL_GPL(ata_bmdma_status);
-EXPORT_SYMBOL_GPL(ata_bmdma_stop);
-EXPORT_SYMBOL_GPL(ata_bmdma_freeze);
-EXPORT_SYMBOL_GPL(ata_bmdma_thaw);
-EXPORT_SYMBOL_GPL(ata_bmdma_error_handler);
-EXPORT_SYMBOL_GPL(ata_bmdma_post_internal_cmd);
 EXPORT_SYMBOL_GPL(ata_port_probe);
 EXPORT_SYMBOL_GPL(ata_dev_disable);
 EXPORT_SYMBOL_GPL(sata_set_spd);
 EXPORT_SYMBOL_GPL(sata_link_debounce);
 EXPORT_SYMBOL_GPL(sata_link_resume);
-EXPORT_SYMBOL_GPL(ata_bus_reset);
-EXPORT_SYMBOL_GPL(ata_std_prereset);
-EXPORT_SYMBOL_GPL(ata_std_softreset);
 EXPORT_SYMBOL_GPL(sata_link_hardreset);
-EXPORT_SYMBOL_GPL(sata_std_hardreset);
-EXPORT_SYMBOL_GPL(ata_std_postreset);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_pair);
 EXPORT_SYMBOL_GPL(ata_port_disable);
 EXPORT_SYMBOL_GPL(ata_ratelimit);
 EXPORT_SYMBOL_GPL(ata_wait_register);
-EXPORT_SYMBOL_GPL(ata_busy_sleep);
-EXPORT_SYMBOL_GPL(ata_wait_after_reset);
-EXPORT_SYMBOL_GPL(ata_wait_ready);
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_destroy);
 EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
-EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(sata_scr_valid);
 EXPORT_SYMBOL_GPL(sata_scr_read);
 EXPORT_SYMBOL_GPL(sata_scr_write);
@@ -7954,11 +6097,6 @@ EXPORT_SYMBOL_GPL(ata_timing_cycle2mode);
 
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
-EXPORT_SYMBOL_GPL(ata_pci_init_sff_host);
-EXPORT_SYMBOL_GPL(ata_pci_init_bmdma);
-EXPORT_SYMBOL_GPL(ata_pci_prepare_sff_host);
-EXPORT_SYMBOL_GPL(ata_pci_activate_sff_host);
-EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
 #ifdef CONFIG_PM
 EXPORT_SYMBOL_GPL(ata_pci_device_do_suspend);
@@ -7966,8 +6104,6 @@ EXPORT_SYMBOL_GPL(ata_pci_device_do_resume);
 EXPORT_SYMBOL_GPL(ata_pci_device_suspend);
 EXPORT_SYMBOL_GPL(ata_pci_device_resume);
 #endif /* CONFIG_PM */
-EXPORT_SYMBOL_GPL(ata_pci_default_filter);
-EXPORT_SYMBOL_GPL(ata_pci_clear_simplex);
 #endif /* CONFIG_PCI */
 
 EXPORT_SYMBOL_GPL(sata_pmp_qc_defer_cmd_switch);
@@ -7994,8 +6130,6 @@ EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 EXPORT_SYMBOL_GPL(ata_do_eh);
 EXPORT_SYMBOL_GPL(ata_std_error_handler);
-EXPORT_SYMBOL_GPL(ata_irq_on);
-EXPORT_SYMBOL_GPL(ata_dev_try_classify);
 
 EXPORT_SYMBOL_GPL(ata_cable_40wire);
 EXPORT_SYMBOL_GPL(ata_cable_80wire);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 4cbb149..37e7cac 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -35,9 +35,185 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/libata.h>
+#include <linux/highmem.h>
 
 #include "libata.h"
 
+const struct ata_port_operations ata_sff_port_ops = {
+	.inherits		= &ata_base_port_ops,
+
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.softreset		= ata_std_softreset,
+	.error_handler		= ata_bmdma_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+
+	.dev_select		= ata_std_dev_select,
+	.check_status		= ata_check_status,
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.exec_command		= ata_exec_command,
+	.data_xfer		= ata_data_xfer,
+	.irq_on			= ata_irq_on,
+
+	.port_start		= ata_sff_port_start,
+};
+
+const struct ata_port_operations ata_bmdma_port_ops = {
+	.inherits		= &ata_sff_port_ops,
+
+	.mode_filter		= ata_pci_default_filter,
+
+	.bmdma_setup		= ata_bmdma_setup,
+	.bmdma_start		= ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
+	.irq_clear		= ata_bmdma_irq_clear,
+};
+
+/**
+ *	ata_fill_sg - Fill PCI IDE PRD table
+ *	@qc: Metadata associated with taskfile to be transferred
+ *
+ *	Fill PCI IDE PRD (scatter-gather) table with segments
+ *	associated with the current disk command.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ */
+static void ata_fill_sg(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct scatterlist *sg;
+	unsigned int si, pi;
+
+	pi = 0;
+	for_each_sg(qc->sg, sg, qc->n_elem, si) {
+		u32 addr, offset;
+		u32 sg_len, len;
+
+		/* determine if physical DMA addr spans 64K boundary.
+		 * Note h/w doesn't support 64-bit, so we unconditionally
+		 * truncate dma_addr_t to u32.
+		 */
+		addr = (u32) sg_dma_address(sg);
+		sg_len = sg_dma_len(sg);
+
+		while (sg_len) {
+			offset = addr & 0xffff;
+			len = sg_len;
+			if ((offset + sg_len) > 0x10000)
+				len = 0x10000 - offset;
+
+			ap->prd[pi].addr = cpu_to_le32(addr);
+			ap->prd[pi].flags_len = cpu_to_le32(len & 0xffff);
+			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", pi, addr, len);
+
+			pi++;
+			sg_len -= len;
+			addr += len;
+		}
+	}
+
+	ap->prd[pi - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
+}
+
+/**
+ *	ata_fill_sg_dumb - Fill PCI IDE PRD table
+ *	@qc: Metadata associated with taskfile to be transferred
+ *
+ *	Fill PCI IDE PRD (scatter-gather) table with segments
+ *	associated with the current disk command. Perform the fill
+ *	so that we avoid writing any length 64K records for
+ *	controllers that don't follow the spec.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ */
+static void ata_fill_sg_dumb(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct scatterlist *sg;
+	unsigned int si, pi;
+
+	pi = 0;
+	for_each_sg(qc->sg, sg, qc->n_elem, si) {
+		u32 addr, offset;
+		u32 sg_len, len, blen;
+
+		/* determine if physical DMA addr spans 64K boundary.
+		 * Note h/w doesn't support 64-bit, so we unconditionally
+		 * truncate dma_addr_t to u32.
+		 */
+		addr = (u32) sg_dma_address(sg);
+		sg_len = sg_dma_len(sg);
+
+		while (sg_len) {
+			offset = addr & 0xffff;
+			len = sg_len;
+			if ((offset + sg_len) > 0x10000)
+				len = 0x10000 - offset;
+
+			blen = len & 0xffff;
+			ap->prd[pi].addr = cpu_to_le32(addr);
+			if (blen == 0) {
+			   /* Some PATA chipsets like the CS5530 can't
+			      cope with 0x0000 meaning 64K as the spec says */
+				ap->prd[pi].flags_len = cpu_to_le32(0x8000);
+				blen = 0x8000;
+				ap->prd[++pi].addr = cpu_to_le32(addr + 0x8000);
+			}
+			ap->prd[pi].flags_len = cpu_to_le32(blen);
+			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", pi, addr, len);
+
+			pi++;
+			sg_len -= len;
+			addr += len;
+		}
+	}
+
+	ap->prd[pi - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
+}
+
+/**
+ *	ata_qc_prep - Prepare taskfile for submission
+ *	@qc: Metadata associated with taskfile to be prepared
+ *
+ *	Prepare ATA taskfile for submission.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
+void ata_qc_prep(struct ata_queued_cmd *qc)
+{
+	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
+		return;
+
+	ata_fill_sg(qc);
+}
+
+/**
+ *	ata_dumb_qc_prep - Prepare taskfile for submission
+ *	@qc: Metadata associated with taskfile to be prepared
+ *
+ *	Prepare ATA taskfile for submission.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
+void ata_dumb_qc_prep(struct ata_queued_cmd *qc)
+{
+	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
+		return;
+
+	ata_fill_sg_dumb(qc);
+}
+
 /**
  *	ata_check_status - Read device status reg & clear interrupt
  *	@ap: port where the device is
@@ -76,6 +252,167 @@ u8 ata_altstatus(struct ata_port *ap)
 }
 
 /**
+ *	ata_busy_sleep - sleep until BSY clears, or timeout
+ *	@ap: port containing status register to be polled
+ *	@tmout_pat: impatience timeout
+ *	@tmout: overall timeout
+ *
+ *	Sleep until ATA Status register bit BSY clears,
+ *	or a timeout occurs.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_busy_sleep(struct ata_port *ap,
+		   unsigned long tmout_pat, unsigned long tmout)
+{
+	unsigned long timer_start, timeout;
+	u8 status;
+
+	status = ata_busy_wait(ap, ATA_BUSY, 300);
+	timer_start = jiffies;
+	timeout = timer_start + tmout_pat;
+	while (status != 0xff && (status & ATA_BUSY) &&
+	       time_before(jiffies, timeout)) {
+		msleep(50);
+		status = ata_busy_wait(ap, ATA_BUSY, 3);
+	}
+
+	if (status != 0xff && (status & ATA_BUSY))
+		ata_port_printk(ap, KERN_WARNING,
+				"port is slow to respond, please be patient "
+				"(Status 0x%x)\n", status);
+
+	timeout = timer_start + tmout;
+	while (status != 0xff && (status & ATA_BUSY) &&
+	       time_before(jiffies, timeout)) {
+		msleep(50);
+		status = ata_chk_status(ap);
+	}
+
+	if (status == 0xff)
+		return -ENODEV;
+
+	if (status & ATA_BUSY) {
+		ata_port_printk(ap, KERN_ERR, "port failed to respond "
+				"(%lu secs, Status 0x%x)\n",
+				tmout / HZ, status);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+/**
+ *	ata_wait_ready - sleep until BSY clears, or timeout
+ *	@ap: port containing status register to be polled
+ *	@deadline: deadline jiffies for the operation
+ *
+ *	Sleep until ATA Status register bit BSY clears, or timeout
+ *	occurs.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_wait_ready(struct ata_port *ap, unsigned long deadline)
+{
+	unsigned long start = jiffies;
+	int warned = 0;
+
+	while (1) {
+		u8 status = ata_chk_status(ap);
+		unsigned long now = jiffies;
+
+		if (!(status & ATA_BUSY))
+			return 0;
+		if (!ata_link_online(&ap->link) && status == 0xff)
+			return -ENODEV;
+		if (time_after(now, deadline))
+			return -EBUSY;
+
+		if (!warned && time_after(now, start + 5 * HZ) &&
+		    (deadline - now > 3 * HZ)) {
+			ata_port_printk(ap, KERN_WARNING,
+				"port is slow to respond, please be patient "
+				"(Status 0x%x)\n", status);
+			warned = 1;
+		}
+
+		msleep(50);
+	}
+}
+
+/**
+ *	ata_std_dev_select - Select device 0/1 on ATA bus
+ *	@ap: ATA channel to manipulate
+ *	@device: ATA device (numbered from zero) to select
+ *
+ *	Use the method defined in the ATA specification to
+ *	make either device 0, or device 1, active on the
+ *	ATA channel.  Works with both PIO and MMIO.
+ *
+ *	May be used as the dev_select() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	caller.
+ */
+void ata_std_dev_select(struct ata_port *ap, unsigned int device)
+{
+	u8 tmp;
+
+	if (device == 0)
+		tmp = ATA_DEVICE_OBS;
+	else
+		tmp = ATA_DEVICE_OBS | ATA_DEV1;
+
+	iowrite8(tmp, ap->ioaddr.device_addr);
+	ata_pause(ap);		/* needed; also flushes, for mmio */
+}
+
+/**
+ *	ata_dev_select - Select device 0/1 on ATA bus
+ *	@ap: ATA channel to manipulate
+ *	@device: ATA device (numbered from zero) to select
+ *	@wait: non-zero to wait for Status register BSY bit to clear
+ *	@can_sleep: non-zero if context allows sleeping
+ *
+ *	Use the method defined in the ATA specification to
+ *	make either device 0, or device 1, active on the
+ *	ATA channel.
+ *
+ *	This is a high-level version of ata_std_dev_select(),
+ *	which additionally provides the services of inserting
+ *	the proper pauses and status polling, where needed.
+ *
+ *	LOCKING:
+ *	caller.
+ */
+void ata_dev_select(struct ata_port *ap, unsigned int device,
+			   unsigned int wait, unsigned int can_sleep)
+{
+	if (ata_msg_probe(ap))
+		ata_port_printk(ap, KERN_INFO, "ata_dev_select: ENTER, "
+				"device %u, wait %u\n", device, wait);
+
+	if (wait)
+		ata_wait_idle(ap);
+
+	ap->ops->dev_select(ap, device);
+
+	if (wait) {
+		if (can_sleep && ap->link.device[device].class == ATA_DEV_ATAPI)
+			msleep(150);
+		ata_wait_idle(ap);
+	}
+}
+
+/**
  *	ata_irq_on - Enable interrupts on a port.
  *	@ap: Port on which interrupts are enabled.
  *
@@ -242,6 +579,987 @@ void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
 }
 
 /**
+ *	ata_tf_to_host - issue ATA taskfile to host controller
+ *	@ap: port to which command is being issued
+ *	@tf: ATA taskfile register set
+ *
+ *	Issues ATA taskfile register set to ATA host controller,
+ *	with proper synchronization with interrupt handler and
+ *	other threads.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
+static inline void ata_tf_to_host(struct ata_port *ap,
+				  const struct ata_taskfile *tf)
+{
+	ap->ops->tf_load(ap, tf);
+	ap->ops->exec_command(ap, tf);
+}
+
+/**
+ *	ata_data_xfer - Transfer data by PIO
+ *	@dev: device to target
+ *	@buf: data buffer
+ *	@buflen: buffer length
+ *	@rw: read/write
+ *
+ *	Transfer data from/to the device data register by PIO.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ *	RETURNS:
+ *	Bytes consumed.
+ */
+unsigned int ata_data_xfer(struct ata_device *dev, unsigned char *buf,
+			   unsigned int buflen, int rw)
+{
+	struct ata_port *ap = dev->link->ap;
+	void __iomem *data_addr = ap->ioaddr.data_addr;
+	unsigned int words = buflen >> 1;
+
+	/* Transfer multiple of 2 bytes */
+	if (rw == READ)
+		ioread16_rep(data_addr, buf, words);
+	else
+		iowrite16_rep(data_addr, buf, words);
+
+	/* Transfer trailing 1 byte, if any. */
+	if (unlikely(buflen & 0x01)) {
+		__le16 align_buf[1] = { 0 };
+		unsigned char *trailing_buf = buf + buflen - 1;
+
+		if (rw == READ) {
+			align_buf[0] = cpu_to_le16(ioread16(data_addr));
+			memcpy(trailing_buf, align_buf, 1);
+		} else {
+			memcpy(align_buf, trailing_buf, 1);
+			iowrite16(le16_to_cpu(align_buf[0]), data_addr);
+		}
+		words++;
+	}
+
+	return words << 1;
+}
+
+/**
+ *	ata_data_xfer_noirq - Transfer data by PIO
+ *	@dev: device to target
+ *	@buf: data buffer
+ *	@buflen: buffer length
+ *	@rw: read/write
+ *
+ *	Transfer data from/to the device data register by PIO. Do the
+ *	transfer with interrupts disabled.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ *	RETURNS:
+ *	Bytes consumed.
+ */
+unsigned int ata_data_xfer_noirq(struct ata_device *dev, unsigned char *buf,
+				 unsigned int buflen, int rw)
+{
+	unsigned long flags;
+	unsigned int consumed;
+
+	local_irq_save(flags);
+	consumed = ata_data_xfer(dev, buf, buflen, rw);
+	local_irq_restore(flags);
+
+	return consumed;
+}
+
+/**
+ *	ata_pio_sector - Transfer a sector of data.
+ *	@qc: Command on going
+ *
+ *	Transfer qc->sect_size bytes of data from/to the ATA device.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+static void ata_pio_sector(struct ata_queued_cmd *qc)
+{
+	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
+	struct ata_port *ap = qc->ap;
+	struct page *page;
+	unsigned int offset;
+	unsigned char *buf;
+
+	if (qc->curbytes == qc->nbytes - qc->sect_size)
+		ap->hsm_task_state = HSM_ST_LAST;
+
+	page = sg_page(qc->cursg);
+	offset = qc->cursg->offset + qc->cursg_ofs;
+
+	/* get the current page and offset */
+	page = nth_page(page, (offset >> PAGE_SHIFT));
+	offset %= PAGE_SIZE;
+
+	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
+
+	if (PageHighMem(page)) {
+		unsigned long flags;
+
+		/* FIXME: use a bounce buffer */
+		local_irq_save(flags);
+		buf = kmap_atomic(page, KM_IRQ0);
+
+		/* do the actual data transfer */
+		ap->ops->data_xfer(qc->dev, buf + offset, qc->sect_size, do_write);
+
+		kunmap_atomic(buf, KM_IRQ0);
+		local_irq_restore(flags);
+	} else {
+		buf = page_address(page);
+		ap->ops->data_xfer(qc->dev, buf + offset, qc->sect_size, do_write);
+	}
+
+	qc->curbytes += qc->sect_size;
+	qc->cursg_ofs += qc->sect_size;
+
+	if (qc->cursg_ofs == qc->cursg->length) {
+		qc->cursg = sg_next(qc->cursg);
+		qc->cursg_ofs = 0;
+	}
+}
+
+/**
+ *	ata_pio_sectors - Transfer one or many sectors.
+ *	@qc: Command on going
+ *
+ *	Transfer one or many sectors of data from/to the
+ *	ATA device for the DRQ request.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+static void ata_pio_sectors(struct ata_queued_cmd *qc)
+{
+	if (is_multi_taskfile(&qc->tf)) {
+		/* READ/WRITE MULTIPLE */
+		unsigned int nsect;
+
+		WARN_ON(qc->dev->multi_count == 0);
+
+		nsect = min((qc->nbytes - qc->curbytes) / qc->sect_size,
+			    qc->dev->multi_count);
+		while (nsect--)
+			ata_pio_sector(qc);
+	} else
+		ata_pio_sector(qc);
+
+	ata_altstatus(qc->ap); /* flush */
+}
+
+/**
+ *	atapi_send_cdb - Write CDB bytes to hardware
+ *	@ap: Port to which ATAPI device is attached.
+ *	@qc: Taskfile currently active
+ *
+ *	When device has indicated its readiness to accept
+ *	a CDB, this function is called.  Send the CDB.
+ *
+ *	LOCKING:
+ *	caller.
+ */
+static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
+{
+	/* send SCSI cdb */
+	DPRINTK("send cdb\n");
+	WARN_ON(qc->dev->cdb_len < 12);
+
+	ap->ops->data_xfer(qc->dev, qc->cdb, qc->dev->cdb_len, 1);
+	ata_altstatus(ap); /* flush */
+
+	switch (qc->tf.protocol) {
+	case ATAPI_PROT_PIO:
+		ap->hsm_task_state = HSM_ST;
+		break;
+	case ATAPI_PROT_NODATA:
+		ap->hsm_task_state = HSM_ST_LAST;
+		break;
+	case ATAPI_PROT_DMA:
+		ap->hsm_task_state = HSM_ST_LAST;
+		/* initiate bmdma */
+		ap->ops->bmdma_start(qc);
+		break;
+	}
+}
+
+/**
+ *	__atapi_pio_bytes - Transfer data from/to the ATAPI device.
+ *	@qc: Command on going
+ *	@bytes: number of bytes
+ *
+ *	Transfer Transfer data from/to the ATAPI device.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ */
+static int __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
+{
+	int rw = (qc->tf.flags & ATA_TFLAG_WRITE) ? WRITE : READ;
+	struct ata_port *ap = qc->ap;
+	struct ata_device *dev = qc->dev;
+	struct ata_eh_info *ehi = &dev->link->eh_info;
+	struct scatterlist *sg;
+	struct page *page;
+	unsigned char *buf;
+	unsigned int offset, count, consumed;
+
+next_sg:
+	sg = qc->cursg;
+	if (unlikely(!sg)) {
+		ata_ehi_push_desc(ehi, "unexpected or too much trailing data "
+				  "buf=%u cur=%u bytes=%u",
+				  qc->nbytes, qc->curbytes, bytes);
+		return -1;
+	}
+
+	page = sg_page(sg);
+	offset = sg->offset + qc->cursg_ofs;
+
+	/* get the current page and offset */
+	page = nth_page(page, (offset >> PAGE_SHIFT));
+	offset %= PAGE_SIZE;
+
+	/* don't overrun current sg */
+	count = min(sg->length - qc->cursg_ofs, bytes);
+
+	/* don't cross page boundaries */
+	count = min(count, (unsigned int)PAGE_SIZE - offset);
+
+	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
+
+	if (PageHighMem(page)) {
+		unsigned long flags;
+
+		/* FIXME: use bounce buffer */
+		local_irq_save(flags);
+		buf = kmap_atomic(page, KM_IRQ0);
+
+		/* do the actual data transfer */
+		consumed = ap->ops->data_xfer(dev,  buf + offset, count, rw);
+
+		kunmap_atomic(buf, KM_IRQ0);
+		local_irq_restore(flags);
+	} else {
+		buf = page_address(page);
+		consumed = ap->ops->data_xfer(dev,  buf + offset, count, rw);
+	}
+
+	bytes -= min(bytes, consumed);
+	qc->curbytes += count;
+	qc->cursg_ofs += count;
+
+	if (qc->cursg_ofs == sg->length) {
+		qc->cursg = sg_next(qc->cursg);
+		qc->cursg_ofs = 0;
+	}
+
+	/* consumed can be larger than count only for the last transfer */
+	WARN_ON(qc->cursg && count != consumed);
+
+	if (bytes)
+		goto next_sg;
+	return 0;
+}
+
+/**
+ *	atapi_pio_bytes - Transfer data from/to the ATAPI device.
+ *	@qc: Command on going
+ *
+ *	Transfer Transfer data from/to the ATAPI device.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+static void atapi_pio_bytes(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct ata_device *dev = qc->dev;
+	struct ata_eh_info *ehi = &dev->link->eh_info;
+	unsigned int ireason, bc_lo, bc_hi, bytes;
+	int i_write, do_write = (qc->tf.flags & ATA_TFLAG_WRITE) ? 1 : 0;
+
+	/* Abuse qc->result_tf for temp storage of intermediate TF
+	 * here to save some kernel stack usage.
+	 * For normal completion, qc->result_tf is not relevant. For
+	 * error, qc->result_tf is later overwritten by ata_qc_complete().
+	 * So, the correctness of qc->result_tf is not affected.
+	 */
+	ap->ops->tf_read(ap, &qc->result_tf);
+	ireason = qc->result_tf.nsect;
+	bc_lo = qc->result_tf.lbam;
+	bc_hi = qc->result_tf.lbah;
+	bytes = (bc_hi << 8) | bc_lo;
+
+	/* shall be cleared to zero, indicating xfer of data */
+	if (unlikely(ireason & (1 << 0)))
+		goto atapi_check;
+
+	/* make sure transfer direction matches expected */
+	i_write = ((ireason & (1 << 1)) == 0) ? 1 : 0;
+	if (unlikely(do_write != i_write))
+		goto atapi_check;
+
+	if (unlikely(!bytes))
+		goto atapi_check;
+
+	VPRINTK("ata%u: xfering %d bytes\n", ap->print_id, bytes);
+
+	if (unlikely(__atapi_pio_bytes(qc, bytes)))
+		goto err_out;
+	ata_altstatus(ap); /* flush */
+
+	return;
+
+ atapi_check:
+	ata_ehi_push_desc(ehi, "ATAPI check failed (ireason=0x%x bytes=%u)",
+			  ireason, bytes);
+ err_out:
+	qc->err_mask |= AC_ERR_HSM;
+	ap->hsm_task_state = HSM_ST_ERR;
+}
+
+/**
+ *	ata_hsm_ok_in_wq - Check if the qc can be handled in the workqueue.
+ *	@ap: the target ata_port
+ *	@qc: qc on going
+ *
+ *	RETURNS:
+ *	1 if ok in workqueue, 0 otherwise.
+ */
+static inline int ata_hsm_ok_in_wq(struct ata_port *ap, struct ata_queued_cmd *qc)
+{
+	if (qc->tf.flags & ATA_TFLAG_POLLING)
+		return 1;
+
+	if (ap->hsm_task_state == HSM_ST_FIRST) {
+		if (qc->tf.protocol == ATA_PROT_PIO &&
+		    (qc->tf.flags & ATA_TFLAG_WRITE))
+		    return 1;
+
+		if (ata_is_atapi(qc->tf.protocol) &&
+		    !(qc->dev->flags & ATA_DFLAG_CDB_INTR))
+			return 1;
+	}
+
+	return 0;
+}
+
+/**
+ *	ata_hsm_qc_complete - finish a qc running on standard HSM
+ *	@qc: Command to complete
+ *	@in_wq: 1 if called from workqueue, 0 otherwise
+ *
+ *	Finish @qc which is running on standard HSM.
+ *
+ *	LOCKING:
+ *	If @in_wq is zero, spin_lock_irqsave(host lock).
+ *	Otherwise, none on entry and grabs host lock.
+ */
+static void ata_hsm_qc_complete(struct ata_queued_cmd *qc, int in_wq)
+{
+	struct ata_port *ap = qc->ap;
+	unsigned long flags;
+
+	if (ap->ops->error_handler) {
+		if (in_wq) {
+			spin_lock_irqsave(ap->lock, flags);
+
+			/* EH might have kicked in while host lock is
+			 * released.
+			 */
+			qc = ata_qc_from_tag(ap, qc->tag);
+			if (qc) {
+				if (likely(!(qc->err_mask & AC_ERR_HSM))) {
+					ap->ops->irq_on(ap);
+					ata_qc_complete(qc);
+				} else
+					ata_port_freeze(ap);
+			}
+
+			spin_unlock_irqrestore(ap->lock, flags);
+		} else {
+			if (likely(!(qc->err_mask & AC_ERR_HSM)))
+				ata_qc_complete(qc);
+			else
+				ata_port_freeze(ap);
+		}
+	} else {
+		if (in_wq) {
+			spin_lock_irqsave(ap->lock, flags);
+			ap->ops->irq_on(ap);
+			ata_qc_complete(qc);
+			spin_unlock_irqrestore(ap->lock, flags);
+		} else
+			ata_qc_complete(qc);
+	}
+}
+
+/**
+ *	ata_hsm_move - move the HSM to the next state.
+ *	@ap: the target ata_port
+ *	@qc: qc on going
+ *	@status: current device status
+ *	@in_wq: 1 if called from workqueue, 0 otherwise
+ *
+ *	RETURNS:
+ *	1 when poll next status needed, 0 otherwise.
+ */
+int ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
+		 u8 status, int in_wq)
+{
+	unsigned long flags = 0;
+	int poll_next;
+
+	WARN_ON((qc->flags & ATA_QCFLAG_ACTIVE) == 0);
+
+	/* Make sure ata_qc_issue_prot() does not throw things
+	 * like DMA polling into the workqueue. Notice that
+	 * in_wq is not equivalent to (qc->tf.flags & ATA_TFLAG_POLLING).
+	 */
+	WARN_ON(in_wq != ata_hsm_ok_in_wq(ap, qc));
+
+fsm_start:
+	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
+		ap->print_id, qc->tf.protocol, ap->hsm_task_state, status);
+
+	switch (ap->hsm_task_state) {
+	case HSM_ST_FIRST:
+		/* Send first data block or PACKET CDB */
+
+		/* If polling, we will stay in the work queue after
+		 * sending the data. Otherwise, interrupt handler
+		 * takes over after sending the data.
+		 */
+		poll_next = (qc->tf.flags & ATA_TFLAG_POLLING);
+
+		/* check device status */
+		if (unlikely((status & ATA_DRQ) == 0)) {
+			/* handle BSY=0, DRQ=0 as error */
+			if (likely(status & (ATA_ERR | ATA_DF)))
+				/* device stops HSM for abort/error */
+				qc->err_mask |= AC_ERR_DEV;
+			else
+				/* HSM violation. Let EH handle this */
+				qc->err_mask |= AC_ERR_HSM;
+
+			ap->hsm_task_state = HSM_ST_ERR;
+			goto fsm_start;
+		}
+
+		/* Device should not ask for data transfer (DRQ=1)
+		 * when it finds something wrong.
+		 * We ignore DRQ here and stop the HSM by
+		 * changing hsm_task_state to HSM_ST_ERR and
+		 * let the EH abort the command or reset the device.
+		 */
+		if (unlikely(status & (ATA_ERR | ATA_DF))) {
+			/* Some ATAPI tape drives forget to clear the ERR bit
+			 * when doing the next command (mostly request sense).
+			 * We ignore ERR here to workaround and proceed sending
+			 * the CDB.
+			 */
+			if (!(qc->dev->horkage & ATA_HORKAGE_STUCK_ERR)) {
+				ata_port_printk(ap, KERN_WARNING,
+						"DRQ=1 with device error, "
+						"dev_stat 0x%X\n", status);
+				qc->err_mask |= AC_ERR_HSM;
+				ap->hsm_task_state = HSM_ST_ERR;
+				goto fsm_start;
+			}
+		}
+
+		/* Send the CDB (atapi) or the first data block (ata pio out).
+		 * During the state transition, interrupt handler shouldn't
+		 * be invoked before the data transfer is complete and
+		 * hsm_task_state is changed. Hence, the following locking.
+		 */
+		if (in_wq)
+			spin_lock_irqsave(ap->lock, flags);
+
+		if (qc->tf.protocol == ATA_PROT_PIO) {
+			/* PIO data out protocol.
+			 * send first data block.
+			 */
+
+			/* ata_pio_sectors() might change the state
+			 * to HSM_ST_LAST. so, the state is changed here
+			 * before ata_pio_sectors().
+			 */
+			ap->hsm_task_state = HSM_ST;
+			ata_pio_sectors(qc);
+		} else
+			/* send CDB */
+			atapi_send_cdb(ap, qc);
+
+		if (in_wq)
+			spin_unlock_irqrestore(ap->lock, flags);
+
+		/* if polling, ata_pio_task() handles the rest.
+		 * otherwise, interrupt handler takes over from here.
+		 */
+		break;
+
+	case HSM_ST:
+		/* complete command or read/write the data register */
+		if (qc->tf.protocol == ATAPI_PROT_PIO) {
+			/* ATAPI PIO protocol */
+			if ((status & ATA_DRQ) == 0) {
+				/* No more data to transfer or device error.
+				 * Device error will be tagged in HSM_ST_LAST.
+				 */
+				ap->hsm_task_state = HSM_ST_LAST;
+				goto fsm_start;
+			}
+
+			/* Device should not ask for data transfer (DRQ=1)
+			 * when it finds something wrong.
+			 * We ignore DRQ here and stop the HSM by
+			 * changing hsm_task_state to HSM_ST_ERR and
+			 * let the EH abort the command or reset the device.
+			 */
+			if (unlikely(status & (ATA_ERR | ATA_DF))) {
+				ata_port_printk(ap, KERN_WARNING, "DRQ=1 with "
+						"device error, dev_stat 0x%X\n",
+						status);
+				qc->err_mask |= AC_ERR_HSM;
+				ap->hsm_task_state = HSM_ST_ERR;
+				goto fsm_start;
+			}
+
+			atapi_pio_bytes(qc);
+
+			if (unlikely(ap->hsm_task_state == HSM_ST_ERR))
+				/* bad ireason reported by device */
+				goto fsm_start;
+
+		} else {
+			/* ATA PIO protocol */
+			if (unlikely((status & ATA_DRQ) == 0)) {
+				/* handle BSY=0, DRQ=0 as error */
+				if (likely(status & (ATA_ERR | ATA_DF)))
+					/* device stops HSM for abort/error */
+					qc->err_mask |= AC_ERR_DEV;
+				else
+					/* HSM violation. Let EH handle this.
+					 * Phantom devices also trigger this
+					 * condition.  Mark hint.
+					 */
+					qc->err_mask |= AC_ERR_HSM |
+							AC_ERR_NODEV_HINT;
+
+				ap->hsm_task_state = HSM_ST_ERR;
+				goto fsm_start;
+			}
+
+			/* For PIO reads, some devices may ask for
+			 * data transfer (DRQ=1) alone with ERR=1.
+			 * We respect DRQ here and transfer one
+			 * block of junk data before changing the
+			 * hsm_task_state to HSM_ST_ERR.
+			 *
+			 * For PIO writes, ERR=1 DRQ=1 doesn't make
+			 * sense since the data block has been
+			 * transferred to the device.
+			 */
+			if (unlikely(status & (ATA_ERR | ATA_DF))) {
+				/* data might be corrputed */
+				qc->err_mask |= AC_ERR_DEV;
+
+				if (!(qc->tf.flags & ATA_TFLAG_WRITE)) {
+					ata_pio_sectors(qc);
+					status = ata_wait_idle(ap);
+				}
+
+				if (status & (ATA_BUSY | ATA_DRQ))
+					qc->err_mask |= AC_ERR_HSM;
+
+				/* ata_pio_sectors() might change the
+				 * state to HSM_ST_LAST. so, the state
+				 * is changed after ata_pio_sectors().
+				 */
+				ap->hsm_task_state = HSM_ST_ERR;
+				goto fsm_start;
+			}
+
+			ata_pio_sectors(qc);
+
+			if (ap->hsm_task_state == HSM_ST_LAST &&
+			    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
+				/* all data read */
+				status = ata_wait_idle(ap);
+				goto fsm_start;
+			}
+		}
+
+		poll_next = 1;
+		break;
+
+	case HSM_ST_LAST:
+		if (unlikely(!ata_ok(status))) {
+			qc->err_mask |= __ac_err_mask(status);
+			ap->hsm_task_state = HSM_ST_ERR;
+			goto fsm_start;
+		}
+
+		/* no more data to transfer */
+		DPRINTK("ata%u: dev %u command complete, drv_stat 0x%x\n",
+			ap->print_id, qc->dev->devno, status);
+
+		WARN_ON(qc->err_mask);
+
+		ap->hsm_task_state = HSM_ST_IDLE;
+
+		/* complete taskfile transaction */
+		ata_hsm_qc_complete(qc, in_wq);
+
+		poll_next = 0;
+		break;
+
+	case HSM_ST_ERR:
+		/* make sure qc->err_mask is available to
+		 * know what's wrong and recover
+		 */
+		WARN_ON(qc->err_mask == 0);
+
+		ap->hsm_task_state = HSM_ST_IDLE;
+
+		/* complete taskfile transaction */
+		ata_hsm_qc_complete(qc, in_wq);
+
+		poll_next = 0;
+		break;
+	default:
+		poll_next = 0;
+		BUG();
+	}
+
+	return poll_next;
+}
+
+void ata_pio_task(struct work_struct *work)
+{
+	struct ata_port *ap =
+		container_of(work, struct ata_port, port_task.work);
+	struct ata_queued_cmd *qc = ap->port_task_data;
+	u8 status;
+	int poll_next;
+
+fsm_start:
+	WARN_ON(ap->hsm_task_state == HSM_ST_IDLE);
+
+	/*
+	 * This is purely heuristic.  This is a fast path.
+	 * Sometimes when we enter, BSY will be cleared in
+	 * a chk-status or two.  If not, the drive is probably seeking
+	 * or something.  Snooze for a couple msecs, then
+	 * chk-status again.  If still busy, queue delayed work.
+	 */
+	status = ata_busy_wait(ap, ATA_BUSY, 5);
+	if (status & ATA_BUSY) {
+		msleep(2);
+		status = ata_busy_wait(ap, ATA_BUSY, 10);
+		if (status & ATA_BUSY) {
+			ata_pio_queue_task(ap, qc, ATA_SHORT_PAUSE);
+			return;
+		}
+	}
+
+	/* move the HSM */
+	poll_next = ata_hsm_move(ap, qc, status, 1);
+
+	/* another command or interrupt handler
+	 * may be running at this point.
+	 */
+	if (poll_next)
+		goto fsm_start;
+}
+
+/**
+ *	ata_qc_issue_prot - issue taskfile to device in proto-dependent manner
+ *	@qc: command to issue to device
+ *
+ *	Using various libata functions and hooks, this function
+ *	starts an ATA command.  ATA commands are grouped into
+ *	classes called "protocols", and issuing each type of protocol
+ *	is slightly different.
+ *
+ *	May be used as the qc_issue() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ *	RETURNS:
+ *	Zero on success, AC_ERR_* mask on failure
+ */
+unsigned int ata_qc_issue_prot(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+
+	/* Use polling pio if the LLD doesn't handle
+	 * interrupt driven pio and atapi CDB interrupt.
+	 */
+	if (ap->flags & ATA_FLAG_PIO_POLLING) {
+		switch (qc->tf.protocol) {
+		case ATA_PROT_PIO:
+		case ATA_PROT_NODATA:
+		case ATAPI_PROT_PIO:
+		case ATAPI_PROT_NODATA:
+			qc->tf.flags |= ATA_TFLAG_POLLING;
+			break;
+		case ATAPI_PROT_DMA:
+			if (qc->dev->flags & ATA_DFLAG_CDB_INTR)
+				/* see ata_dma_blacklisted() */
+				BUG();
+			break;
+		default:
+			break;
+		}
+	}
+
+	/* select the device */
+	ata_dev_select(ap, qc->dev->devno, 1, 0);
+
+	/* start the command */
+	switch (qc->tf.protocol) {
+	case ATA_PROT_NODATA:
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			ata_qc_set_polling(qc);
+
+		ata_tf_to_host(ap, &qc->tf);
+		ap->hsm_task_state = HSM_ST_LAST;
+
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			ata_pio_queue_task(ap, qc, 0);
+
+		break;
+
+	case ATA_PROT_DMA:
+		WARN_ON(qc->tf.flags & ATA_TFLAG_POLLING);
+
+		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
+		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
+		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
+		ap->hsm_task_state = HSM_ST_LAST;
+		break;
+
+	case ATA_PROT_PIO:
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			ata_qc_set_polling(qc);
+
+		ata_tf_to_host(ap, &qc->tf);
+
+		if (qc->tf.flags & ATA_TFLAG_WRITE) {
+			/* PIO data out protocol */
+			ap->hsm_task_state = HSM_ST_FIRST;
+			ata_pio_queue_task(ap, qc, 0);
+
+			/* always send first data block using
+			 * the ata_pio_task() codepath.
+			 */
+		} else {
+			/* PIO data in protocol */
+			ap->hsm_task_state = HSM_ST;
+
+			if (qc->tf.flags & ATA_TFLAG_POLLING)
+				ata_pio_queue_task(ap, qc, 0);
+
+			/* if polling, ata_pio_task() handles the rest.
+			 * otherwise, interrupt handler takes over from here.
+			 */
+		}
+
+		break;
+
+	case ATAPI_PROT_PIO:
+	case ATAPI_PROT_NODATA:
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			ata_qc_set_polling(qc);
+
+		ata_tf_to_host(ap, &qc->tf);
+
+		ap->hsm_task_state = HSM_ST_FIRST;
+
+		/* send cdb by polling if no cdb interrupt */
+		if ((!(qc->dev->flags & ATA_DFLAG_CDB_INTR)) ||
+		    (qc->tf.flags & ATA_TFLAG_POLLING))
+			ata_pio_queue_task(ap, qc, 0);
+		break;
+
+	case ATAPI_PROT_DMA:
+		WARN_ON(qc->tf.flags & ATA_TFLAG_POLLING);
+
+		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
+		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
+		ap->hsm_task_state = HSM_ST_FIRST;
+
+		/* send cdb by polling if no cdb interrupt */
+		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
+			ata_pio_queue_task(ap, qc, 0);
+		break;
+
+	default:
+		WARN_ON(1);
+		return AC_ERR_SYSTEM;
+	}
+
+	return 0;
+}
+
+/**
+ *	ata_host_intr - Handle host interrupt for given (port, task)
+ *	@ap: Port on which interrupt arrived (possibly...)
+ *	@qc: Taskfile currently active in engine
+ *
+ *	Handle host interrupt for given queued command.  Currently,
+ *	only DMA interrupts are handled.  All other commands are
+ *	handled via polling with interrupts disabled (nIEN bit).
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ *	RETURNS:
+ *	One if interrupt was handled, zero if not (shared irq).
+ */
+inline unsigned int ata_host_intr(struct ata_port *ap,
+				  struct ata_queued_cmd *qc)
+{
+	struct ata_eh_info *ehi = &ap->link.eh_info;
+	u8 status, host_stat = 0;
+
+	VPRINTK("ata%u: protocol %d task_state %d\n",
+		ap->print_id, qc->tf.protocol, ap->hsm_task_state);
+
+	/* Check whether we are expecting interrupt in this state */
+	switch (ap->hsm_task_state) {
+	case HSM_ST_FIRST:
+		/* Some pre-ATAPI-4 devices assert INTRQ
+		 * at this state when ready to receive CDB.
+		 */
+
+		/* Check the ATA_DFLAG_CDB_INTR flag is enough here.
+		 * The flag was turned on only for atapi devices.  No
+		 * need to check ata_is_atapi(qc->tf.protocol) again.
+		 */
+		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
+			goto idle_irq;
+		break;
+	case HSM_ST_LAST:
+		if (qc->tf.protocol == ATA_PROT_DMA ||
+		    qc->tf.protocol == ATAPI_PROT_DMA) {
+			/* check status of DMA engine */
+			host_stat = ap->ops->bmdma_status(ap);
+			VPRINTK("ata%u: host_stat 0x%X\n",
+				ap->print_id, host_stat);
+
+			/* if it's not our irq... */
+			if (!(host_stat & ATA_DMA_INTR))
+				goto idle_irq;
+
+			/* before we do anything else, clear DMA-Start bit */
+			ap->ops->bmdma_stop(qc);
+
+			if (unlikely(host_stat & ATA_DMA_ERR)) {
+				/* error when transfering data to/from memory */
+				qc->err_mask |= AC_ERR_HOST_BUS;
+				ap->hsm_task_state = HSM_ST_ERR;
+			}
+		}
+		break;
+	case HSM_ST:
+		break;
+	default:
+		goto idle_irq;
+	}
+
+	/* check altstatus */
+	status = ata_altstatus(ap);
+	if (status & ATA_BUSY)
+		goto idle_irq;
+
+	/* check main status, clearing INTRQ */
+	status = ata_chk_status(ap);
+	if (unlikely(status & ATA_BUSY))
+		goto idle_irq;
+
+	/* ack bmdma irq events */
+	ap->ops->irq_clear(ap);
+
+	ata_hsm_move(ap, qc, status, 0);
+
+	if (unlikely(qc->err_mask) && (qc->tf.protocol == ATA_PROT_DMA ||
+				       qc->tf.protocol == ATAPI_PROT_DMA))
+		ata_ehi_push_desc(ehi, "BMDMA stat 0x%x", host_stat);
+
+	return 1;	/* irq handled */
+
+idle_irq:
+	ap->stats.idle_irq++;
+
+#ifdef ATA_IRQ_TRAP
+	if ((ap->stats.idle_irq % 1000) == 0) {
+		ata_chk_status(ap);
+		ap->ops->irq_clear(ap);
+		ata_port_printk(ap, KERN_WARNING, "irq trap\n");
+		return 1;
+	}
+#endif
+	return 0;	/* irq not handled */
+}
+
+/**
+ *	ata_interrupt - Default ATA host interrupt handler
+ *	@irq: irq line (unused)
+ *	@dev_instance: pointer to our ata_host information structure
+ *
+ *	Default interrupt handler for PCI IDE devices.  Calls
+ *	ata_host_intr() for each port that is not disabled.
+ *
+ *	LOCKING:
+ *	Obtains host lock during operation.
+ *
+ *	RETURNS:
+ *	IRQ_NONE or IRQ_HANDLED.
+ */
+irqreturn_t ata_interrupt(int irq, void *dev_instance)
+{
+	struct ata_host *host = dev_instance;
+	unsigned int i;
+	unsigned int handled = 0;
+	unsigned long flags;
+
+	/* TODO: make _irqsave conditional on x86 PCI IDE legacy mode */
+	spin_lock_irqsave(&host->lock, flags);
+
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap;
+
+		ap = host->ports[i];
+		if (ap &&
+		    !(ap->flags & ATA_FLAG_DISABLED)) {
+			struct ata_queued_cmd *qc;
+
+			qc = ata_qc_from_tag(ap, ap->link.active_tag);
+			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
+			    (qc->flags & ATA_QCFLAG_ACTIVE))
+				handled |= ata_host_intr(ap, qc);
+		}
+	}
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return IRQ_RETVAL(handled);
+}
+
+/**
  *	ata_bmdma_freeze - Freeze BMDMA controller port
  *	@ap: port to freeze
  *
@@ -287,6 +1605,387 @@ void ata_bmdma_thaw(struct ata_port *ap)
 }
 
 /**
+ *	ata_devchk - PATA device presence detection
+ *	@ap: ATA channel to examine
+ *	@device: Device to examine (starting at zero)
+ *
+ *	This technique was originally described in
+ *	Hale Landis's ATADRVR (www.ata-atapi.com), and
+ *	later found its way into the ATA/ATAPI spec.
+ *
+ *	Write a pattern to the ATA shadow registers,
+ *	and if a device is present, it will respond by
+ *	correctly storing and echoing back the
+ *	ATA shadow register contents.
+ *
+ *	LOCKING:
+ *	caller.
+ */
+static unsigned int ata_devchk(struct ata_port *ap, unsigned int device)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+	u8 nsect, lbal;
+
+	ap->ops->dev_select(ap, device);
+
+	iowrite8(0x55, ioaddr->nsect_addr);
+	iowrite8(0xaa, ioaddr->lbal_addr);
+
+	iowrite8(0xaa, ioaddr->nsect_addr);
+	iowrite8(0x55, ioaddr->lbal_addr);
+
+	iowrite8(0x55, ioaddr->nsect_addr);
+	iowrite8(0xaa, ioaddr->lbal_addr);
+
+	nsect = ioread8(ioaddr->nsect_addr);
+	lbal = ioread8(ioaddr->lbal_addr);
+
+	if ((nsect == 0x55) && (lbal == 0xaa))
+		return 1;	/* we found a device */
+
+	return 0;		/* nothing found */
+}
+
+/**
+ *	ata_dev_try_classify - Parse returned ATA device signature
+ *	@dev: ATA device to classify (starting at zero)
+ *	@present: device seems present
+ *	@r_err: Value of error register on completion
+ *
+ *	After an event -- SRST, E.D.D., or SATA COMRESET -- occurs,
+ *	an ATA/ATAPI-defined set of values is placed in the ATA
+ *	shadow registers, indicating the results of device detection
+ *	and diagnostics.
+ *
+ *	Select the ATA device, and read the values from the ATA shadow
+ *	registers.  Then parse according to the Error register value,
+ *	and the spec-defined values examined by ata_dev_classify().
+ *
+ *	LOCKING:
+ *	caller.
+ *
+ *	RETURNS:
+ *	Device type - %ATA_DEV_ATA, %ATA_DEV_ATAPI or %ATA_DEV_NONE.
+ */
+unsigned int ata_dev_try_classify(struct ata_device *dev, int present,
+				  u8 *r_err)
+{
+	struct ata_port *ap = dev->link->ap;
+	struct ata_taskfile tf;
+	unsigned int class;
+	u8 err;
+
+	ap->ops->dev_select(ap, dev->devno);
+
+	memset(&tf, 0, sizeof(tf));
+
+	ap->ops->tf_read(ap, &tf);
+	err = tf.feature;
+	if (r_err)
+		*r_err = err;
+
+	/* see if device passed diags: continue and warn later */
+	if (err == 0)
+		/* diagnostic fail : do nothing _YET_ */
+		dev->horkage |= ATA_HORKAGE_DIAGNOSTIC;
+	else if (err == 1)
+		/* do nothing */ ;
+	else if ((dev->devno == 0) && (err == 0x81))
+		/* do nothing */ ;
+	else
+		return ATA_DEV_NONE;
+
+	/* determine if device is ATA or ATAPI */
+	class = ata_dev_classify(&tf);
+
+	if (class == ATA_DEV_UNKNOWN) {
+		/* If the device failed diagnostic, it's likely to
+		 * have reported incorrect device signature too.
+		 * Assume ATA device if the device seems present but
+		 * device signature is invalid with diagnostic
+		 * failure.
+		 */
+		if (present && (dev->horkage & ATA_HORKAGE_DIAGNOSTIC))
+			class = ATA_DEV_ATA;
+		else
+			class = ATA_DEV_NONE;
+	} else if ((class == ATA_DEV_ATA) && (ata_chk_status(ap) == 0))
+		class = ATA_DEV_NONE;
+
+	return class;
+}
+
+static int ata_bus_post_reset(struct ata_port *ap, unsigned int devmask,
+			      unsigned long deadline)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+	unsigned int dev0 = devmask & (1 << 0);
+	unsigned int dev1 = devmask & (1 << 1);
+	int rc, ret = 0;
+
+	/* if device 0 was found in ata_devchk, wait for its
+	 * BSY bit to clear
+	 */
+	if (dev0) {
+		rc = ata_wait_ready(ap, deadline);
+		if (rc) {
+			if (rc != -ENODEV)
+				return rc;
+			ret = rc;
+		}
+	}
+
+	/* if device 1 was found in ata_devchk, wait for register
+	 * access briefly, then wait for BSY to clear.
+	 */
+	if (dev1) {
+		int i;
+
+		ap->ops->dev_select(ap, 1);
+
+		/* Wait for register access.  Some ATAPI devices fail
+		 * to set nsect/lbal after reset, so don't waste too
+		 * much time on it.  We're gonna wait for !BSY anyway.
+		 */
+		for (i = 0; i < 2; i++) {
+			u8 nsect, lbal;
+
+			nsect = ioread8(ioaddr->nsect_addr);
+			lbal = ioread8(ioaddr->lbal_addr);
+			if ((nsect == 1) && (lbal == 1))
+				break;
+			msleep(50);	/* give drive a breather */
+		}
+
+		rc = ata_wait_ready(ap, deadline);
+		if (rc) {
+			if (rc != -ENODEV)
+				return rc;
+			ret = rc;
+		}
+	}
+
+	/* is all this really necessary? */
+	ap->ops->dev_select(ap, 0);
+	if (dev1)
+		ap->ops->dev_select(ap, 1);
+	if (dev0)
+		ap->ops->dev_select(ap, 0);
+
+	return ret;
+}
+
+/**
+ *	ata_wait_after_reset - wait before checking status after reset
+ *	@ap: port containing status register to be polled
+ *	@deadline: deadline jiffies for the operation
+ *
+ *	After reset, we need to pause a while before reading status.
+ *	Also, certain combination of controller and device report 0xff
+ *	for some duration (e.g. until SATA PHY is up and running)
+ *	which is interpreted as empty port in ATA world.  This
+ *	function also waits for such devices to get out of 0xff
+ *	status.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void ata_wait_after_reset(struct ata_port *ap, unsigned long deadline)
+{
+	unsigned long until = jiffies + ATA_TMOUT_FF_WAIT;
+
+	if (time_before(until, deadline))
+		deadline = until;
+
+	/* Spec mandates ">= 2ms" before checking status.  We wait
+	 * 150ms, because that was the magic delay used for ATAPI
+	 * devices in Hale Landis's ATADRVR, for the period of time
+	 * between when the ATA command register is written, and then
+	 * status is checked.  Because waiting for "a while" before
+	 * checking status is fine, post SRST, we perform this magic
+	 * delay here as well.
+	 *
+	 * Old drivers/ide uses the 2mS rule and then waits for ready.
+	 */
+	msleep(150);
+
+	/* Wait for 0xff to clear.  Some SATA devices take a long time
+	 * to clear 0xff after reset.  For example, HHD424020F7SV00
+	 * iVDR needs >= 800ms while.  Quantum GoVault needs even more
+	 * than that.
+	 *
+	 * Note that some PATA controllers (pata_ali) explode if
+	 * status register is read more than once when there's no
+	 * device attached.
+	 */
+	if (ap->flags & ATA_FLAG_SATA) {
+		while (1) {
+			u8 status = ata_chk_status(ap);
+
+			if (status != 0xff || time_after(jiffies, deadline))
+				return;
+
+			msleep(50);
+		}
+	}
+}
+
+static int ata_bus_softreset(struct ata_port *ap, unsigned int devmask,
+			     unsigned long deadline)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+
+	DPRINTK("ata%u: bus reset via SRST\n", ap->print_id);
+
+	/* software reset.  causes dev0 to be selected */
+	iowrite8(ap->ctl, ioaddr->ctl_addr);
+	udelay(20);	/* FIXME: flush */
+	iowrite8(ap->ctl | ATA_SRST, ioaddr->ctl_addr);
+	udelay(20);	/* FIXME: flush */
+	iowrite8(ap->ctl, ioaddr->ctl_addr);
+
+	/* wait a while before checking status */
+	ata_wait_after_reset(ap, deadline);
+
+	/* Before we perform post reset processing we want to see if
+	 * the bus shows 0xFF because the odd clown forgets the D7
+	 * pulldown resistor.
+	 */
+	if (ata_chk_status(ap) == 0xFF)
+		return -ENODEV;
+
+	return ata_bus_post_reset(ap, devmask, deadline);
+}
+
+/**
+ *	ata_std_softreset - reset host port via ATA SRST
+ *	@link: ATA link to reset
+ *	@classes: resulting classes of attached devices
+ *	@deadline: deadline jiffies for the operation
+ *
+ *	Reset host port using ATA SRST.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_std_softreset(struct ata_link *link, unsigned int *classes,
+		      unsigned long deadline)
+{
+	struct ata_port *ap = link->ap;
+	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
+	unsigned int devmask = 0;
+	int rc;
+	u8 err;
+
+	DPRINTK("ENTER\n");
+
+	if (ata_link_offline(link)) {
+		classes[0] = ATA_DEV_NONE;
+		goto out;
+	}
+
+	/* determine if device 0/1 are present */
+	if (ata_devchk(ap, 0))
+		devmask |= (1 << 0);
+	if (slave_possible && ata_devchk(ap, 1))
+		devmask |= (1 << 1);
+
+	/* select device 0 again */
+	ap->ops->dev_select(ap, 0);
+
+	/* issue bus reset */
+	DPRINTK("about to softreset, devmask=%x\n", devmask);
+	rc = ata_bus_softreset(ap, devmask, deadline);
+	/* if link is occupied, -ENODEV too is an error */
+	if (rc && (rc != -ENODEV || sata_scr_valid(link))) {
+		ata_link_printk(link, KERN_ERR, "SRST failed (errno=%d)\n", rc);
+		return rc;
+	}
+
+	/* determine by signature whether we have ATA or ATAPI devices */
+	classes[0] = ata_dev_try_classify(&link->device[0],
+					  devmask & (1 << 0), &err);
+	if (slave_possible && err != 0x81)
+		classes[1] = ata_dev_try_classify(&link->device[1],
+						  devmask & (1 << 1), &err);
+
+ out:
+	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
+	return 0;
+}
+
+/**
+ *	sata_std_hardreset - reset host port via SATA phy reset
+ *	@link: link to reset
+ *	@class: resulting class of attached device
+ *	@deadline: deadline jiffies for the operation
+ *
+ *	SATA phy-reset host port using DET bits of SControl register,
+ *	wait for !BSY and classify the attached device.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int sata_std_hardreset(struct ata_link *link, unsigned int *class,
+		       unsigned long deadline)
+{
+	struct ata_port *ap = link->ap;
+	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
+	int rc;
+
+	DPRINTK("ENTER\n");
+
+	/* do hardreset */
+	rc = sata_link_hardreset(link, timing, deadline);
+	if (rc) {
+		ata_link_printk(link, KERN_ERR,
+				"COMRESET failed (errno=%d)\n", rc);
+		return rc;
+	}
+
+	/* TODO: phy layer with polling, timeouts, etc. */
+	if (ata_link_offline(link)) {
+		*class = ATA_DEV_NONE;
+		DPRINTK("EXIT, link offline\n");
+		return 0;
+	}
+
+	/* wait a while before checking status */
+	ata_wait_after_reset(ap, deadline);
+
+	/* If PMP is supported, we have to do follow-up SRST.  Note
+	 * that some PMPs don't send D2H Reg FIS after hardreset at
+	 * all if the first port is empty.  Wait for it just for a
+	 * second and request follow-up SRST.
+	 */
+	if (ap->flags & ATA_FLAG_PMP) {
+		ata_wait_ready(ap, jiffies + HZ);
+		return -EAGAIN;
+	}
+
+	rc = ata_wait_ready(ap, deadline);
+	/* link occupied, -ENODEV too is an error */
+	if (rc) {
+		ata_link_printk(link, KERN_ERR,
+				"COMRESET failed (errno=%d)\n", rc);
+		return rc;
+	}
+
+	ap->ops->dev_select(ap, 0);	/* probably unnecessary */
+
+	*class = ata_dev_try_classify(link->device, 1, NULL);
+
+	DPRINTK("EXIT, class=%u\n", *class);
+	return 0;
+}
+
+/**
  *	ata_bmdma_error_handler - Stock error handler for BMDMA controller
  *	@ap: port to handle error for
  *
@@ -395,6 +2094,31 @@ int ata_sff_port_start(struct ata_port *ap)
 }
 
 /**
+ *	ata_std_ports - initialize ioaddr with standard port offsets.
+ *	@ioaddr: IO address structure to be initialized
+ *
+ *	Utility function which initializes data_addr, error_addr,
+ *	feature_addr, nsect_addr, lbal_addr, lbam_addr, lbah_addr,
+ *	device_addr, status_addr, and command_addr to standard offsets
+ *	relative to cmd_addr.
+ *
+ *	Does not set ctl_addr, altstatus_addr, bmdma_addr, or scr_addr.
+ */
+void ata_std_ports(struct ata_ioports *ioaddr)
+{
+	ioaddr->data_addr = ioaddr->cmd_addr + ATA_REG_DATA;
+	ioaddr->error_addr = ioaddr->cmd_addr + ATA_REG_ERR;
+	ioaddr->feature_addr = ioaddr->cmd_addr + ATA_REG_FEATURE;
+	ioaddr->nsect_addr = ioaddr->cmd_addr + ATA_REG_NSECT;
+	ioaddr->lbal_addr = ioaddr->cmd_addr + ATA_REG_LBAL;
+	ioaddr->lbam_addr = ioaddr->cmd_addr + ATA_REG_LBAM;
+	ioaddr->lbah_addr = ioaddr->cmd_addr + ATA_REG_LBAH;
+	ioaddr->device_addr = ioaddr->cmd_addr + ATA_REG_DEVICE;
+	ioaddr->status_addr = ioaddr->cmd_addr + ATA_REG_STATUS;
+	ioaddr->command_addr = ioaddr->cmd_addr + ATA_REG_CMD;
+}
+
+/**
  *	ata_bmdma_setup - Set up PCI IDE BMDMA transaction
  *	@qc: Info associated with this ATA transaction.
  *
@@ -495,11 +2219,94 @@ u8 ata_bmdma_status(struct ata_port *ap)
 }
 
 /**
- *	ata_noop_irq_clear - Noop placeholder for irq_clear
- *	@ap: Port associated with this ATA transaction.
+ *	ata_bus_reset - reset host port and associated ATA channel
+ *	@ap: port to reset
+ *
+ *	This is typically the first time we actually start issuing
+ *	commands to the ATA channel.  We wait for BSY to clear, then
+ *	issue EXECUTE DEVICE DIAGNOSTIC command, polling for its
+ *	result.  Determine what devices, if any, are on the channel
+ *	by looking at the device 0/1 error register.  Look at the signature
+ *	stored in each device's taskfile registers, to determine if
+ *	the device is ATA or ATAPI.
+ *
+ *	LOCKING:
+ *	PCI/etc. bus probe sem.
+ *	Obtains host lock.
+ *
+ *	SIDE EFFECTS:
+ *	Sets ATA_FLAG_DISABLED if bus reset fails.
+ *
+ *	DEPRECATED:
+ *	This function is only for drivers which still use old EH and
+ *	will be removed soon.
  */
-void ata_noop_irq_clear(struct ata_port *ap)
+void ata_bus_reset(struct ata_port *ap)
 {
+	struct ata_device *device = ap->link.device;
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
+	u8 err;
+	unsigned int dev0, dev1 = 0, devmask = 0;
+	int rc;
+
+	DPRINTK("ENTER, host %u, port %u\n", ap->print_id, ap->port_no);
+
+	/* determine if device 0/1 are present */
+	if (ap->flags & ATA_FLAG_SATA_RESET)
+		dev0 = 1;
+	else {
+		dev0 = ata_devchk(ap, 0);
+		if (slave_possible)
+			dev1 = ata_devchk(ap, 1);
+	}
+
+	if (dev0)
+		devmask |= (1 << 0);
+	if (dev1)
+		devmask |= (1 << 1);
+
+	/* select device 0 again */
+	ap->ops->dev_select(ap, 0);
+
+	/* issue bus reset */
+	if (ap->flags & ATA_FLAG_SRST) {
+		rc = ata_bus_softreset(ap, devmask, jiffies + 40 * HZ);
+		if (rc && rc != -ENODEV)
+			goto err_out;
+	}
+
+	/*
+	 * determine by signature whether we have ATA or ATAPI devices
+	 */
+	device[0].class = ata_dev_try_classify(&device[0], dev0, &err);
+	if ((slave_possible) && (err != 0x81))
+		device[1].class = ata_dev_try_classify(&device[1], dev1, &err);
+
+	/* is double-select really necessary? */
+	if (device[1].class != ATA_DEV_NONE)
+		ap->ops->dev_select(ap, 1);
+	if (device[0].class != ATA_DEV_NONE)
+		ap->ops->dev_select(ap, 0);
+
+	/* if no devices were detected, disable this port */
+	if ((device[0].class == ATA_DEV_NONE) &&
+	    (device[1].class == ATA_DEV_NONE))
+		goto err_out;
+
+	if (ap->flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST)) {
+		/* set up device control for ATA_FLAG_SATA_RESET */
+		iowrite8(ap->ctl, ioaddr->ctl_addr);
+	}
+
+	DPRINTK("EXIT\n");
+	return;
+
+err_out:
+	ata_port_printk(ap, KERN_ERR, "disabling port\n");
+	ata_port_disable(ap);
+
+	DPRINTK("EXIT\n");
 }
 
 #ifdef CONFIG_PCI
@@ -915,3 +2722,49 @@ int ata_pci_init_one(struct pci_dev *pdev,
 
 #endif /* CONFIG_PCI */
 
+EXPORT_SYMBOL_GPL(ata_sff_port_ops);
+EXPORT_SYMBOL_GPL(ata_bmdma_port_ops);
+EXPORT_SYMBOL_GPL(ata_qc_prep);
+EXPORT_SYMBOL_GPL(ata_dumb_qc_prep);
+EXPORT_SYMBOL_GPL(ata_std_dev_select);
+EXPORT_SYMBOL_GPL(ata_check_status);
+EXPORT_SYMBOL_GPL(ata_altstatus);
+EXPORT_SYMBOL_GPL(ata_busy_sleep);
+EXPORT_SYMBOL_GPL(ata_wait_ready);
+EXPORT_SYMBOL_GPL(ata_tf_load);
+EXPORT_SYMBOL_GPL(ata_tf_read);
+EXPORT_SYMBOL_GPL(ata_exec_command);
+EXPORT_SYMBOL_GPL(ata_data_xfer);
+EXPORT_SYMBOL_GPL(ata_data_xfer_noirq);
+EXPORT_SYMBOL_GPL(ata_irq_on);
+EXPORT_SYMBOL_GPL(ata_bmdma_irq_clear);
+EXPORT_SYMBOL_GPL(ata_hsm_move);
+EXPORT_SYMBOL_GPL(ata_qc_issue_prot);
+EXPORT_SYMBOL_GPL(ata_host_intr);
+EXPORT_SYMBOL_GPL(ata_interrupt);
+EXPORT_SYMBOL_GPL(ata_bmdma_freeze);
+EXPORT_SYMBOL_GPL(ata_bmdma_thaw);
+EXPORT_SYMBOL_GPL(ata_std_prereset);
+EXPORT_SYMBOL_GPL(ata_dev_try_classify);
+EXPORT_SYMBOL_GPL(ata_wait_after_reset);
+EXPORT_SYMBOL_GPL(ata_std_softreset);
+EXPORT_SYMBOL_GPL(sata_std_hardreset);
+EXPORT_SYMBOL_GPL(ata_std_postreset);
+EXPORT_SYMBOL_GPL(ata_bmdma_error_handler);
+EXPORT_SYMBOL_GPL(ata_bmdma_post_internal_cmd);
+EXPORT_SYMBOL_GPL(ata_sff_port_start);
+EXPORT_SYMBOL_GPL(ata_std_ports);
+EXPORT_SYMBOL_GPL(ata_bmdma_setup);
+EXPORT_SYMBOL_GPL(ata_bmdma_start);
+EXPORT_SYMBOL_GPL(ata_bmdma_stop);
+EXPORT_SYMBOL_GPL(ata_bmdma_status);
+EXPORT_SYMBOL_GPL(ata_bus_reset);
+#ifdef CONFIG_PCI
+EXPORT_SYMBOL_GPL(ata_pci_clear_simplex);
+EXPORT_SYMBOL_GPL(ata_pci_default_filter);
+EXPORT_SYMBOL_GPL(ata_pci_init_bmdma);
+EXPORT_SYMBOL_GPL(ata_pci_init_sff_host);
+EXPORT_SYMBOL_GPL(ata_pci_prepare_sff_host);
+EXPORT_SYMBOL_GPL(ata_pci_activate_sff_host);
+EXPORT_SYMBOL_GPL(ata_pci_init_one);
+#endif /* CONFIG_PCI */
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index aa884f7..a69f663 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -67,6 +67,8 @@ extern int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
 			   unsigned int tag);
 extern u64 ata_tf_read_block(struct ata_taskfile *tf, struct ata_device *dev);
 extern void ata_dev_disable(struct ata_device *dev);
+extern void ata_pio_queue_task(struct ata_port *ap, void *data,
+			       unsigned long delay);
 extern void ata_port_flush_task(struct ata_port *ap);
 extern unsigned ata_exec_internal(struct ata_device *dev,
 				  struct ata_taskfile *tf, const u8 *cdb,
@@ -91,8 +93,6 @@ extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern void ata_qc_issue(struct ata_queued_cmd *qc);
 extern void __ata_qc_complete(struct ata_queued_cmd *qc);
 extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
-extern void ata_dev_select(struct ata_port *ap, unsigned int device,
-                           unsigned int wait, unsigned int can_sleep);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
 extern int ata_flush_cache(struct ata_device *dev);
 extern void ata_dev_init(struct ata_device *dev);
@@ -194,7 +194,9 @@ extern int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 extern void ata_eh_finish(struct ata_port *ap);
 
 /* libata-sff.c */
+extern void ata_dev_select(struct ata_port *ap, unsigned int device,
+                           unsigned int wait, unsigned int can_sleep);
 extern u8 ata_irq_on(struct ata_port *ap);
-
+extern void ata_pio_task(struct work_struct *work);
 
 #endif /* __LIBATA_H__ */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 47bdf38..9bfc3b2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -348,6 +348,22 @@ enum {
 	ATAPI_WRITE		= 1,		/* WRITEs */
 	ATAPI_READ_CD		= 2,		/* READ CD [MSF] */
 	ATAPI_MISC		= 3,		/* the rest */
+
+	/* Timing constants */
+	ATA_TIMING_SETUP	= (1 << 0),
+	ATA_TIMING_ACT8B	= (1 << 1),
+	ATA_TIMING_REC8B	= (1 << 2),
+	ATA_TIMING_CYC8B	= (1 << 3),
+	ATA_TIMING_8BIT		= ATA_TIMING_ACT8B | ATA_TIMING_REC8B |
+				  ATA_TIMING_CYC8B,
+	ATA_TIMING_ACTIVE	= (1 << 4),
+	ATA_TIMING_RECOVER	= (1 << 5),
+	ATA_TIMING_CYCLE	= (1 << 6),
+	ATA_TIMING_UDMA		= (1 << 7),
+	ATA_TIMING_ALL		= ATA_TIMING_SETUP | ATA_TIMING_ACT8B |
+				  ATA_TIMING_REC8B | ATA_TIMING_CYC8B |
+				  ATA_TIMING_ACTIVE | ATA_TIMING_RECOVER |
+				  ATA_TIMING_CYCLE | ATA_TIMING_UDMA,
 };
 
 enum ata_xfer_mask {
@@ -778,6 +794,9 @@ struct ata_timing {
 
 #define FIT(v, vmin, vmax)	max_t(short, min_t(short, v, vmax), vmin)
 
+/*
+ * Core layer - drivers/ata/libata-core.c
+ */
 extern const unsigned long sata_deb_timing_normal[];
 extern const unsigned long sata_deb_timing_hotplug[];
 extern const unsigned long sata_deb_timing_long[];
@@ -801,22 +820,14 @@ static inline int ata_port_is_dummy(struct ata_port *ap)
 
 extern void sata_print_link_status(struct ata_link *link);
 extern void ata_port_probe(struct ata_port *);
-extern void ata_bus_reset(struct ata_port *ap);
 extern int sata_set_spd(struct ata_link *link);
 extern int sata_link_debounce(struct ata_link *link,
 			const unsigned long *params, unsigned long deadline);
 extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
 			    unsigned long deadline);
-extern int ata_std_prereset(struct ata_link *link, unsigned long deadline);
-extern int ata_std_softreset(struct ata_link *link, unsigned int *classes,
-			     unsigned long deadline);
 extern int sata_link_hardreset(struct ata_link *link,
 			const unsigned long *timing, unsigned long deadline);
-extern int sata_std_hardreset(struct ata_link *link, unsigned int *class,
-			      unsigned long deadline);
-extern void ata_std_postreset(struct ata_link *link, unsigned int *classes);
 extern void ata_port_disable(struct ata_port *);
-extern void ata_std_ports(struct ata_ioports *ioaddr);
 
 extern struct ata_host *ata_host_alloc(struct device *dev, int max_ports);
 extern struct ata_host *ata_host_alloc_pinfo(struct device *dev,
@@ -842,7 +853,6 @@ extern void ata_sas_port_stop(struct ata_port *ap);
 extern int ata_sas_slave_configure(struct scsi_device *, struct ata_port *);
 extern int ata_sas_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *),
 			    struct ata_port *ap);
-extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
 extern int sata_scr_valid(struct ata_link *link);
 extern int sata_scr_read(struct ata_link *link, int reg, u32 *val);
 extern int sata_scr_write(struct ata_link *link, int reg, u32 val);
@@ -854,21 +864,9 @@ extern int ata_host_suspend(struct ata_host *host, pm_message_t mesg);
 extern void ata_host_resume(struct ata_host *host);
 #endif
 extern int ata_ratelimit(void);
-extern int ata_busy_sleep(struct ata_port *ap,
-			  unsigned long timeout_pat, unsigned long timeout);
-extern void ata_wait_after_reset(struct ata_port *ap, unsigned long deadline);
-extern int ata_wait_ready(struct ata_port *ap, unsigned long deadline);
 extern u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
 			     unsigned long interval_msec,
 			     unsigned long timeout_msec);
-extern unsigned int ata_dev_try_classify(struct ata_device *dev, int present,
-					 u8 *r_err);
-
-/*
- * Default driver ops implementations
- */
-extern void ata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf);
-extern void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 extern void ata_tf_to_fis(const struct ata_taskfile *tf,
 			  u8 pmp, int is_cmd, u8 *fis);
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
@@ -883,22 +881,9 @@ extern int ata_xfer_mode2shift(unsigned long xfer_mode);
 extern const char *ata_mode_string(unsigned long xfer_mask);
 extern unsigned long ata_id_xfermask(const u16 *id);
 extern void ata_noop_dev_select(struct ata_port *ap, unsigned int device);
-extern void ata_std_dev_select(struct ata_port *ap, unsigned int device);
-extern u8 ata_check_status(struct ata_port *ap);
-extern u8 ata_altstatus(struct ata_port *ap);
-extern void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf);
 extern int ata_port_start(struct ata_port *ap);
-extern int ata_sff_port_start(struct ata_port *ap);
-extern irqreturn_t ata_interrupt(int irq, void *dev_instance);
-extern unsigned int ata_data_xfer(struct ata_device *dev,
-			unsigned char *buf, unsigned int buflen, int rw);
-extern unsigned int ata_data_xfer_noirq(struct ata_device *dev,
-			unsigned char *buf, unsigned int buflen, int rw);
 extern int ata_std_qc_defer(struct ata_queued_cmd *qc);
-extern void ata_dumb_qc_prep(struct ata_queued_cmd *qc);
-extern void ata_qc_prep(struct ata_queued_cmd *qc);
 extern void ata_noop_qc_prep(struct ata_queued_cmd *qc);
-extern unsigned int ata_qc_issue_prot(struct ata_queued_cmd *qc);
 extern void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 		 unsigned int n_elem);
 extern unsigned int ata_dev_classify(const struct ata_taskfile *tf);
@@ -907,18 +892,7 @@ extern void ata_id_string(const u16 *id, unsigned char *s,
 			  unsigned int ofs, unsigned int len);
 extern void ata_id_c_string(const u16 *id, unsigned char *s,
 			    unsigned int ofs, unsigned int len);
-extern void ata_bmdma_setup(struct ata_queued_cmd *qc);
-extern void ata_bmdma_start(struct ata_queued_cmd *qc);
-extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
-extern u8   ata_bmdma_status(struct ata_port *ap);
-extern void ata_bmdma_irq_clear(struct ata_port *ap);
 extern void ata_noop_irq_clear(struct ata_port *ap);
-extern void ata_bmdma_freeze(struct ata_port *ap);
-extern void ata_bmdma_thaw(struct ata_port *ap);
-extern void ata_bmdma_error_handler(struct ata_port *ap);
-extern void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc);
-extern int ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
-			u8 status, int in_wq);
 extern void ata_qc_complete(struct ata_queued_cmd *qc);
 extern int ata_qc_complete_multiple(struct ata_port *ap, u32 qc_active,
 				    void (*finish_qc)(struct ata_queued_cmd *));
@@ -933,7 +907,6 @@ extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
 				       int queue_depth);
 extern struct ata_device *ata_dev_pair(struct ata_device *adev);
 extern int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
-extern u8 ata_irq_on(struct ata_port *ap);
 
 extern int ata_cable_40wire(struct ata_port *ap);
 extern int ata_cable_80wire(struct ata_port *ap);
@@ -941,10 +914,7 @@ extern int ata_cable_sata(struct ata_port *ap);
 extern int ata_cable_ignore(struct ata_port *ap);
 extern int ata_cable_unknown(struct ata_port *ap);
 
-/*
- * Timing helpers
- */
-
+/* Timing helpers */
 extern unsigned int ata_pio_need_iordy(const struct ata_device *);
 extern const struct ata_timing *ata_timing_find_mode(u8 xfer_mode);
 extern int ata_timing_compute(struct ata_device *, unsigned short,
@@ -954,24 +924,31 @@ extern void ata_timing_merge(const struct ata_timing *,
 			     unsigned int);
 extern u8 ata_timing_cycle2mode(unsigned int xfer_shift, int cycle);
 
-enum {
-	ATA_TIMING_SETUP	= (1 << 0),
-	ATA_TIMING_ACT8B	= (1 << 1),
-	ATA_TIMING_REC8B	= (1 << 2),
-	ATA_TIMING_CYC8B	= (1 << 3),
-	ATA_TIMING_8BIT		= ATA_TIMING_ACT8B | ATA_TIMING_REC8B |
-				  ATA_TIMING_CYC8B,
-	ATA_TIMING_ACTIVE	= (1 << 4),
-	ATA_TIMING_RECOVER	= (1 << 5),
-	ATA_TIMING_CYCLE	= (1 << 6),
-	ATA_TIMING_UDMA		= (1 << 7),
-	ATA_TIMING_ALL		= ATA_TIMING_SETUP | ATA_TIMING_ACT8B |
-				  ATA_TIMING_REC8B | ATA_TIMING_CYC8B |
-				  ATA_TIMING_ACTIVE | ATA_TIMING_RECOVER |
-				  ATA_TIMING_CYCLE | ATA_TIMING_UDMA,
+/* PCI */
+#ifdef CONFIG_PCI
+struct pci_dev;
+
+struct pci_bits {
+	unsigned int		reg;	/* PCI config register to read */
+	unsigned int		width;	/* 1 (8 bit), 2 (16 bit), 4 (32 bit) */
+	unsigned long		mask;
+	unsigned long		val;
 };
 
-/* libata-acpi.c */
+extern int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits);
+extern void ata_pci_remove_one(struct pci_dev *pdev);
+
+#ifdef CONFIG_PM
+extern void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg);
+extern int __must_check ata_pci_device_do_resume(struct pci_dev *pdev);
+extern int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
+extern int ata_pci_device_resume(struct pci_dev *pdev);
+#endif /* CONFIG_PM */
+#endif /* CONFIG_PCI */
+
+/*
+ * ACPI - drivers/ata/libata-acpi.c
+ */
 #ifdef CONFIG_ATA_ACPI
 static inline const struct ata_acpi_gtm *ata_acpi_init_gtm(struct ata_port *ap)
 {
@@ -1015,43 +992,8 @@ static inline int ata_acpi_cbl_80wire(struct ata_port *ap,
 }
 #endif
 
-#ifdef CONFIG_PCI
-struct pci_dev;
-
-extern int ata_pci_init_one(struct pci_dev *pdev,
-			    const struct ata_port_info * const * ppi,
-			    struct scsi_host_template *sht, void *host_priv);
-extern void ata_pci_remove_one(struct pci_dev *pdev);
-#ifdef CONFIG_PM
-extern void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg);
-extern int __must_check ata_pci_device_do_resume(struct pci_dev *pdev);
-extern int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
-extern int ata_pci_device_resume(struct pci_dev *pdev);
-#endif
-extern int ata_pci_clear_simplex(struct pci_dev *pdev);
-
-struct pci_bits {
-	unsigned int		reg;	/* PCI config register to read */
-	unsigned int		width;	/* 1 (8 bit), 2 (16 bit), 4 (32 bit) */
-	unsigned long		mask;
-	unsigned long		val;
-};
-
-extern int ata_pci_init_sff_host(struct ata_host *host);
-extern int ata_pci_init_bmdma(struct ata_host *host);
-extern int ata_pci_prepare_sff_host(struct pci_dev *pdev,
-				    const struct ata_port_info * const * ppi,
-				    struct ata_host **r_host);
-extern int ata_pci_activate_sff_host(struct ata_host *host,
-				     irq_handler_t irq_handler,
-				     struct scsi_host_template *sht);
-extern int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits);
-extern unsigned long ata_pci_default_filter(struct ata_device *dev,
-					    unsigned long xfer_mask);
-#endif /* CONFIG_PCI */
-
 /*
- * PMP
+ * PMP - drivers/ata/libata-pmp.c
  */
 extern int sata_pmp_qc_defer_cmd_switch(struct ata_queued_cmd *qc);
 extern int sata_pmp_std_prereset(struct ata_link *link, unsigned long deadline);
@@ -1061,7 +1003,7 @@ extern void sata_pmp_std_postreset(struct ata_link *link, unsigned int *class);
 extern void sata_pmp_error_handler(struct ata_port *ap);
 
 /*
- * EH
+ * EH - drivers/ata/libata-eh.c
  */
 extern void ata_port_schedule_eh(struct ata_port *ap);
 extern int ata_link_abort(struct ata_link *link);
@@ -1104,8 +1046,6 @@ extern void ata_std_error_handler(struct ata_port *ap);
 extern const struct ata_port_operations ata_base_port_ops;
 extern const struct ata_port_operations sata_port_ops;
 extern const struct ata_port_operations sata_pmp_port_ops;
-extern const struct ata_port_operations ata_sff_port_ops;
-extern const struct ata_port_operations ata_bmdma_port_ops;
 
 #define ATA_BASE_SHT(drv_name)					\
 	.module			= THIS_MODULE,			\
@@ -1122,17 +1062,6 @@ extern const struct ata_port_operations ata_bmdma_port_ops;
 	.slave_destroy		= ata_scsi_slave_destroy,	\
 	.bios_param		= ata_std_bios_param
 
-/* PIO only, sg_tablesize and dma_boundary limits can be removed */
-#define ATA_PIO_SHT(drv_name)					\
-	ATA_BASE_SHT(drv_name),					\
-	.sg_tablesize		= LIBATA_MAX_PRD,		\
-	.dma_boundary		= ATA_DMA_BOUNDARY
-
-#define ATA_BMDMA_SHT(drv_name)					\
-	ATA_BASE_SHT(drv_name),					\
-	.sg_tablesize		= LIBATA_MAX_PRD,		\
-	.dma_boundary		= ATA_DMA_BOUNDARY
-
 #define ATA_NCQ_SHT(drv_name)					\
 	ATA_BASE_SHT(drv_name),					\
 	.change_queue_depth	= ata_scsi_change_queue_depth
@@ -1285,11 +1214,6 @@ static inline struct ata_link *ata_port_next_link(struct ata_link *link)
 	for ((dev) = (link)->device + ata_link_max_devices(link) - 1; \
 	     (dev) >= (link)->device || ((dev) = NULL); (dev)--)
 
-static inline u8 ata_chk_status(struct ata_port *ap)
-{
-	return ap->ops->check_status(ap);
-}
-
 /**
  *	ata_ncq_enabled - Test whether NCQ is enabled
  *	@dev: ATA device to test for
@@ -1306,74 +1230,6 @@ static inline int ata_ncq_enabled(struct ata_device *dev)
 			      ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ;
 }
 
-/**
- *	ata_pause - Flush writes and pause 400 nanoseconds.
- *	@ap: Port to wait for.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
-static inline void ata_pause(struct ata_port *ap)
-{
-	ata_altstatus(ap);
-	ndelay(400);
-}
-
-
-/**
- *	ata_busy_wait - Wait for a port status register
- *	@ap: Port to wait for.
- *	@bits: bits that must be clear
- *	@max: number of 10uS waits to perform
- *
- *	Waits up to max*10 microseconds for the selected bits in the port's
- *	status register to be cleared.
- *	Returns final value of status register.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
-static inline u8 ata_busy_wait(struct ata_port *ap, unsigned int bits,
-			       unsigned int max)
-{
-	u8 status;
-
-	do {
-		udelay(10);
-		status = ata_chk_status(ap);
-		max--;
-	} while (status != 0xff && (status & bits) && (max > 0));
-
-	return status;
-}
-
-
-/**
- *	ata_wait_idle - Wait for a port to be idle.
- *	@ap: Port to wait for.
- *
- *	Waits up to 10ms for port's BUSY and DRQ signals to clear.
- *	Returns final value of status register.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
-static inline u8 ata_wait_idle(struct ata_port *ap)
-{
-	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
-
-#ifdef ATA_DEBUG
-	if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ)))
-		ata_port_printk(ap, KERN_DEBUG, "abnormal Status 0x%X\n",
-				status);
-#endif
-
-	return status;
-}
-
 static inline void ata_qc_set_polling(struct ata_queued_cmd *qc)
 {
 	qc->tf.ctl |= ATA_NIEN;
@@ -1487,4 +1343,149 @@ static inline struct ata_port *ata_shost_to_port(struct Scsi_Host *host)
 	return *(struct ata_port **)&host->hostdata[0];
 }
 
+/**************************************************************************
+ * SFF - drivers/ata/libata-sff.c
+ */
+extern const struct ata_port_operations ata_sff_port_ops;
+extern const struct ata_port_operations ata_bmdma_port_ops;
+
+/* PIO only, sg_tablesize and dma_boundary limits can be removed */
+#define ATA_PIO_SHT(drv_name)					\
+	ATA_BASE_SHT(drv_name),					\
+	.sg_tablesize		= LIBATA_MAX_PRD,		\
+	.dma_boundary		= ATA_DMA_BOUNDARY
+
+#define ATA_BMDMA_SHT(drv_name)					\
+	ATA_BASE_SHT(drv_name),					\
+	.sg_tablesize		= LIBATA_MAX_PRD,		\
+	.dma_boundary		= ATA_DMA_BOUNDARY
+
+extern void ata_qc_prep(struct ata_queued_cmd *qc);
+extern void ata_dumb_qc_prep(struct ata_queued_cmd *qc);
+extern void ata_std_dev_select(struct ata_port *ap, unsigned int device);
+extern u8 ata_check_status(struct ata_port *ap);
+extern u8 ata_altstatus(struct ata_port *ap);
+extern int ata_busy_sleep(struct ata_port *ap,
+			  unsigned long timeout_pat, unsigned long timeout);
+extern int ata_wait_ready(struct ata_port *ap, unsigned long deadline);
+extern void ata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf);
+extern void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
+extern void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf);
+extern unsigned int ata_data_xfer(struct ata_device *dev,
+			unsigned char *buf, unsigned int buflen, int rw);
+extern unsigned int ata_data_xfer_noirq(struct ata_device *dev,
+			unsigned char *buf, unsigned int buflen, int rw);
+extern u8 ata_irq_on(struct ata_port *ap);
+extern void ata_bmdma_irq_clear(struct ata_port *ap);
+extern int ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
+			u8 status, int in_wq);
+extern unsigned int ata_qc_issue_prot(struct ata_queued_cmd *qc);
+extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
+extern irqreturn_t ata_interrupt(int irq, void *dev_instance);
+extern void ata_bmdma_freeze(struct ata_port *ap);
+extern void ata_bmdma_thaw(struct ata_port *ap);
+extern int ata_std_prereset(struct ata_link *link, unsigned long deadline);
+extern unsigned int ata_dev_try_classify(struct ata_device *dev, int present,
+					 u8 *r_err);
+extern void ata_wait_after_reset(struct ata_port *ap, unsigned long deadline);
+extern int ata_std_softreset(struct ata_link *link, unsigned int *classes,
+			     unsigned long deadline);
+extern int sata_std_hardreset(struct ata_link *link, unsigned int *class,
+			      unsigned long deadline);
+extern void ata_std_postreset(struct ata_link *link, unsigned int *classes);
+extern void ata_bmdma_error_handler(struct ata_port *ap);
+extern void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc);
+extern int ata_sff_port_start(struct ata_port *ap);
+extern void ata_std_ports(struct ata_ioports *ioaddr);
+extern void ata_bmdma_setup(struct ata_queued_cmd *qc);
+extern void ata_bmdma_start(struct ata_queued_cmd *qc);
+extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
+extern u8 ata_bmdma_status(struct ata_port *ap);
+extern void ata_bus_reset(struct ata_port *ap);
+
+#ifdef CONFIG_PCI
+extern int ata_pci_clear_simplex(struct pci_dev *pdev);
+extern unsigned long ata_pci_default_filter(struct ata_device *dev,
+					    unsigned long xfer_mask);
+extern int ata_pci_init_bmdma(struct ata_host *host);
+extern int ata_pci_init_sff_host(struct ata_host *host);
+extern int ata_pci_prepare_sff_host(struct pci_dev *pdev,
+				    const struct ata_port_info * const * ppi,
+				    struct ata_host **r_host);
+extern int ata_pci_activate_sff_host(struct ata_host *host,
+				     irq_handler_t irq_handler,
+				     struct scsi_host_template *sht);
+extern int ata_pci_init_one(struct pci_dev *pdev,
+			    const struct ata_port_info * const * ppi,
+			    struct scsi_host_template *sht, void *host_priv);
+#endif /* CONFIG_PCI */
+
+static inline u8 ata_chk_status(struct ata_port *ap)
+{
+	return ap->ops->check_status(ap);
+}
+
+/**
+ *	ata_pause - Flush writes and pause 400 nanoseconds.
+ *	@ap: Port to wait for.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+static inline void ata_pause(struct ata_port *ap)
+{
+	ata_altstatus(ap);
+	ndelay(400);
+}
+
+/**
+ *	ata_busy_wait - Wait for a port status register
+ *	@ap: Port to wait for.
+ *	@bits: bits that must be clear
+ *	@max: number of 10uS waits to perform
+ *
+ *	Waits up to max*10 microseconds for the selected bits in the port's
+ *	status register to be cleared.
+ *	Returns final value of status register.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+static inline u8 ata_busy_wait(struct ata_port *ap, unsigned int bits,
+			       unsigned int max)
+{
+	u8 status;
+
+	do {
+		udelay(10);
+		status = ata_chk_status(ap);
+		max--;
+	} while (status != 0xff && (status & bits) && (max > 0));
+
+	return status;
+}
+
+/**
+ *	ata_wait_idle - Wait for a port to be idle.
+ *	@ap: Port to wait for.
+ *
+ *	Waits up to 10ms for port's BUSY and DRQ signals to clear.
+ *	Returns final value of status register.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+static inline u8 ata_wait_idle(struct ata_port *ap)
+{
+	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
+
+#ifdef ATA_DEBUG
+	if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ)))
+		ata_port_printk(ap, KERN_DEBUG, "abnormal Status 0x%X\n",
+				status);
+#endif
+
+	return status;
+}
+
 #endif /* __LINUX_LIBATA_H__ */
-- 
1.5.2.4

