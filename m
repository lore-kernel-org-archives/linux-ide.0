From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] sata_qstor: use hardreset instead of softreset
Date: Fri, 04 Jan 2008 00:22:19 +0900
Message-ID: <477CFDAB.3090705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:43983 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbYACPW2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jan 2008 10:22:28 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1167187nze.1
        for <linux-ide@vger.kernel.org>; Thu, 03 Jan 2008 07:22:26 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>

During conversion to new EH, sata_qstor was accidentaly changed to use
softreset, which is buggy on this chip, instead of hardreset.  This
patch updates sata_qstor such that it uses hardreset again.

This fixes bugzilla bug 9631.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <mlord@pobox.com>
---
 drivers/ata/sata_qstor.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 2f1de6e..c68b241 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -270,7 +270,7 @@ static int qs_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val)
 static void qs_error_handler(struct ata_port *ap)
 {
 	qs_enter_reg_mode(ap);
-	ata_do_eh(ap, qs_prereset, ata_std_softreset, NULL,
+	ata_do_eh(ap, qs_prereset, NULL, sata_std_hardreset,
 		  ata_std_postreset);
 }
 
