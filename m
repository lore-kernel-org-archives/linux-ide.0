From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] ide: Convert timers to use timer_setup()
Date: Thu, 2 Nov 2017 16:11:48 -0700
Message-ID: <20171102231148.GA100210@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/ide/ide-io.c    | 4 ++--
 drivers/ide/ide-probe.c | 2 +-
 include/linux/ide.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 3a234701d92c..6f25da56a169 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -611,9 +611,9 @@ static int drive_is_ready(ide_drive_t *drive)
  *	logic that wants cleaning up.
  */
  
-void ide_timer_expiry (unsigned long data)
+void ide_timer_expiry(struct timer_list *t)
 {
-	ide_hwif_t	*hwif = (ide_hwif_t *)data;
+	ide_hwif_t	*hwif = from_timer(hwif, t, timer);
 	ide_drive_t	*uninitialized_var(drive);
 	ide_handler_t	*handler;
 	unsigned long	flags;
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index eaf39e5db08b..17fd55af4d92 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1184,7 +1184,7 @@ static void ide_init_port_data(ide_hwif_t *hwif, unsigned int index)
 
 	spin_lock_init(&hwif->lock);
 
-	setup_timer(&hwif->timer, &ide_timer_expiry, (unsigned long)hwif);
+	timer_setup(&hwif->timer, ide_timer_expiry, 0);
 
 	init_completion(&hwif->gendev_rel_comp);
 
diff --git a/include/linux/ide.h b/include/linux/ide.h
index dc152e4b7f73..cc412175d036 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1211,7 +1211,7 @@ extern int ide_wait_not_busy(ide_hwif_t *hwif, unsigned long timeout);
 
 extern void ide_stall_queue(ide_drive_t *drive, unsigned long timeout);
 
-extern void ide_timer_expiry(unsigned long);
+extern void ide_timer_expiry(struct timer_list *t);
 extern irqreturn_t ide_intr(int irq, void *dev_id);
 extern void do_ide_request(struct request_queue *);
 extern void ide_requeue_and_plug(ide_drive_t *drive, struct request *rq);
-- 
2.7.4


-- 
Kees Cook
Pixel Security
