From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/22] libata: silly fix in ata_scsi_start_stop_xlat()
Date: Thu, 11 May 2006 20:59:50 +0900
Message-ID: <11473487904084-git-send-email-htejun@gmail.com>
References: <11473487893774-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.193]:58054 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751557AbWEKL74 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 07:59:56 -0400
Received: by wx-out-0102.google.com with SMTP id t16so118649wxc
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 04:59:55 -0700 (PDT)
In-Reply-To: <11473487893774-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Don't directly access &qc->tf when tf == &qc->tf.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-scsi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

0dc90181abc07a5fa439bc099620f34381ec293b
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 9871f82..b0c83c2 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -748,7 +748,7 @@ static unsigned int ata_scsi_start_stop_
 		tf->nsect = 1;	/* 1 sector, lba=0 */
 
 		if (qc->dev->flags & ATA_DFLAG_LBA) {
-			qc->tf.flags |= ATA_TFLAG_LBA;
+			tf->flags |= ATA_TFLAG_LBA;
 
 			tf->lbah = 0x0;
 			tf->lbam = 0x0;
-- 
1.2.4


