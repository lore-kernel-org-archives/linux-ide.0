From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/14] libata-link: update ata_scsi_error() to handle PMP links
Date: Mon, 6 Aug 2007 18:36:23 +0900
Message-ID: <11863929833537-git-send-email-htejun@gmail.com>
References: <11863929823677-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:47225 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761265AbXHFJgf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Aug 2007 05:36:35 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1076031rvb
        for <linux-ide@vger.kernel.org>; Mon, 06 Aug 2007 02:36:34 -0700 (PDT)
In-Reply-To: <11863929823677-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update ata_scsi_error() to handle PMP links.  As error conditions can
occur on both host and PMP links, __ata_port_for_each_link() is used.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index eb4c059..45eb932 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -363,6 +363,8 @@ void ata_scsi_error(struct Scsi_Host *host)
  repeat:
 	/* invoke error handler */
 	if (ap->ops->error_handler) {
+		struct ata_link *link;
+
 		/* kill fast drain timer */
 		del_timer_sync(&ap->fastdrain_timer);
 
@@ -372,9 +374,11 @@ void ata_scsi_error(struct Scsi_Host *host)
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
@@ -410,7 +414,8 @@ void ata_scsi_error(struct Scsi_Host *host)
 		}
 
 		/* this run is complete, make sure EH info is clear */
-		memset(&ap->link.eh_info, 0, sizeof(ap->link.eh_info));
+		__ata_port_for_each_link(link, ap)
+			memset(&link->eh_info, 0, sizeof(link->eh_info));
 
 		/* Clear host_eh_scheduled while holding ap->lock such
 		 * that if exception occurs after this point but
-- 
1.5.0.3


