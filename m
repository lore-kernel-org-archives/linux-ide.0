From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] ata: sata_mv: fix mis-conversion in mv_write_cached_reg()
Date: Tue,  7 Jun 2016 17:49:09 +0100
Message-ID: <1465318149-21029-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 82-70-136-246.dsl.in-addr.zen.co.uk ([82.70.136.246]:36358 "EHLO
	rainbowdash.ducie.codethink.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1161164AbcFGQtP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Jun 2016 12:49:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@lists.codethink.co.uk
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Fix the signed issue in mv_write_cached_reg() where the laddr
is assigned from a (long)addr instead of (unsigned long)addr.

Fixes the following warnings:

drivers/ata/sata_mv.c:989:26: warning: cast removes address space of expression
drivers/ata/sata_mv.c:989:26: warning: cast removes address space of expression
drivers/ata/sata_mv.c:989:26: warning: cast removes address space of expression
drivers/ata/sata_mv.c:989:26: warning: cast removes address space of expression

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/ata/sata_mv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index bd74ee5..745489a 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -986,7 +986,7 @@ static inline void mv_write_cached_reg(void __iomem *addr, u32 *old, u32 new)
 		 * Looks like a lot of fuss, but it avoids an unnecessary
 		 * +1 usec read-after-write delay for unaffected registers.
 		 */
-		laddr = (long)addr & 0xffff;
+		laddr = (unsigned long)addr & 0xffff;
 		if (laddr >= 0x300 && laddr <= 0x33c) {
 			laddr &= 0x000f;
 			if (laddr == 0x4 || laddr == 0xc) {
-- 
2.8.1

