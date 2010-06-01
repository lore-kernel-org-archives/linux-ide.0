From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] sata_nv: don't diddle with nIEN on mcp55
Date: Tue, 01 Jun 2010 17:29:21 +0200
Message-ID: <4C052751.3070403@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41941 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173Ab0FAQgo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Jun 2010 12:36:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, =?ISO-8859-1?Q?Cengiz_G=FCnay?= <cgunay@emory.edu>, stable@kernel.org

On mcp55, nIEN gets stuck once set and liteon blueray rom iHOS104-08
violates ATA specification and fails to set I on D2H Reg FIS if nIEN
is set when the command was issued.  When the other party is following
the spec, both devices can work fine but when the two flaws are put
together, they can't talk to each other.

mcp55 has its own IRQ masking mechanism and there's no reason to mess
with nIEN in the first place.  Fix it by dropping nIEN diddling from
nv_mcp55_freeze/thaw().

This was originally reported by Cengiz.  Although Cengiz hasn't
verified the fix yet, I could reproduce this problem and verfiy the
fix.  Even if Cengiz is experiencing different or additional problems,
this patch is needed.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Cengiz G=FCnay <cgunay@emory.edu>
Cc: stable@kernel.org
---
 drivers/ata/sata_nv.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 2a98b09..75482c9 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -1674,7 +1674,6 @@ static void nv_mcp55_freeze(struct ata_port *ap)
 	mask =3D readl(mmio_base + NV_INT_ENABLE_MCP55);
 	mask &=3D ~(NV_INT_ALL_MCP55 << shift);
 	writel(mask, mmio_base + NV_INT_ENABLE_MCP55);
-	ata_sff_freeze(ap);
 }

 static void nv_mcp55_thaw(struct ata_port *ap)
@@ -1688,7 +1687,6 @@ static void nv_mcp55_thaw(struct ata_port *ap)
 	mask =3D readl(mmio_base + NV_INT_ENABLE_MCP55);
 	mask |=3D (NV_INT_MASK_MCP55 << shift);
 	writel(mask, mmio_base + NV_INT_ENABLE_MCP55);
-	ata_sff_thaw(ap);
 }

 static void nv_adma_error_handler(struct ata_port *ap)
