From: akpm@linux-foundation.org
Subject: [patch 2/2] libata-core: make sure that ata_force_tbl is freed in case of an error
Date: Wed, 30 Jul 2008 12:32:39 -0700
Message-ID: <200807301932.m6UJWdaM012125@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48835 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754481AbYG3TeA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2008 15:34:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, eo@nebensachen.de, alan@lxorguk.ukuu.org.uk, tj@kernel.org

From: Elias Oltmanns <eo@nebensachen.de>

Fix a potential memory leak when ata_init() encounters an error.

Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-core.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff -puN drivers/ata/libata-core.c~libata-core-make-sure-that-ata_force_tbl-is-freed-in-case-of-an-error drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c~libata-core-make-sure-that-ata_force_tbl-is-freed-in-case-of-an-error
+++ a/drivers/ata/libata-core.c
@@ -6088,16 +6088,20 @@ static int __init ata_init(void)
 
 	ata_wq = create_workqueue("ata");
 	if (!ata_wq)
-		return -ENOMEM;
+		goto free_force_tbl;
 
 	ata_aux_wq = create_singlethread_workqueue("ata_aux");
-	if (!ata_aux_wq) {
-		destroy_workqueue(ata_wq);
-		return -ENOMEM;
-	}
+	if (!ata_aux_wq)
+		goto free_wq;
 
 	printk(KERN_DEBUG "libata version " DRV_VERSION " loaded.\n");
 	return 0;
+
+free_wq:
+	destroy_workqueue(ata_wq);
+free_force_tbl:
+	kfree(ata_force_tbl);
+	return -ENOMEM;
 }
 
 static void __exit ata_exit(void)
_
