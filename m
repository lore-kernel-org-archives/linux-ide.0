From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] ata: libahci: Make host flags unsigned long
Date: Fri,  1 Aug 2014 13:39:41 +0200
Message-ID: <1406893181-24764-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:49591 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbaHALjq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Aug 2014 07:39:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Commit 725c7b570fda (ata: libahci_platform: move port_map parameters
into the AHCI structure) moves flags into the struct ahci_host_priv's
.flags field, which causes compiler warnings on 64-bit builds when that
value is cast to a void * pointer. Rather than adding additional casting
to silence the warning, turn the flags field into a unsigned long.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/ata/ahci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 59ae0ee00149..e68532ca3826 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -317,7 +317,7 @@ struct ahci_port_priv {
 
 struct ahci_host_priv {
 	/* Input fields */
-	unsigned int		flags;		/* AHCI_HFLAG_* */
+	unsigned long		flags;		/* AHCI_HFLAG_* */
 	u32			force_port_map;	/* force port map */
 	u32			mask_port_map;	/* mask out particular bits */
 
-- 
2.0.3

