From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3] libata: cosmetic update to ata_bus_probe()
Date: Tue, 11 Apr 2006 22:26:29 +0900
Message-ID: <11447619893595-git-send-email-htejun@gmail.com>
References: <11447619891579-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.233]:6275 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750848AbWDKN0b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:26:31 -0400
Received: by wproxy.gmail.com with SMTP id i11so922159wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:26:31 -0700 (PDT)
In-Reply-To: <11447619891579-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Move ata_set_mode() failure handling outside of ap->ops->set_mode if
clause such that it can handle ap->ops->set_mode failures after it's
updated.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

8ed14e7229110cf9e338ba866fdca78373d1215d
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index e42a8f3..f1abe75 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1441,12 +1441,12 @@ static int ata_bus_probe(struct ata_port
 				break;
 			}
 		rc = 0;
-	} else {
+	} else
 		rc = ata_set_mode(ap, &dev);
-		if (rc) {
-			down_xfermask = 1;
-			goto fail;
-		}
+
+	if (rc) {
+		down_xfermask = 1;
+		goto fail;
 	}
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
-- 
1.2.4


