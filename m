From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/6] sata_sil: convert sil_port[] to u16 from unsigned long
Date: Sun, 5 Mar 2006 16:03:52 +0900
Message-ID: <1141542232248-git-send-email-htejun@gmail.com>
References: <11415422323592-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.205]:38173 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752083AbWCEHEA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 02:04:00 -0500
Received: by zproxy.gmail.com with SMTP id 13so1009550nzn
        for <linux-ide@vger.kernel.org>; Sat, 04 Mar 2006 23:04:00 -0800 (PST)
In-Reply-To: <11415422323592-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

unsigned long is way too big for sil_port[] offsets (currently the
table is 256 bytes on 64bit machines).  Convert sil_port[] to u16.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

21111e9d5d332ba90051d6821ca7abf058ee5e99
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index f096cc9..fb86e36 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -202,18 +202,18 @@ static const struct ata_port_info sil_po
 /* per-port register offsets */
 /* TODO: we can probably calculate rather than use a table */
 static const struct {
-	unsigned long tf;	/* ATA taskfile register block */
-	unsigned long ctl;	/* ATA control/altstatus register block */
-	unsigned long bmdma;	/* DMA register block */
-	unsigned long fifo_cfg;	/* FIFO Valid Byte Count and Control */
-	unsigned long scr;	/* SATA control register block */
-	unsigned long sien;	/* SATA Interrupt Enable register */
-	unsigned long xfer_mode;/* data transfer mode register */
-	unsigned long sfis_cfg;	/* SATA FIS reception config register */
+	u16 tf;		/* ATA taskfile register block */
+	u16 ctl;	/* ATA control/altstatus register block */
+	u16 bmdma;	/* DMA register block */
+	u16 fifo_cfg;	/* FIFO Valid Byte Count and Control */
+	u16 scr;	/* SATA control register block */
+	u16 sien;	/* SATA Interrupt Enable register */
+	u16 xfer_mode;	/* data transfer mode register */
+	u16 sfis_cfg;	/* SATA FIS reception config register */
 } sil_port[] = {
 	/* port 0 ... */
-	{ 0x80, 0x8A, 0x00, 0x40, 0x100, 0x148, 0xb4, 0x14c },
-	{ 0xC0, 0xCA, 0x08, 0x44, 0x180, 0x1c8, 0xf4, 0x1cc },
+	{ 0x080, 0x08A, 0x000, 0x040, 0x100, 0x148, 0x0b4, 0x14c },
+	{ 0x0C0, 0x0CA, 0x008, 0x044, 0x180, 0x1c8, 0x0f4, 0x1cc },
 	{ 0x280, 0x28A, 0x200, 0x240, 0x300, 0x348, 0x2b4, 0x34c },
 	{ 0x2C0, 0x2CA, 0x208, 0x244, 0x380, 0x3c8, 0x2f4, 0x3cc },
 	/* ... port 3 */
-- 
1.2.1


