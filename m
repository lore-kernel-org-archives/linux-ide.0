From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata-sff: don't whine on spurious IRQ
Date: Wed, 31 Mar 2010 16:41:18 +0900
Message-ID: <4BB2FC9E.3050301@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34904 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756946Ab0CaHiQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Mar 2010 03:38:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On configurations where IRQ line is shared with a different
controller, spurious IRQs may happen continuously.  The message was
put there primarily for debugging anyway.  Kill it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-sff.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 2774772..9d20f7a 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1815,10 +1815,6 @@ retry:
 			    !ap->ops->sff_irq_check(ap))
 				continue;

-			if (printk_ratelimit())
-				ata_port_printk(ap, KERN_INFO,
-						"clearing spurious IRQ\n");
-
 			if (idle & (1 << i)) {
 				ap->ops->sff_check_status(ap);
 				ap->ops->sff_irq_clear(ap);
