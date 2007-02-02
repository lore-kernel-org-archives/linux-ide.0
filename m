From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/4] libata: reimplement reset sequencing
Date: Fri, 2 Feb 2007 16:50:52 +0900
Message-ID: <11704026522917-git-send-email-htejun@gmail.com>
References: <11704026511717-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:64551 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423203AbXBBHvA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 02:51:00 -0500
Received: by wr-out-0506.google.com with SMTP id 68so643749wri
        for <linux-ide@vger.kernel.org>; Thu, 01 Feb 2007 23:50:59 -0800 (PST)
In-Reply-To: <11704026511717-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, ric@emc.com, edmudama@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

libata previously depended upon waits in prereset to get resets after
hotplug right for both spin up and device ready wait.  This was
necessary both for reliablity and speed as reset was likely to fail if
initiated too early and each try usually took more than 30secs to
fail.  Previous patches fixed the reliability part by fixing status
and SCR handling in resets.  This patch remedies the speed part by
improving reset sequencing.

Prereset waiting timeout is adjusted to 10s because spinup wait is
replaced by reset sequencing and !BSY wait is not as important as
before.  During boot or module loading where the drive is already
fully spun up, !BSY wait succeeds immediately, so 10s should be enough
in most cases.  It matters after hotplugging or other error
conditions, but in those cases, !BSY wait in prereset simply can't be
relied upon due to the varied and weird behaviors ATA controllers and
devices show.

Reset is now driven by ata_eh_reset_timeouts[] table which contains
timeouts for each reset try.  The first reset can be softreset but the
following ones are always hardreset if available.  Each timeout
defines deadline for the reset try.  If a reset try fails, reset is
retried with the next timeout till the end of the timeout table is
reached.  If a reset try fails before the timeout with error, libata
waits till the deadline of the failed try before retrying.

IOW, the timeout table defines timetable of reset tries such that the
n'th try always begins at least after the sum of all previous timeouts
has passed.  The current timetable defines 4 tries and takes around 1
minute.

@0	: First try.  This should succeed most of the time during boot.
@10	: 10s is enough to spin up most consumer harddrives.  Give it
	  another shot.
@20	: 20s should spin up > 99% of working drives.  This has 30s
	  timeout for retarded devices needing long idleness post reset.
@55	: Final try with 5s timeout just in case.

The above timetable is trade off between not annoying the device too
much with frequent resets and taking reasonable amount of time in most
cases.  Some controllers may do better with shorter timeouts while
others may fare better with longer but we just can't rely upon LLD
writers to test each controller with wide variety of devices using
various scenarios.  We need default behavior which reasonably fits
most cases.

I've tested the above timetable on a dozen SATA controllers and a few
PATA controllers with about a dozen different drives from all major
vendors and 4 different ODDs from three different vendors for both
boot and hotplug (if available) cases.

Boot probing is not affected unless the device is broken in which
cases new code gives up on the port after a minute rather than five or
nine minutes.  When hotplugging, most devices get detected on the
first or second try.  Multi-platter drives with long spin up time
which sometimes took > 40 secs with the original code, now usually
comes up during the second try and at least right after the third try
@20.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   35 +--------------------------
 drivers/ata/libata-eh.c   |   58 +++++++++++++++++++++++++++++++-------------
 include/linux/libata.h    |   16 ------------
 3 files changed, 42 insertions(+), 67 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 03ad181..3d9cd4f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2894,35 +2894,6 @@ int sata_phy_resume(struct ata_port *ap, const unsigned long *params,
 	return sata_phy_debounce(ap, params, deadline);
 }
 
