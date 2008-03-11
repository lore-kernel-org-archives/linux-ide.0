From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/5] libata: prefer hardreset
Date: Tue, 11 Mar 2008 12:41:39 +0900
Message-ID: <12052069032806-git-send-email-htejun@gmail.com>
References: <12052069033338-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.234]:23542 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502AbYCKDlw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Mar 2008 23:41:52 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2280940wxd.4
        for <linux-ide@vger.kernel.org>; Mon, 10 Mar 2008 20:41:52 -0700 (PDT)
In-Reply-To: <12052069033338-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: mikpe@it.uu.se, Tejun Heo <htejun@gmail.com>

When both soft and hard resets are available, libata preferred
softreset till now.  The logic behind it was to be softer to devices;
however, this doesn't really help much.  Rationales for the change:

* BIOS may freeze lock certain things during boot and softreset can't
  unlock those.  This by itself is okay but during operation PHY event
  or other error conditions can trigger hardreset and the device may
  end up with different configuration.

  For example, after a hardreset, previously unlockable HPA can be
  unlocked resulting in different device size and thus revalidation
  failure.  Similar condition can occur during or after resume.

* Certain ATAPI devices require hardreset to recover after certain
  error conditions.  On PATA, this is done by issuing the DEVICE RESET
  command.  On SATA, COMRESET has equivalent effect.  The problem is
  that DEVICE RESET needs its own execution protocol.

  For SFF controllers with bare TF access, it can be easily
  implemented but more advanced controllers (e.g. ahci and sata_sil24)
  require specialized implementations.  Simply using hardreset solves
  the problem nicely.

* COMRESET initialization sequence is the norm in SATA land and many
  SATA devices don't work properly if only SRST is used.  For example,
  some PMPs behave this way and libata works around by always issuing
  hardreset if the host supports PMP.

  Like the above example, libata has developed a number of mechanisms
  aiming to promote softreset to hardreset if softreset is not going
  to work.  This approach is time consuming and error prone.

  Also, note that, dependingon how you read the specs, it could be
  argued that PMP fan-out ports require COMRESET to start operation.
  In fact, all the PMPs on the market except one don't work properly
  if COMRESET is not issued to fan-out ports after PMP reset.

* COMRESET is an integral part of SATA connection and any working
  device should be able to handle COMRESET properly.  After all, it's
  the way to signal hardreset during reboot.  This is the most used
  and recommended (at least by the ahci spec) method of resetting
  devices.

So, this patch makes libata prefer hardreset over softreset by making
the following changes.

* Rename ATA_EH_RESET_MASK to ATA_EH_RESET and use it whereever
  ATA_EH_{SOFT|HARD}RESET used to be used.  ATA_EH_{SOFT|HARD}RESET is
  now only used to tell prereset whether soft or hard reset will be
  issued.

* Strip out now unneeded promote-to-hardreset logics from
  ata_eh_reset(), ata_std_prereset(), sata_pmp_std_prereset() and
  other places.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c        |   10 ++--
 drivers/ata/libata-core.c |   19 ++-------
 drivers/ata/libata-eh.c   |   99 ++++++++++++++++-----------------------------
 drivers/ata/libata-pmp.c  |   28 ++++---------
 drivers/ata/libata-scsi.c |    4 +-
 drivers/ata/sata_fsl.c    |    2 +-
 drivers/ata/sata_mv.c     |   29 +++----------
 drivers/ata/sata_nv.c     |   12 +++---
 drivers/ata/sata_sil24.c  |   54 ++++++++++++------------
 drivers/ata/sata_via.c    |    2 +-
 include/linux/libata.h    |    8 ++--
 11 files changed, 100 insertions(+), 167 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 29e71bd..032b3f6 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1603,7 +1603,7 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 		u32 *unk = (u32 *)(pp->rx_fis + RX_FIS_UNK);
 
 		active_ehi->err_mask |= AC_ERR_HSM;
-		active_ehi->action |= ATA_EH_SOFTRESET;
+		active_ehi->action |= ATA_EH_RESET;
 		ata_ehi_push_desc(active_ehi,
 				  "unknown FIS %08x %08x %08x %08x" ,
 				  unk[0], unk[1], unk[2], unk[3]);
@@ -1611,19 +1611,19 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 
 	if (ap->nr_pmp_links && (irq_stat & PORT_IRQ_BAD_PMP)) {
 		active_ehi->err_mask |= AC_ERR_HSM;
-		active_ehi->action |= ATA_EH_SOFTRESET;
+		active_ehi->action |= ATA_EH_RESET;
 		ata_ehi_push_desc(active_ehi, "incorrect PMP");
 	}
 
 	if (irq_stat & (PORT_IRQ_HBUS_ERR | PORT_IRQ_HBUS_DATA_ERR)) {
 		host_ehi->err_mask |= AC_ERR_HOST_BUS;
-		host_ehi->action |= ATA_EH_SOFTRESET;
+		host_ehi->action |= ATA_EH_RESET;
 		ata_ehi_push_desc(host_ehi, "host bus error");
 	}
 
 	if (irq_stat & PORT_IRQ_IF_ERR) {
 		host_ehi->err_mask |= AC_ERR_ATA_BUS;
-		host_ehi->action |= ATA_EH_SOFTRESET;
+		host_ehi->action |= ATA_EH_RESET;
 		ata_ehi_push_desc(host_ehi, "interface fatal error");
 	}
 
