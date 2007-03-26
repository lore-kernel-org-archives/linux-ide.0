From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Add _GTM and _STM support to libata
Date: Mon, 26 Mar 2007 21:15:14 +0100
Message-ID: <20070326201514.GA27284@srcf.ucam.org>
References: <20070326032222.GA13113@srcf.ucam.org> <20070326115807.0c89ee21@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:59510 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbXCZUPd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Mar 2007 16:15:33 -0400
Content-Disposition: inline
In-Reply-To: <20070326115807.0c89ee21@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, kristen.c.accardi@intel.com

On Mon, Mar 26, 2007 at 11:58:07AM +0100, Alan Cox wrote:
> On Mon, 26 Mar 2007 04:22:23 +0100
> Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> 
> > I've ported the drivers/ide code for handling _GTM and _STM to libata. 
> > I'm not utterly convinced that I'm doing the calls in the right place - 
> 
> Please see the various patches I've posted or the -mm tree. I did that
> some time ago and the pata_acpi driver makes full use of them already.

Ok, missed that. How about something like the following? I've changed 
some of the interfaces slightly, so the pata_acpi driver would need to 
be altered to match. This gets rid of the CABLE_SATA checking in 
libata-acpi.c, stores the handle in the ata_port structure so we can 
delete a load of code that keeps regenerating it, and ensures that the 
acpi code is setup up at device creation time. Finally, it hooks the 
calls into the core libata code.

Any comments?

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

