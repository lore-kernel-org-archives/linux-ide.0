From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: add short 40c quirk for Acer Aspire 2030, take
 #2
Date: Tue, 22 May 2007 11:34:22 +0200
Message-ID: <4652B91E.9000208@gmail.com>
References: <4651810A.8020809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.234]:44136 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983AbXEVJec (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 May 2007 05:34:32 -0400
Received: by wx-out-0506.google.com with SMTP id h29so174170wxd
        for <linux-ide@vger.kernel.org>; Tue, 22 May 2007 02:34:31 -0700 (PDT)
In-Reply-To: <4651810A.8020809@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: mail.pandor@gmail.com

Acer Aspire 2023WLMi uses short 40c cable.  Add quirk for it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Steve H. <mail.pandor@gmail.com>
---
Model name in comment was incorrect.  Updated.

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
+	{ 0x24CA, 0x1025, 0x0061 },	/* ICH4 on ACER Aspire 2023WLMi */
 	/* end marker */
 	{ 0, }
 };