-static void ata_wait_spinup(struct ata_port *ap, unsigned long deadline)
-{
-	struct ata_eh_context *ehc = &ap->eh_context;
-	unsigned long end, secs;
-	int rc;
-
-	/* first, debounce phy if SATA */
-	if (ap->cbl == ATA_CBL_SATA) {
-		rc = sata_phy_debounce(ap, sata_deb_timing_hotplug, deadline);
-
-		/* if debounced successfully and offline, no need to wait */
-		if ((rc == 0 || rc == -EOPNOTSUPP) && ata_port_offline(ap))
-			return;
-	}
-
-	/* okay, let's give the drive time to spin up */
-	end = ehc->i.hotplug_timestamp + ATA_SPINUP_WAIT * HZ / 1000;
-	secs = ((end - jiffies) + HZ - 1) / HZ;
-
-	if (time_after(jiffies, end))
-		return;
-
-	if (secs > 5)
-		ata_port_printk(ap, KERN_INFO, "waiting for device to spin up "
-				"(%lu secs)\n", secs);
-
-	schedule_timeout_uninterruptible(end - jiffies);
-}
-
 /**
  *	ata_std_prereset - prepare for reset
  *	@ap: ATA port to be reset
@@ -2946,15 +2917,11 @@ int ata_std_prereset(struct ata_port *ap, unsigned long deadline)
 	const unsigned long *timing = sata_ehc_deb_timing(ehc);
 	int rc;
 
-	/* handle link resume & hotplug spinup */
+	/* handle link resume */
 	if ((ehc->i.flags & ATA_EHI_RESUME_LINK) &&
 	    (ap->flags & ATA_FLAG_HRST_TO_RESUME))
 		ehc->i.action |= ATA_EH_HARDRESET;
 
-	if ((ehc->i.flags & ATA_EHI_HOTPLUGGED) &&
-	    (ap->flags & ATA_FLAG_SKIP_D2H_BSY))
-		ata_wait_spinup(ap, deadline);
-
 	/* if we're about to do hardreset, nothing more to do */
 	if (ehc->i.action & ATA_EH_HARDRESET)
 		return 0;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7118995..642af6b 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -50,6 +50,28 @@ enum {
 	ATA_EH_SPDN_FALLBACK_TO_PIO	= (1 << 2),
 };
 
+/* Waiting in ->prereset can never be reliable.  It's sometimes nice
+ * to wait there but it can't be depended upon; otherwise, we wouldn't
+ * be resetting.  Just give it enough time for most drives to spin up.
+ */
+enum {
+	ATA_EH_PRERESET_TIMEOUT		= 10 * HZ,
+};
+
+/* The following table determines how we sequence resets.  Each entry
+ * represents timeout for that try.  The first try can be soft or
+ * hardreset.  All others are hardreset if available.  In most cases
+ * the first reset w/ 10sec timeout should succeed.  Following entries
+ * are mostly for error handling, hotplug and retarded devices.
+ */
+static const unsigned long ata_eh_reset_timeouts[] = {
+	10 * HZ,	/* most drives spin up by 10sec */
+	10 * HZ,	/* > 99% working drives spin up before 20sec */
+	35 * HZ,	/* give > 30 secs of idleness for retarded devices */
+	5 * HZ,		/* and sweet one last chance */
+	/* > 1 min has elapsed, give up */
+};
+
 static void __ata_port_freeze(struct ata_port *ap);
 static void ata_eh_finish(struct ata_port *ap);
 static void ata_eh_handle_port_suspend(struct ata_port *ap);
