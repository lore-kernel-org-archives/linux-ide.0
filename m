From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/22] libata: hold host_set lock while finishing internal qc
Date: Thu, 11 May 2006 20:59:50 +0900
Message-ID: <1147348790254-git-send-email-htejun@gmail.com>
References: <11473487893774-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.195]:9925 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751601AbWEKMAD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:00:03 -0400
Received: by nz-out-0102.google.com with SMTP id 13so170486nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:00:03 -0700 (PDT)
In-Reply-To: <11473487893774-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Hold host_set lock while finishing internal qc.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

b187d8d384d552b351c297e6e3e8276781e5ffd5
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 763dd66..4c8e602 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1031,6 +1031,9 @@ unsigned ata_exec_internal(struct ata_po
 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
 	}
 
+	/* finish up */
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+
 	*tf = qc->tf;
 	err_mask = qc->err_mask;
 
@@ -1052,6 +1055,8 @@ unsigned ata_exec_internal(struct ata_po
 		ata_port_probe(ap);
 	}
 
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
 	return err_mask;
 }
 
-- 
1.2.4


