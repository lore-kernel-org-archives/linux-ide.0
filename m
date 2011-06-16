From: Manuel Zerpies <manuel.f.zerpies@ww.stud.uni-erlangen.de>
Subject: [PATCH 01/11] drivers/ide: use printk_ratelimited() instead of
 printk_ratelimit()
Date: Thu, 16 Jun 2011 14:06:37 +0200
Message-ID: <0a1488254bd51475a90133c0fc41a4d34b533ef4.1308142053.git.manuel.f.zerpies@ww.stud.uni-erlangen.de>
References: <cover.1308142053.git.manuel.f.zerpies@ww.stud.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1308142053.git.manuel.f.zerpies@ww.stud.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, christian.dietrich@informatik.uni-erlangen.de
List-Id: linux-ide@vger.kernel.org

Since printk_ratelimit() shouldn't be used anymore (see comment in
include/linux/printk.h), replace it with printk_ratelimited().

Signed-off-by: Manuel Zerpies <manuel.f.zerpies@ww.stud.uni-erlangen.de>
---
 drivers/ide/ide-atapi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 6f218e01..1b04f45 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -8,6 +8,7 @@
 #include <linux/ide.h>
 #include <linux/scatterlist.h>
 #include <linux/gfp.h>
+#include <linux/ratelimit.h>
 
 #include <scsi/scsi.h>
 
@@ -200,8 +201,7 @@ void ide_prep_sense(ide_drive_t *drive, struct request *rq)
 	err = blk_rq_map_kern(drive->queue, sense_rq, sense, sense_len,
 			      GFP_NOIO);
 	if (unlikely(err)) {
-		if (printk_ratelimit())
-			printk(KERN_WARNING PFX "%s: failed to map sense "
+		printk_ratelimited(KERN_WARNING PFX "%s: failed to map sense "
 					    "buffer\n", drive->name);
 		return;
 	}
-- 
1.7.4.1
