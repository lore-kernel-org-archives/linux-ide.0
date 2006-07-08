From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/17] libata-link: update ata_scsi_error() to handle PMP links
Date: Sat, 8 Jul 2006 14:45:37 +0900
Message-ID: <1152337537362-git-send-email-htejun@gmail.com>
References: <11523375353473-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.195]:11714 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964786AbWGHFoy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:44:54 -0400
Received: by wx-out-0102.google.com with SMTP id t10so1205846wxc
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:44:54 -0700 (PDT)
In-Reply-To: <11523375353473-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update ata_scsi_error() to handle PMP links.  As error conditions can
occur on both host and PMP links, __ata_port_for_each_link() is used.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

b01c2d5a1be5b7b11edc375ac8477cf58993be00
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 7b4a7d8..6c473af 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -278,15 +278,19 @@ void ata_scsi_error(struct Scsi_Host *ho
  repeat:
 	/* invoke error handler */
 	if (ap->ops->error_handler) {
+		struct ata_link *link;
+
 		/* process port resume request */
 		ata_eh_handle_port_resume(ap);
 
 		/* fetch & clear EH info */
 		spin_lock_irqsave(ap->lock, flags);
 
-		memset(&ap->link.eh_context, 0, sizeof(ap->link.eh_context));
-		ap->link.eh_context.i = ap->link.eh_info;
-		memset(&ap->link.eh_info, 0, sizeof(ap->link.eh_info));
+		__ata_port_for_each_link(link, ap) {
+			memset(&link->eh_context, 0, sizeof(link->eh_context));
+			link->eh_context.i = link->eh_info;
+			memset(&link->eh_info, 0, sizeof(link->eh_info));
+		}
 
 		ap->pflags |= ATA_PFLAG_EH_IN_PROGRESS;
 		ap->pflags &= ~ATA_PFLAG_EH_PENDING;
@@ -321,7 +325,8 @@ void ata_scsi_error(struct Scsi_Host *ho
 		}
 
 		/* this run is complete, make sure EH info is clear */
-		memset(&ap->link.eh_info, 0, sizeof(ap->link.eh_info));
+		__ata_port_for_each_link(link, ap)
+			memset(&link->eh_info, 0, sizeof(link->eh_info));
 
 		/* Clear host_eh_scheduled while holding ap->lock such
 		 * that if exception occurs after this point but
-- 
1.3.2


