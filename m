From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/14] libata: clear ATA_DFLAG_PIO before setting it
Date: Sat, 1 Apr 2006 19:48:36 +0900
Message-ID: <11438885163134-git-send-email-htejun@gmail.com>
References: <11438885151530-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:39690 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751395AbWDAKso (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 05:48:44 -0500
Received: by zproxy.gmail.com with SMTP id o37so1210249nzf
        for <linux-ide@vger.kernel.org>; Sat, 01 Apr 2006 02:48:44 -0800 (PST)
In-Reply-To: <11438885151530-git-send-email-htejun@gmail.com>
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

24040601836bac07896b6be91011b217e7eb8083
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 0bc81c3..fe66e04 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1960,6 +1960,7 @@ static int ata_dev_set_mode(struct ata_p
 	unsigned int err_mask;
 	int rc;
 
+	dev->flags &= ~ATA_DFLAG_PIO;
 	if (dev->xfer_shift == ATA_SHIFT_PIO)
 		dev->flags |= ATA_DFLAG_PIO;
 
-- 
1.2.4


