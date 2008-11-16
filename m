From: Qinghuang Feng <qhfeng.kernel@gmail.com>
Subject: [PATCH 2/7] drivers/ata/libata-core.c: cleanup kernel-doc
Date: Sun, 16 Nov 2008 17:43:51 +0800
Message-ID: <491feb61.06876e0a.1407.fffff256@mx.google.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f29.google.com ([209.85.217.29]:63598 "EHLO
	mail-gx0-f29.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbYKPJoE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Nov 2008 04:44:04 -0500
Received: by gxk10 with SMTP id 10so606455gxk.13
        for <linux-ide@vger.kernel.org>; Sun, 16 Nov 2008 01:44:03 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: qhfeng.kernel@gmail.com, Randy Dunlap <rdunlap@xenotime.net>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

No argument named @tag in ata_qc_new_init,
remove it.

Signed-off-by: Qinghuang Feng <qhfeng.kernel@gmail.com> 
---
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4214bfb..1e11c5d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4598,7 +4598,6 @@ static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
 /**
  *	ata_qc_new_init - Request an available ATA command, and initialize it
  *	@dev: Device from whom we request an available command structure
- *	@tag: command tag
  *
  *	LOCKING:
  *	None.

