From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/16] libata-link: update ata_scsi_error() to handle PMP links
Date: Sun, 1 Jul 2007 19:06:01 +0900
Message-ID: <11832843613176-git-send-email-htejun@gmail.com>
References: <11832843581399-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:52955 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756230AbXGAKGL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:06:11 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1879710wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:06:11 -0700 (PDT)
In-Reply-To: <11832843581399-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Update ata_scsi_error() to handle PMP links.  As error conditions can
occur on both host and PMP links, __ata_port_for_each_link() is used.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 2e0e11b..29f05b7 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -298,6 +298,8 @@ void ata_scsi_error(struct Scsi_Host *host)
  repeat:
 	/* invoke error handler */
 	if (ap->ops->error_handler) {
+		struct ata_link *link;
+
 		/* kill fast drain timer */
 		del_timer_sync(&ap->fastdrain_timer);
 
@@ -307,9 +309,11 @@ void ata_scsi_error(struct Scsi_Host *host)
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
@@ -345,7 +349,8 @@ void ata_scsi_error(struct Scsi_Host *host)
 		}
 
 		/* this run is complete, make sure EH info is clear */
-		memset(&ap->link.eh_info, 0, sizeof(ap->link.eh_info));
+		__ata_port_for_each_link(link, ap)
+			memset(&link->eh_info, 0, sizeof(link->eh_info));
 
 		/* Clear host_eh_scheduled while holding ap->lock such
 		 * that if exception occurs after this point but
-- 
1.5.0.3


