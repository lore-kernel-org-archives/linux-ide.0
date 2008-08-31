From: Chris Webb <chris@arachsys.com>
Subject: sata_nv regression on Supermicro H8DMT+ for kernels newer than
	2.6.25
Date: Sun, 31 Aug 2008 21:41:47 +0100
Message-ID: <20080831204147.GG30238@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alpha.arachsys.com ([91.203.57.7]:57174 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbYHaVPO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 Aug 2008 17:15:14 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm having some trouble with the sata_nv driver on a Supermicro Opteron
motherboard. It's an H8DMT+ with an onboard nVidia MCP55V Pro SATA controller
running the latest release of the BIOS. Straight after boot on recent kernels,
I'm seeing error messages like this:

  ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
  ata1.00: cmd ca/00:08:3f:10:00/00:00:00:00:00/e0 tag 0 dma 4096 out
           res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
  ata1.00: status: { DRDY }
  ata1: hard resetting link
  ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
  ata1.00: configured for UDMA/133
  ata1: EH complete
  ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
  ata1.00: cmd ca/00:08:3f:10:00/00:00:00:00:00/e0 tag 0 dma 4096 out
           res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
  ata1.00: status: { DRDY }
  ata1: hard resetting link
  ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
  ata1.00: configured for UDMA/133
  ata1: EH complete
  ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
  ata1.00: cmd ca/00:08:3f:10:00/00:00:00:00:00/e0 tag 0 dma 4096 out
           res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
  ata1.00: status: { DRDY }
  ata1: hard resetting link
  ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
  [...]

with the IO operation eventually timing out. The sata_nv driver worked fine in
2.6.25, but stops working shortly after this release, and is breaking in this
way for 2.6.26[.y] and in the latest 2.6.27-rc5.

I've bisected to the changeset where the regression appears for me. It's
included at the end of the message, but here's a direct link:

  http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=cf48062658e7ab3bc55e10c65676c3c73c16f8bf

I imagine this implies that the chipset on this board has trouble with hard
resets in some way, but I'd be grateful for any advice as to the most sensible
next step to debug this!

Best wishes,

Chris.


Changeset provoking the symptoms:

libata: prefer hardreset

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

committer: Jeff Garzik <jgarzik@redhat.com>

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1663,7 +1663,7 @@
 		u32 *unk = (u32 *)(pp->rx_fis + RX_FIS_UNK);
 
 		active_ehi->err_mask |= AC_ERR_HSM;
-		active_ehi->action |= ATA_EH_SOFTRESET;
+		active_ehi->action |= ATA_EH_RESET;
 		ata_ehi_push_desc(active_ehi,
 				  "unknown FIS %08x %08x %08x %08x" ,
 				  unk[0], unk[1], unk[2], unk[3]);
@@ -1671,19 +1671,19 @@
 
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
 
@@ -1771,7 +1771,7 @@
 	/* while resetting, invalid completions are expected */
 	if (unlikely(rc < 0 && !resetting)) {
 		ehi->err_mask |= AC_ERR_HSM;
-		ehi->action |= ATA_EH_SOFTRESET;
+		ehi->action |= ATA_EH_RESET;
 		ata_port_freeze(ap);
 	}
 }
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3948,17 +3948,6 @@
 	struct ata_eh_context *ehc = &link->eh_context;
 	const unsigned long *timing = sata_ehc_deb_timing(ehc);
 	int rc;
-
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
 
 	/* if we're about to do hardreset, nothing more to do */
 	if (ehc->i.action & ATA_EH_HARDRESET)
@@ -6055,9 +6044,9 @@
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
@@ -6634,7 +6623,7 @@
  */
 void ata_host_resume(struct ata_host *host)
 {
-	ata_host_request_pm(host, PMSG_ON, ATA_EH_SOFTRESET,
+	ata_host_request_pm(host, PMSG_ON, ATA_EH_RESET,
 			    ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET, 0);
 	host->dev->power.power_state = PMSG_ON;
 
@@ -7171,7 +7160,7 @@
 
 			ehi->probe_mask =
 				(1 << ata_link_max_devices(&ap->link)) - 1;
-			ehi->action |= ATA_EH_SOFTRESET;
+			ehi->action |= ATA_EH_RESET;
 			ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
 
 			ap->pflags &= ~ATA_PFLAG_INITIALIZING;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1079,16 +1079,9 @@
 
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
 
@@ -1117,11 +1110,9 @@
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
@@ -1329,20 +1320,20 @@
 
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
@@ -1448,7 +1439,7 @@
 
 	if ((stat & (ATA_BUSY | ATA_DRQ | ATA_DRDY)) != ATA_DRDY) {
 		qc->err_mask |= AC_ERR_HSM;
-		return ATA_EH_SOFTRESET;
+		return ATA_EH_RESET;
 	}
 
 	if (stat & (ATA_ERR | ATA_DF))
@@ -1484,7 +1475,7 @@
 	}
 
 	if (qc->err_mask & (AC_ERR_HSM | AC_ERR_TIMEOUT | AC_ERR_ATA_BUS))
-		action |= ATA_EH_SOFTRESET;
+		action |= ATA_EH_RESET;
 
 	return action;
 }
