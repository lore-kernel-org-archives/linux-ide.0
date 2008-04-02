From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstrema-fixes] libata: fix IDENTIFY order in ata_bus_probe()
Date: Wed, 02 Apr 2008 10:35:15 +0900
Message-ID: <47F2E2D3.6050100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.183]:55420 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbYDBBfW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Apr 2008 21:35:22 -0400
Received: by el-out-1112.google.com with SMTP id v27so1130016ele.17
        for <linux-ide@vger.kernel.org>; Tue, 01 Apr 2008 18:35:21 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Commit f58229f8060055b08b34008ea08f31de1e2f003c accidentally made
ata_bus_probe() not use reverse order probing.  Fix it.

There currently isn't any PATA driver which uses obsolete
ata_bus_probe() path, so this patch is mainly for correctness.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4851988..2db5c9c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2660,7 +2660,7 @@ int ata_bus_probe(struct ata_port *ap)
 	   specific sequence bass-ackwards so that PDIAG- is released by
 	   the slave device */
 
-	ata_link_for_each_dev(dev, &ap->link) {
+	ata_link_for_each_dev_reverse(dev, &ap->link) {
 		if (tries[dev->devno])
 			dev->class = classes[dev->devno];
 
