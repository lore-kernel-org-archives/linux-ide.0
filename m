From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/10] libata: fix sata_link_hardreset() @online out parameter handling
Date: Mon, 19 May 2008 01:15:05 +0900
Message-ID: <12111273153728-git-send-email-htejun@gmail.com>
References: <12111273141039-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:47696 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbYERQPW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 12:15:22 -0400
Received: by py-out-1112.google.com with SMTP id u52so1493694pyb.10
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 09:15:21 -0700 (PDT)
In-Reply-To: <12111273141039-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: liml@rtr.ca, Tejun Heo <htejun@gmail.com>

The @online out parameter is supposed to set to true iff link is
online and reset succeeded as advertised in the function description
and callers are coded expecting that.  However, sata_link_reset()
didn't behave this way on device readiness test failure.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 927b692..c6c316f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3653,9 +3653,13 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 	if (check_ready)
 		rc = ata_wait_ready(link, deadline, check_ready);
  out:
-	if (rc && rc != -EAGAIN)
+	if (rc && rc != -EAGAIN) {
+		/* online is set iff link is online && reset succeeded */
+		if (online)
+			*online = false;
 		ata_link_printk(link, KERN_ERR,
 				"COMRESET failed (errno=%d)\n", rc);
+	}
 	DPRINTK("EXIT, rc=%d\n", rc);
 	return rc;
 }
-- 
1.5.2.4

