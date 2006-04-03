From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/14] libata: clean up AHCI constants in preparation for NCQ
Date: Mon, 3 Apr 2006 17:32:40 +0900
Message-ID: <11440531601152-git-send-email-htejun@gmail.com>
References: <1144053158183-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.224]:59876 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751655AbWDCIcx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Apr 2006 04:32:53 -0400
Received: by wproxy.gmail.com with SMTP id i22so1247732wra
        for <linux-ide@vger.kernel.org>; Mon, 03 Apr 2006 01:32:53 -0700 (PDT)
In-Reply-To: <1144053158183-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, axboe@suse.de, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

* Rename CMD_TBL_HDR to CMD_TBL_HDR_SZ as it's size not offset.

* Define MAX_CMDS and CMD_SZ and use them in calculation of other
  constants.

* Define CMD_TBL_AR_SZ as product of CMD_TBL_SZ and MAX_CMDS, and use
  it when calculating PRIV_DMA_SZ.

* CMD_SLOT_SZ is also dependent on MAX_CMDS but hasn't been changed
  because I didn't want to change the value used by the original code
  (32 commands).  Later NCQ change will bump MAX_CMDS to 32 anyway and
  the hard coded 32 can be changed to MAX_CMDS then.

* Reorder HOST_CAP_* flags.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

82ed365bb9a6628a1fbf1a2d3bba240dc5a88069
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 3dad10f..c01e58a 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -56,12 +56,15 @@ enum {
 	AHCI_MAX_SG		= 168, /* hardware max is 64K */
 	AHCI_DMA_BOUNDARY	= 0xffffffff,
 	AHCI_USE_CLUSTERING	= 0,
-	AHCI_CMD_SLOT_SZ	= 32 * 32,
+	AHCI_MAX_CMDS		= 1,
+	AHCI_CMD_SZ		= 32,
+	AHCI_CMD_SLOT_SZ	= 32 * AHCI_CMD_SZ,
 	AHCI_RX_FIS_SZ		= 256,
-	AHCI_CMD_TBL_HDR	= 0x80,
 	AHCI_CMD_TBL_CDB	= 0x40,
-	AHCI_CMD_TBL_SZ		= AHCI_CMD_TBL_HDR + (AHCI_MAX_SG * 16),
-	AHCI_PORT_PRIV_DMA_SZ	= AHCI_CMD_SLOT_SZ + AHCI_CMD_TBL_SZ +
+	AHCI_CMD_TBL_HDR_SZ	= 0x80,
+	AHCI_CMD_TBL_SZ		= AHCI_CMD_TBL_HDR_SZ + (AHCI_MAX_SG * 16),
+	AHCI_CMD_TBL_AR_SZ	= AHCI_CMD_TBL_SZ * AHCI_MAX_CMDS,
+	AHCI_PORT_PRIV_DMA_SZ	= AHCI_CMD_SLOT_SZ + AHCI_CMD_TBL_AR_SZ +
 				  AHCI_RX_FIS_SZ,
 	AHCI_IRQ_ON_SG		= (1 << 31),
 	AHCI_CMD_ATAPI		= (1 << 5),
@@ -88,8 +91,8 @@ enum {
 	HOST_AHCI_EN		= (1 << 31), /* AHCI enabled */
 
 	/* HOST_CAP bits */
-	HOST_CAP_64		= (1 << 31), /* PCI DAC (64-bit DMA) support */
 	HOST_CAP_CLO		= (1 << 24), /* Command List Override support */
+	HOST_CAP_64		= (1 << 31), /* PCI DAC (64-bit DMA) support */
 
 	/* registers for each SATA port */
 	PORT_LST_ADDR		= 0x00, /* command list DMA addr */
@@ -381,7 +384,7 @@ static int ahci_port_start(struct ata_po
 	pp->cmd_tbl = mem;
 	pp->cmd_tbl_dma = mem_dma;
 
-	pp->cmd_tbl_sg = mem + AHCI_CMD_TBL_HDR;
+	pp->cmd_tbl_sg = mem + AHCI_CMD_TBL_HDR_SZ;
 
 	ap->private_data = pp;
 
-- 
1.2.4


