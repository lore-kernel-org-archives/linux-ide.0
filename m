From: "Jian Peng" <jipeng2005@gmail.com>
Subject: [PATCH 1/1] libata: ahci_start_engine compliant to AHCI spec
Date: Fri, 22 Apr 2011 23:58:10 -0700
Message-ID: <1303541890-14528-1-git-send-email-jipeng2005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mms2.broadcom.com ([216.31.210.18]:4611 "EHLO mms2.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033Ab1DWG62 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 23 Apr 2011 02:58:28 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jian Peng <jipeng2005@gmail.com>

At the end of section 10.1 of AHCI spec (rev 1.3), it states

Software shall not set PxCMD.ST to 1 until it is determined that
a functoinal device is present on the port as determined by
PxTFD.STS.BSY=0, PxTFD.STS.DRQ=0 and PxSSTS.DET=3h

Even though most AHCI host controller works without this check,
specific controller will fail under this condition.

Signed-off-by: Jian Peng <jipeng2005@gmail.com>
---
 drivers/ata/libahci.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 26d4523..83ed544 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -539,6 +539,27 @@ void ahci_start_engine(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 tmp;
+	u8 status;
+
+	status = readl(port_mmio + PORT_TFDATA) & 0xFF;
+
+	/*
+	 * At end of section 10.1 of AHCI spec (rev 1.3), it states
+	 * Software shall not set PxCMD.ST to 1 until it is determined
+	 * that a functoinal device is present on the port as determined by
+	 * PxTFD.STS.BSY=0, PxTFD.STS.DRQ=0 and PxSSTS.DET=3h
+	 *
+	 * Even though most AHCI host controllers work without this check,
+	 * specific controller will fail under this condition
+	 */
+	if (status & (ATA_BUSY | ATA_DRQ))
+		return;
+	else {
+		ahci_scr_read(&ap->link, SCR_STATUS, &tmp);
+
+		if ((tmp & 0xf) != 0x3)
+			return;
+	}
 
 	/* start DMA */
 	tmp = readl(port_mmio + PORT_CMD);
-- 
1.7.4.1


