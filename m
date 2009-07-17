From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream] libata: clear eh_info on reset completion
Date: Fri, 17 Jul 2009 11:58:33 +0900
Message-ID: <4A5FE8D9.2040702@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41223 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934037AbZGQC7k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Jul 2009 22:59:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Zdenek Kaspar <zkaspar82@gmail.com>

Resets are done with port frozen but some controllers still issue
interrupts during reset and they may end up recording error conditions
in ehi leading to unnecessary EH retrials.

This patch makes ata_eh_reset() clear ehi on reset completion.  As
reset is the most severe recovery action, there's nothing to lose by
clearing ehi on its completion.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Zdenek Kaspar <zkaspar82@gmail.com>
---
Zdenek, I moved the clearing above a bit.  It should work the same but
can you please test this one too?

Jeff, after Zdenek's verification, please commit this to #upstream.

Thanks.

 drivers/ata/libata-eh.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index a3df9fe..924a8de 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2572,11 +2572,17 @@ int ata_eh_reset(struct ata_link *link, int classify,
 			postreset(slave, classes);
 	}

-	/* clear cached SError */
+	/*
+	 * Some controllers can't be frozen very well and may set
+	 * spuruious error conditions during reset.  Clear accumulated
+	 * error information.  As reset is the final recovery action,
+	 * nothing is lost by doing this.
+	 */
 	spin_lock_irqsave(link->ap->lock, flags);
-	link->eh_info.serror = 0;
+	memset(&link->eh_info, 0, sizeof(link->eh_info));
 	if (slave)
-		slave->eh_info.serror = 0;
+		memset(&slave->eh_info, 0, sizeof(link->eh_info));
+	ap->pflags &= ~ATA_PFLAG_EH_PENDING;
 	spin_unlock_irqrestore(link->ap->lock, flags);

 	/* Make sure onlineness and classification result correspond.
