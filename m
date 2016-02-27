From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] ata: ahci: don't mark HotPlugCapable Ports as external/removable
Date: Sat, 27 Feb 2016 16:10:05 +0100
Message-ID: <1456585805-897872-1-git-send-email-manuel.lauss@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33572 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756529AbcB0PKK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Feb 2016 10:10:10 -0500
Received: by mail-wm0-f41.google.com with SMTP id g62so105462353wme.0
        for <linux-ide@vger.kernel.org>; Sat, 27 Feb 2016 07:10:09 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux-IDE <linux-ide@vger.kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Laura Abbott <labbott@redhat.com>, Manuel Lauss <manuel.lauss@gmail.com>

The HPCP bit is set by bioses for on-board sata ports either because
they think sata is hotplug capable in general or to allow Windows
to display a "device eject" icon on ports which are routed to an
external connector bracket.

However in Redhat Bugzilla #1310682, users report that with kernel 4.4,
where this bit test first appeared, a lot of partitions on sata drives
are now mounted automatically.

This patch should fix redhat and a lot of other distros which
unconditionally automount all devices which have the "removable"
bit set.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 drivers/ata/libahci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 4029679..e029e3c 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1164,8 +1164,7 @@ static void ahci_port_init(struct device *dev, struct ata_port *ap,
 
 	/* mark esata ports */
 	tmp = readl(port_mmio + PORT_CMD);
-	if ((tmp & PORT_CMD_HPCP) ||
-	    ((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS)))
+	if ((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS))
 		ap->pflags |= ATA_PFLAG_EXTERNAL;
 }
 
-- 
2.7.2

