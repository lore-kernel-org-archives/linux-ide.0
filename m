From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/11] libata: reimplement ACPI invocation
Date: Sat, 5 May 2007 23:50:39 +0900
Message-ID: <11783766393667-git-send-email-htejun@gmail.com>
References: <11783766373569-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <11783766373569-git-send-email-htejun@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, lenb@kernel.org, linux-acpi@vger.kernel.org, hare@suse.de, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>
List-Id: linux-ide@vger.kernel.org

This patch reimplements ACPI invocation such that, instead of
exporting ACPI details to the rest of libata, ACPI event handlers -
ata_acpi_on_resume() and ata_acpi_on_devcfg() - are used.  These two
functions are responsible for determining whether specific ACPI method
is used and when.

On resume, _GTF is scheduled by setting ATA_DFLAG_ACPI_PENDING device
flag.  This is done this way to avoid performing the action on wrong
device device (device swapping while suspended).

On every ata_dev_configure(), ata_acpi_on_devcfg() is called, which
performs _SDD and _GTF.  _GTF is performed only after resuming and, if
SATA, hardreset as the ACPI spec specifies.  As _GTF may contain
arbitrary commands, IDENTIFY page is re-read after _GTF taskfiles are
executed.

If one of ACPI methods fails, ata_acpi_on_devcfg() retries on the
first failure.  If it fails again on the second try, ACPI is disabled
on the device.  Note that successful configuration clears ACPI failed
status.

With all feature checks moved to the above two functions,
do_drive_set_taskfiles() is trivial and thus collapsed into
ata_acpi_exec_tfs(), which is now static and converted to return the
number of executed taskfiles to be used by ata_acpi_on_resume().  As
failures are handled properly, ata_acpi_push_id() now returns -errno
on errors instead of unconditional zero.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-acpi.c |  204 +++++++++++++++++++++++++++-----------------
 drivers/ata/libata-core.c |   16 ++--
 drivers/ata/libata-eh.c   |    3 +
 drivers/ata/libata.h      |   14 +--
 include/linux/libata.h    |    2 +
 5 files changed, 140 insertions(+), 99 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index ae2077e..e09df44 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -273,91 +273,47 @@ static int taskfile_load_raw(struct ata_device *dev,
 }
 
 /**
- * ata_dev_set_taskfiles - write the drive taskfile settings from _GTF
- * @dev: target ATA device
- * @gtf: pointer to array of _GTF taskfiles to execute
- * @gtf_count: number of taskfiles
- *
- * This applies to both PATA and SATA drives.
- *
- * Execute taskfiles in @gtf.
- *
- * LOCKING:
- * EH context.
- *
- * RETURNS:
- * 0 on success, -errno on failure.
- */
-static int ata_dev_set_taskfiles(struct ata_device *dev,
-				 struct ata_acpi_gtf *gtf, int gtf_count)
-{
-	struct ata_port *ap = dev->ap;
-	int ix;
-
-	if (ata_msg_probe(ap))
-		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER: port#: %d\n",
-			       __FUNCTION__, ap->port_no);
-
-	if (!(ap->flags & ATA_FLAG_ACPI_SATA))
-		return 0;
-
-	if (!ata_dev_enabled(dev) || (ap->flags & ATA_FLAG_DISABLED))
-		return -ENODEV;
-
-	/* send all TaskFile registers (0x1f1-0x1f7) *in*that*order* */
-	for (ix = 0; ix < gtf_count; ix++)
-		 taskfile_load_raw(dev, gtf++);
-
-	return 0;
-}
-
-/**
  * ata_acpi_exec_tfs - get then write drive taskfile settings
- * @ap: the ata_port for the drive
+ * @dev: target ATA device
  *
- * This applies to both PATA and SATA drives.
+ * Evaluate _GTF and excute returned taskfiles.
  *
  * LOCKING:
  * EH context.
  *
  * RETURNS:
- * 0 on success, -errno on failure.
+ * Number of executed taskfiles on success, 0 if _GTF doesn't exist or
+ * doesn't contain valid data.  -errno on other errors.
  */
