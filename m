From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/14] libata-eh: implement ata_eh_revive()
Date: Tue, 11 Apr 2006 22:48:22 +0900
Message-ID: <11447633023982-git-send-email-htejun@gmail.com>
References: <11447633013561-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.225]:12958 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750940AbWDKNs2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:48:28 -0400
Received: by wproxy.gmail.com with SMTP id i11so926518wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:48:28 -0700 (PDT)
In-Reply-To: <11447633013561-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement EH helper function ata_eh_revive().  This function executes
what ata_eh_autopsy() and other parts of EH determined necessary to
resurrect the port.  As in ata_bus_probe(), each device is given fixed
number (ATA_EH_MAX_TRIES) of chances.  If a device uses up all its
chances and still fail to recover, it gets disabled.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 
 drivers/scsi/libata-eh.c   |  206 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    4 +
 3 files changed, 211 insertions(+), 0 deletions(-)

98acfd8b52af7a85887b7a38cadb9267a808bebc
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index e724a76..cb174cf 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5345,3 +5345,4 @@ EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 EXPORT_SYMBOL_GPL(ata_eh_determine_qc);
 EXPORT_SYMBOL_GPL(ata_eh_autopsy);
 EXPORT_SYMBOL_GPL(ata_eh_report);
+EXPORT_SYMBOL_GPL(ata_eh_revive);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index eebb165..1d25d55 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -918,3 +918,209 @@ void ata_eh_report(struct ata_port *ap, 
 	       tf->command, tf->feature, serror, action,
 	       desc_head, desc, desc_tail);
 }
+
+static void ata_eh_wait_before_reset(struct ata_port *ap)
+{
+	int scr_valid = ap->cbl == ATA_CBL_SATA && ap->ops->scr_read;
+	unsigned long timeout;
+
+	/* Give devices time to get ready before trying the first
+	 * reset.  Without this, devices tend to fail the first reset
+	 * under certain circumstances and cause much longer delay.
+	 */
+	timeout = jiffies + 5 * HZ;
+	ssleep(1);
+
+	if (scr_valid) {
+		while (time_before(jiffies, timeout)) {
+			if ((scr_read(ap, SCR_STATUS) & 0xf) != 0x1)
+				break;
+			msleep(100);
+		}
+	}
+
+	if (!scr_valid || sata_dev_present(ap)) {
+		while (time_before(jiffies, timeout)) {
+			if (!(ata_chk_status(ap) & ATA_BUSY))
+				break;
+			msleep(100);
+		}
+	}
+}
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
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+int ata_eh_revive(struct ata_port *ap, unsigned int action,
+		  ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
+		  ata_postreset_fn_t postreset)
+{
+	int scr_valid = ap->cbl == ATA_CBL_SATA && ap->ops->scr_read;
+	unsigned int classes[ATA_MAX_DEVICES];
+	int tries[ATA_MAX_DEVICES], reset_tries, nr_enabled;
+	struct ata_device *dev;
+	ata_reset_fn_t reset;
+	int i, down_xfermask, rc = 0;
+
+	if (!action)
+		goto out;
+
+	reset_tries = ATA_EH_MAX_TRIES;
+	nr_enabled = 0;
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		tries[i] = ATA_EH_MAX_TRIES;
+		if (ata_dev_enabled(&ap->device[i]))
+			nr_enabled++;
+	}
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
+	/* Skip reset if possible. */
+	if (!nr_enabled && !(ap->flags & ATA_FLAG_FROZEN))
+		goto out;
+
+	/* give devices some time to breath */
+	ata_eh_wait_before_reset(ap);
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
+	rc = ata_do_reset(ap, reset, postreset, classes);
+	if (rc)
+		goto fail_reset;
+
+	/* revalidate and reconfigure devices */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		dev = &ap->device[i];
+
+		if (!ata_dev_enabled(dev))
+			continue;
+
+		if (scr_valid && !sata_dev_present(ap)) {
+			rc = -EIO;
+			goto fail;
+		}
+
+		rc = ata_dev_revalidate(ap, dev, 1);
+		if (rc)
+			goto fail;
+	}
+
+	/* configure transfer mode */
+	if (ap->ops->set_mode) {
+		/* FIXME: make ->set_mode handle no device case and
+		 * return error code and failing device on failure as
+		 * ata_set_mode() does.
+		 */
+		for (i = 0; i < ATA_MAX_DEVICES; i++)
+			if (ata_dev_enabled(&ap->device[i])) {
+				ap->ops->set_mode(ap);
+				break;
+			}
+		rc = 0;
+	} else
+		rc = ata_set_mode(ap, &dev);
+
+	if (rc) {
+		down_xfermask = 1;
+		goto fail;
+	}
+
+	goto out;
+
+ fail_reset:
+	if (!--reset_tries) {
+		printk(KERN_ERR "ata%u: EH reset failed, giving up\n", ap->id);
+		goto out;
+	}
+	if (reset == hardreset)
+		ata_down_sata_spd_limit(ap);
+	if (hardreset)
+		reset = hardreset;
+
+	printk(KERN_WARNING "ata%u: EH reset failed, will retry in 5 secs\n",
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
+	if (!tries[dev->devno]) {
+		ata_dev_disable(ap, dev);
+		nr_enabled--;
+	}
+
+	if (nr_enabled) {
+		printk(KERN_WARNING "ata%u: some devices seem to be offline, "
+		       "will retry in 5 secs\n", ap->id);
+		ssleep(5);
+	} else {
+		/* no device left, repeat fast */
+		msleep(500);
+	}
+
+	if (hardreset)
+		reset = hardreset;
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
index 5efadab..22472f6 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -238,6 +238,7 @@ enum {
 
 	/* how hard are we gonna try to probe/recover devices */
 	ATA_PROBE_MAX_TRIES	= 3,
+	ATA_EH_MAX_TRIES	= 3,
 };
 
 enum hsm_task_states {
@@ -696,6 +697,9 @@ extern unsigned int ata_eh_autopsy(struc
 extern void ata_eh_report(struct ata_port *ap, struct ata_queued_cmd *qc,
 			  const struct ata_taskfile *tf, u32 serror,
 			  unsigned int action, const char *desc);
+extern int ata_eh_revive(struct ata_port *ap, unsigned int action,
+			 ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
+			 ata_postreset_fn_t postreset);
 
 
 static inline int
-- 
1.2.4


