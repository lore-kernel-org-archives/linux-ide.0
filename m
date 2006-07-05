From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] libata: implement hotplug by polling
Date: Wed, 5 Jul 2006 15:06:18 +0900
Message-ID: <11520795783315-git-send-email-htejun@gmail.com>
References: <11520795783649-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:11394 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750983AbWGEGFj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Jul 2006 02:05:39 -0400
Received: by wr-out-0506.google.com with SMTP id i28so888967wra
        for <linux-ide@vger.kernel.org>; Tue, 04 Jul 2006 23:05:38 -0700 (PDT)
In-Reply-To: <11520795783649-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This patch implements hotplug by polling - hp-poll.  It is used for

* hotplug event detection on controllers which don't provide PHY
  status changed interrupt.

* hotplug event detection on disabled ports after reset failure.
  libata used to leave such ports in frozen state to protect the
  system from malfunctioning controller/device.  With hp-poll, hotplug
  events no such ports are watched safely by polling, such that
  removing/replacing the malfunctioning device triggers EH retry on
  the port.

There are three port ops for hp-poll - hp_poll_activate, hp_poll,
hp_poll_deactivate.  Only hp_poll is mandatory for hp-poll to work.
This patch also implements SATA standard polling callbacks which poll
SError.N/X bits - sata_std_hp_poll_activate() and sata_std_hp_poll().

By default, hp-poll is enabled only on disabled ports.  If a LLD
doesn't support hotplug interrupts but can poll for hotplug events, it
should indicate it by setting ATA_FLAG_HP_POLLING which tells libata
to turn on hp-poll by default.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   82 +++++++++++++++++++++++++++
 drivers/scsi/libata-eh.c   |  134 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/scsi/libata.h      |    5 ++
 include/linux/libata.h     |   10 +++
 4 files changed, 229 insertions(+), 2 deletions(-)

fb6848884560d691fc69c6994f490d0918712eae
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 46ae4bc..3d4ea35 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2840,6 +2840,76 @@ void ata_std_postreset(struct ata_port *
 }
 
 /**
+ *	sata_std_hp_poll_activate - standard SATA hotplug polling activation
+ *	@ap: the target ata_port
+ *
+ *	Activate SATA std hotplug polling.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void sata_std_hp_poll_activate(struct ata_port *ap)
+{
+	u32 serror;
+
+	sata_scr_read(ap, SCR_ERROR, &serror);
+	serror &= SERR_PHYRDY_CHG | SERR_DEV_XCHG;
+	if (serror)
+		sata_scr_write(ap, SCR_ERROR, serror);
+
+	ap->hp_poll_data = 0;
+}
+
+/**
+ *	sata_std_hp_poll - standard SATA hotplug polling callback
+ *	@ap: the target ata_port
+ *
+ *	Poll SError.N/X for hotplug event.  Hotplug event is triggered
+ *	only after PHY stays stable for at least one full polling
+ *	interval after the first event detection.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ *
+ *	RETURNS:
+ *	1 if hotplug event has occurred, 0 otherwise.
+ */
+int sata_std_hp_poll(struct ata_port *ap)
+{
+	unsigned long state = (unsigned long)ap->hp_poll_data;
+	u32 serror;
+	int rc = 0;
+
+	sata_scr_read(ap, SCR_ERROR, &serror);
+	serror &= SERR_PHYRDY_CHG | SERR_DEV_XCHG;
+
+	switch (state) {
+	case 0:
+		if (serror) {
+			/* PHY status could be bouncing crazy due to
+			 * faulty controller or device.  Don't fire
+			 * hotplug event till hotplug event stays
+			 * quiescent for one full polling interval.
+			 */
+			sata_scr_write(ap, SCR_ERROR, serror);
+			state = 1;
+		}
+		break;
+
+	case 1:
+		if (!serror)
+			rc = 1;
+		else
+			sata_scr_write(ap, SCR_ERROR, serror);
+		break;
+	}
+
+	ap->hp_poll_data = (void *)(unsigned long)state;
+
+	return rc;
+}
+
+/**
  *	ata_dev_same_device - Determine whether new ID matches configured device
  *	@dev: device to compare against
  *	@new_class: class of the new device
@@ -5290,6 +5360,7 @@ #endif
 	INIT_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan, ap);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 	init_waitqueue_head(&ap->eh_wait_q);
+	INIT_LIST_HEAD(&ap->hp_poll_entry);
 
 	/* set cable type */
 	ap->cbl = ATA_CBL_NONE;
@@ -5586,6 +5657,9 @@ void ata_port_detach(struct ata_port *ap
 	cancel_delayed_work(&ap->hotplug_task);
 	flush_workqueue(ata_aux_wq);
 
+	/* deactivate hotplug polling */
+	ata_hp_poll_deactivate(ap);
+
 	/* remove the associated SCSI host */
 	scsi_remove_host(ap->host);
 }
