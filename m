From: Harry Zhang <harry.zhang@amd.com>
Subject: libahci: Fix bug in storing EM messages
Date: Fri, 11 Jun 2010 15:44:12 +0800
Message-ID: <1276242252.14959.8.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:10842 "EHLO
	TX2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969Ab0FKHrh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jun 2010 03:47:37 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, tj@kernel.org, shane.huang@amd.com, Zhang@domain.invalid, Harry <Harry.Zhang@amd.com>

In function ahci_store_em_buffer(), if the input (signed char*) buffer
contains negative data, the constructed 32-bit long message data may
be wrong.

Signed-off-by: Harry Zhang <harry.zhang@amd.com>
---
 drivers/ata/libahci.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 1984a6e..09a9b51 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -324,7 +324,7 @@ static ssize_t ahci_store_em_buffer(struct device *dev,
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 	void __iomem *mmio = hpriv->mmio;
 	void __iomem *em_mmio = mmio + hpriv->em_loc;
-	u32 em_ctl, msg;
+	u32 em_ctl, *msg_buf = (u32 *)buf;
 	unsigned long flags;
 	int i;
 
@@ -342,11 +342,8 @@ static ssize_t ahci_store_em_buffer(struct device *dev,
 		return -EBUSY;
 	}
 
-	for (i = 0; i < size; i += 4) {
-		msg = buf[i] | buf[i + 1] << 8 |
-		      buf[i + 2] << 16 | buf[i + 3] << 24;
-		writel(msg, em_mmio + i);
-	}
+	for (i = 0; i < size; i += 4)
+		writel(msg_buf[i >> 2], em_mmio + i);
 
 	writel(em_ctl | EM_CTL_TM, mmio + HOST_EM_CTL);
 
-- 
1.6.4.2



