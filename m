From: Daeseok Youn <daeseok.youn@gmail.com>
Subject: [PATCH] atm: libahci: replace obselete simple_strtoul() with kstrtouint()
Date: Wed, 19 Feb 2014 14:09:49 +0900
Message-ID: <1983660.RVkLooTtjT@daeseok-laptop.cloud.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:49203 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbaBSFJz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Feb 2014 00:09:55 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

>From 18bd7236f36a248a0871f810cec3c1e98f098a91 Mon Sep 17 00:00:00 2001
From: Daeseok Youn <daeseok.youn@gmail.com>
Date: Wed, 19 Feb 2014 13:44:24 +0900
Subject: [PATCH] atm: libahci: replace obselete simple_strtoul() with
 kstrtouint()

Signed-off-by: Daeseok Youn <daeseok.youn@gmail.com>
---
 drivers/ata/libahci.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 36605ab..417946b 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1032,12 +1032,13 @@ static ssize_t ahci_led_show(struct ata_port *ap, char 
*buf)
 static ssize_t ahci_led_store(struct ata_port *ap, const char *buf,
 				size_t size)
 {
-	int state;
+	unsigned int state;
 	int pmp;
 	struct ahci_port_priv *pp = ap->private_data;
 	struct ahci_em_priv *emp;
 
-	state = simple_strtoul(buf, NULL, 0);
+	if (kstrtouint(buf, 0, &state) < 0)
+		return -EINVAL;
 
 	/* get the slot number from the message */
 	pmp = (state & EM_MSG_LED_PMP_SLOT) >> 8;
-- 
1.7.9.5
---
