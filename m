From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/6] libata: fix timing computation in ata_eh_reset()
Date: Wed, 31 Oct 2007 10:17:02 +0900
Message-ID: <11937934272494-git-send-email-htejun@gmail.com>
References: <11937934273607-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.235.223.38] ([222.235.223.38]:9121 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752249AbXJaB2r (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 21:28:47 -0400
In-Reply-To: <11937934273607-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

As jiffies changes asynchronously, it needs to be cached if unchanging
timestamp is needed.  The code in ata_eh_reset() intended to do that
with @now but never actually did it.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 496edaf..f1c0117 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2184,7 +2184,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		unsigned long now = jiffies;
 
 		if (time_before(now, deadline)) {
-			unsigned long delta = deadline - jiffies;
+			unsigned long delta = deadline - now;
 
 			ata_link_printk(link, KERN_WARNING, "reset failed "
 				"(errno=%d), retrying in %u secs\n",
-- 
1.5.2.4

