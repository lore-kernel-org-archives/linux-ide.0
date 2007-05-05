From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/11] libata-acpi: implement ata_acpi_associate()
Date: Sat, 5 May 2007 23:50:38 +0900
Message-ID: <1178376638773-git-send-email-htejun@gmail.com>
References: <11783766373569-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.232]:6208 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423291AbXEEPvV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 May 2007 11:51:21 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1146181nzf
        for <linux-ide@vger.kernel.org>; Sat, 05 May 2007 08:51:21 -0700 (PDT)
In-Reply-To: <11783766373569-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, lenb@kernel.org, linux-acpi@vger.kernel.org, hare@suse.de, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

* Add acpi_handle to ata_host and ata_port.  Rename
  ata_device->obj_handle to ->acpi_handle and move it above such that
  it doesn't get cleared on reconfiguration.

* Replace ACPI node association which ata_acpi_associate() which is
  called once during host initialization.  Unlike the previous
  implementation, ata_acpi_associate() uses ATA_FLAG_ACPI_SATA to
  choose between IDE or SATA ACPI hierarchy and uses simple child look
  up instead of recursive walk to match the nodes.  This is way safer
  and simpler.  Please read the following message for more info.

  http://article.gmane.org/gmane.linux.ide/17554

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-acpi.c |  369 ++++++---------------------------------------
 drivers/ata/libata-core.c |    3 +
 drivers/ata/libata.h      |    2 +
 include/linux/libata.h    |   13 +-
 4 files changed, 63 insertions(+), 324 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 0223673..eda4263 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -24,10 +24,8 @@
 #include <acpi/acmacros.h>
 #include <acpi/actypes.h>
 
-#define SATA_ROOT_PORT(x)	(((x) >> 16) & 0xffff)
-#define SATA_PORT_NUMBER(x)	((x) & 0xffff)	/* or NO_PORT_MULT */
 #define NO_PORT_MULT		0xffff
-#define SATA_ADR_RSVD		0xffffffff
+#define SATA_ADR(root,pmp)	(((root) << 16) | (pmp))
 
 #define REGS_PER_GTF		7
 struct taskfile_array {
@@ -42,230 +40,64 @@ static int is_pci_dev(struct device *dev)
 	return (dev->bus == &pci_bus_type);
 }
 
-/**
- * sata_get_dev_handle - finds acpi_handle and PCI device.function
- * @dev: device to locate
- * @handle: returned acpi_handle for @dev
- * @pcidevfn: return PCI device.func for @dev
- *
- * This function is somewhat SATA-specific.  Or at least the
- * PATA & SATA versions of this function are different,
- * so it's not entirely generic code.
- *
- * Returns 0 on success, <0 on error.
- */
-static int sata_get_dev_handle(struct device *dev, acpi_handle *handle,
-					acpi_integer *pcidevfn)
+static void ata_acpi_associate_sata_port(struct ata_port *ap)
 {
-	struct pci_dev	*pci_dev;
-	acpi_integer	addr;
-
-	if (!is_pci_dev(dev))
-		return -ENODEV;
-
-	pci_dev = to_pci_dev(dev);	/* NOTE: PCI-specific */
-	/* Please refer to the ACPI spec for the syntax of _ADR. */
-	addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
-	*pcidevfn = addr;
-	*handle = acpi_get_child(DEVICE_ACPI_HANDLE(dev->parent), addr);
-	if (!*handle)
-		return -ENODEV;
-	return 0;
+	acpi_integer adr = SATA_ADR(ap->port_no, NO_PORT_MULT);
+
+	ap->device->acpi_handle = acpi_get_child(ap->host->acpi_handle, adr);
 }
 
