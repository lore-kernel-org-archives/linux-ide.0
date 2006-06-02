From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH] Reduce the AHCI probe time
Date: Fri, 02 Jun 2006 16:04:12 +0800
Message-ID: <1149235452.13451.74.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:51552 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751310AbWFBIPw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jun 2006 04:15:52 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, htejun@gmail.com
Cc: linux-ide@vger.kernel.org

Hi, 

This patch can reduce the AHCI probe(thus bootup) time when there are
ports, which have no attached SATA drive.

In my development machine, only 1 of 4 ports has attached SATA disk. By
using this patch, I observed a reduced bootup time.

The patch is against libata #upstream
[ef2824073fba9def3cf122e89cc485f66dd71f70]

Thanks,
Forrest

Signed-off-by: Forrest Zhao <forrest.zhao@intel.com>

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 45fd71d..1c85606 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -1171,7 +1171,7 @@ static int ahci_host_init(struct ata_pro
 		while (j < 100) {
 			msleep(10);
 			tmp = readl(port_mmio + PORT_SCR_STAT);
-			if ((tmp & 0xf) == 0x3)
+			if ((tmp & 0xf) != 0x1)
 				break;
 			j++;
 		}
