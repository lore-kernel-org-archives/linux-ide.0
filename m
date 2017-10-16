From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] libata: Convert timers to use timer_setup()
Date: Mon, 16 Oct 2017 14:56:42 -0700
Message-ID: <20171016215642.GA101924@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:57213 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752199AbdJPV4q (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 16 Oct 2017 17:56:46 -0400
Received: by mail-pf0-f177.google.com with SMTP id b85so16761638pfj.13
        for <linux-ide@vger.kernel.org>; Mon, 16 Oct 2017 14:56:46 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Tejun Heo <tj@kernel.org>
---
Tejun asked that this go via the timer tree...
---
 drivers/ata/libata-core.c | 5 ++---
 drivers/ata/libata-eh.c   | 4 ++--
 drivers/ata/libata.h      | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 29e351669353..112350bbe645 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5980,9 +5980,8 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	INIT_LIST_HEAD(&ap->eh_done_q);
 	init_waitqueue_head(&ap->eh_wait_q);
 	init_completion(&ap->park_req_pending);
-	setup_deferrable_timer(&ap->fastdrain_timer,
-			       ata_eh_fastdrain_timerfn,
-			       (unsigned long)ap);
+	timer_setup(&ap->fastdrain_timer, ata_eh_fastdrain_timerfn,
+		    TIMER_DEFERRABLE);
 
 	ap->cbl = ATA_CBL_NONE;
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 49b3745d2c1f..b58f52d8b6b3 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -879,9 +879,9 @@ static int ata_eh_nr_in_flight(struct ata_port *ap)
 	return nr;
 }
 
-void ata_eh_fastdrain_timerfn(unsigned long arg)
+void ata_eh_fastdrain_timerfn(struct timer_list *t)
 {
-	struct ata_port *ap = (void *)arg;
+	struct ata_port *ap = from_timer(ap, t, fastdrain_timer);
 	unsigned long flags;
 	int cnt;
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 18bf1e995a18..f953cb4bb1ba 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -154,7 +154,7 @@ extern void ata_internal_cmd_timed_out(struct ata_device *dev, u8 cmd);
 extern void ata_eh_acquire(struct ata_port *ap);
 extern void ata_eh_release(struct ata_port *ap);
 extern void ata_scsi_error(struct Scsi_Host *host);
-extern void ata_eh_fastdrain_timerfn(unsigned long arg);
+extern void ata_eh_fastdrain_timerfn(struct timer_list *t);
 extern void ata_qc_schedule_eh(struct ata_queued_cmd *qc);
 extern void ata_dev_disable(struct ata_device *dev);
 extern void ata_eh_detach_dev(struct ata_device *dev);
-- 
2.7.4


-- 
Kees Cook
Pixel Security
