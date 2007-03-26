From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH] Add _GTM and _STM support to libata
Date: Mon, 26 Mar 2007 04:22:23 +0100
Message-ID: <20070326032222.GA13113@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: kristen.c.accardi@intel.com
List-Id: linux-ide@vger.kernel.org

I've ported the drivers/ide code for handling _GTM and _STM to libata. 
I'm not utterly convinced that I'm doing the calls in the right place - 
should they be attached to the scsi code rather than the ata host code? 
Anyway, this fixes suspend/resume on nc6220, which is what I was aiming 
for...

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

--- 

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index c428a56..0e542ea 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -34,6 +34,19 @@ struct taskfile_array {
 	u8	tfa[REGS_PER_GTF];	/* regs. 0x1f1 - 0x1f7 */
 };
 
+struct GTM_buffer {
+        u32     PIO_speed0;
+        u32     DMA_speed0;
+        u32     PIO_speed1;
+        u32     DMA_speed1;
+        u32     GTM_flags;
+};
+
+struct ata_acpi_port_link {
+        acpi_handle                      obj_handle;
+        struct GTM_buffer                gtm;
+};
+
 /*
  *	Helper - belongs in the PCI layer somewhere eventually
  */
@@ -706,4 +719,125 @@ out:
 	return 0;
 }
 
+/**
+ * ata_acpi_get_timings - get the channel (controller) timings
+ * @hwif: target IDE interface (channel)
+ *
+ * This function executes the _GTM ACPI method for the target channel.
+ *
+ */
+void ata_acpi_get_timings(struct ata_port *ap)
+{
+        acpi_status                     status;
+	int                             err;
+        acpi_handle                     dev_handle = NULL;
+        acpi_integer                    pcidevfn = 0;
+	struct device			*dev = ap->host->dev;
+        struct acpi_buffer              output;
+        union acpi_object               *out_obj;
+
+        if (noacpi)
+		return;
+
+	if (ap->cbl == ATA_CBL_SATA)
+		return;
 
+	err = pata_get_dev_handle(dev, &dev_handle, &pcidevfn);
+
+	if (err < 0)
+		return;
+
+	ap->port_handle = acpi_get_child(dev_handle, ap->port_no);
+
+        /* Setting up output buffer for _GTM */
+        output.length = ACPI_ALLOCATE_BUFFER;
+        output.pointer = NULL;  /* ACPI-CA sets this; save/free it later */
+
+        /* _GTM has no input parameters */
+        status = acpi_evaluate_object(ap->port_handle, "_GTM",
+                                      NULL, &output);
+
+        if (ACPI_FAILURE(status))
+	  return;
+
+        if (!output.length || !output.pointer) {
+                kfree(output.pointer);
+                return;
+        }
+
+        out_obj = output.pointer;
+        if (out_obj->type != ACPI_TYPE_BUFFER) {
+                kfree(output.pointer);
+                return;
+        }
+
+        if (!out_obj->buffer.length || !out_obj->buffer.pointer ||
+            out_obj->buffer.length != sizeof(struct GTM_buffer)) {
+                kfree(output.pointer);
+                printk(KERN_ERR
+                        "%s: unexpected _GTM length (0x%x)[should be 0x%zx] or \
+"
+		       "addr (0x%p)\n",
+		       __FUNCTION__, out_obj->buffer.length,
+		       sizeof(struct GTM_buffer), out_obj->buffer.pointer);
+                return;
+        }
+
+	if (!ap->acpidata) {
+		ap->acpidata = kzalloc(sizeof(struct ata_acpi_port_link), GFP_KERNEL);
+		if (!ap->acpidata)
+			return;
+	}
+
+        memcpy(&ap->acpidata->gtm, out_obj->buffer.pointer,
+               sizeof(struct GTM_buffer));
+
+        kfree(output.pointer);
+}
+EXPORT_SYMBOL_GPL(ata_acpi_get_timings);
+
+/**
+ * ata_acpi_push_timings - set the channel (controller) timings
+ * @hwif: target IDE interface (channel)
+ *
+ * This function executes the _STM ACPI method for the target channel.
+ *
+ * _STM requires Identify Drive data, which has to passed as an argument.
+ * Unfortunately hd_driveid is a mangled version which we can't readily
+ * use; hence we'll get the information afresh.
+ */
+void ata_acpi_push_timings(struct ata_port *ap)
+{
+        acpi_status             status;
+        struct acpi_object_list input;
+        union acpi_object       in_params[3];
+
+        if (noacpi)
+                return;
+
+        if (!ap->acpidata)
+                return;
+
+        /* Give the GTM buffer + drive Identify data to the channel via the
+         * _STM method: */
+        /* setup input parameters buffer for _STM */
+        input.count = 3;
+        input.pointer = in_params;
+        in_params[0].type = ACPI_TYPE_BUFFER;
+        in_params[0].buffer.length = sizeof(struct GTM_buffer);
+        in_params[0].buffer.pointer = (u8 *)&ap->acpidata->gtm;
+        in_params[1].type = ACPI_TYPE_BUFFER;
+        in_params[1].buffer.length = sizeof(ap->device[0].id[0]) * ATA_ID_WORDS;
+        in_params[1].buffer.pointer = (u8 *)&ap->device[0].id;
+        in_params[2].type = ACPI_TYPE_BUFFER;
+        in_params[2].buffer.length = sizeof(ap->device[1].id[0]) * ATA_ID_WORDS;
+        in_params[2].buffer.pointer = (u8 *)&ap->device[1].id;
+        /* Output buffer: _STM has no output */
+
+        status = acpi_evaluate_object(ap->port_handle, "_STM",
+                                      &input, NULL);
+
+        if (ACPI_FAILURE(status))
+	  return;
+}
+EXPORT_SYMBOL_GPL(ata_acpi_push_timings);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index bf327d4..df38fc3 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5444,6 +5444,7 @@ int ata_host_suspend(struct ata_host *host, pm_message_t mesg)
 				goto fail;
 			}
 		}
