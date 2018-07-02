From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ide: remove redundant variables queue_run_ms and left
Date: Mon,  2 Jul 2018 10:47:05 +0100
Message-ID: <20180702094705.15734-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
To: "David S . Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable queue_run_ms is not being used and is redundant and hence can
be removed. Removing this also means that variable left can also be
removed.

Cleans up clang warning:
warning: variable ‘queue_run_ms’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/ide/ide-io.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index a444bad7a2aa..0d93e0cfbeaf 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -460,7 +460,6 @@ void do_ide_request(struct request_queue *q)
 	struct ide_host *host = hwif->host;
 	struct request	*rq = NULL;
 	ide_startstop_t	startstop;
-	unsigned long queue_run_ms = 3; /* old plug delay */
 
 	spin_unlock_irq(q->queue_lock);
 
@@ -480,9 +479,6 @@ void do_ide_request(struct request_queue *q)
 		prev_port = hwif->host->cur_port;
 		if (drive->dev_flags & IDE_DFLAG_SLEEPING &&
 		    time_after(drive->sleep, jiffies)) {
-			unsigned long left = jiffies - drive->sleep;
-
-			queue_run_ms = jiffies_to_msecs(left + 1);
 			ide_unlock_port(hwif);
 			goto plug_device;
 		}
-- 
2.17.1
