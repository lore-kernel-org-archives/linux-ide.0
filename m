From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH] libata: use setup_deferrable_timer
Date: Sat, 11 Mar 2017 08:47:01 +0800
Message-ID: <7eff953a3a1eaa33e39692b18d59e6baecb189cc.1489060962.git.geliangtang@gmail.com>
References: <3afa5498142ef68256023257dad37b9f8352e65e.1489060803.git.geliangtang@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34589 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933696AbdCKArn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Mar 2017 19:47:43 -0500
In-Reply-To: <3afa5498142ef68256023257dad37b9f8352e65e.1489060803.git.geliangtang@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Use setup_deferrable_timer() instead of init_timer_deferrable() to
simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/ata/libata-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ca75823..55d3c8b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5902,9 +5902,9 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	INIT_LIST_HEAD(&ap->eh_done_q);
 	init_waitqueue_head(&ap->eh_wait_q);
 	init_completion(&ap->park_req_pending);
-	init_timer_deferrable(&ap->fastdrain_timer);
-	ap->fastdrain_timer.function = ata_eh_fastdrain_timerfn;
-	ap->fastdrain_timer.data = (unsigned long)ap;
+	setup_deferrable_timer(&ap->fastdrain_timer,
+			       ata_eh_fastdrain_timerfn,
+			       (unsigned long)ap);
 
 	ap->cbl = ATA_CBL_NONE;
 
-- 
2.9.3

