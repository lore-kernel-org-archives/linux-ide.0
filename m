From: Qinghuang Feng <qhfeng.kernel@gmail.com>
Subject: [PATCH 5/7] drivers/ata/pata_legacy.c: cleanup kernel-doc
Date: Sun, 16 Nov 2008 17:44:08 +0800
Message-ID: <491feb71.044e6e0a.74c1.ffffeeab@mx.google.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f29.google.com ([209.85.217.29]:46879 "EHLO
	mail-gx0-f29.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676AbYKPJoU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Nov 2008 04:44:20 -0500
Received: by mail-gx0-f29.google.com with SMTP id 10so606439gxk.13
        for <linux-ide@vger.kernel.org>; Sun, 16 Nov 2008 01:44:19 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: qhfeng.kernel@gmail.com, Randy Dunlap <rdunlap@xenotime.net>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

No argument named @irq in qdi6580dp_set_piomode
remove it.

Signed-off-by: Qinghuang Feng <qhfeng.kernel@gmail.com>
---
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 930c220..cfb35a7 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -641,7 +641,6 @@ static void qdi6500_set_piomode(struct ata_port *ap, struct ata_device *adev)
  *	qdi6580dp_set_piomode		-	PIO setup for dual channel
  *	@ap: Port
  *	@adev: Device
- *	@irq: interrupt line
  *
  *	In dual channel mode the 6580 has one clock per channel and we have
  *	to software clockswitch in qc_issue.

