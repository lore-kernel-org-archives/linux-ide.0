From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] sata_mv: safer logic for limit_warnings
Date: Wed, 18 Jun 2008 21:57:42 -0400
Message-ID: <4859BD16.4020600@rtr.ca>
References: <485933A4.3010409@rtr.ca> <4859340E.60203@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4751 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbYFSB5n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jun 2008 21:57:43 -0400
In-Reply-To: <4859340E.60203@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

There is a miniscule chance that two separate host controllers
might be in sata_mv at the same time and manage to decrement
the static limit_warnings variable below zero.

Fix the comparison to deal with it.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

(blush) How did I miss that ???

--- old/drivers/ata/sata_mv.c	2008-06-17 19:22:15.000000000 -0400
+++ linux//drivers/ata/sata_mv.c	2008-06-18 21:52:19.000000000 -0400
@@ -1607,7 +1607,7 @@
 		 * Much of the time, this could just work regardless.
 		 * So for now, just log the incident, and allow the attempt.
 		 */
-		if (limit_warnings && (qc->nbytes / qc->sect_size) > 1) {
+		if (limit_warnings > 0 && (qc->nbytes / qc->sect_size) > 1) {
 			--limit_warnings;
 			ata_link_printk(qc->dev->link, KERN_WARNING, DRV_NAME
 					": attempting PIO w/multiple DRQ: "