@@ -5832,6 +5906,12 @@ static int __init ata_init(void)
 
 static void __exit ata_exit(void)
 {
+	/* hp_poll_list gotta be empty by now and thus hp_poll_work
+	 * isn't rearming.
+	 */
+	WARN_ON(!list_empty(&hp_poll_list));
+	cancel_delayed_work(&hp_poll_work);
+
 	destroy_workqueue(ata_wq);
 	destroy_workqueue(ata_aux_wq);
 }
@@ -5966,6 +6046,8 @@ EXPORT_SYMBOL_GPL(ata_std_prereset);
 EXPORT_SYMBOL_GPL(ata_std_softreset);
 EXPORT_SYMBOL_GPL(sata_std_hardreset);
 EXPORT_SYMBOL_GPL(ata_std_postreset);
+EXPORT_SYMBOL_GPL(sata_std_hp_poll_activate);
+EXPORT_SYMBOL_GPL(sata_std_hp_poll);
 EXPORT_SYMBOL_GPL(ata_dev_revalidate);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_pair);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 4b6aa30..bd89608 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -34,6 +34,8 @@
 
 #include <linux/config.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_eh.h>
@@ -45,6 +47,17 @@ #include <linux/libata.h>
 
 #include "libata.h"
 
+static unsigned long hotplug_polling_interval = 2000;
+module_param(hotplug_polling_interval, ulong, 0644);
+MODULE_PARM_DESC(hotplug_polling_interval,
+		 "Hotplug polling interval in milliseconds (default 2000)");
+
+static void ata_hp_poll_worker(void *data);
+
+static DEFINE_MUTEX(hp_poll_mutex);
+struct list_head hp_poll_list = LIST_HEAD_INIT(hp_poll_list);
+DECLARE_WORK(hp_poll_work, ata_hp_poll_worker, NULL);
+
 static void __ata_port_freeze(struct ata_port *ap);
 static void ata_eh_finish(struct ata_port *ap);
 static void ata_eh_handle_port_suspend(struct ata_port *ap);
@@ -617,7 +630,10 @@ int ata_port_freeze(struct ata_port *ap)
  *	ata_eh_freeze_port - EH helper to freeze port
  *	@ap: ATA port to freeze
  *
- *	Freeze @ap.
+ *	Freeze @ap.  As the 'freeze' operation means 'shutdown event
+ *	reporting', it is a perfect place to deactivate hp-poll.  Note
+ *	that ata_port_freeze() always invokes EH and eventually this
+ *	function, so deactivating hp-poll in this function is enough.
  *
  *	LOCKING:
  *	None.
