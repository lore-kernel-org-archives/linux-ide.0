From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/15] ahci: clean up AHCI constants in preparation for NCQ
Date: Tue, 11 Apr 2006 22:53:37 +0900
Message-ID: <11447636171154-git-send-email-htejun@gmail.com>
References: <1144763616819-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.194]:17886 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750982AbWDKNxo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:53:44 -0400
Received: by zproxy.gmail.com with SMTP id o37so1097580nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:53:44 -0700 (PDT)
In-Reply-To: <1144763616819-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
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

6493b186a1b012e7a8cc76467d06c6b3701ace3a
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index f3d117e..405d4da 100644
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


