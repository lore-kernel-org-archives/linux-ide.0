From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] libata: increase the timeout when setting transfer mode
Date: Wed, 8 Jul 2015 13:06:12 -0400 (EDT)
Message-ID: <alpine.LRH.2.02.1507081304050.5355@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46265 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758552AbbGHRGN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Jul 2015 13:06:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

I have a ST4000DM000 disk. If Linux is booted while the disk is spun down,
the command that sets transfer mode causes the disk to spin up. The
spin-up takes longer than the default 5s timeout, so the command fails and
timeout is reported.

Fix this by increasing the timeout to 15s, which is enough for the disk to
spin up.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 drivers/ata/libata-core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-4.1.1/drivers/ata/libata-core.c
===================================================================
--- linux-4.1.1.orig/drivers/ata/libata-core.c	2015-07-07 22:21:39.962112941 +0200
+++ linux-4.1.1/drivers/ata/libata-core.c	2015-07-08 18:59:03.852951057 +0200
@@ -4501,7 +4501,8 @@ static unsigned int ata_dev_set_xfermode
 	else /* In the ancient relic department - skip all of this */
 		return 0;
 
-	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
+	/* On some disks, this command causes spin-up, so we need longer timeout */
+	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 15000);
 
 	DPRINTK("EXIT, err_mask=%x\n", err_mask);
 	return err_mask;
