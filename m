From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] ata: core: fix irq description on AHCI single irq systems
Date: Sun, 6 Dec 2015 21:56:33 +0100
Message-ID: <5664A101.1050401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35191 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384AbbLFU4k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Dec 2015 15:56:40 -0500
Received: by wmuu63 with SMTP id u63so118371831wmu.0
        for <linux-ide@vger.kernel.org>; Sun, 06 Dec 2015 12:56:39 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On my machine with single irq AHCI just the PCI id is printed as
description in /proc/interrupts.
I found a related discussion from beginning of this year:
http://www.gossamer-threads.com/lists/linux/kernel/2117335

Seems like commit commit 4f37b504768c952b64bc9469a2d579c7597590f2
tried to fix displaying a proper interrupt description for one
scenario but broke it for another one.

The mentioned discussion ended in the current situation being
considered as broken but w/o a patch to fix it.

The following patch is based on a proposal in this mail thread.
Now the interrupt is properly described as:
PCI-MSI 512000-edge      ahci[0000:00:1f.2]

By combining both values also the scenario that commit
4f37b504768c952b64bc9469a2d579c7597590f2 refers to should
still be fine. There it should look like this now:
ahci[20100000.ide]

Using managed memory allocation ensures that the irq description
lives at least as long as the interrupt.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/ata/libata-core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b79cb10..1004155 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6223,6 +6223,7 @@ int ata_host_activate(struct ata_host *host, int irq,
 		      struct scsi_host_template *sht)
 {
 	int i, rc;
+	char *irq_desc;
 
 	rc = ata_host_start(host);
 	if (rc)
@@ -6234,8 +6235,14 @@ int ata_host_activate(struct ata_host *host, int irq,
 		return ata_host_register(host, sht);
 	}
 
+	irq_desc = devm_kasprintf(host->dev, GFP_KERNEL, "%s[%s]",
+				  dev_driver_string(host->dev),
+				  dev_name(host->dev));
+	if (!irq_desc)
+		return -ENOMEM;
+
 	rc = devm_request_irq(host->dev, irq, irq_handler, irq_flags,
-			      dev_name(host->dev), host);
+			      irq_desc, host);
 	if (rc)
 		return rc;
 
-- 
2.6.3


