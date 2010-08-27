From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] ahci: fix hang on failed softreset
Date: Fri, 27 Aug 2010 11:09:15 +0200
Message-ID: <4C7780BB.6030604@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57577 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986Ab0H0JPX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Aug 2010 05:15:23 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Anssi Hannula <anssi.hannula@iki.fi>, Gwendal Grignou <gwendal@google.com>, stable <stable@kernel.org>

ahci_do_softreset() compared the current time and deadline in reverse
when calculating timeout for SRST issue.  The result is that if
@deadline is in future, SRST is issued with 0 timeout, which hasn't
caused any problem because it later waits for DRDY with the correct
timeout.  If deadline is already exceeded by the time SRST is about to
be issued, the timeout calculation underflows and if the device
doesn't respond, timeout doesn't trigger for a _very_ long time.

Reverse the incorrect comparison order.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Anssi Hannula <anssi.hannula@iki.fi>
Tested-by: Gwendal Grignou <gwendal@google.com>
Cc: stable@kernel.org
---
 drivers/ata/libahci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 81e772a..98c80e1 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1320,7 +1320,7 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 	/* issue the first D2H Register FIS */
 	msecs = 0;
 	now = jiffies;
-	if (time_after(now, deadline))
+	if (time_after(deadline, now))
 		msecs = jiffies_to_msecs(deadline - now);

 	tf.ctl |= ATA_SRST;
