From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/13] libata-hp: implement bootplug
Date: Fri, 12 May 2006 00:32:07 +0900
Message-ID: <11473615272605-git-send-email-htejun@gmail.com>
References: <11473615261297-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.235]:581 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030270AbWEKPcT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:32:19 -0400
Received: by wr-out-0506.google.com with SMTP id i28so165347wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:32:19 -0700 (PDT)
In-Reply-To: <11473615261297-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement bootplug - boot probing via hotplug path.  While loading,
ata_host_add() simply schedules probing and invokes EH.  After EH
completes, ata_host_add() scans and assicates them with SCSI devices.
EH path is slightly modified to handle this (e.g. no autopsy during
bootplug).  The SCSI part is left in ata_host_add() because it's
shared with legacy path and to keep probing order as before (ATA scan
all ports in host_set then attach all).

---

 drivers/scsi/libata-core.c |   58 +++++++++++++++++++++++++++++++++-----------
 drivers/scsi/libata-eh.c   |   29 +++++++++++++++-------
 2 files changed, 63 insertions(+), 24 deletions(-)

c47e6b5a71f6126e77c7aa339b4ff366d581f303
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 68e9530..17b1782 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5358,7 +5358,7 @@ static struct ata_port * ata_host_add(co
 
 	DPRINTK("ENTER\n");
 
-	if (!ent->port_ops->probe_reset &&
+	if (!ent->port_ops->probe_reset && !ent->port_ops->error_handler &&
 	    !(ent->host_flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST))) {
 		printk(KERN_ERR "ata%u: no reset mechanism available\n",
 		       port_no);
@@ -5386,6 +5386,12 @@ err_out:
 	return NULL;
 }
 
+static int ata_boot_probe_wait(void *dummy)
+{
+	schedule();
+	return 0;
+}
+
 /**
  *	ata_device_add - Register hardware device with ATA and SCSI layers
  *	@ent: Probe information describing hardware device to be registered
@@ -5404,7 +5410,6 @@ err_out:
  *	RETURNS:
  *	Number of ports registered.  Zero on error (no ports registered).
  */
-
 int ata_device_add(const struct ata_probe_ent *ent)
 {
 	unsigned int count = 0, i;
@@ -5481,19 +5486,6 @@ int ata_device_add(const struct ata_prob
 		}
 		ap->sata_spd_limit = ap->hw_sata_spd_limit;
 
-		DPRINTK("ata%u: bus probe begin\n", ap->id);
-		rc = ata_bus_probe(ap);
-		DPRINTK("ata%u: bus probe end\n", ap->id);
-
-		if (rc) {
-			/* FIXME: do something useful here?
-			 * Current libata behavior will
-			 * tear down everything when
-			 * the module is removed
-			 * or the h/w is unplugged.
-			 */
-		}
-
 		rc = scsi_add_host(ap->host, dev);
 		if (rc) {
 			ata_port_printk(ap, KERN_ERR, "scsi_add_host failed\n");
@@ -5503,6 +5495,42 @@ int ata_device_add(const struct ata_prob
 			 * at the very least
 			 */
 		}
+
+		if (!ap->ops->probe_reset) {
+			int bit = fls(ATA_FLAG_LOADING) - 1;
+			unsigned long flags;
+
+			ata_port_probe(ap);
+
+			spin_lock_irqsave(&ap->host_set->lock, flags);
+
+			ap->eh_info.probe_mask = (1 << ATA_MAX_DEVICES) - 1;
+			ap->eh_info.action |= ATA_EH_SOFTRESET;
+
+			set_bit(bit, &ap->flags);
+			ata_port_schedule_eh(ap);
+
+			spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+			wait_on_bit(&ap->flags, bit, ata_boot_probe_wait,
+				    TASK_UNINTERRUPTIBLE);
+
+			while (scsi_host_in_recovery(ap->host))
+				msleep(10);
+		} else {
+			DPRINTK("ata%u: bus probe begin\n", ap->id);
+			rc = ata_bus_probe(ap);
+			DPRINTK("ata%u: bus probe end\n", ap->id);
+
+			if (rc) {
+				/* FIXME: do something useful here?
+				 * Current libata behavior will
+				 * tear down everything when
+				 * the module is removed
+				 * or the h/w is unplugged.
+				 */
+			}
+		}
 	}
 
 	/* probes are done, now scan each port's disk(s) */
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index c787b91..694e063 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -291,11 +291,16 @@ void ata_scsi_error(struct Scsi_Host *ho
 	/* clean up */
 	spin_lock_irqsave(hs_lock, flags);
 
-	if (ap->flags & ATA_FLAG_SCSI_HOTPLUG)
-		queue_work(ata_hotplug_wq, &ap->hotplug_task);
-
-	if (ap->flags & ATA_FLAG_RECOVERED)
-		ata_port_printk(ap, KERN_INFO, "EH complete\n");
+	if (ap->flags & ATA_FLAG_LOADING) {
+		int bit = fls(ATA_FLAG_LOADING) - 1;
+		clear_bit(bit, &ap->flags);
+		wake_up_bit(&ap->flags, bit);
+	} else {
+		if (ap->flags & ATA_FLAG_SCSI_HOTPLUG)
+			queue_work(ata_hotplug_wq, &ap->hotplug_task);
+		if (ap->flags & ATA_FLAG_RECOVERED)
+			ata_port_printk(ap, KERN_INFO, "EH complete\n");
+	}
 
 	ap->flags &= ~(ATA_FLAG_SCSI_HOTPLUG | ATA_FLAG_RECOVERED);
 
@@ -1336,6 +1341,7 @@ static int ata_eh_reset(struct ata_port 
 	struct ata_eh_context *ehc = &ap->eh_context;
 	unsigned int *classes = ehc->classes;
 	int tries = ATA_EH_RESET_TRIES;
+	int verbose = !(ap->flags & ATA_FLAG_LOADING);
 	unsigned int action;
 	ata_reset_fn_t reset;
 	int i, did_followup_srst, rc;
@@ -1375,8 +1381,10 @@ static int ata_eh_reset(struct ata_port 
 	}
 
  retry:
-	ata_port_printk(ap, KERN_INFO, "%s resetting port\n",
-			reset == softreset ? "soft" : "hard");
+	/* shut up during boot probing */
+	if (verbose)
+		ata_port_printk(ap, KERN_INFO, "%s resetting port\n",
+				reset == softreset ? "soft" : "hard");
 
 	/* reset */
 	ata_eh_about_to_do(ap, ATA_EH_RESET_MASK);
@@ -1818,8 +1826,11 @@ void ata_do_eh(struct ata_port *ap, ata_
 	       ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 	       ata_postreset_fn_t postreset)
 {
-	ata_eh_autopsy(ap);
-	ata_eh_report(ap);
+	if (!(ap->flags & ATA_FLAG_LOADING)) {
+		ata_eh_autopsy(ap);
+		ata_eh_report(ap);
+	}
+
 	ata_eh_recover(ap, prereset, softreset, hardreset, postreset);
 	ata_eh_finish(ap);
 }
-- 
1.2.4


