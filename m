From: "Jian Peng" <jipeng2005@gmail.com>
Subject: [PATCH 1/1] libata: ahci_start_engine compliant to AHCI spec
Date: Tue, 19 Apr 2011 14:44:59 -0700
Message-ID: <1303249499-11557-1-git-send-email-jipeng2005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jian Peng <jipeng2005@gmail.com>
List-Id: linux-ide@vger.kernel.org

At the end of section 10.1 of AHCI spec (rev 1.3), it states

Software shall not set PxCMD.ST to 1 until it is determined that a
functoinal device is present on the port as determined by
PxTFD.STS.BSY=0, PxTFD.STS.DRQ=0 and PxSSTS.DET=3h

Even though most AHCI host controller works without this additional
check, specific controller will fail without this.

Signed-off-by: Jian Peng <jipeng2005@gmail.com>
---
 drivers/ata/libahci.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 26d4523..39e0698 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -539,6 +539,12 @@ void ahci_start_engine(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 tmp;
+	u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
+
+	if (status & (ATA_BUSY | ATA_DRQ) ||
+	    ahci_scr_read(&ap->link, SCR_STATUS, &tmp) ||
+	    (tmp & 0x0f) != 0x03)
+		return;
 
 	/* start DMA */
 	tmp = readl(port_mmio + PORT_CMD);
-- 
1.7.4.1