-/**
- * pata_get_dev_handle - finds acpi_handle and PCI device.function
- * @dev: device to locate
- * @handle: returned acpi_handle for @dev
- * @pcidevfn: return PCI device.func for @dev
- *
- * The PATA and SATA versions of this function are different.
- *
- * Returns 0 on success, <0 on error.
- */
-static int pata_get_dev_handle(struct device *dev, acpi_handle *handle,
-				acpi_integer *pcidevfn)
+static void ata_acpi_associate_ide_port(struct ata_port *ap)
 {
-	unsigned int bus, devnum, func;
-	acpi_integer addr;
-	acpi_handle dev_handle, parent_handle;
-	struct acpi_buffer buffer = {.length = ACPI_ALLOCATE_BUFFER,
-					.pointer = NULL};
-	acpi_status status;
-	struct acpi_device_info	*dinfo = NULL;
-	int ret = -ENODEV;
-	struct pci_dev *pdev;
-
-	if (!is_pci_dev(dev))
-		return -ENODEV;
-
-	pdev = to_pci_dev(dev);
-
-	bus = pdev->bus->number;
-	devnum = PCI_SLOT(pdev->devfn);
-	func = PCI_FUNC(pdev->devfn);
-
-	dev_handle = DEVICE_ACPI_HANDLE(dev);
-	parent_handle = DEVICE_ACPI_HANDLE(dev->parent);
-
-	status = acpi_get_object_info(parent_handle, &buffer);
-	if (ACPI_FAILURE(status))
-		goto err;
-
-	dinfo = buffer.pointer;
-	if (dinfo && (dinfo->valid & ACPI_VALID_ADR) &&
-	    dinfo->address == bus) {
-		/* ACPI spec for _ADR for PCI bus: */
-		addr = (acpi_integer)(devnum << 16 | func);
-		*pcidevfn = addr;
-		*handle = dev_handle;
-	} else {
-		goto err;
-	}
+	int max_devices, i;
 
-	if (!*handle)
-		goto err;
-	ret = 0;
-err:
-	kfree(dinfo);
-	return ret;
-}
-
-struct walk_info {		/* can be trimmed some */
-	struct device	*dev;
-	struct acpi_device *adev;
-	acpi_handle	handle;
-	acpi_integer	pcidevfn;
-	unsigned int	drivenum;
-	acpi_handle	obj_handle;
-	struct ata_port *ataport;
-	struct ata_device *atadev;
-	u32		sata_adr;
-	int		status;
-	char		basepath[ACPI_PATHNAME_MAX];
-	int		basepath_len;
-};
+	ap->acpi_handle = acpi_get_child(ap->host->acpi_handle, ap->port_no);
+	if (!ap->acpi_handle)
+		return;
 
-static acpi_status get_devices(acpi_handle handle,
-				u32 level, void *context, void **return_value)
-{
-	acpi_status		status;
-	struct walk_info	*winfo = context;
-	struct acpi_buffer	namebuf = {ACPI_ALLOCATE_BUFFER, NULL};
-	char			*pathname;
-	struct acpi_buffer	buffer;
-	struct acpi_device_info	*dinfo;
-
-	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &namebuf);
-	if (status)
-		goto ret;
-	pathname = namebuf.pointer;
-
-	buffer.length = ACPI_ALLOCATE_BUFFER;
-	buffer.pointer = NULL;
-	status = acpi_get_object_info(handle, &buffer);
-	if (ACPI_FAILURE(status))
-		goto out2;
-
-	dinfo = buffer.pointer;
-
-	/* find full device path name for pcidevfn */
-	if (dinfo && (dinfo->valid & ACPI_VALID_ADR) &&
-	    dinfo->address == winfo->pcidevfn) {
-		if (ata_msg_probe(winfo->ataport))
-			ata_dev_printk(winfo->atadev, KERN_DEBUG,
-				":%s: matches pcidevfn (0x%llx)\n",
-				pathname, winfo->pcidevfn);
-		strlcpy(winfo->basepath, pathname,
-			sizeof(winfo->basepath));
-		winfo->basepath_len = strlen(pathname);
-		goto out;
-	}
+	max_devices = 1;
+	if (ap->flags & ATA_FLAG_SLAVE_POSS)
+		max_devices++;
 
-	/* if basepath is not yet known, ignore this object */
-	if (!winfo->basepath_len)
-		goto out;
+	for (i = 0; i < max_devices; i++) {
+		struct ata_device *dev = &ap->device[i];
 
-	/* if this object is in scope of basepath, maybe use it */
-	if (strncmp(pathname, winfo->basepath,
-	    winfo->basepath_len) == 0) {
-		if (!(dinfo->valid & ACPI_VALID_ADR))
-			goto out;
-		if (ata_msg_probe(winfo->ataport))
-			ata_dev_printk(winfo->atadev, KERN_DEBUG,
-				"GOT ONE: (%s) root_port = 0x%llx,"
-				" port_num = 0x%llx\n", pathname,
-				SATA_ROOT_PORT(dinfo->address),
-				SATA_PORT_NUMBER(dinfo->address));
-		/* heuristics: */
-		if (SATA_PORT_NUMBER(dinfo->address) != NO_PORT_MULT)
-			if (ata_msg_probe(winfo->ataport))
-				ata_dev_printk(winfo->atadev,
-					KERN_DEBUG, "warning: don't"
-					" know how to handle SATA port"
-					" multiplier\n");
-		if (SATA_ROOT_PORT(dinfo->address) ==
-			winfo->ataport->port_no &&
-		    SATA_PORT_NUMBER(dinfo->address) == NO_PORT_MULT) {
-			if (ata_msg_probe(winfo->ataport))
-				ata_dev_printk(winfo->atadev,
-					KERN_DEBUG,
-					"THIS ^^^^^ is the requested"
-					" SATA drive (handle = 0x%p)\n",
-					handle);
-			winfo->sata_adr = dinfo->address;
-			winfo->obj_handle = handle;
-		}
+		dev->acpi_handle = acpi_get_child(ap->acpi_handle, i);
 	}
-out:
-	kfree(dinfo);
-out2:
-	kfree(pathname);
-
-ret:
-	return status;
 }
 
