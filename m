From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/15] libata: clear ATA_DFLAG_PIO before setting it
Date: Sun, 2 Apr 2006 18:51:53 +0900
Message-ID: <11439715133746-git-send-email-htejun@gmail.com>
References: <11439715124131-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:48058 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932306AbWDBJwC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 05:52:02 -0400
Received: by zproxy.gmail.com with SMTP id o37so1447005nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 01:52:01 -0800 (PST)
In-Reply-To: <11439715124131-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_dev_set_mode() is now responsible for managing ATA_DFLAG_PIO.
Clear it before setting it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

323a4f47e0e9e8b0011cebb706b66e20cdc1d672
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 167d9f1..169adad 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1949,6 +1949,7 @@ static int ata_dev_set_mode(struct ata_p
 	unsigned int err_mask;
 	int rc;
 
+	dev->flags &= ~ATA_DFLAG_PIO;
 	if (dev->xfer_shift == ATA_SHIFT_PIO)
 		dev->flags |= ATA_DFLAG_PIO;
 
-- 
1.2.4


