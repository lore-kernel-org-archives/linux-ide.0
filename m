From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/12] libata-pmp-prep: implement ATA_LFLAG_NO_RETRY
Date: Sun, 23 Sep 2007 13:14:12 +0900
Message-ID: <11905208522521-git-send-email-htejun@gmail.com>
References: <11905208513747-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:64083 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613AbXIWEO0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Sep 2007 00:14:26 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1545873wah
        for <linux-ide@vger.kernel.org>; Sat, 22 Sep 2007 21:14:25 -0700 (PDT)
In-Reply-To: <11905208513747-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Some PMP links are connected to internal pseudo devices which may come
and go depending on situation.  There's no reason to try hard to
recover them.  ATA_LFLAG_NO_RETRY tells EH to not retry if the device
attached to the link fails.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |    5 ++++-
 include/linux/libata.h  |    1 +
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7be04bd..8f8ed4d 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2335,7 +2335,10 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 		struct ata_eh_context *ehc = &link->eh_context;
 
 		ata_link_for_each_dev(dev, link) {
-			ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
+			if (link->flags & ATA_LFLAG_NO_RETRY)
+				ehc->tries[dev->devno] = 1;
+			else
+				ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
 
 			/* collect port action mask recorded in dev actions */
 			ehc->i.action |= ehc->i.dev_action[dev->devno] &
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6266fff..adeee73 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -169,6 +169,7 @@ enum {
 	ATA_LFLAG_ASSUME_ATA	= (1 << 3), /* assume ATA class */
 	ATA_LFLAG_ASSUME_SEMB	= (1 << 4), /* assume SEMB class */
 	ATA_LFLAG_ASSUME_CLASS	= ATA_LFLAG_ASSUME_ATA | ATA_LFLAG_ASSUME_SEMB,
+	ATA_LFLAG_NO_RETRY	= (1 << 5), /* don't retry this link */
 
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
-- 
1.5.0.3


