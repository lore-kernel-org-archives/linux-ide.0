From: Tejun Heo <htejun@gmail.com>
Subject: Re: [ANNOUNCE] new revision of PMP support patchsets are about to be posted
Date: Mon, 10 Jul 2006 23:29:40 +0900
Message-ID: <20060710142940.GI2592@htj.dyndns.org>
References: <20060708053517.GB2592@htj.dyndns.org> <20060708112110.GD2592@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.202]:18535 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1422634AbWGJO2q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Jul 2006 10:28:46 -0400
Received: by nz-out-0102.google.com with SMTP id v1so53263nzb
        for <linux-ide@vger.kernel.org>; Mon, 10 Jul 2006 07:28:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20060708112110.GD2592@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Git tree has been updated to reflect two EH fixes just posted [1][2].

* Link resume handling in the previous version was broken causing
  libata to ignore hotplug event after a link has been hot-unplugged.
  Fixed.

* A few other hotplug related problems are fixed. 

Git trees are updated and available in the following git trees.

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=link
  git://htj.dyndns.org/libata-tj link

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=pmp-prep
  git://htj.dyndns.org/libata-tj pmp-prep

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=pmp
  git://htj.dyndns.org/libata-tj pmp

Diff from the last post [3] is at the end of this mail.

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/12001
[2] http://article.gmane.org/gmane.linux.ide/12002
[3] http://article.gmane.org/gmane.linux.ide/11967

 drivers/scsi/libata-eh.c  |   48 +++++++++++++++++++++++++++++++++++-----------
 drivers/scsi/libata-pmp.c |    3 +-
 drivers/scsi/sata_sil24.c |   19 ++++++++++++++++++
 include/linux/libata.h    |    4 ++-
 4 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index bdfea33..be956fc 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -814,13 +814,28 @@ void ata_eh_about_to_do(struct ata_link 
 			unsigned int action)
 {
 	struct ata_port *ap = link->ap;
+	struct ata_eh_info *ehi = &link->eh_info;
+	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned long flags;
 
 	spin_lock_irqsave(ap->lock, flags);
 
-	ata_eh_clear_action(link, dev, &link->eh_info, action);
+	/* Reset is represented by combination of actions and EHI
+	 * flags.  Suck in all related bits before clearing eh_info to
+	 * avoid losing requested action.
+	 */
+	if (action & ATA_EH_RESET_MASK) {
+		ehc->i.action |= ehi->action & ATA_EH_RESET_MASK;
+		ehc->i.flags |= ehi->flags & ATA_EHI_RESET_MODIFIER_MASK;
+
+		/* make sure all reset actions are cleared & clear EHI flags */
+		action |= ATA_EH_RESET_MASK;
+		ehi->flags &= ~ATA_EHI_RESET_MODIFIER_MASK;
+	}
+
+	ata_eh_clear_action(link, dev, ehi, action);
 
-	if (!(link->eh_context.i.flags & ATA_EHI_QUIET))
+	if (!(ehc->i.flags & ATA_EHI_QUIET))
 		ap->pflags |= ATA_PFLAG_RECOVERED;
 
 	spin_unlock_irqrestore(ap->lock, flags);
@@ -828,7 +843,7 @@ void ata_eh_about_to_do(struct ata_link 
 
 /**
  *	ata_eh_done - EH action complete
- *	@link: target ATA link
+*	@ap: target ATA port
  *	@dev: target ATA dev for per-dev action (can be NULL)
  *	@action: action just completed
  *
@@ -841,7 +856,15 @@ void ata_eh_about_to_do(struct ata_link 
 void ata_eh_done(struct ata_link *link, struct ata_device *dev,
 		 unsigned int action)
 {
-	ata_eh_clear_action(link, dev, &link->eh_context.i, action);
+	struct ata_eh_context *ehc = &link->eh_context;
+
+	/* if reset is complete, clear all reset actions & reset modifier */
+	if (action & ATA_EH_RESET_MASK) {
+		action |= ATA_EH_RESET_MASK;
+		ehc->i.flags &= ~ATA_EHI_RESET_MODIFIER_MASK;
+	}
+
+	ata_eh_clear_action(link, dev, &ehc->i, action);
 }
 
 /**
@@ -1591,6 +1614,9 @@ int ata_eh_reset(struct ata_link *link, 
 	ata_reset_fn_t reset;
 	int did_followup_srst, rc;
 
+	/* about to reset */
+	ata_eh_about_to_do(link, NULL, ehc->i.action & ATA_EH_RESET_MASK);
+
 	/* Determine which reset to use and record in ehc->i.action.
 	 * prereset() may examine and modify it.
 	 */
@@ -1639,8 +1665,7 @@ int ata_eh_reset(struct ata_link *link, 
 		ata_link_printk(link, KERN_INFO, "%s resetting port\n",
 				reset == softreset ? "soft" : "hard");
 
-	/* reset */
-	ata_eh_about_to_do(link, NULL, ATA_EH_RESET_MASK);
+	/* mark that this EH session started with reset */
 	ehc->i.flags |= ATA_EHI_DID_RESET;
 
 	rc = ata_do_reset(link, reset, classes);
@@ -1703,7 +1728,7 @@ int ata_eh_reset(struct ata_link *link, 
 			postreset(link, classes);
 
 		/* reset successful, schedule revalidation */
-		ata_eh_done(link, NULL, ATA_EH_RESET_MASK);
+		ata_eh_done(link, NULL, ehc->i.action & ATA_EH_RESET_MASK);
 		ehc->i.action |= ATA_EH_REVALIDATE;
 	}
 
@@ -1974,15 +1999,16 @@ static int ata_eh_skip_recovery(struct a
 
 	/* skip if all possible devices are suspended */
 	ata_link_for_each_dev(dev, link) {
-		if (ata_dev_absent(dev) || ata_dev_ready(dev))
+		if (!(dev->flags & ATA_DFLAG_SUSPENDED))
 			break;
 	}
 
 	if (dev == NULL)
 		return 1;
 
-	/* always thaw frozen port and recover failed devices */
-	if (link->ap->pflags & ATA_PFLAG_FROZEN || ata_link_nr_enabled(link))
+	/* thaw frozen port, resume link and recover failed devices */
+	if ((link->ap->pflags & ATA_PFLAG_FROZEN) ||
+	    (ehc->i.flags & ATA_EHI_RESUME_LINK) || ata_link_nr_enabled(link))
 		return 0;
 
 	/* skip if class codes for all vacant slots are ATA_DEV_NONE */
@@ -2194,7 +2220,7 @@ int ata_eh_recover(struct ata_port *ap, 
 			goto dev_fail;
 
 		/* this link is okay now */
-		ehc->i.flags &= ~ATA_EHI_DID_RESET;
+		ehc->i.flags = 0;
 		continue;
 
 	dev_fail:
diff --git a/drivers/scsi/libata-pmp.c b/drivers/scsi/libata-pmp.c
index c0bf4c1..f4e4ece 100644
--- a/drivers/scsi/libata-pmp.c
+++ b/drivers/scsi/libata-pmp.c
@@ -435,6 +435,7 @@ static int sata_pmp_init_links(struct at
 		struct ata_link *link = &pmp_link[i];
 		struct ata_eh_context *ehc = &link->eh_context;
 
+		link->flags = 0;
 		link->reset_tries = ATA_EH_PMP_RESET_TRIES;
 		ehc->i.probe_mask |= 1;
 		ehc->i.action |= ATA_EH_SOFTRESET;
@@ -807,7 +808,7 @@ static int sata_pmp_eh_recover_pmp(struc
 	}
 
 	/* okay, PMP resurrected */
-	ehc->i.flags &= ~ATA_EHI_DID_RESET;
+	ehc->i.flags = 0;
 
 	DPRINTK("EXIT, rc=0\n");
 	return 0;
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 3757701..399bd1e 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -320,6 +320,7 @@ struct sil24_port_priv {
 	union sil24_cmd_block *cmd_block;	/* 32 cmd blocks */
 	dma_addr_t cmd_block_dma;		/* DMA base addr for them */
 	struct ata_taskfile tf;			/* Cached taskfile registers */
+	int sdb_notify;
 	int do_port_rst;
 };
 
@@ -1035,6 +1036,7 @@ static void sil24_error_intr(struct ata_
 		ehi->err_mask |= AC_ERR_OTHER;
 		ata_ehi_push_desc(ehi, ", SDB notify");
 		ata_port_schedule_eh(ap);
+		pp->sdb_notify = 1;
 	}
 
 	/* deal with command error */
@@ -1207,12 +1209,29 @@ static void sil24_error_handler(struct a
 	if (sil24_init_port(ap))
 		ata_eh_freeze_port(ap);
 
+	/* SDB_NOTIFY often hangs the controller resulting in port
+	 * reset.  If PORT_RST is scheduled or pmp_read doesn't work
+	 * after SDB_NOTIFY, unconditionally generate hotplug events
+	 * on all PMP links.
+	 */
+	if (ap->nr_pmp_links && pp->sdb_notify) {
+		struct ata_device *pmp_dev = ap->link.device;
+		u32 tmp;
+
+		if (sil24_pmp_read(pmp_dev, SATA_PMP_CTRL_PORT, 0, &tmp)) {
+			struct ata_link *tlink;
+			ata_port_for_each_link(tlink, ap)
+				ata_ehi_hotplugged(&tlink->eh_context.i);
+		}
+	}
+
 	/* perform recovery */
 	sata_pmp_do_eh(ap, ata_std_prereset, sil24_softreset, sil24_hardreset,
 		       ata_std_postreset, sata_pmp_std_prereset,
 		       sil24_pmp_softreset, sil24_pmp_hardreset,
 		       sata_pmp_std_postreset);
 
+	pp->sdb_notify = 0;
 	pp->do_port_rst = 0;
 }
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index a90135f..e8fc080 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -279,13 +279,15 @@ enum {
 				  ATA_EH_RESUME | ATA_EH_PM_FREEZE,
 
 	/* ata_eh_info->flags */
-	ATA_EHI_HOTPLUGGED	= (1 << 0),  /* hotplugged (reset modifier) */
+	ATA_EHI_HOTPLUGGED	= (1 << 0),  /* could have been hotplugged */
 	ATA_EHI_RESUME_LINK	= (1 << 1),  /* resume link (reset modifier) */
 	ATA_EHI_NO_AUTOPSY	= (1 << 2),  /* no autopsy */
 	ATA_EHI_QUIET		= (1 << 3),  /* be quiet */
 
 	ATA_EHI_DID_RESET	= (1 << 16), /* already reset this port */
 
+	ATA_EHI_RESET_MODIFIER_MASK = ATA_EHI_RESUME_LINK,
+
 	/* max repeat if error condition is still set after ->error_handler */
 	ATA_EH_MAX_REPEAT	= 5,
 
