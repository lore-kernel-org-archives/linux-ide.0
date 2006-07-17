From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] libata: implement hotplug by polling
Date: Mon, 17 Jul 2006 16:00:48 +0900
Message-ID: <11531196481023-git-send-email-htejun@gmail.com>
References: <11531196483920-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:54135 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932355AbWGQG7b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Jul 2006 02:59:31 -0400
Received: by py-out-1112.google.com with SMTP id x31so3890186pye
        for <linux-ide@vger.kernel.org>; Sun, 16 Jul 2006 23:59:30 -0700 (PDT)
In-Reply-To: <11531196483920-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
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

Putting port into any static powersave mode or setting
libata.hotplug_polling_interval to zero disables hp-poll.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   92 ++++++++++++++++++++++++++++
 drivers/scsi/libata-eh.c   |  143 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/scsi/libata.h      |    5 ++
 include/linux/libata.h     |   10 +++
 4 files changed, 246 insertions(+), 4 deletions(-)

5cc3fdf67263ca76fc930ab9400a26fb637b18ae
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 9890387..f1db8d4 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3082,6 +3082,86 @@ void sata_std_set_powersave(struct ata_p
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
+	u32 serror, mask;
+
+	/* watch .X and, if not in dynamic powersave, .N */
+	mask = SERR_DEV_XCHG;
+	if (ata_ps_dynamic(ap->ps_state) == ATA_PS_NONE)
+		mask |= SERR_PHYRDY_CHG;
+
+	sata_scr_read(ap, SCR_ERROR, &serror);
+	serror &= mask;
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
+	u32 serror, mask;
+	int rc = 0;
+
+	/* watch .X and, if not in dynamic powersave, .N */
+	mask = SERR_DEV_XCHG;
+	if (ata_ps_dynamic(ap->ps_state) == ATA_PS_NONE)
+		mask |= SERR_PHYRDY_CHG;
+
+	sata_scr_read(ap, SCR_ERROR, &serror);
+	serror &= mask;
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
@@ -5798,6 +5878,7 @@ #endif
 	INIT_LIST_HEAD(&ap->eh_done_q);
 	init_waitqueue_head(&ap->eh_wait_q);
 	setup_timer(&ap->ps_timer, ata_ps_timer_worker, (unsigned long)ap);
+	INIT_LIST_HEAD(&ap->hp_poll_entry);
 
 	/* set cable type */
 	ap->cbl = ATA_CBL_NONE;
@@ -6119,6 +6200,9 @@ void ata_port_detach(struct ata_port *ap
 	list_del_init(&ap->all_ports_entry);
 	mutex_unlock(&ata_all_ports_mutex);
 
+	/* deactivate hotplug polling */
+	ata_hp_poll_deactivate(ap);
+
 	/* remove the associated SCSI host */
 	scsi_remove_host(ap->host);
 }
@@ -6365,6 +6449,12 @@ static int __init ata_init(void)
 
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
@@ -6504,6 +6594,8 @@ EXPORT_SYMBOL_GPL(sata_std_hips_timer_fn
 EXPORT_SYMBOL_GPL(sata_do_set_powersave);
 EXPORT_SYMBOL_GPL(sata_determine_hips_params);
 EXPORT_SYMBOL_GPL(sata_std_set_powersave);
+EXPORT_SYMBOL_GPL(sata_std_hp_poll_activate);
+EXPORT_SYMBOL_GPL(sata_std_hp_poll);
 EXPORT_SYMBOL_GPL(ata_dev_revalidate);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_pair);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index b19eaae..f9d9bb7 100644
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
+MODULE_PARM_DESC(hotplug_polling_interval, "Hotplug polling interval "
+		 "(milliseconds, default 2000, 0 to disable)");
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
@@ -628,7 +641,10 @@ int ata_port_freeze(struct ata_port *ap)
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
@@ -640,6 +656,8 @@ void ata_eh_freeze_port(struct ata_port 
 	if (!ap->ops->error_handler)
 		return;
 
+	ata_hp_poll_deactivate(ap);
+
 	spin_lock_irqsave(ap->lock, flags);
 	__ata_port_freeze(ap);
 	spin_unlock_irqrestore(ap->lock, flags);
@@ -649,7 +667,7 @@ void ata_eh_freeze_port(struct ata_port 
  *	ata_port_thaw_port - EH helper to thaw port
  *	@ap: ATA port to thaw
  *
- *	Thaw frozen port @ap.
+ *	Thaw frozen port @ap and activate hp-poll if necessary.
  *
  *	LOCKING:
  *	None.
@@ -670,6 +688,9 @@ void ata_eh_thaw_port(struct ata_port *a
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
+	if (ap->flags & ATA_FLAG_HP_POLLING)
+		ata_hp_poll_activate(ap);
+
 	DPRINTK("ata%u port thawed\n", ap->id);
 }
 
@@ -1926,8 +1947,12 @@ static int ata_eh_set_powersave(struct a
 	/* At this point, we're in ATA_PS_NONE state and DIPS setting
 	 * is unknown.  Execute the requested PS state transition.
 	 */
-	if (ps_state && set_ps)
-		set_ps(ap, ps_state);
+	if (ps_state) {
+		if (set_ps)
+			set_ps(ap, ps_state);
+		if (ata_ps_static(ps_state))
+			ata_hp_poll_deactivate(ap);
+	}
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
@@ -2172,6 +2197,9 @@ static int ata_eh_recover(struct ata_por
 
  out:
 	if (rc) {
+		/* recovery failed, activate hp-poll */
+		ata_hp_poll_activate(ap);
+
 		for (i = 0; i < ATA_MAX_DEVICES; i++)
 			ata_dev_disable(&ap->device[i]);
 	}
@@ -2360,3 +2388,110 @@ static void ata_eh_handle_port_resume(st
 	}
 	spin_unlock_irqrestore(ap->lock, flags);
 }
+
+static void ata_hp_poll_worker(void *data)
+{
+	unsigned long interval = msec_to_jiffies(hotplug_polling_interval);
+	unsigned long flags = 0;	/* shut up, gcc */
+	struct ata_port *ap, *next;
+	spinlock_t *held_lock = NULL;
+
+	mutex_lock(&hp_poll_mutex);
+
+	list_for_each_entry_safe(ap, next, &hp_poll_list, hp_poll_entry) {
+		int rc;
+
+		/* Ports sharing a lock are registered sequentially.
+		 * Cache locking.
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
+	if (!list_empty(&hp_poll_list) && interval)
+		schedule_delayed_work(&hp_poll_work, interval);
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
+	unsigned long interval = msec_to_jiffies(hotplug_polling_interval);
+	struct list_head *pos;
+
+	if (!ap->ops->hp_poll || !hotplug_polling_interval ||
+	    !list_empty(&ap->hp_poll_entry))
+		return;
+
+	if (ap->ops->hp_poll_activate)
+		ap->ops->hp_poll_activate(ap);
+
+	mutex_lock(&hp_poll_mutex);
+
+	if (list_empty(&hp_poll_list) && interval)
+		schedule_delayed_work(&hp_poll_work, interval);
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
index 9e44f56..bc71b3f 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -118,9 +118,14 @@ extern void ata_schedule_scsi_eh(struct 
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
index b8bee5f..39d6186 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -164,6 +164,7 @@ enum {
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
 	ATA_FLAG_HIPS		= (1 << 14), /* SATA host-initiated powersave */
 	ATA_FLAG_DIPS		= (1 << 15), /* SATA dev-initiated powersave */
+	ATA_FLAG_HP_POLLING	= (1 << 16), /* hotplug by polling */
 
 	/* The following flag belongs to ap->pflags but is kept in
 	 * ap->flags because it's referenced in many LLDs and will be
@@ -586,6 +587,9 @@ struct ata_port {
 
 	struct list_head	all_ports_entry;
 
+	struct list_head	hp_poll_entry;	/* hotplug poll list entry */
+	void			*hp_poll_data;
+
 	void			*private_data;
 
 	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
@@ -633,6 +637,10 @@ struct ata_port_operations {
 	void (*error_handler) (struct ata_port *ap);
 	void (*post_internal_cmd) (struct ata_queued_cmd *qc);
 
+	void (*hp_poll_activate) (struct ata_port *ap);
+	void (*hp_poll_deactivate) (struct ata_port *ap);
+	int (*hp_poll) (struct ata_port *ap);
+
 	irqreturn_t (*irq_handler)(int, void *, struct pt_regs *);
 	void (*irq_clear) (struct ata_port *);
 
@@ -702,6 +710,8 @@ extern int ata_std_prereset(struct ata_p
 extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes);
 extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class);
 extern void ata_std_postreset(struct ata_port *ap, unsigned int *classes);
+extern void sata_std_hp_poll_activate(struct ata_port *ap);
+extern int sata_std_hp_poll(struct ata_port *ap);
 extern unsigned long sata_do_hips_timer_fn(struct ata_port *ap, int seq,
 			u8 sctl_ipm, ata_update_sctl_spm_fn_t update_sctl_spm);
 extern unsigned long sata_std_hips_timer_fn(struct ata_port *ap, int seq);
-- 
1.3.2


