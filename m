From: Elias Oltmanns <eo@nebensachen.de>
Subject: [PATCH 1/5] Make sure that ata_force_tbl is freed in case of an error
Date: Sat, 26 Jul 2008 08:23:23 +0200
Message-ID: <20080726062141.29070.75212.stgit@denkblock.local>
References: <87prp1kvyy.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:37617 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbYGZGXh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Jul 2008 02:23:37 -0400
In-Reply-To: <87prp1kvyy.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

This is just a trivial fix of a potential memory leak when ata_init()
encounters an error.

Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
---

 drivers/ata/libata-core.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9bef1a8..0a2f921 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
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


