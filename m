From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: PATCH 2/2] at91_ide: turn on PIO 6 support
Date: Mon, 6 Apr 2009 23:42:11 -0400
Message-ID: <200904062342.11437.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:59217 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753691AbZDFW3T (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Apr 2009 18:29:19 -0400
Received: from r2aq169.net.upc.cz (stf_xl@wp.pl@[62.245.106.169])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
          for <linux-ide@vger.kernel.org>; 7 Apr 2009 00:28:59 +0200
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Steve Wootton <swootton@esi-estech.com>

As we have already PIO 6 transfer mode supported in IDE layer, we can turn
it on in the driver.

Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
Patch is against pata-2.6. Steve (CCed) tested on real hardware that PIO6
works with at91_ide .

 drivers/ide/at91_ide.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/at91_ide.c b/drivers/ide/at91_ide.c
index c48dc61..403d0e4 100644
--- a/drivers/ide/at91_ide.c
+++ b/drivers/ide/at91_ide.c
@@ -215,7 +215,7 @@ static const struct ide_port_info at91_ide_port_info __initdata = {
 	.tp_ops		= &at91_ide_tp_ops,
 	.host_flags 	= IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA | IDE_HFLAG_SINGLE |
 			  IDE_HFLAG_NO_IO_32BIT | IDE_HFLAG_UNMASK_IRQS,
-	.pio_mask 	= ATA_PIO5,
+	.pio_mask 	= ATA_PIO6,
 };
 
 /*
-- 
1.4.4.4
