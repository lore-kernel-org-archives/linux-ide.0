From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/21] ahci: separate out ahci_exec_polled_cmd()
Date: Mon, 16 Jul 2007 14:29:39 +0900
Message-ID: <11845637793463-git-send-email-htejun@gmail.com>
References: <11845637782629-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:11852 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761652AbXGPF3s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 01:29:48 -0400
Received: by nz-out-0506.google.com with SMTP id s18so736626nze
        for <linux-ide@vger.kernel.org>; Sun, 15 Jul 2007 22:29:47 -0700 (PDT)
In-Reply-To: <11845637782629-git-send-email-htejun@gmail.com>
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
index 1be238d..db65f4a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -993,17 +993,42 @@ static int ahci_kick_engine(struct ata_port *ap, int force_restart)
 	return rc;
 }
 
-static int ahci_softreset(struct ata_port *ap, unsigned int *class,
-			  unsigned long deadline)
+static int ahci_exec_polled_cmd(struct ata_port *ap, int pmp,
+				struct ata_taskfile *tf, int is_cmd, u16 flags,
+				unsigned long timeout_msec)
 {
+	const u32 cmd_fis_len = 5; /* five dwords */
 	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *port_mmio = ahci_port_base(ap);
-	const u32 cmd_fis_len = 5; /* five dwords */
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
+static int ahci_softreset(struct ata_port *ap, unsigned int *class,
+			  unsigned long deadline)
+{
 	const char *reason = NULL;
 	unsigned long now, msecs;
 	struct ata_taskfile tf;
-	u32 tmp;
-	u8 *fis;
 	int rc;
 
 	DPRINTK("ENTER\n");
@@ -1021,7 +1046,6 @@ static int ahci_softreset(struct ata_port *ap, unsigned int *class,
 				"failed to reset engine (errno=%d)", rc);
 
 	ata_tf_init(ap->device, &tf);
-	fis = pp->cmd_tbl;
 
 	/* issue the first D2H Register FIS */
 	msecs = 0;
@@ -1029,16 +1053,9 @@ static int ahci_softreset(struct ata_port *ap, unsigned int *class,
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
@@ -1048,13 +1065,8 @@ static int ahci_softreset(struct ata_port *ap, unsigned int *class,
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


