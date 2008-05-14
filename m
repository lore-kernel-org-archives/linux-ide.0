From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 01/04] sata_mv always do softreset
Date: Wed, 14 May 2008 09:18:12 -0400
Message-ID: <482AE694.5080604@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1679 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753888AbYENNSN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 May 2008 09:18:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Always request a softreset after hardreset succeeds.
This fixes a regression reported by Martin Michlmayr <tbm@cyrius.com>.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

For 2.6.26.

--- old/drivers/ata/sata_mv.c	2008-05-09 17:21:52.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-13 18:10:29.000000000 -0400
@@ -2728,6 +2728,7 @@
 
 		rc = sata_link_hardreset(link, timing, deadline + extra,
 					 &online, NULL);
+		rc = online ? -EAGAIN : rc;
 		if (rc)
 			return rc;
 		sata_scr_read(link, SCR_STATUS, &sstatus);