-/* Get the SATA drive _ADR object. */
-static int get_sata_adr(struct device *dev, acpi_handle handle,
-			acpi_integer pcidevfn, unsigned int drive,
-			struct ata_port *ap,
-			struct ata_device *atadev, u32 *dev_adr)
+/**
+ * ata_acpi_associate - associate ATA host with ACPI objects
+ * @host: target ATA host
+ *
+ * Look up ACPI objects associated with @host and initialize
+ * acpi_handle fields of @host, its ports and devices accordingly.
+ *
+ * LOCKING:
+ * EH context.
+ *
+ * RETURNS:
+ * 0 on success, -errno on failure.
+ */
+void ata_acpi_associate(struct ata_host *host)
 {
-	acpi_status	status;
-	struct walk_info *winfo;
-	int		err = -ENOMEM;
+	int i;
 
-	winfo = kzalloc(sizeof(struct walk_info), GFP_KERNEL);
-	if (!winfo)
-		goto out;
+	if (!is_pci_dev(host->dev) || libata_noacpi)
+		return;
 
-	winfo->dev = dev;
-	winfo->atadev = atadev;
-	winfo->ataport = ap;
-	if (acpi_bus_get_device(handle, &winfo->adev) < 0)
-		if (ata_msg_probe(ap))
-			ata_dev_printk(winfo->atadev, KERN_DEBUG,
-				"acpi_bus_get_device failed\n");
-	winfo->handle = handle;
-	winfo->pcidevfn = pcidevfn;
-	winfo->drivenum = drive;
+	host->acpi_handle = DEVICE_ACPI_HANDLE(host->dev);
+	if (!host->acpi_handle)
+		return;
 
-	status = acpi_get_devices(NULL, get_devices, winfo, NULL);
-	if (ACPI_FAILURE(status)) {
-		if (ata_msg_probe(ap))
-			ata_dev_printk(winfo->atadev, KERN_DEBUG,
-				"%s: acpi_get_devices failed\n",
-				__FUNCTION__);
-		err = -ENODEV;
-	} else {
-		*dev_adr = winfo->sata_adr;
-		atadev->obj_handle = winfo->obj_handle;
-		err = 0;
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+
+		if (host->ports[0]->flags & ATA_FLAG_ACPI_SATA)
+			ata_acpi_associate_sata_port(ap);
+		else
+			ata_acpi_associate_ide_port(ap);
 	}
-	kfree(winfo);
-out:
-	return err;
 }
 
 /**
@@ -290,20 +122,15 @@ static int do_drive_get_GTF(struct ata_device *dev, unsigned int *gtf_length,
 {
 	struct ata_port *ap = dev->ap;
 	acpi_status status;
-	acpi_handle dev_handle = NULL;
-	acpi_handle chan_handle, drive_handle;
-	acpi_integer pcidevfn = 0;
-	u32 dev_adr;
 	struct acpi_buffer output;
 	union acpi_object *out_obj;
-	struct device *gdev = ap->host->dev;
 	int err = -ENODEV;
 
 	*gtf_length = 0;
 	*gtf_address = 0UL;
 	*obj_loc = 0UL;
 
-	if (libata_noacpi)
+	if (!dev->acpi_handle)
 		return 0;
 
 	if (ata_msg_probe(ap))
@@ -319,78 +146,14 @@ static int do_drive_get_GTF(struct ata_device *dev, unsigned int *gtf_length,
 		goto out;
 	}
 
-	/* Don't continue if device has no _ADR method.
-	 * _GTF is intended for known motherboard devices. */
-	if (!(ap->flags & ATA_FLAG_ACPI_SATA)) {
-		err = pata_get_dev_handle(gdev, &dev_handle, &pcidevfn);
-		if (err < 0) {
-			if (ata_msg_probe(ap))
-				ata_dev_printk(dev, KERN_DEBUG,
-					"%s: pata_get_dev_handle failed (%d)\n",
-					__FUNCTION__, err);
-			goto out;
-		}
-	} else {
-		err = sata_get_dev_handle(gdev, &dev_handle, &pcidevfn);
-		if (err < 0) {
-			if (ata_msg_probe(ap))
-				ata_dev_printk(dev, KERN_DEBUG,
-					"%s: sata_get_dev_handle failed (%d\n",
-					__FUNCTION__, err);
-			goto out;
-		}
-	}
-
-	/* Get this drive's _ADR info. if not already known. */
-	if (!dev->obj_handle) {
-		if (!(ap->flags & ATA_FLAG_ACPI_SATA)) {
-			/* get child objects of dev_handle == channel objects,
-	 		 * + _their_ children == drive objects */
-			/* channel is ap->port_no */
-			chan_handle = acpi_get_child(dev_handle,
-						ap->port_no);
-			if (ata_msg_probe(ap))
-				ata_dev_printk(dev, KERN_DEBUG,
-					"%s: chan adr=%d: chan_handle=0x%p\n",
-					__FUNCTION__, ap->port_no,
-					chan_handle);
-			if (!chan_handle) {
-				err = -ENODEV;
-				goto out;
-			}
-			/* TBD: could also check ACPI object VALID bits */
-			drive_handle = acpi_get_child(chan_handle, dev->devno);
-			if (!drive_handle) {
-				err = -ENODEV;
-				goto out;
-			}
-			dev_adr = dev->devno;
-			dev->obj_handle = drive_handle;
-		} else {	/* for SATA mode */
-			dev_adr = SATA_ADR_RSVD;
-			err = get_sata_adr(gdev, dev_handle, pcidevfn, 0,
-					ap, dev, &dev_adr);
-		}
-		if (err < 0 || dev_adr == SATA_ADR_RSVD ||
-		    !dev->obj_handle) {
-			if (ata_msg_probe(ap))
-				ata_dev_printk(dev, KERN_DEBUG,
-					"%s: get_sata/pata_adr failed: "
-					"err=%d, dev_adr=%u, obj_handle=0x%p\n",
-					__FUNCTION__, err, dev_adr,
-					dev->obj_handle);
-			goto out;
-		}
-	}
-
 	/* Setting up output buffer */
 	output.length = ACPI_ALLOCATE_BUFFER;
 	output.pointer = NULL;	/* ACPI-CA sets this; save/free it later */
 
 	/* _GTF has no input parameters */
 	err = -EIO;
