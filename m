From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/12] libata: implement standard powersave methods
Date: Mon, 17 Jul 2006 15:52:32 +0900
Message-ID: <11531191524049-git-send-email-htejun@gmail.com>
References: <11531191512028-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.202]:36985 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932322AbWGQGvT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Jul 2006 02:51:19 -0400
Received: by nz-out-0102.google.com with SMTP id x7so398401nzc
        for <linux-ide@vger.kernel.org>; Sun, 16 Jul 2006 23:51:18 -0700 (PDT)
In-Reply-To: <11531191512028-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement helpers to build SATA ->set_powersave() and HIPS timer, and
use them to implement sata_std_set_powersave() and
sata_std_hips_timer_fn() for standard SATA link powersave using
SControl register.

Depending on controller capability, the following modes are supported.

none:		no powersave
HIPS:		host-initiated partial/slumber (both or either one)
DIPS:		device-initiated partial/slumber (both or either one)
static:		link off by writing 0x4 to DET
HIPS/static:	HIPS + static
DIPS/static;	DIPS + static

Timeouts for HIPS can be modified using module parameters -
libata.partial_timeout and libata.slumber_timeout.  Setting timeout to
zero disables the powersave mode.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |  280 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |   10 ++
 2 files changed, 290 insertions(+), 0 deletions(-)

e19c560ab7e8fa9b20ed5ec3233fb75e0daceb63
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1658cd1..9890387 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -71,6 +71,7 @@ static unsigned int ata_dev_set_xfermode
 static void ata_dev_xfermask(struct ata_device *dev);
 
 static int ata_param_set_powersave(const char *val, struct kernel_param *kp);
+static int ata_param_set_hips_timeout(const char *val, struct kernel_param *kp);
 
 static DEFINE_MUTEX(ata_all_ports_mutex);
 static LIST_HEAD(ata_all_ports);
