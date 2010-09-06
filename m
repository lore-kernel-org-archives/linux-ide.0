From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream 2/3] libata: implement cross-port EH exclusion
Date: Mon, 06 Sep 2010 17:57:14 +0200
Message-ID: <4C850F5A.7030602@gmail.com>
References: <4C850F2D.4030601@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43244 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999Ab0IFP5S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Sep 2010 11:57:18 -0400
Received: by fxm13 with SMTP id 13so2522611fxm.19
        for <linux-ide@vger.kernel.org>; Mon, 06 Sep 2010 08:57:17 -0700 (PDT)
In-Reply-To: <4C850F2D.4030601@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, yuanding02@gmail.com

In libata, the non-EH code paths should always take and release
ap->lock explicitly when accessing hardware or shared data structures.
However, once EH is active, it's assumed that the port is owned by EH
and EH methods don't explicitly take ap->lock unless race from irq
handler or other code paths are expected.  However, libata EH didn't
guarantee exclusion among EHs for ports of the same host.  IOW,
multiple EHs may execute in parallel on multiple ports of the same
controller.

In many cases, especially in SATA, the ports are completely
independent of each other and this doesn't cause problems; however,
there are cases where different ports share the same resource, which
lead to obscure timing related bugs such as the one fixed by commit
213373cf (ata_piix: fix locking around SIDPR access).

This patch implements exclusion among EHs of the same host.  When EH
begins, it acquires per-host EH ownership by calling ata_eh_acquire().
When EH finishes, the ownership is released by calling
ata_eh_release().  EH ownership is also released whenever the EH
thread goes to sleep from ata_msleep() or explicitly and reacquired
after waking up.

This ensures that while EH is actively accessing the hardware, it has
exclusive access to it while allowing EHs to interleave and progress
in parallel as they hit waiting stages, which dominate the time spent
in EH.  This achieves cross-port EH exclusion without pervasive and
fragile changes while still allowing parallel EH for the most part.

This was first reported by yuanding02@gmail.com more than three years
ago in the following bugzilla.  :-)

  https://bugzilla.kernel.org/show_bug.cgi?id=8223

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Reported-by: yuanding02@gmail.com
---
 drivers/ata/libata-core.c |   30 ++++++++++++++++++++++++++++++
 drivers/ata/libata-eh.c   |   44 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/ata/libata.h      |    2 ++
 include/linux/libata.h    |    5 +++++
 4 files changed, 80 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 77b8ca6..96f8191 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1806,8 +1806,14 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 		}
 	}

+	if (ap->ops->error_handler)
+		ata_eh_release(ap);
+
 	rc = wait_for_completion_timeout(&wait, msecs_to_jiffies(timeout));

