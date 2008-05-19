From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/5] libata: improve EH internal command timeout handling
Date: Tue, 20 May 2008 02:17:54 +0900
Message-ID: <12112174751449-git-send-email-htejun@gmail.com>
References: <12112174741373-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.153]:16301 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423AbYESRSF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 May 2008 13:18:05 -0400
Received: by po-out-1718.google.com with SMTP id c31so3028484poi.1
        for <linux-ide@vger.kernel.org>; Mon, 19 May 2008 10:18:05 -0700 (PDT)
In-Reply-To: <12112174741373-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: liml@rtr.ca, Tejun Heo <htejun@gmail.com>

ATA_TMOUT_INTERNAL which was 30secs were used for all internal
commands which is way too long when something goes wrong.  This patch
implements command type based stepped timeouts.  Different command
types can use different timeouts and each command type can use
different timeout values after timeouts.

ie. the initial timeout is set to a value which should cover most of
the cases but not too long so that run away cases don't delay things
too much.  After the first try times out, the second try can use
longer timeout and if that one times out too, it can go for full 30sec
timeout.

IDENTIFYs use 5s - 10s - 30s timeout and all other commands use 5s -
10s timeouts.

This patch significantly cuts down the needed time to handle failure
cases while still allowing libata to work with nut job devices through
retries.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   16 +++++-
 drivers/ata/libata-eh.c   |  121 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/ata/libata.h      |    2 +
 include/linux/libata.h    |    8 +++-
 4 files changed, 142 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index eb9dfbc..1a40d41 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -144,7 +144,7 @@ static int libata_dma_mask = ATA_DMA_MASK_ATA|ATA_DMA_MASK_ATAPI|ATA_DMA_MASK_CF
 module_param_named(dma, libata_dma_mask, int, 0444);
 MODULE_PARM_DESC(dma, "DMA enable/disable (0x1==ATA, 0x2==ATAPI, 0x4==CF)");
 
-static int ata_probe_timeout = ATA_TMOUT_INTERNAL / 1000;
+static int ata_probe_timeout;
 module_param(ata_probe_timeout, int, 0444);
 MODULE_PARM_DESC(ata_probe_timeout, "Set ATA probing timeout (seconds)");
 
@@ -1611,6 +1611,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 	struct ata_link *link = dev->link;
 	struct ata_port *ap = link->ap;
 	u8 command = tf->command;
+	int auto_timeout = 0;
 	struct ata_queued_cmd *qc;
 	unsigned int tag, preempted_tag;
 	u32 preempted_sactive, preempted_qc_active;
@@ -1683,8 +1684,14 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	if (!timeout)
-		timeout = ata_probe_timeout * 1000;
+	if (!timeout) {
+		if (ata_probe_timeout)
+			timeout = ata_probe_timeout * 1000;
+		else {
+			timeout = ata_internal_cmd_timeout(dev, command);
+			auto_timeout = 1;
+		}
+	}
 
 	rc = wait_for_completion_timeout(&wait, msecs_to_jiffies(timeout));
 
