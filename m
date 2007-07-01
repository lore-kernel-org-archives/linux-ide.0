From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/12] libata-pmp-prep: implement ATA_LFLAG_NO_RETRY
Date: Sun, 1 Jul 2007 19:26:08 +0900
Message-ID: <11832855683184-git-send-email-htejun@gmail.com>
References: <11832855672398-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:34123 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755960AbXGAK0R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:26:17 -0400
Received: by py-out-1112.google.com with SMTP id u77so2082941pyb
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:26:17 -0700 (PDT)
In-Reply-To: <11832855672398-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
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
index 5d06509..e4363af 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2197,7 +2197,10 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
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
index 57da3ba..3ac3763 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -167,6 +167,7 @@ enum {
 	ATA_LFLAG_ASSUME_ATA	= (1 << 3), /* assume ATA class */
 	ATA_LFLAG_ASSUME_SEMB	= (1 << 4), /* assume SEMB class */
 	ATA_LFLAG_ASSUME_CLASS	= ATA_LFLAG_ASSUME_ATA | ATA_LFLAG_ASSUME_SEMB,
+	ATA_LFLAG_NO_RETRY	= (1 << 5), /* don't retry this link */
 
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
-- 
1.5.0.3


