From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] libata: disable failed devices only once in ata_bus_probe()
Date: Tue, 11 Apr 2006 22:26:29 +0900
Message-ID: <1144761989789-git-send-email-htejun@gmail.com>
References: <11447619891579-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.224]:8579 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750854AbWDKN0c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:26:32 -0400
Received: by wproxy.gmail.com with SMTP id i11so922156wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:26:32 -0700 (PDT)
In-Reply-To: <11447619891579-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Devices which consumed all their changes used to be disabled every
iteration.  This causes unnecessary noise in the console output.
Disable once and leave alone.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

54e2d4ab9771cc5d7c228ee0e2087f009df0efb4
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 56e1cc6..e42a8f3 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1411,12 +1411,9 @@ static int ata_bus_probe(struct ata_port
 	/* read IDENTIFY page and configure devices */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		dev = &ap->device[i];
-		dev->class = classes[i];
 
-		if (!tries[i]) {
-			ata_down_xfermask_limit(ap, dev, 1);
-			ata_dev_disable(ap, dev);
-		}
+		if (tries[i])
+			dev->class = classes[i];
 
 		if (!ata_dev_enabled(dev))
 			continue;
@@ -1477,6 +1474,11 @@ static int ata_bus_probe(struct ata_port
 			tries[dev->devno] = 0;
 	}
 
+	if (!tries[dev->devno]) {
+		ata_down_xfermask_limit(ap, dev, 1);
+		ata_dev_disable(ap, dev);
+	}
+
 	goto retry;
 }
 
-- 
1.2.4


