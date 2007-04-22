From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/13] libata-acpi: implement _GTM/_STM support
Date: Mon, 23 Apr 2007 02:41:07 +0900
Message-ID: <1177263667443-git-send-email-htejun@gmail.com>
References: <11772636651400-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <11772636651400-git-send-email-htejun@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>
List-Id: linux-ide@vger.kernel.org

Implement _GTM/_STM support.  acpi_gtm is added to ata_port which
stores _GTM parameters over suspend/resume cycle.  A new hook
ata_acpi_on_suspend() is responsible for storing _GTM parameters
during suspend.  _STM is executed in ata_acpi_on_resume().  With this
change, invoking _GTF is safe on IDE hierarchy and acpi_sata check
before _GTF is removed.

ata_acpi_gtm() and ata_acpi_stm() implementation is taken from Alan
Cox's pata_acpi implementation.  ata_acpi_gtm() is fixed such that the
result parameter is not shifted by sizeof(union acpi_object).

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/ata/libata-acpi.c |  153 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/ata/libata-eh.c   |    8 ++-
 drivers/ata/libata.h      |    2 +
 include/linux/libata.h    |   13 ++++
 4 files changed, 171 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 0ba0e79..8403c50 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -101,6 +101,108 @@ void ata_acpi_associate(struct ata_host *host)
 }
 
 /**
+ * ata_acpi_gtm - execute _GTM
+ * @ap: target ATA port
+ * @gtm: out parameter for _GTM result
+ *
+ * Evaluate _GTM and store the result in @gtm.
+ *
+ * LOCKING:
+ * EH context.
+ *
+ * RETURNS:
+ * 0 on success, -ENOENT if _GTM doesn't exist, -errno on failure.
+ */
+static int ata_acpi_gtm(const struct ata_port *ap, struct ata_acpi_gtm *gtm)
+{
+	struct acpi_buffer output = { .length = ACPI_ALLOCATE_BUFFER };
+	union acpi_object *out_obj;
+	acpi_status status;
+	int rc = 0;
+
+	status = acpi_evaluate_object(ap->acpi_handle, "_GTM", NULL, &output);
+
+	rc = -ENOENT;
+	if (status == AE_NOT_FOUND)
+		goto out_free;
+
+	rc = -EINVAL;
+	if (ACPI_FAILURE(status)) {
+		ata_port_printk(ap, KERN_ERR,
+				"ACPI get timing mode failed (AE 0x%x)\n",
+				status);
+		goto out_free;
+	}
+
+	out_obj = output.pointer;
+	if (out_obj->type != ACPI_TYPE_BUFFER) {
+		ata_port_printk(ap, KERN_WARNING,
+				"_GTM returned unexpected object type 0x%x\n",
+				out_obj->type);
+
+		goto out_free;
+	}
+
+	if (out_obj->buffer.length != sizeof(struct ata_acpi_gtm)) {
+		ata_port_printk(ap, KERN_ERR,
+				"_GTM returned invalid length %d\n",
+				out_obj->buffer.length);
+		goto out_free;
+	}
+
+	memcpy(gtm, out_obj->buffer.pointer, sizeof(struct ata_acpi_gtm));
+	rc = 0;
+ out_free:
+	kfree(output.pointer);
+	return rc;
+}
+
+/**
+ * ata_acpi_stm - execute _STM
+ * @ap: target ATA port
+ * @stm: timing parameter to _STM
+ *
+ * Evaluate _STM with timing parameter @stm.
+ *
+ * LOCKING:
+ * EH context.
+ *
+ * RETURNS:
+ * 0 on success, -ENOENT if _STM doesn't exist, -errno on failure.
+ */
+static int ata_acpi_stm(const struct ata_port *ap, struct ata_acpi_gtm *stm)
+{
+	acpi_status status;
+	struct acpi_object_list         input;
+	union acpi_object               in_params[3];
+
+	in_params[0].type = ACPI_TYPE_BUFFER;
+	in_params[0].buffer.length = sizeof(struct ata_acpi_gtm);
+	in_params[0].buffer.pointer = (u8 *)stm;
+	/* Buffers for id may need byteswapping ? */
+	in_params[1].type = ACPI_TYPE_BUFFER;
+	in_params[1].buffer.length = 512;
+	in_params[1].buffer.pointer = (u8 *)ap->device[0].id;
+	in_params[2].type = ACPI_TYPE_BUFFER;
+	in_params[2].buffer.length = 512;
+	in_params[2].buffer.pointer = (u8 *)ap->device[1].id;
+
+	input.count = 3;
+	input.pointer = in_params;
+
+	status = acpi_evaluate_object(ap->acpi_handle, "_STM", &input, NULL);
+
+	if (status == AE_NOT_FOUND)
+		return -ENOENT;
+	if (ACPI_FAILURE(status)) {
+		ata_port_printk(ap, KERN_ERR,
+			"ACPI set timing mode failed (status=0x%x)\n", status);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/**
  * do_drive_get_GTF - get the drive bootup default taskfile settings
  * @adev: target ATA device
  * @gtf: output parameter for buffer containing _GTF taskfile arrays
@@ -354,6 +456,46 @@ static int ata_acpi_push_id(struct ata_device *adev)
 }
 
 /**
+ * ata_acpi_on_suspend - ATA ACPI hook called on suspend
+ * @ap: target ATA port
+ *
+ * This function is called when @ap is about to be suspended.  All
+ * devices are already put to sleep but the port_suspend() callback
+ * hasn't been executed yet.  Error return from this function aborts
+ * suspend.
+ *
+ * LOCKING:
+ * EH context.
+ *
+ * RETURNS:
+ * 0 on success, -errno on failure.
+ */
+int ata_acpi_on_suspend(struct ata_port *ap)
+{
+	unsigned long flags;
+	int rc;
+
+	/* proceed iff per-port acpi_handle is valid */
+	if (!ap->acpi_handle)
+		return 0;
+	BUG_ON(ap->flags & ATA_FLAG_ACPI_SATA);
+
+	/* store timing parameters */
+	rc = ata_acpi_gtm(ap, &ap->acpi_gtm);
+
+	spin_lock_irqsave(ap->lock, flags);
+	if (rc == 0)
+		ap->pflags |= ATA_PFLAG_GTM_VALID;
+	else
+		ap->pflags &= ~ATA_PFLAG_GTM_VALID;
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	if (rc == -ENOENT)
+		rc = 0;
+	return rc;
+}
+
+/**
  * ata_acpi_on_resume - ATA ACPI hook called on resume
  * @ap: target ATA port
  *
@@ -367,6 +509,13 @@ void ata_acpi_on_resume(struct ata_port *ap)
 {
 	int i;
 
+	if (ap->acpi_handle && (ap->pflags & ATA_PFLAG_GTM_VALID)) {
+		BUG_ON(ap->flags & ATA_FLAG_ACPI_SATA);
+
+		/* restore timing parameters */
+		ata_acpi_stm(ap, &ap->acpi_gtm);
+	}
+
 	/* schedule _GTF */
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
 		ap->device[i].flags |= ATA_DFLAG_ACPI_PENDING;
@@ -393,10 +542,6 @@ int ata_acpi_on_devcfg(struct ata_device *adev)
 	int acpi_sata = ap->flags & ATA_FLAG_ACPI_SATA;
 	int rc;
 
-	/* XXX: _STM isn't implemented yet, skip if IDE for now */
-	if (!acpi_sata)
-		return 0;
-
 	if (!adev->acpi_handle)
 		return 0;
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b68673b..25ee022 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2335,19 +2335,25 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
 
 	WARN_ON(ap->pflags & ATA_PFLAG_SUSPENDED);
 
+	/* tell ACPI we're suspending */
+	rc = ata_acpi_on_suspend(ap);
+	if (rc)
+		goto out;
+
 	/* suspend */
 	ata_eh_freeze_port(ap);
 
 	if (ap->ops->port_suspend)
 		rc = ap->ops->port_suspend(ap, ap->pm_mesg);
 
+ out:
 	/* report result */
 	spin_lock_irqsave(ap->lock, flags);
 
 	ap->pflags &= ~ATA_PFLAG_PM_PENDING;
 	if (rc == 0)
 		ap->pflags |= ATA_PFLAG_SUSPENDED;
-	else
+	else if (ap->pflags & ATA_PFLAG_FROZEN)
 		ata_port_schedule_eh(ap);
 
 	if (ap->pm_result) {
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index bee7cbc..ba17fc5 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -99,10 +99,12 @@ extern struct ata_port *ata_port_alloc(struct ata_host *host);
 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
 extern void ata_acpi_associate(struct ata_host *host);
+extern int ata_acpi_on_suspend(struct ata_port *ap);
 extern void ata_acpi_on_resume(struct ata_port *ap);
 extern int ata_acpi_on_devcfg(struct ata_device *adev);
 #else
 static inline void ata_acpi_associate(struct ata_host *host) { }
+static inline int ata_acpi_on_suspend(struct ata_port *ap) { return 0; }
 static inline void ata_acpi_on_resume(struct ata_port *ap) { }
 static inline int ata_acpi_on_devcfg(struct ata_device *adev) { return 0; }
 #endif
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e43edc9..806108b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -198,6 +198,7 @@ enum {
 	ATA_PFLAG_FLUSH_PORT_TASK = (1 << 16), /* flush port task */
 	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
 	ATA_PFLAG_PM_PENDING	= (1 << 18), /* PM operation pending */
+	ATA_PFLAG_GTM_VALID	= (1 << 19), /* acpi_gtm data valid */
 
 	/* struct ata_queued_cmd flags */
 	ATA_QCFLAG_ACTIVE	= (1 << 0), /* cmd not yet ack'd to scsi lyer */
@@ -512,6 +513,17 @@ struct ata_eh_context {
 	unsigned int		did_probe_mask;
 };
 
+struct ata_acpi_drive
+{
+	u32 pio;
+	u32 dma;
+} __packed;
+
+struct ata_acpi_gtm {
+	struct ata_acpi_drive drive[2];
+	u32 flags;
+} __packed;
+
 struct ata_port {
 	struct Scsi_Host	*scsi_host; /* our co-allocated scsi host */
 	const struct ata_port_operations *ops;
@@ -574,6 +586,7 @@ struct ata_port {
 
 #ifdef CONFIG_ATA_ACPI
 	acpi_handle		acpi_handle;
+	struct ata_acpi_gtm	acpi_gtm;
 #endif
 	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
 };
-- 
1.5.0.3


