From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 1/2] ahci: Dont start port DMA engines unless a device is
 present
Date: Tue, 25 Mar 2008 15:28:07 -0700
Message-ID: <20080325152807.321a8338@appleyard>
References: <20080325221646.567639335@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46114 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755351AbYCYWcv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Mar 2008 18:32:51 -0400
In-Reply-To: <20080325221646.567639335@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, arjan@linux.intel.com, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

According to the AHCI spec, you should not set PxCMD.ST unless
a functional device is present, as determined by PxTFD.STS.BSY=0,
PxTFD.STS.DRQ=0, and PxSSTS.DET = 3.

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Index: linux-2.6.25-rc3/drivers/ata/ahci.c
===================================================================
--- linux-2.6.25-rc3.orig/drivers/ata/ahci.c
+++ linux-2.6.25-rc3/drivers/ata/ahci.c
@@ -783,11 +783,40 @@ static int ahci_scr_write(struct ata_por
 	return -EINVAL;
 }
 
+static int ahci_is_device_present(struct ata_port *ap)
+{
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u8 status;
+
+	/* Make sure PxTFD.STS.BSY and PxTFD.STS.DRQ are 0 */
+	status = ahci_check_status(ap);
+	if (status & (ATA_BUSY | ATA_DRQ))
+		return 0;
+
+	/* Make sure PxSSTS.DET is 3h */
+	status = readl(port_mmio + PORT_SCR_STAT);
+	status &= 0xf;
+	if ((status & 0xf) != 3)
+		return 0;
+	return 1;
+}
+
 static void ahci_start_engine(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 tmp;
 
+	/*
+	 * See AHCI specification 1.2 section 10.1.2
+	 *
+	 * Software shall not set PxCMD.ST to '1' until it is
+ 	 * determined that a functional device is present on
+ 	 * the port, as determined by PxTFD.STS.BSY = '0',
+ 	 * PxTFD.STS.DRQ = '0', PxSSTS.DET = 3h
+ 	 */
+	if (!ahci_is_device_present(ap))
+		return;
+
 	/* start DMA */
 	tmp = readl(port_mmio + PORT_CMD);
 	tmp |= PORT_CMD_START;

-- 