@@ -1685,7 +1676,7 @@
 	if (verdict & ATA_EH_SPDN_SPEED_DOWN) {
 		/* speed down SATA link speed if possible */
 		if (sata_down_spd_limit(link) == 0) {
-			action |= ATA_EH_HARDRESET;
+			action |= ATA_EH_RESET;
 			goto done;
 		}
 
@@ -1705,7 +1696,7 @@
 			dev->spdn_cnt++;
 
 			if (ata_down_xfermask_limit(dev, sel) == 0) {
-				action |= ATA_EH_SOFTRESET;
+				action |= ATA_EH_RESET;
 				goto done;
 			}
 		}
@@ -1719,7 +1710,7 @@
 	    (dev->xfer_shift != ATA_SHIFT_PIO)) {
 		if (ata_down_xfermask_limit(dev, ATA_DNXFER_FORCE_PIO) == 0) {
 			dev->spdn_cnt = 0;
-			action |= ATA_EH_SOFTRESET;
+			action |= ATA_EH_RESET;
 			goto done;
 		}
 	}
@@ -1764,9 +1755,9 @@
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
 
@@ -1814,7 +1805,7 @@
 	/* enforce default EH actions */
 	if (ap->pflags & ATA_PFLAG_FROZEN ||
 	    all_err_mask & (AC_ERR_HSM | AC_ERR_TIMEOUT))
-		ehc->i.action |= ATA_EH_SOFTRESET;
+		ehc->i.action |= ATA_EH_RESET;
 	else if (((eflags & ATA_EFLAG_IS_IO) && all_err_mask) ||
 		 (!(eflags & ATA_EFLAG_IS_IO) && (all_err_mask & ~AC_ERR_DEV)))
 		ehc->i.action |= ATA_EH_REVALIDATE;
@@ -2118,7 +2109,6 @@
 	int try = 0;
 	struct ata_device *dev;
 	unsigned long deadline, now;
-	unsigned int tmp_action;
 	ata_reset_fn_t reset;
 	unsigned long flags;
 	u32 sstatus;
@@ -2129,7 +2119,7 @@
 	ap->pflags |= ATA_PFLAG_RESETTING;
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	ata_eh_about_to_do(link, NULL, ehc->i.action & ATA_EH_RESET_MASK);
+	ata_eh_about_to_do(link, NULL, ATA_EH_RESET);
 
 	ata_link_for_each_dev(dev, link) {
 		/* If we issue an SRST then an ATA drive (not ATAPI)
@@ -2159,17 +2149,15 @@
 		goto done;
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
@@ -2177,7 +2165,7 @@
 			if (rc == -ENOENT) {
 				ata_link_printk(link, KERN_DEBUG,
 						"port disabled. ignoring.\n");
-				ehc->i.action &= ~ATA_EH_RESET_MASK;
+				ehc->i.action &= ~ATA_EH_RESET;
 
 				ata_link_for_each_dev(dev, link)
 					classes[dev->devno] = ATA_DEV_NONE;
@@ -2190,25 +2178,13 @@
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
 		rc = 0;
 		goto out;
-	}
-
-	/* did prereset() screw up?  if so, fix up to avoid oopsing */
-	if (!reset) {
-		if (softreset)
-			reset = softreset;
-		else
-			reset = hardreset;
 	}
 
  retry:
@@ -2240,7 +2216,7 @@
 			goto fail;
 		}
 
-		ata_eh_about_to_do(link, NULL, ATA_EH_RESET_MASK);
+		ata_eh_about_to_do(link, NULL, ATA_EH_RESET);
 		rc = ata_do_reset(link, reset, classes, deadline);
 	}
 
@@ -2290,7 +2266,7 @@
 		postreset(link, classes);
 
 	/* reset successful, schedule revalidation */
-	ata_eh_done(link, NULL, ehc->i.action & ATA_EH_RESET_MASK);
+	ata_eh_done(link, NULL, ATA_EH_RESET);
 	ehc->i.action |= ATA_EH_REVALIDATE;
 
 	rc = 0;
@@ -2548,7 +2524,7 @@
 	ata_eh_detach_dev(dev);
 	ata_dev_init(dev);
 	ehc->did_probe_mask |= (1 << dev->devno);
-	ehc->i.action |= ATA_EH_SOFTRESET;
+	ehc->i.action |= ATA_EH_RESET;
 	ehc->saved_xfer_mode[dev->devno] = 0;
 	ehc->saved_ncq_enabled &= ~(1 << dev->devno);
 