@@ -1576,8 +1598,9 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 {
 	struct ata_eh_context *ehc = &ap->eh_context;
 	unsigned int *classes = ehc->classes;
-	int tries = ATA_EH_RESET_TRIES;
 	int verbose = !(ehc->i.flags & ATA_EHI_QUIET);
+	int try = 0;
+	unsigned long deadline;
 	unsigned int action;
 	ata_reset_fn_t reset;
 	int i, did_followup_srst, rc;
@@ -1597,7 +1620,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 		ehc->i.action |= ATA_EH_HARDRESET;
 
 	if (prereset) {
-		rc = prereset(ap, jiffies + 40 * HZ);
+		rc = prereset(ap, jiffies + ATA_EH_PRERESET_TIMEOUT);
 		if (rc) {
 			if (rc == -ENOENT) {
 				ata_port_printk(ap, KERN_DEBUG, "port disabled. ignoring.\n");
@@ -1632,6 +1655,8 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 	}
 
  retry:
+	deadline = jiffies + ata_eh_reset_timeouts[try++];
+
 	/* shut up during boot probing */
 	if (verbose)
 		ata_port_printk(ap, KERN_INFO, "%s resetting port\n",
@@ -1640,7 +1665,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 	/* mark that this EH session started with reset */
 	ehc->i.flags |= ATA_EHI_DID_RESET;
 
-	rc = ata_do_reset(ap, reset, classes, jiffies + 40 * HZ);
+	rc = ata_do_reset(ap, reset, classes, deadline);
 
 	did_followup_srst = 0;
 	if (reset == hardreset &&
@@ -1657,7 +1682,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 		}
 
 		ata_eh_about_to_do(ap, NULL, ATA_EH_RESET_MASK);
-		rc = ata_do_reset(ap, reset, classes, jiffies + 40 * HZ);
+		rc = ata_do_reset(ap, reset, classes, deadline);
 
 		if (rc == 0 && classify &&
 		    classes[0] == ATA_DEV_UNKNOWN) {
@@ -1667,22 +1692,21 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 		}
 	}
 
-	if (rc && --tries) {
-		const char *type;
+	if (rc && try < ARRAY_SIZE(ata_eh_reset_timeouts)) {
+		unsigned long now = jiffies;
 
-		if (reset == softreset) {
-			if (did_followup_srst)
-				type = "follow-up soft";
-			else
-				type = "soft";
-		} else
-			type = "hard";
+		if (time_before(now, deadline)) {
+			unsigned long delta = deadline - jiffies;
 
-		ata_port_printk(ap, KERN_WARNING,
-				"%sreset failed, retrying in 5 secs\n", type);
-		ssleep(5);
+			ata_port_printk(ap, KERN_WARNING, "reset failed "
+				"(errno=%d), retrying in %u secs\n",
+				rc, (jiffies_to_msecs(delta) + 999) / 1000);
+
+			schedule_timeout_uninterruptible(delta);
+		}
 
-		if (reset == hardreset)
+		if (reset == hardreset &&
+		    try == ARRAY_SIZE(ata_eh_reset_timeouts) - 1)
 			sata_down_spd_limit(ap);
 		if (hardreset)
 			reset = hardreset;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9b1ddaf..e8d2ffc 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -293,18 +293,8 @@ enum {
 
 	/* how hard are we gonna try to probe/recover devices */
 	ATA_PROBE_MAX_TRIES	= 3,
-	ATA_EH_RESET_TRIES	= 3,
 	ATA_EH_DEV_TRIES	= 3,
 
-	/* Drive spinup time (time from power-on to the first D2H FIS)
-	 * in msecs - 8s currently.  Failing to get ready in this time
-	 * isn't critical.  It will result in reset failure for
-	 * controllers which can't wait for the first D2H FIS.  libata
-	 * will retry, so it just has to be long enough to spin up
-	 * most devices.
-	 */
-	ATA_SPINUP_WAIT		= 8000,
-
 	/* Horkage types. May be set by libata or controller on drives
 	   (some horkage may be drive/controller pair dependant */
 
@@ -513,7 +503,6 @@ struct ata_eh_info {
 	unsigned int		dev_action[ATA_MAX_DEVICES]; /* dev EH action */
 	unsigned int		flags;		/* ATA_EHI_* flags */
 
-	unsigned long		hotplug_timestamp;
 	unsigned int		probe_mask;
 
 	char			desc[ATA_EH_DESC_LEN];
@@ -908,12 +897,7 @@ extern void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 
 static inline void __ata_ehi_hotplugged(struct ata_eh_info *ehi)
 {
-	if (ehi->flags & ATA_EHI_HOTPLUGGED)
-		return;
-
 	ehi->flags |= ATA_EHI_HOTPLUGGED | ATA_EHI_RESUME_LINK;
-	ehi->hotplug_timestamp = jiffies;
-
 	ehi->action |= ATA_EH_SOFTRESET;
 	ehi->probe_mask |= (1 << ATA_MAX_DEVICES) - 1;
 }
-- 
1.4.4.4


