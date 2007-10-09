From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: wrap schedule_timeout_uninterruptible() in loop
Date: Tue, 9 Oct 2007 14:58:33 +0900
Message-ID: <20071009055833.GH12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:8843 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbXJIF6k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Oct 2007 01:58:40 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1917476wah
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 22:58:39 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Tasks in uninterruptible sleep might be woken up by unrelated events
and should check whether the condition it was waiting for has actually
triggered.  Wrap schedule_timeout_uninterruptible() in loop to achieve
it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 866ac9d..8aa6140 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2183,7 +2183,8 @@ int ata_eh_reset(struct ata_link *link, int classify,
 				"(errno=%d), retrying in %u secs\n",
 				rc, (jiffies_to_msecs(delta) + 999) / 1000);
 
-			schedule_timeout_uninterruptible(delta);
+			while (delta)
+				delta = schedule_timeout_uninterruptible(delta);
 		}
 
 		if (rc == -EPIPE ||
-- 
1.5.0.3

