From: akpm@linux-foundation.org
Subject: [patch 04/11] libata: implement ata_wait_after_reset()
Date: Mon, 09 Jul 2007 11:46:18 -0700
Message-ID: <200707091846.l69IkJVw001375@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57528 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754723AbXGISrI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 14:47:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, htejun@gmail.com

From: Tejun Heo <htejun@gmail.com>

On certain device/controller combination, 0xff status is asserted
after reset and doesn't get cleared during 150ms post-reset wait.  As
0xff status is interpreted as no device (for good reasons), this can
lead to misdetection on such cases.

This patch implements ata_wait_after_reset() which replaces the 150ms
sleep and waits upto ATA_TMOUT_FF_WAIT if status is 0xff.
ATA_TMOUT_FF_WAIT is currently 800ms which is enough for
HHD424020F7SV00 to get detected but not enough for Quantum GoVault
drive which is known to take upto 2s.

Without parallel probing, spending 2s on 0xff port would incur too
much delay on ata_piix's which use 0xff to indicate empty port and
doesn't have SCR register, so GoVault needs to wait till parallel
probing.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/ahci.c          |   11 +----
 drivers/ata/libata-core.c   |   67 +++++++++++++++++++++++++++-------
 drivers/ata/pata_scc.c      |   13 +-----
 drivers/ata/sata_inic162x.c |    2 -
 include/linux/libata.h      |    8 ++++
 5 files changed, 67 insertions(+), 34 deletions(-)

diff -puN drivers/ata/ahci.c~libata-implement-ata_wait_after_reset drivers/ata/ahci.c
--- a/drivers/ata/ahci.c~libata-implement-ata_wait_after_reset
+++ a/drivers/ata/ahci.c
@@ -1045,15 +1045,8 @@ static int ahci_softreset(struct ata_por
 	writel(1, port_mmio + PORT_CMD_ISSUE);
 	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
 
-	/* spec mandates ">= 2ms" before checking status.
-	 * We wait 150ms, because that was the magic delay used for
-	 * ATAPI devices in Hale Landis's ATADRVR, for the period of time
-	 * between when the ATA command register is written, and then
-	 * status is checked.  Because waiting for "a while" before
-	 * checking status is fine, post SRST, we perform this magic
-	 * delay here as well.
-	 */
-	msleep(150);
+	/* wait a while before checking status */
+	ata_wait_after_reset(ap, deadline);
 
 	rc = ata_wait_ready(ap, deadline);
 	/* link occupied, -ENODEV too is an error */
diff -puN drivers/ata/libata-core.c~libata-implement-ata_wait_after_reset drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c~libata-implement-ata_wait_after_reset
+++ a/drivers/ata/libata-core.c
@@ -2962,6 +2962,55 @@ int ata_busy_sleep(struct ata_port *ap,
 }
 
 /**
+ *	ata_wait_after_reset - wait before checking status after reset
+ *	@ap: port containing status register to be polled
+ *	@deadline: deadline jiffies for the operation
+ *
+ *	After reset, we need to pause a while before reading status.
+ *	Also, certain combination of controller and device report 0xff
+ *	for some duration (e.g. until SATA PHY is up and running)
+ *	which is interpreted as empty port in ATA world.  This
+ *	function also waits for such devices to get out of 0xff
+ *	status.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void ata_wait_after_reset(struct ata_port *ap, unsigned long deadline)
+{
+	unsigned long until = jiffies + ATA_TMOUT_FF_WAIT;
+
+	if (time_before(until, deadline))
+		deadline = until;
+
+	/* Spec mandates ">= 2ms" before checking status.  We wait
+	 * 150ms, because that was the magic delay used for ATAPI
+	 * devices in Hale Landis's ATADRVR, for the period of time
+	 * between when the ATA command register is written, and then
+	 * status is checked.  Because waiting for "a while" before
+	 * checking status is fine, post SRST, we perform this magic
+	 * delay here as well.
+	 *
+	 * Old drivers/ide uses the 2mS rule and then waits for ready.
+	 */
+	msleep(150);
+
+	/* Wait for 0xff to clear.  Some SATA devices take a long time
+	 * to clear 0xff after reset.  For example, HHD424020F7SV00
+	 * iVDR needs >= 800ms while.  Quantum GoVault needs even more
+	 * than that.
+	 */
+	while (1) {
+		u8 status = ata_chk_status(ap);
+
+		if (status != 0xff || time_after(jiffies, deadline))
+			return;
+
+		msleep(50);
+	}
+}
+
+/**
  *	ata_wait_ready - sleep until BSY clears, or timeout
  *	@ap: port containing status register to be polled
  *	@deadline: deadline jiffies for the operation
@@ -3077,17 +3126,8 @@ static int ata_bus_softreset(struct ata_
 	udelay(20);	/* FIXME: flush */
 	iowrite8(ap->ctl, ioaddr->ctl_addr);
 
