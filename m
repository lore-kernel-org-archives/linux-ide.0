From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 1/2] libata: implement to get tf's from _GTF and execute
	them
Date: Wed, 26 Jul 2006 15:36:12 +0800
Message-ID: <1153899372.4957.61.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28998 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030265AbWGZHtI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Jul 2006 03:49:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, rdunlap@xenotime.net, htejun@gmail.com
Cc: linux-ide@vger.kernel.org

1 update the Makefile, Kconfig, kernel-parameters.txt, and add
definition of noacpi
2 implement core SATA-ACPI functions
3 implement the functions for getting tf's from _GTF and executing them
4 invoke ata_acpi_exec_tfs in appropriate places


Signed-off-by: Zhao Forrest <forrest.zhao@intel.com>


---

 Documentation/kernel-parameters.txt |    5 
 drivers/scsi/Kconfig                |   13 +
 drivers/scsi/Makefile               |    1 
 drivers/scsi/libata-acpi.c          |  654 +++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-core.c          |    7 
 drivers/scsi/libata.h               |   28 +
 include/linux/libata.h              |    6 
 7 files changed, 714 insertions(+), 0 deletions(-)
 create mode 100644 drivers/scsi/libata-acpi.c

a960cea106c4aad99a5417818fcdab20b3e68056
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index e11f772..0a57036 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -48,6 +48,7 @@ parameter is applicable:
 	ISAPNP	ISA PnP code is enabled.
 	ISDN	Appropriate ISDN support is enabled.
 	JOY	Appropriate joystick support is enabled.
+	LIBATA  Libata driver is enabled.
 	LP	Printer support is enabled.
 	LOOP	Loopback device support is enabled.
 	M68k	M68k architecture is enabled.
@@ -1018,6 +1019,10 @@ running once the system is up.
 			emulation library even if a 387 maths coprocessor
 			is present.
 
+	noacpi		[LIBATA] Disables use of ACPI in libata suspend/resume
+			when set.
+			Format: <int>
+
 	noalign		[KNL,ARM]
 
 	noapic		[SMP,APIC] Tells the kernel to not make use of any
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 96a81cd..364f171 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -619,6 +619,19 @@ config SCSI_SATA_INTEL_COMBINED
 	depends on IDE=y && !BLK_DEV_IDE_SATA && (SCSI_SATA_AHCI || SCSI_ATA_PIIX)
 	default y
 