+		ata_acpi_get_timings(ap);
 	}
 
 	host->dev->power.power_state = mesg;
@@ -5467,6 +5468,11 @@ int ata_host_suspend(struct ata_host *host, pm_message_t mesg)
  */
 void ata_host_resume(struct ata_host *host)
 {
+        int i;
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+		ata_acpi_push_timings(ap);
+	}
 	ata_host_request_pm(host, PMSG_ON, ATA_EH_SOFTRESET,
 			    ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET, 0);
 	host->dev->power.power_state = PMSG_ON;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index c426714..277982c 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -101,6 +101,8 @@ extern struct ata_probe_ent *ata_probe_ent_alloc(struct device *dev,
 #ifdef CONFIG_SATA_ACPI
 extern int ata_acpi_exec_tfs(struct ata_port *ap);
 extern int ata_acpi_push_id(struct ata_port *ap, unsigned int ix);
+extern void ata_acpi_get_timings(struct ata_port *ap);
+extern void ata_acpi_push_timings(struct ata_port *ap);
 #else
 static inline int ata_acpi_exec_tfs(struct ata_port *ap)
 {
@@ -110,6 +112,14 @@ static inline int ata_acpi_push_id(struct ata_port *ap, unsigned int ix)
 {
 	return 0;
 }
+static inline void ata_acpi_get_timings(struct ata_port *ap)
+{
+        return;
+}
+extern void ata_acpi_push_timings(struct ata_port *ap)
+{
+        return;
+}
 #endif
 
 /* libata-scsi.c */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e3f32f3..b141863 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -340,6 +340,9 @@ struct scsi_device;
 struct ata_port_operations;
 struct ata_port;
 struct ata_queued_cmd;
+#ifdef CONFIG_SATA_ACPI
+struct ata_acpi_port_link;
+#endif
 
 /* typedefs */
 typedef void (*ata_qc_cb_t) (struct ata_queued_cmd *qc);
@@ -590,6 +593,11 @@ struct ata_port {
 	void			*private_data;
 
 	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
+#ifdef CONFIG_SATA_ACPI
+	/* ACPI objects info */
+	acpi_handle port_handle;
+	struct ata_acpi_port_link *acpidata;
+#endif
 };
 
 struct ata_port_operations {

-- 
Matthew Garrett | mjg59@srcf.ucam.org
