From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/5] [PATCH] libata-pmp-prep: make a number of functions global to libata
Date: Mon, 16 Oct 2006 08:17:47 +0900
Message-ID: <1160954267277-git-send-email-htejun@gmail.com>
References: <11609542672061-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:4274 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750946AbWJOXRy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 19:17:54 -0400
Received: by py-out-1112.google.com with SMTP id n25so2078415pyg
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 16:17:54 -0700 (PDT)
In-Reply-To: <11609542672061-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make a number of functions from libata-core.c and libata-eh.c global
to libata (drivers/ata/libata.h).  These will be used by PMP.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    8 ++++----
 drivers/ata/libata-eh.c   |   34 ++++++++++++++++------------------
 drivers/ata/libata.h      |   20 ++++++++++++++++++++
 3 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d7b28f6..0dd5c4c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1706,7 +1706,7 @@ void ata_port_probe(struct ata_port *ap)
  *	LOCKING:
  *	None.
  */
-static void sata_print_link_status(struct ata_link *link)
+void sata_print_link_status(struct ata_link *link)
 {
 	u32 sstatus, scontrol, tmp;
 
@@ -2639,7 +2639,7 @@ int sata_link_resume(struct ata_link *li
 	return sata_link_debounce(link, params);
 }
 
-static void ata_wait_spinup(struct ata_link *link)
+void ata_wait_spinup(struct ata_link *link)
 {
 	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned long end, secs;
@@ -5421,7 +5421,7 @@ void ata_dev_init(struct ata_device *dev
  *	LOCKING:
  *	Kernel thread context (may sleep)
  */
-static void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp)
+void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp)
 {
 	struct ata_device *dev;
 
@@ -5454,7 +5454,7 @@ static void ata_link_init(struct ata_por
  *	RETURNS:
  *	0 on success, -errno on failure.
  */
-static int sata_link_init_spd_limit(struct ata_link *link)
+int sata_link_init_spd_limit(struct ata_link *link)
 {
 
 	u32 scontrol, spd;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 8ee4674..ba8b173 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -51,10 +51,8 @@ MODULE_PARM_DESC(hotplug_polling_interva
 		 "Hotplug polling interval in milliseconds (default 2000)");
 
 static void __ata_port_freeze(struct ata_port *ap);
-static void ata_eh_finish(struct ata_port *ap);
 static void ata_eh_handle_port_suspend(struct ata_port *ap);
 static void ata_eh_handle_port_resume(struct ata_port *ap);
-static void ata_hp_poll_activate(struct ata_port *ap);
 
 
 static void ata_ering_record(struct ata_ering *ering, int is_io,
@@ -767,7 +765,7 @@ void ata_eh_qc_retry(struct ata_queued_c
  *	LOCKING:
  *	None.
  */
-static void ata_eh_detach_dev(struct ata_device *dev)
+void ata_eh_detach_dev(struct ata_device *dev)
 {
 	struct ata_link *link = dev->link;
 	struct ata_port *ap = link->ap;
@@ -804,8 +802,8 @@ static void ata_eh_detach_dev(struct ata
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
@@ -847,8 +845,8 @@ static void ata_eh_about_to_do(struct at
  *	LOCKING:
  *	None.
  */
-static void ata_eh_done(struct ata_link *link, struct ata_device *dev,
-			unsigned int action)
+void ata_eh_done(struct ata_link *link, struct ata_device *dev,
+		 unsigned int action)
 {
 	struct ata_eh_context *ehc = &link->eh_context;
 
@@ -1441,7 +1439,7 @@ static void ata_eh_link_autopsy(struct a
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
-static void ata_eh_autopsy(struct ata_port *ap)
+void ata_eh_autopsy(struct ata_port *ap)
 {
 	struct ata_link *link;
 
@@ -1527,7 +1525,7 @@ static void ata_eh_link_report(struct at
  *	LOCKING:
  *	None.
  */
-static void ata_eh_report(struct ata_port *ap)
+void ata_eh_report(struct ata_port *ap)
 {
 	struct ata_link *link;
 
@@ -1578,9 +1576,9 @@ static int ata_eh_followup_srst_needed(i
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
@@ -2061,10 +2059,10 @@ static void ata_eh_handle_dev_fail(struc
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
@@ -2218,7 +2216,7 @@ static int ata_eh_recover(struct ata_por
  *	LOCKING:
  *	None.
  */
-static void ata_eh_finish(struct ata_port *ap)
+void ata_eh_finish(struct ata_port *ap)
 {
 	int tag;
 
@@ -2428,7 +2426,7 @@ static unsigned long ata_hp_poll_delay(v
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
-static void ata_hp_poll_activate(struct ata_port *ap)
+void ata_hp_poll_activate(struct ata_port *ap)
 {
 	unsigned long flags;
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 92ae977..342888a 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
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
 extern void ata_port_init(struct ata_port *ap, struct ata_host *host,
@@ -119,7 +123,23 @@ extern enum scsi_eh_timer_return ata_scs
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
 extern void ata_hp_poll_worker(void *data);
+extern void ata_hp_poll_activate(struct ata_port *ap);
 extern void ata_hp_poll_deactivate(struct ata_port *ap);
 
 #endif /* __LIBATA_H__ */
-- 
1.4.2.3


