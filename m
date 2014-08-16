From: Arjun Sreedharan <arjun024@gmail.com>
Subject: [PATCH] ata: pata_samsung_cf: change ret type to signed
Date: Sat, 16 Aug 2014 18:38:34 +0530
Message-ID: <1408194514-2001-1-git-send-email-arjun024@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:41984 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbaHPNI4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Aug 2014 09:08:56 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Change return type to signed int since it could be
a negative errno.

Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
---
 drivers/ata/pata_samsung_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index fb52883..0c1c03a 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -361,7 +361,7 @@ static int pata_s3c_wait_after_reset(struct ata_link *link,
 /*
  * pata_s3c_bus_softreset - PATA device software reset
  */
-static unsigned int pata_s3c_bus_softreset(struct ata_port *ap,
+static int pata_s3c_bus_softreset(struct ata_port *ap,
 		unsigned long deadline)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
-- 
1.7.11.7

