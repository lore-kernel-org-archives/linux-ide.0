From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/12] libata: implement interface power management infrastructure
Date: Mon, 17 Jul 2006 15:52:32 +0900
Message-ID: <11531191522798-git-send-email-htejun@gmail.com>
References: <11531191512028-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.203]:59265 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932319AbWGQGvT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Jul 2006 02:51:19 -0400
Received: by nz-out-0102.google.com with SMTP id x7so398403nzc
        for <linux-ide@vger.kernel.org>; Sun, 16 Jul 2006 23:51:18 -0700 (PDT)
In-Reply-To: <11531191512028-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement interface power management infrastructure.  To discern link
power management from device power management (suspend/resume), link
power management is called 'powersave' or 'PS' while device power
mangement is called 'power management' or 'PM'.

libata PS infrastructure is primarily designed to accomodate SATA link
powersave (link ACTIVE/PARTIAL/SLUMBER) but is not limited to it.
libata implements the following powersave modes.

* none		: no powersave, link is powered up all the time
* HIPS		: host-initiated powersave
* DIPS		: device-initiated powersave
* static	: no powersave on occupied link, power off empty link
* HIPS/static	: HIPS on occupied link, power off empty link
* DIPS/static	: DIPS on occupied link, power off empty link

HIPS/DIPS are called dynamic PS while static is static PS.  LLD can
indicate which dynamic PS modes it supports using ATA_FLAG_HIPS and
ATA_FLAG_DIPS.  Static mode support is mandatory but LLD is free to
implement it as noop.  In fact, if LLD doesn't implement any powersave
feature, libata will automatically handle static PS as noop.

PS mode is disengaged during EH recovery and reenabled on recovery
completion.  Device configuration for DIPS is done by libata EH and
LLD only has to configure the controller when instructed via
->set_powersave() callback.

libata guarantees that there is a reset before changing PS mode.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   78 ++++++++++++++++++++++++++++-
 drivers/scsi/libata-eh.c   |  119 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |   33 ++++++++++++
 3 files changed, 228 insertions(+), 2 deletions(-)

4a08bd8677a09fb31619435a5046c9cacd8b73d2
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index cc77bd5..b968b44 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -70,6 +70,8 @@ static unsigned int ata_dev_init_params(
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_device *dev);
 
+static int ata_param_set_powersave(const char *val, struct kernel_param *kp);
+
 static DEFINE_MUTEX(ata_all_ports_mutex);
 static LIST_HEAD(ata_all_ports);
 
@@ -94,6 +96,12 @@ static int ata_probe_timeout = ATA_TMOUT
 module_param(ata_probe_timeout, int, 0444);
 MODULE_PARM_DESC(ata_probe_timeout, "Set ATA probing timeout (seconds)");
 
+static int libata_powersave = 0;	/* protected by all_ports_mutex */
+module_param_call(powersave, ata_param_set_powersave, param_get_int,
+		  &libata_powersave, 0644);
+MODULE_PARM_DESC(powersave, "Powersave mode (0=none, 1=HIPS, 2=DIPS, "
+		 "3=static, 4=HIPS/static, 5=DIPS/static)");
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
@@ -5258,6 +5266,66 @@ void ata_host_stop (struct ata_host_set 
 		iounmap(host_set->mmio_base);
 }
 
+/**
+ *	ata_param_set_powersave - param_set method for libata.powersave
+ *	@val: input value from user
+ *	@kp: kernel_param pointing to libata.powersave
+ *
+ *	This function is invoked when user writes to module parameter
+ *	node /sys/module/libata/parameters/powersave and responsible
+ *	for changing powersave configuration accordingly.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+static int ata_param_set_powersave(const char *val, struct kernel_param *kp)
+{
+	struct kernel_param tkp;
+	struct ata_port *ap;
+	int new_val, rc;
+
+	tkp = *kp;
+	tkp.arg = &new_val;
+
+	rc = param_set_int(val, &tkp);
+	if (rc)
+		return rc;
+	if (new_val == libata_powersave)
+		return 0;
+	if (new_val < 0 || new_val >= ATA_PS_NR_STATES)
+		return -EINVAL;
+
+	/* powersave state change requested */
+	mutex_lock(&ata_all_ports_mutex);
+
+	list_for_each_entry(ap, &ata_all_ports, all_ports_entry) {
+		unsigned long flags;
+
+		/* set target ps_state and schedule EH */
+		spin_lock_irqsave(ap->lock, flags);
+
+		ap->target_ps_state = new_val;
+
+		ap->eh_info.action |= ATA_EH_SOFTRESET;
+		ap->eh_info.flags |= ATA_EHI_QUIET;
+		ata_port_schedule_eh(ap);
+
+		spin_unlock_irqrestore(ap->lock, flags);
+	}
+
+	/* wait for EH */
+	list_for_each_entry(ap, &ata_all_ports, all_ports_entry)
+		ata_port_wait_eh(ap);
+
+	libata_powersave = new_val;
+
+	mutex_unlock(&ata_all_ports_mutex);
+
+	return 0;
+}
 
 /**
  *	ata_host_remove - Unregister SCSI host structure with upper layers
@@ -5536,9 +5604,13 @@ int ata_device_add(const struct ata_prob
 
 		ap = host_set->ports[i];
 
-		/* this port is active now, add it to all_ports */
+		/* This port is active now, add it to all_ports.
+		 * Initial powersave setting is also configured here
+		 * as it's protected by all_ports_mutex.
+		 */
 		mutex_lock(&ata_all_ports_mutex);
 		list_add_tail(&ap->all_ports_entry, &ata_all_ports);
