From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCHES] 2.6.x libata minor fixes
Date: Thu, 2 Dec 2004 01:36:49 -0500
Message-ID: <20041202063649.GA2664@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:38809 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261562AbULBGgx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Dec 2004 01:36:53 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org


Please do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 Documentation/DocBook/libata.tmpl |  192 +++++++++++++++++++++++++++++++++++++-
 drivers/scsi/ahci.c               |    5 
 drivers/scsi/libata-core.c        |   10 +
 drivers/scsi/libata-scsi.c        |    4 
 4 files changed, 201 insertions(+), 10 deletions(-)

through these ChangeSets:

<jgarzik@pobox.com> (04/11/17 1.2147.1.122)
   [libata docs] add chapter on libata driver API

<jgarzik@pobox.com> (04/11/16 1.2147.2.2)
   [libata ahci] minor fixes
   
   Add support for ioctl handling.
   Remove incorrect comment.

<jgarzik@pobox.com> (04/11/15 1.2147.2.1)
   [libata] fix DocBook bugs

diff -Nru a/Documentation/DocBook/libata.tmpl b/Documentation/DocBook/libata.tmpl
--- a/Documentation/DocBook/libata.tmpl	2004-12-02 01:33:06 -05:00
+++ b/Documentation/DocBook/libata.tmpl	2004-12-02 01:33:06 -05:00
@@ -61,6 +61,196 @@
   </para>
   </chapter>
 
+  <chapter id="libataDriverApi">
+     <title>libata Driver API</title>
+     <sect1>
+        <title>struct ata_port_operations</title>
+
+	<programlisting>
+void (*port_disable) (struct ata_port *);
+	</programlisting>
+
+	<para>
+	Called from ata_bus_probe() and ata_bus_reset() error paths,
+	as well as when unregistering from the SCSI module (rmmod, hot
+	unplug).
+	</para>
+
+	<programlisting>
+void (*dev_config) (struct ata_port *, struct ata_device *);
+	</programlisting>
+
+	<para>
+	Called after IDENTIFY [PACKET] DEVICE is issued to each device
+	found.  Typically used to apply device-specific fixups prior to
+	issue of SET FEATURES - XFER MODE, and prior to operation.
+	</para>
+
+	<programlisting>
+void (*set_piomode) (struct ata_port *, struct ata_device *);
+void (*set_dmamode) (struct ata_port *, struct ata_device *);
+void (*post_set_mode) (struct ata_port *ap);
+	</programlisting>
+
+	<para>
+	Hooks called prior to the issue of SET FEATURES - XFER MODE
+	command.  dev->pio_mode is guaranteed to be valid when
+	->set_piomode() is called, and dev->dma_mode is guaranteed to be
+	valid when ->set_dmamode() is called.  ->post_set_mode() is
+	called unconditionally, after the SET FEATURES - XFER MODE
+	command completes successfully.
+	</para>
+
+	<para>
+	->set_piomode() is always called (if present), but
+	->set_dma_mode() is only called if DMA is possible.
+	</para>
+
+	<programlisting>
+void (*tf_load) (struct ata_port *ap, struct ata_taskfile *tf);
+void (*tf_read) (struct ata_port *ap, struct ata_taskfile *tf);
+	</programlisting>
+
+	<para>
+	->tf_load() is called to load the given taskfile into hardware
+	registers / DMA buffers.  ->tf_read() is called to read the
+	hardware registers / DMA buffers, to obtain the current set of
+	taskfile register values.
+	</para>
+
+	<programlisting>
+void (*exec_command)(struct ata_port *ap, struct ata_taskfile *tf);
+	</programlisting>
+
+	<para>
+	causes an ATA command, previously loaded with
+	->tf_load(), to be initiated in hardware.
+	</para>
+
+	<programlisting>
+u8   (*check_status)(struct ata_port *ap);
+void (*dev_select)(struct ata_port *ap, unsigned int device);
+	</programlisting>
+
+	<para>
+	Reads the Status ATA shadow register from hardware.  On some
+	hardware, this has the side effect of clearing the interrupt
+	condition.
+	</para>
+
+	<programlisting>
+void (*dev_select)(struct ata_port *ap, unsigned int device);
+	</programlisting>
+
+	<para>
+	Issues the low-level hardware command(s) that causes one of N
+	hardware devices to be considered 'selected' (active and
+	available for use) on the ATA bus.
+	</para>
+
+	<programlisting>
+void (*phy_reset) (struct ata_port *ap);
+	</programlisting>
+
+	<para>
+	The very first step in the probe phase.  Actions vary depending
+	on the bus type, typically.  After waking up the device and probing
+	for device presence (PATA and SATA), typically a soft reset
+	(SRST) will be performed.  Drivers typically use the helper
+	functions ata_bus_reset() or sata_phy_reset() for this hook.
+	</para>
+
+	<programlisting>
+void (*bmdma_setup) (struct ata_queued_cmd *qc);
+void (*bmdma_start) (struct ata_queued_cmd *qc);
+	</programlisting>
+
+	<para>
+	When setting up an IDE BMDMA transaction, these hooks arm
+	(->bmdma_setup) and fire (->bmdma_start) the hardware's DMA
+	engine.
+	</para>
+
+	<programlisting>
+void (*qc_prep) (struct ata_queued_cmd *qc);
+int (*qc_issue) (struct ata_queued_cmd *qc);
+	</programlisting>
+
+	<para>
+	Higher-level hooks, these two hooks can potentially supercede
+	several of the above taskfile/DMA engine hooks.  ->qc_prep is
+	called after the buffers have been DMA-mapped, and is typically
+	used to populate the hardware's DMA scatter-gather table.
+	Most drivers use the standard ata_qc_prep() helper function, but
+	more advanced drivers roll their own.
+	</para>
+	<para>
+	->qc_issue is used to make a command active, once the hardware
+	and S/G tables have been prepared.  IDE BMDMA drivers use the
+	helper function ata_qc_issue_prot() for taskfile protocol-based
+	dispatch.  More advanced drivers roll their own ->qc_issue
+	implementation, using this as the "issue new ATA command to
+	hardware" hook.
+	</para>
+
+	<programlisting>
+void (*eng_timeout) (struct ata_port *ap);
+	</programlisting>
+
+	<para>
+	This is a high level error handling function, called from the
+	error handling thread, when a command times out.
+	</para>
+
+	<programlisting>
+irqreturn_t (*irq_handler)(int, void *, struct pt_regs *);
+void (*irq_clear) (struct ata_port *);
+	</programlisting>
+
+	<para>
+	->irq_handler is the interrupt handling routine registered with
+	the system, by libata.  ->irq_clear is called during probe just
+	before the interrupt handler is registered, to be sure hardware
+	is quiet.
+	</para>
+
+	<programlisting>
+u32 (*scr_read) (struct ata_port *ap, unsigned int sc_reg);
+void (*scr_write) (struct ata_port *ap, unsigned int sc_reg,
+                   u32 val);
+	</programlisting>
+
+	<para>
+	Read and write standard SATA phy registers.  Currently only used
+	if ->phy_reset hook called the sata_phy_reset() helper function.
+	</para>
+
+	<programlisting>
+int (*port_start) (struct ata_port *ap);
+void (*port_stop) (struct ata_port *ap);
+void (*host_stop) (struct ata_host_set *host_set);
+	</programlisting>
+
+	<para>
+	->port_start() is called just after the data structures for each
+	port are initialized.  Typically this is used to alloc per-port
+	DMA buffers / tables / rings, enable DMA engines, and similar
+	tasks.  
+	</para>
+	<para>
+	->host_stop() is called when the rmmod or hot unplug process
+	begins.  The hook must stop all hardware interrupts, DMA
+	engines, etc.
+	</para>
+	<para>
+	->port_stop() is called after ->host_stop().  It's sole function
+	is to release DMA/memory resources, now that they are no longer
+	actively being used.
+	</para>
+
+     </sect1>
+  </chapter>
+
   <chapter id="libataExt">
      <title>libata Library</title>
 !Edrivers/scsi/libata-core.c
