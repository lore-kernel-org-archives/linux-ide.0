From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/22] ahci: hardreset classification fix
Date: Thu, 11 May 2006 20:59:50 +0900
Message-ID: <11473487902190-git-send-email-htejun@gmail.com>
References: <11473487893774-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.194]:49320 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751566AbWEKL74 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 07:59:56 -0400
Received: by wx-out-0102.google.com with SMTP id t16so118654wxc
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 04:59:56 -0700 (PDT)
In-Reply-To: <11473487893774-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

AHCI calls ata_dev_classify() even when no device is attached which
results in false class code.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

fab598203c75f0ad53a57a2c629433586036e1f0
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index d23f002..c332554 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -670,7 +670,7 @@ static int ahci_hardreset(struct ata_por
 	rc = sata_std_hardreset(ap, class);
 	ahci_start_engine(ap);
 
-	if (rc == 0)
+	if (rc == 0 && sata_dev_present(ap))
 		*class = ahci_dev_classify(ap);
 	if (*class == ATA_DEV_UNKNOWN)
 		*class = ATA_DEV_NONE;
-- 
1.2.4


