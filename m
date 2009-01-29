From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/8] libata: improve probe failure handling
Date: Thu, 29 Jan 2009 20:31:34 +0900
Message-ID: <1233228696-10562-7-git-send-email-tj@kernel.org>
References: <1233228696-10562-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34110 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752924AbZA2LcI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jan 2009 06:32:08 -0500
In-Reply-To: <1233228696-10562-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

When link is flaky at high speed, it isn't uncommon for a device to
repeatedly fail probing sequence early after successfully negotiating
high link speed.  This often leads to consecutive hotplug events
without successful probing.

This patch improves libata EH such that it remembers probing trials
and if there have been more than two unsuccessful trials in the past
60 seconds, slows down link speed to 1.5Gbps.

As link speed negotiation is the duty of the PHY layer proper, the
goal of this fallback mechanism is to provide the last resort when
everything else fails, which unfortunately happens not too
infrequently, so no fancy 6->3->1.5 speeding down or highest
successful transmission speed seen kind of logics (yet).

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-eh.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 685509b..caa1e9f 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -82,6 +82,10 @@ enum {
 	ATA_EH_FASTDRAIN_INTERVAL	=  3000,
 
 	ATA_EH_UA_TRIES			= 5,
+
+	/* probe speed down parameters, see ata_eh_schedule_probe() */
+	ATA_EH_PROBE_TRIAL_INTERVAL	= 60000,	/* 1 min */
+	ATA_EH_PROBE_TRIALS		= 2,
 };
 
 /* The following table determines how we sequence resets.  Each entry
@@ -2975,9 +2979,24 @@ static int ata_eh_skip_recovery(struct ata_link *link)
 	return 1;
 }
 
+static int ata_count_probe_trials_cb(struct ata_ering_entry *ent, void *void_arg)
+{
+	u64 interval = msecs_to_jiffies(ATA_EH_PROBE_TRIAL_INTERVAL);
+	u64 now = get_jiffies_64();
+	int *trials = void_arg;
+
+	if (ent->timestamp < now - min(now, interval))
+		return -1;
+
+	(*trials)++;
+	return 0;
+}
+
 static int ata_eh_schedule_probe(struct ata_device *dev)
 {
 	struct ata_eh_context *ehc = &dev->link->eh_context;
+	struct ata_link *link = ata_dev_phys_link(dev);
+	int trials = 0;
 
 	if (!(ehc->i.probe_mask & (1 << dev->devno)) ||
 	    (ehc->did_probe_mask & (1 << dev->devno)))
@@ -2990,6 +3009,25 @@ static int ata_eh_schedule_probe(struct ata_device *dev)
 	ehc->saved_xfer_mode[dev->devno] = 0;
 	ehc->saved_ncq_enabled &= ~(1 << dev->devno);
 
+	/* Record and count probe trials on the ering.  The specific
+	 * error mask used is irrelevant.  Because a successful device
+	 * detection clears the ering, this count accumulates only if
+	 * there are consecutive failed probes.
+	 *
+	 * If the count is equal to or higher than ATA_EH_PROBE_TRIALS
+	 * in the last ATA_EH_PROBE_TRIAL_INTERVAL, link speed is
+	 * forced to 1.5Gbps.
+	 *
+	 * This is to work around cases where failed link speed
+	 * negotiation results in device misdetection leading to
+	 * infinite DEVXCHG or PHRDY CHG events.
+	 */
+	ata_ering_record(&dev->ering, 0, AC_ERR_OTHER);
+	ata_ering_map(&dev->ering, ata_count_probe_trials_cb, &trials);
+
+	if (trials > ATA_EH_PROBE_TRIALS)
+		sata_down_spd_limit(link, 1);
+
 	return 1;
 }
 
-- 
1.6.0.2