@@ -83,7 +273,7 @@
   </chapter>
 
   <chapter id="SILInt">
-     <title>ata_sil Internals</title>
+     <title>sata_sil Internals</title>
 !Idrivers/scsi/sata_sil.c
   </chapter>
 
diff -Nru a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c	2004-12-02 01:33:06 -05:00
+++ b/drivers/scsi/ahci.c	2004-12-02 01:33:06 -05:00
@@ -184,6 +184,7 @@
 static Scsi_Host_Template ahci_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
@@ -944,10 +945,6 @@
 	if (!printed_version++)
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
 
-	/*
-	 * If this driver happens to only be useful on Apple's K2, then
-	 * we should check that here as it has a normal Serverworks ID
-	 */
 	rc = pci_enable_device(pdev);
 	if (rc)
 		return rc;
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-12-02 01:33:06 -05:00
+++ b/drivers/scsi/libata-core.c	2004-12-02 01:33:06 -05:00
@@ -582,7 +582,7 @@
 
 /**
  *	ata_udma_string - convert UDMA bit offset to string
- *	@udma_mask: mask of bits supported; only highest bit counts.
+ *	@mask: mask of bits supported; only highest bit counts.
  *
  *	Determine string which represents the highest speed
  *	(highest bit in @udma_mask).
@@ -819,7 +819,7 @@
 
 /**
  *	ata_dev_id_string - Convert IDENTIFY DEVICE page into string
- *	@dev: Device whose IDENTIFY DEVICE results we will examine
+ *	@id: IDENTIFY DEVICE results we will examine
  *	@s: string into which data is output
  *	@ofs: offset into identify device page
  *	@len: length of string to return. must be an even number.
@@ -1766,8 +1766,10 @@
 }
 
 /**
- *	ata_choose_xfer_mode -
- *	@ap:
+ *	ata_choose_xfer_mode - attempt to find best transfer mode
+ *	@ap: Port for which an xfer mode will be selected
+ *	@xfer_mode_out: (output) SET FEATURES - XFER MODE code
+ *	@xfer_shift_out: (output) bit shift that selects this mode
  *
  *	LOCKING:
  *
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2004-12-02 01:33:06 -05:00
+++ b/drivers/scsi/libata-scsi.c	2004-12-02 01:33:06 -05:00
@@ -156,6 +156,7 @@
 /**
  *	ata_to_sense_error - convert ATA error to SCSI error
  *	@qc: Command that we are erroring out
+ *	@drv_stat: value contained in ATA status register
  *
  *	Converts an ATA error into a SCSI error. While we are at it
  *	we decode and dump the ATA error for the user so that they
@@ -735,6 +736,7 @@
 /**
  *	ata_scsi_rbuf_put - Unmap response buffer.
  *	@cmd: SCSI command containing buffer to be unmapped.
+ *	@buf: buffer to unmap
  *
  *	Unmaps response buffer contained within @cmd.
  *
@@ -1334,7 +1336,7 @@
 /**
  *	ata_scsi_find_dev - lookup ata_device from scsi_cmnd
  *	@ap: ATA port to which the device is attached
- *	@cmd: SCSI command to be sent to the device
+ *	@scsidev: SCSI device from which we derive the ATA device
  *
  *	Given various information provided in struct scsi_cmnd,
  *	map that onto an ATA bus, and using that mapping
