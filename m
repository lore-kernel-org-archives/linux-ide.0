From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] SATA: use NULL for ptrs
Date: Tue, 13 Feb 2007 16:11:41 -0800
Message-ID: <20070213161141.d5ac00fe.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:35889 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932101AbXBNATE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Feb 2007 19:19:04 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: jgarzik <jgarzik@pobox.com>, akpm <akpm@osdl.org>

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix sparse warnings in SATA:
drivers/ata/sata_sil.c:342:9: warning: Using plain integer as NULL pointer
drivers/ata/sata_mv.c:2056:55: warning: Using plain integer as NULL pointer

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/ata/sata_mv.c  |    2 +-
 drivers/ata/sata_sil.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.20-git9.orig/drivers/ata/sata_mv.c
+++ linux-2.6.20-git9/drivers/ata/sata_mv.c
@@ -2053,7 +2053,7 @@ static void mv_port_init(struct ata_iopo
 	port->altstatus_addr = port->ctl_addr = shd_base + SHD_CTL_AST_OFS;
 
 	/* unused: */
-	port->cmd_addr = port->bmdma_addr = port->scr_addr = 0;
+	port->cmd_addr = port->bmdma_addr = port->scr_addr = NULL;
 
 	/* Clear any currently outstanding port interrupt conditions */
 	serr_ofs = mv_scr_offset(SCR_ERROR);
--- linux-2.6.20-git9.orig/drivers/ata/sata_sil.c
+++ linux-2.6.20-git9/drivers/ata/sata_sil.c
@@ -339,7 +339,7 @@ static inline void __iomem *sil_scr_addr
 		break;
 	}
 
-	return 0;
+	return NULL;
 }
 
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg)
