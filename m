From: Niels de Vos <ndevos@redhat.com>
Subject: [PATCH] pata_imx: expose module alias for loading from device-tree
Date: Mon, 29 Jul 2013 09:38:38 +0200
Message-ID: <1375083518-14899-1-git-send-email-ndevos@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:55787 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644Ab3G2Hio (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Jul 2013 03:38:44 -0400
Received: by mail-we0-f175.google.com with SMTP id q58so3551023wes.6
        for <linux-ide@vger.kernel.org>; Mon, 29 Jul 2013 00:38:43 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Niels de Vos <ndevos@redhat.com>, Sascha Hauer <s.hauer@pengutronix.de>

Enable auto loading by udev when pata_imx is compiled as a module.

Signed-off-by: Niels de Vos <ndevos@redhat.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/ata/pata_imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index 4ec7c04..26386f0 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -237,6 +237,7 @@ static const struct of_device_id imx_pata_dt_ids[] = {
 		/* sentinel */
 	}
 };
+MODULE_DEVICE_TABLE(of, imx_pata_dt_ids);
 
 static struct platform_driver pata_imx_driver = {
 	.probe		= pata_imx_probe,
-- 
1.7.11.7

