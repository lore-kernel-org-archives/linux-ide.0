From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: make user scan wait for scan to complete
Date: Sat, 30 Sep 2006 18:07:17 +0900
Message-ID: <20060930090717.GO25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:60431 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751084AbWI3JHW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Sep 2006 05:07:22 -0400
Received: by py-out-1112.google.com with SMTP id n25so1617260pyg
        for <linux-ide@vger.kernel.org>; Sat, 30 Sep 2006 02:07:22 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: fajunchen@gmail.com

Make user scan wait for scan to complete.  This way user can wait for
warm plug request to complete and is prevented from causing EH event
storm by repetitively issuing scan request while EH is in progress.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Fajun Chen <fajunchen@gmail.com>

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3986ec8..e1fe832 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3138,10 +3138,12 @@ static int ata_scsi_user_scan(struct Scs
 			rc = -EINVAL;
 	}
 
-	if (rc == 0)
+	if (rc == 0) {
 		ata_port_schedule_eh(ap);
-
-	spin_unlock_irqrestore(ap->lock, flags);
+		spin_unlock_irqrestore(ap->lock, flags);
+		ata_port_wait_eh(ap);
+	} else
+		spin_unlock_irqrestore(ap->lock, flags);
 
 	return rc;
 }

