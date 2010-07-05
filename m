From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH] libata: add ATA_CMD_DSM to ata_get_cmd_descript
Date: Mon, 5 Jul 2010 15:45:20 +0900
Message-ID: <20100705154454U.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:34888 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580Ab0GEGpm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Jul 2010 02:45:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, tj@kernel.org
Cc: linux-ide@vger.kernel.org

Why isn't ATA_CMD_DSM in ata_get_cmd_descript()?

=
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH] libata: add ATA_CMD_DSM to ata_get_cmd_descript

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 drivers/ata/libata-eh.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index f77a673..697474b 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2214,6 +2214,7 @@ const char *ata_get_cmd_descript(u8 command)
 		{ ATA_CMD_SMART,		"SMART" },
 		{ ATA_CMD_MEDIA_LOCK,		"DOOR LOCK" },
 		{ ATA_CMD_MEDIA_UNLOCK,		"DOOR UNLOCK" },
+		{ ATA_CMD_DSM,			"DATA SET MANAGEMENT" },
 		{ ATA_CMD_CHK_MED_CRD_TYP, 	"CHECK MEDIA CARD TYPE" },
 		{ ATA_CMD_CFA_REQ_EXT_ERR, 	"CFA REQUEST EXTENDED ERROR" },
 		{ ATA_CMD_CFA_WRITE_NE,		"CFA WRITE SECTORS WITHOUT ERASE" },
-- 
1.6.5

