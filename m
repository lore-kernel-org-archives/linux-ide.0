From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/12] libata-pmp-prep: make a number of functions global to libata
Date: Sun, 1 Jul 2007 19:26:08 +0900
Message-ID: <1183285568371-git-send-email-htejun@gmail.com>
References: <11832855672398-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:24640 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755672AbXGAK0N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:26:13 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1884682wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:26:13 -0700 (PDT)
In-Reply-To: <11832855672398-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Make a number of functions from libata-core.c and libata-eh.c global
to libata (drivers/ata/libata.h).  These will be used by PMP.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    4 ++--
 drivers/ata/libata-eh.c   |   31 +++++++++++++++----------------
 drivers/ata/libata.h      |   17 +++++++++++++++++
 3 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d366ac2..1e1855e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6010,7 +6010,7 @@ void ata_dev_init(struct ata_device *dev)
  *	LOCKING:
  *	Kernel thread context (may sleep)
  */
-static void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp)
+void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp)
 {
 	int i;
 
@@ -6045,7 +6045,7 @@ static void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp)
  *	RETURNS:
  *	0 on success, -errno on failure.
  */
-static int sata_link_init_spd_limit(struct ata_link *link)
+int sata_link_init_spd_limit(struct ata_link *link)
 {
 	u32 scontrol, spd;
 	int rc;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7e8ec17..ec0b90b 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -74,7 +74,6 @@ static const unsigned long ata_eh_reset_timeouts[] = {
 };
 
 static void __ata_port_freeze(struct ata_port *ap);
-static void ata_eh_finish(struct ata_port *ap);
 #ifdef CONFIG_PM
 static void ata_eh_handle_port_suspend(struct ata_port *ap);
 static void ata_eh_handle_port_resume(struct ata_port *ap);
@@ -883,7 +882,7 @@ void ata_eh_qc_retry(struct ata_queued_cmd *qc)
  *	LOCKING:
  *	None.
  */
-static void ata_eh_detach_dev(struct ata_device *dev)
+void ata_eh_detach_dev(struct ata_device *dev)
 {
 	struct ata_link *link = dev->link;
 	struct ata_port *ap = link->ap;
@@ -920,8 +919,8 @@ static void ata_eh_detach_dev(struct ata_device *dev)
  *	LOCKING:
  *	None.
  */
-static void ata_eh_about_to_do(struct ata_link *link, struct ata_device *dev,
-			       unsigned int action)
+void ata_eh_about_to_do(struct ata_link *link, struct ata_device *dev,
+			unsigned int action)
 {
 	struct ata_port *ap = link->ap;
 	struct ata_eh_info *ehi = &link->eh_info;
@@ -963,8 +962,8 @@ static void ata_eh_about_to_do(struct ata_link *link, struct ata_device *dev,
  *	LOCKING:
  *	None.
  */
-static void ata_eh_done(struct ata_link *link, struct ata_device *dev,
-			unsigned int action)
+void ata_eh_done(struct ata_link *link, struct ata_device *dev,
+		 unsigned int action)
 {
 	struct ata_eh_context *ehc = &link->eh_context;
 
@@ -1624,7 +1623,7 @@ static void ata_eh_link_autopsy(struct ata_link *link)
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
-static void ata_eh_autopsy(struct ata_port *ap)
+void ata_eh_autopsy(struct ata_port *ap)
 {
 	struct ata_link *link;
 
@@ -1729,7 +1728,7 @@ static void ata_eh_link_report(struct ata_link *link)
  *	LOCKING:
  *	None.
  */
-static void ata_eh_report(struct ata_port *ap)
+void ata_eh_report(struct ata_port *ap)
 {
 	struct ata_link *link;
 
@@ -1780,9 +1779,9 @@ static int ata_eh_followup_srst_needed(int rc, int classify,
 	return 0;
 }
 
-static int ata_eh_reset(struct ata_link *link, int classify,
-			ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
-			ata_reset_fn_t hardreset, ata_postreset_fn_t postreset)
+int ata_eh_reset(struct ata_link *link, int classify,
+		 ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
+		 ata_reset_fn_t hardreset, ata_postreset_fn_t postreset)
 {
 	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned int *classes = ehc->classes;
@@ -2158,10 +2157,10 @@ static int ata_eh_handle_dev_fail(struct ata_device *dev, int err)
  *	RETURNS:
  *	0 on success, -errno on failure.
  */
-static int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
-			  ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
-			  ata_postreset_fn_t postreset,
-			  struct ata_link **r_failed_link)
+int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
+		   ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
+		   ata_postreset_fn_t postreset,
+		   struct ata_link **r_failed_link)
 {
 	struct ata_link *link;
 	struct ata_device *dev;
@@ -2307,7 +2306,7 @@ static int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
  *	LOCKING:
  *	None.
  */
-static void ata_eh_finish(struct ata_port *ap)
+void ata_eh_finish(struct ata_port *ap)
 {
 	int tag;
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 4153817..114b988 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -93,6 +93,8 @@ extern void ata_dev_select(struct ata_port *ap, unsigned int device,
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
 extern int ata_flush_cache(struct ata_device *dev);
 extern void ata_dev_init(struct ata_device *dev);
+extern void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp);
+extern int sata_link_init_spd_limit(struct ata_link *link);
 extern int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern struct ata_port *ata_port_alloc(struct ata_host *host);
@@ -154,6 +156,21 @@ extern void ata_scsi_error(struct Scsi_Host *host);
 extern void ata_port_wait_eh(struct ata_port *ap);
 extern void ata_eh_fastdrain_timerfn(unsigned long arg);
 extern void ata_qc_schedule_eh(struct ata_queued_cmd *qc);
+extern void ata_eh_detach_dev(struct ata_device *dev);
+extern void ata_eh_about_to_do(struct ata_link *link, struct ata_device *dev,
+			       unsigned int action);
+extern void ata_eh_done(struct ata_link *link, struct ata_device *dev,
+			unsigned int action);
+extern void ata_eh_autopsy(struct ata_port *ap);
+extern void ata_eh_report(struct ata_port *ap);
+extern int ata_eh_reset(struct ata_link *link, int classify,
+			ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
+			ata_reset_fn_t hardreset, ata_postreset_fn_t postreset);
+extern int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
+			  ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
+			  ata_postreset_fn_t postreset,
+			  struct ata_link **r_failed_disk);
+extern void ata_eh_finish(struct ata_port *ap);
 
 /* libata-sff.c */
 extern u8 ata_irq_on(struct ata_port *ap);
-- 
1.5.0.3


