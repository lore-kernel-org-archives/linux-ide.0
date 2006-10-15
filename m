From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] libata: implement hotplug by polling
Date: Mon, 16 Oct 2006 07:37:26 +0900
Message-ID: <11609518463882-git-send-email-htejun@gmail.com>
References: <11609518461142-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:40561 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422905AbWJOWhg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 18:37:36 -0400
Received: by nf-out-0910.google.com with SMTP id c2so623440nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 15:37:34 -0700 (PDT)
In-Reply-To: <11609518461142-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
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
should indicate so by setting ATA_FLAG_HP_POLLING which tells libata
to turn on hp-poll by default.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   79 +++++++++++++++++++++++++++++
 drivers/ata/libata-eh.c   |  123 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/ata/libata.h      |    2 +
 include/linux/libata.h    |   10 ++++
 4 files changed, 211 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c127d6f..006ab12 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2909,6 +2909,76 @@ void ata_std_postreset(struct ata_port *
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
+	ap->hp_poll_data = (void *)state;
+
+	return rc;
+}
+
+/**
  *	ata_dev_same_device - Determine whether new ID matches configured device
  *	@dev: device to compare against
  *	@new_class: class of the new device
@@ -5437,6 +5507,7 @@ void ata_host_init(struct ata_host *host
 	host->dev = dev;
 	host->flags = flags;
 	host->ops = ops;
+	INIT_WORK(&host->hp_poll_task, ata_hp_poll_worker, host);
 }
 
 /**
@@ -5691,11 +5762,15 @@ void ata_port_detach(struct ata_port *ap
 
 	ata_port_wait_eh(ap);
 
-	/* Flush hotplug task.  The sequence is similar to
+	/* deactivate hotplug polling */
+	ata_hp_poll_deactivate(ap);
+
+	/* Flush hotplug tasks.  The sequence is similar to
 	 * ata_port_flush_task().
 	 */
 	flush_workqueue(ata_aux_wq);
 	cancel_delayed_work(&ap->hotplug_task);
+	cancel_delayed_work(&ap->host->hp_poll_task);
 	flush_workqueue(ata_aux_wq);
 
  skip_eh:
@@ -6129,6 +6204,8 @@ EXPORT_SYMBOL_GPL(ata_std_prereset);
 EXPORT_SYMBOL_GPL(ata_std_softreset);
 EXPORT_SYMBOL_GPL(sata_std_hardreset);
 EXPORT_SYMBOL_GPL(ata_std_postreset);
+EXPORT_SYMBOL_GPL(sata_std_hp_poll_activate);
+EXPORT_SYMBOL_GPL(sata_std_hp_poll);
 EXPORT_SYMBOL_GPL(ata_dev_revalidate);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_pair);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 02b2b27..6787fbc 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -33,6 +33,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_eh.h>
@@ -44,10 +45,17 @@ #include <linux/libata.h>
 
 #include "libata.h"
 
+static unsigned long hotplug_polling_interval = 2000;
+module_param(hotplug_polling_interval, ulong, 0644);
+MODULE_PARM_DESC(hotplug_polling_interval,
+		 "Hotplug polling interval in milliseconds (default 2000)");
+
 static void __ata_port_freeze(struct ata_port *ap);
 static void ata_eh_finish(struct ata_port *ap);
 static void ata_eh_handle_port_suspend(struct ata_port *ap);
 static void ata_eh_handle_port_resume(struct ata_port *ap);
+static void ata_hp_poll_activate(struct ata_port *ap);
+
 
 static void ata_ering_record(struct ata_ering *ering, int is_io,
 			     unsigned int err_mask)
