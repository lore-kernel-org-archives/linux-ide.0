From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/21] ahci: use deadline instead of fixed timeout for 1st FIS for SRST
Date: Mon, 16 Jul 2007 14:29:38 +0900
Message-ID: <11845637781995-git-send-email-htejun@gmail.com>
References: <11845637782629-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:11862 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763539AbXGPF3o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 01:29:44 -0400
Received: by nz-out-0506.google.com with SMTP id s18so736630nze
        for <linux-ide@vger.kernel.org>; Sun, 15 Jul 2007 22:29:44 -0700 (PDT)
In-Reply-To: <11845637782629-git-send-email-htejun@gmail.com>
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
index 61c5b6e..0451600 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -976,6 +976,7 @@ static int ahci_softreset(struct ata_port *ap, unsigned int *class,
 	void __iomem *port_mmio = ahci_port_base(ap);
 	const u32 cmd_fis_len = 5; /* five dwords */
 	const char *reason = NULL;
+	unsigned long now, msecs;
 	struct ata_taskfile tf;
 	u32 tmp;
 	u8 *fis;
@@ -1016,6 +1017,11 @@ static int ahci_softreset(struct ata_port *ap, unsigned int *class,
 	fis = pp->cmd_tbl;
 
 	/* issue the first D2H Register FIS */
+	msecs = 0;
+	now = jiffies;
+	if (time_after(now, deadline))
+		msecs = jiffies_to_msecs(deadline - now);
+
 	ahci_fill_cmd_slot(pp, 0,
 			   cmd_fis_len | AHCI_CMD_RESET | AHCI_CMD_CLR_BUSY);
 
@@ -1024,7 +1030,7 @@ static int ahci_softreset(struct ata_port *ap, unsigned int *class,
 
 	writel(1, port_mmio + PORT_CMD_ISSUE);
 
-	tmp = ata_wait_register(port_mmio + PORT_CMD_ISSUE, 0x1, 0x1, 1, 500);
+	tmp = ata_wait_register(port_mmio + PORT_CMD_ISSUE, 0x1, 0x1, 1, msecs);
 	if (tmp & 0x1) {
 		rc = -EIO;
 		reason = "1st FIS failed";
-- 
1.5.0.3


