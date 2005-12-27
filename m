From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [PATCH 5/5] libata: more module parameters
Date: Tue, 27 Dec 2005 15:33:46 -0800
Message-ID: <20051227153346.3c6adcd1.randy_d_dunlap@linux.intel.com>
References: <20051227152613.25d580ff.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:14221 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932391AbVL0XeS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Dec 2005 18:34:18 -0500
In-Reply-To: <20051227152613.25d580ff.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, axboe <axboe@suse.de>

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Add and use 'noacpi' parameter for libata-acpi.
Add and use 'printk' parameter for libata (parts).
Update Documentation/kernel-parameters.txt, including atapi_enabled.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 Documentation/kernel-parameters.txt |   13 +++++++++++++
 drivers/scsi/libata-acpi.c          |   12 ++++++++++++
 drivers/scsi/libata-core.c          |   10 ++++++++++
 drivers/scsi/libata.h               |    2 ++
 4 files changed, 37 insertions(+)

--- linux-2615-rc7-sat.orig/drivers/scsi/libata-core.c
+++ linux-2615-rc7-sat/drivers/scsi/libata-core.c
@@ -82,6 +82,14 @@ int atapi_enabled = 0;
 module_param(atapi_enabled, int, 0444);
 MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on)");
 
+int noacpi = 0;
+module_param(noacpi, int, 0444);
+MODULE_PARM_DESC(noacpi, "Disables use of ACPI in suspend/resume when set");
+
+int libata_printk = ATA_MSG_DRV;
+module_param_named(printk, libata_printk, int, 0644);
+MODULE_PARM_DESC(printk, "Set libata printk flags"); /* in linux/libata.h */
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
@@ -4439,6 +4447,8 @@ int ata_device_add(const struct ata_prob
 				(ap->mwdma_mask << ATA_SHIFT_MWDMA) |
 				(ap->pio_mask << ATA_SHIFT_PIO);
 
+		ap->msg_enable = libata_printk;
+
 		/* print per-port info to dmesg */
 		printk(KERN_INFO "ata%u: %cATA max %s cmd 0x%lX ctl 0x%lX "
 				 "bmdma 0x%lX irq %lu\n",
--- linux-2615-rc7-sat.orig/Documentation/kernel-parameters.txt
+++ linux-2615-rc7-sat/Documentation/kernel-parameters.txt
@@ -41,6 +41,7 @@ restrictions referred to are that the re
 	ISAPNP	ISA PnP code is enabled.
 	ISDN	Appropriate ISDN support is enabled.
 	JOY	Appropriate joystick support is enabled.
+	LIBATA	libata driver is enabled.
 	LP	Printer support is enabled.
 	LOOP	Loopback device support is enabled.
 	M68k	M68k architecture is enabled.
@@ -242,6 +243,9 @@ running once the system is up.
 
 	ataflop=	[HW,M68k]
 
+	atapi_enabled=	[LIBATA] Enable discovery & support of ATAPI devices
+			Format: <value> (0=off, 1=on)
+
 	atarimouse=	[HW,MOUSE] Atari Mouse
 
 	atascsi=	[HW,SCSI] Atari SCSI
@@ -908,6 +912,10 @@ running once the system is up.
 			emulation library even if a 387 maths coprocessor
 			is present.
 
+	noacpi=		[LIBATA] Disables use of ACPI in libata suspend/resume
+			when set.
+			Format: <int>
+
 	noalign		[KNL,ARM]
 
 	noapic		[SMP,APIC] Tells the kernel to not make use of any
@@ -1150,6 +1158,11 @@ running once the system is up.
 			autoconfiguration.
 			Ranges are in pairs (memory base and size).
 
+	printk=		[LIBATA] Set libata printk level (mask).
+			The values are defined in include/linux/libata.h.
+			The default value is 1 (ATA_MSG_DRV).
+			Format: <int>
+
 	profile=	[KNL] Enable kernel profiling via /proc/profile
 			Format: [schedule,]<number>
 			Param: "schedule" - profile schedule points.
--- linux-2615-rc7-sat.orig/drivers/scsi/libata-acpi.c
+++ linux-2615-rc7-sat/drivers/scsi/libata-acpi.c
@@ -212,6 +212,9 @@ int ata_acpi_push_id(struct ata_port *ap
 	struct acpi_object_list		input;
 	union acpi_object 		in_params[1];
 
+	if (noacpi)
+		return 0;
+
 	if (ata_msg_probe(ap))
 		printk(KERN_DEBUG
 			"%s: ap->id: %d, ix = %d, port#: %d, hard_port#: %d\n",
@@ -316,6 +319,9 @@ int do_drive_get_GTF(struct ata_port *ap
 			__FUNCTION__, ap->id,
 			ap->port_no, ap->hard_port_no);
 
+	if (noacpi)
+		return 0;
+
 	if (!ata_dev_present(atadev) ||
 	    (ap->flags & ATA_FLAG_PORT_DISABLED)) {
 		if (ata_msg_probe(ap))
@@ -499,6 +505,9 @@ int do_drive_set_taskfiles(struct ata_po
 			__FUNCTION__, ap->id,
 			ap->port_no, ap->hard_port_no);
 
+	if (noacpi)
+		return 0;
+
 	if (!ata_dev_present(atadev) ||
 	    (ap->flags & ATA_FLAG_PORT_DISABLED))
 		goto out;
@@ -546,6 +555,9 @@ int ata_acpi_exec_tfs(struct ata_port *a
 	if (ata_msg_probe(ap))
 		printk(KERN_DEBUG "%s: ENTER:\n", __FUNCTION__);
 
+	if (noacpi)
+		return 0;
+
 	for (ix = 0; ix < ATA_MAX_DEVICES; ix++) {
 		printk(KERN_DEBUG "%s: call get_GTF, ix=%d\n",
 			__FUNCTION__, ix);
--- linux-2615-rc7-sat.orig/drivers/scsi/libata.h
+++ linux-2615-rc7-sat/drivers/scsi/libata.h
@@ -39,6 +39,8 @@ struct ata_scsi_args {
 
 /* libata-core.c */
 extern int atapi_enabled;
+extern int noacpi;
+extern int libata_printk;
 extern int ata_qc_complete_noop(struct ata_queued_cmd *qc, unsigned int err_mask);
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);

---
