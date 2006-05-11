From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/7] libata-pm-prep: make a number of functions global to libata
Date: Fri, 12 May 2006 01:37:50 +0900
Message-ID: <11473654703689-git-send-email-htejun@gmail.com>
References: <11473654703440-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:50067 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030334AbWEKQh5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:37:57 -0400
Received: by wr-out-0506.google.com with SMTP id i12so407142wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:37:57 -0700 (PDT)
In-Reply-To: <11473654703440-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make a number of functions from libata-core.c and libata-eh.c global
to libata (drivers/scsi/libata.h).  These will be used by PM.

---

 drivers/scsi/libata-core.c |    7 +++----
 drivers/scsi/libata-eh.c   |   24 ++++++++++++------------
 drivers/scsi/libata.h      |   15 +++++++++++++++
 3 files changed, 30 insertions(+), 16 deletions(-)

9827f37046db8165d763573523d3cd864966a1be
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 71f9ea7..d4e3b37 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -65,7 +65,6 @@ static unsigned int ata_dev_init_params(
 					u16 heads, u16 sectors);
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_device *dev);
-static int ata_link_init_sata_spd_limit(struct ata_link *link);
 
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
@@ -1594,7 +1593,7 @@ void ata_port_probe(struct ata_port *ap)
  *	LOCKING:
  *	None.
  */
-static void sata_print_link_status(struct ata_link *link)
+void sata_print_link_status(struct ata_link *link)
 {
 	u32 sstatus, scontrol, tmp;
 
@@ -5118,7 +5117,7 @@ void ata_dev_init(struct ata_device *dev
  *	LOCKING:
  *	Kernel thread context (may sleep)
  */
-static void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp)
+void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp)
 {
 	struct ata_device *dev;
 
@@ -5151,7 +5150,7 @@ static void ata_link_init(struct ata_por
  *	RETURNS:
  *	0 on success, -errno on failure.
  */
-static int ata_link_init_sata_spd_limit(struct ata_link *link)
+int ata_link_init_sata_spd_limit(struct ata_link *link)
 {
 
 	u32 scontrol, spd;
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 7abeb11..3764e21 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -679,7 +679,7 @@ void ata_eh_qc_retry(struct ata_queued_c
  *	LOCKING:
  *	None.
  */
-static void ata_eh_detach_dev(struct ata_device *dev)
+void ata_eh_detach_dev(struct ata_device *dev)
 {
 	struct ata_port *ap = dev->link->ap;
 	unsigned long flags;
@@ -710,7 +710,7 @@ static void ata_eh_detach_dev(struct ata
  *	LOCKING:
  *	None.
  */
-static void ata_eh_about_to_do(struct ata_link *link, unsigned int action)
+void ata_eh_about_to_do(struct ata_link *link, unsigned int action)
 {
 	struct ata_port *ap = link->ap;
 	unsigned long flags;
@@ -1296,7 +1296,7 @@ static void ata_eh_link_autopsy(struct a
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
-static void ata_eh_autopsy(struct ata_port *ap)
+void ata_eh_autopsy(struct ata_port *ap)
 {
 	struct ata_link *link;
 
@@ -1382,7 +1382,7 @@ static void ata_eh_link_report(struct at
  *	LOCKING:
  *	None.
  */
-static void ata_eh_report(struct ata_port *ap)
+void ata_eh_report(struct ata_port *ap)
 {
 	struct ata_link *link;
 
@@ -1431,9 +1431,9 @@ static int ata_eh_followup_srst_needed(i
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
@@ -1665,10 +1665,10 @@ static int ata_eh_skip_recovery(struct a
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
 	struct ata_eh_context *ehc;
@@ -1843,7 +1843,7 @@ static int ata_eh_recover(struct ata_por
  *	LOCKING:
  *	None.
  */
-static void ata_eh_finish(struct ata_port *ap)
+void ata_eh_finish(struct ata_port *ap)
 {
 	int tag;
 
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index f09c23e..e4d21aa 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -53,6 +53,7 @@ extern unsigned ata_exec_internal(struct
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 			   int post_reset, u16 *id);
 extern int ata_dev_configure(struct ata_device *dev, int print_info);
+extern void sata_print_link_status(struct ata_link *link);
 extern int ata_down_sata_spd_limit(struct ata_link *link);
 extern int ata_set_sata_spd_needed(struct ata_link *link);
 extern int ata_down_xfermask_limit(struct ata_device *dev, int force_pio0);
@@ -66,6 +67,8 @@ extern void ata_dev_select(struct ata_po
                            unsigned int wait, unsigned int can_sleep);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
 extern void ata_dev_init(struct ata_device *dev);
+extern void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp);
+extern int ata_link_init_sata_spd_limit(struct ata_link *link);
 extern int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
 
@@ -111,6 +114,18 @@ extern void ata_ering_init(struct ata_er
 extern enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
 extern void ata_scsi_error(struct Scsi_Host *host);
 extern void ata_qc_schedule_eh(struct ata_queued_cmd *qc);
+extern void ata_eh_detach_dev(struct ata_device *dev);
+extern void ata_eh_about_to_do(struct ata_link *link, unsigned int action);
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
 extern void ata_eh_scsi_hotplug(void *data);
 
 #endif /* __LIBATA_H__ */
-- 
1.2.4


