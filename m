From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/6] ahci: cosmetic changes to ahci_start/stop_engine()
Date: Wed, 26 Jul 2006 15:59:25 +0900
Message-ID: <11538971653784-git-send-email-htejun@gmail.com>
References: <11538971651205-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:62052 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030439AbWGZG7b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Jul 2006 02:59:31 -0400
Received: by py-out-1112.google.com with SMTP id t32so3362771pyc
        for <linux-ide@vger.kernel.org>; Tue, 25 Jul 2006 23:59:30 -0700 (PDT)
In-Reply-To: <11538971651205-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, Zhao@htj.dyndns.org, Forrest <forrest.zhao@intel.com>

* fascist-format comments according to comment style used in libata
  core layer.

* if() -> if ()

Signed-off-by: Tejun Heo <htejun@gmail.com>
Signed-off-by: Zhao, Forrest <forrest.zhao@intel.com>

---

 drivers/scsi/ahci.c |   27 +++++++++------------------
 1 files changed, 9 insertions(+), 18 deletions(-)

51d2cea03da874cd41cd7a29d1314ddbe46b5314
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 92e2b95..ee00aed 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -410,30 +410,23 @@ static int ahci_start_engine(void __iome
 {
 	u32 tmp;
 
-	/*
-	 * Get current status
-	 */
+	/* get current status */
 	tmp = readl(port_mmio + PORT_CMD);
 
-	/*
-	 * AHCI rev 1.1 section 10.3.1:
+	/* AHCI rev 1.1 section 10.3.1:
 	 * Software shall not set PxCMD.ST to '1' until it verifies
 	 * that PxCMD.CR is '0' and has set PxCMD.FRE to '1'
 	 */
 	if ((tmp & PORT_CMD_FIS_RX) == 0)
 		return -EPERM;
 
-	/*
-	 * wait for engine to become idle.
-	 */
+	/* wait for engine to become idle */
 	tmp = ata_wait_register(port_mmio + PORT_CMD,
 				PORT_CMD_LIST_ON, PORT_CMD_LIST_ON, 1,500);
-	if(tmp & PORT_CMD_LIST_ON)
+	if (tmp & PORT_CMD_LIST_ON)
 		return -EBUSY;
 
-	/*
-	 * Start DMA
-	 */
+	/* start DMA */
 	tmp |= PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
 	readl(port_mmio + PORT_CMD); /* flush */
@@ -447,20 +440,18 @@ static int ahci_stop_engine(void __iomem
 
 	tmp = readl(port_mmio + PORT_CMD);
 
-	/* Check if the HBA is idle */
+	/* check if the HBA is idle */
 	if ((tmp & (PORT_CMD_START | PORT_CMD_LIST_ON)) == 0)
 		return 0;
 
-	/* Setting HBA to idle */
+	/* setting HBA to idle */
 	tmp &= ~PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
 
-	/* wait for engine to stop. This could be
-	 * as long as 500 msec
-	 */
+	/* wait for engine to stop. This could be as long as 500 msec */
 	tmp = ata_wait_register(port_mmio + PORT_CMD,
 			        PORT_CMD_LIST_ON, PORT_CMD_LIST_ON, 1, 500);
-	if(tmp & PORT_CMD_LIST_ON)
+	if (tmp & PORT_CMD_LIST_ON)
 		return -EIO;
 
 	return 0;
-- 
1.3.2


