From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/15] ahci: use deadline instead of fixed timeout for 1st FIS for SRST
Date: Sun, 1 Jul 2007 19:54:16 +0900
Message-ID: <11832872562186-git-send-email-htejun@gmail.com>
References: <1183287253677-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:12292 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756917AbXGAKyZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:54:25 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1891691wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:54:24 -0700 (PDT)
In-Reply-To: <1183287253677-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Use deadline instead of fixed timeout for 1st FIS for SRST to improve
robustness of SRST.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 88cfac0..9af91ac 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -952,6 +952,7 @@ static int ahci_softreset(struct ata_link *link, unsigned int *class,
 	void __iomem *port_mmio = ahci_port_base(ap);
 	const u32 cmd_fis_len = 5; /* five dwords */
 	const char *reason = NULL;
+	unsigned long now, msecs;
 	struct ata_taskfile tf;
 	u32 tmp;
 	u8 *fis;
@@ -992,6 +993,11 @@ static int ahci_softreset(struct ata_link *link, unsigned int *class,
 	fis = pp->cmd_tbl;
 
 	/* issue the first D2H Register FIS */
+	msecs = 0;
+	now = jiffies;
+	if (time_after(now, deadline))
+		msecs = jiffies_to_msecs(deadline - now);
+
 	ahci_fill_cmd_slot(pp, 0,
 			   cmd_fis_len | AHCI_CMD_RESET | AHCI_CMD_CLR_BUSY);
 
@@ -1000,7 +1006,7 @@ static int ahci_softreset(struct ata_link *link, unsigned int *class,
 
 	writel(1, port_mmio + PORT_CMD_ISSUE);
 
-	tmp = ata_wait_register(port_mmio + PORT_CMD_ISSUE, 0x1, 0x1, 1, 500);
+	tmp = ata_wait_register(port_mmio + PORT_CMD_ISSUE, 0x1, 0x1, 1, msecs);
 	if (tmp & 0x1) {
 		rc = -EIO;
 		reason = "1st FIS failed";
-- 
1.5.0.3


