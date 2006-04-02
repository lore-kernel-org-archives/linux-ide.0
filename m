From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/15] libata: report device number when PIO fails
Date: Sun, 2 Apr 2006 18:51:52 +0900
Message-ID: <11439715121350-git-send-email-htejun@gmail.com>
References: <11439715124131-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:5252 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932272AbWDBJv6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 05:51:58 -0400
Received: by zproxy.gmail.com with SMTP id o37so1447008nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 01:51:58 -0800 (PST)
In-Reply-To: <11439715124131-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Report device number on PIO failure.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

531b46c6b78b8b702ffb87b7042816260b54fd23
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index b058602..843c08f 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3904,7 +3904,8 @@ static void ata_pio_error(struct ata_por
 	WARN_ON(qc == NULL);
 
 	if (qc->tf.command != ATA_CMD_PACKET)
-		printk(KERN_WARNING "ata%u: PIO error\n", ap->id);
+		printk(KERN_WARNING "ata%u: dev %u PIO error\n",
+		       ap->id, qc->dev->devno);
 
 	/* make sure qc->err_mask is available to
 	 * know what's wrong and recover
-- 
1.2.4


