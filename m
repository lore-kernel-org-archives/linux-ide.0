From: Harry Zhang <harry.zhang@amd.com>
Subject: [PATCH #upstream-fixes] libahci: Fix bug in storing EM messages
Date: Thu, 24 Jun 2010 11:34:23 +0800
Message-ID: <1277350463.8158.3.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:56453
	"EHLO VA3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754116Ab0FXDee (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jun 2010 23:34:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, tj@kernel.org, shane.Huang@amd.com

In function ahci_store_em_buffer(), if the input (signed char*) buffer
contains negative data, the constructed 32-bit long message data may
be wrong.

Signed-off-by: Harry Zhang <harry.zhang@amd.com>
---
 drivers/ata/libahci.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 1984a6e..7b273f0 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -324,6 +324,7 @@ static ssize_t ahci_store_em_buffer(struct device *dev,
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 	void __iomem *mmio = hpriv->mmio;
 	void __iomem *em_mmio = mmio + hpriv->em_loc;
+	const unsigned char *msg_buf = buf;
 	u32 em_ctl, msg;
 	unsigned long flags;
 	int i;
@@ -343,8 +344,8 @@ static ssize_t ahci_store_em_buffer(struct device *dev,
 	}
 
 	for (i = 0; i < size; i += 4) {
-		msg = buf[i] | buf[i + 1] << 8 |
-		      buf[i + 2] << 16 | buf[i + 3] << 24;
+		msg = msg_buf[i] | msg_buf[i + 1] << 8 |
+		      msg_buf[i + 2] << 16 | msg_buf[i + 3] << 24;
 		writel(msg, em_mmio + i);
 	}
 
-- 
1.6.4.2



