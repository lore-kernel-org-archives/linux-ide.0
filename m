From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/10] sata_inic162x: add / update constants
Date: Wed, 30 Apr 2008 16:35:09 +0900
Message-ID: <12095409181272-git-send-email-htejun@gmail.com>
References: <12095409172824-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:38540 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755475AbYD3HfZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Apr 2008 03:35:25 -0400
Received: by py-out-1112.google.com with SMTP id u52so616522pyb.10
        for <linux-ide@vger.kernel.org>; Wed, 30 Apr 2008 00:35:24 -0700 (PDT)
In-Reply-To: <12095409172824-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

* add a bunch of constants, most are from the datasheet, a few
  undocumented ones are from initio's modified driver

* HCTL_PWRDWN is bit 12 not 13

This is in preparation of further inic162x updates.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_inic162x.c |   59 ++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 1f5d17e..1b10455 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -35,6 +35,7 @@ enum {
 
 	NR_PORTS		= 2,
 
+	HOST_ACTRL		= 0x08,
 	HOST_CTL		= 0x7c,
 	HOST_STAT		= 0x7e,
 	HOST_IRQ_STAT		= 0xbc,
@@ -43,22 +44,37 @@ enum {
 	PORT_SIZE		= 0x40,
 
 	/* registers for ATA TF operation */
-	PORT_TF			= 0x00,
-	PORT_ALT_STAT		= 0x08,
+	PORT_TF_DATA		= 0x00,
+	PORT_TF_FEATURE		= 0x01,
+	PORT_TF_NSECT		= 0x02,
+	PORT_TF_LBAL		= 0x03,
+	PORT_TF_LBAM		= 0x04,
+	PORT_TF_LBAH		= 0x05,
+	PORT_TF_DEVICE		= 0x06,
+	PORT_TF_COMMAND		= 0x07,
+	PORT_TF_ALT_STAT	= 0x08,
 	PORT_IRQ_STAT		= 0x09,
 	PORT_IRQ_MASK		= 0x0a,
 	PORT_PRD_CTL		= 0x0b,
 	PORT_PRD_ADDR		= 0x0c,
 	PORT_PRD_XFERLEN	= 0x10,
+	PORT_CPB_CPBLAR		= 0x18,
+	PORT_CPB_PTQFIFO	= 0x1c,
 
 	/* IDMA register */
 	PORT_IDMA_CTL		= 0x14,
+	PORT_IDMA_STAT		= 0x16,
+
+	PORT_RPQ_FIFO		= 0x1e,
+	PORT_RPQ_CNT		= 0x1f,
 
 	PORT_SCR		= 0x20,
 
 	/* HOST_CTL bits */
 	HCTL_IRQOFF		= (1 << 8),  /* global IRQ off */
-	HCTL_PWRDWN		= (1 << 13), /* power down PHYs */
+	HCTL_FTHD0		= (1 << 10), /* fifo threshold 0 */
+	HCTL_FTHD1		= (1 << 11), /* fifo threshold 1*/
+	HCTL_PWRDWN		= (1 << 12), /* power down PHYs */
 	HCTL_SOFTRST		= (1 << 13), /* global reset (no phy reset) */
 	HCTL_RPGSEL		= (1 << 15), /* register page select */
 
@@ -96,6 +112,43 @@ enum {
 	IDMA_CTL_RST_IDMA	= (1 << 5),  /* reset IDMA machinary */
 	IDMA_CTL_GO		= (1 << 7),  /* IDMA mode go */
 	IDMA_CTL_ATA_NIEN	= (1 << 8),  /* ATA IRQ disable */
+
+	/* PORT_IDMA_STAT bits */
+	IDMA_STAT_PERR		= (1 << 0),  /* PCI ERROR MODE */
+	IDMA_STAT_CPBERR	= (1 << 1),  /* ADMA CPB error */
+	IDMA_STAT_LGCY		= (1 << 3),  /* ADMA legacy */
+	IDMA_STAT_UIRQ		= (1 << 4),  /* ADMA unsolicited irq */
+	IDMA_STAT_STPD		= (1 << 5),  /* ADMA stopped */
+	IDMA_STAT_PSD		= (1 << 6),  /* ADMA pause */
+	IDMA_STAT_DONE		= (1 << 7),  /* ADMA done */
+
+	IDMA_STAT_ERR		= IDMA_STAT_PERR | IDMA_STAT_CPBERR,
+
+	/* CPB Control Flags*/
+	CPB_CTL_VALID		= (1 << 0),  /* CPB valid */
+	CPB_CTL_QUEUED		= (1 << 1),  /* queued command */
+	CPB_CTL_DATA		= (1 << 2),  /* data, rsvd in datasheet */
+	CPB_CTL_IEN		= (1 << 3),  /* PCI interrupt enable */
+	CPB_CTL_DEVDIR		= (1 << 4),  /* device direction control */
+
+	/* CPB Response Flags */
+	CPB_RESP_DONE		= (1 << 0),  /* ATA command complete */
+	CPB_RESP_REL		= (1 << 1),  /* ATA release */
+	CPB_RESP_IGNORED	= (1 << 2),  /* CPB ignored */
+	CPB_RESP_ATA_ERR	= (1 << 3),  /* ATA command error */
+	CPB_RESP_SPURIOUS	= (1 << 4),  /* ATA spurious interrupt error */
+	CPB_RESP_UNDERFLOW	= (1 << 5),  /* APRD deficiency length error */
+	CPB_RESP_OVERFLOW	= (1 << 6),  /* APRD exccess length error */
+	CPB_RESP_CPB_ERR	= (1 << 7),  /* CPB error flag */
+
+	/* PRD Control Flags */
+	PRD_DRAIN		= (1 << 1),  /* ignore data excess */
+	PRD_CDB			= (1 << 2),  /* atapi packet command pointer */
+	PRD_DIRECT_INTR		= (1 << 3),  /* direct interrupt */
+	PRD_DMA			= (1 << 4),  /* data transfer method */
+	PRD_WRITE		= (1 << 5),  /* data dir, rsvd in datasheet */
+	PRD_IOM			= (1 << 6),  /* io/memory transfer */
+	PRD_END			= (1 << 7),  /* APRD chain end */
 };
 
 struct inic_host_priv {
-- 
1.5.2.4

