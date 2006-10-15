From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 14/18] [PATCH] libata-link: update ata_scsi_error() to handle PMP links
Date: Mon, 16 Oct 2006 07:54:41 +0900
Message-ID: <11609528813672-git-send-email-htejun@gmail.com>
References: <1160952879581-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.194]:25686 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1422934AbWJOWyy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 18:54:54 -0400
Received: by nz-out-0102.google.com with SMTP id z3so453512nzf
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 15:54:53 -0700 (PDT)
In-Reply-To: <1160952879581-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update ata_scsi_error() to handle PMP links.  As error conditions can
occur on both host and PMP links, __ata_port_for_each_link() is used.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index d1927a7..5ce1e16 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -272,15 +272,19 @@ void ata_scsi_error(struct Scsi_Host *ho
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
@@ -315,7 +319,8 @@ void ata_scsi_error(struct Scsi_Host *ho
 		}
 
 		/* this run is complete, make sure EH info is clear */
-		memset(&ap->link.eh_info, 0, sizeof(ap->link.eh_info));
+		__ata_port_for_each_link(link, ap)
+			memset(&link->eh_info, 0, sizeof(link->eh_info));
 
 		/* Clear host_eh_scheduled while holding ap->lock such
 		 * that if exception occurs after this point but
-- 
1.4.2.3


