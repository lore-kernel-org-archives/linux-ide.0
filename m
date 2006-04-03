From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/14] libata: implement ata_ncq_complete()
Date: Mon, 3 Apr 2006 17:32:39 +0900
Message-ID: <11440531593561-git-send-email-htejun@gmail.com>
References: <1144053158183-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.233]:59876 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751653AbWDCIcx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Apr 2006 04:32:53 -0400
Received: by wproxy.gmail.com with SMTP id i22so1247733wra
        for <linux-ide@vger.kernel.org>; Mon, 03 Apr 2006 01:32:53 -0700 (PDT)
In-Reply-To: <1144053158183-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, axboe@suse.de, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement NCQ helper function ata_ncq_complete().  This function takes
the current value of SActive, compares it against ap->sactive and
invoke ata_qc_complete() on all finished commands.  This function is
to be used by interrupt handlers implementing NCQ.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   47 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    1 +
 2 files changed, 48 insertions(+), 0 deletions(-)

429f220dc61c1d67cedbbc7da9eb9f52b20c2271
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 56637f0..fa941cc 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4574,6 +4574,52 @@ irqreturn_t ata_interrupt (int irq, void
 	return IRQ_RETVAL(handled);
 }
 
+/**
+ *	ata_ncq_complete - NCQ driver helper.  Complete requests normally.
+ *	@ap: port in question
+ *	@sactive: current SActive value
+ *
+ *	Complete in-flight commands.  One device per port is assumed.
+ *	This functions is meant to be called from low-level driver's
+ *	interrupt routine to complete requests normally.  On
+ *	invocation, if non-NCQ command was in-flight, it's completed
+ *	normally.  If NCQ commands were in-flight, cached ap->sactive
+ *	and new @sactive is compared and commands are completed
+ *	accordingly.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ *
+ *	RETURNS:
+ *	Number of completed commands on success, -errno otherwise.
+ */
+int ata_ncq_complete(struct ata_port *ap, u32 sactive)
+{
+	int nr_done = 0;
+	unsigned long done_mask = 0;
+	int i;
+
+	if (ap->sactive) {
+		done_mask = ap->sactive ^ sactive;
+
+		if (unlikely(done_mask & sactive)) {
+			printk(KERN_ERR "ata%u: illegal sactive transition "
+			       "(%08x->%08x)\n", ap->id, ap->sactive, sactive);
+			return -EINVAL;
+		}
+	} else if (ap->active_tag != ATA_TAG_POISON)
+		done_mask = 1 << ap->active_tag;
+
+	for (i = 0; i < ATA_MAX_QUEUE; i++) {
+		struct ata_queued_cmd *qc = ata_qc_from_tag(ap, i);
+		if (done_mask & (1 << i) && qc) {
+			ata_qc_complete(qc);
+			nr_done++;
+		}
+	}
+
+	return nr_done;
+}
 
 /*
  * Execute a 'simple' command, that only consists of the opcode 'cmd' itself,
@@ -5300,6 +5346,7 @@ EXPORT_SYMBOL_GPL(ata_scsi_slave_config)
 EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
 EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
+EXPORT_SYMBOL_GPL(ata_ncq_complete);
 EXPORT_SYMBOL_GPL(ata_id_string);
 EXPORT_SYMBOL_GPL(ata_id_c_string);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9ae1f03..b9abfb3 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -580,6 +580,7 @@ extern int ata_scsi_ioctl(struct scsi_de
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
 extern int ata_scsi_release(struct Scsi_Host *host);
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
+extern int ata_ncq_complete(struct ata_port *ap, u32 sactive);
 extern int ata_scsi_device_resume(struct scsi_device *);
 extern int ata_scsi_device_suspend(struct scsi_device *, pm_message_t state);
 extern int ata_device_resume(struct ata_port *, struct ata_device *);
-- 
1.2.4