--- 
diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 0bd4789..99e534c 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -291,8 +291,7 @@ static int do_drive_get_GTF(struct ata_port *ap, int ix,
 			unsigned long *obj_loc)
 {
 	acpi_status			status;
-	acpi_handle			dev_handle = NULL;
-	acpi_handle			chan_handle, drive_handle;
+	acpi_handle			drive_handle;
 	acpi_integer			pcidevfn = 0;
 	u32				dev_adr;
 	struct acpi_buffer		output;
@@ -321,47 +320,12 @@ static int do_drive_get_GTF(struct ata_port *ap, int ix,
 		goto out;
 	}
 
-	/* Don't continue if device has no _ADR method.
-	 * _GTF is intended for known motherboard devices. */
-	if (!(ap->cbl == ATA_CBL_SATA)) {
-		err = pata_get_dev_handle(dev, &dev_handle, &pcidevfn);
-		if (err < 0) {
-			if (ata_msg_probe(ap))
-				ata_dev_printk(atadev, KERN_DEBUG,
-					"%s: pata_get_dev_handle failed (%d)\n",
-					__FUNCTION__, err);
-			goto out;
-		}
-	} else {
-		err = sata_get_dev_handle(dev, &dev_handle, &pcidevfn);
-		if (err < 0) {
-			if (ata_msg_probe(ap))
-				ata_dev_printk(atadev, KERN_DEBUG,
-					"%s: sata_get_dev_handle failed (%d\n",
-					__FUNCTION__, err);
-			goto out;
-		}
-	}
-
 	/* Get this drive's _ADR info. if not already known. */
 	if (!atadev->obj_handle) {
-		if (!(ap->cbl == ATA_CBL_SATA)) {
-			/* get child objects of dev_handle == channel objects,
-	 		 * + _their_ children == drive objects */
-			/* channel is ap->port_no */
-			chan_handle = acpi_get_child(dev_handle,
-						ap->port_no);
-			if (ata_msg_probe(ap))
-				ata_dev_printk(atadev, KERN_DEBUG,
-					"%s: chan adr=%d: chan_handle=0x%p\n",
-					__FUNCTION__, ap->port_no,
-					chan_handle);
-			if (!chan_handle) {
-				err = -ENODEV;
-				goto out;
-			}
+		if (ap->acpi_port_link->is_pata) {
 			/* TBD: could also check ACPI object VALID bits */
-			drive_handle = acpi_get_child(chan_handle, ix);
+			drive_handle = 
+				acpi_get_child(ap->acpi_port_link->handle, ix);
 			if (!drive_handle) {
 				err = -ENODEV;
 				goto out;
@@ -370,7 +334,7 @@ static int do_drive_get_GTF(struct ata_port *ap, int ix,
 			atadev->obj_handle = drive_handle;
 		} else {	/* for SATA mode */
 			dev_adr = SATA_ADR_RSVD;
-			err = get_sata_adr(dev, dev_handle, pcidevfn, 0,
+			err = get_sata_adr(dev, ap->acpi_port_link->handle, pcidevfn, 0,
 					ap, atadev, &dev_adr);
 		}
 		if (err < 0 || dev_adr == SATA_ADR_RSVD ||
@@ -531,7 +495,7 @@ static int do_drive_set_taskfiles(struct ata_port *ap,
 		ata_dev_printk(atadev, KERN_DEBUG, "%s: ENTER: port#: %d\n",
 			       __FUNCTION__, ap->port_no);
 
-	if (noacpi || !(ap->cbl == ATA_CBL_SATA))
+	if (noacpi || !ap->acpi_port_link || ap->acpi_port_link->is_pata)
 		return 0;
 
 	if (!ata_dev_enabled(atadev) || (ap->flags & ATA_FLAG_DISABLED))
@@ -581,7 +545,7 @@ int ata_acpi_exec_tfs(struct ata_port *ap)
 	 * we should not run GTF on PATA devices since some
 	 * PATA require execution of GTM/STM before GTF.
 	 */
-	if (!(ap->cbl == ATA_CBL_SATA))
+	if (!ap->acpi_port_link || ap->acpi_port_link->is_pata)
 		return 0;
 
 	for (ix = 0; ix < ATA_MAX_DEVICES; ix++) {
@@ -626,7 +590,6 @@ int ata_acpi_exec_tfs(struct ata_port *ap)
  */
 int ata_acpi_push_id(struct ata_port *ap, unsigned int ix)
 {
-	acpi_handle                     handle;
 	acpi_integer                    pcidevfn;
 	int                             err;
 	struct device                   *dev = ap->host->dev;
@@ -636,36 +599,17 @@ int ata_acpi_push_id(struct ata_port *ap, unsigned int ix)
 	struct acpi_object_list         input;
 	union acpi_object               in_params[1];
 
-	if (noacpi)
+	if (noacpi || !ap->acpi_port_link || ap->acpi_port_link->is_pata)
 		return 0;
 
 	if (ata_msg_probe(ap))
 		ata_dev_printk(atadev, KERN_DEBUG, "%s: ix = %d, port#: %d\n",
 			       __FUNCTION__, ix, ap->port_no);
 
-	/* Don't continue if not a SATA device. */
-	if (!(ap->cbl == ATA_CBL_SATA)) {
-		if (ata_msg_probe(ap))
-			ata_dev_printk(atadev, KERN_DEBUG,
-				"%s: Not a SATA device\n", __FUNCTION__);
-		goto out;
-	}
-
-	/* Don't continue if device has no _ADR method.
-	 * _SDD is intended for known motherboard devices. */
-	err = sata_get_dev_handle(dev, &handle, &pcidevfn);
-	if (err < 0) {
-		if (ata_msg_probe(ap))
-			ata_dev_printk(atadev, KERN_DEBUG,
-				"%s: sata_get_dev_handle failed (%d\n",
-				__FUNCTION__, err);
-		goto out;
-	}
-
 	/* Get this drive's _ADR info, if not already known */
 	if (!atadev->obj_handle) {
 		dev_adr = SATA_ADR_RSVD;
-		err = get_sata_adr(dev, handle, pcidevfn, ix, ap, atadev,
+		err = get_sata_adr(dev, ap->acpi_port_link->handle, pcidevfn, ix, ap, atadev,
 					&dev_adr);
 		if (err < 0 || dev_adr == SATA_ADR_RSVD ||
 			!atadev->obj_handle) {
@@ -706,16 +650,18 @@ out:
 	return 0;
 }
 
-
-int ata_acpi_gtm(const struct ata_port *ap, void *handle, struct acpi_gtm *gtm)
+int ata_acpi_gtm(const struct ata_port *ap)
 {
 	acpi_status status;
 	struct acpi_buffer output;
 
+	if (!ap->acpi_port_link || !ap->acpi_port_link->is_pata)
+		return -ENODEV;
+
 	output.length = ACPI_ALLOCATE_BUFFER;
 	output.pointer = NULL;
 
-	status = acpi_evaluate_object(handle, "_GTM", NULL, &output);
+	status = acpi_evaluate_object(ap->acpi_port_link->handle, "_GTM", NULL, &output);
 
 	if (ACPI_FAILURE(status)) {
 		ata_port_printk(ap, KERN_ERR, "ACPI get timing mode failed.\n");
@@ -725,20 +671,23 @@ int ata_acpi_gtm(const struct ata_port *ap, void *handle, struct acpi_gtm *gtm)
 		ata_port_printk(ap, KERN_ERR, "ACPI get timing provided invalid data.\n");
 		return -EINVAL;
 	}
-	memcpy(gtm, output.pointer, sizeof(struct acpi_gtm));
+	memcpy(ap->acpi_port_link->gtm, output.pointer, sizeof(struct acpi_gtm));
 	kfree(output.pointer);
 	return 0;
 }
 
-int ata_acpi_stm(const struct ata_port *ap, void *handle, struct acpi_gtm *stm)
+int ata_acpi_stm(const struct ata_port *ap)
 {
 	acpi_status status;
 	struct acpi_object_list         input;
 	union acpi_object               in_params[3];
 
+	if (!ap->acpi_port_link || !ap->acpi_port_link->is_pata || !ap->acpi_port_link->gtm)
+		return -ENODEV;
+
 	in_params[0].type = ACPI_TYPE_BUFFER;
 	in_params[0].buffer.length = sizeof(struct acpi_gtm);
-	in_params[0].buffer.pointer = (u8 *)stm;
+	in_params[0].buffer.pointer = (u8 *)ap->acpi_port_link->gtm;
 	/* Buffers for id may need byteswapping ? */
 	in_params[1].type = ACPI_TYPE_BUFFER;
 	in_params[1].buffer.length = 512;
@@ -750,7 +699,7 @@ int ata_acpi_stm(const struct ata_port *ap, void *handle, struct acpi_gtm *stm)
 	input.count = 3;
 	input.pointer = in_params;
 
-	status = acpi_evaluate_object(handle, "_STM", &input, NULL);
+	status = acpi_evaluate_object(ap->acpi_port_link->handle, "_STM", &input, NULL);
 
 	if (ACPI_FAILURE(status)) {
 		ata_port_printk(ap, KERN_ERR, "ACPI set timing mode failed.\n");
@@ -787,8 +736,58 @@ int ata_pata_acpi_present(struct pci_dev *pdev)
 	return present;
 }
 
+static void *ata_sata_find_handle(struct device *dev, int port)
+{
+	acpi_handle handle;
+	acpi_integer devfn;
+
+	if (noacpi)
+		return NULL;
+	if (sata_get_dev_handle(dev, &handle, &devfn) < 0)
+		return NULL;
+	return acpi_get_child(handle, port);
+}
+
+int ata_sata_acpi_present(struct pci_dev *pdev)
+{
+	if (ata_sata_find_handle(&pdev->dev, 0))
+		return 1;
+	return 0;
+}
+
+void ata_acpi_setup(struct ata_port *ap)
+{
+	struct device *dev = ap->host->dev;	
+	struct pci_dev pci_dev;
+	int pata;
+
+	if (!is_pci_dev (dev))
+		return;
+
+	pci_dev = to_pci_dev(dev);
+
+	if (ata_sata_acpi_present(pci_dev)) 
+		pata = 0;
+	else if (ata_pata_acpi_present(pci_dev))
+		pata = 1;
+	else
+		return;
+
+	ap->acpi_port_link = kzalloc(sizeof(struct ata_acpi_port_link), 
+				     GFP_KERNEL);
+	ap->acpi_port_link->is_pata = pata;
+	if (pata) {
+		ap->acpi_port_link->handle = 
+			ata_pata_find_handle(ap->host->dev, ap->port_no);
+		ap->acpi_port_link->gtm = kzalloc(sizeof(struct acpi_gtm), 
+						  GFP_KERNEL);
+	} else
+		ap->acpi_port_link->handle = 
+			ata_sata_find_handle(ap->host->dev, ap->port_no);
+}
 
 EXPORT_SYMBOL_GPL(ata_acpi_gtm);
 EXPORT_SYMBOL_GPL(ata_acpi_stm);
 EXPORT_SYMBOL_GPL(ata_pata_acpi_handle);
 EXPORT_SYMBOL_GPL(ata_pata_acpi_present);
+EXPORT_SYMBOL_GPL(ata_acpi_setup);
diff --git a/drivers/ata/libata-acpi.h b/drivers/ata/libata-acpi.h
index d630ec3..339768a 100644
--- a/drivers/ata/libata-acpi.h
+++ b/drivers/ata/libata-acpi.h
@@ -39,9 +39,47 @@ struct acpi_gtm {
 	u32 flags;
 };
 
+struct acpi_port_link {
+	int is_pata;
+	acpi_handle *handle;
+	struct acpi_gtm *gtm;
+}
+
+#ifdef CONFIG_SATA_ACPI
+extern int ata_acpi_exec_tfs(struct ata_port *ap);
+extern int ata_acpi_push_id(struct ata_port *ap, unsigned int ix);
 extern int ata_acpi_gtm(const struct ata_port *p, void *handle, struct acpi_gtm *gtm);
 extern int ata_acpi_stm(const struct ata_port *ap, void *handle, struct acpi_gtm *stm);
 extern void *ata_pata_acpi_handle(const struct ata_port *ap);
 extern int ata_pata_acpi_present(struct pci_dev *pdev);
-
+extern void ata_acpi_setup(const struct ata_port *ap);
+#else
+static inline int ata_acpi_exec_tfs(struct ata_port *ap)
+{
+        return 0;
+}
+static inline int ata_acpi_push_id(struct ata_port *ap, unsigned int ix)
+{
+        return 0;
+}
+extern inline int ata_acpi_gtm(const struct ata_port *p, void *handle, struct acpi_gtm *gtm)
+{
+	return 0;
+}
+extern inline int ata_acpi_stm(const struct ata_port *ap, void *handle, struct acpi_gtm *stm)
+{
+	return 0;
+}
+extern inline void *ata_pata_acpi_handle(const struct ata_port *ap)
+{
+	return 0;
+}
+extern inline int ata_pata_acpi_present(struct pci_dev *pdev)
+{
+	return 0;
+}
+extern inline void ata_acpi_setup(const struct ata_port *ap)
+{
+	return;
+}
 #endif
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index bf327d4..079606b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -58,6 +58,7 @@
 #include <asm/byteorder.h>
 
 #include "libata.h"
+#include "libata-acpi.h"
 
 #define DRV_VERSION	"2.20"	/* must be exactly four chars */
 
@@ -5444,6 +5445,7 @@ int ata_host_suspend(struct ata_host *host, pm_message_t mesg)
 				goto fail;
 			}
 		}
+		ata_acpi_gtm(ap);
 	}
 
 	host->dev->power.power_state = mesg;
@@ -5467,6 +5469,11 @@ int ata_host_suspend(struct ata_host *host, pm_message_t mesg)
  */
 void ata_host_resume(struct ata_host *host)
 {
+	int i;
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+		ata_acpi_stm(ap);
+	}
 	ata_host_request_pm(host, PMSG_ON, ATA_EH_SOFTRESET,
 			    ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET, 0);
 	host->dev->power.power_state = PMSG_ON;
@@ -5917,6 +5924,7 @@ int ata_device_add(const struct ata_probe_ent *ent)
 		struct ata_port *ap = host->ports[i];
 
 		ata_scsi_scan_host(ap);
+		ata_acpi_setup(ap);
 	}
 
 	VPRINTK("EXIT, returning %u\n", ent->n_ports);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index c426714..eb41263 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -97,21 +97,6 @@ extern void ata_port_init(struct ata_port *ap, struct ata_host *host,
 extern struct ata_probe_ent *ata_probe_ent_alloc(struct device *dev,
 						 const struct ata_port_info *port);
 
-/* libata-acpi.c */
-#ifdef CONFIG_SATA_ACPI
-extern int ata_acpi_exec_tfs(struct ata_port *ap);
-extern int ata_acpi_push_id(struct ata_port *ap, unsigned int ix);
-#else
-static inline int ata_acpi_exec_tfs(struct ata_port *ap)
-{
-	return 0;
-}
-static inline int ata_acpi_push_id(struct ata_port *ap, unsigned int ix)
-{
-	return 0;
-}
-#endif
-
 /* libata-scsi.c */
 extern struct scsi_transport_template ata_scsi_transport_template;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e3f32f3..9fb8586 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -590,6 +590,9 @@ struct ata_port {
 	void			*private_data;
 
 	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
+#ifdef CONFIG_SATA_ACPI
+	struct ata_acpi_port_link *acpi_port_link;
+#endif
 };
 
 struct ata_port_operations {

-- 
Matthew Garrett | mjg59@srcf.ucam.org