@@ -2592,12 +2568,7 @@
 
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
@@ -2690,7 +2661,7 @@
 			ehc->i.action = 0;
 
 		/* do we need to reset? */
-		if (ehc->i.action & ATA_EH_RESET_MASK)
+		if (ehc->i.action & ATA_EH_RESET)
 			reset = 1;
 
 		ata_link_for_each_dev(dev, link)
@@ -2708,7 +2679,7 @@
 		ata_port_for_each_link(link, ap) {
 			struct ata_eh_context *ehc = &link->eh_context;
 
-			if (!(ehc->i.action & ATA_EH_RESET_MASK))
+			if (!(ehc->i.action & ATA_EH_RESET))
 				continue;
 
 			rc = ata_eh_reset(link, ata_link_nr_vacant(link),
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -193,15 +193,6 @@
 	struct ata_eh_context *ehc = &link->eh_context;
 	const unsigned long *timing = sata_ehc_deb_timing(ehc);
 	int rc;
-
-	/* force HRST? */
-	if (link->flags & ATA_LFLAG_NO_SRST)
-		ehc->i.action |= ATA_EH_HARDRESET;
-
-	/* handle link resume */
-	if ((ehc->i.flags & ATA_EHI_RESUME_LINK) &&
-	    (link->flags & ATA_LFLAG_HRST_TO_RESUME))
-		ehc->i.action |= ATA_EH_HARDRESET;
 
 	/* if we're about to do hardreset, nothing more to do */
 	if (ehc->i.action & ATA_EH_HARDRESET)
@@ -445,7 +436,7 @@
 
 		link->flags = 0;
 		ehc->i.probe_mask |= 1;
-		ehc->i.action |= ATA_EH_SOFTRESET;
+		ehc->i.action |= ATA_EH_RESET;
 		ehc->i.flags |= ATA_EHI_RESUME_LINK;
 	}
 
@@ -840,13 +831,12 @@
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
@@ -890,11 +880,11 @@
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
@@ -938,10 +928,8 @@
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
@@ -1124,7 +1112,7 @@
 
  link_fail:
 	if (sata_pmp_handle_link_fail(link, link_tries)) {
-		pmp_ehc->i.action |= ATA_EH_HARDRESET;
+		pmp_ehc->i.action |= ATA_EH_RESET;
 		goto retry;
 	}
 
@@ -1142,7 +1130,7 @@
 	if (--pmp_tries) {
 		ata_port_printk(ap, KERN_WARNING,
 				"failed to recover PMP, retrying in 5 secs\n");
-		pmp_ehc->i.action |= ATA_EH_HARDRESET;
+		pmp_ehc->i.action |= ATA_EH_RESET;
 		ssleep(5);
 		goto retry;
 	}
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3508,7 +3508,7 @@
 		ata_port_for_each_link(link, ap) {
 			struct ata_eh_info *ehi = &link->eh_info;
 			ehi->probe_mask |= (1 << ata_link_max_devices(link)) - 1;
-			ehi->action |= ATA_EH_SOFTRESET;
+			ehi->action |= ATA_EH_RESET;
 		}
 	} else {
 		struct ata_device *dev = ata_find_dev(ap, devno);
@@ -3516,7 +3516,7 @@
 		if (dev) {
 			struct ata_eh_info *ehi = &dev->link->eh_info;
 			ehi->probe_mask |= 1 << dev->devno;
-			ehi->action |= ATA_EH_SOFTRESET;
+			ehi->action |= ATA_EH_RESET;
 			ehi->flags |= ATA_EHI_RESUME_LINK;
 		} else
 			rc = -EINVAL;
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -996,7 +996,7 @@
 	/* handle fatal errors */
 	if (hstatus & FATAL_ERROR_DECODE) {
 		err_mask |= AC_ERR_ATA_BUS;
-		action |= ATA_EH_SOFTRESET;
+		action |= ATA_EH_RESET;
 		/* how will fatal error interrupts be completed ?? */
 		freeze = 1;
 	}
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1524,14 +1524,14 @@
 			EDMA_ERR_CRQB_PAR | EDMA_ERR_CRPB_PAR |
 			EDMA_ERR_INTRL_PAR)) {
 		err_mask |= AC_ERR_ATA_BUS;
-		action |= ATA_EH_HARDRESET;
+		action |= ATA_EH_RESET;
 		ata_ehi_push_desc(ehi, "parity error");
 	}
 	if (edma_err_cause & (EDMA_ERR_DEV_DCON | EDMA_ERR_DEV_CON)) {
 		ata_ehi_hotplugged(ehi);
 		ata_ehi_push_desc(ehi, edma_err_cause & EDMA_ERR_DEV_DCON ?
 			"dev disconnect" : "dev connect");
-		action |= ATA_EH_HARDRESET;
+		action |= ATA_EH_RESET;
 	}
 
 	if (IS_GEN_I(hpriv)) {
@@ -1555,7 +1555,7 @@
 			sata_scr_read(&ap->link, SCR_ERROR, &serr);
 			sata_scr_write_flush(&ap->link, SCR_ERROR, serr);
 			err_mask = AC_ERR_ATA_BUS;
-			action |= ATA_EH_HARDRESET;
+			action |= ATA_EH_RESET;
 		}
 	}
 
