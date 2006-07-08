From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/12] sata_sil24: rename PMP related constants
Date: Sat, 8 Jul 2006 14:58:08 +0900
Message-ID: <11523382883375-git-send-email-htejun@gmail.com>
References: <11523382873130-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:5493 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964818AbWGHF5Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:57:24 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1484773wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:57:24 -0700 (PDT)
In-Reply-To: <11523382873130-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Rename PMP related constants for consistency.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

08589377d5dfc16cda38f1d7cdeadf75057e0d5d
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 68a3fc1..958038a 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -100,10 +100,10 @@ enum {
 	 */
 	PORT_REGS_SIZE		= 0x2000,
 
-	PORT_LRAM		= 0x0000, /* 31 LRAM slots and PM regs */
+	PORT_LRAM		= 0x0000, /* 31 LRAM slots and PMP regs */
 	PORT_LRAM_SLOT_SZ	= 0x0080, /* 32 bytes PRB + 2 SGE, ACT... */
 
-	PORT_PM			= 0x0f80, /* 8 bytes PM * 16 (128 bytes) */
+	PORT_PMP		= 0x0f80, /* 8 bytes PMP * 16 (128 bytes) */
 		/* 32 bit regs */
 	PORT_CTRL_STAT		= 0x1000, /* write: ctrl-set, read: stat */
 	PORT_CTRL_CLR		= 0x1004, /* write: ctrl-clear */
@@ -139,9 +139,9 @@ enum {
 	PORT_CS_INIT		= (1 << 2), /* port initialize */
 	PORT_CS_IRQ_WOC		= (1 << 3), /* interrupt write one to clear */
 	PORT_CS_CDB16		= (1 << 5), /* 0=12b cdb, 1=16b cdb */
-	PORT_CS_RESUME		= (1 << 6), /* port resume */
+	PORT_CS_PMP_RESUME	= (1 << 6), /* PMP resume */
 	PORT_CS_32BIT_ACTV	= (1 << 10), /* 32-bit activation */
-	PORT_CS_PM_EN		= (1 << 13), /* port multiplier enable */
+	PORT_CS_PMP_EN		= (1 << 13), /* port multiplier enable */
 	PORT_CS_RDY		= (1 << 31), /* port ready to accept commands */
 
 	/* PORT_IRQ_STAT/ENABLE_SET/CLR */
@@ -562,7 +562,7 @@ static int sil24_softreset(struct ata_li
 
 	/* do SRST */
 	prb->ctrl = cpu_to_le16(PRB_CTRL_SRST);
-	prb->fis[1] = 0; /* no PM yet */
+	prb->fis[1] = 0; /* no PMP yet */
 
 	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
 	writel((u64)paddr >> 32, port + PORT_CMD_ACTIVATE + 4);
@@ -1051,7 +1051,8 @@ static void sil24_init_controller(struct
 		writel(PORT_CS_32BIT_ACTV, port + PORT_CTRL_CLR);
 
 		/* Clear port multiplier enable and resume bits */
-		writel(PORT_CS_PM_EN | PORT_CS_RESUME, port + PORT_CTRL_CLR);
+		writel(PORT_CS_PMP_EN | PORT_CS_PMP_RESUME,
+		       port + PORT_CTRL_CLR);
 	}
 
 	/* Turn on interrupts */
-- 
1.3.2


