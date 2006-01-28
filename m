From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH] libata docs patches merged
Date: Fri, 27 Jan 2006 20:50:17 -0800
Message-ID: <20060127205017.102dddb3.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:27050 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932516AbWA1EuB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jan 2006 23:50:01 -0500
Received: from midway.site ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Fri, 27 Jan 2006 20:50:00 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik <jgarzik@pobox.com>, tali@admingilde.org
Cc: ide <linux-ide@vger.kernel.org>

This is a merger of libata docs + cleanups from
Martin Waitz <tali@admingilde.org> and me.

From: Randy Dunlap <rdunlap@xenotime.net>
From: Martin Waitz <tali@admingilde.org>

Fix libata kernel-doc comments to match code.
Add some function parameters to kernel-doc.
Fix some typos/spellos.
Put comments in <= 80 columns.
Make one DPRINTK string unique.
Fix sparse cast warnings.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/scsi/ata_piix.c    |    1 
 drivers/scsi/libata-core.c |   60 ++++++++++++++++++++++-----------------------
 drivers/scsi/libata-scsi.c |    9 +++---
 3 files changed, 36 insertions(+), 34 deletions(-)

--- linux-2616-rc1g4.orig/drivers/scsi/ata_piix.c
+++ linux-2616-rc1g4/drivers/scsi/ata_piix.c
@@ -627,6 +627,7 @@ static int piix_disable_ahci(struct pci_
 
 /**
  *	piix_check_450nx_errata	-	Check for problem 450NX setup
+ *	@ata_dev: the PCI device to check
  *	
  *	Check for the present of 450NX errata #19 and errata #25. If
  *	they are found return an error code so we can turn off DMA
--- linux-2616-rc1g4.orig/drivers/scsi/libata-scsi.c
+++ linux-2616-rc1g4/drivers/scsi/libata-scsi.c
@@ -151,7 +151,7 @@ int ata_cmd_ioctl(struct scsi_device *sc
 	struct scsi_sense_hdr sshdr;
 	enum dma_data_direction data_dir;
 
-	if (NULL == (void *)arg)
+	if (arg == NULL)
 		return -EINVAL;
 
 	if (copy_from_user(args, arg, sizeof(args)))
@@ -201,7 +201,7 @@ int ata_cmd_ioctl(struct scsi_device *sc
 	/* Need code to retrieve data from check condition? */
 
 	if ((argbuf)
-	 && copy_to_user((void *)(arg + sizeof(args)), argbuf, argsize))
+	 && copy_to_user(arg + sizeof(args), argbuf, argsize))
 		rc = -EFAULT;
 error:
 	if (argbuf)
