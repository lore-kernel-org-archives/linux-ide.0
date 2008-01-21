From: Tejun Heo <htejun@gmail.com>
Subject: Re: unable to use cdrom/dvd drive after some usage
Date: Tue, 22 Jan 2008 00:28:25 +0900
Message-ID: <4794BA19.50506@gmail.com>
References: <20080115044608.GA13420@www> <20080115113406.10d691e3@lxorguk.ukuu.org.uk> <47945166.4060907@gmail.com> <20080121083806.GA28080@www>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010701040001030502000702"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.232]:7013 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762066AbYAUP2l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 10:28:41 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1102395nze.1
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 07:28:39 -0800 (PST)
In-Reply-To: <20080121083806.GA28080@www>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Johnny Luong <johnny.linux-ide@compfazed.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010701040001030502000702
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Johnny Luong wrote:
>>> If it doesn't then we need to look at it further and find out what is
>>> going on to crash the drive.
>> Another possibility is that the drive requires DEVICE RESET to clear its
>> FIFO or whatever.  I'm working on DEVICE RESET.  Will post patch soon.
>> Johnny, please hold on to the hardware for testing.
> 
> Since it may be a software issue, I've simply kept the drive in place.
> I did upgrade to 2.6.24-rc8 a couple of days ago though and haven't 
> seen that strange HSM error.  

Please apply the attached patch on top of 2.6.24-rc8 and see whether the
problem goes away, that is, libata EH recovers the device after such
failure.

Thanks.

-- 
tejun

--------------010701040001030502000702
Content-Type: text/x-patch;
 name="update-reset.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="update-reset.patch"

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 54f38c2..c1d285f 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1593,7 +1593,7 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 		u32 *unk = (u32 *)(pp->rx_fis + RX_FIS_UNK);
 
 		active_ehi->err_mask |= AC_ERR_HSM;
-		active_ehi->action |= ATA_EH_SOFTRESET;
+		active_ehi->action |= ATA_EH_RESET;
 		ata_ehi_push_desc(active_ehi,
 				  "unknown FIS %08x %08x %08x %08x" ,
 				  unk[0], unk[1], unk[2], unk[3]);
@@ -1601,19 +1601,19 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 
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
 
@@ -1701,7 +1701,7 @@ static void ahci_port_intr(struct ata_port *ap)
 	/* while resetting, invalid completions are expected */
 	if (unlikely(rc < 0 && !resetting)) {
 		ehi->err_mask |= AC_ERR_HSM;
-		ehi->action |= ATA_EH_SOFTRESET;
+		ehi->action |= ATA_EH_RESET;
 		ata_port_freeze(ap);
 	}
 }
diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 9032998..9b7c5b0 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -110,6 +110,7 @@ static struct ata_port_operations generic_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_unknown,
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index b406b39..26dac82 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -317,6 +317,7 @@ static const struct ata_port_operations piix_pata_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= piix_pata_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_40wire,
@@ -349,6 +350,7 @@ static const struct ata_port_operations ich_pata_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= piix_pata_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ich_pata_cable_detect,
@@ -377,6 +379,7 @@ static const struct ata_port_operations piix_sata_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
@@ -408,6 +411,7 @@ static const struct ata_port_operations piix_vmw_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= piix_pata_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_40wire,
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6380726..bdb8a16 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1911,9 +1911,21 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 	case ATA_DEV_ATA:
 		tf.command = ATA_CMD_ID_ATA;
 		break;
+
 	case ATA_DEV_ATAPI:
 		tf.command = ATA_CMD_ID_ATAPI;
+
+		if ((flags & ATA_READID_POST_SOFTRESET) ||
+		    !ap->ops->atapi_dev_reset)
+			break;
+
+		rc = ap->ops->atapi_dev_reset(dev);
+		if (rc) {
+			reason = "ATAPI DEVICE RESET failed";
+			goto err_out;
+		}
 		break;
+
 	default:
 		rc = -ENODEV;
 		reason = "unsupported class";
@@ -2001,7 +2013,7 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 			goto retry;
 	}
 
-	if ((flags & ATA_READID_POSTRESET) && class == ATA_DEV_ATA) {
+	if ((flags & ATA_READID_POST_RESET) && class == ATA_DEV_ATA) {
 		/*
 		 * The exact sequence expected by certain pre-ATA4 drives is:
 		 * SRST RESET
@@ -2024,7 +2036,7 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 			/* current CHS translation info (id[53-58]) might be
 			 * changed. reread the identify device info.
 			 */
-			flags &= ~ATA_READID_POSTRESET;
+			flags &= ~ATA_READID_POST_RESET;
 			goto retry;
 		}
 	}
@@ -2471,8 +2483,8 @@ int ata_bus_probe(struct ata_port *ap)
 		if (!ata_dev_enabled(dev))
 			continue;
 
-		rc = ata_dev_read_id(dev, &dev->class, ATA_READID_POSTRESET,
-				     dev->id);
+		rc = ata_dev_read_id(dev, &dev->class,
+				     ATA_READID_POST_SOFTRESET, dev->id);
 		if (rc)
 			goto fail;
 	}
@@ -6013,9 +6025,9 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 		qc->flags &= ~ATA_QCFLAG_DMAMAP;
 	}
 
