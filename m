From: Xiaotian Feng <xtfeng@gmail.com>
Subject: [PATCH] AHCI: fix Null pointer dereference in achi_host_active()
Date: Wed, 17 Jul 2013 14:10:39 +0800
Message-ID: <1374041439-34122-1-git-send-email-xtfeng@gmail.com>
References: <51E53300.6010000@cogentembedded.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:45696 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341Ab3GQGKw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Jul 2013 02:10:52 -0400
In-Reply-To: <51E53300.6010000@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Xiaotian Feng <xtfeng@gmail.com>, Alexander Gordeev <agordeev@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

commit b29900e6 (AHCI: Make distinct names for ports in /proc/interrupts)
introuded a regression, which resulted Null pointer dereference for achi
host with dummy ports. For ahci ports, when the port is dummy port, its
private_data will be NULL, as ata_dummy_port_ops doesn't support ->port_start.

Reported-and-tested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Xiaotian Feng <xtfeng@gmail.com>
Cc: Alexander Gordeev <agordeev@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/ata/ahci.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 5064f3e..f1de689 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1147,10 +1147,16 @@ int ahci_host_activate(struct ata_host *host, int irq, unsigned int n_msis)
 
 	for (i = 0; i < host->n_ports; i++) {
 		struct ahci_port_priv *pp = host->ports[i]->private_data;
+		const char *desc;
 
+		if (ata_port_is_dummy(host->ports[i]))
+			desc = dev_driver_string(host->dev);
+		else
+			desc = pp->irq_desc;
+ 
 		rc = devm_request_threaded_irq(host->dev,
 			irq + i, ahci_hw_interrupt, ahci_thread_fn, IRQF_SHARED,
-			pp->irq_desc, host->ports[i]);
+			desc, host->ports[i]);
 		if (rc)
 			goto out_free_irqs;
 	}
-- 
1.7.9.6 (Apple Git-31.1)

