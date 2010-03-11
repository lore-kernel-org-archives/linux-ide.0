From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [RFC] ata/core: don't enable the interrupt while activating the
 host
Date: Thu, 11 Mar 2010 23:04:17 +0100
Message-ID: <20100311220417.GA16022@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:48610 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758243Ab0CKWES (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Mar 2010 17:04:18 -0500
Received: id: bigeasy by Chamillionaire.breakpoint.cc with local
	(easymta 1.00 BETA 1)
	id 1NpqUL-0004B9-3W
	for linux-ide@vger.kernel.org; Thu, 11 Mar 2010 23:04:17 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I just migrated from ide_platform to pata_platform on my Swarm/Mips
board. This resulted in "nobody cared" during request_irq().
The only difference I noticed between ATA and IDE before registering the
interrupt handler is that IDE does not enable the interrupt.
After removing the flag it looks like the controller is working with the
ATA layer.

If I flip the polarity of the interrupt, I see the "nobody cared"
message shortly after seeing ata_sff_softreset() during boot. So I tried
to perform the software reset with ATA_SRST before requesting the
interrupt hoping that it makes interrupt go away. It did not so.

Does anyone have an idea what might go wrong here?

Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 drivers/ata/libata-core.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6728328..8484223 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6274,6 +6274,13 @@ int ata_host_activate(struct ata_host *host, int irq,
 		return ata_host_register(host, sht);
 	}
 
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap;
+
+		ap = host->ports[i];
+		iowrite8(ap->ctl & ~ATA_NIEN, ap->ioaddr.ctl_addr);
+	}
+
 	rc = devm_request_irq(host->dev, irq, irq_handler, irq_flags,
 			      dev_driver_string(host->dev), host);
 	if (rc)
-- 
1.6.6

