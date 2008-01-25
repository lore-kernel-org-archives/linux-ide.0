From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 15/14] sata_mv NCQ support
Date: Thu, 24 Jan 2008 19:04:15 -0500
Message-ID: <4799277F.8020300@rtr.ca>
References: <4798FB68.70400@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1657 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbYAYAEQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Jan 2008 19:04:16 -0500
In-Reply-To: <4798FB68.70400@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Tejun Heo <htejun@gmail.com>

sata_mv Add missing qc_defer op.

This is necessary now that we support NCQ in the driver.

Signed-off-by: Mark Lord <mlord@pobox.com>
---
Who says a 14-patch series cannot have a 15th patch?  :)

--- old/drivers/ata/sata_mv.c	2008-01-24 18:55:12.000000000 -0500
+++ new/drivers/ata/sata_mv.c	2008-01-24 18:57:21.000000000 -0500
@@ -558,6 +558,7 @@
 	.post_internal_cmd	= mv_post_int_cmd,
 	.freeze			= mv_eh_freeze,
 	.thaw			= mv_eh_thaw,
+	.qc_defer		= ata_std_qc_defer,
 
 	.scr_read		= mv_scr_read,
 	.scr_write		= mv_scr_write,
@@ -586,6 +587,7 @@
 	.post_internal_cmd	= mv_post_int_cmd,
 	.freeze			= mv_eh_freeze,
 	.thaw			= mv_eh_thaw,
+	.qc_defer		= ata_std_qc_defer,
 
 	.scr_read		= mv_scr_read,
 	.scr_write		= mv_scr_write,
