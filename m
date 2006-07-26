From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/6] ahci: simplify ahci_start_engine()
Date: Wed, 26 Jul 2006 15:59:26 +0900
Message-ID: <11538971662256-git-send-email-htejun@gmail.com>
References: <11538971651205-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:62052 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030439AbWGZG7c (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Jul 2006 02:59:32 -0400
Received: by py-out-1112.google.com with SMTP id t32so3362771pyc
        for <linux-ide@vger.kernel.org>; Tue, 25 Jul 2006 23:59:31 -0700 (PDT)
In-Reply-To: <11538971651205-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, Zhao@htj.dyndns.org, Forrest <forrest.zhao@intel.com>

Simplify ahci_start_engine() by killing prerequisite condition checks.
Rationales are..

* No user checks error return from ahci_start_engine()

* Code flow guarantees the prerequisite conditions unless the
  controller is malfunctioning.  In such cases, the driver had chances
  to learn about the problem _before_ calling this function.

* Closely related to the above two, driver calls into this function
  even when prerequisites fail hoping for the best.

Basically, ahci_start_engine() should only do the operation itself.
It isn't the right place to check for prerequisites.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Signed-off-by: Zhao, Forrest <forrest.zhao@intel.com>

---

 drivers/scsi/ahci.c |   21 ++-------------------
 1 files changed, 2 insertions(+), 19 deletions(-)

e98289381268b565aadcda0e32e0bdd5fad5f9f4
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index ee00aed..e02b9c6 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -406,32 +406,15 @@ static void ahci_scr_write (struct ata_p
 	writel(val, (void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
-static int ahci_start_engine(void __iomem *port_mmio)
+static void ahci_start_engine(void __iomem *port_mmio)
 {
 	u32 tmp;
 
-	/* get current status */
-	tmp = readl(port_mmio + PORT_CMD);
-
-	/* AHCI rev 1.1 section 10.3.1:
-	 * Software shall not set PxCMD.ST to '1' until it verifies
-	 * that PxCMD.CR is '0' and has set PxCMD.FRE to '1'
-	 */
-	if ((tmp & PORT_CMD_FIS_RX) == 0)
-		return -EPERM;
-
-	/* wait for engine to become idle */
-	tmp = ata_wait_register(port_mmio + PORT_CMD,
-				PORT_CMD_LIST_ON, PORT_CMD_LIST_ON, 1,500);
-	if (tmp & PORT_CMD_LIST_ON)
-		return -EBUSY;
-
 	/* start DMA */
+	tmp = readl(port_mmio + PORT_CMD);
 	tmp |= PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
 	readl(port_mmio + PORT_CMD); /* flush */
-
-	return 0;
 }
 
 static int ahci_stop_engine(void __iomem *port_mmio)
-- 
1.3.2