-int ata_acpi_exec_tfs(struct ata_port *ap)
+static int ata_acpi_exec_tfs(struct ata_device *dev)
 {
-	int ix, ret = 0;
-
-	/*
-	 * TBD - implement PATA support.  For now,
-	 * we should not run GTF on PATA devices since some
-	 * PATA require execution of GTM/STM before GTF.
-	 */
-	if (!(ap->flags & ATA_FLAG_ACPI_SATA))
-		return 0;
-
-	for (ix = 0; ix < ATA_MAX_DEVICES; ix++) {
-		struct ata_device *dev = &ap->device[ix];
-		struct ata_acpi_gtf *gtf = NULL;
-		int gtf_count;
-		void *ptr_to_free = NULL;
-
-		if (!ata_dev_enabled(dev))
-			continue;
-
-		ret = ata_dev_get_GTF(dev, &gtf, &ptr_to_free);
-		if (ret == 0)
-			continue;
-		if (ret < 0)
-			break;
-		gtf_count = ret;
-
-		ret = ata_dev_set_taskfiles(dev, gtf, gtf_count);
-		kfree(ptr_to_free);
-		if (ret < 0)
-			break;
+	struct ata_acpi_gtf *gtf = NULL;
+	void *ptr_to_free = NULL;
+	int gtf_count, i, rc;
+
+	/* get taskfiles */
+	rc = ata_dev_get_GTF(dev, &gtf, &ptr_to_free);
+	if (rc < 0)
+		return rc;
+	gtf_count = rc;
+
+	/* execute them */
+	for (i = 0, rc = 0; i < gtf_count; i++) {
+		int tmp;
+
+		/* ACPI errors are eventually ignored.  Run till the
+		 * end even after errors.
+		 */
+		tmp = taskfile_load_raw(dev, gtf++);
+		if (!rc)
+			rc = tmp;
 	}
 
-	return ret;
+	kfree(ptr_to_free);
+
+	if (rc == 0)
+		return gtf_count;
+	return rc;
 }
 
 /**
@@ -376,7 +332,7 @@ int ata_acpi_exec_tfs(struct ata_port *ap)
  * RETURNS:
  * 0 on success, -errno on failure.
  */
-int ata_acpi_push_id(struct ata_device *dev)
+static int ata_acpi_push_id(struct ata_device *dev)
 {
 	struct ata_port *ap = dev->ap;
 	int err;
@@ -396,7 +352,7 @@ int ata_acpi_push_id(struct ata_device *dev)
 		if (ata_msg_probe(ap))
 			ata_dev_printk(dev, KERN_DEBUG,
 				"%s: Not a SATA device\n", __FUNCTION__);
-		goto out;
+		return 0;
 	}
 
 	/* Give the drive Identify data to the drive via the _SDD method */
@@ -418,9 +374,99 @@ int ata_acpi_push_id(struct ata_device *dev)
 		ata_dev_printk(dev, KERN_WARNING,
 			       "ACPI _SDD failed (AE 0x%x)\n", status);
 
-	/* always return success */
-out:
-	return 0;
+	return err;
+}
+
+/**
+ * ata_acpi_on_resume - ATA ACPI hook called on resume
+ * @ap: target ATA port
+ *
+ * This function is called when @ap is resumed - right after port
+ * itself is resumed but before any EH action is taken.
+ *
+ * LOCKING:
+ * EH context.
+ */
+void ata_acpi_on_resume(struct ata_port *ap)
+{
+	int i;
+
+	/* schedule _GTF */
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		ap->device[i].flags |= ATA_DFLAG_ACPI_PENDING;
 }
 
