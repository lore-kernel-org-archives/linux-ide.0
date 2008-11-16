From: Qinghuang Feng <qhfeng.kernel@gmail.com>
Subject: [PATCH 6/7] drivers/ata/pata_sis.c: cleanup kernel-doc
Date: Sun, 16 Nov 2008 17:44:13 +0800
Message-ID: <491feb76.04686e0a.739a.3151@mx.google.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f29.google.com ([209.85.217.29]:63598 "EHLO
	mail-gx0-f29.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853AbYKPJoZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Nov 2008 04:44:25 -0500
Received: by mail-gx0-f29.google.com with SMTP id 10so606455gxk.13
        for <linux-ide@vger.kernel.org>; Sun, 16 Nov 2008 01:44:25 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: qhfeng.kernel@gmail.com, Randy Dunlap <rdunlap@xenotime.net>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

No argument named @deadline in sis_66_cable_detect,
remove it.

Signed-off-by: Qinghuang Feng <qhfeng.kernel@gmail.com>
---
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index d342366..60a3f00 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -113,7 +113,6 @@ static int sis_133_cable_detect(struct ata_port *ap)
 /**
  *	sis_66_cable_detect	-	check for 40/80 pin
  *	@ap: Port
- *	@deadline: deadline jiffies for the operation
  *
  *	Perform cable detection on the UDMA66, UDMA100 and early UDMA133
  *	SiS IDE controllers.

