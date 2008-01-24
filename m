From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 13/14] sata_mv No soft resets
Date: Thu, 24 Jan 2008 16:03:59 -0500
Message-ID: <4798FD3F.2050807@rtr.ca>
References: <4798FB68.70400@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4185 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756573AbYAXVEA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Jan 2008 16:04:00 -0500
In-Reply-To: <4798FB68.70400@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

sata_mv No soft resets.

Soft resets rarely have significant effect with these chips,
so always do a hard reset instead.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-01-24 14:49:28.000000000 -0500
+++ new/drivers/ata/sata_mv.c	2008-01-24 14:51:53.000000000 -0500
@@ -2414,8 +2414,7 @@
 
 static void mv_error_handler(struct ata_port *ap)
 {
-	ata_do_eh(ap, mv_prereset, ata_std_softreset,
-		  mv_hardreset, mv_postreset);
+	ata_do_eh(ap, mv_prereset, NULL, mv_hardreset, mv_postreset);
 }
 
 static void mv_post_int_cmd(struct ata_queued_cmd *qc)
