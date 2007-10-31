From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH 2.6.24-rc1] sata_promise: fix endianess bug in ASIC PRD bug workaround
Date: Wed, 31 Oct 2007 13:21:29 +0100 (MET)
Message-ID: <200710311221.l9VCLTiG008243@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:38655 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755308AbXJaMVo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Oct 2007 08:21:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Alexander Sabourenkov <screwdriver@lxnt.info>

The original workaround for the Promise ASIC PRD bug
contained an endianess bug which I failed to detect:
the adjustment of the last PRD entry's length field
applied host arithmetic to little-endian data, which
is incorrect on big-endian machines.

We have the length available in host-endian format, so
do the adjustment on host-endian data and then convert
and store it in the PRD entry's little-endian data field.

Thanks to an anonymous reviewer for detecting this bug.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
Jeff: please include this fix in any backport(s) of the
ASIC PRD bug workaround.

 drivers/ata/sata_promise.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -rupN linux-2.6.24-rc1/drivers/ata/sata_promise.c linux-2.6.24-rc1.sata_promise-endianess-fix/drivers/ata/sata_promise.c
--- linux-2.6.24-rc1/drivers/ata/sata_promise.c	2007-10-31 11:47:13.000000000 +0100
+++ linux-2.6.24-rc1.sata_promise-endianess-fix/drivers/ata/sata_promise.c	2007-10-31 11:47:25.000000000 +0100
@@ -585,7 +585,7 @@ static void pdc_fill_sg(struct ata_queue
 			VPRINTK("Splitting last PRD.\n");
 
 			addr = le32_to_cpu(ap->prd[idx - 1].addr);
-			ap->prd[idx - 1].flags_len -= cpu_to_le32(SG_COUNT_ASIC_BUG);
+			ap->prd[idx - 1].flags_len = cpu_to_le32(len - SG_COUNT_ASIC_BUG);
 			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx - 1, addr, SG_COUNT_ASIC_BUG);
 
 			addr = addr + len - SG_COUNT_ASIC_BUG;
