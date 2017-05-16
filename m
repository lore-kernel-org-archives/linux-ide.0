From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH] ata: libahci: properly propagate return value of platform_get_irq()
Date: Tue, 16 May 2017 14:06:12 +0200
Message-ID: <1494936372-27209-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:44663 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbdEPMGW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2017 08:06:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

When platform_get_irq() fails, it returns an error code, which
libahci_platform and replaces it by -EINVAL. This commit fixes that by
propagating the error code. It fixes the situation where
platform_get_irq() returns -EPROBE_DEFER because the interrupt
controller is not available yet, and generally looks like the right
thing to do.

We pay attention to not show the "no irq" message when we are in an
EPROBE_DEFER situation, because the driver probing will be retried
later on, once the interrupt controller becomes available to provide
the interrupt.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/ata/libahci_platform.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index aaa761b..cd2eab6 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -514,8 +514,9 @@ int ahci_platform_init_host(struct platform_device *pdev,
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(dev, "no irq\n");
-		return -EINVAL;
+		if (irq != -EPROBE_DEFER)
+			dev_err(dev, "no irq\n");
+		return irq;
 	}
 
 	hpriv->irq = irq;
-- 
2.7.4

