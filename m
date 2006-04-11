From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/15] sata_sil: add new constants in preparation for new interrupt handler
Date: Tue, 11 Apr 2006 23:14:08 +0900
Message-ID: <11447648483270-git-send-email-htejun@gmail.com>
References: <1144764846705-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.180]:7863 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751268AbWDKOOP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:14:15 -0400
Received: by pproxy.gmail.com with SMTP id i49so1396235pye
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:14:15 -0700 (PDT)
In-Reply-To: <1144764846705-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

sata_sil is about to get brand new interrupt handler.  Add relevant
constants.  While at it, add a new line for readability.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil.c |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

7e4271599752e0c0ba1742e98c26094502638a0e
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 3853c46..e46c044 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -54,6 +54,7 @@ enum {
 	 */
 	SIL_FLAG_RERR_ON_DMA_ACT = (1 << 29),
 	SIL_FLAG_MOD15WRITE	= (1 << 30),
+
 	SIL_DFL_HOST_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO,
 
@@ -84,6 +85,20 @@ enum {
 	/* BMDMA/BMDMA2 */
 	SIL_INTR_STEERING	= (1 << 1),
 
+	SIL_DMA_ENABLE		= (1 << 0),  /* DMA run switch */
+	SIL_DMA_RDWR		= (1 << 3),  /* DMA Rd-Wr */
+	SIL_DMA_SATA_IRQ	= (1 << 4),  /* OR of all SATA IRQs */
+	SIL_DMA_ACTIVE		= (1 << 16), /* DMA running */
+	SIL_DMA_ERROR		= (1 << 17), /* PCI bus error */
+	SIL_DMA_COMPLETE	= (1 << 18), /* cmd complete / IRQ pending */
+	SIL_DMA_N_SATA_IRQ	= (1 << 6),  /* SATA_IRQ for the next channel */
+	SIL_DMA_N_ACTIVE	= (1 << 24), /* ACTIVE for the next channel */
+	SIL_DMA_N_ERROR		= (1 << 25), /* ERROR for the next channel */
+	SIL_DMA_N_COMPLETE	= (1 << 26), /* COMPLETE for the next channel */
+
+	/* SIEN */
+	SIL_SIEN_N		= (1 << 16), /* triggered by SError.N */
+
 	/*
 	 * Others
 	 */
@@ -227,6 +242,7 @@ static const struct {
 	unsigned long tf;	/* ATA taskfile register block */
 	unsigned long ctl;	/* ATA control/altstatus register block */
 	unsigned long bmdma;	/* DMA register block */
+	unsigned long bmdma2;	/* DMA register block #2 */
 	unsigned long fifo_cfg;	/* FIFO Valid Byte Count and Control */
 	unsigned long scr;	/* SATA control register block */
 	unsigned long sien;	/* SATA Interrupt Enable register */
@@ -234,10 +250,10 @@ static const struct {
 	unsigned long sfis_cfg;	/* SATA FIS reception config register */
 } sil_port[] = {
 	/* port 0 ... */
-	{ 0x80, 0x8A, 0x00, 0x40, 0x100, 0x148, 0xb4, 0x14c },
-	{ 0xC0, 0xCA, 0x08, 0x44, 0x180, 0x1c8, 0xf4, 0x1cc },
-	{ 0x280, 0x28A, 0x200, 0x240, 0x300, 0x348, 0x2b4, 0x34c },
-	{ 0x2C0, 0x2CA, 0x208, 0x244, 0x380, 0x3c8, 0x2f4, 0x3cc },
+	{ 0x80, 0x8A, 0x00, 0x10, 0x40, 0x100, 0x148, 0xb4, 0x14c },
+	{ 0xC0, 0xCA, 0x08, 0x18, 0x44, 0x180, 0x1c8, 0xf4, 0x1cc },
+	{ 0x280, 0x28A, 0x200, 0x210, 0x240, 0x300, 0x348, 0x2b4, 0x34c },
+	{ 0x2C0, 0x2CA, 0x208, 0x218, 0x244, 0x380, 0x3c8, 0x2f4, 0x3cc },
 	/* ... port 3 */
 };
 
-- 
1.2.4


