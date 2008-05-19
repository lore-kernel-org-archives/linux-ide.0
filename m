From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/5] libata: consistently use msecs for time durations
Date: Tue, 20 May 2008 02:17:51 +0900
Message-ID: <12112174751988-git-send-email-htejun@gmail.com>
References: <12112174741373-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.155]:16517 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017AbYESRSD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 May 2008 13:18:03 -0400
Received: by po-out-1718.google.com with SMTP id c31so3028399poi.1
        for <linux-ide@vger.kernel.org>; Mon, 19 May 2008 10:18:02 -0700 (PDT)
In-Reply-To: <12112174741373-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: liml@rtr.ca, Tejun Heo <htejun@gmail.com>

libata has been using mix of jiffies and msecs for time druations.
This is getting confusing.  As writing sub HZ values in jiffies is
PITA and msecs_to_jiffies() can't be used as initializer, unify unit
for all time durations to msecs.  So, durations are in msecs and
deadlines are in jiffies.  ata_deadline() is added to compute deadline
from a start time and duration in msecs.

While at it, drop now superflous _msec suffix from arguments and
rename @timeout to @deadline if it represents a fixed point in time
rather than duration.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   44 +++++++++++++++++++++-----------------------
 drivers/ata/libata-eh.c   |   33 +++++++++++++++++----------------
 drivers/ata/libata-pmp.c  |    3 ++-
 drivers/ata/libata-sff.c  |   15 ++++++++-------
 drivers/ata/pata_bf54x.c  |    6 +++---
 drivers/ata/pata_scc.c    |    2 +-
 include/linux/libata.h    |   26 ++++++++++++++++----------
 7 files changed, 68 insertions(+), 61 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3c89f20..eb9dfbc 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -54,7 +54,6 @@
 #include <linux/completion.h>
 #include <linux/suspend.h>
 #include <linux/workqueue.h>
-#include <linux/jiffies.h>
 #include <linux/scatterlist.h>
 #include <linux/io.h>
 #include <scsi/scsi.h>
@@ -145,7 +144,7 @@ static int libata_dma_mask = ATA_DMA_MASK_ATA|ATA_DMA_MASK_ATAPI|ATA_DMA_MASK_CF
 module_param_named(dma, libata_dma_mask, int, 0444);
 MODULE_PARM_DESC(dma, "DMA enable/disable (0x1==ATA, 0x2==ATAPI, 0x4==CF)");
 
-static int ata_probe_timeout = ATA_TMOUT_INTERNAL / HZ;
+static int ata_probe_timeout = ATA_TMOUT_INTERNAL / 1000;
 module_param(ata_probe_timeout, int, 0444);
 MODULE_PARM_DESC(ata_probe_timeout, "Set ATA probing timeout (seconds)");
 
@@ -1533,7 +1532,7 @@ unsigned long ata_id_xfermask(const u16 *id)
  *	@ap: The ata_port to queue port_task for
  *	@fn: workqueue function to be scheduled
  *	@data: data for @fn to use
- *	@delay: delay time for workqueue function
+ *	@delay: delay time in msecs for workqueue function
  *
  *	Schedule @fn(@data) for execution after @delay jiffies using
  *	port_task.  There is one port_task per port and it's the
@@ -1552,7 +1551,7 @@ void ata_pio_queue_task(struct ata_port *ap, void *data, unsigned long delay)
 	ap->port_task_data = data;
 
 	/* may fail if ata_port_flush_task() in progress */
