From: Cong Wang <amwang@redhat.com>
Subject: [PATCH 15/60] ide: remove the second argument of k[un]map_atomic()
Date: Fri, 10 Feb 2012 13:39:36 +0800
Message-ID: <1328852421-19678-16-git-send-email-amwang@redhat.com>
References: <1328852421-19678-1-git-send-email-amwang@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1328852421-19678-1-git-send-email-amwang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Cong Wang <amwang@redhat.com>, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Cong Wang <amwang@redhat.com>
---
 drivers/ide/ide-taskfile.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index 5bc2839..729428e 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -253,7 +253,7 @@ void ide_pio_bytes(ide_drive_t *drive, struct ide_cmd *cmd,
 		if (page_is_high)
 			local_irq_save(flags);
 
-		buf = kmap_atomic(page, KM_BIO_SRC_IRQ) + offset;
+		buf = kmap_atomic(page) + offset;
 
 		cmd->nleft -= nr_bytes;
 		cmd->cursg_ofs += nr_bytes;
@@ -269,7 +269,7 @@ void ide_pio_bytes(ide_drive_t *drive, struct ide_cmd *cmd,
 		else
 			hwif->tp_ops->input_data(drive, cmd, buf, nr_bytes);
 
-		kunmap_atomic(buf, KM_BIO_SRC_IRQ);
+		kunmap_atomic(buf);
 
 		if (page_is_high)
 			local_irq_restore(flags);
-- 
1.7.7.6