+		ap->target_ps_state = libata_powersave;
 		mutex_unlock(&ata_all_ports_mutex);
 
 		/* init scontrol and sata_spd_limit to the current value */
@@ -5677,6 +5749,10 @@ void ata_port_detach(struct ata_port *ap
 	cancel_delayed_work(&ap->hotplug_task);
 	flush_workqueue(ata_aux_wq);
 
+	/* turn it off */
+	if (ap->ops->set_powersave)
+		ap->ops->set_powersave(ap, ATA_PS_STATIC);
+
 	/* this port is dead now, remove from all_ports */
 	mutex_lock(&ata_all_ports_mutex);
 	list_del_init(&ap->all_ports_entry);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 7c5217a..d5126b7 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1030,7 +1030,8 @@ static void ata_eh_analyze_serror(struct
 		err_mask |= AC_ERR_SYSTEM;
 		action |= ATA_EH_SOFTRESET;
 	}
-	if (serror & (SERR_PHYRDY_CHG | SERR_DEV_XCHG))
+	if ((serror & SERR_DEV_XCHG) ||
+	    (!ata_ps_dynamic(ap->ps_state) && (serror & SERR_PHYRDY_CHG)))
 		ata_ehi_hotplugged(&ehc->i);
 
 	ehc->i.err_mask |= err_mask;
@@ -1837,6 +1838,114 @@ static int ata_eh_resume(struct ata_port
 	return 0;
 }
 
+static unsigned int ata_dev_set_dips(struct ata_device *dev, int on)
+{
+	struct ata_taskfile tf;
+	unsigned int err_mask;
+
+	/* set up set-features taskfile */
+	DPRINTK("set features - SATA DIPS\n");
+
+	ata_tf_init(dev, &tf);
+	tf.command = ATA_CMD_SET_FEATURES;
+	if (on)
+		tf.feature = SETFEATURES_SATA_ON;
+	else
+		tf.feature = SETFEATURES_SATA_OFF;
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf.protocol = ATA_PROT_NODATA;
+	tf.nsect = SETFEATURES_SATA_DIPS;
+
+	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+
+	DPRINTK("EXIT, err_mask=%x\n", err_mask);
+	return err_mask;
+}
+
+static int ata_eh_set_powersave(struct ata_port *ap,
+				struct ata_device **r_failed_dev)
+{
+	static const char * const ps_strs[] = {
+		[ATA_PS_NONE]		= "none",
+		[ATA_PS_HIPS]		= "HIPS",
+		[ATA_PS_DIPS]		= "DIPS",
+		[ATA_PS_STATIC]		= "static",
+		[ATA_PS_HIPS_STATIC]	= "HIPS/static",
+		[ATA_PS_DIPS_STATIC]	= "DIPS/static",
+	};
+	void (*set_ps)(struct ata_port *, int) = ap->ops->set_powersave;
+	int ps_state, ps_static, ps_dynamic;
+	int dev_dips, dev_hips, i;
+
+	/* power up for recovery */
+	if (r_failed_dev == NULL) {
+		if (ap->ps_state && set_ps)
+			set_ps(ap, ATA_PS_NONE);
+		return 0;
+	}
+
+	/* determine possible ps_state */
+	ps_state = ap->target_ps_state;
+	ps_static = ata_ps_static(ps_state);
+	ps_dynamic = ata_ps_dynamic(ps_state);
+
+	dev_dips = 1;
+	dev_hips = 1;
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
+
+		if (ata_dev_ready(dev) && !ata_id_has_dips(dev->id))
+			dev_dips = 0;
+		if (ata_dev_ready(dev) && !ata_id_has_hips(dev->id))
+			dev_hips = 0;
+	}
+
+	if (ps_dynamic == ATA_PS_DIPS && (!(ap->flags & ATA_FLAG_DIPS) ||
+					  !dev_dips))
+		ps_dynamic--;
+
+	if (ps_dynamic == ATA_PS_HIPS && (!(ap->flags & ATA_FLAG_HIPS) ||
+					  !dev_hips))
+		ps_dynamic--;
+
+	ps_state = ps_static + ps_dynamic;
+
+	/* At this point, we're in ATA_PS_NONE state and DIPS setting
+	 * is unknown.  Execute the requested PS state transition.
+	 */
+	if (ps_state && set_ps)
+		set_ps(ap, ps_state);
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
+		int is_dips = ps_dynamic == ATA_PS_DIPS;
+		unsigned int err_mask;
+
+		if (!ata_dev_ready(dev) || !ata_id_has_dips(dev->id))
+			continue;
+
+		if (!!ata_id_dips_enabled(dev->id) == is_dips)
+			continue;
+
+		err_mask = ata_dev_set_dips(dev, is_dips);
+		if (err_mask) {
+			if (ps_state && set_ps)
+				set_ps(ap, ATA_PS_NONE);
+			*r_failed_dev = dev;
+			return -EIO;
+		}
+	}
+
+	if (ap->ps_state != ps_state) {
+		ata_port_printk(ap, KERN_INFO,
+				"powersave mode changed, %s -> %s\n",
+				ps_strs[ap->ps_state], ps_strs[ps_state]);
+		ap->ps_state = ps_state;
+	}
+
+	return 0;
+}
+
 static int ata_eh_skip_recovery(struct ata_port *ap)
 {
 	struct ata_eh_context *ehc = &ap->eh_context;
@@ -1901,6 +2010,9 @@ static int ata_eh_recover(struct ata_por
 
 	DPRINTK("ENTER\n");
 
+	/* power up for recovery */
+	ata_eh_set_powersave(ap, NULL);
+
 	/* prep for recovery */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		dev = &ap->device[i];
@@ -1978,6 +2090,11 @@ static int ata_eh_recover(struct ata_por
 	if (rc)
 		goto dev_fail;
 
+	/* EH complete, configure powersave mode */
+	rc = ata_eh_set_powersave(ap, &dev);
+	if (rc)
+		goto dev_fail;
+
 	goto out;
 
  dev_fail:
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1656d5b..b3f56c5 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -162,6 +162,8 @@ enum {
 	ATA_FLAG_SKIP_D2H_BSY	= (1 << 12), /* can't wait for the first D2H
 					      * Register FIS clearing BSY */
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
+	ATA_FLAG_HIPS		= (1 << 14), /* SATA host-initiated powersave */
+	ATA_FLAG_DIPS		= (1 << 15), /* SATA dev-initiated powersave */
 
 	/* The following flag belongs to ap->pflags but is kept in
 	 * ap->flags because it's referenced in many LLDs and will be
@@ -245,6 +247,15 @@ enum {
 	ATA_PORT_PRIMARY	= (1 << 0),
 	ATA_PORT_SECONDARY	= (1 << 1),
 
+	/* powersave constants */
+	ATA_PS_NONE		= 0, /* no powersave */
+	ATA_PS_HIPS		= 1, /* SATA host-initiated powersave */
+	ATA_PS_DIPS		= 2, /* SATA device-initiated powersave */
+	ATA_PS_STATIC		= 3, /* turn off unoccupied PHY */
+	ATA_PS_HIPS_STATIC	= 4, /* HIPS + STATIC */
+	ATA_PS_DIPS_STATIC	= 5, /* DIPS + STATIC */
+	ATA_PS_NR_STATES	= 6,
+
 	/* ering size */
 	ATA_ERING_SIZE		= 32,
 
@@ -554,6 +565,11 @@ struct ata_port {
 	struct list_head	eh_done_q;
 	wait_queue_head_t	eh_wait_q;
 
+	/* powersave (dynamic link power management) */
+	int			target_ps_state;
+	int			ps_state;
+
+	/* power management (host suspend and resume) */
 	pm_message_t		pm_mesg;
 	int			*pm_result;
 
@@ -613,6 +629,8 @@ struct ata_port_operations {
 	void (*scr_write) (struct ata_port *ap, unsigned int sc_reg,
 			   u32 val);
 
+	void (*set_powersave) (struct ata_port *ap, int ps_state);
+
 	int (*port_suspend) (struct ata_port *ap, pm_message_t mesg);
 	int (*port_resume) (struct ata_port *ap);
 
@@ -982,6 +1000,21 @@ static inline int ata_port_max_devices(c
 	return 1;
 }
 
+/*
+ * powersave helpers
+ */
+static inline int ata_ps_static(int ps_state)
+{
+	return ps_state >= ATA_PS_STATIC ? ATA_PS_STATIC : 0;
+}
+
+static inline int ata_ps_dynamic(int ps_state)
+{
+	if (ps_state >= ATA_PS_STATIC)
+		ps_state -= ATA_PS_STATIC;
+	return ps_state;
+}
+
 
 static inline u8 ata_chk_status(struct ata_port *ap)
 {
-- 
1.3.2


