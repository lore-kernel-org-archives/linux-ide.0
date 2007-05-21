From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: add short 40c quirk for Acer Aspire 2030
Date: Mon, 21 May 2007 13:22:50 +0200
Message-ID: <4651810A.8020809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.225]:50680 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755705AbXEULXJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 07:23:09 -0400
Received: by nz-out-0506.google.com with SMTP id z3so278553nzf
        for <linux-ide@vger.kernel.org>; Mon, 21 May 2007 04:23:08 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: mail.pandor@gmail.com

Acer Aspire 2030 uses short 40c cable.  Add quirk for it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Steve H. <mail.pandor@gmail.com>
---
 ata_piix.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 13b6b1d..683057c 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -579,6 +579,7 @@ static const struct ich_laptop ich_lapto
 	{ 0x27DF, 0x0005, 0x0280 },	/* ICH7 on Acer 5602WLMi */
 	{ 0x27DF, 0x1025, 0x0110 },	/* ICH7 on Acer 3682WLMi */
 	{ 0x27DF, 0x1043, 0x1267 },	/* ICH7 on Asus W5F */
+	{ 0x24CA, 0x1025, 0x0061 },	/* ICH4 on ACER Aspire 2030 */
 	/* end marker */
 	{ 0, }
 };
