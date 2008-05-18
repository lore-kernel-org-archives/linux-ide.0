From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/10] libata: ignore recovered PHY errors
Date: Mon, 19 May 2008 01:15:09 +0900
Message-ID: <12111273183948-git-send-email-htejun@gmail.com>
References: <12111273141039-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:47396 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011AbYERQP2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 12:15:28 -0400
Received: by py-out-1112.google.com with SMTP id u52so1493698pyb.10
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 09:15:28 -0700 (PDT)
In-Reply-To: <12111273141039-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: liml@rtr.ca, Tejun Heo <htejun@gmail.com>

No reason to get overzealous about recovered comm and data errors.
Some PHYs habitually sets them w/o no good reason and being draconian
about these soft error conditions doesn't seem to help anybody.

If need ever rises, we might need to add soft PHY error condition, say
AC_ERR_MAYBE_ATA_BUS and use it only to determine whether speed down
is necessary but I don't think that's very likely to happen.  It's far
more likely we'll get timeouts or fatal transmission errors if
recovered errors are so prominent that they hamper operation.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 751dad0..7894d83 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1308,12 +1308,7 @@ static void ata_eh_analyze_serror(struct ata_link *link)
 	unsigned int err_mask = 0, action = 0;
 	u32 hotplug_mask;
 
-	if (serror & SERR_PERSISTENT) {
-		err_mask |= AC_ERR_ATA_BUS;
-		action |= ATA_EH_RESET;
-	}
-	if (serror &
-	    (SERR_DATA_RECOVERED | SERR_COMM_RECOVERED | SERR_DATA)) {
+	if (serror & (SERR_PERSISTENT | SERR_DATA)) {
 		err_mask |= AC_ERR_ATA_BUS;
 		action |= ATA_EH_RESET;
 	}
-- 
1.5.2.4