@@ -1564,7 +1564,7 @@
 
 	if (!err_mask) {
 		err_mask = AC_ERR_OTHER;
-		action |= ATA_EH_HARDRESET;
+		action |= ATA_EH_RESET;
 	}
 
 	ehi->serror |= serr;
@@ -1780,7 +1780,7 @@
 				ata_ehi_push_desc(ehi,
 					"PCI err cause 0x%08x", err_cause);
 			err_mask = AC_ERR_HOST_BUS;
-			ehi->action = ATA_EH_HARDRESET;
+			ehi->action = ATA_EH_RESET;
 			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc)
 				qc->err_mask |= err_mask;
@@ -2449,28 +2449,13 @@
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
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -929,7 +929,7 @@
 					"notifier for tag %d with no cmd?\n",
 					cpb_num);
 			ehi->err_mask |= AC_ERR_HSM;
-			ehi->action |= ATA_EH_SOFTRESET;
+			ehi->action |= ATA_EH_RESET;
 			ata_port_freeze(ap);
 			return 1;
 		}
@@ -1892,7 +1892,7 @@
 
 	if (ap->link.sactive) {
 		nv_swncq_ncq_stop(ap);
-		ehc->i.action |= ATA_EH_HARDRESET;
+		ehc->i.action |= ATA_EH_RESET;
 	}
 
 	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset,
@@ -2173,7 +2173,7 @@
 		ata_ehi_clear_desc(ehi);
 		ata_ehi_push_desc(ehi, "BMDMA stat 0x%x", host_stat);
 		ehi->err_mask |= AC_ERR_HOST_BUS;
-		ehi->action |= ATA_EH_SOFTRESET;
+		ehi->action |= ATA_EH_RESET;
 		return -EINVAL;
 	}
 
@@ -2188,7 +2188,7 @@
 		ata_ehi_push_desc(ehi, "illegal SWNCQ:qc_active transition"
 				  "(%08x->%08x)", pp->qc_active, sactive);
 		ehi->err_mask |= AC_ERR_HSM;
-		ehi->action |= ATA_EH_HARDRESET;
+		ehi->action |= ATA_EH_RESET;
 		return -EINVAL;
 	}
 	for (i = 0; i < ATA_MAX_QUEUE; i++) {
@@ -2324,7 +2324,7 @@
 		ata_ehi_push_desc(ehi, "Ata error. fis:0x%X", fis);
 		ehi->err_mask |= AC_ERR_DEV;
 		ehi->serror |= serror;
-		ehi->action |= ATA_EH_SOFTRESET;
+		ehi->action |= ATA_EH_RESET;
 		ata_port_freeze(ap);
 		return;
 	}
@@ -2356,7 +2356,7 @@
 		if (pp->ncq_flags & (ncq_saw_sdb | ncq_saw_backout)) {
 			ata_ehi_push_desc(ehi, "illegal fis transaction");
 			ehi->err_mask |= AC_ERR_HSM;
-			ehi->action |= ATA_EH_HARDRESET;
+			ehi->action |= ATA_EH_RESET;
 			goto irq_error;
 		}
 
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -286,45 +286,45 @@
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
 
@@ -616,7 +616,7 @@
 
 	if ((tmp & (PORT_CS_INIT | PORT_CS_RDY)) != PORT_CS_RDY) {
 		pp->do_port_rst = 1;
-		ap->link.eh_context.i.action |= ATA_EH_HARDRESET;
+		ap->link.eh_context.i.action |= ATA_EH_RESET;
 		return -EIO;
 	}
 
@@ -1022,7 +1022,7 @@
 
 	if (irq_stat & PORT_IRQ_UNK_FIS) {
 		ehi->err_mask |= AC_ERR_HSM;
-		ehi->action |= ATA_EH_SOFTRESET;
+		ehi->action |= ATA_EH_RESET;
 		ata_ehi_push_desc(ehi, "unknown FIS");
 		freeze = 1;
 	}
@@ -1043,7 +1043,7 @@
 		 */
 		if (ap->nr_active_links >= 3) {
 			ehi->err_mask |= AC_ERR_OTHER;
-			ehi->action |= ATA_EH_HARDRESET;
+			ehi->action |= ATA_EH_RESET;
 			ata_ehi_push_desc(ehi, "PMP DMA CS errata");
 			pp->do_port_rst = 1;
 			freeze = 1;
@@ -1064,7 +1064,7 @@
 						  irq_stat);
 			} else {
 				err_mask |= AC_ERR_HSM;
-				action |= ATA_EH_HARDRESET;
+				action |= ATA_EH_RESET;
 				freeze = 1;
 			}
 		} else
