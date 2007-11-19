From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream] ahci: update PCS programming
Date: Mon, 19 Nov 2007 16:03:44 +0900
Message-ID: <20071119070344.GD30919@htj.mynetwork.cxm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:52375 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbXKSHDu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 02:03:50 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1342626rvb
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 23:03:50 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

For intel ones, ahci unconditionally OR'd 0xf to PCS.  This isn't
correct for the following cases.

* ich6/7m's which only implement P0 and P2 (0xf works fine tho)

* ich8/9's which have six ports and needs 0x3f to enable all ports

This patch updates PCS programming such that...

* port_map determined by ahci_save_initial_config() is OR'd instead of 0xf

* PCS is updated only if necessary (there are turned off enable bits)

port_map is determined from PORTS_IMPL PCI register which is
implemented as write or write-once register.  If the register isn't
programmed, ahci automatically generates it from number of ports,
which is good enough for PCS programming.  ICH6/7M are probably the
only ones where non-contiguous enable bits are necessary && PORTS_IMPL
isn't programmed properly but they're proven to work reliably with 0xf
anyway.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
As there hasn't been any report of brokeness due to this, I think this
change can wait and get tested till the next merge cycle.  The reason
why this doesn't really break anything (yet) is that BIOS programs PCS
correctly during boot and the value is preserved over suspend-to-ram,
which is interesting considering the default value for PCS is zero.
Maybe SMM code reprograms it while resuming?

 drivers/ata/ahci.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ed9b407..2c686b4 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1030,6 +1030,7 @@ static int ahci_deinit_port(struct ata_port *ap, const char **emsg)
 static int ahci_reset_controller(struct ata_host *host)
 {
 	struct pci_dev *pdev = to_pci_dev(host->dev);
+	struct ahci_host_priv *hpriv = host->private_data;
 	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];
 	u32 tmp;
 
@@ -1072,8 +1073,10 @@ static int ahci_reset_controller(struct ata_host *host)
 
 		/* configure PCS */
 		pci_read_config_word(pdev, 0x92, &tmp16);
-		tmp16 |= 0xf;
-		pci_write_config_word(pdev, 0x92, tmp16);
+		if ((tmp16 & hpriv->port_map) != hpriv->port_map) {
+			tmp16 |= hpriv->port_map;
+			pci_write_config_word(pdev, 0x92, tmp16);
+		}
 	}
 
 	return 0;
