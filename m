From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: implement ata_eh_revive()
Date: Mon, 3 Apr 2006 12:40:58 +0900
Message-ID: <11440356581251-git-send-email-htejun@gmail.com>
References: <11440356574107-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:45617 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964819AbWDCDlI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 23:41:08 -0400
Received: by zproxy.gmail.com with SMTP id o37so1664771nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 20:41:07 -0700 (PDT)
In-Reply-To: <11440356574107-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement EH helper function ata_eh_revive().  This function executes
what ata_eh_autopsy() and other parts of EH determined necessary to
resurrect the port.  As in ata_bus_probe(), each device is given fixed
number (ATA_EH_MAX_TRIES) of chances.  If a device uses up all its
chances and still fail to recover, it gets disabled.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 
 drivers/scsi/libata-eh.c   |  149 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    4 +
 3 files changed, 154 insertions(+), 0 deletions(-)

cbae2411028b7f48070809527cb1d7475635faad
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index dbf6815..62dabb1 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5282,3 +5282,4 @@ EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 EXPORT_SYMBOL_GPL(ata_eh_determine_qc);
 EXPORT_SYMBOL_GPL(ata_eh_autopsy);
 EXPORT_SYMBOL_GPL(ata_eh_report);
+EXPORT_SYMBOL_GPL(ata_eh_revive);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 7b8b2d8..3fc3f0f 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -880,3 +880,152 @@ void ata_eh_report(struct ata_port *ap, 
 	       tf->command, tf->feature, serror, action,
 	       desc_head, desc, desc_tail);
 }
+
+/**
+ *	ata_eh_revive - revive host port after error
+ *	@ap: host port to revive
+ *	@action: action to perform to revive @ap
+ *	@softreset: softreset method (can be NULL)
+ *	@hardreset: hardreset method (can be NULL)
+ *	@postreset: postreset method (can be NULL)
+ *
+ *	Perform action specified by @action to revive host port @ap
+ *	after error.
+ * *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+int ata_eh_revive(struct ata_port *ap, unsigned int action,
+		  ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
+		  ata_postreset_fn_t postreset)
+{
+	unsigned int classes[ATA_MAX_DEVICES];
+	int tries[ATA_MAX_DEVICES], reset_tries;
+	int scr_valid = ap->flags & ATA_FLAG_SATA && ap->ops->scr_read;
+	struct ata_device *dev;
+	ata_reset_fn_t reset;
+	int i, down_xfermask, rc = 0;
+
+	if (!action)
+		goto out;
+
+	reset_tries = ATA_EH_MAX_TRIES;
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		tries[i] = ATA_EH_MAX_TRIES;
+
+	/* revalidate */
+	if (action == ATA_PORT_REVALIDATE) {
+		for (i = 0; i < ATA_MAX_DEVICES; i++) {
+			struct ata_device *dev = &ap->device[i];
+			if (!ata_dev_enabled(dev) ||
+			    !(dev->flags & ATA_DFLAG_FAILED))
+				continue;
+			if (ata_dev_revalidate(ap, dev, 0))
+				break;
+		}
+		if (i == ATA_MAX_DEVICES) {
+			rc = 0;
+			goto out;
+		}
+
+		action |= ATA_PORT_SOFTRESET;
+	}
+	action &= ~ATA_PORT_REVALIDATE;
+
+	/* Give devices time to get ready before trying the first
+	 * reset.  Without this, devices tend to fail the first reset
+	 * under certain circumstances and cause much longer delay.
+	 */
+	if (scr_valid && sata_dev_present(ap)) {
+		unsigned long timeout = jiffies + 5 * HZ;
+		while (time_before(jiffies, timeout) &&
+		       ata_chk_status(ap) & ATA_BUSY)
+			ssleep(1);
+	}
+
+	if (softreset && (!hardreset || (!ata_set_sata_spd_needed(ap) &&
+					 action == ATA_PORT_SOFTRESET)))
+		reset = softreset;
+	else
+		reset = hardreset;
+
+ retry:
+	down_xfermask = 0;
+
+	/* reset.  postreset is responsible for thawing the port. */
+	printk("ata%u: %s resetting channel for error handling\n",
+	       ap->id, reset == softreset ? "soft" : "hard");
+
+	rc = ata_do_reset(ap, reset, postreset, 1, classes);
+	if (rc)
+		goto fail_reset;
+
+	/* revalidate and reconfigure devices */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		dev = &ap->device[i];
+
+		if (!tries[i])
+			ata_dev_disable(ap, dev);
+
+		if (!ata_dev_enabled(dev))
+			continue;
+
+		rc = ata_dev_revalidate(ap, dev, 1);
+		if (rc)
+			goto fail;
+	}
+
+	/* configure transfer mode */
+	rc = ata_set_mode(ap, &dev);
+	if (rc) {
+		down_xfermask = 1;
+		goto fail;
+	}
+
+	goto out;
+
+ fail_reset:
+	if (!--reset_tries)
+		goto out;
+	if (reset == hardreset)
+		ata_down_sata_spd_limit(ap);
+	if (hardreset)
+		reset = hardreset;
+
+	printk(KERN_WARNING "ata%u: reset failed, will retry in 5 secs\n",
+	       ap->id);
+	ssleep(5);
+	goto retry;
+
+ fail:
+	switch (rc) {
+	case -EINVAL:
+	case -ENODEV:
+		tries[dev->devno] = 0;
+		break;
+	case -EIO:
+		ata_down_sata_spd_limit(ap);
+	default:
+		tries[dev->devno]--;
+		if (down_xfermask &&
+		    ata_down_xfermask_limit(ap, dev, tries[dev->devno] == 1))
+			tries[dev->devno] = 0;
+	}
+
+	if (hardreset)
+		reset = hardreset;
+
+	printk(KERN_WARNING "ata%u: some devices seem to be offline, will "
+	       "retry in 5 secs\n", ap->id);
+	ssleep(5);
+	goto retry;
+
+ out:
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		dev = &ap->device[i];
+		dev->flags &= ~ATA_DFLAG_FAILED;
+		if (rc)
+			ata_dev_disable(ap, dev);
+	}
+
+	return rc;
+}
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 437c5ad..ed28a1d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -236,6 +236,7 @@ enum {
 
 	/* how hard are we gonna try to probe/recover devices */
 	ATA_PROBE_MAX_TRIES	= 3,
+	ATA_EH_MAX_TRIES	= 3,
 };
 
 enum hsm_task_states {
@@ -692,6 +693,9 @@ extern unsigned int ata_eh_autopsy(struc
 extern void ata_eh_report(struct ata_port *ap, struct ata_queued_cmd *qc,
 			  const struct ata_taskfile *tf, u32 serror,
 			  unsigned int action, const char *desc);
+extern int ata_eh_revive(struct ata_port *ap, unsigned int action,
+			 ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
+			 ata_postreset_fn_t postreset);
 
 
 static inline int
-- 
1.2.4


