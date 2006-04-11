From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/5] ahci: use ata_wait_register()
Date: Tue, 11 Apr 2006 22:22:29 +0900
Message-ID: <11447617494183-git-send-email-htejun@gmail.com>
References: <11447617493149-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.226]:23934 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750825AbWDKNWd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:22:33 -0400
Received: by wproxy.gmail.com with SMTP id i11so921434wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:22:33 -0700 (PDT)
In-Reply-To: <11447617493149-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Replace ahci_poll_register() with ata_wait_register().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c |   31 ++++++-------------------------
 1 files changed, 6 insertions(+), 25 deletions(-)

6383eb44d8f1be3efa37aac4e3073deb1555bbb5
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 8f06375..241ed5d 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -517,24 +517,6 @@ static void ahci_fill_cmd_slot(struct ah
 	pp->cmd_slot[0].tbl_addr_hi = cpu_to_le32((pp->cmd_tbl_dma >> 16) >> 16);
 }
 
-static int ahci_poll_register(void __iomem *reg, u32 mask, u32 val,
-			      unsigned long interval_msec,
-			      unsigned long timeout_msec)
-{
-	unsigned long timeout;
-	u32 tmp;
-
-	timeout = jiffies + (timeout_msec * HZ) / 1000;
-	do {
-		tmp = readl(reg);
-		if ((tmp & mask) == val)
-			return 0;
-		msleep(interval_msec);
-	} while (time_before(jiffies, timeout));
-
-	return -1;
-}
-
 static int ahci_softreset(struct ata_port *ap, unsigned int *class)
 {
 	struct ahci_host_priv *hpriv = ap->host_set->private_data;
@@ -544,6 +526,7 @@ static int ahci_softreset(struct ata_por
 	const u32 cmd_fis_len = 5; /* five dwords */
 	const char *reason = NULL;
 	struct ata_taskfile tf;
+	u32 tmp;
 	u8 *fis;
 	int rc;
 
@@ -565,8 +548,6 @@ static int ahci_softreset(struct ata_por
 	/* check BUSY/DRQ, perform Command List Override if necessary */
 	ahci_tf_read(ap, &tf);
 	if (tf.command & (ATA_BUSY | ATA_DRQ)) {
-		u32 tmp;
-
 		if (!(hpriv->cap & HOST_CAP_CLO)) {
 			rc = -EIO;
 			reason = "port busy but no CLO";
@@ -576,10 +557,10 @@ static int ahci_softreset(struct ata_por
 		tmp = readl(port_mmio + PORT_CMD);
 		tmp |= PORT_CMD_CLO;
 		writel(tmp, port_mmio + PORT_CMD);
-		readl(port_mmio + PORT_CMD); /* flush */
 
-		if (ahci_poll_register(port_mmio + PORT_CMD, PORT_CMD_CLO, 0x0,
-				       1, 500)) {
+		tmp = ata_wait_register(port_mmio + PORT_CMD,
+					PORT_CMD_CLO, PORT_CMD_CLO, 1, 500);
+		if (tmp & PORT_CMD_CLO) {
 			rc = -EIO;
 			reason = "CLO failed";
 			goto fail_restart;
@@ -600,9 +581,9 @@ static int ahci_softreset(struct ata_por
 	fis[1] &= ~(1 << 7);	/* turn off Command FIS bit */
 
 	writel(1, port_mmio + PORT_CMD_ISSUE);
-	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
 
-	if (ahci_poll_register(port_mmio + PORT_CMD_ISSUE, 0x1, 0x0, 1, 500)) {
+	tmp = ata_wait_register(port_mmio + PORT_CMD_ISSUE, 0x1, 0x1, 1, 500);
+	if (tmp & 0x1) {
 		rc = -EIO;
 		reason = "1st FIS failed";
 		goto fail;
-- 
1.2.4