@@ -629,6 +645,8 @@ void ata_eh_freeze_port(struct ata_port 
 	if (!ap->ops->error_handler)
 		return;
 
+	ata_hp_poll_deactivate(ap);
+
 	spin_lock_irqsave(ap->lock, flags);
 	__ata_port_freeze(ap);
 	spin_unlock_irqrestore(ap->lock, flags);
@@ -638,7 +656,7 @@ void ata_eh_freeze_port(struct ata_port 
  *	ata_port_thaw_port - EH helper to thaw port
  *	@ap: ATA port to thaw
  *
- *	Thaw frozen port @ap.
+ *	Thaw frozen port @ap and activate hp-poll if necessary.
  *
  *	LOCKING:
  *	None.
@@ -659,6 +677,9 @@ void ata_eh_thaw_port(struct ata_port *a
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
+	if (ap->flags & ATA_FLAG_HP_POLLING)
+		ata_hp_poll_activate(ap);
+
 	DPRINTK("ata%u port thawed\n", ap->id);
 }
 
@@ -2037,6 +2058,9 @@ static int ata_eh_recover(struct ata_por
 
  out:
 	if (rc) {
+		/* recovery failed, activate hp-poll */
+		ata_hp_poll_activate(ap);
+
 		for (i = 0; i < ATA_MAX_DEVICES; i++)
 			ata_dev_disable(&ap->device[i]);
 	}
@@ -2225,3 +2249,109 @@ static void ata_eh_handle_port_resume(st
 	}
 	spin_unlock_irqrestore(ap->lock, flags);
 }
+
+static void ata_hp_poll_worker(void *data)
+{
+	unsigned long flags = 0;	/* shut up, gcc */
+	struct ata_port *ap, *next;
+	spinlock_t *held_lock = NULL;
+
+	mutex_lock(&hp_poll_mutex);
+
+	list_for_each_entry_safe(ap, next, &hp_poll_list, hp_poll_entry) {
+		int rc;
+
+		/* Ports belonging to sharing a lock are registered
+		 * sequentially.  Cache locking.
+		 */
+		if (ap->lock != held_lock) {
+			if (held_lock)
+				spin_unlock_irqrestore(held_lock, flags);
+			spin_lock_irqsave(ap->lock, flags);
+			held_lock = ap->lock;
+		}
+
+		/* Poll.  Positive return value indicates hotplug
+		 * event while negative indicates error condition.
+		 */
+		rc = ap->ops->hp_poll(ap);
+		if (rc) {
+			if (rc > 0) {
+				ata_ehi_hotplugged(&ap->eh_info);
+				ata_port_freeze(ap);
+			}
+			list_del_init(&ap->hp_poll_entry);
+		}
+	}
+
+	if (held_lock)
+		spin_unlock_irqrestore(held_lock, flags);
+
+	if (!list_empty(&hp_poll_list))
+		schedule_delayed_work(&hp_poll_work,
+				      hotplug_polling_interval * HZ / 1000);
+
+	mutex_unlock(&hp_poll_mutex);
+}
+
+/**
+ *	ata_hp_poll_activate - activate hotplug polling
+ *	@ap: host port to activate hotplug polling for
+ *
+ *	Activate hotplug probing for @ap.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void ata_hp_poll_activate(struct ata_port *ap)
+{
+	struct list_head *pos;
+
+	if (!ap->ops->hp_poll || !list_empty(&ap->hp_poll_entry))
+		return;
+
+	if (ap->ops->hp_poll_activate)
+		ap->ops->hp_poll_activate(ap);
+
+	mutex_lock(&hp_poll_mutex);
+
+	if (list_empty(&hp_poll_list))
+		schedule_delayed_work(&hp_poll_work,
+				      hotplug_polling_interval * HZ / 1000);
+
+	/* group poll entries by lock to cache locking when polling */
+	list_for_each(pos, &hp_poll_list) {
+		struct ata_port *pos_ap =
+			list_entry(pos, struct ata_port, hp_poll_entry);
+
+		if (ap->lock == pos_ap->lock)
+			break;
+	}
+
+	list_add(&ap->hp_poll_entry, pos);
+	ap->hp_poll_data = 0;
+
+	mutex_unlock(&hp_poll_mutex);
+}
+
+/**
+ *	ata_hp_poll_deactivate - deactivate hotplug polling
+ *	@ap: host port to deactivate hotplug polling for
+ *
+ *	Deactivate hotplug probing for @ap.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void ata_hp_poll_deactivate(struct ata_port *ap)
+{
+	if (list_empty(&ap->hp_poll_entry))
+		return;
+
+	mutex_lock(&hp_poll_mutex);
+	list_del_init(&ap->hp_poll_entry);
+	mutex_unlock(&hp_poll_mutex);
+
+	if (ap->ops->hp_poll_deactivate)
+		ap->ops->hp_poll_deactivate(ap);
+}
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index c325679..3171dde 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -109,9 +109,14 @@ extern void ata_schedule_scsi_eh(struct 
 extern void ata_scsi_dev_rescan(void *data);
 
 /* libata-eh.c */
+extern struct list_head hp_poll_list;
+extern struct work_struct hp_poll_work;
+
 extern enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
 extern void ata_scsi_error(struct Scsi_Host *host);
 extern void ata_port_wait_eh(struct ata_port *ap);
 extern void ata_qc_schedule_eh(struct ata_queued_cmd *qc);
+extern void ata_hp_poll_activate(struct ata_port *ap);
+extern void ata_hp_poll_deactivate(struct ata_port *ap);
 
 #endif /* __LIBATA_H__ */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6cc497a..1609309 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -162,6 +162,7 @@ enum {
 	ATA_FLAG_SKIP_D2H_BSY	= (1 << 12), /* can't wait for the first D2H
 					      * Register FIS clearing BSY */
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
+	ATA_FLAG_HP_POLLING	= (1 << 14), /* hotplug by polling */
 
 	/* The following flag belongs to ap->pflags but is kept in
 	 * ap->flags because it's referenced in many LLDs and will be
@@ -553,6 +554,9 @@ struct ata_port {
 	pm_message_t		pm_mesg;
 	int			*pm_result;
 
+	struct list_head	hp_poll_entry;	/* hotplug poll list entry */
+	void			*hp_poll_data;
+
 	void			*private_data;
 
 	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
@@ -600,6 +604,10 @@ struct ata_port_operations {
 	void (*error_handler) (struct ata_port *ap);
 	void (*post_internal_cmd) (struct ata_queued_cmd *qc);
 
+	void (*hp_poll_activate) (struct ata_port *ap);
+	void (*hp_poll_deactivate) (struct ata_port *ap);
+	int (*hp_poll) (struct ata_port *ap);
+
 	irqreturn_t (*irq_handler)(int, void *, struct pt_regs *);
 	void (*irq_clear) (struct ata_port *);
 
@@ -667,6 +675,8 @@ extern int ata_std_prereset(struct ata_p
 extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes);
 extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class);
 extern void ata_std_postreset(struct ata_port *ap, unsigned int *classes);
+extern void sata_std_hp_poll_activate(struct ata_port *ap);
+extern int sata_std_hp_poll(struct ata_port *ap);
 extern int ata_dev_revalidate(struct ata_device *dev, int post_reset);
 extern void ata_port_disable(struct ata_port *);
 extern void ata_std_ports(struct ata_ioports *ioaddr);
-- 
1.3.2


