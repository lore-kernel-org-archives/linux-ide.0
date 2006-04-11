From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/16] libata-eh-fw: hold host_set lock while finishing internal qc
Date: Tue, 11 Apr 2006 22:42:54 +0900
Message-ID: <11447629741173-git-send-email-htejun@gmail.com>
References: <11447629733305-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.239]:13463 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750895AbWDKNm5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:42:57 -0400
Received: by wproxy.gmail.com with SMTP id i11so925405wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:42:57 -0700 (PDT)
In-Reply-To: <11447629733305-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Hold host_set lock while finishing internal qc.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

ba608e38dd436e9129b6a9c99b9fa1f77a79a024
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 8bf8cc6..d2a7b6f 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1031,6 +1031,8 @@ unsigned ata_exec_internal(struct ata_po
 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
 	}
 
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+
 	*tf = qc->tf;
 	err_mask = qc->err_mask;
 
@@ -1052,6 +1054,8 @@ unsigned ata_exec_internal(struct ata_po
 		ata_port_probe(ap);
 	}
 
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
 	return err_mask;
 }
 
-- 
1.2.4


