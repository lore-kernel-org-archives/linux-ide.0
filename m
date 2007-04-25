From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 1/3] libata: implement hotplug by polling
Date: Tue, 24 Apr 2007 23:28:18 -0700
Message-ID: <20070425062818.GA7846@curie-int.orbis-terrarum.net>
References: <20070425062538.GU7810@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b01.ext.isohunt.com ([208.71.112.51]:38822 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423223AbXDYG2I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Apr 2007 02:28:08 -0400
Content-Disposition: inline
In-Reply-To: <20070425062538.GU7810@curie-int.orbis-terrarum.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: htejun@gmail.com, robbat2@gentoo.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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

(This revision contains cleanups that prevent the original patch from worki=
ng
on newer kernels - robbat2).

Signed-off-by: Tejun Heo <htejun@gmail.com>
Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 drivers/ata/libata-core.c |   80 +++++++++++++++++++++++++++++-
 drivers/ata/libata-eh.c   |  122 +++++++++++++++++++++++++++++++++++++++++=
+++-
 drivers/ata/libata.h      |    2 +
 include/linux/libata.h    |   11 ++++
 4 files changed, 212 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6d0a946..68ea34b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3498,6 +3498,76 @@ void ata_std_postreset(struct ata_port *ap, unsigned=
 int *classes)
 }
=20
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
+	serror &=3D SERR_PHYRDY_CHG | SERR_DEV_XCHG;
+	if (serror)
+		sata_scr_write(ap, SCR_ERROR, serror);
+
+	ap->hp_poll_data =3D 0;
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
+	unsigned long state =3D (unsigned long)ap->hp_poll_data;
+	u32 serror;
+	int rc =3D 0;
+
+	sata_scr_read(ap, SCR_ERROR, &serror);
+	serror &=3D SERR_PHYRDY_CHG | SERR_DEV_XCHG;
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
+			state =3D 1;
+		}
+		break;
+
+	case 1:
+		if (!serror)
+			rc =3D 1;
+		else
+			sata_scr_write(ap, SCR_ERROR, serror);
+		break;
+	}
+
+	ap->hp_poll_data =3D (void *)state;
+
+	return rc;
+}
+
+/**
  *	ata_dev_same_device - Determine whether new ID matches configured device
  *	@dev: device to compare against
  *	@new_class: class of the new device
@@ -6160,6 +6230,7 @@ void ata_host_init(struct ata_host *host, struct devi=
ce *dev,
 	host->dev =3D dev;
 	host->flags =3D flags;
 	host->ops =3D ops;
+	INIT_DELAYED_WORK(&host->hp_poll_task, ata_hp_poll_worker);
 }
=20
 /**
@@ -6387,11 +6458,15 @@ void ata_port_detach(struct ata_port *ap)
=20
 	ata_port_wait_eh(ap);
=20
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
=20
  skip_eh:
@@ -6752,6 +6827,9 @@ EXPORT_SYMBOL_GPL(ata_std_softreset);
 EXPORT_SYMBOL_GPL(sata_port_hardreset);
 EXPORT_SYMBOL_GPL(sata_std_hardreset);
 EXPORT_SYMBOL_GPL(ata_std_postreset);
+EXPORT_SYMBOL_GPL(sata_std_hp_poll_activate);
+EXPORT_SYMBOL_GPL(sata_std_hp_poll);
+EXPORT_SYMBOL_GPL(ata_dev_revalidate);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_pair);
 EXPORT_SYMBOL_GPL(ata_port_disable);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 0dbee55..d70aa04 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -33,6 +33,7 @@
  */
=20
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_eh.h>
@@ -49,6 +50,10 @@ enum {
 	ATA_EH_SPDN_SPEED_DOWN		=3D (1 << 1),
 	ATA_EH_SPDN_FALLBACK_TO_PIO	=3D (1 << 2),
 };
