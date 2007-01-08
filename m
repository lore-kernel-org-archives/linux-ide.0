From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: add ICH7 on Acer 3682WLMi to laptop list
Date: Tue, 9 Jan 2007 02:26:30 +0900
Message-ID: <20070108172630.GI10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [221.139.199.108] ([221.139.199.108]:60772 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751598AbXAHR0c (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Jan 2007 12:26:32 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: J J <jakub007@go2.pl>

From: J J <jakub007@go2.pl>

In Acer Aspire hdd is connected to ICH7 via 40c cable, however it is
short cable and it is UDMA66 capable.

Signed-off-by: J J <jakub007@go2.pl>
Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 7959e4c..aadfcb3 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -569,6 +569,7 @@ struct ich_laptop {
 static const struct ich_laptop ich_laptop[] = {
 	/* devid, subvendor, subdev */
 	{ 0x27DF, 0x0005, 0x0280 },	/* ICH7 on Acer 5602WLMi */
+	{ 0x27DF, 0x1025, 0x0110 },	/* ICH7 on Acer 3682WLMi */
 	/* end marker */
 	{ 0, }
 };