@@ -1760,6 +1767,9 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
+	if ((err_mask & AC_ERR_TIMEOUT) && auto_timeout)
+		ata_internal_cmd_timed_out(dev, command);
+
 	return err_mask;
 }
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 83d1451..d5f03a6 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -67,6 +67,8 @@ enum {
 	ATA_ECAT_DUBIOUS_UNK_DEV	= 7,
 	ATA_ECAT_NR			= 8,
 
+	ATA_EH_CMD_DFL_TIMEOUT		=  5000,
+
 	/* always put at least this amount of time between resets */
 	ATA_EH_RESET_COOL_DOWN		=  5000,
 
@@ -93,6 +95,53 @@ static const unsigned long ata_eh_reset_timeouts[] = {
 	ULONG_MAX, /* > 1 min has elapsed, give up */
 };
 
+static const unsigned long ata_eh_identify_timeouts[] = {
+	 5000,	/* covers > 99% of successes and not too boring on failures */
+	10000,  /* combined time till here is enough even for media access */
+	30000,	/* for true idiots */
+	ULONG_MAX,
+};
+
+static const unsigned long ata_eh_other_timeouts[] = {
+	 5000,	/* same rationale as identify timeout */
+	10000,	/* ditto */
+	/* but no merciful 30sec for other commands, it just isn't worth it */
+	ULONG_MAX,
+};
+
+struct ata_eh_cmd_timeout_ent {
+	const u8		*commands;
+	const unsigned long	*timeouts;
+};
+
+/* The following table determines timeouts to use for EH internal
+ * commands.  Each table entry is a command class and matches the
+ * commands the entry applies to and the timeout table to use.
+ *
+ * On the retry after a command timed out, the next timeout value from
+ * the table is used.  If the table doesn't contain further entries,
+ * the last value is used.
+ *
+ * ehc->cmd_timeout_idx keeps track of which timeout to use per
+ * command class, so if SET_FEATURES times out on the first try, the
+ * next try will use the second timeout value only for that class.
+ */
+#define CMDS(cmds...)	(const u8 []){ cmds, 0 }
+static const struct ata_eh_cmd_timeout_ent
+ata_eh_cmd_timeout_table[ATA_EH_CMD_TIMEOUT_TABLE_SIZE] = {
+	{ .commands = CMDS(ATA_CMD_ID_ATA, ATA_CMD_ID_ATAPI),
+	  .timeouts = ata_eh_identify_timeouts, },
+	{ .commands = CMDS(ATA_CMD_READ_NATIVE_MAX, ATA_CMD_READ_NATIVE_MAX_EXT),
+	  .timeouts = ata_eh_other_timeouts, },
+	{ .commands = CMDS(ATA_CMD_SET_MAX, ATA_CMD_SET_MAX_EXT),
+	  .timeouts = ata_eh_other_timeouts, },
+	{ .commands = CMDS(ATA_CMD_SET_FEATURES),
+	  .timeouts = ata_eh_other_timeouts, },
+	{ .commands = CMDS(ATA_CMD_INIT_DEV_PARAMS),
+	  .timeouts = ata_eh_other_timeouts, },
+};
+#undef CMDS
+
 static void __ata_port_freeze(struct ata_port *ap);
 #ifdef CONFIG_PM
 static void ata_eh_handle_port_suspend(struct ata_port *ap);
@@ -238,6 +287,73 @@ void ata_port_pbar_desc(struct ata_port *ap, int bar, ssize_t offset,
 
 #endif /* CONFIG_PCI */
 
+static int ata_lookup_timeout_table(u8 cmd)
+{
+	int i;
+
+	for (i = 0; i < ATA_EH_CMD_TIMEOUT_TABLE_SIZE; i++) {
+		const u8 *cur;
+
+		for (cur = ata_eh_cmd_timeout_table[i].commands; *cur; cur++)
+			if (*cur == cmd)
+				return i;
+	}
+
+	return -1;
+}
+
+/**
+ *	ata_internal_cmd_timeout - determine timeout for an internal command
+ *	@dev: target device
+ *	@cmd: internal command to be issued
+ *
+ *	Determine timeout for internal command @cmd for @dev.
+ *
+ *	LOCKING:
+ *	EH context.
+ *
+ *	RETURNS:
+ *	Determined timeout.
+ */
+unsigned long ata_internal_cmd_timeout(struct ata_device *dev, u8 cmd)
+{
+	struct ata_eh_context *ehc = &dev->link->eh_context;
+	int ent = ata_lookup_timeout_table(cmd);
+	int idx;
+
+	if (ent < 0)
+		return ATA_EH_CMD_DFL_TIMEOUT;
+
+	idx = ehc->cmd_timeout_idx[dev->devno][ent];
+	return ata_eh_cmd_timeout_table[ent].timeouts[idx];
+}
+
+/**
+ *	ata_internal_cmd_timed_out - notification for internal command timeout
+ *	@dev: target device
+ *	@cmd: internal command which timed out
+ *
+ *	Notify EH that internal command @cmd for @dev timed out.  This
+ *	function should be called only for commands whose timeouts are
+ *	determined using ata_internal_cmd_timeout().
+ *
+ *	LOCKING:
+ *	EH context.
+ */
+void ata_internal_cmd_timed_out(struct ata_device *dev, u8 cmd)
+{
+	struct ata_eh_context *ehc = &dev->link->eh_context;
+	int ent = ata_lookup_timeout_table(cmd);
+	int idx;
+
+	if (ent < 0)
+		return;
+
+	idx = ehc->cmd_timeout_idx[dev->devno][ent];
+	if (ata_eh_cmd_timeout_table[ent].timeouts[idx + 1] != ULONG_MAX)
+		ehc->cmd_timeout_idx[dev->devno][ent]++;
+}
+
 static void ata_ering_record(struct ata_ering *ering, unsigned int eflags,
 			     unsigned int err_mask)
 {
@@ -2600,8 +2716,11 @@ static int ata_eh_handle_dev_fail(struct ata_device *dev, int err)
 			ata_eh_detach_dev(dev);
 
 		/* schedule probe if necessary */
-		if (ata_eh_schedule_probe(dev))
+		if (ata_eh_schedule_probe(dev)) {
 			ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
+			memset(ehc->cmd_timeout_idx[dev->devno], 0,
+			       sizeof(ehc->cmd_timeout_idx[dev->devno]));
+		}
 
 		return 1;
 	} else {
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 4514283..daf2b44 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -151,6 +151,8 @@ extern void ata_scsi_dev_rescan(struct work_struct *work);
 extern int ata_bus_probe(struct ata_port *ap);
 
 /* libata-eh.c */
+extern unsigned long ata_internal_cmd_timeout(struct ata_device *dev, u8 cmd);
+extern void ata_internal_cmd_timed_out(struct ata_device *dev, u8 cmd);
 extern enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
 extern void ata_scsi_error(struct Scsi_Host *host);
 extern void ata_port_wait_eh(struct ata_port *ap);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 4fc9ab0..70cf9fd 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -237,7 +237,6 @@ enum {
 	/* various lengths of time */
 	ATA_TMOUT_BOOT		= 30000,	/* heuristic */
 	ATA_TMOUT_BOOT_QUICK	=  7000,	/* heuristic */
-	ATA_TMOUT_INTERNAL	= 30000,
 	ATA_TMOUT_INTERNAL_QUICK = 5000,
 
 	/* FIXME: GoVault needs 2s but we can't afford that without
@@ -341,6 +340,11 @@ enum {
 
 	SATA_PMP_RW_TIMEOUT	= 3000,		/* PMP read/write timeout */
 
+	/* This should match the actual table size of
+	 * ata_eh_cmd_timeout_table in libata-eh.c.
+	 */
+	ATA_EH_CMD_TIMEOUT_TABLE_SIZE = 5,
+
 	/* Horkage types. May be set by libata or controller on drives
 	   (some horkage may be drive/controller pair dependant */
 
@@ -598,6 +602,8 @@ struct ata_eh_info {
 struct ata_eh_context {
 	struct ata_eh_info	i;
 	int			tries[ATA_MAX_DEVICES];
+	int			cmd_timeout_idx[ATA_MAX_DEVICES]
+					       [ATA_EH_CMD_TIMEOUT_TABLE_SIZE];
 	unsigned int		classes[ATA_MAX_DEVICES];
 	unsigned int		did_probe_mask;
 	unsigned int		saved_ncq_enabled;
-- 
1.5.2.4

