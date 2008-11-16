From: Qinghuang Feng <qhfeng.kernel@gmail.com>
Subject: [PATCH 1/7] drivers/ata/pata_radisys.c: cleanup kernel-doc
Date: Sun, 16 Nov 2008 17:43:46 +0800
Message-ID: <491feb5b.08486e0a.075a.4c48@mx.google.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f29.google.com ([209.85.217.29]:46879 "EHLO
	mail-gx0-f29.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbYKPJn6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Nov 2008 04:43:58 -0500
Received: by gxk10 with SMTP id 10so606439gxk.13
        for <linux-ide@vger.kernel.org>; Sun, 16 Nov 2008 01:43:57 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: qhfeng.kernel@gmail.com, Randy Dunlap <rdunlap@xenotime.net>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

No argument named @isich in radisys_set_dmamode,
remove it.

Signed-off-by: Qinghuang Feng <qhfeng.kernel@gmail.com>
---
diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index 0b0aa45..695d44a 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -81,7 +81,6 @@ static void radisys_set_piomode (struct ata_port *ap, struct ata_device *adev)
  *	radisys_set_dmamode - Initialize host controller PATA DMA timings
  *	@ap: Port whose timings we are configuring
  *	@adev: Device to program
- *	@isich: True if the device is an ICH and has IOCFG registers
  *
  *	Set MWDMA mode for device, in host controller PCI config space.
  *

