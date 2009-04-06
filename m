From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 05/07] sata_mv: workaround errata SATA#26
Date: Mon, 06 Apr 2009 15:24:57 -0400
Message-ID: <49DA5709.7060005@rtr.ca>
References: <49DA2DFD.4010402@rtr.ca> <49DA2E33.4050704@rtr.ca> <49DA2E76.7000800@rtr.ca> <49DA566D.9040501@rtr.ca> <49DA56DE.3000200@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:33202 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753516AbZDFTY7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Apr 2009 15:24:59 -0400
In-Reply-To: <49DA56DE.3000200@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Saeed Bishara <saeed@marvell.com>

Workaround for errata SATA#26.

Prevents accidently putting a drive to sleep when attempting COMRESET,
by ORing 0xf000 with the values written to SCR_CONTROL.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-04-06 13:29:05.000000000 -0400
+++ new/drivers/ata/sata_mv.c	2009-04-06 14:20:53.000000000 -0400
@@ -1296,7 +1296,25 @@
 	unsigned int ofs = mv_scr_offset(sc_reg_in);
 
 	if (ofs != 0xffffffffU) {
-		writelfl(val, mv_ap_base(link->ap) + ofs);
+		void __iomem *addr = mv_ap_base(link->ap) + ofs;
+		if (sc_reg_in == SCR_CONTROL) {
+			/*
+			 * Workaround for 88SX60x1 FEr SATA#26:
+			 *
+			 * COMRESETs have to take care not to accidently
+			 * put the drive to sleep when writing SCR_CONTROL.
+			 * Setting bits 12..15 prevents this problem.
+			 *
+			 * So if we see an outbound COMMRESET, set those bits.
+			 * Ditto for the followup write that clears the reset.
+			 *
+			 * The proprietary driver does this for
+			 * all chip versions, and so do we.
+			 */
+			if ((val & 0xf) == 1 || (readl(addr) & 0xf) == 1)
+				val |= 0xf000;
+		}
+		writelfl(val, addr);
 		return 0;
 	} else
 		return -EINVAL;
