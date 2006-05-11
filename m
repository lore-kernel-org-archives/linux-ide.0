From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/14] libata-link: update ata_scsi_error() to handle PM links
Date: Fri, 12 May 2006 01:30:23 +0900
Message-ID: <1147365023777-git-send-email-htejun@gmail.com>
References: <11473650221713-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.227]:26763 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751786AbWEKQaf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:30:35 -0400
Received: by wr-out-0506.google.com with SMTP id 55so367470wri
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:30:34 -0700 (PDT)
In-Reply-To: <11473650221713-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update ata_scsi_error() to handle PM links.  As error conditions can
occur on both host and PM links, __ata_port_for_each_link() is used.

---

 drivers/scsi/libata-eh.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

48be52e2b9a5f5ec81af8e3da1e784a63f1cde47
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 1bd7d1e..8e89379 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -235,13 +235,17 @@ void ata_scsi_error(struct Scsi_Host *ho
  repeat:
 	/* invoke error handler */
 	if (ap->ops->error_handler) {
+		struct ata_link *link;
+
 		/* fetch & clear EH info */
 		spin_lock_irqsave(hs_lock, flags);
 
-		memset(&ap->link.eh_context, 0, sizeof(ap->link.eh_context));
-		if (!(ap->flags & ATA_FLAG_UNLOADING))
-			ap->link.eh_context.i = ap->link.eh_info;
-		memset(&ap->link.eh_info, 0, sizeof(ap->link.eh_info));
+		__ata_port_for_each_link(link, ap) {
+			memset(&link->eh_context, 0, sizeof(link->eh_context));
+			if (!(ap->flags & ATA_FLAG_UNLOADING))
+				link->eh_context.i = link->eh_info;
+			memset(&link->eh_info, 0, sizeof(link->eh_info));
+		}
 
 		ap->flags &= ~ATA_FLAG_EH_PENDING;
 
@@ -269,7 +273,8 @@ void ata_scsi_error(struct Scsi_Host *ho
 		}
 
 		/* this run is complete, make sure EH info is clear */
-		memset(&ap->link.eh_info, 0, sizeof(ap->link.eh_info));
+		__ata_port_for_each_link(link, ap)
+			memset(&link->eh_info, 0, sizeof(link->eh_info));
 
 		/* Clear host_eh_scheduled while holding hs_lock such
 		 * that if exception occurs after this point but
-- 
1.2.4


