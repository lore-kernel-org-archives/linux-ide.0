From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH] libata kernel-doc fixes
Date: Mon, 24 Oct 2005 22:26:32 -0700
Message-ID: <20051024222632.60baf8bc.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:22438 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751460AbVJYF0e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Oct 2005 01:26:34 -0400
Received: from midway ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2005 22:26:33 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik <jgarzik@pobox.com>

From: Randy Dunlap <rdunlap@xenotime.net>

Correct some function names in kernel-doc.
Add some kernel-doc descriptions.
Fix some typos.
Remove a few blank lines.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 drivers/scsi/libata-core.c |   36 +++++++++++++----------------------
 1 files changed, 14 insertions(+), 22 deletions(-)

diff -Naurp linux-2614-rc5/drivers/scsi/libata-core.c~kdoc_libata linux-2614-rc5/drivers/scsi/libata-core.c
--- linux-2614-rc5/drivers/scsi/libata-core.c~kdoc_libata	2005-10-20 18:55:34.000000000 -0700
+++ linux-2614-rc5/drivers/scsi/libata-core.c	2005-10-24 21:57:44.000000000 -0700
@@ -85,7 +85,7 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
 /**
- *	ata_tf_load - send taskfile registers to host controller
+ *	ata_tf_load_pio - send taskfile registers to host controller
  *	@ap: Port to which output is sent
  *	@tf: ATA taskfile register set
  *
@@ -2413,13 +2413,13 @@ void ata_poll_qc_complete(struct ata_que
 
 /**
  *	ata_pio_poll -
- *	@ap:
+ *	@ap: the target ata_port
  *
  *	LOCKING:
  *	None.  (executing in kernel thread context)
  *
  *	RETURNS:
- *
+ *	timeout value to use
  */
 
 static unsigned long ata_pio_poll(struct ata_port *ap)
@@ -2460,8 +2460,8 @@ static unsigned long ata_pio_poll(struct
 }
 
 /**
- *	ata_pio_complete -
- *	@ap:
+ *	ata_pio_complete - check if drive is busy or idle
+ *	@ap: the target ata_port
  *
  *	LOCKING:
  *	None.  (executing in kernel thread context)
@@ -2513,7 +2513,7 @@ static int ata_pio_complete (struct ata_
 
 
 /**
- *	swap_buf_le16 -
+ *	swap_buf_le16 - swap halves of 16-words in place
  *	@buf:  Buffer to swap
  *	@buf_words:  Number of 16-bit words in buffer.
  *
@@ -2522,6 +2522,7 @@ static int ata_pio_complete (struct ata_
  *	vice-versa.
  *
  *	LOCKING:
+ *	Inherited from caller.
  */
 void swap_buf_le16(u16 *buf, unsigned int buf_words)
 {
@@ -2544,7 +2545,6 @@ void swap_buf_le16(u16 *buf, unsigned in
  *
  *	LOCKING:
  *	Inherited from caller.
- *
  */
 
 static void ata_mmio_data_xfer(struct ata_port *ap, unsigned char *buf,
@@ -2590,7 +2590,6 @@ static void ata_mmio_data_xfer(struct at
  *
  *	LOCKING:
  *	Inherited from caller.
- *
  */
 
 static void ata_pio_data_xfer(struct ata_port *ap, unsigned char *buf,
@@ -2630,7 +2629,6 @@ static void ata_pio_data_xfer(struct ata
  *
  *	LOCKING:
  *	Inherited from caller.
- *
  */
 
 static void ata_data_xfer(struct ata_port *ap, unsigned char *buf,
@@ -2783,7 +2781,6 @@ next_sg:
  *
  *	LOCKING:
  *	Inherited from caller.
- *
  */
 
 static void atapi_pio_bytes(struct ata_queued_cmd *qc)
@@ -2819,8 +2816,8 @@ err_out:
 }
 
 /**
- *	ata_pio_sector -
- *	@ap:
+ *	ata_pio_block - start PIO on a block
+ *	@ap: the target ata_port
  *
  *	LOCKING:
  *	None.  (executing in kernel thread context)
@@ -2832,7 +2829,7 @@ static void ata_pio_block(struct ata_por
 	u8 status;
 
 	/*
-	 * This is purely hueristic.  This is a fast path.
+	 * This is purely heuristic.  This is a fast path.
 	 * Sometimes when we enter, BSY will be cleared in
 	 * a chk-status or two.  If not, the drive is probably seeking
 	 * or something.  Snooze for a couple msecs, then
@@ -3201,7 +3198,6 @@ static void __ata_qc_complete(struct ata
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
- *
  */
 void ata_qc_free(struct ata_queued_cmd *qc)
 {
@@ -3221,7 +3217,6 @@ void ata_qc_free(struct ata_queued_cmd *
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
- *
  */
 
 void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
@@ -3715,7 +3710,6 @@ idle_irq:
  *
  *	RETURNS:
  *	IRQ_NONE or IRQ_HANDLED.
- *
  */
 
 irqreturn_t ata_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
@@ -3827,6 +3821,7 @@ err_out:
  *	May be used as the port_start() entry in ata_port_operations.
  *
  *	LOCKING:
+ *	Inherited from caller.
  */
 
 int ata_port_start (struct ata_port *ap)
@@ -3852,6 +3847,7 @@ int ata_port_start (struct ata_port *ap)
  *	May be used as the port_stop() entry in ata_port_operations.
  *
  *	LOCKING:
+ *	Inherited from caller.
  */
 
 void ata_port_stop (struct ata_port *ap)
@@ -3874,6 +3870,7 @@ void ata_host_stop (struct ata_host_set 
  *	@do_unregister: 1 if we fully unregister, 0 to just stop the port
  *
  *	LOCKING:
+ *	Inherited from caller.
  */
 
 static void ata_host_remove(struct ata_port *ap, unsigned int do_unregister)
@@ -3901,7 +3898,6 @@ static void ata_host_remove(struct ata_p
  *
  *	LOCKING:
  *	Inherited from caller.
- *
  */
 
 static void ata_host_init(struct ata_port *ap, struct Scsi_Host *host,
@@ -3962,7 +3958,6 @@ static void ata_host_init(struct ata_por
  *
  *	RETURNS:
  *	New ata_port on success, for NULL on error.
- *
  */
 
 static struct ata_port * ata_host_add(struct ata_probe_ent *ent,
@@ -4010,7 +4005,6 @@ err_out:
  *
  *	RETURNS:
  *	Number of ports registered.  Zero on error (no ports registered).
- *
  */
 
 int ata_device_add(struct ata_probe_ent *ent)
@@ -4142,7 +4136,6 @@ err_out:
  *	Inherited from calling layer (may sleep).
  */
 
-
 void ata_host_set_remove(struct ata_host_set *host_set)
 {
 	struct ata_port *ap;
@@ -4374,7 +4367,6 @@ ata_pci_init_legacy_mode(struct pci_dev 
  *
  *	RETURNS:
  *	Zero on success, negative on errno-based value on error.
- *
  */
 
 int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
@@ -4505,7 +4497,7 @@ err_out:
  *	@pdev: PCI device that was removed
  *
  *	PCI layer indicates to libata via this hook that
- *	hot-unplug or module unload event has occured.
+ *	hot-unplug or module unload event has occurred.
  *	Handle this by unregistering all objects associated
  *	with this PCI device.  Free those objects.  Then finally
  *	release PCI resources and disable device.


---
