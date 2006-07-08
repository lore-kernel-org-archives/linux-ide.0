From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/6] libata-pmp-prep: make a number of functions global to libata
Date: Sat, 8 Jul 2006 14:51:17 +0900
Message-ID: <11523378771146-git-send-email-htejun@gmail.com>
References: <11523378773934-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.232]:4210 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964793AbWGHFu1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:50:27 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1484431wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:50:26 -0700 (PDT)
In-Reply-To: <11523378773934-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make a number of functions from libata-core.c and libata-eh.c global
to libata (drivers/scsi/libata.h).  These will be used by PMP.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    9 ++++-----
 drivers/scsi/libata-eh.c   |   31 +++++++++++++++----------------
 drivers/scsi/libata.h      |   19 +++++++++++++++++++
 3 files changed, 38 insertions(+), 21 deletions(-)

883d46c043da3fc913dbe979f49c2c19fd29889b
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index f004675..bb12e16 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -69,7 +69,6 @@ static unsigned int ata_dev_init_params(
 					u16 heads, u16 sectors);
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_device *dev);
-static int sata_link_init_spd_limit(struct ata_link *link);
 
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
@@ -1656,7 +1655,7 @@ void ata_port_probe(struct ata_port *ap)
  *	LOCKING:
  *	None.
  */
-static void sata_print_link_status(struct ata_link *link)
+void sata_print_link_status(struct ata_link *link)
 {
 	u32 sstatus, scontrol, tmp;
 
@@ -2583,7 +2582,7 @@ int sata_link_resume(struct ata_link *li
 	return sata_link_debounce(link, params);
 }
 
-static void ata_wait_spinup(struct ata_link *link)
+void ata_wait_spinup(struct ata_link *link)
 {
 	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned long end, secs;
@@ -5354,7 +5353,7 @@ void ata_dev_init(struct ata_device *dev
  *	LOCKING:
  *	Kernel thread context (may sleep)
  */
-static void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp)
+void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp)
 {
 	struct ata_device *dev;
 
@@ -5387,7 +5386,7 @@ static void ata_link_init(struct ata_por
  *	RETURNS:
  *	0 on success, -errno on failure.
  */
-static int sata_link_init_spd_limit(struct ata_link *link)
+int sata_link_init_spd_limit(struct ata_link *link)
 {
 
 	u32 scontrol, spd;
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 55d43c1..e6fd54a 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -59,7 +59,6 @@ struct list_head hp_poll_list = LIST_HEA
 DECLARE_WORK(hp_poll_work, ata_hp_poll_worker, NULL);
 
 static void __ata_port_freeze(struct ata_port *ap);
-static void ata_eh_finish(struct ata_port *ap);
 static void ata_eh_handle_port_suspend(struct ata_port *ap);
 static void ata_eh_handle_port_resume(struct ata_port *ap);
 
@@ -773,7 +772,7 @@ void ata_eh_qc_retry(struct ata_queued_c
  *	LOCKING:
  *	None.
  */
-static void ata_eh_detach_dev(struct ata_device *dev)
+void ata_eh_detach_dev(struct ata_device *dev)
 {
 	struct ata_link *link = dev->link;
 	struct ata_port *ap = link->ap;
@@ -810,8 +809,8 @@ static void ata_eh_detach_dev(struct ata
  *	LOCKING:
  *	None.
  */
-static void ata_eh_about_to_do(struct ata_link *link, struct ata_device *dev,
-			       unsigned int action)
+void ata_eh_about_to_do(struct ata_link *link, struct ata_device *dev,
+			unsigned int action)
 {
 	struct ata_port *ap = link->ap;
 	unsigned long flags;
@@ -838,8 +837,8 @@ static void ata_eh_about_to_do(struct at
  *	LOCKING:
  *	None.
  */
-static void ata_eh_done(struct ata_link *link, struct ata_device *dev,
-			unsigned int action)
+void ata_eh_done(struct ata_link *link, struct ata_device *dev,
+		 unsigned int action)
 {
 	ata_eh_clear_action(link, dev, &link->eh_context.i, action);
 }
@@ -1427,7 +1426,7 @@ static void ata_eh_link_autopsy(struct a
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
-static void ata_eh_autopsy(struct ata_port *ap)
+void ata_eh_autopsy(struct ata_port *ap)
 {
 	struct ata_link *link;
 
@@ -1513,7 +1512,7 @@ static void ata_eh_link_report(struct at
  *	LOCKING:
  *	None.
  */
-static void ata_eh_report(struct ata_port *ap)
+void ata_eh_report(struct ata_port *ap)
 {
 	struct ata_link *link;
 
@@ -1564,9 +1563,9 @@ static int ata_eh_followup_srst_needed(i
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
@@ -2039,10 +2038,10 @@ static void ata_eh_handle_dev_fail(struc
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
@@ -2196,7 +2195,7 @@ static int ata_eh_recover(struct ata_por
  *	LOCKING:
  *	None.
  */
-static void ata_eh_finish(struct ata_port *ap)
+void ata_eh_finish(struct ata_port *ap)
 {
 	int tag;
 
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index c544d88..e610894 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -54,11 +54,13 @@ extern unsigned int ata_do_simple_cmd(st
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 			   int post_reset, u16 *id);
 extern int ata_dev_configure(struct ata_device *dev, int print_info);
+extern void sata_print_link_status(struct ata_link *link);
 extern int sata_down_spd_limit(struct ata_link *link);
 extern int sata_set_spd_needed(struct ata_link *link);
 extern int ata_down_xfermask_limit(struct ata_device *dev, int force_pio0);
 extern int ata_set_mode(struct ata_link *link,
 			struct ata_device **r_failed_dev);
+extern void ata_wait_spinup(struct ata_link *link);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern void ata_qc_issue(struct ata_queued_cmd *qc);
 extern void __ata_qc_complete(struct ata_queued_cmd *qc);
@@ -68,6 +70,8 @@ extern void ata_dev_select(struct ata_po
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
 extern int ata_flush_cache(struct ata_device *dev);
 extern void ata_dev_init(struct ata_device *dev);
+extern void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp);
+extern int sata_link_init_spd_limit(struct ata_link *link);
 extern int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
 
@@ -117,6 +121,21 @@ extern enum scsi_eh_timer_return ata_scs
 extern void ata_scsi_error(struct Scsi_Host *host);
 extern void ata_port_wait_eh(struct ata_port *ap);
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
 extern void ata_hp_poll_activate(struct ata_port *ap);
 extern void ata_hp_poll_deactivate(struct ata_port *ap);
 
-- 
1.3.2


