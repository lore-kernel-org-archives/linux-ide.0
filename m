From: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] ata: libahci: fix comment indentation
Date: Mon,  5 Feb 2018 13:50:36 +0200
Message-ID: <d047a8d1f9356e6139c61ce5f252b5747988093a.1517831436.git.baruch@tkos.co.il>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:33445 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750949AbeBELun (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 5 Feb 2018 06:50:43 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>

Indent the numbered item with one space like all other items in the same
list.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/ata/libahci_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 341d0ef82cbd..30cc8f1a31e1 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -340,7 +340,7 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
  * 2) regulator for controlling the targets power (optional)
  * 3) 0 - AHCI_MAX_CLKS clocks, as specified in the devs devicetree node,
  *    or for non devicetree enabled platforms a single clock
- *	4) phys (optional)
+ * 4) phys (optional)
  *
  * RETURNS:
  * The allocated ahci_host_priv on success, otherwise an ERR_PTR value
-- 
2.15.1