-	queue_delayed_work(ata_wq, &ap->port_task, delay);
+	queue_delayed_work(ata_wq, &ap->port_task, msecs_to_jiffies(delay));
 }
 
 /**
@@ -1685,7 +1684,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 	spin_unlock_irqrestore(ap->lock, flags);
 
 	if (!timeout)
-		timeout = ata_probe_timeout * 1000 / HZ;
+		timeout = ata_probe_timeout * 1000;
 
 	rc = wait_for_completion_timeout(&wait, msecs_to_jiffies(timeout));
 
@@ -3319,7 +3318,7 @@ int ata_wait_ready(struct ata_link *link, unsigned long deadline,
 		   int (*check_ready)(struct ata_link *link))
 {
 	unsigned long start = jiffies;
-	unsigned long nodev_deadline = start + ATA_TMOUT_FF_WAIT;
+	unsigned long nodev_deadline = ata_deadline(start, ATA_TMOUT_FF_WAIT);
 	int warned = 0;
 
 	if (time_after(nodev_deadline, deadline))
@@ -3387,7 +3386,7 @@ int ata_wait_ready(struct ata_link *link, unsigned long deadline,
 int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
 				int (*check_ready)(struct ata_link *link))
 {
-	msleep(ATA_WAIT_AFTER_RESET_MSECS);
+	msleep(ATA_WAIT_AFTER_RESET);
 
 	return ata_wait_ready(link, deadline, check_ready);
 }
@@ -3417,13 +3416,13 @@ int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
 int sata_link_debounce(struct ata_link *link, const unsigned long *params,
 		       unsigned long deadline)
 {
-	unsigned long interval_msec = params[0];
-	unsigned long duration = msecs_to_jiffies(params[1]);
+	unsigned long interval = params[0];
+	unsigned long duration = params[1];
 	unsigned long last_jiffies, t;
 	u32 last, cur;
 	int rc;
 
-	t = jiffies + msecs_to_jiffies(params[2]);
+	t = ata_deadline(jiffies, params[2]);
 	if (time_before(t, deadline))
 		deadline = t;
 
@@ -3435,7 +3434,7 @@ int sata_link_debounce(struct ata_link *link, const unsigned long *params,
 	last_jiffies = jiffies;
 
 	while (1) {
-		msleep(interval_msec);
+		msleep(interval);
 		if ((rc = sata_scr_read(link, SCR_STATUS, &cur)))
 			return rc;
 		cur &= 0xf;
@@ -3444,7 +3443,8 @@ int sata_link_debounce(struct ata_link *link, const unsigned long *params,
 		if (cur == last) {
 			if (cur == 1 && time_before(jiffies, deadline))
 				continue;
-			if (time_after(jiffies, last_jiffies + duration))
+			if (time_after(jiffies,
+				       ata_deadline(last_jiffies, duration)))
 				return 0;
 			continue;
 		}
@@ -3636,7 +3636,8 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 		if (check_ready) {
 			unsigned long pmp_deadline;
 
-			pmp_deadline = jiffies + ATA_TMOUT_PMP_SRST_WAIT;
+			pmp_deadline = ata_deadline(jiffies,
+						    ATA_TMOUT_PMP_SRST_WAIT);
 			if (time_after(pmp_deadline, deadline))
 				pmp_deadline = deadline;
 			ata_wait_ready(link, pmp_deadline, check_ready);
@@ -6073,8 +6074,6 @@ static void __init ata_parse_force_param(void)
 
 static int __init ata_init(void)
 {
-	ata_probe_timeout *= HZ;
-
 	ata_parse_force_param();
 
 	ata_wq = create_workqueue("ata");
@@ -6127,8 +6126,8 @@ int ata_ratelimit(void)
  *	@reg: IO-mapped register
  *	@mask: Mask to apply to read register value
  *	@val: Wait condition
- *	@interval_msec: polling interval in milliseconds
- *	@timeout_msec: timeout in milliseconds
+ *	@interval: polling interval in milliseconds
+ *	@timeout: timeout in milliseconds
  *
  *	Waiting for some bits of register to change is a common
  *	operation for ATA controllers.  This function reads 32bit LE
@@ -6146,10 +6145,9 @@ int ata_ratelimit(void)
  *	The final register value.
  */
 u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