-	/* if device is sleeping, schedule softreset and abort the link */
+	/* if device is sleeping, schedule reset and abort the link */
 	if (unlikely(qc->dev->flags & ATA_DFLAG_SLEEPING)) {
-		link->eh_info.action |= ATA_EH_SOFTRESET;
+		link->eh_info.action |= ATA_EH_RESET;
 		ata_ehi_push_desc(&link->eh_info, "waking up from sleep");
 		ata_link_abort(link);
 		return;
@@ -6593,7 +6605,7 @@ int ata_host_suspend(struct ata_host *host, pm_message_t mesg)
  */
 void ata_host_resume(struct ata_host *host)
 {
-	ata_host_request_pm(host, PMSG_ON, ATA_EH_SOFTRESET,
+	ata_host_request_pm(host, PMSG_ON, ATA_EH_RESET,
 			    ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET, 0);
 	host->dev->power.power_state = PMSG_ON;
 
@@ -7135,7 +7147,7 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 
 			ehi->probe_mask =
 				(1 << ata_link_max_devices(&ap->link)) - 1;
-			ehi->action |= ATA_EH_SOFTRESET;
+			ehi->action |= ATA_EH_RESET;
 			ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
 
 			ap->pflags &= ~ATA_PFLAG_INITIALIZING;
@@ -7619,6 +7631,7 @@ EXPORT_SYMBOL_GPL(ata_bmdma_start);
 EXPORT_SYMBOL_GPL(ata_bmdma_irq_clear);
 EXPORT_SYMBOL_GPL(ata_bmdma_status);
 EXPORT_SYMBOL_GPL(ata_bmdma_stop);
+EXPORT_SYMBOL_GPL(atapi_sff_dev_reset);
 EXPORT_SYMBOL_GPL(ata_bmdma_freeze);
 EXPORT_SYMBOL_GPL(ata_bmdma_thaw);
 EXPORT_SYMBOL_GPL(ata_bmdma_drive_eh);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 21a81cd..d76a47e 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1045,12 +1045,12 @@ void ata_eh_about_to_do(struct ata_link *link, struct ata_device *dev,
 	 * flags.  Suck in all related bits before clearing eh_info to
 	 * avoid losing requested action.
 	 */
-	if (action & ATA_EH_RESET_MASK) {
-		ehc->i.action |= ehi->action & ATA_EH_RESET_MASK;
+	if (action & ATA_EH_RESET) {
+		ehc->i.action |= ehi->action & ATA_EH_RESET;
 		ehc->i.flags |= ehi->flags & ATA_EHI_RESET_MODIFIER_MASK;
 
 		/* make sure all reset actions are cleared & clear EHI flags */
-		action |= ATA_EH_RESET_MASK;
+		action |= ATA_EH_RESET;
 		ehi->flags &= ~ATA_EHI_RESET_MODIFIER_MASK;
 	}
 
@@ -1080,8 +1080,8 @@ void ata_eh_done(struct ata_link *link, struct ata_device *dev,
 	struct ata_eh_context *ehc = &link->eh_context;
 
 	/* if reset is complete, clear all reset actions & reset modifier */
-	if (action & ATA_EH_RESET_MASK) {
-		action |= ATA_EH_RESET_MASK;
+	if (action & ATA_EH_RESET) {
+		action |= ATA_EH_RESET;
 		ehc->i.flags &= ~ATA_EHI_RESET_MODIFIER_MASK;
 	}
 
@@ -1291,20 +1291,20 @@ static void ata_eh_analyze_serror(struct ata_link *link)
 
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
@@ -1410,7 +1410,7 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc,
 
 	if ((stat & (ATA_BUSY | ATA_DRQ | ATA_DRDY)) != ATA_DRDY) {
 		qc->err_mask |= AC_ERR_HSM;
-		return ATA_EH_SOFTRESET;
+		return ATA_EH_RESET;
 	}
 
 	if (stat & (ATA_ERR | ATA_DF))
@@ -1446,7 +1446,7 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc,
 	}
 
 	if (qc->err_mask & (AC_ERR_HSM | AC_ERR_TIMEOUT | AC_ERR_ATA_BUS))
-		action |= ATA_EH_SOFTRESET;
+		action |= ATA_EH_RESET;
 
 	return action;
 }
@@ -1591,7 +1591,7 @@ static unsigned int ata_eh_speed_down(struct ata_device *dev, int is_io,
 	if (verdict & ATA_EH_SPDN_SPEED_DOWN) {
 		/* speed down SATA link speed if possible */
 		if (sata_down_spd_limit(dev->link) == 0) {
-			action |= ATA_EH_HARDRESET;
+			action |= ATA_EH_RESET;
 			goto done;
 		}
 
@@ -1611,7 +1611,7 @@ static unsigned int ata_eh_speed_down(struct ata_device *dev, int is_io,
 			dev->spdn_cnt++;
 
 			if (ata_down_xfermask_limit(dev, sel) == 0) {
-				action |= ATA_EH_SOFTRESET;
+				action |= ATA_EH_RESET;
 				goto done;
 			}
 		}
@@ -1625,7 +1625,7 @@ static unsigned int ata_eh_speed_down(struct ata_device *dev, int is_io,
 	    (dev->xfer_shift != ATA_SHIFT_PIO)) {
 		if (ata_down_xfermask_limit(dev, ATA_DNXFER_FORCE_PIO) == 0) {
 			dev->spdn_cnt = 0;
-			action |= ATA_EH_SOFTRESET;
+			action |= ATA_EH_RESET;
 			goto done;
 		}
 	}
@@ -1669,9 +1669,9 @@ static void ata_eh_link_autopsy(struct ata_link *link)
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
 
@@ -1719,7 +1719,7 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 	/* enforce default EH actions */
 	if (ap->pflags & ATA_PFLAG_FROZEN ||
 	    all_err_mask & (AC_ERR_HSM | AC_ERR_TIMEOUT))
-		ehc->i.action |= ATA_EH_SOFTRESET;
+		ehc->i.action |= ATA_EH_RESET;
 	else if ((is_io && all_err_mask) ||
 		 (!is_io && (all_err_mask & ~AC_ERR_DEV)))
 		ehc->i.action |= ATA_EH_REVALIDATE;
@@ -2031,7 +2031,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	ap->pflags |= ATA_PFLAG_RESETTING;
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	ata_eh_about_to_do(link, NULL, ehc->i.action & ATA_EH_RESET_MASK);
+	ata_eh_about_to_do(link, NULL, ehc->i.action & ATA_EH_RESET);
 
 	ata_link_for_each_dev(dev, link) {
 		/* If we issue an SRST then an ATA drive (not ATAPI)
@@ -2055,14 +2055,12 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	/* Determine which reset to use and record in ehc->i.action.
 	 * prereset() may examine and modify it.
 	 */
-	if (softreset && (!hardreset || (!(lflags & ATA_LFLAG_NO_SRST) &&
-					 !sata_set_spd_needed(link) &&
-					 !(ehc->i.action & ATA_EH_HARDRESET))))
-		tmp_action = ATA_EH_SOFTRESET;
-	else
+	if (hardreset)
 		tmp_action = ATA_EH_HARDRESET;
+	else
+		tmp_action = ATA_EH_SOFTRESET;
 
-	ehc->i.action = (ehc->i.action & ~ATA_EH_RESET_MASK) | tmp_action;
+	ehc->i.action = (ehc->i.action & ~ATA_EH_RESET) | tmp_action;
 
 	if (prereset) {
 		rc = prereset(link, jiffies + ATA_EH_PRERESET_TIMEOUT);
@@ -2070,7 +2068,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 			if (rc == -ENOENT) {
 				ata_link_printk(link, KERN_DEBUG,
 						"port disabled. ignoring.\n");
-				ehc->i.action &= ~ATA_EH_RESET_MASK;
+				ehc->i.action &= ~ATA_EH_RESET;
 
 				ata_link_for_each_dev(dev, link)
 					classes[dev->devno] = ATA_DEV_NONE;
@@ -2133,7 +2131,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 			goto fail;
 		}
 
-		ata_eh_about_to_do(link, NULL, ATA_EH_RESET_MASK);
+		ata_eh_about_to_do(link, NULL, ATA_EH_RESET);
 		rc = ata_do_reset(link, reset, classes, deadline);
 	}
 
@@ -2182,7 +2180,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		postreset(link, classes);
 
 	/* reset successful, schedule revalidation */
-	ata_eh_done(link, NULL, ehc->i.action & ATA_EH_RESET_MASK);
+	ata_eh_done(link, NULL, ehc->i.action & ATA_EH_RESET);
 	ehc->i.action |= ATA_EH_REVALIDATE;
 
 	rc = 0;
@@ -2239,8 +2237,10 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 		unsigned int action = ata_eh_dev_action(dev);
 		unsigned int readid_flags = 0;
 
-		if (ehc->i.flags & ATA_EHI_DID_RESET)
-			readid_flags |= ATA_READID_POSTRESET;
+		if (ehc->i.flags & ATA_EHI_DID_HARDRESET)
+			readid_flags |= ATA_READID_POST_HARDRESET;
+		else if (ehc->i.flags & ATA_EHI_DID_SOFTRESET)
+			readid_flags |= ATA_READID_POST_SOFTRESET;
 
 		if ((action & ATA_EH_REVALIDATE) && ata_dev_enabled(dev)) {
 			WARN_ON(dev->class == ATA_DEV_PMP);
@@ -2414,17 +2414,12 @@ static int ata_eh_handle_dev_fail(struct ata_device *dev, int err)
 
 			ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
 			ehc->did_probe_mask |= (1 << dev->devno);
-			ehc->i.action |= ATA_EH_SOFTRESET;
+			ehc->i.action |= ATA_EH_RESET;
 		}
 
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
@@ -2498,7 +2493,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 				ata_eh_detach_dev(dev);
 				ata_dev_init(dev);
 				ehc->did_probe_mask |= (1 << dev->devno);
-				ehc->i.action |= ATA_EH_SOFTRESET;
+				ehc->i.action |= ATA_EH_RESET;
 			}
 		}
 	}
@@ -2522,7 +2517,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 			ehc->i.action = 0;
 
 		/* do we need to reset? */
-		if (ehc->i.action & ATA_EH_RESET_MASK)
+		if (ehc->i.action & ATA_EH_RESET)
 			reset = 1;
 
 		ata_link_for_each_dev(dev, link)
@@ -2540,7 +2535,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 		ata_port_for_each_link(link, ap) {
 			struct ata_eh_context *ehc = &link->eh_context;
 
-			if (!(ehc->i.action & ATA_EH_RESET_MASK))
+			if (!(ehc->i.action & ATA_EH_RESET))
 				continue;
 
 			rc = ata_eh_reset(link, ata_link_nr_vacant(link),
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index caef2bb..c53a4e9 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -196,15 +196,15 @@ int sata_pmp_std_prereset(struct ata_link *link, unsigned long deadline)
 
 	/* force HRST? */
 	if (link->flags & ATA_LFLAG_NO_SRST)
-		ehc->i.action |= ATA_EH_HARDRESET;
+		ehc->i.action |= ATA_EH_RESET;
 
 	/* handle link resume */
 	if ((ehc->i.flags & ATA_EHI_RESUME_LINK) &&
 	    (link->flags & ATA_LFLAG_HRST_TO_RESUME))
-		ehc->i.action |= ATA_EH_HARDRESET;
+		ehc->i.action |= ATA_EH_RESET;
 
 	/* if we're about to do hardreset, nothing more to do */
-	if (ehc->i.action & ATA_EH_HARDRESET)
+	if (ehc->i.action & ATA_EH_RESET)
 		return 0;
 
 	/* resume link */
@@ -445,7 +445,7 @@ static int sata_pmp_init_links(struct ata_port *ap, int nr_ports)
 
 		link->flags = 0;
 		ehc->i.probe_mask |= 1;
-		ehc->i.action |= ATA_EH_SOFTRESET;
+		ehc->i.action |= ATA_EH_RESET;
 		ehc->i.flags |= ATA_EHI_RESUME_LINK;
 	}
 
@@ -840,13 +840,13 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
  retry:
 	ehc->classes[0] = ATA_DEV_UNKNOWN;
 
-	if (ehc->i.action & ATA_EH_RESET_MASK) {
+	if (ehc->i.action & ATA_EH_RESET) {
 		struct ata_link *tlink;
 
 		ata_eh_freeze_port(ap);
 
 		/* reset */
-		ehc->i.action = ATA_EH_HARDRESET;
+		ehc->i.action = ATA_EH_RESET;
 		rc = ata_eh_reset(link, 0, prereset, softreset, hardreset,
 				  postreset);
 		if (rc) {
@@ -894,7 +894,7 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 				       sleep ? " in 5 secs" : "");
 			if (sleep)
 				ssleep(5);
-			ehc->i.action |= ATA_EH_HARDRESET;
+			ehc->i.action |= ATA_EH_RESET;
 			goto retry;
 		} else {
 			ata_dev_printk(dev, KERN_ERR, "failed to recover PMP "
@@ -1124,7 +1124,7 @@ static int sata_pmp_eh_recover(struct ata_port *ap,
 
  link_fail:
 	if (sata_pmp_handle_link_fail(link, link_tries)) {
-		pmp_ehc->i.action |= ATA_EH_HARDRESET;
+		pmp_ehc->i.action |= ATA_EH_RESET;
 		goto retry;
 	}
 
@@ -1142,7 +1142,7 @@ static int sata_pmp_eh_recover(struct ata_port *ap,
 	if (--pmp_tries) {
 		ata_port_printk(ap, KERN_WARNING,
 				"failed to recover PMP, retrying in 5 secs\n");
-		pmp_ehc->i.action |= ATA_EH_HARDRESET;
+		pmp_ehc->i.action |= ATA_EH_RESET;
 		ssleep(5);
 		goto retry;
 	}
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 14daf48..ca499d9 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3422,7 +3422,7 @@ static int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 		ata_port_for_each_link(link, ap) {
 			struct ata_eh_info *ehi = &link->eh_info;
 			ehi->probe_mask |= (1 << ata_link_max_devices(link)) - 1;
-			ehi->action |= ATA_EH_SOFTRESET;
+			ehi->action |= ATA_EH_RESET;
 		}
 	} else {
 		struct ata_device *dev = ata_find_dev(ap, devno);
@@ -3430,7 +3430,7 @@ static int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 		if (dev) {
 			struct ata_eh_info *ehi = &dev->link->eh_info;
 			ehi->probe_mask |= 1 << dev->devno;
-			ehi->action |= ATA_EH_SOFTRESET;
+			ehi->action |= ATA_EH_RESET;
 			ehi->flags |= ATA_EHI_RESUME_LINK;
 		} else
 			rc = -EINVAL;
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index b7ac80b..a4dece2 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -335,6 +335,33 @@ void ata_bmdma_stop(struct ata_queued_cmd *qc)
 }
 
 /**
+ *	atapi_sff_dev_reset - Perform ATAPI DEVICE RESET
+ *	@dev: target ATAPI device
+ *
+ *	Perform ATAPI DEVICE RESET (0x08).
+ *
+ *	LOCKING:
+ *	EH thread context
+ *
+ *	RETURNS:
+ *	0 on success, AC_ERR_* mask otherwise.
+ */
+int atapi_sff_dev_reset(struct ata_device *dev)
+{
+	struct ata_port *ap = dev->link->ap;
+	struct ata_taskfile tf;
+
+	ata_tf_init(dev, &tf);
+	tf.command = ATA_CMD_DEV_RESET;
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE | ATA_TFLAG_POLLING;
+
+	ata_dev_select(ap, dev->devno, 1, 1); /* select device 0/1 */
+	ap->ops->exec_command(ap, &tf);
+
+	return ata_wait_ready(ap, jiffies + 5 * HZ);
+}
+
+/**
  *	ata_bmdma_freeze - Freeze BMDMA controller port
  *	@ap: port to freeze
  *
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index bbe59c2..48fb91a 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -41,7 +41,10 @@ struct ata_scsi_args {
 /* libata-core.c */
 enum {
 	/* flags for ata_dev_read_id() */
-	ATA_READID_POSTRESET	= (1 << 0), /* reading ID after reset */
+	ATA_READID_POST_SOFTRESET	= (1 << 0), /* reading ID after srst */
+	ATA_READID_POST_HARDRESET	= (1 << 1), /* reading ID after hrst */
+	ATA_READID_POST_RESET		= ATA_READID_POST_SOFTRESET |
+					  ATA_READID_POST_HARDRESET,
 
 	/* selector for ata_down_xfermask_limit() */
 	ATA_DNXFER_PIO		= 0,	/* speed down PIO */
diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
index e4542ab..27341c7 100644
--- a/drivers/ata/pata_acpi.c
+++ b/drivers/ata/pata_acpi.c
@@ -307,6 +307,7 @@ static const struct ata_port_operations pacpi_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= pacpi_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= pacpi_cable_detect,
diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 8caf9af..f272c95 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -332,6 +332,7 @@ static struct ata_port_operations ali_early_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -366,6 +367,7 @@ static struct ata_port_operations ali_20_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -404,6 +406,7 @@ static struct ata_port_operations ali_c2_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ali_c2_cable_detect,
@@ -441,6 +444,7 @@ static struct ata_port_operations ali_c5_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ali_c2_cable_detect,
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 3cc27b5..91a939a 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -344,6 +344,7 @@ static struct ata_port_operations amd33_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= amd_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -377,6 +378,7 @@ static struct ata_port_operations amd66_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= amd_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_unknown,
@@ -410,6 +412,7 @@ static struct ata_port_operations amd100_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= amd_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_unknown,
@@ -443,6 +446,7 @@ static struct ata_port_operations amd133_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= amd_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= amd_cable_detect,
@@ -476,6 +480,7 @@ static struct ata_port_operations nv100_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= nv_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= nv_cable_detect,
@@ -509,6 +514,7 @@ static struct ata_port_operations nv133_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= nv_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= nv_cable_detect,
diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index d421831..556622d 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -344,6 +344,7 @@ static const struct ata_port_operations artop6210_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= artop6210_error_handler,
 	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_40wire,
@@ -376,6 +377,7 @@ static const struct ata_port_operations artop6260_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= artop6260_error_handler,
 	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= artop6260_cable_detect,
diff --git a/drivers/ata/pata_at32.c b/drivers/ata/pata_at32.c
index 67e574d..5b6fd34 100644
--- a/drivers/ata/pata_at32.c
+++ b/drivers/ata/pata_at32.c
@@ -199,6 +199,7 @@ static struct ata_port_operations at32_port_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_40wire,
diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 9623f52..0f5d2d3 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -250,6 +250,7 @@ static struct ata_port_operations atiixp_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= atiixp_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= atiixp_cable_detect,
diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index 7842cc4..580f067 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -1396,6 +1396,7 @@ static const struct ata_port_operations bfin_pata_ops = {
 
 	.freeze			= bfin_bmdma_freeze,
 	.thaw			= bfin_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= bfin_error_handler,
 	.post_internal_cmd	= bfin_bmdma_stop,
 
diff --git a/drivers/ata/pata_cmd640.c b/drivers/ata/pata_cmd640.c
index 43d198f..ce517df 100644
--- a/drivers/ata/pata_cmd640.c
+++ b/drivers/ata/pata_cmd640.c
@@ -194,6 +194,7 @@ static struct ata_port_operations cmd640_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index 7acbbd9..b840a3f 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -295,6 +295,7 @@ static struct ata_port_operations cmd64x_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -328,6 +329,7 @@ static struct ata_port_operations cmd646r1_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -361,6 +363,7 @@ static struct ata_port_operations cmd648_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= cmd648_cable_detect,
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 33f7f08..c17ade5 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -169,6 +169,7 @@ static struct ata_port_operations cs5520_port_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_40wire,
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index e1818fd..1a865dd 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -196,6 +196,7 @@ static struct ata_port_operations cs5530_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index 0132453..fd3abc3 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -188,6 +188,7 @@ static struct ata_port_operations cs5535_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= cs5535_cable_detect,
diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index d753e56..bb176a9 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -251,6 +251,7 @@ static struct ata_port_operations cs5536_port_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= cs5536_cable_detect,
diff --git a/drivers/ata/pata_cypress.c b/drivers/ata/pata_cypress.c
index fc5f9c4..e011689 100644
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -140,6 +140,7 @@ static struct ata_port_operations cy82c693_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff --git a/drivers/ata/pata_efar.c b/drivers/ata/pata_efar.c
index 043dcd3..dfa7779 100644
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -263,6 +263,7 @@ static const struct ata_port_operations efar_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= efar_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= efar_cable_detect,
diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 0713872..9a3f1e8 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -324,6 +324,7 @@ static struct ata_port_operations hpt366_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= hpt36x_cable_detect,
diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index c79f066..a4d0196 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -653,6 +653,7 @@ static struct ata_port_operations hpt370_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= hpt37x_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 
@@ -690,6 +691,7 @@ static struct ata_port_operations hpt370a_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= hpt37x_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 
@@ -728,6 +730,7 @@ static struct ata_port_operations hpt372_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= hpt37x_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 
@@ -766,6 +769,7 @@ static struct ata_port_operations hpt374_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= hpt374_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 
diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index 9f1c084..1f2ce6e 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -373,6 +373,7 @@ static struct ata_port_operations hpt3x2n_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= hpt3x2n_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= hpt3x2n_cable_detect,
diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index cb8bdb6..bd27235 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -134,6 +134,7 @@ static struct ata_port_operations hpt3x3_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff --git a/drivers/ata/pata_icside.c b/drivers/ata/pata_icside.c
index 842fe08..5ed32f4 100644
--- a/drivers/ata/pata_icside.c
+++ b/drivers/ata/pata_icside.c
@@ -382,6 +382,7 @@ static struct ata_port_operations pata_icside_port_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= pata_icside_error_handler,
 	.post_internal_cmd	= pata_icside_bmdma_stop,
 
diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index 4320e79..1d2e049 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -46,6 +46,7 @@ static struct ata_port_operations isapnp_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff --git a/drivers/ata/pata_it8213.c b/drivers/ata/pata_it8213.c
index 1eda821..f5f4fef 100644
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -273,6 +273,7 @@ static const struct ata_port_operations it8213_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= it8213_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= it8213_cable_detect,
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index ca9aae0..692b338 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -667,6 +667,8 @@ static struct ata_port_operations it821x_passthru_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_unknown,
diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index 120b5bf..42470af 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -115,6 +115,7 @@ static struct ata_port_operations ixp4xx_port_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index 5b8174d..75f1811 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -149,6 +149,7 @@ static const struct ata_port_operations jmicron_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= jmicron_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 17159b5..1b8143c 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -297,6 +297,7 @@ static struct ata_port_operations pdc20230_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -351,6 +352,7 @@ static struct ata_port_operations ht6560a_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -416,6 +418,8 @@ static struct ata_port_operations ht6560b_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -536,6 +540,7 @@ static struct ata_port_operations opti82c611a_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -668,6 +673,11 @@ static struct ata_port_operations opti82c46x_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
+	.atapi_dev_reset = atapi_sff_dev_reset,
+	.atapi_dev_reset = atapi_sff_dev_reset,
+	.atapi_dev_reset = atapi_sff_dev_reset,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index 9afc8a3..40294d7 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -120,6 +120,7 @@ static const struct ata_port_operations marvell_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= marvell_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= marvell_cable_detect,
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 50c56e2..f4b1408 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -291,6 +291,7 @@ static struct ata_port_operations mpc52xx_ata_port_ops = {
 	.exec_command		= ata_exec_command,
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= mpc52xx_ata_error_handler,
 	.cable_detect		= ata_cable_40wire,
 	.qc_prep		= ata_qc_prep,
diff --git a/drivers/ata/pata_mpiix.c b/drivers/ata/pata_mpiix.c
index c0d9e0c..f3bd458 100644
--- a/drivers/ata/pata_mpiix.c
+++ b/drivers/ata/pata_mpiix.c
@@ -179,6 +179,7 @@ static struct ata_port_operations mpiix_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= mpiix_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff --git a/drivers/ata/pata_netcell.c b/drivers/ata/pata_netcell.c
index 25c922a..f271f7f 100644
--- a/drivers/ata/pata_netcell.c
+++ b/drivers/ata/pata_netcell.c
@@ -49,6 +49,7 @@ static const struct ata_port_operations netcell_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_80wire,
diff --git a/drivers/ata/pata_ns87410.c b/drivers/ata/pata_ns87410.c
index 9fe66fd..ce57754 100644
--- a/drivers/ata/pata_ns87410.c
+++ b/drivers/ata/pata_ns87410.c
@@ -172,6 +172,7 @@ static struct ata_port_operations ns87410_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ns87410_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
index d0e2e50..1d9b57e 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -311,6 +311,7 @@ static const struct ata_port_operations ns87560_pata_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_40wire,
@@ -346,6 +347,7 @@ static const struct ata_port_operations ns87415_pata_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_40wire,
diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index 44da09a..f49f361 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -250,6 +250,7 @@ static const struct ata_port_operations oldpiix_pata_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= oldpiix_pata_error_handler,
 	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_40wire,
diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
index 8f79447..4bec33f 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -193,6 +193,7 @@ static struct ata_port_operations opti_port_ops = {
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= opti_error_handler,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
 
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index f9b485a..234d386 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -380,6 +380,7 @@ static struct ata_port_operations optidma_port_ops = {
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= optidma_error_handler,
 	.set_mode	= optidma_set_mode,
 	.cable_detect	= ata_cable_40wire,
@@ -414,6 +415,7 @@ static struct ata_port_operations optiplus_port_ops = {
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= optidma_error_handler,
 	.set_mode	= optidma_set_mode,
 	.cable_detect	= ata_cable_40wire,
diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index fd36099..e667544 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -114,6 +114,8 @@ static struct ata_port_operations pcmcia_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 2622577..05633a5 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -166,6 +166,7 @@ static struct ata_port_operations pdc2027x_pata100_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= pdc2027x_error_handler,
 	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= pdc2027x_cable_detect,
@@ -199,6 +200,7 @@ static struct ata_port_operations pdc2027x_pata133_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= pdc2027x_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= pdc2027x_cable_detect,
diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index 6c9689b..894b6ef 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -292,6 +292,7 @@ static struct ata_port_operations pdc2024x_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -326,6 +327,7 @@ static struct ata_port_operations pdc2026x_port_ops = {
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= pdc2026x_cable_detect,
 
diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index ac03a90..7f14598 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -77,6 +77,7 @@ static struct ata_port_operations pata_platform_port_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_unknown,
diff --git a/drivers/ata/pata_qdi.c b/drivers/ata/pata_qdi.c
index a4c0e50..612b576 100644
--- a/drivers/ata/pata_qdi.c
+++ b/drivers/ata/pata_qdi.c
@@ -178,6 +178,7 @@ static struct ata_port_operations qdi6500_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
@@ -204,6 +205,7 @@ static struct ata_port_operations qdi6580_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index 8109b08..8ec9a25 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -215,6 +215,7 @@ static const struct ata_port_operations radisys_pata_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_unknown,
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index ba8a31c..62b32ad 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -91,6 +91,7 @@ static struct ata_port_operations rz1000_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff --git a/drivers/ata/pata_sc1200.c b/drivers/ata/pata_sc1200.c
index 725a858..f3b014e 100644
--- a/drivers/ata/pata_sc1200.c
+++ b/drivers/ata/pata_sc1200.c
@@ -209,6 +209,7 @@ static struct ata_port_operations sc1200_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index ea2ef9f..86d572c 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -1005,6 +1005,7 @@ static const struct ata_port_operations scc_pata_ops = {
 	.qc_issue		= ata_qc_issue_prot,
 
 	.freeze			= scc_bmdma_freeze,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= scc_error_handler,
 	.post_internal_cmd	= scc_bmdma_stop,
 
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index 8bed888..ad9cbb3 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -329,6 +329,7 @@ static struct ata_port_operations serverworks_osb4_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= serverworks_cable_detect,
@@ -363,6 +364,7 @@ static struct ata_port_operations serverworks_csb_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= serverworks_cable_detect,
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 503245a..ef50bcd 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -221,6 +221,7 @@ static struct ata_port_operations sil680_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= sil680_cable_detect,
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index 87546d9..53350d7 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -544,6 +544,7 @@ static const struct ata_port_operations sis_133_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= sis_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= sis_133_cable_detect,
@@ -576,6 +577,7 @@ static const struct ata_port_operations sis_133_for_sata_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= sis_133_cable_detect,
@@ -608,6 +610,7 @@ static const struct ata_port_operations sis_133_early_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= sis_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= sis_66_cable_detect,
@@ -640,6 +643,7 @@ static const struct ata_port_operations sis_100_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= sis_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= sis_66_cable_detect,
@@ -673,6 +677,7 @@ static const struct ata_port_operations sis_66_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= sis_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
@@ -704,6 +709,7 @@ static const struct ata_port_operations sis_old_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= sis_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_40wire,
diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index 1388cef..9f1e3c3 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -236,6 +236,7 @@ static struct ata_port_operations sl82c105_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= sl82c105_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff --git a/drivers/ata/pata_triflex.c b/drivers/ata/pata_triflex.c
index 403eafc..1e9e4ef 100644
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -209,6 +209,7 @@ static struct ata_port_operations triflex_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= triflex_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 453d72b..9b8d830 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -360,6 +360,7 @@ static struct ata_port_operations via_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= via_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= via_cable_detect,
@@ -394,6 +395,7 @@ static struct ata_port_operations via_port_ops_noirq = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= via_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= via_cable_detect,
diff --git a/drivers/ata/pata_winbond.c b/drivers/ata/pata_winbond.c
index 7116a9e..e978e4c 100644
--- a/drivers/ata/pata_winbond.c
+++ b/drivers/ata/pata_winbond.c
@@ -146,6 +146,7 @@ static struct ata_port_operations winbond_port_ops = {
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
+	.atapi_dev_reset = atapi_sff_dev_reset,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index bd4c2a3..6d7bce8 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -173,6 +173,7 @@ static const struct ata_port_operations adma_ata_ops = {
 	.qc_issue		= adma_qc_issue,
 	.freeze			= adma_freeze,
 	.thaw			= adma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= adma_error_handler,
 	.irq_clear		= adma_irq_clear,
 	.irq_on			= ata_irq_on,
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index d015b4a..94fc561 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1006,7 +1006,7 @@ static void sata_fsl_error_intr(struct ata_port *ap)
 	/* handle fatal errors */
 	if (hstatus & FATAL_ERROR_DECODE) {
 		err_mask |= AC_ERR_ATA_BUS;
-		action |= ATA_EH_SOFTRESET;
+		action |= ATA_EH_RESET;
 		/* how will fatal error interrupts be completed ?? */
 		freeze = 1;
 	}
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 37b850a..e1c9632 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1429,7 +1429,7 @@ static void mv_err_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
 			EDMA_ERR_CRQB_PAR | EDMA_ERR_CRPB_PAR |
 			EDMA_ERR_INTRL_PAR)) {
 		err_mask |= AC_ERR_ATA_BUS;
-		action |= ATA_EH_HARDRESET;
+		action |= ATA_EH_RESET;
 		ata_ehi_push_desc(ehi, "parity error");
 	}
 	if (edma_err_cause & (EDMA_ERR_DEV_DCON | EDMA_ERR_DEV_CON)) {
@@ -1459,7 +1459,7 @@ static void mv_err_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
 			sata_scr_read(&ap->link, SCR_ERROR, &serr);
 			sata_scr_write_flush(&ap->link, SCR_ERROR, serr);
 			err_mask = AC_ERR_ATA_BUS;
-			action |= ATA_EH_HARDRESET;
+			action |= ATA_EH_RESET;
 		}
 	}
 
@@ -1468,7 +1468,7 @@ static void mv_err_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
 
 	if (!err_mask) {
 		err_mask = AC_ERR_OTHER;
-		action |= ATA_EH_HARDRESET;
+		action |= ATA_EH_RESET;
 	}
 
 	ehi->serror |= serr;
@@ -1683,7 +1683,7 @@ static void mv_pci_error(struct ata_host *host, void __iomem *mmio)
 				ata_ehi_push_desc(ehi,
 					"PCI err cause 0x%08x", err_cause);
 			err_mask = AC_ERR_HOST_BUS;
-			ehi->action = ATA_EH_HARDRESET;
+			ehi->action = ATA_EH_RESET;
 			qc = ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc)
 				qc->err_mask |= err_mask;
@@ -2265,15 +2265,15 @@ static int mv_prereset(struct ata_link *link, unsigned long deadline)
 
 	rc = mv_stop_dma(ap);
 	if (rc)
-		ehc->i.action |= ATA_EH_HARDRESET;
+		ehc->i.action |= ATA_EH_RESET;
 
 	if (!(pp->pp_flags & MV_PP_FLAG_HAD_A_RESET)) {
 		pp->pp_flags |= MV_PP_FLAG_HAD_A_RESET;
-		ehc->i.action |= ATA_EH_HARDRESET;
+		ehc->i.action |= ATA_EH_RESET;
 	}
 
 	/* if we're about to do hardreset, nothing more to do */
-	if (ehc->i.action & ATA_EH_HARDRESET)
+	if (ehc->i.action & ATA_EH_RESET)
 		return 0;
 
 	if (ata_link_online(link))
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index ed5dc7c..33e4fa2 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -890,7 +890,7 @@ static int nv_adma_check_cpb(struct ata_port *ap, int cpb_num, int force_err)
 					"notifier for tag %d with no cmd?\n",
 					cpb_num);
 			ehi->err_mask |= AC_ERR_HSM;
-			ehi->action |= ATA_EH_SOFTRESET;
+			ehi->action |= ATA_EH_RESET;
 			ata_port_freeze(ap);
 			return 1;
 		}
@@ -1831,7 +1831,7 @@ static void nv_swncq_error_handler(struct ata_port *ap)
 
 	if (ap->link.sactive) {
 		nv_swncq_ncq_stop(ap);
-		ehc->i.action |= ATA_EH_HARDRESET;
+		ehc->i.action |= ATA_EH_RESET;
 	}
 
 	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset,
@@ -2116,7 +2116,7 @@ static int nv_swncq_sdbfis(struct ata_port *ap)
 		ata_ehi_clear_desc(ehi);
 		ata_ehi_push_desc(ehi, "BMDMA stat 0x%x", host_stat);
 		ehi->err_mask |= AC_ERR_HOST_BUS;
-		ehi->action |= ATA_EH_SOFTRESET;
+		ehi->action |= ATA_EH_RESET;
 		return -EINVAL;
 	}
 
@@ -2131,7 +2131,7 @@ static int nv_swncq_sdbfis(struct ata_port *ap)
 		ata_ehi_push_desc(ehi, "illegal SWNCQ:qc_active transition"
 				  "(%08x->%08x)", pp->qc_active, sactive);
 		ehi->err_mask |= AC_ERR_HSM;
-		ehi->action |= ATA_EH_HARDRESET;
+		ehi->action |= ATA_EH_RESET;
 		return -EINVAL;
 	}
 	for (i = 0; i < ATA_MAX_QUEUE; i++) {
@@ -2267,7 +2267,7 @@ static void nv_swncq_host_interrupt(struct ata_port *ap, u16 fis)
 		ata_ehi_push_desc(ehi, "Ata error. fis:0x%X", fis);
 		ehi->err_mask |= AC_ERR_DEV;
 		ehi->serror |= serror;
-		ehi->action |= ATA_EH_SOFTRESET;
+		ehi->action |= ATA_EH_RESET;
 		ata_port_freeze(ap);
 		return;
 	}
@@ -2299,7 +2299,7 @@ static void nv_swncq_host_interrupt(struct ata_port *ap, u16 fis)
 		if (pp->ncq_flags & (ncq_saw_sdb | ncq_saw_backout)) {
 			ata_ehi_push_desc(ehi, "illegal fis transaction");
 			ehi->err_mask |= AC_ERR_HSM;
-			ehi->action |= ATA_EH_HARDRESET;
+			ehi->action |= ATA_EH_RESET;
 			goto irq_error;
 		}
 
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 7914def..eda298c 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -231,6 +231,7 @@ static const struct ata_port_operations pdc_pata_ops = {
 	.qc_issue		= pdc_qc_issue_prot,
 	.freeze			= pdc_freeze,
 	.thaw			= pdc_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= pdc_pata_error_handler,
 	.post_internal_cmd	= pdc_post_internal_cmd,
 	.cable_detect		= pdc_pata_cable_detect,
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 864c1c1..3dfb8ab 100644
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
 
@@ -1038,7 +1038,7 @@ static void sil24_error_intr(struct ata_port *ap)
 
 	if (irq_stat & PORT_IRQ_UNK_FIS) {
 		ehi->err_mask |= AC_ERR_HSM;
-		ehi->action |= ATA_EH_SOFTRESET;
+		ehi->action |= ATA_EH_RESET;
 		ata_ehi_push_desc(ehi, "unknown FIS");
 		freeze = 1;
 	}
@@ -1059,7 +1059,7 @@ static void sil24_error_intr(struct ata_port *ap)
 		 */
 		if (ap->nr_active_links >= 3) {
 			ehi->err_mask |= AC_ERR_OTHER;
-			ehi->action |= ATA_EH_HARDRESET;
+			ehi->action |= ATA_EH_RESET;
 			ata_ehi_push_desc(ehi, "PMP DMA CS errata");
 			pp->do_port_rst = 1;
 			freeze = 1;
@@ -1080,7 +1080,7 @@ static void sil24_error_intr(struct ata_port *ap)
 						  irq_stat);
 			} else {
 				err_mask |= AC_ERR_HSM;
-				action |= ATA_EH_HARDRESET;
+				action |= ATA_EH_RESET;
 				freeze = 1;
 			}
 		} else
@@ -1094,12 +1094,12 @@ static void sil24_error_intr(struct ata_port *ap)
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
@@ -1169,7 +1169,7 @@ static inline void sil24_host_intr(struct ata_port *ap)
 	if (rc < 0) {
 		struct ata_eh_info *ehi = &ap->link.eh_info;
 		ehi->err_mask |= AC_ERR_HSM;
-		ehi->action |= ATA_EH_SOFTRESET;
+		ehi->action |= ATA_EH_RESET;
 		ata_port_freeze(ap);
 		return;
 	}
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 3ef072f..b513555 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -137,6 +137,7 @@ static const struct ata_port_operations vt6420_sata_ops = {
 
 	.freeze			= svia_noop_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= vt6420_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
@@ -167,6 +168,7 @@ static const struct ata_port_operations vt6421_pata_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
+	.atapi_dev_reset	= atapi_sff_dev_reset,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= vt6421_pata_cable_detect,
@@ -322,7 +324,7 @@ static int vt6420_prereset(struct ata_link *link, unsigned long deadline)
 
 	if (!online) {
 		/* tell EH to bail */
-		ehc->i.action &= ~ATA_EH_RESET_MASK;
+		ehc->i.action &= ~ATA_EH_RESET;
 		return 0;
 	}
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 124033c..c78bb3e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -298,9 +298,9 @@ enum {
 	ATA_EH_REVALIDATE	= (1 << 0),
 	ATA_EH_SOFTRESET	= (1 << 1),
 	ATA_EH_HARDRESET	= (1 << 2),
+	ATA_EH_RESET		= ATA_EH_SOFTRESET | ATA_EH_HARDRESET,
 	ATA_EH_ENABLE_LINK	= (1 << 3),
 
-	ATA_EH_RESET_MASK	= ATA_EH_SOFTRESET | ATA_EH_HARDRESET,
 	ATA_EH_PERDEV_MASK	= ATA_EH_REVALIDATE,
 
 	/* ata_eh_info->flags */
@@ -724,6 +724,8 @@ struct ata_port_operations {
 
 	void (*bmdma_stop) (struct ata_queued_cmd *qc);
 	u8   (*bmdma_status) (struct ata_port *ap);
+
+	int (*atapi_dev_reset)(struct ata_device *dev);
 };
 
 struct ata_port_info {
@@ -878,6 +880,7 @@ extern void ata_id_c_string(const u16 *id, unsigned char *s,
 extern void ata_id_to_dma_mode(struct ata_device *dev, u8 unknown);
 extern void ata_bmdma_setup(struct ata_queued_cmd *qc);
 extern void ata_bmdma_start(struct ata_queued_cmd *qc);
+extern int atapi_sff_dev_reset(struct ata_device *dev);
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
 extern u8   ata_bmdma_status(struct ata_port *ap);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);

--------------010701040001030502000702--