@@ -1711,7 +1711,7 @@ static void ahci_port_intr(struct ata_port *ap)
 	/* while resetting, invalid completions are expected */
 	if (unlikely(rc < 0 && !resetting)) {
 		ehi->err_mask |= AC_ERR_HSM;
-		ehi->action |= ATA_EH_SOFTRESET;
+		ehi->action |= ATA_EH_RESET;
 		ata_port_freeze(ap);
 	}
 }
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3011919..af76d8b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3678,17 +3678,6 @@ int ata_std_prereset(struct ata_link *link, unsigned long deadline)
 	const unsigned long *timing = sata_ehc_deb_timing(ehc);
 	int rc;
 
-	/* handle link resume */
-	if ((ehc->i.flags & ATA_EHI_RESUME_LINK) &&
-	    (link->flags & ATA_LFLAG_HRST_TO_RESUME))
-		ehc->i.action |= ATA_EH_HARDRESET;
-
-	/* Some PMPs don't work with only SRST, force hardreset if PMP
-	 * is supported.
-	 */
-	if (ap->flags & ATA_FLAG_PMP)
-		ehc->i.action |= ATA_EH_HARDRESET;
-
 	/* if we're about to do hardreset, nothing more to do */
 	if (ehc->i.action & ATA_EH_HARDRESET)
 		return 0;
@@ -5961,9 +5950,9 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 		if (ata_sg_setup(qc))
 			goto sg_err;
 