-	status = acpi_evaluate_object(dev->obj_handle, "_GTF",
-					NULL, &output);
+	status = acpi_evaluate_object(dev->acpi_handle, "_GTF",
+				      NULL, &output);
 	if (ACPI_FAILURE(status)) {
 		if (ata_msg_probe(ap))
 			ata_dev_printk(dev, KERN_DEBUG,
@@ -528,7 +291,7 @@ static int do_drive_set_taskfiles(struct ata_device *dev,
 		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER: port#: %d\n",
 			       __FUNCTION__, ap->port_no);
 
-	if (libata_noacpi || !(ap->flags & ATA_FLAG_ACPI_SATA))
+	if (!(ap->flags & ATA_FLAG_ACPI_SATA))
 		return 0;
 
 	if (!ata_dev_enabled(dev) || (ap->flags & ATA_FLAG_DISABLED))
@@ -571,8 +334,6 @@ int ata_acpi_exec_tfs(struct ata_port *ap)
 	unsigned long gtf_address;
 	unsigned long obj_loc;
 
-	if (libata_noacpi)
-		return 0;
 	/*
 	 * TBD - implement PATA support.  For now,
 	 * we should not run GTF on PATA devices since some
@@ -624,16 +385,12 @@ int ata_acpi_exec_tfs(struct ata_port *ap)
 int ata_acpi_push_id(struct ata_device *dev)
 {
 	struct ata_port *ap = dev->ap;
-	acpi_handle handle;
-	acpi_integer pcidevfn;
 	int err;
-	struct device *gdev = ap->host->dev;
-	u32 dev_adr;
 	acpi_status status;
 	struct acpi_object_list input;
 	union acpi_object in_params[1];
 
-	if (libata_noacpi)
+	if (!dev->acpi_handle)
 		return 0;
 
 	if (ata_msg_probe(ap))
@@ -648,34 +405,6 @@ int ata_acpi_push_id(struct ata_device *dev)
 		goto out;
 	}
 
-	/* Don't continue if device has no _ADR method.
-	 * _SDD is intended for known motherboard devices. */
-	err = sata_get_dev_handle(gdev, &handle, &pcidevfn);
-	if (err < 0) {
-		if (ata_msg_probe(ap))
-			ata_dev_printk(dev, KERN_DEBUG,
-				"%s: sata_get_dev_handle failed (%d\n",
-				__FUNCTION__, err);
-		goto out;
-	}
-
-	/* Get this drive's _ADR info, if not already known */
-	if (!dev->obj_handle) {
-		dev_adr = SATA_ADR_RSVD;
-		err = get_sata_adr(gdev, handle, pcidevfn, dev->devno, ap, dev,
-					&dev_adr);
-		if (err < 0 || dev_adr == SATA_ADR_RSVD ||
-			!dev->obj_handle) {
-			if (ata_msg_probe(ap))
-				ata_dev_printk(dev, KERN_DEBUG,
-					"%s: get_sata_adr failed: "
-					"err=%d, dev_adr=%u, obj_handle=0x%p\n",
-					__FUNCTION__, err, dev_adr,
-					dev->obj_handle);
-			goto out;
-		}
-	}
-
 	/* Give the drive Identify data to the drive via the _SDD method */
 	/* _SDD: set up input parameters */
 	input.count = 1;
@@ -687,7 +416,7 @@ int ata_acpi_push_id(struct ata_device *dev)
 
 	/* It's OK for _SDD to be missing too. */
 	swap_buf_le16(dev->id, ATA_ID_WORDS);
-	status = acpi_evaluate_object(dev->obj_handle, "_SDD", &input, NULL);
+	status = acpi_evaluate_object(dev->acpi_handle, "_SDD", &input, NULL);
 	swap_buf_le16(dev->id, ATA_ID_WORDS);
 
 	err = ACPI_FAILURE(status) ? -EIO : 0;
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 55543b2..7967ef9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6258,6 +6258,9 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 	if (rc)
 		return rc;
 
+	/* associate with ACPI nodes */
+	ata_acpi_associate(host);
+
 	/* set cable, sata_spd_limit and report */
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 5e24666..29037cd 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -98,9 +98,11 @@ extern struct ata_port *ata_port_alloc(struct ata_host *host);
 
 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
+extern void ata_acpi_associate(struct ata_host *host);
 extern int ata_acpi_exec_tfs(struct ata_port *ap);
 extern int ata_acpi_push_id(struct ata_device *dev);
 #else
+static inline void ata_acpi_associate(struct ata_host *host) { }
 static inline int ata_acpi_exec_tfs(struct ata_port *ap)
 {
 	return 0;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index a26bb7f..9a517e6 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -381,6 +381,9 @@ struct ata_host {
 	void			*private_data;
 	const struct ata_port_operations *ops;
 	unsigned long		flags;
+#ifdef CONFIG_ATA_ACPI
+	acpi_handle		acpi_handle;
+#endif
 	struct ata_port		*simplex_claimed;	/* channel owning the DMA */
 	struct ata_port		*ports[0];
 };
@@ -447,6 +450,9 @@ struct ata_device {
 	unsigned int		devno;		/* 0 or 1 */
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	struct scsi_device	*sdev;		/* attached SCSI device */
+#ifdef CONFIG_ATA_ACPI
+	acpi_handle		acpi_handle;
+#endif
 	/* n_sector is used as CLEAR_OFFSET, read comment above CLEAR_OFFSET */
 	u64			n_sectors;	/* size of device, if ATA */
 	unsigned int		class;		/* ATA_DEV_xxx */
@@ -475,10 +481,6 @@ struct ata_device {
 	struct ata_ering	ering;
 	int			spdn_cnt;
 	unsigned int		horkage;	/* List of broken features */
-#ifdef CONFIG_ATA_ACPI
-	/* ACPI objects info */
-	acpi_handle obj_handle;
-#endif
 };
 
 /* Offset into struct ata_device.  Fields above it are maintained
@@ -568,6 +570,9 @@ struct ata_port {
 
 	void			*private_data;
 
+#ifdef CONFIG_ATA_ACPI
+	acpi_handle		acpi_handle;
+#endif
 	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
 };
 
-- 
1.5.0.3


