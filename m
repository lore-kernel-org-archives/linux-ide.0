From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: Fwd: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne
 boards
Date: Wed, 07 Jan 2009 16:31:38 +0100
Message-ID: <20090107153138.140960@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:41673 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760002AbZAGPbo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Jan 2009 10:31:44 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: gerhard_pircher@gmx.net

The AmigaOne uses the onboard VIA IDE controller in legacy mode (like the
Pegasos).

Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
---
 drivers/ide/via82cxxx.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/via82cxxx.c b/drivers/ide/via82cxxx.c
index 2a812d3..086f476 100644
--- a/drivers/ide/via82cxxx.c
+++ b/drivers/ide/via82cxxx.c
@@ -450,6 +450,11 @@ static int __devinit via_init_one(struct pci_dev *dev, const struct pci_device_i
 		d.host_flags |= IDE_HFLAG_FORCE_LEGACY_IRQS;
 #endif
 
+#ifdef CONFIG_AMIGAONE
+	if (machine_is(amigaone))
+		d.host_flags |= IDE_HFLAG_FORCE_LEGACY_IRQS;
+#endif
+
 	d.udma_mask = via_config->udma_mask;
 
 	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
-- 
1.5.6.5