+static unsigned long hotplug_polling_interval =3D 2000;
+module_param(hotplug_polling_interval, ulong, 0644);
+MODULE_PARM_DESC(hotplug_polling_interval,
+		 "Hotplug polling interval in milliseconds (default 2000)");
=20
 static void __ata_port_freeze(struct ata_port *ap);
 static void ata_eh_finish(struct ata_port *ap);
@@ -62,6 +67,7 @@ static int ata_eh_resume(struct ata_port *ap, struct ata_=
device **r_failed_dev);
 #else /* CONFIG_PM */
 static void ata_eh_handle_port_suspend(struct ata_port *ap)
 { }
+static void ata_hp_poll_activate(struct ata_port *ap);
=20
 static void ata_eh_handle_port_resume(struct ata_port *ap)
 { }
@@ -644,7 +650,10 @@ int ata_port_freeze(struct ata_port *ap)
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
@@ -656,6 +665,8 @@ void ata_eh_freeze_port(struct ata_port *ap)
 	if (!ap->ops->error_handler)
 		return;
=20
+	ata_hp_poll_deactivate(ap);
+
 	spin_lock_irqsave(ap->lock, flags);
 	__ata_port_freeze(ap);
 	spin_unlock_irqrestore(ap->lock, flags);
@@ -665,7 +676,7 @@ void ata_eh_freeze_port(struct ata_port *ap)
  *	ata_port_thaw_port - EH helper to thaw port
  *	@ap: ATA port to thaw
  *
- *	Thaw frozen port @ap.
+ *	Thaw frozen port @ap and activate hp-poll if necessary.
  *
  *	LOCKING:
  *	None.
@@ -686,6 +697,9 @@ void ata_eh_thaw_port(struct ata_port *ap)
=20
 	spin_unlock_irqrestore(ap->lock, flags);
=20
+	if (ap->flags & ATA_FLAG_HP_POLLING)
+		ata_hp_poll_activate(ap);
+
 	DPRINTK("ata%u port thawed\n", ap->print_id);
 }
=20
@@ -2229,6 +2243,9 @@ static int ata_eh_recover(struct ata_port *ap, ata_pr=
ereset_fn_t prereset,
=20
  out:
 	if (rc) {
+		/* recovery failed, activate hp-poll */
+		ata_hp_poll_activate(ap);
+
 		for (i =3D 0; i < ATA_MAX_DEVICES; i++)
 			ata_dev_disable(&ap->device[i]);
 	}
@@ -2419,3 +2436,104 @@ static void ata_eh_handle_port_resume(struct ata_po=
rt *ap)
 	spin_unlock_irqrestore(ap->lock, flags);
 }
 #endif /* CONFIG_PM */
