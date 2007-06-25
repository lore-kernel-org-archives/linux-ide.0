From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2.6.22-rc5] libata: kill non-sense warning message
Date: Mon, 25 Jun 2007 21:11:13 +0900
Message-ID: <467FB0E1.206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:7647 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbXFYMLV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jun 2007 08:11:21 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1781462wah
        for <linux-ide@vger.kernel.org>; Mon, 25 Jun 2007 05:11:17 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

prereset() is now allowed to set flag for unsupported reset method.
EH layer is responsible for selecting the fallback.  Remove non-sense
warning message.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index d807098..376f004 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1665,8 +1665,6 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 
 	/* did prereset() screw up?  if so, fix up to avoid oopsing */
 	if (!reset) {
-		ata_port_printk(ap, KERN_ERR, "BUG: prereset() requested "
-				"invalid reset type\n");
 		if (softreset)
 			reset = softreset;
 		else