@@ -228,7 +228,7 @@ int ata_task_ioctl(struct scsi_device *s
 	u8 args[7];
 	struct scsi_sense_hdr sshdr;
 
-	if (NULL == (void *)arg)
+	if (arg == NULL)
 		return -EINVAL;
 
 	if (copy_from_user(args, arg, sizeof(args)))
@@ -2492,7 +2492,8 @@ out_unlock:
 
 /**
  *	ata_scsi_simulate - simulate SCSI command on ATA device
- *	@id: current IDENTIFY data for target device.
+ *	@ap: port the device is connected to
+ *	@dev: the target device
  *	@cmd: SCSI command being sent to device.
  *	@done: SCSI command completion function.
  *
--- linux-2616-rc1g4.orig/drivers/scsi/libata-core.c
+++ linux-2616-rc1g4/drivers/scsi/libata-core.c
@@ -1439,12 +1439,11 @@ static inline u8 ata_dev_knobble(const s
 }
 
 /**
- * 	ata_dev_config - Run device specific handlers and check for
- * 			 SATA->PATA bridges
- * 	@ap: Bus
- * 	@i:  Device
+ * ata_dev_config - Run device specific handlers & check for SATA->PATA bridges
+ * @ap: Bus
+ * @i:  Device
  *
- * 	LOCKING:
+ * LOCKING:
  */
 
 void ata_dev_config(struct ata_port *ap, unsigned int i)
@@ -1752,9 +1751,9 @@ int ata_timing_compute(struct ata_device
 	ata_timing_quantize(t, t, T, UT);
 
 	/*
-	 * Even in DMA/UDMA modes we still use PIO access for IDENTIFY, S.M.A.R.T
-	 * and some other commands. We have to ensure that the DMA cycle timing is
-	 * slower/equal than the fastest PIO timing.
+	 * Even in DMA/UDMA modes we still use PIO access for IDENTIFY,
+	 * S.M.A.R.T * and some other commands. We have to ensure that the
+	 * DMA cycle timing is slower/equal than the fastest PIO timing.
 	 */
 
 	if (speed > XFER_PIO_4) {
@@ -1763,7 +1762,7 @@ int ata_timing_compute(struct ata_device
 	}
 
 	/*
-	 * Lenghten active & recovery time so that cycle time is correct.
+	 * Lengthen active & recovery time so that cycle time is correct.
 	 */
 
 	if (t->act8b + t->rec8b < t->cyc8b) {
@@ -1882,7 +1881,6 @@ static void ata_host_set_dma(struct ata_
  *
  *	LOCKING:
  *	PCI/etc. bus probe sem.
- *
  */
 static void ata_set_mode(struct ata_port *ap)
 {
@@ -1931,7 +1929,6 @@ err_out:
  *	or a timeout occurs.
  *
  *	LOCKING: None.
- *
  */
 
 static unsigned int ata_busy_sleep (struct ata_port *ap,
@@ -2869,7 +2866,7 @@ void ata_poll_qc_complete(struct ata_que
 }
 
 /**
- *	ata_pio_poll -
+ *	ata_pio_poll - poll using PIO, depending on current state
  *	@ap: the target ata_port
  *
  *	LOCKING:
@@ -2976,7 +2973,7 @@ static int ata_pio_complete (struct ata_
 
 
 /**
- *	swap_buf_le16 - swap halves of 16-words in place
+ *	swap_buf_le16 - swap halves of 16-bit words in place
  *	@buf:  Buffer to swap
  *	@buf_words:  Number of 16-bit words in buffer.
  *
@@ -4212,19 +4209,6 @@ err_out:
 }
 
 
-/**
- *	ata_port_start - Set port up for dma.
- *	@ap: Port to initialize
- *
- *	Called just after data structures for each port are
- *	initialized.  Allocates space for PRD table.
- *
- *	May be used as the port_start() entry in ata_port_operations.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
 /*
  * Execute a 'simple' command, that only consists of the opcode 'cmd' itself,
  * without filling any other registers
@@ -4276,6 +4260,8 @@ static int ata_start_drive(struct ata_po
 
 /**
  *	ata_device_resume - wakeup a previously suspended devices
+ *	@ap: port the device is connected to
+ *	@dev: the device to resume
  *
  *	Kick the drive back into action, by sending it an idle immediate
  *	command and making sure its transfer mode matches between drive
@@ -4298,10 +4284,11 @@ int ata_device_resume(struct ata_port *a
 
 /**
  *	ata_device_suspend - prepare a device for suspend
+ *	@ap: port the device is connected to
+ *	@dev: the device to suspend
  *
  *	Flush the cache on the drive, if appropriate, then issue a
  *	standbynow command.
- *
  */
 int ata_device_suspend(struct ata_port *ap, struct ata_device *dev)
 {
@@ -4315,6 +4302,19 @@ int ata_device_suspend(struct ata_port *
 	return 0;
 }
 
+/**
+ *	ata_port_start - Set port up for dma.
+ *	@ap: Port to initialize
+ *
+ *	Called just after data structures for each port are
+ *	initialized.  Allocates space for PRD table.
+ *
+ *	May be used as the port_start() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+
 int ata_port_start (struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
@@ -4571,9 +4571,9 @@ int ata_device_add(const struct ata_prob
 
 		ap = host_set->ports[i];
 
-		DPRINTK("ata%u: probe begin\n", ap->id);
+		DPRINTK("ata%u: bus probe begin\n", ap->id);
 		rc = ata_bus_probe(ap);
-		DPRINTK("ata%u: probe end\n", ap->id);
+		DPRINTK("ata%u: bus probe end\n", ap->id);
 
 		if (rc) {
 			/* FIXME: do something useful here?
@@ -4597,7 +4597,7 @@ int ata_device_add(const struct ata_prob
 	}
 
 	/* probes are done, now scan each port's disk(s) */
-	DPRINTK("probe begin\n");
+	DPRINTK("host probe begin\n");
 	for (i = 0; i < count; i++) {
 		struct ata_port *ap = host_set->ports[i];
 

---