+config SCSI_SATA_ACPI
+	bool
+	depends on SCSI_SATA && ACPI && PCI
+	default y
+	help
+	  This option adds support for SATA-related ACPI objects.
+	  These ACPI objects add the ability to retrieve taskfiles
+	  from the ACPI BIOS and write them to the disk controller.
+	  These objects may be related to performance, security,
+	  power management, or other areas.
+	  You can disable this at kernel boot time by using the
+	  option 'libata.noacpi'.
+
 config SCSI_BUSLOGIC
 	tristate "BusLogic SCSI support"
 	depends on (PCI || ISA || MCA) && SCSI && ISA_DMA_API
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index ebd0cf0..b458b3a 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -167,6 +167,7 @@ CFLAGS_ncr53c8xx.o	:= $(ncr53c8xx-flags-
 zalon7xx-objs	:= zalon.o ncr53c8xx.o
 NCR_Q720_mod-objs	:= NCR_Q720.o ncr53c8xx.o
 libata-objs	:= libata-core.o libata-scsi.o libata-bmdma.o libata-eh.o
+libata-$(CONFIG_SCSI_SATA_ACPI) += libata-acpi.o
 oktagon_esp_mod-objs	:= oktagon_esp.o oktagon_io.o
 
 # Files generated that shall be removed upon make clean
diff --git a/drivers/scsi/libata-acpi.c b/drivers/scsi/libata-acpi.c
new file mode 100644
index 0000000..cf7eeb1
--- /dev/null
+++ b/drivers/scsi/libata-acpi.c
@@ -0,0 +1,654 @@
+/*
+ * libata-acpi.c
+ * Provides ACPI support for PATA/SATA.
+ *
+ * Copyright (C) 2005 Intel Corp.
+ * Copyright (C) 2005 Randy Dunlap
+ */
+
+#include <linux/ata.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <acpi/acpi.h>
+#include "scsi.h"
+#include <linux/libata.h>
+#include <linux/pci.h>
+#include "libata.h"
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acnames.h>
+#include <acpi/acnamesp.h>
+#include <acpi/acparser.h>
+#include <acpi/acexcep.h>
+#include <acpi/acmacros.h>
+#include <acpi/actypes.h>
+
+#define SATA_ROOT_PORT(x)	(((x) >> 16) & 0xffff)
+#define SATA_PORT_NUMBER(x)	((x) & 0xffff)	/* or NO_PORT_MULT */
+#define NO_PORT_MULT		0xffff
+#define SATA_ADR_RSVD		0xffffffff
+
+#define REGS_PER_GTF		7
+struct taskfile_array {
+	u8	tfa[REGS_PER_GTF];	/* regs. 0x1f1 - 0x1f7 */
+};
+
+struct GTM_buffer {
+	__u32	PIO_speed0;
+	__u32	DMA_speed0;
+	__u32	PIO_speed1;
+	__u32	DMA_speed1;
+	__u32	GTM_flags;
+};
+
+#define DEBUGGING	1
+/* note: adds function name and KERN_DEBUG */
+#ifdef DEBUGGING
+#define DEBPRINT(fmt, args...)	\
+		printk(KERN_DEBUG "%s: " fmt, __FUNCTION__, ## args)
+#else
+#define DEBPRINT(fmt, args...)	do {} while (0)
+#endif	/* DEBUGGING */
+
+/**
+ * sata_get_dev_handle - finds acpi_handle and PCI device.function
+ * @dev: device to locate
+ * @handle: returned acpi_handle for @dev
+ * @pcidevfn: return PCI device.func for @dev
+ *
+ * This function is somewhat SATA-specific.  Or at least the
+ * IDE and SCSI versions of this function are different,
+ * so it's not entirely generic code.
+ *
+ * Returns 0 on success, <0 on error.
+ */
+static int sata_get_dev_handle(struct device *dev, acpi_handle *handle,
+					acpi_integer *pcidevfn)
+{
+	struct pci_dev	*pci_dev;
+	acpi_integer	addr;
+
+	pci_dev = to_pci_dev(dev);	/* NOTE: PCI-specific */
+	/* Please refer to the ACPI spec for the syntax of _ADR. */
+	addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
+	*pcidevfn = addr;
+	*handle = acpi_get_child(DEVICE_ACPI_HANDLE(dev->parent), addr);
+	printk(KERN_DEBUG "%s: SATA dev addr=0x%llx, handle=0x%p\n",
+		__FUNCTION__, (unsigned long long)addr, *handle);
+	if (!*handle)
+		return -ENODEV;
+	return 0;
+}
+
+/**
+ * pata_get_dev_handle - finds acpi_handle and PCI device.function
+ * @dev: device to locate
+ * @handle: returned acpi_handle for @dev
+ * @pcidevfn: return PCI device.func for @dev
+ *
+ * The PATA and SATA versions of this function are different.
+ *
+ * Returns 0 on success, <0 on error.
+ */
+static int pata_get_dev_handle(struct device *dev, acpi_handle *handle,
+					acpi_integer *pcidevfn)
+{
+	unsigned int domain, bus, devnum, func;
+	acpi_integer addr;
+	acpi_handle dev_handle, parent_handle;
+	int scanned;
+	struct acpi_buffer buffer = {.length = ACPI_ALLOCATE_BUFFER,
+					.pointer = NULL};
+	acpi_status status;
+	struct acpi_device_info	*dinfo = NULL;
+	int ret = -ENODEV;
+
+	printk(KERN_DEBUG "%s: ENTER: dev->bus_id='%s'\n",
+		__FUNCTION__,  dev->bus_id);
+
+	if ((scanned = sscanf(dev->bus_id, "%x:%x:%x.%x",
+			&domain, &bus, &devnum, &func)) != 4) {
+		printk("sscanf ret. %d\n", scanned);
+		goto err;
+	}
+
+	dev_handle = DEVICE_ACPI_HANDLE(dev);
+	parent_handle = DEVICE_ACPI_HANDLE(dev->parent);
+
+	status = acpi_get_object_info(parent_handle, &buffer);
+	if (ACPI_FAILURE(status)) {
+		printk("get_object_info for parent failed\n");
+		goto err;
+	}
+	dinfo = buffer.pointer;
+	if (dinfo && (dinfo->valid & ACPI_VALID_ADR) &&
+	    dinfo->address == bus) {
+		/* ACPI spec for _ADR for PCI bus: */
+		addr = (acpi_integer)(devnum << 16 | func);
+		*pcidevfn = addr;
+		*handle = dev_handle;
+	} else {
+		printk("get_object_info for parent has wrong "
+			" bus: %llu, should be %d\n",
+			dinfo ? (unsigned long long)dinfo->address : -1ULL,
+			bus);
+		goto err;
+	}
+
+	printk(KERN_DEBUG "%s: dev_handle: 0x%p, parent_handle: 0x%p\n",
+		__FUNCTION__, dev_handle, parent_handle);
+	printk(KERN_DEBUG
+		"%s: for dev=0x%x.%x, addr=0x%llx, parent=0x%p, *handle=0x%p\n",
+		__FUNCTION__, devnum, func, (unsigned long long)addr,
+		dev->parent, *handle);
+	if (!*handle)
+		goto err;
+	ret = 0;
+err:
+	kfree(dinfo);
+	return ret;
+}
+
+struct walk_info {		/* can be trimmed some */
+	struct device	*dev;
+	struct acpi_device *adev;
+	acpi_handle	handle;
+	acpi_integer	pcidevfn;
+	unsigned int	drivenum;
+	acpi_handle	obj_handle;
+	struct ata_port *ataport;
+	struct ata_device *atadev;
+	u32		sata_adr;
+	int		status;
+	char		basepath[ACPI_PATHNAME_MAX];
+	int		basepath_len;
+};
+
+static acpi_status get_devices(acpi_handle handle,
+				u32 level, void *context, void **return_value)
+{
+	acpi_status		status;
+	struct walk_info	*winfo = context;
+	struct acpi_buffer	namebuf = {ACPI_ALLOCATE_BUFFER, NULL};
+	char			*pathname;
+	struct acpi_buffer	buffer;
+	struct acpi_device_info	*dinfo;
+
+	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &namebuf);
+	if (status)
+		goto ret;
+	pathname = namebuf.pointer;
+
+	buffer.length = ACPI_ALLOCATE_BUFFER;
+	buffer.pointer = NULL;
+	status = acpi_get_object_info(handle, &buffer);
+
+	if (ACPI_SUCCESS(status)) {
+		dinfo = buffer.pointer;
+
+		/* find full device path name for pcidevfn */
+		if (dinfo && (dinfo->valid & ACPI_VALID_ADR) &&
+		    dinfo->address == winfo->pcidevfn) {
+			if (ata_msg_probe(winfo->ataport))
+				printk(KERN_DEBUG
+					":%s: matches pcidevfn (0x%llx)\n",
+					pathname, winfo->pcidevfn);
+			strlcpy(winfo->basepath, pathname,
+				sizeof(winfo->basepath));
+			winfo->basepath_len = strlen(pathname);
+			goto out;
+		}
+
+		/* if basepath is not yet known, ignore this object */
+		if (!winfo->basepath_len)
+			goto out;
+
+		/* if this object is in scope of basepath, maybe use it */
+		if (strncmp(pathname, winfo->basepath,
+		    winfo->basepath_len) == 0) {
+			if (!(dinfo->valid & ACPI_VALID_ADR))
+				goto out;
+			if (ata_msg_probe(winfo->ataport))
+				printk(KERN_DEBUG "GOT ONE: (%s) "
+					"root_port = 0x%llx, port_num = 0x%llx\n",
+					pathname,
+					SATA_ROOT_PORT(dinfo->address),
+					SATA_PORT_NUMBER(dinfo->address));
+			/* heuristics: */
+			if (SATA_PORT_NUMBER(dinfo->address) != NO_PORT_MULT)
+				if (ata_msg_probe(winfo->ataport))
+					printk(KERN_DEBUG
+						"warning: don't know how to handle SATA port multiplier\n");
+			if (SATA_ROOT_PORT(dinfo->address) ==
+				winfo->ataport->port_no &&
+			    SATA_PORT_NUMBER(dinfo->address) == NO_PORT_MULT) {
+				if (ata_msg_probe(winfo->ataport))
+					printk(KERN_DEBUG
+						"THIS ^^^^^ is the requested SATA drive (handle = 0x%p)\n",
+						handle);
+				winfo->sata_adr = dinfo->address;
+				winfo->obj_handle = handle;
+			}
+		}
+out:
+		kfree(dinfo);
+	}
+	kfree(pathname);
+
+ret:
+	return status;
+}
+
+/* Get the SATA drive _ADR object. */
+static int get_sata_adr(struct device *dev, acpi_handle handle,
+			acpi_integer pcidevfn, unsigned int drive,
+			struct ata_port *ap,
+			struct ata_device *atadev, u32 *dev_adr)
+{
+	acpi_status	status;
+	struct walk_info *winfo;
+	int		err = -ENOMEM;
+
+	winfo = kzalloc(sizeof(struct walk_info), GFP_KERNEL);
+	if (!winfo)
+		goto out;
+
+	winfo->dev = dev;
+	winfo->atadev = atadev;
+	winfo->ataport = ap;
+	if (acpi_bus_get_device(handle, &winfo->adev) < 0)
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "acpi_bus_get_device failed\n");
+	winfo->handle = handle;
+	winfo->pcidevfn = pcidevfn;
+	winfo->drivenum = drive;
+
+	status = acpi_get_devices(NULL, get_devices, winfo, NULL);
+	if (ACPI_FAILURE(status)) {
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "%s: acpi_get_devices failed\n",
+				__FUNCTION__);
+		err = -ENODEV;
+	} else {
+		*dev_adr = winfo->sata_adr;
+		atadev->obj_handle = winfo->obj_handle;
+		err = 0;
+	}
+	kfree(winfo);
+out:
+	return err;
+}
+
+/**
+ * do_drive_get_GTF - get the drive bootup default taskfile settings
+ * @ap: the ata_port for the drive
+ * @ix: target ata_device (drive) index
+ * @gtf_length: number of bytes of _GTF data returned at @gtf_address
+ * @gtf_address: buffer containing _GTF taskfile arrays
+ *
+ * This applies to both PATA and SATA drives.
+ *
+ * The _GTF method has no input parameters.
+ * It returns a variable number of register set values (registers
+ * hex 1F1..1F7, taskfiles).
+ * The <variable number> is not known in advance, so have ACPI-CA
+ * allocate the buffer as needed and return it, then free it later.
+ *
+ * The returned @gtf_length and @gtf_address are only valid if the
+ * function return value is 0.
+ */
+int do_drive_get_GTF(struct ata_port *ap, int ix,
+			unsigned int *gtf_length, unsigned long *gtf_address,
+			unsigned long *obj_loc)
+{
+	acpi_status			status;
+	acpi_handle			dev_handle = NULL;
+	acpi_handle			chan_handle, drive_handle;
+	acpi_integer			pcidevfn = 0;
+	u32				dev_adr;
+	struct acpi_buffer		output;
+	union acpi_object 		*out_obj;
+	struct device			*dev = ap->host_set->dev;
+	struct ata_device		*atadev = &ap->device[ix];
+	int				err = -ENODEV;
+
+	*gtf_length = 0;
+	*gtf_address = 0UL;
+	*obj_loc = 0UL;
+
+	if (noacpi)
+		return 0;
+
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG
+			"%s: ENTER: ap->id: %d, port#: %d, hard_port#: %d\n",
+			__FUNCTION__, ap->id,
+		ap->port_no, ap->hard_port_no);
+
+	if (!ata_dev_enabled(atadev) || (ap->flags & ATA_FLAG_DISABLED)) {
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "%s: ERR: "
+				"ata_dev_present: %d, PORT_DISABLED: %lu\n",
+				__FUNCTION__, ata_dev_enabled(atadev),
+				ap->flags & ATA_FLAG_DISABLED);
+		goto out;
+	}
+
+	/* Don't continue if device has no _ADR method.
+	 * _GTF is intended for known motherboard devices. */
+	if (!(ap->flags & ATA_FLAG_SATA)) {
+		err = pata_get_dev_handle(dev, &dev_handle, &pcidevfn);
+		if (err < 0) {
+			if (ata_msg_probe(ap))
+				printk(KERN_DEBUG
+					"%s: pata_get_dev_handle failed (%d)\n",
+					__FUNCTION__, err);
+			goto out;
+		}
+	} else {
+		err = sata_get_dev_handle(dev, &dev_handle, &pcidevfn);
+		if (err < 0) {
+			if (ata_msg_probe(ap))
+				printk(KERN_DEBUG
+					"%s: sata_get_dev_handle failed (%d\n",
+					__FUNCTION__, err);
+			goto out;
+		}
+	}
+
+	/* Get this drive's _ADR info. if not already known. */
+	if (!atadev->obj_handle) {
+		if (!(ap->flags & ATA_FLAG_SATA)) {
+			/* get child objects of dev_handle == channel objects,
+	 		 * + _their_ children == drive objects */
+			/* channel is ap->hard_port_no */
+			chan_handle = acpi_get_child(dev_handle,
+						ap->hard_port_no);
+			if (ata_msg_probe(ap))
+				printk(KERN_DEBUG
+					"%s: chan adr=%d: chan_handle=0x%p\n",
+					__FUNCTION__, ap->hard_port_no,
+					chan_handle);
+			if (!chan_handle) {
+				err = -ENODEV;
+				goto out;
+			}
+			/* TBD: could also check ACPI object VALID bits */
+			drive_handle = acpi_get_child(chan_handle, ix);
+			printk(KERN_DEBUG "%s:   drive w/ adr=%d: %c: 0x%p\n",
+				__FUNCTION__, ix,
+				!ata_dev_enabled(atadev) ? 'n' : 'v',
+				drive_handle);
+			if (!drive_handle) {
+				err = -ENODEV;
+				goto out;
+			}
+			dev_adr = ix;
+			atadev->obj_handle = drive_handle;
+		} else {	/* for SATA mode */
+			dev_adr = SATA_ADR_RSVD;
+			err = get_sata_adr(dev, dev_handle, pcidevfn, 0,
+					ap, atadev, &dev_adr);
+		}
+		if (err < 0 || dev_adr == SATA_ADR_RSVD ||
+		    !atadev->obj_handle) {
+			if (ata_msg_probe(ap))
+				printk(KERN_DEBUG
+					"%s: get_sata/pata_adr failed: "
+					"err=%d, dev_adr=%u, obj_handle=0x%p\n",
+					__FUNCTION__, err, dev_adr,
+					atadev->obj_handle);
+			goto out;
+		}
+	}
+
+	/* Setting up output buffer */
+	output.length = ACPI_ALLOCATE_BUFFER;
+	output.pointer = NULL;	/* ACPI-CA sets this; save/free it later */
+
+	/* _GTF has no input parameters */
+	err = -EIO;
+	status = acpi_evaluate_object(atadev->obj_handle, "_GTF",
+					NULL, &output);
+	if (ACPI_FAILURE(status)) {
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG
+				"%s: Run _GTF error: status = 0x%x\n",
+				__FUNCTION__, status);
+		goto out;
+	}
+
+	if (!output.length || !output.pointer) {
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "%s: Run _GTF: "
+				"length or ptr is NULL (0x%llx, 0x%p)\n",
+				__FUNCTION__,
+				(unsigned long long)output.length,
+				output.pointer);
+		kfree(output.pointer);
+		goto out;
+	}
+
+	out_obj = output.pointer;
+	if (out_obj->type != ACPI_TYPE_BUFFER) {
+		kfree(output.pointer);
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "%s: Run _GTF: error: "
+				"expected object type of ACPI_TYPE_BUFFER, "
+				"got 0x%x\n",
+				__FUNCTION__, out_obj->type);
+		err = -ENOENT;
+		goto out;
+	}
+
+	if (!out_obj->buffer.length || !out_obj->buffer.pointer ||
+	    out_obj->buffer.length % REGS_PER_GTF) {
+		if (ata_msg_drv(ap))
+			printk(KERN_ERR
+				"%s: unexpected GTF length (%d) or addr (0x%p)\n",
+				__FUNCTION__, out_obj->buffer.length,
+				out_obj->buffer.pointer);
+		err = -ENOENT;
+		goto out;
+	}
+
+	*gtf_length = out_obj->buffer.length;
+	*gtf_address = (unsigned long)out_obj->buffer.pointer;
+	*obj_loc = (unsigned long)out_obj;
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG "%s: returning "
+			"gtf_length=%d, gtf_address=0x%lx, obj_loc=0x%lx\n",
+			__FUNCTION__, *gtf_length, *gtf_address, *obj_loc);
+	err = 0;
+out:
+	return err;
+}
+EXPORT_SYMBOL_GPL(do_drive_get_GTF);
+
+/**
+ * taskfile_load_raw - send taskfile registers to host controller
+ * @ap: Port to which output is sent
+ * @gtf: raw ATA taskfile register set (0x1f1 - 0x1f7)
+ *
+ * Outputs ATA taskfile to standard ATA host controller using MMIO
+ * or PIO as indicated by the ATA_FLAG_MMIO flag.
+ * Writes the control, feature, nsect, lbal, lbam, and lbah registers.
+ * Optionally (ATA_TFLAG_LBA48) writes hob_feature, hob_nsect,
+ * hob_lbal, hob_lbam, and hob_lbah.
+ *
+ * This function waits for idle (!BUSY and !DRQ) after writing
+ * registers.  If the control register has a new value, this
+ * function also waits for idle after writing control and before
+ * writing the remaining registers.
+ *
+ * LOCKING: TBD:
+ * Inherited from caller.
+ */
+static void taskfile_load_raw(struct ata_port *ap,
+				struct ata_device *atadev,
+				const struct taskfile_array *gtf)
+{
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG "%s: (0x1f1-1f7): hex: "
+			"%02x %02x %02x %02x %02x %02x %02x\n",
+			__FUNCTION__,
+			gtf->tfa[0], gtf->tfa[1], gtf->tfa[2],
+			gtf->tfa[3], gtf->tfa[4], gtf->tfa[5], gtf->tfa[6]);
+
+	if ((gtf->tfa[0] == 0) && (gtf->tfa[1] == 0) && (gtf->tfa[2] == 0)
+	    && (gtf->tfa[3] == 0) && (gtf->tfa[4] == 0) && (gtf->tfa[5] == 0)
+	    && (gtf->tfa[6] == 0))
+		return;
+
+	if (ap->ops->qc_issue) {
+		struct ata_taskfile tf;
+		unsigned int err;
+
+		ata_tf_init(atadev, &tf);
+
+		/* convert gtf to tf */
+		tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE; /* TBD */
+		tf.protocol = atadev->class == ATA_DEV_ATAPI ?
+			ATA_PROT_ATAPI_NODATA : ATA_PROT_NODATA;
+		tf.feature = gtf->tfa[0];	/* 0x1f1 */
+		tf.nsect   = gtf->tfa[1];	/* 0x1f2 */
+		tf.lbal    = gtf->tfa[2];	/* 0x1f3 */
+		tf.lbam    = gtf->tfa[3];	/* 0x1f4 */
+		tf.lbah    = gtf->tfa[4];	/* 0x1f5 */
+		tf.device  = gtf->tfa[5];	/* 0x1f6 */
+		tf.command = gtf->tfa[6];	/* 0x1f7 */
+
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "call ata_exec_internal:\n");
+		err = ata_exec_internal(atadev, &tf, NULL, DMA_NONE, NULL, 0);
+		if (err && ata_msg_probe(ap))
+			printk(KERN_ERR "%s: ata_exec_internal failed: %u\n",
+				__FUNCTION__, err);
+	} else
+		if (ata_msg_warn(ap))
+			printk(KERN_WARNING
+				"%s: SATA driver is missing qc_issue function entry points\n",
+				__FUNCTION__);
+}
+
+/**
+ * do_drive_set_taskfiles - write the drive taskfile settings from _GTF
+ * @ap: the ata_port for the drive
+ * @atadev: target ata_device
+ * @gtf_length: total number of bytes of _GTF taskfiles
+ * @gtf_address: location of _GTF taskfile arrays
+ *
+ * This applies to both PATA and SATA drives.
+ *
+ * Write {gtf_address, length gtf_length} in groups of
+ * REGS_PER_GTF bytes.
+ */
+int do_drive_set_taskfiles(struct ata_port *ap, struct ata_device *atadev,
+			unsigned int gtf_length, unsigned long gtf_address)
+{
+	int			err = -ENODEV;
+	int			gtf_count = gtf_length / REGS_PER_GTF;
+	int			ix;
+	struct taskfile_array	*gtf;
+
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG
+			"%s: ENTER: ap->id: %d, port#: %d, hard_port#: %d\n",
+			__FUNCTION__, ap->id,
+			ap->port_no, ap->hard_port_no);
+
+	if (noacpi)
+		return 0;
+
+	if (!ata_dev_enabled(atadev) || (ap->flags & ATA_FLAG_DISABLED))
+		goto out;
+	if (!gtf_count)		/* shouldn't be here */
+		goto out;
+
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG
+			"%s: total GTF bytes=%u (0x%x), gtf_count=%d, addr=0x%lx\n",
+			__FUNCTION__, gtf_length, gtf_length, gtf_count,
+			gtf_address);
+	if (gtf_length % REGS_PER_GTF) {
+		if (ata_msg_drv(ap))
+			printk(KERN_ERR "%s: unexpected GTF length (%d)\n",
+				__FUNCTION__, gtf_length);
+		goto out;
+	}
+
+	for (ix = 0; ix < gtf_count; ix++) {
+		gtf = (struct taskfile_array *)
+			(gtf_address + ix * REGS_PER_GTF);
+
+		/* send all TaskFile registers (0x1f1-0x1f7) *in*that*order* */
+		taskfile_load_raw(ap, atadev, gtf);
+	}
+
+	err = 0;
+out:
+	return err;
+}
+EXPORT_SYMBOL_GPL(do_drive_set_taskfiles);
+
+/**
+ * ata_acpi_exec_tfs - get then write drive taskfile settings
+ * @ap: the ata_port for the drive
+ *
+ * This applies to both PATA and SATA drives.
+ */
+int ata_acpi_exec_tfs(struct ata_port *ap)
+{
+	int		ix;
+	int		ret =0;
+	unsigned int	gtf_length;
+	unsigned long	gtf_address;
+	unsigned long	obj_loc;
+
+	if (noacpi)
+		return 0;
+
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG "%s: ENTER:\n", __FUNCTION__);
+
+	for (ix = 0; ix < ATA_MAX_DEVICES; ix++) {
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "%s: call get_GTF, ix=%d\n",
+				__FUNCTION__, ix);
+
+		if (!ata_dev_enabled(&ap->device[ix]))
+			continue;
+
+		ret = do_drive_get_GTF(ap, ix,
+				&gtf_length, &gtf_address, &obj_loc);
+		if (ret < 0) {
+			if (ata_msg_probe(ap))
+				printk(KERN_DEBUG "%s: get_GTF error (%d)\n",
+					__FUNCTION__, ret);
+			break;
+		}
+
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "%s: call set_taskfiles, ix=%d\n",
+				__FUNCTION__, ix);
+		ret = do_drive_set_taskfiles(ap, &ap->device[ix],
+				gtf_length, gtf_address);
+		kfree((void *)obj_loc);
+		if (ret < 0) {
+			if (ata_msg_probe(ap))
+				printk(KERN_DEBUG
+					"%s: set_taskfiles error (%d)\n",
+					__FUNCTION__, ret);
+			break;
+		}
+	}
+
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG "%s: ret=%d\n", __FUNCTION__, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ata_acpi_exec_tfs);
+
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 386e5f2..cd4cf97 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -91,6 +91,10 @@ static int ata_probe_timeout = ATA_TMOUT
 module_param(ata_probe_timeout, int, 0444);
 MODULE_PARM_DESC(ata_probe_timeout, "Set ATA probing timeout (seconds)");
 
