From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: replace SKIP_D2H_BSY with HRST_TO_RESUME
Date: Thu, 28 Sep 2006 17:45:21 +0900
Message-ID: <20060928084521.GK25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:12010 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751794AbWI1Ip0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Sep 2006 04:45:26 -0400
Received: by py-out-1112.google.com with SMTP id n25so661742pyg
        for <linux-ide@vger.kernel.org>; Thu, 28 Sep 2006 01:45:26 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

ATA_FLAG_SKIP_D2H_BSY was added because some ahci controllers failed
to turn off !BSY after hotplug regardless of device state.  However,
some ahci controllers time out on softreset if it is issued while BSY
is set.  This can also be resolved by always doing CLO before SRST but
CLO is an optional feature.

This patch makes ahci use hardreset after link resume event including
hotplug.  Hardreset doesn't wait for !BSY, so the unnecessary timeout
is avoided and ahci now politely waits for !BSY on normal soft resets
(including boot and EH) thus avoiding SRST timeout caused by issuing
it while BSY is set.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---

Jeff, this should fix the 'first reset fails on slow ATAPI device if
delay during initialization is shortened' problem.  This makes much
more sense too as the only problemetic reset was post-hotplug SRST.

Thanks.

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 1aabc81..0b0619b 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -279,7 +279,7 @@ static const struct ata_port_info ahci_p
 		.sht		= &ahci_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_SKIP_D2H_BSY,
+				  ATA_FLAG_HRST_TO_RESUME,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
@@ -289,7 +289,7 @@ static const struct ata_port_info ahci_p
 		.sht		= &ahci_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_SKIP_D2H_BSY |
+				  ATA_FLAG_HRST_TO_RESUME |
 				  AHCI_FLAG_RESET_NEEDS_CLO | AHCI_FLAG_NO_NCQ,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