-		      unsigned long interval_msec,
-		      unsigned long timeout_msec)
+		      unsigned long interval, unsigned long timeout)
 {
-	unsigned long timeout;
+	unsigned long deadline;
 	u32 tmp;
 
 	tmp = ioread32(reg);
@@ -6158,10 +6156,10 @@ u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
 	 * preceding writes reach the controller before starting to
 	 * eat away the timeout.
 	 */
-	timeout = jiffies + (timeout_msec * HZ) / 1000;
+	deadline = ata_deadline(jiffies, timeout);
 
-	while ((tmp & mask) == val && time_before(jiffies, timeout)) {
-		msleep(interval_msec);
+	while ((tmp & mask) == val && time_before(jiffies, deadline)) {
+		msleep(interval);
 		tmp = ioread32(reg);
 	}
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7894d83..08dd07f 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -66,15 +66,14 @@ enum {
 	ATA_ECAT_DUBIOUS_TOUT_HSM	= 6,
 	ATA_ECAT_DUBIOUS_UNK_DEV	= 7,
 	ATA_ECAT_NR			= 8,
-};
 
-/* Waiting in ->prereset can never be reliable.  It's sometimes nice
- * to wait there but it can't be depended upon; otherwise, we wouldn't
- * be resetting.  Just give it enough time for most drives to spin up.
- */
-enum {
-	ATA_EH_PRERESET_TIMEOUT		= 10 * HZ,
-	ATA_EH_FASTDRAIN_INTERVAL	= 3 * HZ,
+	/* Waiting in ->prereset can never be reliable.  It's
+	 * sometimes nice to wait there but it can't be depended upon;
+	 * otherwise, we wouldn't be resetting.  Just give it enough
+	 * time for most drives to spin up.
+	 */
+	ATA_EH_PRERESET_TIMEOUT		= 10000,
+	ATA_EH_FASTDRAIN_INTERVAL	=  3000,
 };
 
 /* The following table determines how we sequence resets.  Each entry
@@ -84,10 +83,10 @@ enum {
  * are mostly for error handling, hotplug and retarded devices.
  */
 static const unsigned long ata_eh_reset_timeouts[] = {
-	10 * HZ,	/* most drives spin up by 10sec */
-	10 * HZ,	/* > 99% working drives spin up before 20sec */
-	35 * HZ,	/* give > 30 secs of idleness for retarded devices */
-	5 * HZ,		/* and sweet one last chance */
+	10000,	/* most drives spin up by 10sec */
+	10000,	/* > 99% working drives spin up before 20sec */
+	35000,	/* give > 30 secs of idleness for retarded devices */
+	 5000,	/* and sweet one last chance */
 	/* > 1 min has elapsed, give up */
 };
 
@@ -641,7 +640,7 @@ void ata_eh_fastdrain_timerfn(unsigned long arg)
 		/* some qcs have finished, give it another chance */
 		ap->fastdrain_cnt = cnt;
 		ap->fastdrain_timer.expires =
-			jiffies + ATA_EH_FASTDRAIN_INTERVAL;
+			ata_deadline(jiffies, ATA_EH_FASTDRAIN_INTERVAL);
 		add_timer(&ap->fastdrain_timer);
 	}
 
@@ -681,7 +680,8 @@ static void ata_eh_set_pending(struct ata_port *ap, int fastdrain)
 
 	/* activate fast drain */
 	ap->fastdrain_cnt = cnt;
-	ap->fastdrain_timer.expires = jiffies + ATA_EH_FASTDRAIN_INTERVAL;
+	ap->fastdrain_timer.expires =
+		ata_deadline(jiffies, ATA_EH_FASTDRAIN_INTERVAL);
 	add_timer(&ap->fastdrain_timer);
 }
 
