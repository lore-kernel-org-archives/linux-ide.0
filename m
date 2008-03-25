From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/27] libata: separate out ata_wait_ready() and implement ata_wait_after_reset()
Date: Tue, 25 Mar 2008 22:16:51 +0900
Message-ID: <1206451027778-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:61115 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755518AbYCYNRw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:52 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1755562rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:51 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

Factor out waiting logic (which is common to all ATA controllers) from
ata_sff_wait_ready() into ata_wait_ready().  ata_wait_ready() takes
@check_ready function pointer and uses it to poll for readiness.  This
allows non-SFF controllers to use ata_wait_ready() to wait for link
readiness.

This patch also implements ata_wait_after_reset() - generic version of
ata_sff_wait_after_reset() - using ata_wait_ready().

ata_sff_wait_ready() is reimplemented using ata_wait_ready() and
ata_sff_check_ready().  Functionality remains the same.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   98 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata-sff.c  |   62 +++++-----------------------
 drivers/ata/libata.h      |    2 +
 include/linux/libata.h    |    2 +
 4 files changed, 114 insertions(+), 50 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9184a50..9064b3e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3273,6 +3273,103 @@ int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
 }
 
 /**
+ *	ata_wait_ready - wait for link to become ready
+ *	@link: link to be waited on
+ *	@deadline: deadline jiffies for the operation
+ *	@check_ready: callback to check link readiness
+ *
+ *	Wait for @link to become ready.  @check_ready should return
+ *	positive number if @link is ready, 0 if it isn't, -ENODEV if
+ *	link doesn't seem to be occupied, other errno for other error
+ *	conditions.
+ *
+ *	Transient -ENODEV conditions are allowed for
+ *	ATA_TMOUT_FF_WAIT.
+ *
+ *	LOCKING:
+ *	EH context.
+ *
+ *	RETURNS:
+ *	0 if @linke is ready before @deadline; otherwise, -errno.
+ */
+int ata_wait_ready(struct ata_link *link, unsigned long deadline,
+		   int (*check_ready)(struct ata_link *link))
+{
+	unsigned long start = jiffies;
+	unsigned long nodev_deadline = start + ATA_TMOUT_FF_WAIT;
+	int warned = 0;
+
+	if (time_after(nodev_deadline, deadline))
+		nodev_deadline = deadline;
+
+	while (1) {
+		unsigned long now = jiffies;
+		int ready, tmp;
+
+		ready = tmp = check_ready(link);
+		if (ready > 0)
+			return 0;
+
+		/* -ENODEV could be transient.  Ignore -ENODEV if link
+		 * is online.  Also, some SATA devices take a long
+		 * time to clear 0xff after reset.  For example,
+		 * HHD424020F7SV00 iVDR needs >= 800ms while Quantum
+		 * GoVault needs even more than that.  Wait for
+		 * ATA_TMOUT_FF_WAIT on -ENODEV if link isn't offline.
+		 *
+		 * Note that some PATA controllers (pata_ali) explode
+		 * if status register is read more than once when
+		 * there's no device attached.
+		 */
+		if (ready == -ENODEV) {
+			if (ata_link_online(link))
+				ready = 0;
+			else if ((link->ap->flags & ATA_FLAG_SATA) &&
+				 !ata_link_offline(link) &&
+				 time_before(now, nodev_deadline))
+				ready = 0;
+		}
+
+		if (ready)
+			return ready;
+		if (time_after(now, deadline))
+			return -EBUSY;
+
+		if (!warned && time_after(now, start + 5 * HZ) &&
+		    (deadline - now > 3 * HZ)) {
+			ata_link_printk(link, KERN_WARNING,
+				"link is slow to respond, please be patient "
+				"(ready=%d)\n", tmp);
+			warned = 1;
+		}
+
+		msleep(50);
+	}
+}
+
+/**
+ *	ata_wait_after_reset - wait for link to become ready after reset
+ *	@link: link to be waited on
+ *	@deadline: deadline jiffies for the operation
+ *	@check_ready: callback to check link readiness
+ *
+ *	Wait for @link to become ready after reset.
+ *
+ *	LOCKING:
+ *	EH context.
+ *
+ *	RETURNS:
+ *	0 if @linke is ready before @deadline; otherwise, -errno.
+ */
+extern int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
+				int (*check_ready)(struct ata_link *link))
+{
+	msleep(ATA_WAIT_AFTER_RESET_MSECS);
+
+	return ata_wait_ready(link, deadline, check_ready);
+}
+
+/**
  *	sata_link_debounce - debounce SATA phy status
  *	@link: ATA link to debounce SATA phy status for
  *	@params: timing parameters { interval, duratinon, timeout } in msec
@@ -6022,6 +6119,7 @@ EXPORT_SYMBOL_GPL(ata_noop_qc_prep);
 EXPORT_SYMBOL_GPL(ata_port_probe);
 EXPORT_SYMBOL_GPL(ata_dev_disable);
 EXPORT_SYMBOL_GPL(sata_set_spd);
+EXPORT_SYMBOL_GPL(ata_wait_after_reset);
 EXPORT_SYMBOL_GPL(sata_link_debounce);
 EXPORT_SYMBOL_GPL(sata_link_resume);
 EXPORT_SYMBOL_GPL(ata_std_prereset);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 6e8de3c..78912c5 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -308,6 +308,17 @@ int ata_sff_busy_sleep(struct ata_port *ap,
 	return 0;
 }
 
+static int ata_sff_check_ready(struct ata_link *link)
+{
+	u8 status = link->ap->ops->sff_check_status(link->ap);
+
+	if (!(status & ATA_BUSY))
+		return 1;
+	if (status == 0xff)
+		return -ENODEV;
+	return 0;
+}
+
 /**
  *	ata_sff_wait_ready - sleep until BSY clears, or timeout
  *	@link: SFF link to wait ready status for
@@ -324,56 +335,7 @@ int ata_sff_busy_sleep(struct ata_port *ap,
  */
 int ata_sff_wait_ready(struct ata_link *link, unsigned long deadline)
 {
-	struct ata_port *ap = link->ap;
-	unsigned long start = jiffies;
-	unsigned long nodev_deadline = start + ATA_TMOUT_FF_WAIT;
-	int warned = 0;
-
-	if (time_after(nodev_deadline, deadline))
-		nodev_deadline = deadline;
-
-	while (1) {
-		u8 status = ap->ops->sff_check_status(ap);
-		unsigned long now = jiffies;
-
-		if (!(status & ATA_BUSY))
-			return 0;
-
-		/* No device status could be transient.  Ignore it if
-		 * link is online.  Also, some SATA devices take a
-		 * long time to clear 0xff after reset.  For example,
-		 * HHD424020F7SV00 iVDR needs >= 800ms while Quantum
-		 * GoVault needs even more than that.  Wait for
-		 * ATA_TMOUT_FF_WAIT on -ENODEV if link isn't offline.
-		 *
-		 * Note that some PATA controllers (pata_ali) explode
-		 * if status register is read more than once when
-		 * there's no device attached.
-		 */
-		if (status == 0xff) {
-			if (ata_link_online(link))
-				status = ATA_BUSY;
-			else if ((link->ap->flags & ATA_FLAG_SATA) &&
-				 !ata_link_offline(link) &&
-				 time_before(now, nodev_deadline))
-				status = ATA_BUSY;
-			if (status == 0xff)
-				return -ENODEV;
-		}
-
-		if (time_after(now, deadline))
-			return -EBUSY;
-
-		if (!warned && time_after(now, start + 5 * HZ) &&
-		    (deadline - now > 3 * HZ)) {
-			ata_link_printk(link, KERN_WARNING,
-				"link is slow to respond, please be patient "
-				"(Status 0x%x)\n", status);
-			warned = 1;
-		}
-
-		msleep(50);
-	}
+	return ata_wait_ready(link, deadline, ata_sff_check_ready);
 }
 
 /**
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index a69f663..f3e9e3f 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -79,6 +79,8 @@ extern unsigned ata_exec_internal_sg(struct ata_device *dev,
 				     int dma_dir, struct scatterlist *sg,
 				     unsigned int n_elem, unsigned long timeout);
 extern unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd);
+extern int ata_wait_ready(struct ata_link *link, unsigned long deadline,
+			  int (*check_ready)(struct ata_link *link));
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 			   unsigned int flags, u16 *id);
 extern int ata_dev_reread_id(struct ata_device *dev, unsigned int readid_flags);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b6e1968..2638e35 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -835,6 +835,8 @@ extern void sata_print_link_status(struct ata_link *link);
 extern void ata_port_probe(struct ata_port *);
 extern int sata_set_spd(struct ata_link *link);
 extern int ata_std_prereset(struct ata_link *link, unsigned long deadline);
+extern int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
+				int (*check_ready)(struct ata_link *link));
 extern int sata_link_debounce(struct ata_link *link,
 			const unsigned long *params, unsigned long deadline);
 extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
-- 
1.5.2.4