+	if (ap->ops->error_handler)
+		ata_eh_acquire(ap);
+
 	ata_sff_flush_pio_task(ap);

 	if (!rc) {
@@ -5693,6 +5699,7 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 	dev_set_drvdata(dev, host);

 	spin_lock_init(&host->lock);
+	mutex_init(&host->eh_mutex);
 	host->dev = dev;
 	host->n_ports = max_ports;

@@ -5990,6 +5997,7 @@ void ata_host_init(struct ata_host *host, struct device *dev,
 		   unsigned long flags, struct ata_port_operations *ops)
 {
 	spin_lock_init(&host->lock);
+	mutex_init(&host->eh_mutex);
 	host->dev = dev;
 	host->flags = flags;
 	host->ops = ops;
@@ -6606,9 +6614,31 @@ int ata_ratelimit(void)
 	return __ratelimit(&ratelimit);
 }

+/**
+ *	ata_msleep - ATA EH owner aware msleep
+ *	@ap: ATA port to attribute the sleep to
+ *	@msecs: duration to sleep in milliseconds
+ *
+ *	Sleeps @msecs.  If the current task is owner of @ap's EH, the
+ *	ownership is released before going to sleep and reacquired
+ *	after the sleep is complete.  IOW, other ports sharing the
+ *	@ap->host will be allowed to own the EH while this task is
+ *	sleeping.
+ *
+ *	LOCKING:
+ *	Might sleep.
+ */
 void ata_msleep(struct ata_port *ap, unsigned int msecs)
 {
+	bool owns_eh = ap && ap->host->eh_owner == current;
+
+	if (owns_eh)
+		ata_eh_release(ap);
+
 	msleep(msecs);
+
+	if (owns_eh)
+		ata_eh_acquire(ap);
 }

 /**
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index a9b47f1..2f6d095 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -463,6 +463,41 @@ static void ata_eh_clear_action(struct ata_link *link, struct ata_device *dev,
 }

 /**
+ *	ata_eh_acquire - acquire EH ownership
+ *	@ap: ATA port to acquire EH ownership for
+ *
+ *	Acquire EH ownership for @ap.  This is the basic exclusion
+ *	mechanism for ports sharing a host.  Only one port hanging off
+ *	the same host can claim the ownership of EH.
+ *
+ *	LOCKING:
+ *	EH context.
+ */
+void ata_eh_acquire(struct ata_port *ap)
+{
+	mutex_lock(&ap->host->eh_mutex);
+	WARN_ON_ONCE(ap->host->eh_owner);
+	ap->host->eh_owner = current;
+}
+
+/**
+ *	ata_eh_release - release EH ownership
+ *	@ap: ATA port to release EH ownership for
+ *
+ *	Release EH ownership for @ap if the caller.  The caller must
+ *	have acquired EH ownership using ata_eh_acquire() previously.
+ *
+ *	LOCKING:
+ *	EH context.
+ */
+void ata_eh_release(struct ata_port *ap)
+{
+	WARN_ON_ONCE(ap->host->eh_owner != current);
+	ap->host->eh_owner = NULL;
+	mutex_unlock(&ap->host->eh_mutex);
+}
+
+/**
  *	ata_scsi_timed_out - SCSI layer time out callback
  *	@cmd: timed out SCSI command
  *
@@ -639,11 +674,13 @@ void ata_scsi_error(struct Scsi_Host *host)
 	/* If we timed raced normal completion and there is nothing to
 	   recover nr_timedout == 0 why exactly are we doing error recovery ? */

- repeat:
 	/* invoke error handler */
 	if (ap->ops->error_handler) {
 		struct ata_link *link;

+		/* acquire EH ownership */
+		ata_eh_acquire(ap);
+ repeat:
 		/* kill fast drain timer */
 		del_timer_sync(&ap->fastdrain_timer);

@@ -718,6 +755,7 @@ void ata_scsi_error(struct Scsi_Host *host)
 		host->host_eh_scheduled = 0;

 		spin_unlock_irqrestore(ap->lock, flags);
+		ata_eh_release(ap);
 	} else {
 		WARN_ON(ata_qc_from_tag(ap, ap->link.active_tag) == NULL);
 		ap->ops->eng_timeout(ap);
@@ -2817,8 +2855,10 @@ int ata_eh_reset(struct ata_link *link, int classify,
 			"reset failed (errno=%d), retrying in %u secs\n",
 			rc, DIV_ROUND_UP(jiffies_to_msecs(delta), 1000));

+		ata_eh_release(ap);
 		while (delta)
 			delta = schedule_timeout_uninterruptible(delta);
+		ata_eh_acquire(ap);
 	}

 	if (try == max_tries - 1) {
@@ -3504,8 +3544,10 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 		if (time_before_eq(deadline, now))
 			break;

+		ata_eh_release(ap);
 		deadline = wait_for_completion_timeout(&ap->park_req_pending,
 						       deadline - now);
+		ata_eh_acquire(ap);
 	} while (deadline);
 	ata_for_each_link(link, ap, EDGE) {
 		ata_for_each_dev(dev, link, ALL) {
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 142102b..d9cf380 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -145,6 +145,8 @@ extern int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 /* libata-eh.c */
 extern unsigned long ata_internal_cmd_timeout(struct ata_device *dev, u8 cmd);
 extern void ata_internal_cmd_timed_out(struct ata_device *dev, u8 cmd);
+extern void ata_eh_acquire(struct ata_port *ap);
+extern void ata_eh_release(struct ata_port *ap);
 extern enum blk_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
 extern void ata_scsi_error(struct Scsi_Host *host);
 extern void ata_port_wait_eh(struct ata_port *ap);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1da3374..1bcc603 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -37,6 +37,7 @@
 #include <scsi/scsi_host.h>
 #include <linux/acpi.h>
 #include <linux/cdrom.h>
+#include <linux/sched.h>

 /*
  * Define if arch has non-standard setup.  This is a _PCI_ standard
@@ -529,6 +530,10 @@ struct ata_host {
 	void			*private_data;
 	struct ata_port_operations *ops;
 	unsigned long		flags;
+
+	struct mutex		eh_mutex;
+	struct task_struct	*eh_owner;
+
 #ifdef CONFIG_ATA_ACPI
 	acpi_handle		acpi_handle;
 #endif
-- 
1.7.1