@@ -1078,12 +1078,12 @@
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
@@ -1153,7 +1153,7 @@
 	if (rc < 0) {
 		struct ata_eh_info *ehi = &ap->link.eh_info;
 		ehi->err_mask |= AC_ERR_HSM;
-		ehi->action |= ATA_EH_SOFTRESET;
+		ehi->action |= ATA_EH_RESET;
 		ata_port_freeze(ap);
 		return;
 	}
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -320,7 +320,7 @@
 
 	if (!online) {
 		/* tell EH to bail */
-		ehc->i.action &= ~ATA_EH_RESET_MASK;
+		ehc->i.action &= ~ATA_EH_RESET;
 		return 0;
 	}
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -292,12 +292,12 @@
 
 	/* reset / recovery action types */
 	ATA_EH_REVALIDATE	= (1 << 0),
-	ATA_EH_SOFTRESET	= (1 << 1),
-	ATA_EH_HARDRESET	= (1 << 2),
+	ATA_EH_SOFTRESET	= (1 << 1), /* meaningful only in ->prereset */
+	ATA_EH_HARDRESET	= (1 << 2), /* meaningful only in ->prereset */
+	ATA_EH_RESET		= ATA_EH_SOFTRESET | ATA_EH_HARDRESET,
 	ATA_EH_ENABLE_LINK	= (1 << 3),
 	ATA_EH_LPM		= (1 << 4),  /* link power management action */
 
-	ATA_EH_RESET_MASK	= ATA_EH_SOFTRESET | ATA_EH_HARDRESET,
 	ATA_EH_PERDEV_MASK	= ATA_EH_REVALIDATE,
 
 	/* ata_eh_info->flags */
@@ -1097,7 +1097,7 @@
 static inline void ata_ehi_schedule_probe(struct ata_eh_info *ehi)
 {
 	ehi->flags |= ATA_EHI_RESUME_LINK;
-	ehi->action |= ATA_EH_SOFTRESET;
+	ehi->action |= ATA_EH_RESET;
 	ehi->probe_mask |= (1 << ATA_MAX_DEVICES) - 1;
 }


Kernel config:

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.25
# Sun Aug 31 20:25:48 2008
#
# CONFIG_64BIT is not set
CONFIG_X86_32=y
# CONFIG_X86_64 is not set
CONFIG_X86=y
# CONFIG_GENERIC_LOCKBREAK is not set
CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_HAVE_LATENCYTOP_SUPPORT=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_FAST_CMPXCHG_LOCAL=y
CONFIG_MMU=y
CONFIG_ZONE_DMA=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
# CONFIG_GENERIC_GPIO is not set
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
# CONFIG_ARCH_HAS_ILOG2_U32 is not set
# CONFIG_ARCH_HAS_ILOG2_U64 is not set
CONFIG_ARCH_HAS_CPU_IDLE_WAIT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
# CONFIG_GENERIC_TIME_VSYSCALL is not set
CONFIG_ARCH_HAS_CPU_RELAX=y
# CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
# CONFIG_ZONE_DMA32 is not set
CONFIG_ARCH_POPULATES_NODE_MAP=y
# CONFIG_AUDIT_ARCH is not set
CONFIG_ARCH_SUPPORTS_AOUT=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_X86_SMP=y
CONFIG_X86_32_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_KTIME_SCALAR=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# General setup
#
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_CGROUPS=y
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_CGROUP_NS is not set
# CONFIG_CPUSETS is not set
CONFIG_GROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_RT_GROUP_SCHED=y
# CONFIG_USER_SCHED is not set
CONFIG_CGROUP_SCHED=y
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_RESOURCE_COUNTERS is not set
# CONFIG_SYSFS_DEPRECATED_V2 is not set
# CONFIG_RELAY is not set
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
# CONFIG_IPC_NS is not set
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
# CONFIG_EMBEDDED is not set
CONFIG_UID16=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_COMPAT_BRK is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_ANON_INODES=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_PROFILING=y
# CONFIG_MARKERS is not set
CONFIG_OPROFILE=y
CONFIG_HAVE_OPROFILE=y
# CONFIG_KPROBES is not set
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y
CONFIG_BLOCK=y
CONFIG_LBD=y
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_LSF=y
CONFIG_BLK_DEV_BSG=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_CLASSIC_RCU=y

