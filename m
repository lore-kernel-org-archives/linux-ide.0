From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/14] libata: report device number when PIO fails
Date: Sat, 1 Apr 2006 19:48:36 +0900
Message-ID: <11438885163722-git-send-email-htejun@gmail.com>
References: <11438885151530-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:54728 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751258AbWDAKsl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 05:48:41 -0500
Received: by zproxy.gmail.com with SMTP id o37so1210246nzf
        for <linux-ide@vger.kernel.org>; Sat, 01 Apr 2006 02:48:40 -0800 (PST)
In-Reply-To: <11438885151530-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Report device number on PIO failure.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

75ac0de9ac24614a2a75d80cb7f5bc1e7dc509ba
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 0d72792..93f8bce 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3898,7 +3898,8 @@ static void ata_pio_error(struct ata_por
 	WARN_ON(qc == NULL);
 
 	if (qc->tf.command != ATA_CMD_PACKET)
-		printk(KERN_WARNING "ata%u: PIO error\n", ap->id);
+		printk(KERN_WARNING "ata%u: dev %u PIO error\n",
+		       ap->id, qc->dev->devno);
 
 	/* make sure qc->err_mask is available to
 	 * know what's wrong and recover
-- 
1.2.4