@@ -616,7 +624,10 @@ int ata_port_freeze(struct ata_port *ap)
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
@@ -628,6 +639,8 @@ void ata_eh_freeze_port(struct ata_port 
 	if (!ap->ops->error_handler)
 		return;
 
+	ata_hp_poll_deactivate(ap);
+
 	spin_lock_irqsave(ap->lock, flags);
 	__ata_port_freeze(ap);
 	spin_unlock_irqrestore(ap->lock, flags);
@@ -637,7 +650,7 @@ void ata_eh_freeze_port(struct ata_port 
  *	ata_port_thaw_port - EH helper to thaw port
  *	@ap: ATA port to thaw
  *
- *	Thaw frozen port @ap.
+ *	Thaw frozen port @ap and activate hp-poll if necessary.
  *
  *	LOCKING:
  *	None.
@@ -658,6 +671,9 @@ void ata_eh_thaw_port(struct ata_port *a
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
+	if (ap->flags & ATA_FLAG_HP_POLLING)
+		ata_hp_poll_activate(ap);
+
 	DPRINTK("ata%u port thawed\n", ap->id);
 }
 
@@ -2059,6 +2075,9 @@ static int ata_eh_recover(struct ata_por
 
  out:
 	if (rc) {
+		/* recovery failed, activate hp-poll */
+		ata_hp_poll_activate(ap);
+
 		for (i = 0; i < ATA_MAX_DEVICES; i++)
 			ata_dev_disable(&ap->device[i]);
 	}
@@ -2247,3 +2266,103 @@ static void ata_eh_handle_port_resume(st
 	}
 	spin_unlock_irqrestore(ap->lock, flags);
 }
+
+static unsigned long ata_hp_poll_delay(void)
+{
+	unsigned long interval, now;
+
+	/* Group polls to polling interval boundaries to allow cpu to
+	 * go idle as much as possible.
+	 */
+	interval = hotplug_polling_interval * HZ / 1000;
+	now = jiffies;
+	return roundup(now + 1, interval) - now;
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
+static void ata_hp_poll_activate(struct ata_port *ap)
+{
+	unsigned long flags;
+
+	if (!ap->ops->hp_poll || (ap->pflags & ATA_PFLAG_HP_POLL))
+		return;
+
+	if (ap->ops->hp_poll_activate)
+		ap->ops->hp_poll_activate(ap);
+
+	queue_delayed_work(ata_aux_wq, &ap->host->hp_poll_task,
+			   ata_hp_poll_delay());
+	ap->hp_poll_data = 0;
+
+	spin_lock_irqsave(ap->lock, flags);
+	ap->pflags |= ATA_PFLAG_HP_POLL;
+	spin_unlock_irqrestore(ap->lock, flags);
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
+	unsigned long flags;
+
+	if (!(ap->pflags & ATA_PFLAG_HP_POLL))
+		return;
+
+	spin_lock_irqsave(ap->lock, flags);
+	ap->pflags &= ~ATA_PFLAG_HP_POLL;
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	if (ap->ops->hp_poll_deactivate)
+		ap->ops->hp_poll_deactivate(ap);
+}
+
+void ata_hp_poll_worker(void *data)
+{
+	struct ata_host *host = data;
+	int i, nr_to_poll = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+		int rc;
+
+		if (!(ap->pflags & ATA_PFLAG_HP_POLL))
+			continue;
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
+			ap->pflags &= ~ATA_PFLAG_HP_POLL;
+		} else
+			nr_to_poll++;
+	}
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (nr_to_poll)
+		queue_delayed_work(ata_aux_wq, &host->hp_poll_task,
+				   ata_hp_poll_delay());
+}
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index a5ecb71..017dc08 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -118,5 +118,7 @@ extern enum scsi_eh_timer_return ata_scs
 extern void ata_scsi_error(struct Scsi_Host *host);
 extern void ata_port_wait_eh(struct ata_port *ap);
 extern void ata_qc_schedule_eh(struct ata_queued_cmd *qc);
+extern void ata_hp_poll_worker(void *data);
+extern void ata_hp_poll_deactivate(struct ata_port *ap);
 
 #endif /* __LIBATA_H__ */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d0a7ad5..4fc74c4 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -175,6 +175,7 @@ enum {
 	ATA_FLAG_SKIP_D2H_BSY	= (1 << 12), /* can't wait for the first D2H
 					      * Register FIS clearing BSY */
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
+	ATA_FLAG_HP_POLLING	= (1 << 14), /* hotplug by polling */
 
 	/* The following flag belongs to ap->pflags but is kept in
 	 * ap->flags because it's referenced in many LLDs and will be
@@ -192,6 +193,7 @@ enum {
 	ATA_PFLAG_LOADING	= (1 << 4), /* boot/loading probe */
 	ATA_PFLAG_UNLOADING	= (1 << 5), /* module is unloading */
 	ATA_PFLAG_SCSI_HOTPLUG	= (1 << 6), /* SCSI hotplug scheduled */
+	ATA_PFLAG_HP_POLL	= (1 << 7), /* hp-poll active */
 
 	ATA_PFLAG_FLUSH_PORT_TASK = (1 << 16), /* flush port task */
 	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
@@ -401,6 +403,7 @@ struct ata_host {
 	unsigned long		flags;
 	int			simplex_claimed;	/* Keep seperate in case we
 							   ever need to do this locked */
+	struct work_struct	hp_poll_task;
 	struct ata_port		*ports[0];
 };
 
@@ -581,6 +584,7 @@ struct ata_port {
 	pm_message_t		pm_mesg;
 	int			*pm_result;
 
+	void			*hp_poll_data;
 	void			*private_data;
 
 	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
@@ -628,6 +632,10 @@ struct ata_port_operations {
 	void (*error_handler) (struct ata_port *ap);
 	void (*post_internal_cmd) (struct ata_queued_cmd *qc);
 
+	void (*hp_poll_activate) (struct ata_port *ap);
+	void (*hp_poll_deactivate) (struct ata_port *ap);
+	int (*hp_poll) (struct ata_port *ap);
+
 	irq_handler_t irq_handler;
 	void (*irq_clear) (struct ata_port *);
 
@@ -702,6 +710,8 @@ extern int ata_std_prereset(struct ata_p
 extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes);
 extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class);
 extern void ata_std_postreset(struct ata_port *ap, unsigned int *classes);
+extern void sata_std_hp_poll_activate(struct ata_port *ap);
+extern int sata_std_hp_poll(struct ata_port *ap);
 extern int ata_dev_revalidate(struct ata_device *dev, int post_reset);
 extern void ata_port_disable(struct ata_port *);
 extern void ata_std_ports(struct ata_ioports *ioaddr);
-- 
1.4.2.3