#
# Processor type and features
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
CONFIG_SMP=y
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_X86_RDC321X is not set
# CONFIG_X86_VSMP is not set
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
CONFIG_PARAVIRT_GUEST=y
# CONFIG_XEN is not set
# CONFIG_VMI is not set
CONFIG_PARAVIRT=y
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
CONFIG_MK8=y
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_XADD=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_MINIMUM_CPU_FAMILY=4
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_IOMMU_HELPER is not set
CONFIG_NR_CPUS=8
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
# CONFIG_PREEMPT_RCU is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_VM86=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_RESOURCES_64BIT=y
CONFIG_ZONE_DMA_FLAG=1
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_HIGHPTE=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_IRQBALANCE=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x100000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x100000
CONFIG_HOTPLUG_CPU=y
# CONFIG_COMPAT_VDSO is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management options
#
# CONFIG_PM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
CONFIG_ARCH_SUPPORTS_MSI=y
CONFIG_PCI_MSI=y
# CONFIG_PCI_LEGACY is not set
CONFIG_HT_IRQ=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_PCCARD is not set
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=y
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_NET_KEY=y
# CONFIG_NET_KEY_MIGRATE is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_IPCOMP=y
CONFIG_INET_XFRM_TUNNEL=y
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_LRO=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=y

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_NETLINK_QUEUE=y
CONFIG_NETFILTER_NETLINK_LOG=y
CONFIG_NF_CONNTRACK=y
CONFIG_NF_CT_ACCT=y
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
# CONFIG_NF_CONNTRACK_AMANDA is not set
CONFIG_NF_CONNTRACK_FTP=y
CONFIG_NF_CONNTRACK_H323=y
# CONFIG_NF_CONNTRACK_IRC is not set
# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
# CONFIG_NF_CONNTRACK_PPTP is not set
# CONFIG_NF_CONNTRACK_SANE is not set
CONFIG_NF_CONNTRACK_SIP=y
CONFIG_NF_CONNTRACK_TFTP=y
CONFIG_NF_CT_NETLINK=y
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=y
CONFIG_NETFILTER_XT_TARGET_CONNMARK=y
CONFIG_NETFILTER_XT_TARGET_DSCP=y
CONFIG_NETFILTER_XT_TARGET_MARK=y
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=y
CONFIG_NETFILTER_XT_TARGET_NFLOG=y
CONFIG_NETFILTER_XT_TARGET_NOTRACK=y
CONFIG_NETFILTER_XT_TARGET_RATEEST=y
CONFIG_NETFILTER_XT_TARGET_TRACE=y
CONFIG_NETFILTER_XT_TARGET_TCPMSS=y
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=y
CONFIG_NETFILTER_XT_MATCH_COMMENT=y
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=y
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=y
CONFIG_NETFILTER_XT_MATCH_CONNMARK=y
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
CONFIG_NETFILTER_XT_MATCH_DCCP=y
CONFIG_NETFILTER_XT_MATCH_DSCP=y
CONFIG_NETFILTER_XT_MATCH_ESP=y
CONFIG_NETFILTER_XT_MATCH_HELPER=y
CONFIG_NETFILTER_XT_MATCH_IPRANGE=y
CONFIG_NETFILTER_XT_MATCH_LENGTH=y
CONFIG_NETFILTER_XT_MATCH_LIMIT=y
CONFIG_NETFILTER_XT_MATCH_MAC=y
CONFIG_NETFILTER_XT_MATCH_MARK=y
CONFIG_NETFILTER_XT_MATCH_OWNER=y
CONFIG_NETFILTER_XT_MATCH_POLICY=y
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=y
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=y
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=y
CONFIG_NETFILTER_XT_MATCH_QUOTA=y
CONFIG_NETFILTER_XT_MATCH_RATEEST=y
CONFIG_NETFILTER_XT_MATCH_REALM=y
CONFIG_NETFILTER_XT_MATCH_SCTP=y
CONFIG_NETFILTER_XT_MATCH_STATE=y
CONFIG_NETFILTER_XT_MATCH_STATISTIC=y
CONFIG_NETFILTER_XT_MATCH_STRING=y
CONFIG_NETFILTER_XT_MATCH_TCPMSS=y
CONFIG_NETFILTER_XT_MATCH_TIME=y
CONFIG_NETFILTER_XT_MATCH_U32=y
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=y

#
# IP: Netfilter Configuration
#
CONFIG_NF_CONNTRACK_IPV4=y
CONFIG_NF_CONNTRACK_PROC_COMPAT=y
CONFIG_IP_NF_QUEUE=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_RECENT=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_AH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_ADDRTYPE=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_NF_NAT=y
CONFIG_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_TARGET_NETMAP=y
CONFIG_NF_NAT_SNMP_BASIC=y
CONFIG_NF_NAT_FTP=y
# CONFIG_NF_NAT_IRC is not set
CONFIG_NF_NAT_TFTP=y
# CONFIG_NF_NAT_AMANDA is not set
# CONFIG_NF_NAT_PPTP is not set
CONFIG_NF_NAT_H323=y
CONFIG_NF_NAT_SIP=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_TTL=y
CONFIG_IP_NF_TARGET_CLUSTERIP=y
CONFIG_IP_NF_RAW=y
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
CONFIG_IP_NF_ARP_MANGLE=y

