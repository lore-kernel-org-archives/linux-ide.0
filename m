From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/15] ahci: separate out ahci_exec_polled_cmd()
Date: Sun, 1 Jul 2007 19:54:16 +0900
Message-ID: <11832872563686-git-send-email-htejun@gmail.com>
References: <1183287253677-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:12448 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756849AbXGAKy3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:54:29 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1891721wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:54:29 -0700 (PDT)
In-Reply-To: <1183287253677-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Separate out ahci_exec_polled_cmd() from ahci_softreset().  This will
be used to implement ahci_pmp_read/write().  ahci_exec_polled_cmd()
performs reset_engine before returning if the command fails (times
out).  This is to improve robustness.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |   54 +++++++++++++++++++++++++++++++--------------------
 1 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 9d24dad..d25cee8 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -968,18 +968,43 @@ static int ahci_kick_engine(struct ata_port *ap, int force_restart)
 	return rc;
 }
 
+static int ahci_exec_polled_cmd(struct ata_port *ap, int pmp,
+				struct ata_taskfile *tf, int is_cmd, u16 flags,
+				unsigned long timeout_msec)
+{
+	const u32 cmd_fis_len = 5; /* five dwords */
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u8 *fis = pp->cmd_tbl;
+	u32 tmp;
+
+	/* prep the command */
+	ata_tf_to_fis(tf, pmp, is_cmd, fis);
+	ahci_fill_cmd_slot(pp, 0, cmd_fis_len | flags | (pmp << 12));
+
+	/* issue & wait */
+	writel(1, port_mmio + PORT_CMD_ISSUE);
+
+	if (timeout_msec) {
+		tmp = ata_wait_register(port_mmio + PORT_CMD_ISSUE, 0x1, 0x1,
+					1, timeout_msec);
+		if (tmp & 0x1) {
+			ahci_kick_engine(ap, 1);
+			return -EBUSY;
+		}
+	} else
+		readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
+
+	return 0;
+}
+
 static int ahci_softreset(struct ata_link *link, unsigned int *class,
 			  unsigned long deadline)
 {
 	struct ata_port *ap = link->ap;
-	struct ahci_port_priv *pp = ap->private_data;
-	void __iomem *port_mmio = ahci_port_base(ap);
-	const u32 cmd_fis_len = 5; /* five dwords */
 	const char *reason = NULL;
 	unsigned long now, msecs;
 	struct ata_taskfile tf;
-	u32 tmp;
-	u8 *fis;
 	int rc;
 
 	DPRINTK("ENTER\n");
@@ -997,7 +1022,6 @@ static int ahci_softreset(struct ata_link *link, unsigned int *class,
 				"failed to reset engine (errno=%d)", rc);
 
 	ata_tf_init(link->device, &tf);
-	fis = pp->cmd_tbl;
 
 	/* issue the first D2H Register FIS */
 	msecs = 0;
@@ -1005,16 +1029,9 @@ static int ahci_softreset(struct ata_link *link, unsigned int *class,
 	if (time_after(now, deadline))
 		msecs = jiffies_to_msecs(deadline - now);
 
-	ahci_fill_cmd_slot(pp, 0,
-			   cmd_fis_len | AHCI_CMD_RESET | AHCI_CMD_CLR_BUSY);
-
 	tf.ctl |= ATA_SRST;
-	ata_tf_to_fis(&tf, 0, 0, fis);
-
-	writel(1, port_mmio + PORT_CMD_ISSUE);
-
-	tmp = ata_wait_register(port_mmio + PORT_CMD_ISSUE, 0x1, 0x1, 1, msecs);
-	if (tmp & 0x1) {
+	if (ahci_exec_polled_cmd(ap, 0, &tf, 0,
+				 AHCI_CMD_RESET | AHCI_CMD_CLR_BUSY, msecs)) {
 		rc = -EIO;
 		reason = "1st FIS failed";
 		goto fail;
@@ -1024,13 +1041,8 @@ static int ahci_softreset(struct ata_link *link, unsigned int *class,
 	msleep(1);
 
 	/* issue the second D2H Register FIS */
-	ahci_fill_cmd_slot(pp, 0, cmd_fis_len);
-
 	tf.ctl &= ~ATA_SRST;
-	ata_tf_to_fis(&tf, 0, 0, fis);
-
-	writel(1, port_mmio + PORT_CMD_ISSUE);
-	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
+	ahci_exec_polled_cmd(ap, 0, &tf, 0, 0, 0);
 
 	/* spec mandates ">= 2ms" before checking status.
 	 * We wait 150ms, because that was the magic delay used for
-- 
1.5.0.3


