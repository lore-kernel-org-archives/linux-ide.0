From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] ata: libata-pmp: Fix a possible data race in sata_pmp_handle_link_fail
Date: Tue,  8 May 2018 16:21:40 +0800
Message-ID: <20180508082140.14038-1-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: linux-ide@vger.kernel.org

The write operation to "link->flags" is protected by
the lock on line 898, but the read operation to
this data on line 892 is not protected by the lock.
Thus, there may exist a data race for "link->flags".

To fix this data race, the read operation to "link->flags" 
should be also protected by the lock.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/ata/libata-pmp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 85aa76116a30..42f61106ac70 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -889,15 +889,14 @@ static int sata_pmp_handle_link_fail(struct ata_link *link, int *link_tries)
 		return 1;
 
 	/* disable this link */
+	spin_lock_irqsave(ap->lock, flags);
 	if (!(link->flags & ATA_LFLAG_DISABLED)) {
 		ata_link_warn(link,
 			"failed to recover link after %d tries, disabling\n",
 			ATA_EH_PMP_LINK_TRIES);
-
-		spin_lock_irqsave(ap->lock, flags);
 		link->flags |= ATA_LFLAG_DISABLED;
-		spin_unlock_irqrestore(ap->lock, flags);
 	}
+	spin_unlock_irqrestore(ap->lock, flags);
 
 	ata_dev_disable(link->device);
 	link->eh_context.i.action = 0;
-- 
2.17.0