-	/* spec mandates ">= 2ms" before checking status.
-	 * We wait 150ms, because that was the magic delay used for
-	 * ATAPI devices in Hale Landis's ATADRVR, for the period of time
-	 * between when the ATA command register is written, and then
-	 * status is checked.  Because waiting for "a while" before
-	 * checking status is fine, post SRST, we perform this magic
-	 * delay here as well.
-	 *
-	 * Old drivers/ide uses the 2mS rule and then waits for ready
-	 */
-	msleep(150);
+	/* wait a while before checking status */
+	ata_wait_after_reset(ap, deadline);
 
 	/* Before we perform post reset processing we want to see if
 	 * the bus shows 0xFF because the odd clown forgets the D7
@@ -3503,8 +3543,8 @@ int sata_std_hardreset(struct ata_port *
 		return 0;
 	}
 
-	/* wait a while before checking status, see SRST for more info */
-	msleep(150);
+	/* wait a while before checking status */
+	ata_wait_after_reset(ap, deadline);
 
 	rc = ata_wait_ready(ap, deadline);
 	/* link occupied, -ENODEV too is an error */
@@ -6895,6 +6935,7 @@ EXPORT_SYMBOL_GPL(ata_port_disable);
 EXPORT_SYMBOL_GPL(ata_ratelimit);
 EXPORT_SYMBOL_GPL(ata_wait_register);
 EXPORT_SYMBOL_GPL(ata_busy_sleep);
+EXPORT_SYMBOL_GPL(ata_wait_after_reset);
 EXPORT_SYMBOL_GPL(ata_wait_ready);
 EXPORT_SYMBOL_GPL(ata_port_queue_task);
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
diff -puN drivers/ata/pata_scc.c~libata-implement-ata_wait_after_reset drivers/ata/pata_scc.c
--- a/drivers/ata/pata_scc.c~libata-implement-ata_wait_after_reset
+++ a/drivers/ata/pata_scc.c
@@ -557,17 +557,8 @@ static unsigned int scc_bus_softreset(st
 	udelay(20);
 	out_be32(ioaddr->ctl_addr, ap->ctl);
 
-	/* spec mandates ">= 2ms" before checking status.
-	 * We wait 150ms, because that was the magic delay used for
-	 * ATAPI devices in Hale Landis's ATADRVR, for the period of time
-	 * between when the ATA command register is written, and then
-	 * status is checked.  Because waiting for "a while" before
-	 * checking status is fine, post SRST, we perform this magic
-	 * delay here as well.
-	 *
-	 * Old drivers/ide uses the 2mS rule and then waits for ready
-	 */
-	msleep(150);
+	/* wait a while before checking status */
+	ata_wait_after_reset(ap, deadline);
 
 	/* Before we perform post reset processing we want to see if
 	 * the bus shows 0xFF because the odd clown forgets the D7
diff -puN drivers/ata/sata_inic162x.c~libata-implement-ata_wait_after_reset drivers/ata/sata_inic162x.c
--- a/drivers/ata/sata_inic162x.c~libata-implement-ata_wait_after_reset
+++ a/drivers/ata/sata_inic162x.c
@@ -446,7 +446,7 @@ static int inic_hardreset(struct ata_por
 		struct ata_taskfile tf;
 
 		/* wait a while before checking status */
-		msleep(150);
+		ata_wait_after_reset(ap, deadline);
 
 		rc = ata_wait_ready(ap, deadline);
 		/* link occupied, -ENODEV too is an error */
diff -puN include/linux/libata.h~libata-implement-ata_wait_after_reset include/linux/libata.h
--- a/include/linux/libata.h~libata-implement-ata_wait_after_reset
+++ a/include/linux/libata.h
@@ -222,6 +222,13 @@ enum {
 	ATA_TMOUT_INTERNAL	= 30 * HZ,
 	ATA_TMOUT_INTERNAL_QUICK = 5 * HZ,
 
+	/* FIXME: GoVault needs 2s but we can't afford that without
+	 * parallel probing.  800ms is enough for iVDR disk
+	 * HHD424020F7SV00.  Increase to 2secs when parallel probing
+	 * is in place.
+	 */
+	ATA_TMOUT_FF_WAIT	= 4 * HZ / 5,
+
 	/* ATA bus states */
 	BUS_UNKNOWN		= 0,
 	BUS_DMA			= 1,
@@ -751,6 +758,7 @@ extern void ata_host_resume(struct ata_h
 extern int ata_ratelimit(void);
 extern int ata_busy_sleep(struct ata_port *ap,
 			  unsigned long timeout_pat, unsigned long timeout);
+extern void ata_wait_after_reset(struct ata_port *ap, unsigned long deadline);
 extern int ata_wait_ready(struct ata_port *ap, unsigned long deadline);
 extern void ata_port_queue_task(struct ata_port *ap, work_func_t fn,
 				void *data, unsigned long delay);
_