-	/* if device is sleeping, schedule softreset and abort the link */
+	/* if device is sleeping, schedule reset and abort the link */
 	if (unlikely(qc->dev->flags & ATA_DFLAG_SLEEPING)) {
-		link->eh_info.action |= ATA_EH_SOFTRESET;
+		link->eh_info.action |= ATA_EH_RESET;
 		ata_ehi_push_desc(&link->eh_info, "waking up from sleep");
 		ata_link_abort(link);
 		return;
@@ -6540,7 +6529,7 @@ int ata_host_suspend(struct ata_host *host, pm_message_t mesg)
  */
 void ata_host_resume(struct ata_host *host)
 {
-	ata_host_request_pm(host, PMSG_ON, ATA_EH_SOFTRESET,
+	ata_host_request_pm(host, PMSG_ON, ATA_EH_RESET,
 			    ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET, 0);
 	host->dev->power.power_state = PMSG_ON;
 
@@ -7082,7 +7071,7 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 
 			ehi->probe_mask =
 				(1 << ata_link_max_devices(&ap->link)) - 1;
-			ehi->action |= ATA_EH_SOFTRESET;
+			ehi->action |= ATA_EH_RESET;
 			ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
 
 			ap->pflags &= ~ATA_PFLAG_INITIALIZING;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 4e31071..42f22ef 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1079,16 +1079,9 @@ void ata_eh_about_to_do(struct ata_link *link, struct ata_device *dev,
 
 	spin_lock_irqsave(ap->lock, flags);
 
-	/* Reset is represented by combination of actions and EHI
-	 * flags.  Suck in all related bits before clearing eh_info to
-	 * avoid losing requested action.
-	 */
-	if (action & ATA_EH_RESET_MASK) {
-		ehc->i.action |= ehi->action & ATA_EH_RESET_MASK;
+	/* suck in and clear reset modifier */
+	if (action & ATA_EH_RESET) {
 		ehc->i.flags |= ehi->flags & ATA_EHI_RESET_MODIFIER_MASK;
-
-		/* make sure all reset actions are cleared & clear EHI flags */
-		action |= ATA_EH_RESET_MASK;
 		ehi->flags &= ~ATA_EHI_RESET_MODIFIER_MASK;
 	}
 
@@ -1117,11 +1110,9 @@ void ata_eh_done(struct ata_link *link, struct ata_device *dev,
 {
 	struct ata_eh_context *ehc = &link->eh_context;
 
-	/* if reset is complete, clear all reset actions & reset modifier */
-	if (action & ATA_EH_RESET_MASK) {
-		action |= ATA_EH_RESET_MASK;
+	/* if reset is complete, clear reset modifier */
+	if (action & ATA_EH_RESET)
 		ehc->i.flags &= ~ATA_EHI_RESET_MODIFIER_MASK;
-	}
 
 	ata_eh_clear_action(link, dev, &ehc->i, action);
 }
@@ -1329,20 +1320,20 @@ static void ata_eh_analyze_serror(struct ata_link *link)
 
 	if (serror & SERR_PERSISTENT) {
 		err_mask |= AC_ERR_ATA_BUS;
-		action |= ATA_EH_HARDRESET;
+		action |= ATA_EH_RESET;
 	}
 	if (serror &
 	    (SERR_DATA_RECOVERED | SERR_COMM_RECOVERED | SERR_DATA)) {
 		err_mask |= AC_ERR_ATA_BUS;
-		action |= ATA_EH_SOFTRESET;
+		action |= ATA_EH_RESET;
 	}
 	if (serror & SERR_PROTOCOL) {
 		err_mask |= AC_ERR_HSM;
-		action |= ATA_EH_SOFTRESET;
+		action |= ATA_EH_RESET;
 	}
 	if (serror & SERR_INTERNAL) {
 		err_mask |= AC_ERR_SYSTEM;
-		action |= ATA_EH_HARDRESET;
+		action |= ATA_EH_RESET;
 	}
 
 	/* Determine whether a hotplug event has occurred.  Both
@@ -1448,7 +1439,7 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc,
 
 	if ((stat & (ATA_BUSY | ATA_DRQ | ATA_DRDY)) != ATA_DRDY) {
 		qc->err_mask |= AC_ERR_HSM;
-		return ATA_EH_SOFTRESET;
+		return ATA_EH_RESET;
 	}
 
 	if (stat & (ATA_ERR | ATA_DF))
@@ -1484,7 +1475,7 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc,
 	}
 
 	if (qc->err_mask & (AC_ERR_HSM | AC_ERR_TIMEOUT | AC_ERR_ATA_BUS))
-		action |= ATA_EH_SOFTRESET;
+		action |= ATA_EH_RESET;
 
 	return action;
 }
@@ -1685,7 +1676,7 @@ static unsigned int ata_eh_speed_down(struct ata_device *dev,
 	if (verdict & ATA_EH_SPDN_SPEED_DOWN) {
 		/* speed down SATA link speed if possible */
 		if (sata_down_spd_limit(link) == 0) {
-			action |= ATA_EH_HARDRESET;
+			action |= ATA_EH_RESET;
 			goto done;
 		}
 
@@ -1705,7 +1696,7 @@ static unsigned int ata_eh_speed_down(struct ata_device *dev,
 			dev->spdn_cnt++;
 
 			if (ata_down_xfermask_limit(dev, sel) == 0) {
-				action |= ATA_EH_SOFTRESET;
+				action |= ATA_EH_RESET;
 				goto done;
 			}
 		}
@@ -1719,7 +1710,7 @@ static unsigned int ata_eh_speed_down(struct ata_device *dev,
 	    (dev->xfer_shift != ATA_SHIFT_PIO)) {
 		if (ata_down_xfermask_limit(dev, ATA_DNXFER_FORCE_PIO) == 0) {
 			dev->spdn_cnt = 0;
-			action |= ATA_EH_SOFTRESET;
+			action |= ATA_EH_RESET;
 			goto done;
 		}
 	}
@@ -1764,9 +1755,9 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 		ehc->i.serror |= serror;
 		ata_eh_analyze_serror(link);
 	} else if (rc != -EOPNOTSUPP) {
-		/* SError read failed, force hardreset and probing */
+		/* SError read failed, force reset and probing */
 		ata_ehi_schedule_probe(&ehc->i);
-		ehc->i.action |= ATA_EH_HARDRESET;
+		ehc->i.action |= ATA_EH_RESET;
 		ehc->i.err_mask |= AC_ERR_OTHER;
 	}
 
@@ -1814,7 +1805,7 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 	/* enforce default EH actions */
 	if (ap->pflags & ATA_PFLAG_FROZEN ||
 	    all_err_mask & (AC_ERR_HSM | AC_ERR_TIMEOUT))
-		ehc->i.action |= ATA_EH_SOFTRESET;
+		ehc->i.action |= ATA_EH_RESET;
 	else if (((eflags & ATA_EFLAG_IS_IO) && all_err_mask) ||
 		 (!(eflags & ATA_EFLAG_IS_IO) && (all_err_mask & ~AC_ERR_DEV)))
 		ehc->i.action |= ATA_EH_REVALIDATE;
@@ -2118,7 +2109,6 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	int try = 0;
 	struct ata_device *dev;
 	unsigned long deadline, now;
-	unsigned int tmp_action;
 	ata_reset_fn_t reset;
 	unsigned long flags;
 	u32 sstatus;
@@ -2129,7 +2119,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	ap->pflags |= ATA_PFLAG_RESETTING;
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	ata_eh_about_to_do(link, NULL, ehc->i.action & ATA_EH_RESET_MASK);
+	ata_eh_about_to_do(link, NULL, ATA_EH_RESET);
 
 	ata_link_for_each_dev(dev, link) {
 		/* If we issue an SRST then an ATA drive (not ATAPI)
@@ -2150,17 +2140,15 @@ int ata_eh_reset(struct ata_link *link, int classify,
 			ap->ops->set_piomode(ap, dev);
 	}
 
-	/* Determine which reset to use and record in ehc->i.action.
-	 * prereset() may examine and modify it.
-	 */
-	if (softreset && (!hardreset || (!(lflags & ATA_LFLAG_NO_SRST) &&
-					 !sata_set_spd_needed(link) &&
-					 !(ehc->i.action & ATA_EH_HARDRESET))))
-		tmp_action = ATA_EH_SOFTRESET;
-	else
-		tmp_action = ATA_EH_HARDRESET;
-
-	ehc->i.action = (ehc->i.action & ~ATA_EH_RESET_MASK) | tmp_action;
+	/* prefer hardreset */
+	ehc->i.action &= ~ATA_EH_RESET;
+	if (hardreset) {
+		reset = hardreset;
+		ehc->i.action = ATA_EH_HARDRESET;
+	} else {
+		reset = softreset;
+		ehc->i.action = ATA_EH_SOFTRESET;
+	}
 
 	if (prereset) {
 		rc = prereset(link, jiffies + ATA_EH_PRERESET_TIMEOUT);
@@ -2168,7 +2156,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 			if (rc == -ENOENT) {
 				ata_link_printk(link, KERN_DEBUG,
 						"port disabled. ignoring.\n");
-				ehc->i.action &= ~ATA_EH_RESET_MASK;
+				ehc->i.action &= ~ATA_EH_RESET;
 
 				ata_link_for_each_dev(dev, link)
 					classes[dev->devno] = ATA_DEV_NONE;
@@ -2181,12 +2169,8 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		}
 	}
 
-	/* prereset() might have modified ehc->i.action */
-	if (ehc->i.action & ATA_EH_HARDRESET)
-		reset = hardreset;
-	else if (ehc->i.action & ATA_EH_SOFTRESET)
-		reset = softreset;
-	else {
+	/* prereset() might have cleared ATA_EH_RESET */
+	if (!(ehc->i.action & ATA_EH_RESET)) {
 		/* prereset told us not to reset, bang classes and return */
 		ata_link_for_each_dev(dev, link)
 			classes[dev->devno] = ATA_DEV_NONE;
@@ -2194,14 +2178,6 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		goto out;
 	}
 
-	/* did prereset() screw up?  if so, fix up to avoid oopsing */
-	if (!reset) {
-		if (softreset)
-			reset = softreset;
-		else
-			reset = hardreset;
-	}
-
  retry:
 	deadline = jiffies + ata_eh_reset_timeouts[try++];
 
@@ -2231,7 +2207,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 			goto fail;
 		}
 
-		ata_eh_about_to_do(link, NULL, ATA_EH_RESET_MASK);
+		ata_eh_about_to_do(link, NULL, ATA_EH_RESET);
 		rc = ata_do_reset(link, reset, classes, deadline);
 	}
 
@@ -2280,7 +2256,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		postreset(link, classes);
 
 	/* reset successful, schedule revalidation */
-	ata_eh_done(link, NULL, ehc->i.action & ATA_EH_RESET_MASK);
+	ata_eh_done(link, NULL, ATA_EH_RESET);
 	ehc->i.action |= ATA_EH_REVALIDATE;
 
 	rc = 0;
@@ -2536,7 +2512,7 @@ static int ata_eh_schedule_probe(struct ata_device *dev)
 	ata_eh_detach_dev(dev);
 	ata_dev_init(dev);
 	ehc->did_probe_mask |= (1 << dev->devno);
-	ehc->i.action |= ATA_EH_SOFTRESET;
+	ehc->i.action |= ATA_EH_RESET;
 	ehc->saved_xfer_mode[dev->devno] = 0;
 	ehc->saved_ncq_enabled &= ~(1 << dev->devno);
 
@@ -2580,12 +2556,7 @@ static int ata_eh_handle_dev_fail(struct ata_device *dev, int err)
 
 		return 1;
 	} else {
-		/* soft didn't work?  be haaaaard */
-		if (ehc->i.flags & ATA_EHI_DID_RESET)
-			ehc->i.action |= ATA_EH_HARDRESET;
-		else
-			ehc->i.action |= ATA_EH_SOFTRESET;
-
+		ehc->i.action |= ATA_EH_RESET;
 		return 0;
 	}
 }
@@ -2678,7 +2649,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 			ehc->i.action = 0;
 
 		/* do we need to reset? */
-		if (ehc->i.action & ATA_EH_RESET_MASK)
+		if (ehc->i.action & ATA_EH_RESET)
 			reset = 1;
 
 		ata_link_for_each_dev(dev, link)
@@ -2696,7 +2667,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 		ata_port_for_each_link(link, ap) {
 			struct ata_eh_context *ehc = &link->eh_context;
 
-			if (!(ehc->i.action & ATA_EH_RESET_MASK))
+			if (!(ehc->i.action & ATA_EH_RESET))
 				continue;
 
 			rc = ata_eh_reset(link, ata_link_nr_vacant(link),
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index caef2bb..133246b 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -194,15 +194,6 @@ int sata_pmp_std_prereset(struct ata_link *link, unsigned long deadline)
 	const unsigned long *timing = sata_ehc_deb_timing(ehc);
 	int rc;
 
-	/* force HRST? */
-	if (link->flags & ATA_LFLAG_NO_SRST)
-		ehc->i.action |= ATA_EH_HARDRESET;
-
-	/* handle link resume */
-	if ((ehc->i.flags & ATA_EHI_RESUME_LINK) &&
-	    (link->flags & ATA_LFLAG_HRST_TO_RESUME))
-		ehc->i.action |= ATA_EH_HARDRESET;
-
 	/* if we're about to do hardreset, nothing more to do */
 	if (ehc->i.action & ATA_EH_HARDRESET)
 		return 0;
@@ -445,7 +436,7 @@ static int sata_pmp_init_links(struct ata_port *ap, int nr_ports)
 
 		link->flags = 0;
 		ehc->i.probe_mask |= 1;
-		ehc->i.action |= ATA_EH_SOFTRESET;
+		ehc->i.action |= ATA_EH_RESET;
 		ehc->i.flags |= ATA_EHI_RESUME_LINK;
 	}
 
@@ -840,13 +831,12 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
  retry:
 	ehc->classes[0] = ATA_DEV_UNKNOWN;
 
-	if (ehc->i.action & ATA_EH_RESET_MASK) {
+	if (ehc->i.action & ATA_EH_RESET) {
 		struct ata_link *tlink;
 
 		ata_eh_freeze_port(ap);
 
 		/* reset */
-		ehc->i.action = ATA_EH_HARDRESET;
 		rc = ata_eh_reset(link, 0, prereset, softreset, hardreset,
 				  postreset);
 		if (rc) {
@@ -890,11 +880,11 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 				reval_failed = 1;
 
 			ata_dev_printk(dev, KERN_WARNING,
-				       "retrying hardreset%s\n",
+				       "retrying reset%s\n",
 				       sleep ? " in 5 secs" : "");
 			if (sleep)
 				ssleep(5);
-			ehc->i.action |= ATA_EH_HARDRESET;
+			ehc->i.action |= ATA_EH_RESET;
 			goto retry;
 		} else {
 			ata_dev_printk(dev, KERN_ERR, "failed to recover PMP "
@@ -938,10 +928,8 @@ static int sata_pmp_eh_handle_disabled_links(struct ata_port *ap)
 		/* Some PMPs require hardreset sequence to get
 		 * SError.N working.
 		 */
-		if ((link->flags & ATA_LFLAG_HRST_TO_RESUME) &&
-		    (link->eh_context.i.flags & ATA_EHI_RESUME_LINK))
-			sata_link_hardreset(link, sata_deb_timing_normal,
-					    jiffies + ATA_TMOUT_INTERNAL_QUICK);
+		sata_link_hardreset(link, sata_deb_timing_normal,
+				    jiffies + ATA_TMOUT_INTERNAL_QUICK);
 
 		/* unconditionally clear SError.N */
 		rc = sata_scr_write(link, SCR_ERROR, SERR_PHYRDY_CHG);
@@ -1124,7 +1112,7 @@ static int sata_pmp_eh_recover(struct ata_port *ap,
 
  link_fail:
 	if (sata_pmp_handle_link_fail(link, link_tries)) {
-		pmp_ehc->i.action |= ATA_EH_HARDRESET;
+		pmp_ehc->i.action |= ATA_EH_RESET;
 		goto retry;
 	}
 
@@ -1142,7 +1130,7 @@ static int sata_pmp_eh_recover(struct ata_port *ap,
 	if (--pmp_tries) {
 		ata_port_printk(ap, KERN_WARNING,
 				"failed to recover PMP, retrying in 5 secs\n");
-		pmp_ehc->i.action |= ATA_EH_HARDRESET;
+		pmp_ehc->i.action |= ATA_EH_RESET;
 		ssleep(5);
 		goto retry;
 	}
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index c02c490..ff4e176 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3449,7 +3449,7 @@ static int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 		ata_port_for_each_link(link, ap) {
 			struct ata_eh_info *ehi = &link->eh_info;
 			ehi->probe_mask |= (1 << ata_link_max_devices(link)) - 1;
-			ehi->action |= ATA_EH_SOFTRESET;
+			ehi->action |= ATA_EH_RESET;
 		}
 	} else {
 		struct ata_device *dev = ata_find_dev(ap, devno);
@@ -3457,7 +3457,7 @@ static int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 		if (dev) {
 			struct ata_eh_info *ehi = &dev->link->eh_info;
 			ehi->probe_mask |= 1 << dev->devno;
-			ehi->action |= ATA_EH_SOFTRESET;
+			ehi->action |= ATA_EH_RESET;
 			ehi->flags |= ATA_EHI_RESUME_LINK;
 		} else
 			rc = -EINVAL;
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index efcb66b..f6dcb1f 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1007,7 +1007,7 @@ static void sata_fsl_error_intr(struct ata_port *ap)
 	/* handle fatal errors */
 	if (hstatus & FATAL_ERROR_DECODE) {
 		err_mask |= AC_ERR_ATA_BUS;
-		action |= ATA_EH_SOFTRESET;
+		action |= ATA_EH_RESET;
 		/* how will fatal error interrupts be completed ?? */
 		freeze = 1;
 	}
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 080b836..3cd7400 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1528,7 +1528,7 @@ static void mv_err_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
 			EDMA_ERR_CRQB_PAR | EDMA_ERR_CRPB_PAR |
 			EDMA_ERR_INTRL_PAR)) {
 		err_mask |= AC_ERR_ATA_BUS;
-		action |= ATA_EH_HARDRESET;
+		action |= ATA_EH_RESET;
 		ata_ehi_push_desc(ehi, "parity error");
 	}
 	if (edma_err_cause & (EDMA_ERR_DEV_DCON | EDMA_ERR_DEV_CON)) {
@@ -1559,7 +1559,7 @@ static void mv_err_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
 			sata_scr_read(&ap->link, SCR_ERROR, &serr);
 			sata_scr_write_flush(&ap->link, SCR_ERROR, serr);
 			err_mask = AC_ERR_ATA_BUS;
-			action |= ATA_EH_HARDRESET;
+			action |= ATA_EH_RESET;
 		}
 	}
 
@@ -1568,7 +1568,7 @@ static void mv_err_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
 
 	if (!err_mask) {
 		err_mask = AC_ERR_OTHER;
-		action |= ATA_EH_HARDRESET;
+		action |= ATA_EH_RESET;
 	}
 
 	ehi->serror |= serr;
@@ -1782,7 +1782,7 @@ static void mv_pci_error(struct ata_host *host, void __iomem *mmio)
 				ata_ehi_push_desc(ehi,
 					"PCI err cause 0x%08x", err_cause);
 			err_mask = AC_ERR_HOST_BUS;
-			ehi->action = ATA_EH_HARDRESET;
+			ehi->action = ATA_EH_RESET;
 			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc)
 				qc->err_mask |= err_mask;
@@ -2451,28 +2451,13 @@ static int mv_prereset(struct ata_link *link, unsigned long deadline)
 {
 	struct ata_port *ap = link->ap;
 	struct mv_port_priv *pp	= ap->private_data;
-	struct ata_eh_context *ehc = &link->eh_context;
-	int rc;
 
-	rc = mv_stop_dma(ap);
-	if (rc)
-		ehc->i.action |= ATA_EH_HARDRESET;
+	mv_stop_dma(ap);
 
-	if (!(pp->pp_flags & MV_PP_FLAG_HAD_A_RESET)) {
+	if (!(pp->pp_flags & MV_PP_FLAG_HAD_A_RESET))
 		pp->pp_flags |= MV_PP_FLAG_HAD_A_RESET;
-		ehc->i.action |= ATA_EH_HARDRESET;
-	}
 
-	/* if we're about to do hardreset, nothing more to do */
-	if (ehc->i.action & ATA_EH_HARDRESET)
-		return 0;
-
-	if (ata_link_online(link))
-		rc = ata_wait_ready(ap, deadline);
-	else
-		rc = -ENODEV;
-
-	return rc;
+	return 0;
 }
 
 static int mv_hardreset(struct ata_link *link, unsigned int *class,
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index ed5473b..ce02e15 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -929,7 +929,7 @@ static int nv_adma_check_cpb(struct ata_port *ap, int cpb_num, int force_err)
 					"notifier for tag %d with no cmd?\n",
 					cpb_num);
 			ehi->err_mask |= AC_ERR_HSM;
-			ehi->action |= ATA_EH_SOFTRESET;
+			ehi->action |= ATA_EH_RESET;
 			ata_port_freeze(ap);
 			return 1;
 		}
@@ -1892,7 +1892,7 @@ static void nv_swncq_error_handler(struct ata_port *ap)
 
 	if (ap->link.sactive) {
 		nv_swncq_ncq_stop(ap);
-		ehc->i.action |= ATA_EH_HARDRESET;
+		ehc->i.action |= ATA_EH_RESET;
 	}
 
 	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset,
@@ -2173,7 +2173,7 @@ static int nv_swncq_sdbfis(struct ata_port *ap)
 		ata_ehi_clear_desc(ehi);
 		ata_ehi_push_desc(ehi, "BMDMA stat 0x%x", host_stat);
 		ehi->err_mask |= AC_ERR_HOST_BUS;
-		ehi->action |= ATA_EH_SOFTRESET;
+		ehi->action |= ATA_EH_RESET;
 		return -EINVAL;
 	}
 
@@ -2188,7 +2188,7 @@ static int nv_swncq_sdbfis(struct ata_port *ap)
 		ata_ehi_push_desc(ehi, "illegal SWNCQ:qc_active transition"
 				  "(%08x->%08x)", pp->qc_active, sactive);
 		ehi->err_mask |= AC_ERR_HSM;
-		ehi->action |= ATA_EH_HARDRESET;
+		ehi->action |= ATA_EH_RESET;
 		return -EINVAL;
 	}
 	for (i = 0; i < ATA_MAX_QUEUE; i++) {
@@ -2324,7 +2324,7 @@ static void nv_swncq_host_interrupt(struct ata_port *ap, u16 fis)
 		ata_ehi_push_desc(ehi, "Ata error. fis:0x%X", fis);
 		ehi->err_mask |= AC_ERR_DEV;
 		ehi->serror |= serror;
-		ehi->action |= ATA_EH_SOFTRESET;
+		ehi->action |= ATA_EH_RESET;
 		ata_port_freeze(ap);
 		return;
 	}
@@ -2356,7 +2356,7 @@ static void nv_swncq_host_interrupt(struct ata_port *ap, u16 fis)
 		if (pp->ncq_flags & (ncq_saw_sdb | ncq_saw_backout)) {
 			ata_ehi_push_desc(ehi, "illegal fis transaction");
 			ehi->err_mask |= AC_ERR_HSM;
-			ehi->action |= ATA_EH_HARDRESET;
+			ehi->action |= ATA_EH_RESET;
 			goto irq_error;
 		}
 
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index b4b1f91..4855eb2 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -286,45 +286,45 @@ static struct sil24_cerr_info {
 				    "device error via D2H FIS" },
 	[PORT_CERR_SDB]		= { AC_ERR_DEV, 0,
 				    "device error via SDB FIS" },
-	[PORT_CERR_DATA]	= { AC_ERR_ATA_BUS, ATA_EH_SOFTRESET,
+	[PORT_CERR_DATA]	= { AC_ERR_ATA_BUS, ATA_EH_RESET,
 				    "error in data FIS" },
-	[PORT_CERR_SEND]	= { AC_ERR_ATA_BUS, ATA_EH_SOFTRESET,
+	[PORT_CERR_SEND]	= { AC_ERR_ATA_BUS, ATA_EH_RESET,
 				    "failed to transmit command FIS" },
-	[PORT_CERR_INCONSISTENT] = { AC_ERR_HSM, ATA_EH_SOFTRESET,
+	[PORT_CERR_INCONSISTENT] = { AC_ERR_HSM, ATA_EH_RESET,
 				     "protocol mismatch" },
-	[PORT_CERR_DIRECTION]	= { AC_ERR_HSM, ATA_EH_SOFTRESET,
+	[PORT_CERR_DIRECTION]	= { AC_ERR_HSM, ATA_EH_RESET,
 				    "data directon mismatch" },
-	[PORT_CERR_UNDERRUN]	= { AC_ERR_HSM, ATA_EH_SOFTRESET,
+	[PORT_CERR_UNDERRUN]	= { AC_ERR_HSM, ATA_EH_RESET,
 				    "ran out of SGEs while writing" },
-	[PORT_CERR_OVERRUN]	= { AC_ERR_HSM, ATA_EH_SOFTRESET,
+	[PORT_CERR_OVERRUN]	= { AC_ERR_HSM, ATA_EH_RESET,
 				    "ran out of SGEs while reading" },
-	[PORT_CERR_PKT_PROT]	= { AC_ERR_HSM, ATA_EH_SOFTRESET,
+	[PORT_CERR_PKT_PROT]	= { AC_ERR_HSM, ATA_EH_RESET,
 				    "invalid data directon for ATAPI CDB" },
-	[PORT_CERR_SGT_BOUNDARY] = { AC_ERR_SYSTEM, ATA_EH_SOFTRESET,
+	[PORT_CERR_SGT_BOUNDARY] = { AC_ERR_SYSTEM, ATA_EH_RESET,
 				     "SGT not on qword boundary" },
-	[PORT_CERR_SGT_TGTABRT]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,
+	[PORT_CERR_SGT_TGTABRT]	= { AC_ERR_HOST_BUS, ATA_EH_RESET,
 				    "PCI target abort while fetching SGT" },
-	[PORT_CERR_SGT_MSTABRT]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,
+	[PORT_CERR_SGT_MSTABRT]	= { AC_ERR_HOST_BUS, ATA_EH_RESET,
 				    "PCI master abort while fetching SGT" },
-	[PORT_CERR_SGT_PCIPERR]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,
+	[PORT_CERR_SGT_PCIPERR]	= { AC_ERR_HOST_BUS, ATA_EH_RESET,
 				    "PCI parity error while fetching SGT" },
-	[PORT_CERR_CMD_BOUNDARY] = { AC_ERR_SYSTEM, ATA_EH_SOFTRESET,
+	[PORT_CERR_CMD_BOUNDARY] = { AC_ERR_SYSTEM, ATA_EH_RESET,
 				     "PRB not on qword boundary" },
-	[PORT_CERR_CMD_TGTABRT]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,
+	[PORT_CERR_CMD_TGTABRT]	= { AC_ERR_HOST_BUS, ATA_EH_RESET,
 				    "PCI target abort while fetching PRB" },
-	[PORT_CERR_CMD_MSTABRT]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,
+	[PORT_CERR_CMD_MSTABRT]	= { AC_ERR_HOST_BUS, ATA_EH_RESET,
 				    "PCI master abort while fetching PRB" },
-	[PORT_CERR_CMD_PCIPERR]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,
+	[PORT_CERR_CMD_PCIPERR]	= { AC_ERR_HOST_BUS, ATA_EH_RESET,
 				    "PCI parity error while fetching PRB" },
-	[PORT_CERR_XFR_UNDEF]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,
+	[PORT_CERR_XFR_UNDEF]	= { AC_ERR_HOST_BUS, ATA_EH_RESET,
 				    "undefined error while transferring data" },
-	[PORT_CERR_XFR_TGTABRT]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,
+	[PORT_CERR_XFR_TGTABRT]	= { AC_ERR_HOST_BUS, ATA_EH_RESET,
 				    "PCI target abort while transferring data" },
-	[PORT_CERR_XFR_MSTABRT]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,
+	[PORT_CERR_XFR_MSTABRT]	= { AC_ERR_HOST_BUS, ATA_EH_RESET,
 				    "PCI master abort while transferring data" },
-	[PORT_CERR_XFR_PCIPERR]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,
+	[PORT_CERR_XFR_PCIPERR]	= { AC_ERR_HOST_BUS, ATA_EH_RESET,
 				    "PCI parity error while transferring data" },
-	[PORT_CERR_SENDSERVICE]	= { AC_ERR_HSM, ATA_EH_SOFTRESET,
+	[PORT_CERR_SENDSERVICE]	= { AC_ERR_HSM, ATA_EH_RESET,
 				    "FIS received while sending service FIS" },
 };
 
@@ -616,7 +616,7 @@ static int sil24_init_port(struct ata_port *ap)
 
 	if ((tmp & (PORT_CS_INIT | PORT_CS_RDY)) != PORT_CS_RDY) {
 		pp->do_port_rst = 1;
-		ap->link.eh_context.i.action |= ATA_EH_HARDRESET;
+		ap->link.eh_context.i.action |= ATA_EH_RESET;
 		return -EIO;
 	}
 
@@ -1022,7 +1022,7 @@ static void sil24_error_intr(struct ata_port *ap)
 
 	if (irq_stat & PORT_IRQ_UNK_FIS) {
 		ehi->err_mask |= AC_ERR_HSM;
-		ehi->action |= ATA_EH_SOFTRESET;
+		ehi->action |= ATA_EH_RESET;
 		ata_ehi_push_desc(ehi, "unknown FIS");
 		freeze = 1;
 	}
@@ -1043,7 +1043,7 @@ static void sil24_error_intr(struct ata_port *ap)
 		 */
 		if (ap->nr_active_links >= 3) {
 			ehi->err_mask |= AC_ERR_OTHER;
-			ehi->action |= ATA_EH_HARDRESET;
+			ehi->action |= ATA_EH_RESET;
 			ata_ehi_push_desc(ehi, "PMP DMA CS errata");
 			pp->do_port_rst = 1;
 			freeze = 1;
@@ -1064,7 +1064,7 @@ static void sil24_error_intr(struct ata_port *ap)
 						  irq_stat);
 			} else {
 				err_mask |= AC_ERR_HSM;
-				action |= ATA_EH_HARDRESET;
+				action |= ATA_EH_RESET;
 				freeze = 1;
 			}
 		} else
@@ -1078,12 +1078,12 @@ static void sil24_error_intr(struct ata_port *ap)
 		if (ci && ci->desc) {
 			err_mask |= ci->err_mask;
 			action |= ci->action;
-			if (action & ATA_EH_RESET_MASK)
+			if (action & ATA_EH_RESET)
 				freeze = 1;
 			ata_ehi_push_desc(ehi, "%s", ci->desc);
 		} else {
 			err_mask |= AC_ERR_OTHER;
-			action |= ATA_EH_SOFTRESET;
+			action |= ATA_EH_RESET;
 			freeze = 1;
 			ata_ehi_push_desc(ehi, "unknown command error %d",
 					  cerr);
@@ -1153,7 +1153,7 @@ static inline void sil24_host_intr(struct ata_port *ap)
 	if (rc < 0) {
 		struct ata_eh_info *ehi = &ap->link.eh_info;
 		ehi->err_mask |= AC_ERR_HSM;
-		ehi->action |= ATA_EH_SOFTRESET;
+		ehi->action |= ATA_EH_RESET;
 		ata_port_freeze(ap);
 		return;
 	}
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 30caa03..1d542f6 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -320,7 +320,7 @@ static int vt6420_prereset(struct ata_link *link, unsigned long deadline)
 
 	if (!online) {
 		/* tell EH to bail */
-		ehc->i.action &= ~ATA_EH_RESET_MASK;
+		ehc->i.action &= ~ATA_EH_RESET;
 		return 0;
 	}
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index bc5a8d0..25e6fb3 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -292,11 +292,11 @@ enum {
 
 	/* reset / recovery action types */
 	ATA_EH_REVALIDATE	= (1 << 0),
-	ATA_EH_SOFTRESET	= (1 << 1),
-	ATA_EH_HARDRESET	= (1 << 2),
+	ATA_EH_SOFTRESET	= (1 << 1), /* meaningful only in ->prereset */
+	ATA_EH_HARDRESET	= (1 << 2), /* meaningful only in ->prereset */
+	ATA_EH_RESET		= ATA_EH_SOFTRESET | ATA_EH_HARDRESET,
 	ATA_EH_ENABLE_LINK	= (1 << 3),
 
-	ATA_EH_RESET_MASK	= ATA_EH_SOFTRESET | ATA_EH_HARDRESET,
 	ATA_EH_PERDEV_MASK	= ATA_EH_REVALIDATE,
 
 	/* ata_eh_info->flags */
@@ -1103,7 +1103,7 @@ extern void ata_ehi_clear_desc(struct ata_eh_info *ehi);
 static inline void ata_ehi_schedule_probe(struct ata_eh_info *ehi)
 {
 	ehi->flags |= ATA_EHI_RESUME_LINK;
-	ehi->action |= ATA_EH_SOFTRESET;
+	ehi->action |= ATA_EH_RESET;
 	ehi->probe_mask |= (1 << ATA_MAX_DEVICES) - 1;
 }
 
-- 
1.5.2.4

