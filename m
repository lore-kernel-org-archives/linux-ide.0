From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [RFC 5/5] ata_acpi: add ACPI support functions
Date: Wed, 23 Nov 2005 15:54:27 -0800
Message-ID: <20051123155427.36fdbfb8.randy_d_dunlap@linux.intel.com>
References: <20051123154055.6ab5cab2.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:17540 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751337AbVKWXyq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Nov 2005 18:54:46 -0500
In-Reply-To: <20051123154055.6ab5cab2.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Add support for ACPI methods to SATA suspend/resume.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
 drivers/scsi/ata_acpi.c |  499 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 499 insertions(+)

--- /dev/null
+++ linux-2615-rc2c/drivers/scsi/ata_acpi.c
@@ -0,0 +1,499 @@
+/*
+ * ata-acpi.c
+ * Provides ACPI support for PATA/SATA.
+ *
+ * Copyright (C) 2005 Intel Corp.
+ * Copyright (C) 2005 Randy Dunlap
+ */
+
+#include <linux/ata.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <acpi/acpi.h>
+#include "scsi.h"
+#include <linux/libata.h>
+#include <linux/pci.h>
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
+#define DEBUGGING	1
+/* note: adds function name and KERN_DEBUG */
+#ifdef DEBUGGING
+#define DEBPRINT(fmt, args...)	\
+		printk(KERN_DEBUG "%s: " fmt, __FUNCTION__, ## args)
+#else
+#define DEBPRINT(fmt, args...)	do {} while (0)
+#endif	/* DEBUGGING */
+
+static u8 *acpi_path_name(acpi_handle handle)
+{
+	acpi_status		status;
+	static u8		path_name[ACPI_PATHNAME_MAX];
+	struct acpi_buffer	ret_buf = { ACPI_PATHNAME_MAX, path_name };
+
+	memset(path_name, 0, sizeof (path_name));
+	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &ret_buf);
+
+	if (ACPI_FAILURE(status))
+		return NULL;
+
+	return path_name;
+}
+
+/**
+ * pci_acpi_get_dev_handle - finds acpi_handle and pci device.function
+ * @dev: device to locate
+ * @handle: returned acpi_handle for @dev
+ * @pcidevfn: return PCI device.func for @dev
+ *
+ * Returns 0 on success, <0 on error.
+ */
+static int pci_acpi_get_dev_handle(struct device *dev, acpi_handle *handle,
+					acpi_integer *pcidevfn)
+{
+	struct pci_dev	*pci_dev;
+	acpi_integer	addr;
+
+	pci_dev = to_pci_dev(dev);
+	/* Please refer to the ACPI spec for the syntax of _ADR. */
+	addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
+	*pcidevfn = addr;
+	*handle = acpi_get_child(DEVICE_ACPI_HANDLE(dev->parent), addr);
+	DEBPRINT("pcidevfn: 0x%llx\n",
+		(unsigned long long)*pcidevfn);
+	if (!*handle)
+		return -ENODEV;
+	return 0;
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
+	u8			*path_name = acpi_path_name(handle);
+	struct acpi_buffer	buffer;
+	struct acpi_device_info	*dinfo;
+
+	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
+	buffer.pointer = NULL;
+	status = acpi_get_object_info(handle, &buffer);
+
+	if (ACPI_SUCCESS(status)) {
+		dinfo = buffer.pointer;
+
+		/* find full device path name for pcidevfn */
+		if (dinfo && (dinfo->valid & ACPI_VALID_ADR) &&
+		    dinfo->address == winfo->pcidevfn) {
+			DEBPRINT(":%s: matches pcidevfn (0x%llx)\n",
+				path_name, winfo->pcidevfn);
+			strlcpy(winfo->basepath, path_name,
+				sizeof(winfo->basepath));
+			winfo->basepath_len = strlen(path_name);
+			goto out;
+		}
+
+		/* if basepath is not yet known, ignore this object */
+		if (!winfo->basepath_len)
+			goto out;
+
+		/* if this object is in scope of basepath, maybe use it */
+		if (strncmp(path_name, winfo->basepath,
+		    winfo->basepath_len) == 0) {
+			if (!(dinfo->valid & ACPI_VALID_ADR))
+				goto out;
+			DEBPRINT("GOT ONE: "
+				"(%s) root_port = 0x%llx, port_num = 0x%llx\n",
+				path_name,
+				SATA_ROOT_PORT(dinfo->address),
+				SATA_PORT_NUMBER(dinfo->address));
+			/* heuristics: */
+			if (SATA_PORT_NUMBER(dinfo->address) != NO_PORT_MULT)
+				DEBPRINT("warning: don't know how to handle SATA port multiplier\n");
+			if (SATA_ROOT_PORT(dinfo->address) ==
+				winfo->ataport->port_no &&
+			    SATA_PORT_NUMBER(dinfo->address) == NO_PORT_MULT) {
+				DEBPRINT("THIS ^^^^^ is the requested SATA drive (handle = 0x%p)\n",
+					handle);
+				winfo->sata_adr = dinfo->address;
+				winfo->obj_handle = handle;
+			}
+		}
+out:
+		ACPI_MEM_FREE(dinfo);
+	}
+
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
+		DEBPRINT("acpi_bus_get_device failed\n");
+	winfo->handle = handle;
+	winfo->pcidevfn = pcidevfn;
+	winfo->drivenum = drive;
+
+	status = acpi_get_devices(NULL, get_devices, winfo, NULL);
+	if (ACPI_FAILURE(status))
+		err = -ENODEV;
+	else {
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
+ * do_drive_SDD - send Identify data to a drive
+ * @ap: the ata_port for the drive
+ * @ix: drive index
+ *
+ * Must be after Identify (Packet) Device -- uses its data.
+ */
+int do_drive_SDD(struct ata_port *ap, unsigned int ix)
+{
+//	struct acpi_device_walk_info	*info =
+//	    (struct acpi_device_walk_info *)context;
+//	struct acpi_parameter_info	pinfo;
+	acpi_handle			handle;
+	acpi_integer			pcidevfn;
+	int				err = -ENODEV;
+	struct device			*dev = ap->host_set->dev;
+	struct ata_device		*atadev = &ap->device[ix];
+	u32				dev_adr;
+	acpi_status			status;
+	struct acpi_object_list		input;
+	union acpi_object 		in_params[1];
+
+	printk(KERN_DEBUG
+		"%s: ap->id: %d, ix = %d, port#: %d, hard_port#: %d\n",
+		__FUNCTION__, ap->id, ix, ap->port_no, ap->hard_port_no);
+
+	/* Don't continue if not a SATA device. */
+	if (!ata_id_is_sata(atadev->id))
+		goto out;
+
+	/* Don't continue if device has no _ADR method.
+	 * _SDD is intended for known motherboard devices. */
+	err = pci_acpi_get_dev_handle(dev, &handle, &pcidevfn);
+	if (err < 0)
+		goto out;
+	/* Get this drive's _ADR info. */
+	dev_adr = SATA_ADR_RSVD;
+	err = get_sata_adr(dev, handle, pcidevfn, ix, ap, atadev, &dev_adr);
+	if (err < 0 || dev_adr == SATA_ADR_RSVD || atadev->obj_handle == NULL)
+		goto out;
+
+	/* Give the drive Identify data to the drive via the _SDD method */
+	/* _SDD: set up input parameters */
+	input.count = 1;
+	input.pointer = in_params;
+	in_params[0].type 		= ACPI_TYPE_BUFFER;
+	in_params[0].buffer.length 	= sizeof(atadev->id);
+	in_params[0].buffer.pointer	= (u8 *)atadev->id;
+	/* Output buffer: _SDD has no output */
+
+	/* It's OK for _SDD to be missing too. */
+	status = acpi_evaluate_object(atadev->obj_handle, "_SDD", &input, NULL);
+	err = ACPI_FAILURE(status) ? -EIO : 0;
+	if (err < 0) {
+		printk(KERN_DEBUG
+			"ata%u(%u): %s _SDD error: status = 0x%x\n",
+			ap->id, ap->device->devno, __FUNCTION__, status);
+	}
+out:
+	return err;
+}
+EXPORT_SYMBOL_GPL(do_drive_SDD);
+
+/**
+ * do_drive_get_GTF - get the drive bootup default taskfile settings
+ * @ap: the ata_port for the drive
+ * @atadev: target ata_device
+ *
+ * This applies to both PATA and SATA drives.
+ *
+ * The _GTF method has no input parameters.
+ * It returns a variable number of register set values (registers
+ * hex 1F1..1F7, taskfiles).
+ * The <variable number> is not known in advance, so have ACPI-CA
+ * allocate the buffer as needed and return it, then free it later.
+ *
+ */
+int do_drive_get_GTF(struct ata_port *ap, struct ata_device *atadev)
+{
+//	struct acpi_device_walk_info	*info =
+//	    (struct acpi_device_walk_info *)context;
+//	struct acpi_parameter_info	pinfo;
+	acpi_status			status;
+	acpi_handle			handle;
+	acpi_integer			pcidevfn;
+	struct acpi_buffer		output;
+	union acpi_object 		*out_obj;
+	struct device			*dev = ap->host_set->dev;
+	int				err = -ENODEV;
+
+	if (!ata_dev_present(atadev))	/* or port disabled ? */
+		goto out;
+
+	/* Don't continue if device has no _ADR method.
+	 * _GTF is intended for known motherboard devices. */
+	err = pci_acpi_get_dev_handle(dev, &handle, &pcidevfn);
+	if (err < 0)
+		goto out;
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
+		ACPI_MEM_FREE(output.pointer);
+		printk(KERN_DEBUG
+			"%s: Run _GTF error: status = 0x%x\n",
+			__FUNCTION__, status);
+		goto out;
+	}
+
+	if (!output.length || !output.pointer) {
+		printk(KERN_DEBUG
+			"%s: Run _GTF: length or ptr is NULL (0x%llx, 0x%p)\n",
+			__FUNCTION__,
+			(unsigned long long)output.length, output.pointer);
+		ACPI_MEM_FREE(output.pointer);
+		goto out;
+	}
+
+	out_obj = output.pointer;
+	if (out_obj->type != ACPI_TYPE_BUFFER) {
+		ACPI_MEM_FREE(output.pointer);
+		printk(KERN_DEBUG "%s: Run _GTF: error: "
+			"expected object type of ACPI_TYPE_BUFFER, got 0x%x\n",
+			__FUNCTION__, out_obj->type);
+		err = -ENOENT;
+		goto out;
+	}
+
+	atadev->gtf_length = out_obj->buffer.length;
+	atadev->gtf_address = out_obj->buffer.pointer;
+	err = 0;
+out:
+	return err;
+}
+EXPORT_SYMBOL_GPL(do_drive_get_GTF);
+
+/**
+ *	taskfile_load_pio - send taskfile registers to host controller
+ *	@ap: Port to which output is sent
+ *	@gtf: raw ATA taskfile register set (0x1f1 - 0x1f7)
+ *
+ *	Outputs ATA taskfile to standard ATA host controller.
+ *
+ *	LOCKING: TBD:
+ *	Inherited from caller.
+ */
+static void taskfile_load_pio(struct ata_port *ap,
+				const struct taskfile_array *gtf)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+
+	outb(gtf->tfa[0], ioaddr->feature_addr);
+	outb(gtf->tfa[1], ioaddr->nsect_addr);
+	outb(gtf->tfa[2], ioaddr->lbal_addr);
+	outb(gtf->tfa[3], ioaddr->lbam_addr);
+	outb(gtf->tfa[4], ioaddr->lbah_addr);
+	outb(gtf->tfa[5], ioaddr->device_addr);
+	outb(gtf->tfa[6], ioaddr->command_addr);
+
+	ata_wait_idle(ap);
+}
+
+/**
+ *	taskfile_load_mmio - send taskfile registers to host controller
+ *	@ap: Port to which output is sent
+ *	@gtf: raw ATA taskfile register set (0x1f1 - 0x1f7)
+ *
+ *	Outputs ATA taskfile to standard ATA host controller using MMIO.
+ *
+ *	LOCKING: TBD:
+ *	Inherited from caller.
+ */
+static void taskfile_load_mmio(struct ata_port *ap,
+				const struct taskfile_array *gtf)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+
+	writeb(gtf->tfa[0], (void __iomem *) ioaddr->feature_addr);
+	writeb(gtf->tfa[1], (void __iomem *) ioaddr->nsect_addr);
+	writeb(gtf->tfa[2], (void __iomem *) ioaddr->lbal_addr);
+	writeb(gtf->tfa[3], (void __iomem *) ioaddr->lbam_addr);
+	writeb(gtf->tfa[4], (void __iomem *) ioaddr->lbah_addr);
+	writeb(gtf->tfa[5], (void __iomem *) ioaddr->device_addr);
+	writeb(gtf->tfa[6], (void __iomem *) ioaddr->command_addr);
+
+	ata_wait_idle(ap);
+}
+
+
+/**
+ *	taskfile_load_raw - send taskfile registers to host controller
+ *	@ap: Port to which output is sent
+ *	@gtf: raw ATA taskfile register set (0x1f1 - 0x1f7)
+ *
+ *	Outputs ATA taskfile to standard ATA host controller using MMIO
+ *	or PIO as indicated by the ATA_FLAG_MMIO flag.
+ *	Writes the control, feature, nsect, lbal, lbam, and lbah registers.
+ *	Optionally (ATA_TFLAG_LBA48) writes hob_feature, hob_nsect,
+ *	hob_lbal, hob_lbam, and hob_lbah.
+ *
+ *	This function waits for idle (!BUSY and !DRQ) after writing
+ *	registers.  If the control register has a new value, this
+ *	function also waits for idle after writing control and before
+ *	writing the remaining registers.
+ *
+ *	LOCKING: TBD:
+ *	Inherited from caller.
+ */
+static void taskfile_load_raw(struct ata_port *ap,
+				const struct taskfile_array *gtf)
+{
+	DEBPRINT("(0x1f1-1f7): hex: %02x %02x %02x %02x %02x %02x %02x\n",
+		gtf->tfa[0], gtf->tfa[1], gtf->tfa[2],
+		gtf->tfa[3], gtf->tfa[4], gtf->tfa[5], gtf->tfa[6]);
+
+
+#if 0
+	if (ap->flags & ATA_FLAG_MMIO)
+		taskfile_load_mmio(ap, gtf);
+	else
+		taskfile_load_pio(ap, gtf);
+#endif
+}
+
+/**
+ * do_drive_set_taskfiles - write the drive taskfile settings from _GTF
+ * @ap: the ata_port for the drive
+ * @atadev: target ata_device
+ *
+ * This applies to both PATA and SATA drives.
+ *
+ * Write {atadev->gtf_address, length atadev->gtf_length} in groups of
+ * REGS_PER_GTF bytes.
+ *
+ */
+int do_drive_set_taskfiles(struct ata_port *ap, struct ata_device *atadev)
+{
+//	struct acpi_device_walk_info	*info =
+//	    (struct acpi_device_walk_info *)context;
+//	struct acpi_parameter_info	pinfo;
+//	struct device			*dev = ap->host_set->dev;
+	int				err = -ENODEV;
+	int				gtf_count =
+					atadev->gtf_length / REGS_PER_GTF;
+	int				ix;
+	struct taskfile_array		*gtf;
+
+	if (!ata_dev_present(atadev))	/* or port disabled ? */
+		goto out;
+	if (!gtf_count)		/* shouldn't be here */
+		goto out;
+
+	DEBPRINT("total GTF bytes = %lld (0x%llx), gtf_count = %d\n",
+		(unsigned long long)atadev->gtf_length,
+		(unsigned long long)atadev->gtf_length, gtf_count);
+	if (atadev->gtf_length % REGS_PER_GTF) {
+		printk(KERN_ERR "%s: unexpected GTF length (%zd)\n",
+			__FUNCTION__, atadev->gtf_length);
+		goto out;
+	}
+
+	for (ix = 0; ix < gtf_count; ix++) {
+		gtf = (struct taskfile_array *)
+			(atadev->gtf_address + ix * REGS_PER_GTF);
+
+		/* TBD: writing the taskfile array must have a more
+		 * generic interface than this.... */
+		/* send all TaskFile registers (0x1f1-0x1f7) *in*that*order* */
+		taskfile_load_raw(ap, gtf);
+	}
+
+	err = 0;
+out:
+	return err;
+}
+EXPORT_SYMBOL_GPL(do_drive_set_taskfiles);
+
+/**
+ * do_drive_update_taskfiles - get then write drive taskfile settings
+ * @ap: the ata_port for the drive
+ *
+ * This applies to both PATA and SATA drives.
+ */
+int do_drive_update_taskfiles(struct ata_port *ap)
+{
+	int ix;
+	int ret;
+
+	for (ix = 0; ix < ATA_MAX_DEVICES; ix++) {
+		ret = do_drive_get_GTF(ap, &ap->device[ix]);
+		if (ret >= 0)
+			ret = do_drive_set_taskfiles(ap, &ap->device[ix]);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(do_drive_update_taskfiles);


---
