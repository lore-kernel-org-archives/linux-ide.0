From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 6/7] sata_mv: endian fix
Date: Fri, 19 May 2006 16:40:15 -0400
Message-ID: <200605191640.15139.liml@rtr.ca>
References: <11480537082648-git-send-email-htejun@gmail.com> <446DEE92.50102@pobox.com> <200605191614.00023.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:36586 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964816AbWESUkQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 16:40:16 -0400
In-Reply-To: <200605191614.00023.liml@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, tie-fei.zang@freescale.com

This fixes a byte-swap issue on PPC, found by Zang Roy-r61911
on the powerpc platform.  His original patch also had some other
platform-specific changes in #ifdef's, but I'm not sure yet how to
incorporate them.  Look for another patch for those (soon).

Signed-off-by: Mark Lord <liml@rtr.ca>

---
--- linux/drivers/scsi/sata_mv.c	2006-05-19 15:44:11.000000000 -0400
+++ linux/drivers/scsi/sata_mv.c	2006-05-19 15:58:21.000000000 -0400
@@ -1030,8 +1030,9 @@
 
 static inline void mv_crqb_pack_cmd(u16 *cmdw, u8 data, u8 addr, unsigned last)
 {
-	*cmdw = data | (addr << CRQB_CMD_ADDR_SHIFT) | CRQB_CMD_CS |
+	u16 tmp = data | (addr << CRQB_CMD_ADDR_SHIFT) | CRQB_CMD_CS |
 		(last ? CRQB_CMD_LAST : 0);
+	*cmdw = cpu_to_le16(tmp);
 }
 
 /**