@@ -102,6 +103,18 @@ module_param_call(powersave, ata_param_s
 MODULE_PARM_DESC(powersave, "Powersave mode (0=none, 1=HIPS, 2=DIPS, "
 		 "3=static, 4=HIPS/static, 5=DIPS/static)");
 
+static unsigned long libata_partial_timeout = 100;
+module_param_call(partial_timeout, ata_param_set_hips_timeout, param_get_ulong,
+		  &libata_partial_timeout, 0644);
+MODULE_PARM_DESC(hips_timeout, "Host-initiated partial powersave timeout "
+		 "(milliseconds, default 100, 0 to disable)");
+
+static unsigned long libata_slumber_timeout = 3000;
+module_param_call(slumber_timeout, ata_param_set_hips_timeout, param_get_ulong,
+		  &libata_slumber_timeout, 0644);
+MODULE_PARM_DESC(slumber_timeout, "Host-initiated slumber powersave timeout "
+		 "(milliseconds, default 3000, 0 to disable)");
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
@@ -2857,6 +2870,217 @@ void ata_std_postreset(struct ata_port *
 	DPRINTK("EXIT\n");
 }
 
+static void sata_std_update_sctl_spm(struct ata_port *ap, u8 sctl_spm,
+				     int may_push_sctl)
+{
+	if (may_push_sctl)
+		sata_update_scontrol_push(ap, ATA_SCTL_SPM, sctl_spm);
+	else
+		sata_update_scontrol(ap, ATA_SCTL_SPM, sctl_spm);
+}
+
+/**
+ *	sata_do_hips_timer_fn - helper to build SATA HIPS timer callback
+ *	@ap: target ATA port
+ *	@seq: current PS sequence
+ *	@sctl_ipm: current SControl IPM
+ *	@update_sctl_spm: update SControl SPM method
+ *
+ *	Implements standard SATA OS-driven host-initiated link
+ *	powersave.  @sctl_ipm is used to determine which powersave
+ *	modes are allowed and @update_sctl_spm is used to actually
+ *	transit powersave mode.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(ap->lock).
+ *
+ *	RETURNS:
+ *	Timeout in jiffies if next PS sequence is needed, 0 otherwise.
+ */
+unsigned long sata_do_hips_timer_fn(struct ata_port *ap, int seq, u8 sctl_ipm,
+				    ata_update_sctl_spm_fn_t update_sctl_spm)
+{
+	unsigned long next_timeout = 0;
+
+	switch (seq) {
+	case 0:
+		if (!(sctl_ipm & 0x1)) {
+			update_sctl_spm(ap, 0x1, 0);
+
+			if (!(sctl_ipm & 0x2))
+				next_timeout = ap->ps_2nd_timeout;
+		} else if (!(sctl_ipm & 0x2))
+			update_sctl_spm(ap, 0x2, 0);
+		break;
+
+	case 1:
+		/* Slumber timeout expired.  Cannot directly transit
+		 * to slumber from partial.  Transit to active first.
+		 */
+		update_sctl_spm(ap, 0x4, 0);
+
+		/* spec says 1ms max, be generous and give it 5 */
+		next_timeout = msec_to_jiffies(5);
+		break;
+
+	case 2:
+		update_sctl_spm(ap, 0x2, 0);
+		break;
+	}
+
+	return next_timeout;
+}
+
+/**
+ *	sata_std_hips_timer_fn - SATA standard powersave HIPS timer callback
+ *	@ap: target ATA port
+ *	@seq: current PS sequence
+ *
+ *	SATA standard powersave HIPS timer callback.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(ap->lock).
+ *
+ *	RETURNS:
+ *	Timeout in jiffies if next PS sequence is needed, 0 otherwise.
+ */
+unsigned long sata_std_hips_timer_fn(struct ata_port *ap, int seq)
+{
+	u8 sctl_ipm = ata_scontrol_field(ap->scontrol, ATA_SCTL_IPM);
+
+	return sata_do_hips_timer_fn(ap, seq, sctl_ipm,
+				     sata_std_update_sctl_spm);
+}
+
+/**
+ *	sata_do_set_powersave - helper to build ->set_powersave method
+ *	@ap: target ATA port
+ *	@ps_state: target powersave state
+ *	@sctl_ipm: SControl IPM value for HIPS/DIPS
+ *	@update_sctl_spm: update SControl SPM method (can be NULL)
+ *
+ *	This function helps building ->set_powersave method for
+ *	controllers with standard SCR registers.
+ *
+ *	LOCKING:
+ *	None (must be called from EH context).
+ */
+void sata_do_set_powersave(struct ata_port *ap, int ps_state, u8 sctl_ipm,
+			   ata_update_sctl_spm_fn_t update_sctl_spm)
+{
+	struct ata_eh_context *ehc = &ap->eh_context;
+	unsigned long flags;
+
+	if (ps_state == ATA_PS_NONE) {
+		/* powersave off */
+		if (ata_ps_dynamic(ap->ps_state)) {
+			/* Make link active.  If host cannot issue PS
+			 * state change, the link can be in PS when
+			 * recovery kicks in, which results in SRST
+			 * failure as link looks offline.  Force
+			 * hardreset in such cases.
+			 */
+			if (update_sctl_spm)
+				update_sctl_spm(ap, 0x4, 1);
+			else if (ehc->i.action & ATA_EH_RESET_MASK)
+				ehc->i.action |= ATA_EH_HARDRESET;
+		}
+		sata_update_scontrol_push(ap, ATA_SCTL_IPM, 0x3);
+		sata_update_scontrol(ap, ATA_SCTL_DET, 0x0);
+		return;
+	}
+
+	/* entering powersave mode */
+	if (ata_ps_static(ps_state) && !ata_port_nr_ready(ap)) {
+		/* no ready device, power down PHY */
+		sata_update_scontrol(ap, ATA_SCTL_DET, 0x4);
+		return;
+	}
+
+	switch (ata_ps_dynamic(ps_state)) {
+	case ATA_PS_NONE:
+		break;
+
+	case ATA_PS_HIPS:
+		sata_update_scontrol(ap, ATA_SCTL_IPM, sctl_ipm);
+
+		if (ap->ps_timer_fn && ap->ps_timeout) {
+			spin_lock_irqsave(ap->lock, flags);
+			ap->pflags |= ATA_PFLAG_PS_TIMER;
+			spin_unlock_irqrestore(ap->lock, flags);
+		}
+		break;
+
+	case ATA_PS_DIPS:
+		sata_update_scontrol(ap, ATA_SCTL_IPM, sctl_ipm);
+		break;
+	}
+}
+
+/**
+ *	sata_determine_hips_params - determine standard HIPS params
+ *	@ap: target ATA port
+ *	@sctl_ipm: I/O argument to constraint and return resulting SControl IPM
+ *
+ *	Determine standard HIPS parameters from two module parameters
+ *	- libata.partial_timeout and libata.slumber_timeout.
+ *	Determined timeout values are stored in ap->ps_[2nd_]timeout
+ *	and SControl IPM value in *@sctl_ipm.
+ *
+ *	LOCKING:
+ *	None.
+ */
+void sata_determine_hips_params(struct ata_port *ap, u8 *sctl_ipm)
+{
+	unsigned long partial_tout = msec_to_jiffies(libata_partial_timeout);
+	unsigned long slumber_tout = msec_to_jiffies(libata_slumber_timeout);
+
+	if (!(*sctl_ipm & 0x1) && partial_tout &&
+	    (!slumber_tout || partial_tout < slumber_tout)) {
+		ap->ps_timeout = partial_tout;
+
+		if (slumber_tout)
+			ap->ps_2nd_timeout = slumber_tout - partial_tout;
+		else
+			*sctl_ipm |= 0x2;
+	} else if (!(*sctl_ipm & 0x2) && slumber_tout) {
+		*sctl_ipm |= 0x1;
+		ap->ps_timeout = slumber_tout;
+	} else {
+		*sctl_ipm |= 0x3;
+		ap->ps_timeout = 0;
+
+		ata_port_printk(ap, KERN_WARNING, "failed to initialize "
+				"HIPS timer, illegal parameters\n");
+	}
+}
+
+/**
+ *	sata_std_set_powersave - standard SATA set_powersave method
+ *	@ap: target ATA port
+ *	@ps_state: target powersave state
+ *
+ *	Standard SATA set_powersave method.
+ *
+ *	LOCKING:
+ *	None (must be called from EH context).
+ */
+void sata_std_set_powersave(struct ata_port *ap, int ps_state)
+{
+	ata_update_sctl_spm_fn_t update_sctl_spm = NULL;
+	u8 sctl_ipm = 0;
+
+	if (ap->flags & ATA_FLAG_HIPS)
+		update_sctl_spm = sata_std_update_sctl_spm;
+
+	if (ata_ps_dynamic(ps_state) == ATA_PS_HIPS) {
+		ap->ps_timer_fn = sata_std_hips_timer_fn;
+		sata_determine_hips_params(ap, &sctl_ipm);
+	}
+
+	sata_do_set_powersave(ap, ps_state, sctl_ipm, update_sctl_spm);
+}
+
 /**
  *	ata_dev_same_device - Determine whether new ID matches configured device
  *	@dev: device to compare against
@@ -5411,6 +5635,57 @@ static int ata_param_set_powersave(const
 }
 
 /**
+ *	ata_param_set_hips_timeout - param_set method for HIPS timeouts
+ *	@val: input value from user
+ *	@kp: kernel_param pointing to libata.(partial|slumber)_timeout
+ *
+ *	This function is invoked when user writes to module parameter
+ *	node /sys/module/libata/parameters/(partial|slumber)_timeout
+ *	and responsible for changing powersave configuration
+ *	accordingly.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+static int ata_param_set_hips_timeout(const char *val, struct kernel_param *kp)
+{
+	unsigned long *timeout = kp->arg;
+	struct kernel_param tkp;
+	struct ata_port *ap;
+	unsigned long new_val;
+	int rc;
+
+	tkp = *kp;
+	tkp.arg = &new_val;
+
+	rc = param_set_ulong(val, &tkp);
+	if (rc)
+		return rc;
+	if (new_val == *timeout)
+		return 0;
+
+	/* timeout updated */
+	*timeout = new_val;
+
+	/* tell EH to update PS configuration */
+	mutex_lock(&ata_all_ports_mutex);
+	list_for_each_entry(ap, &ata_all_ports, all_ports_entry) {
+		unsigned long flags;
+
+		spin_lock_irqsave(ap->lock, flags);
+		ap->eh_info.flags |= ATA_EHI_QUIET;
+		ata_port_schedule_eh(ap);
+		spin_unlock_irqrestore(ap->lock, flags);
+	}
+	mutex_unlock(&ata_all_ports_mutex);
+
+	return 0;
+}
+
+/**
  *	ata_host_remove - Unregister SCSI host structure with upper layers
  *	@ap: Port to unregister
  *	@do_unregister: 1 if we fully unregister, 0 to just stop the port
@@ -6224,6 +6499,11 @@ EXPORT_SYMBOL_GPL(ata_std_prereset);
 EXPORT_SYMBOL_GPL(ata_std_softreset);
 EXPORT_SYMBOL_GPL(sata_std_hardreset);
 EXPORT_SYMBOL_GPL(ata_std_postreset);
+EXPORT_SYMBOL_GPL(sata_do_hips_timer_fn);
+EXPORT_SYMBOL_GPL(sata_std_hips_timer_fn);
+EXPORT_SYMBOL_GPL(sata_do_set_powersave);
+EXPORT_SYMBOL_GPL(sata_determine_hips_params);
+EXPORT_SYMBOL_GPL(sata_std_set_powersave);
 EXPORT_SYMBOL_GPL(ata_dev_revalidate);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_pair);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0881814..b8bee5f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -337,6 +337,8 @@ typedef int (*ata_prereset_fn_t)(struct 
 typedef int (*ata_reset_fn_t)(struct ata_port *ap, unsigned int *classes);
 typedef void (*ata_postreset_fn_t)(struct ata_port *ap, unsigned int *classes);
 typedef unsigned long (*ata_ps_timer_fn_t)(struct ata_port *ap, int seq);
+typedef void (*ata_update_sctl_spm_fn_t)(struct ata_port *ap, u8 sctl_spm,
+					 int may_push_sctl);
 
 struct ata_ioports {
 	unsigned long		cmd_addr;
@@ -573,6 +575,7 @@ struct ata_port {
 	/* powersave timer, protected by ap->lock */
 	ata_ps_timer_fn_t	ps_timer_fn;	/* initialized by LLD */
 	unsigned long		ps_timeout;	/* ditto */
+	unsigned long		ps_2nd_timeout;	/* owned by LLD */
 
 	int			ps_seq;		/* managed by libata */
 	struct timer_list	ps_timer;	/* ditto */
@@ -699,6 +702,13 @@ extern int ata_std_prereset(struct ata_p
 extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes);
 extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class);
 extern void ata_std_postreset(struct ata_port *ap, unsigned int *classes);
+extern unsigned long sata_do_hips_timer_fn(struct ata_port *ap, int seq,
+			u8 sctl_ipm, ata_update_sctl_spm_fn_t update_sctl_spm);
+extern unsigned long sata_std_hips_timer_fn(struct ata_port *ap, int seq);
+extern void sata_do_set_powersave(struct ata_port *ap, int ps_state,
+			u8 sctl_ipm, ata_update_sctl_spm_fn_t update_sctl_spm);
+extern void sata_determine_hips_params(struct ata_port *ap, u8 *sctl_ipm);
+extern void sata_std_set_powersave(struct ata_port *ap, int ps_state);
 extern int ata_dev_revalidate(struct ata_device *dev, int post_reset);
 extern void ata_port_disable(struct ata_port *);
 extern void ata_std_ports(struct ata_ioports *ioaddr);
-- 
1.3.2


