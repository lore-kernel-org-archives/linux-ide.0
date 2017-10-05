From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] libata: Convert timers to use timer_setup()
Date: Wed, 4 Oct 2017 17:48:42 -0700
Message-ID: <20171005004842.GA23011@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-ide@vger.kernel.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This requires commit 686fef928bba ("timer: Prepare to change timer
callback argument type") in v4.14-rc3, but should be otherwise
stand-alone.
---
 drivers/ata/libata-core.c | 5 ++---
 drivers/ata/libata-eh.c   | 4 ++--
 drivers/ata/libata.h      | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1945a8ea2099..0ac2685435a4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5979,9 +5979,8 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
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
index e4effef0c83f..ece6fd91a947 100644
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
index 839d487394b7..08a245b76417 100644
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
