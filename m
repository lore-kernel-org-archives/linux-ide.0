From: Qinghuang Feng <qhfeng.kernel@gmail.com>
Subject: [PATCH 3/7] drivers/ata/pata_oldpiix.c: cleanup kernel-doc
Date: Sun, 16 Nov 2008 17:43:57 +0800
Message-ID: <491feb66.160d6e0a.586d.fffff912@mx.google.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f29.google.com ([209.85.217.29]:63598 "EHLO
	mail-gx0-f29.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbYKPJoJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Nov 2008 04:44:09 -0500
Received: by mail-gx0-f29.google.com with SMTP id 10so606455gxk.13
        for <linux-ide@vger.kernel.org>; Sun, 16 Nov 2008 01:44:08 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: qhfeng.kernel@gmail.com, Randy Dunlap <rdunlap@xenotime.net>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

No argument named @isich in oldpiix_set_dmamode,
remove it.

Signed-off-by: Qinghuang Feng <qhfeng.kernel@gmail.com>
---
diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index c0dbc46..2c1a91c 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -116,7 +116,6 @@ static void oldpiix_set_piomode (struct ata_port *ap, struct ata_device *adev)
  *	oldpiix_set_dmamode - Initialize host controller PATA DMA timings
  *	@ap: Port whose timings we are configuring
  *	@adev: Device to program
- *	@isich: True if the device is an ICH and has IOCFG registers
  *
  *	Set MWDMA mode for device, in host controller PCI config space.
  *