@@ -2125,7 +2125,8 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	}
 
 	if (prereset) {
-		rc = prereset(link, jiffies + ATA_EH_PRERESET_TIMEOUT);
+		rc = prereset(link,
+			      ata_deadline(jiffies, ATA_EH_PRERESET_TIMEOUT));
 		if (rc) {
 			if (rc == -ENOENT) {
 				ata_link_printk(link, KERN_DEBUG,
@@ -2160,7 +2161,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	if (ata_is_host_link(link))
 		ata_eh_freeze_port(ap);
 
-	deadline = jiffies + ata_eh_reset_timeouts[try++];
+	deadline = ata_deadline(jiffies, ata_eh_reset_timeouts[try++]);
 
 	if (reset) {
 		if (verbose)
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 0f9386d..3a2bce0 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -782,7 +782,8 @@ static int sata_pmp_eh_handle_disabled_links(struct ata_port *ap)
 		 * SError.N working.
 		 */
 		sata_link_hardreset(link, sata_deb_timing_normal,
-				jiffies + ATA_TMOUT_INTERNAL_QUICK, NULL, NULL);
+				ata_deadline(jiffies, ATA_TMOUT_INTERNAL_QUICK),
+				NULL, NULL);
 
 		/* unconditionally clear SError.N */
 		rc = sata_scr_write(link, SCR_ERROR, SERR_PHYRDY_CHG);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 3c2d228..d25c129 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -258,8 +258,8 @@ u8 ata_sff_altstatus(struct ata_port *ap)
 /**
  *	ata_sff_busy_sleep - sleep until BSY clears, or timeout
  *	@ap: port containing status register to be polled
- *	@tmout_pat: impatience timeout
- *	@tmout: overall timeout
+ *	@tmout_pat: impatience timeout in msecs
+ *	@tmout: overall timeout in msecs
  *
  *	Sleep until ATA Status register bit BSY clears,
  *	or a timeout occurs.
@@ -278,7 +278,7 @@ int ata_sff_busy_sleep(struct ata_port *ap,
 
 	status = ata_sff_busy_wait(ap, ATA_BUSY, 300);
 	timer_start = jiffies;
-	timeout = timer_start + tmout_pat;
+	timeout = ata_deadline(timer_start, tmout_pat);
 	while (status != 0xff && (status & ATA_BUSY) &&
 	       time_before(jiffies, timeout)) {
 		msleep(50);
@@ -290,7 +290,7 @@ int ata_sff_busy_sleep(struct ata_port *ap,
 				"port is slow to respond, please be patient "
 				"(Status 0x%x)\n", status);
 
-	timeout = timer_start + tmout;
+	timeout = ata_deadline(timer_start, tmout);
 	while (status != 0xff && (status & ATA_BUSY) &&
 	       time_before(jiffies, timeout)) {
 		msleep(50);
@@ -303,7 +303,7 @@ int ata_sff_busy_sleep(struct ata_port *ap,
 	if (status & ATA_BUSY) {
 		ata_port_printk(ap, KERN_ERR, "port failed to respond "
 				"(%lu secs, Status 0x%x)\n",
-				tmout / HZ, status);
+				DIV_ROUND_UP(tmout, 1000), status);
 		return -EBUSY;
 	}
 
@@ -1792,7 +1792,7 @@ int ata_sff_wait_after_reset(struct ata_link *link, unsigned int devmask,
 	unsigned int dev1 = devmask & (1 << 1);
 	int rc, ret = 0;
 
-	msleep(ATA_WAIT_AFTER_RESET_MSECS);
+	msleep(ATA_WAIT_AFTER_RESET);
 
 	/* always check readiness of the master device */
 	rc = ata_sff_wait_ready(link, deadline);
@@ -2275,7 +2275,8 @@ void ata_bus_reset(struct ata_port *ap)
 
 	/* issue bus reset */
 	if (ap->flags & ATA_FLAG_SRST) {
-		rc = ata_bus_softreset(ap, devmask, jiffies + 40 * HZ);
+		rc = ata_bus_softreset(ap, devmask,
+				       ata_deadline(jiffies, 40000));
 		if (rc && rc != -ENODEV)
 			goto err_out;
 	}
diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index 9ab8973..7b9be0e 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -1008,7 +1008,7 @@ static void bfin_bus_post_reset(struct ata_port *ap, unsigned int devmask)
 	void __iomem *base = (void __iomem *)ap->ioaddr.ctl_addr;
 	unsigned int dev0 = devmask & (1 << 0);
 	unsigned int dev1 = devmask & (1 << 1);
-	unsigned long timeout;
+	unsigned long deadline;
 
 	/* if device 0 was found in ata_devchk, wait for its
 	 * BSY bit to clear
@@ -1019,7 +1019,7 @@ static void bfin_bus_post_reset(struct ata_port *ap, unsigned int devmask)
 	/* if device 1 was found in ata_devchk, wait for
 	 * register access, then wait for BSY to clear
 	 */
-	timeout = jiffies + ATA_TMOUT_BOOT;
+	deadline = ata_deadline(jiffies, ATA_TMOUT_BOOT);
 	while (dev1) {
 		u8 nsect, lbal;
 
@@ -1028,7 +1028,7 @@ static void bfin_bus_post_reset(struct ata_port *ap, unsigned int devmask)
 		lbal = read_atapi_register(base, ATA_REG_LBAL);
 		if ((nsect == 1) && (lbal == 1))
 			break;
-		if (time_after(jiffies, timeout)) {
+		if (time_after(jiffies, deadline)) {
 			dev1 = 0;
 			break;
 		}
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index e965b25..a227dd3 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -696,7 +696,7 @@ static void scc_bmdma_stop (struct ata_queued_cmd *qc)
 
 		if (reg & INTSTS_BMSINT) {
 			unsigned int classes;
-			unsigned long deadline = jiffies + ATA_TMOUT_BOOT;
+			unsigned long deadline = ata_deadline(jiffies, ATA_TMOUT_BOOT);
 			printk(KERN_WARNING "%s: Internal Bus Error\n", DRV_NAME);
 			out_be32(bmid_base + SCC_DMA_INTST, INTSTS_BMSINT);
 			/* TBD: SW reset */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 989088e..4bbe955 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -27,6 +27,7 @@
 #define __LINUX_LIBATA_H__
 
 #include <linux/delay.h>
+#include <linux/jiffies.h>
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
 #include <linux/scatterlist.h>
@@ -115,7 +116,7 @@ enum {
 	/* tag ATA_MAX_QUEUE - 1 is reserved for internal commands */
 	ATA_MAX_QUEUE		= 32,
 	ATA_TAG_INTERNAL	= ATA_MAX_QUEUE - 1,
-	ATA_SHORT_PAUSE		= (HZ >> 6) + 1,
+	ATA_SHORT_PAUSE		= 16,
 
 	ATAPI_MAX_DRAIN		= 16 << 10,
 
@@ -234,17 +235,17 @@ enum {
 	/* bits 24:31 of host->flags are reserved for LLD specific flags */
 
 	/* various lengths of time */
-	ATA_TMOUT_BOOT		= 30 * HZ,	/* heuristic */
-	ATA_TMOUT_BOOT_QUICK	= 7 * HZ,	/* heuristic */
-	ATA_TMOUT_INTERNAL	= 30 * HZ,
-	ATA_TMOUT_INTERNAL_QUICK = 5 * HZ,
+	ATA_TMOUT_BOOT		= 30000,	/* heuristic */
+	ATA_TMOUT_BOOT_QUICK	=  7000,	/* heuristic */
+	ATA_TMOUT_INTERNAL	= 30000,
+	ATA_TMOUT_INTERNAL_QUICK = 5000,
 
 	/* FIXME: GoVault needs 2s but we can't afford that without
 	 * parallel probing.  800ms is enough for iVDR disk
 	 * HHD424020F7SV00.  Increase to 2secs when parallel probing
 	 * is in place.
 	 */
-	ATA_TMOUT_FF_WAIT	= 4 * HZ / 5,
+	ATA_TMOUT_FF_WAIT	=  800,
 
 	/* Spec mandates to wait for ">= 2ms" before checking status
 	 * after reset.  We wait 150ms, because that was the magic
@@ -256,14 +257,14 @@ enum {
 	 *
 	 * Old drivers/ide uses the 2mS rule and then waits for ready.
 	 */
-	ATA_WAIT_AFTER_RESET_MSECS = 150,
+	ATA_WAIT_AFTER_RESET	=  150,
 
 	/* If PMP is supported, we have to do follow-up SRST.  As some
 	 * PMPs don't send D2H Reg FIS after hardreset, LLDs are
 	 * advised to wait only for the following duration before
 	 * doing SRST.
 	 */
-	ATA_TMOUT_PMP_SRST_WAIT	= 1 * HZ,
+	ATA_TMOUT_PMP_SRST_WAIT	= 1000,
 
 	/* ATA bus states */
 	BUS_UNKNOWN		= 0,
@@ -897,8 +898,7 @@ extern void ata_host_resume(struct ata_host *host);
 #endif
 extern int ata_ratelimit(void);
 extern u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
-			     unsigned long interval_msec,
-			     unsigned long timeout_msec);
+			     unsigned long interval, unsigned long timeout);
 extern int atapi_cmd_type(u8 opcode);
 extern void ata_tf_to_fis(const struct ata_taskfile *tf,
 			  u8 pmp, int is_cmd, u8 *fis);
@@ -1391,6 +1391,12 @@ static inline int ata_check_ready(u8 status)
 	return 0;
 }
 
+static inline unsigned long ata_deadline(unsigned long from_jiffies,
+					 unsigned long timeout_msecs)
+{
+	return from_jiffies + msecs_to_jiffies(timeout_msecs);
+}
+
 
 /**************************************************************************
  * PMP - drivers/ata/libata-pmp.c
-- 
1.5.2.4