+int noacpi = 0;
+module_param(noacpi, int, 0444);
+MODULE_PARM_DESC(noacpi, "Disables use of ACPI in suspend/resume when set");
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
@@ -1592,6 +1596,9 @@ static int ata_bus_probe(struct ata_port
 		goto fail;
 	}
 
+	/* retrieve and execute the ATA task file of _GTF */
+	ata_acpi_exec_tfs(ap);
+
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
 		if (ata_dev_enabled(&ap->device[i]))
 			return 0;
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index c325679..d9743e0 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -43,6 +43,7 @@ extern struct workqueue_struct *ata_aux_
 extern int atapi_enabled;
 extern int atapi_dmadir;
 extern int libata_fua;
+extern int noacpi;
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev);
 extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);
 extern void ata_dev_disable(struct ata_device *dev);
@@ -114,4 +115,31 @@ extern void ata_scsi_error(struct Scsi_H
 extern void ata_port_wait_eh(struct ata_port *ap);
 extern void ata_qc_schedule_eh(struct ata_queued_cmd *qc);
 
+/* libata-acpi.c */
+#ifdef CONFIG_SCSI_SATA_ACPI
+extern int do_drive_get_GTF(struct ata_port *ap, int ix,
+			unsigned int *gtf_length, unsigned long *gtf_address,
+			unsigned long *obj_loc);
+extern int do_drive_set_taskfiles(struct ata_port *ap, struct ata_device *atadev,
+			unsigned int gtf_length, unsigned long gtf_address);
+extern int ata_acpi_exec_tfs(struct ata_port *ap);
+#else
+static inline int do_drive_get_GTF(struct ata_port *ap, int ix,
+			unsigned int *gtf_length, unsigned long *gtf_address,
+			unsigned long *obj_loc)
+{
+	return 0;
+}
+static inline int do_drive_set_taskfiles(struct ata_port *ap,
+			struct ata_device *atadev,
+			unsigned int gtf_length, unsigned long gtf_address)
+{
+	return 0;
+}
+static inline int ata_acpi_exec_tfs(struct ata_port *ap)
+{
+	return 0;
+}
+#endif
+
 #endif /* __LIBATA_H__ */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 66c3100..5e1cbbb 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -35,6 +35,7 @@
 #include <linux/ata.h>
 #include <linux/workqueue.h>
 #include <scsi/scsi_host.h>
+#include <acpi/acpi.h>
 
 /*
  * compile-time options: to be removed as soon as all the drivers are
@@ -468,6 +469,11 @@ struct ata_device {
 
 	/* error history */
 	struct ata_ering	ering;
+
+#ifdef CONFIG_SCSI_SATA_ACPI
+	/* ACPI objects info */
+	acpi_handle		obj_handle;
+#endif
 };
 
 /* Offset into struct ata_device.  Fields above it are maintained
-- 
1.2.6