+
+static unsigned long ata_hp_poll_delay(void)
+{
+	unsigned long interval, now;
+
+	/* Group polls to polling interval boundaries to allow cpu to
+	 * go idle as much as possible.
+	 */
+	interval =3D hotplug_polling_interval * HZ / 1000;
+	now =3D jiffies;
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
+	ap->hp_poll_data =3D 0;
+
+	spin_lock_irqsave(ap->lock, flags);
+	ap->pflags |=3D ATA_PFLAG_HP_POLL;
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
+	ap->pflags &=3D ~ATA_PFLAG_HP_POLL;
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	if (ap->ops->hp_poll_deactivate)
+		ap->ops->hp_poll_deactivate(ap);
+}
+
+void ata_hp_poll_worker(struct work_struct *work)
+{
+	struct ata_host *host =3D
+		container_of(work, struct ata_host, hp_poll_task.work);
+	int i, nr_to_poll =3D 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	for (i =3D 0; i < host->n_ports; i++) {
+		struct ata_port *ap =3D host->ports[i];
+		int rc;
+
+		if (!(ap->pflags & ATA_PFLAG_HP_POLL))
+			continue;
+
+		/* Poll.  Positive return value indicates hotplug
+		 * event while negative indicates error condition.
+		 */
+		rc =3D ap->ops->hp_poll(ap);
+		if (rc) {
+			if (rc > 0) {
+				ata_ehi_hotplugged(&ap->eh_info);
+				ata_port_freeze(ap);
+			}
+			ap->pflags &=3D ~ATA_PFLAG_HP_POLL;
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
index 5f4d40c..52377dd 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -153,6 +153,8 @@ extern enum scsi_eh_timer_return ata_scsi_timed_out(str=
uct scsi_cmnd *cmd);
 extern void ata_scsi_error(struct Scsi_Host *host);
 extern void ata_port_wait_eh(struct ata_port *ap);
 extern void ata_qc_schedule_eh(struct ata_queued_cmd *qc);
+extern void ata_hp_poll_worker(struct work_struct *work);
+extern void ata_hp_poll_deactivate(struct ata_port *ap);
=20
 /* libata-sff.c */
 extern u8 ata_irq_on(struct ata_port *ap);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 73b86dd..0fd2a8b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -174,6 +174,7 @@ enum {
 	ATA_FLAG_SETXFER_POLLING=3D (1 << 14), /* use polling for SETXFER */
 	ATA_FLAG_IGN_SIMPLEX	=3D (1 << 15), /* ignore SIMPLEX */
 	ATA_FLAG_NO_IORDY	=3D (1 << 16), /* controller lacks iordy */
+	ATA_FLAG_HP_POLLING	=3D (1 << 17), /* hotplug by polling */
=20
 	/* The following flag belongs to ap->pflags but is kept in
 	 * ap->flags because it's referenced in many LLDs and will be
@@ -191,6 +192,7 @@ enum {
 	ATA_PFLAG_LOADING	=3D (1 << 4), /* boot/loading probe */
 	ATA_PFLAG_UNLOADING	=3D (1 << 5), /* module is unloading */
 	ATA_PFLAG_SCSI_HOTPLUG	=3D (1 << 6), /* SCSI hotplug scheduled */
+	ATA_PFLAG_HP_POLL	=3D (1 << 7), /* hp-poll active */
=20
 	ATA_PFLAG_FLUSH_PORT_TASK =3D (1 << 16), /* flush port task */
 	ATA_PFLAG_SUSPENDED	=3D (1 << 17), /* port is suspended (power) */
@@ -379,6 +381,7 @@ struct ata_host {
 	const struct ata_port_operations *ops;
 	unsigned long		flags;
 	struct ata_port		*simplex_claimed;	/* channel owning the DMA */
+	struct delayed_work	hp_poll_task;
 	struct ata_port		*ports[0];
 };
=20
@@ -564,6 +567,7 @@ struct ata_port {
 	pm_message_t		pm_mesg;
 	int			*pm_result;
=20
+	void			*hp_poll_data;
 	void			*private_data;
=20
 	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
@@ -613,6 +617,10 @@ struct ata_port_operations {
 	void (*error_handler) (struct ata_port *ap);
 	void (*post_internal_cmd) (struct ata_queued_cmd *qc);
=20
+	void (*hp_poll_activate) (struct ata_port *ap);
+	void (*hp_poll_deactivate) (struct ata_port *ap);
+	int (*hp_poll) (struct ata_port *ap);
+
 	irq_handler_t irq_handler;
 	void (*irq_clear) (struct ata_port *);
 	u8 (*irq_on) (struct ata_port *);
@@ -694,6 +702,9 @@ extern int sata_port_hardreset(struct ata_port *ap,
 			       const unsigned long *timing);
 extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class);
 extern void ata_std_postreset(struct ata_port *ap, unsigned int *classes);
+extern void sata_std_hp_poll_activate(struct ata_port *ap);
+extern int sata_std_hp_poll(struct ata_port *ap);
+extern int ata_dev_revalidate(struct ata_device *dev, unsigned int flags);
 extern void ata_port_disable(struct ata_port *);
 extern void ata_std_ports(struct ata_ioports *ioaddr);
 #ifdef CONFIG_PCI



--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGLvUCPpIsIjIzwiwRAsZJAJ9NfLDTNsmZ1n0XaglV/SFgqKol9ACgqn4T
LwCjTBb9RpcVDCy186Ch3qI=
=rWXb
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