#
# Bridge: Netfilter Configuration
#
CONFIG_BRIDGE_NF_EBTABLES=y
CONFIG_BRIDGE_EBT_BROUTE=y
CONFIG_BRIDGE_EBT_T_FILTER=y
CONFIG_BRIDGE_EBT_T_NAT=y
CONFIG_BRIDGE_EBT_802_3=y
CONFIG_BRIDGE_EBT_AMONG=y
CONFIG_BRIDGE_EBT_ARP=y
CONFIG_BRIDGE_EBT_IP=y
CONFIG_BRIDGE_EBT_LIMIT=y
CONFIG_BRIDGE_EBT_MARK=y
CONFIG_BRIDGE_EBT_PKTTYPE=y
CONFIG_BRIDGE_EBT_STP=y
CONFIG_BRIDGE_EBT_VLAN=y
CONFIG_BRIDGE_EBT_ARPREPLY=y
CONFIG_BRIDGE_EBT_DNAT=y
CONFIG_BRIDGE_EBT_MARK_T=y
CONFIG_BRIDGE_EBT_REDIRECT=y
CONFIG_BRIDGE_EBT_SNAT=y
CONFIG_BRIDGE_EBT_LOG=y
# CONFIG_BRIDGE_EBT_ULOG is not set
CONFIG_IP_DCCP=y
CONFIG_INET_DCCP_DIAG=y
CONFIG_IP_DCCP_ACKVEC=y

#
# DCCP CCIDs Configuration (EXPERIMENTAL)
#
CONFIG_IP_DCCP_CCID2=y
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_CCID3_RTO=100
CONFIG_IP_DCCP_TFRC_LIB=y
CONFIG_IP_SCTP=y
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
CONFIG_SCTP_HMAC_SHA1=y
# CONFIG_SCTP_HMAC_MD5 is not set
CONFIG_TIPC=y
# CONFIG_TIPC_ADVANCED is not set
# CONFIG_TIPC_DEBUG is not set
# CONFIG_ATM is not set
CONFIG_BRIDGE=y
CONFIG_VLAN_8021Q=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_SCHED is not set
CONFIG_NET_CLS_ROUTE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set

#
# Wireless
#
# CONFIG_CFG80211 is not set
CONFIG_WIRELESS_EXT=y
# CONFIG_MAC80211 is not set
CONFIG_IEEE80211=y
# CONFIG_IEEE80211_DEBUG is not set
CONFIG_IEEE80211_CRYPT_WEP=y
# CONFIG_IEEE80211_CRYPT_CCMP is not set
# CONFIG_IEEE80211_CRYPT_TKIP is not set
# CONFIG_IEEE80211_SOFTMAC is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH="\"\""
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_SYS_HYPERVISOR is not set
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_MTD is not set
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_MISC_DEVICES is not set
CONFIG_HAVE_IDE=y
CONFIG_IDE=y
# CONFIG_BLK_DEV_IDE is not set
# CONFIG_BLK_DEV_HD_ONLY is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_TGT is not set
# CONFIG_SCSI_NETLINK is not set
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set
CONFIG_SCSI_WAIT_SCAN=m

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_SVW is not set
# CONFIG_ATA_PIIX is not set
# CONFIG_SATA_MV is not set
CONFIG_SATA_NV=y
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SX4 is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CS5520 is not set
# CONFIG_PATA_CS5530 is not set
# CONFIG_PATA_CS5535 is not set
# CONFIG_PATA_CS5536 is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_ATA_GENERIC is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_SC1200 is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID10=y
CONFIG_MD_RAID456=y
CONFIG_MD_RAID5_RESHAPE=y
CONFIG_MD_MULTIPATH=y
# CONFIG_MD_FAULTY is not set
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_DEBUG is not set
CONFIG_DM_CRYPT=y
CONFIG_DM_SNAPSHOT=y
CONFIG_DM_MIRROR=y
CONFIG_DM_ZERO=y
CONFIG_DM_MULTIPATH=y
# CONFIG_DM_MULTIPATH_EMC is not set
# CONFIG_DM_MULTIPATH_RDAC is not set
# CONFIG_DM_MULTIPATH_HP is not set
# CONFIG_DM_DELAY is not set
CONFIG_DM_UEVENT=y
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=y
CONFIG_FIREWIRE_SBP2=y
# CONFIG_IEEE1394 is not set
# CONFIG_I2O is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
# CONFIG_NETDEVICES_MULTIQUEUE is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_MACVLAN is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=y
# CONFIG_VETH is not set
# CONFIG_ARCNET is not set
CONFIG_PHYLIB=y

