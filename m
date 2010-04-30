From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] libata: update developer's guide
Date: Fri, 30 Apr 2010 17:56:36 +0400
Message-ID: <201004301756.36355.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:39761 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933473Ab0D3R50 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Apr 2010 13:57:26 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Commit 6bfff31e77cfa1b13490337e5a4dbaa3407e83ac (libata: kill probe_ent
and related helpers) killed ata_device_add() but didn't remove references
to it from the libata developer's guide.

Commit 9363c3825ea9ad76561eb48a395349dd29211ed6 (libata: rename SFF
functions) renamed the taskfile access methods but didn't update the
developer's guide.  Commit c9f75b04ed5ed65a058d18a8a8dda50632a96de8
(libata: kill ata_noop_dev_select()) didn't update the developer's
guide as well.

The guide also refers to the long gone ata_pio_data_xfer_noirq(),
ata_pio_data_xfer(), and ata_mmio_data_xfer() -- replace those by
the modern ata_sff_data_xfer_noirq(), ata_sff_data_xfer(), and
ata_sff_data_xfer32().

Also, remove the reference to non-existant ata_port_stop()...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 Documentation/DocBook/libata.tmpl |   35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

Index: linux-2.6/Documentation/DocBook/libata.tmpl
===================================================================
--- linux-2.6.orig/Documentation/DocBook/libata.tmpl
+++ linux-2.6/Documentation/DocBook/libata.tmpl
@@ -105,10 +105,6 @@ void (*dev_config) (struct ata_port *, s
 	issue of SET FEATURES - XFER MODE, and prior to operation.
 	</para>
 	<para>
-	Called by ata_device_add() after ata_dev_identify() determines
-	a device is present.
-	</para>
-	<para>
 	This entry may be specified as NULL in ata_port_operations.
 	</para>
 
@@ -162,7 +158,7 @@ void (*tf_read) (struct ata_port *ap, st
 	hardware registers / DMA buffers, to obtain the current set of
 	taskfile register values.
 	Most drivers for taskfile-based hardware (PIO or MMIO) use
-	ata_tf_load() and ata_tf_read() for these hooks.
+	ata_sff_tf_load() and ata_sff_tf_read() for these hooks.
 	</para>
 
 	</sect2>
@@ -176,9 +172,8 @@ void (*data_xfer) (struct ata_device *, 
 All bmdma-style drivers must implement this hook.  This is the low-level
 operation that actually copies the data bytes during a PIO data
 transfer.
-Typically the driver
-will choose one of ata_pio_data_xfer_noirq(), ata_pio_data_xfer(), or
-ata_mmio_data_xfer().
+Typically the driver will choose one of ata_sff_data_xfer_noirq(),
+ata_sff_data_xfer(), or ata_sff_data_xfer32().
 	</para>
 
 	</sect2>
@@ -191,7 +186,7 @@ void (*exec_command)(struct ata_port *ap
 	<para>
 	causes an ATA command, previously loaded with
 	->tf_load(), to be initiated in hardware.
-	Most drivers for taskfile-based hardware use ata_exec_command()
+	Most drivers for taskfile-based hardware use ata_sff_exec_command()
 	for this hook.
 	</para>
 
@@ -225,13 +220,7 @@ u8   (*check_altstatus)(struct ata_port 
 	hardware.  On some hardware, reading the Status register has
 	the side effect of clearing the interrupt condition.
 	Most drivers for taskfile-based hardware use
-	ata_check_status() for this hook.
-	</para>
-	<para>
-	Note that because this is called from ata_device_add(), at
-	least a dummy function that clears device interrupts must be
-	provided for all drivers, even if the controller doesn't
-	actually have a taskfile status register.
+	ata_sff_check_status() for this hook.
 	</para>
 
 	</sect2>
@@ -249,9 +238,7 @@ void (*dev_select)(struct ata_port *ap, 
 	</para>
 	<para>
 	Most drivers for taskfile-based hardware use
-	ata_std_dev_select() for this hook.  Controllers which do not
-	support second drives on a port (such as SATA contollers) will
-	use ata_noop_dev_select().
+	ata_sff_dev_select() for this hook.
 	</para>
 
 	</sect2>
@@ -439,13 +426,13 @@ void (*irq_clear) (struct ata_port *);
 	to struct ata_host_set.
 	</para>
 	<para>
-	Most legacy IDE drivers use ata_interrupt() for the
+	Most legacy IDE drivers use ata_sff_interrupt() for the
 	irq_handler hook, which scans all ports in the host_set,
 	determines which queued command was active (if any), and calls
-	ata_host_intr(ap,qc).
+	ata_sff_host_intr(ap,qc).
 	</para>
 	<para>
-	Most legacy IDE drivers use ata_bmdma_irq_clear() for the
+	Most legacy IDE drivers use ata_sff_irq_clear() for the
 	irq_clear() hook, which simply clears the interrupt and error
 	flags in the DMA status register.
 	</para>
@@ -494,10 +481,6 @@ void (*host_stop) (struct ata_host_set *
 	data from port at this time.
 	</para>
 	<para>
-	Many drivers use ata_port_stop() as this hook, which frees the
-	PRD table.
-	</para>
-	<para>
 	->host_stop() is called after all ->port_stop() calls
 have completed.  The hook must finalize hardware shutdown, release DMA
 and other resources, etc.
