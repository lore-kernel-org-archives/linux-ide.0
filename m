From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix handling of port actions in per-dev action mask
Date: Thu, 18 Jan 2007 17:22:18 +0900
Message-ID: <20070118082218.GR10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [221.139.199.108] ([221.139.199.108]:35433 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751990AbXARIW0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Jan 2007 03:22:26 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

libata EH ignores port-wide actions in per-dev action mask.  However,
device resume requests EH_SOFTRESET using per-dev action mask.  Under
certain circumstances, this results in not resetting frozen port after
resuming which causes failure of all commands.

This patch allows port-wide actions to be requested in per-dev action
mask.  Before EH recovery starts, port-wide actions will be collected.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
After being tested, this one should go into -stable too.

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 08ad44b..56cf59b 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1979,6 +1979,10 @@ static int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 
 		ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
 
+		/* collect port action mask recorded in dev actions */
+		ehc->i.action |= ehc->i.dev_action[i] & ~ATA_EH_PERDEV_MASK;
+		ehc->i.dev_action[i] &= ATA_EH_PERDEV_MASK;
+
 		/* process hotplug request */
 		if (dev->flags & ATA_DFLAG_DETACH)
 			ata_eh_detach_dev(dev);