#
# MII PHY device drivers
#
# CONFIG_MARVELL_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_FIXED_PHY is not set
# CONFIG_MDIO_BITBANG is not set
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
# CONFIG_IBM_NEW_EMAC_ZMII is not set
# CONFIG_IBM_NEW_EMAC_RGMII is not set
# CONFIG_IBM_NEW_EMAC_TAH is not set
# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
CONFIG_FORCEDETH=y
CONFIG_FORCEDETH_NAPI=y
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R6040 is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_SC92031 is not set
CONFIG_NETDEV_1000=y
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=y
CONFIG_E1000_NAPI=y
# CONFIG_E1000_DISABLE_PACKET_SPLIT is not set
CONFIG_E1000E=y
CONFIG_E1000E_ENABLED=y
# CONFIG_IP1000 is not set
# CONFIG_IGB is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set
# CONFIG_QLA3XXX is not set
# CONFIG_ATL1 is not set
# CONFIG_NETDEV_10000 is not set
# CONFIG_TR is not set

#
# Wireless LAN
#
# CONFIG_WLAN_PRE80211 is not set
CONFIG_WLAN_80211=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_LIBERTAS is not set
# CONFIG_AIRO is not set
CONFIG_HERMES=y
# CONFIG_PLX_HERMES is not set
# CONFIG_TMD_HERMES is not set
# CONFIG_NORTEL_HERMES is not set
CONFIG_PCI_HERMES=y
# CONFIG_ATMEL is not set
# CONFIG_PRISM54 is not set
# CONFIG_USB_ZD1201 is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
CONFIG_HOSTAP=y
# CONFIG_HOSTAP_FIRMWARE is not set
# CONFIG_HOSTAP_PLX is not set
CONFIG_HOSTAP_PCI=y

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_ISDN is not set
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_WISTRON_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_UINPUT is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_IPMI_HANDLER=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_NSC_GPIO is not set
# CONFIG_CS5535_GPIO is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
# CONFIG_I2C is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_HWMON is not set
# CONFIG_THERMAL is not set
# CONFIG_WATCHDOG is not set

#
# Sonics Silicon Backplane
#
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_SM501 is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DVB_CORE is not set
# CONFIG_DAB is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=y
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
# CONFIG_VGASTATE is not set
# CONFIG_VIDEO_OUTPUT_CONTROL is not set
# CONFIG_FB is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Display device support
#
# CONFIG_DISPLAY_SUPPORT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
# CONFIG_VIDEO_SELECT is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_RTCTIMER is not set
# CONFIG_SND_DYNAMIC_MINORS is not set
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_AC97_CODEC=y
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5530 is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDA_INTEL=y
# CONFIG_SND_HDA_HWDEP is not set
CONFIG_SND_HDA_CODEC_REALTEK=y
CONFIG_SND_HDA_CODEC_ANALOG=y
CONFIG_SND_HDA_CODEC_SIGMATEL=y
CONFIG_SND_HDA_CODEC_VIA=y
CONFIG_SND_HDA_CODEC_ATIHDMI=y
CONFIG_SND_HDA_CODEC_CONEXANT=y
CONFIG_SND_HDA_CODEC_CMEDIA=y
CONFIG_SND_HDA_CODEC_SI3054=y
CONFIG_SND_HDA_GENERIC=y
# CONFIG_SND_HDA_POWER_SAVE is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_HIFIER is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=y
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SIS7019 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set
# CONFIG_SND_USB_CAIAQ is not set

#
# System on Chip audio support
#
# CONFIG_SND_SOC is not set

#
# SoC Audio support for SuperH
#

#
# ALSA SoC audio for Freescale SOCs
#

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set
CONFIG_AC97_BUS=y
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
CONFIG_HID_DEBUG=y
# CONFIG_HIDRAW is not set

#
# USB Input Devices
#
CONFIG_USB_HID=y
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_DEVICE_CLASS=y
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
CONFIG_USB_LIBUSUAL=y

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_MON is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_BERRY_CHARGE is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGET is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_GADGET is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_INFINIBAND is not set
# CONFIG_EDAC is not set
# CONFIG_RTC_CLASS is not set

#
# Userspace I/O
#
# CONFIG_UIO is not set

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
# CONFIG_DMIID is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
# CONFIG_EXT4DEV_FS is not set
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
CONFIG_FUSE_FS=y
CONFIG_GENERIC_ACL=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_CONFIGFS_FS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf-8"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
# CONFIG_PRINTK_TIME is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_LATENCYTOP is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_EARLY_PRINTK=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_DOUBLEFAULT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_DEBUG_PROC_KEYS=y
# CONFIG_SECURITY is not set
CONFIG_SECURITY_FILE_CAPABILITIES=y
CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=y
CONFIG_ASYNC_MEMCPY=y
CONFIG_ASYNC_XOR=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_SALSA20_586=y
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CAMELLIA=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=y
CONFIG_TEXTSEARCH_BM=y
CONFIG_TEXTSEARCH_FSM=y
CONFIG_PLIST=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y
