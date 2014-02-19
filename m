From: Daeseok Youn <daeseok.youn@gmail.com>
Subject: [PATCH] ata: libahci: replace obselete simple_strtoul() with kstrtouint()
Date: Wed, 19 Feb 2014 15:18:49 +0900
Message-ID: <10174432.hzSAsi5PnJ@daeseok-laptop.cloud.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:52338 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbaBSGSy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Feb 2014 01:18:54 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net

>From a6ff4eec0b80ff6596a278623a02e3ed462c49ed Mon Sep 17 00:00:00 2001
From: Daeseok Youn <daeseok.youn@gmail.com>
Date: Wed, 19 Feb 2014 13:44:24 +0900
Subject: [PATCH] ata: libahci: replace obselete simple_strtoul() with
 kstrtouint()

Signed-off-by: Daeseok Youn <daeseok.youn@gmail.com>
---
 drivers/ata/libahci.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 36605ab..417946b 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1032,12 +1032,13 @@ static ssize_t ahci_led_show(struct ata_port *ap, char *buf)
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

