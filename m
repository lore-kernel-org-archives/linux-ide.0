From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V1 1/2] libata-sff: add ata_sff_queue_work() & ata_sff_queue_delayed_work()
Date: Fri, 18 Feb 2011 17:10:13 +0530
Message-ID: <1cad52b042eff06bf671c32e48920bf487d800a4.1298029161.git.viresh.kumar@st.com>
References: <cover.1298029161.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:42011 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755888Ab1BRLlX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Feb 2011 06:41:23 -0500
In-Reply-To: <cover.1298029161.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: viresh.linux@gmail.com, shiraz.hashim@st.com, armando.visconti@st.com, amit.goel@st.com, Viresh Kumar <viresh.kumar@st.com>

This patch adds ata_sff_queue_work() & ata_sff_queue_delayed_work() routine in
libata-sff.c file. This routine can be used by ata drivers to use ata_sff_wq.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/ata/libata-sff.c |   15 +++++++++++++--
 include/linux/libata.h   |    3 +++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index af6141b..a311b43 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1302,6 +1302,18 @@ fsm_start:
 }
 EXPORT_SYMBOL_GPL(ata_sff_hsm_move);
 
+void ata_sff_queue_work(struct work_struct *work)
+{
+	queue_work(ata_sff_wq, work);
+}
+EXPORT_SYMBOL_GPL(ata_sff_queue_work);
+
+void ata_sff_queue_delayed_work(struct delayed_work *dwork, unsigned long delay)
+{
+	queue_delayed_work(ata_sff_wq, dwork, delay);
+}
+EXPORT_SYMBOL_GPL(ata_sff_queue_delayed_work);
+
 void ata_sff_queue_pio_task(struct ata_link *link, unsigned long delay)
 {
 	struct ata_port *ap = link->ap;
@@ -1311,8 +1323,7 @@ void ata_sff_queue_pio_task(struct ata_link *link, unsigned long delay)
 	ap->sff_pio_task_link = link;
 
 	/* may fail if ata_sff_flush_pio_task() in progress */
-	queue_delayed_work(ata_sff_wq, &ap->sff_pio_task,
-			   msecs_to_jiffies(delay));
+	ata_sff_queue_delayed_work(&ap->sff_pio_task, msecs_to_jiffies(delay));
 }
 EXPORT_SYMBOL_GPL(ata_sff_queue_pio_task);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c9c5d7a..d506bc4 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1613,6 +1613,9 @@ extern void ata_sff_irq_on(struct ata_port *ap);
 extern void ata_sff_irq_clear(struct ata_port *ap);
 extern int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
 			    u8 status, int in_wq);
+extern void ata_sff_queue_work(struct work_struct *work);
+extern void ata_sff_queue_delayed_work(struct delayed_work *dwork,
+		unsigned long delay);
 extern void ata_sff_queue_pio_task(struct ata_link *link, unsigned long delay);
 extern unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc);
 extern bool ata_sff_qc_fill_rtf(struct ata_queued_cmd *qc);
-- 
1.7.2.2