+/**
+ * ata_acpi_on_devcfg - ATA ACPI hook called on device donfiguration
+ * @dev: target ATA device
+ *
+ * This function is called when @dev is about to be configured.
+ * IDENTIFY data might have been modified after this hook is run.
+ *
+ * LOCKING:
+ * EH context.
+ *
+ * RETURNS:
+ * Positive number if IDENTIFY data needs to be refreshed, 0 if not,
+ * -errno on failure.
+ */
+int ata_acpi_on_devcfg(struct ata_device *dev)
+{
+	struct ata_port *ap = dev->ap;
+	struct ata_eh_context *ehc = &ap->eh_context;
+	int acpi_sata = ap->flags & ATA_FLAG_ACPI_SATA;
+	int rc;
+
+	/* XXX: _STM isn't implemented yet, skip if IDE for now */
+	if (!acpi_sata)
+		return 0;
 
+	if (!dev->acpi_handle)
+		return 0;
+
+	/* do we need to do _GTF? */
+	if (!(dev->flags & ATA_DFLAG_ACPI_PENDING) &&
+	    !(acpi_sata && (ehc->i.flags & ATA_EHI_DID_HARDRESET)))
+		return 0;
+
+	/* do _SDD if SATA */
+	if (acpi_sata) {
+		rc = ata_acpi_push_id(dev);
+		if (rc)
+			goto acpi_err;
+	}
+
+	/* do _GTF */
+	rc = ata_acpi_exec_tfs(dev);
+	if (rc < 0)
+		goto acpi_err;
+
+	dev->flags &= ~ATA_DFLAG_ACPI_PENDING;
+
+	/* refresh IDENTIFY page if any _GTF command has been executed */
+	if (rc > 0) {
+		rc = ata_dev_reread_id(dev, 0);
+		if (rc < 0) {
+			ata_dev_printk(dev, KERN_ERR, "failed to IDENTIFY "
+				       "after ACPI commands\n");
+			return rc;
+		}
+	}
+
+	return 0;
+
+ acpi_err:
+	/* let EH retry on the first failure, disable ACPI on the second */
+	if (dev->flags & ATA_DFLAG_ACPI_FAILED) {
+		ata_dev_printk(dev, KERN_WARNING, "ACPI on devcfg failed the "
+			       "second time, disabling (errno=%d)\n", rc);
+
+		dev->acpi_handle = NULL;
+
+		/* if port is working, request IDENTIFY reload and continue */
+		if (!(ap->pflags & ATA_PFLAG_FROZEN))
+			rc = 1;
+	}
+	dev->flags |= ATA_DFLAG_ACPI_FAILED;
+	return rc;
+}
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 7967ef9..d254487 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1823,7 +1823,8 @@ static void ata_dev_config_ncq(struct ata_device *dev,
 int ata_dev_configure(struct ata_device *dev)
 {
 	struct ata_port *ap = dev->ap;
-	int print_info = ap->eh_context.i.flags & ATA_EHI_PRINTINFO;
+	struct ata_eh_context *ehc = &ap->eh_context;
+	int print_info = ehc->i.flags & ATA_EHI_PRINTINFO;
 	const u16 *id = dev->id;
 	unsigned int xfer_mask;
 	char revbuf[7];		/* XYZ-99\0 */
@@ -1840,15 +1841,10 @@ int ata_dev_configure(struct ata_device *dev)
 	if (ata_msg_probe(ap))
 		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER\n", __FUNCTION__);
 
-	/* set _SDD */
-	rc = ata_acpi_push_id(dev);
-	if (rc) {
-		ata_dev_printk(dev, KERN_WARNING, "failed to set _SDD(%d)\n",
-			rc);
-	}
-
-	/* retrieve and execute the ATA task file of _GTF */
-	ata_acpi_exec_tfs(ap);
+	/* let ACPI work its magic */
+	rc = ata_acpi_on_devcfg(dev);
+	if (rc)
+		return rc;
 
 	/* print device capabilities */
 	if (ata_msg_probe(ap))
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 2bff9ad..b68673b 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2399,6 +2399,9 @@ static void ata_eh_handle_port_resume(struct ata_port *ap)
 	if (ap->ops->port_resume)
 		rc = ap->ops->port_resume(ap);
 
+	/* tell ACPI that we're resuming */
+	ata_acpi_on_resume(ap);
+
 	/* give devices time to request EH */
 	timeout = jiffies + HZ; /* 1s max */
 	while (1) {
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 29037cd..bee7cbc 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -99,18 +99,12 @@ extern struct ata_port *ata_port_alloc(struct ata_host *host);
 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
 extern void ata_acpi_associate(struct ata_host *host);
-extern int ata_acpi_exec_tfs(struct ata_port *ap);
-extern int ata_acpi_push_id(struct ata_device *dev);
+extern void ata_acpi_on_resume(struct ata_port *ap);
+extern int ata_acpi_on_devcfg(struct ata_device *adev);
 #else
 static inline void ata_acpi_associate(struct ata_host *host) { }
-static inline int ata_acpi_exec_tfs(struct ata_port *ap)
-{
-	return 0;
-}
-static inline int ata_acpi_push_id(struct ata_device *dev)
-{
-	return 0;
-}
+static inline void ata_acpi_on_resume(struct ata_port *ap) { }
+static inline int ata_acpi_on_devcfg(struct ata_device *adev) { return 0; }
 #endif
 
 /* libata-scsi.c */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9a517e6..e43edc9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -136,6 +136,8 @@ enum {
 	ATA_DFLAG_CDB_INTR	= (1 << 2), /* device asserts INTRQ when ready for CDB */
 	ATA_DFLAG_NCQ		= (1 << 3), /* device supports NCQ */
 	ATA_DFLAG_FLUSH_EXT	= (1 << 4), /* do FLUSH_EXT instead of FLUSH */
+	ATA_DFLAG_ACPI_PENDING	= (1 << 5), /* ACPI resume action pending */
+	ATA_DFLAG_ACPI_FAILED	= (1 << 6), /* ACPI on devcfg has failed */
 	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device limited to PIO mode */
-- 
1.5.0.3


