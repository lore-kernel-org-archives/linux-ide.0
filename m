From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 3/7] sata_mv: chip initialization fixes
Date: Fri, 19 May 2006 16:29:21 -0400
Message-ID: <200605191629.21781.liml@rtr.ca>
References: <11480537082648-git-send-email-htejun@gmail.com> <446DEE92.50102@pobox.com> <200605191614.00023.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:51627 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964819AbWESU3X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 16:29:23 -0400
In-Reply-To: <200605191614.00023.liml@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

The interface control register of the 60xx (and later) Marvell chip
requires certain bits to always be set when writing to it.  These bits
incorrectly read-back as zeros, so the pattern must be ORed in
with each write of the register.  Also, bit 12 should NOT be set
(note that Marvell's own driver also had bit-12 wrong here).

While we're at it, we also now do pci_set_master() in the init code.

Signed-off-by: Mark Lord <liml@rtr.ca>

---
--- linux/drivers/scsi/sata_mv.c	2006-05-19 15:32:32.000000000 -0400
+++ linux/drivers/scsi/sata_mv.c	2006-05-19 15:39:27.000000000 -0400
@@ -1885,7 +1885,8 @@
 
 	if (IS_60XX(hpriv)) {
 		u32 ifctl = readl(port_mmio + SATA_INTERFACE_CTL);
-		ifctl |= (1 << 12) | (1 << 7);
+		ifctl |= (1 << 7);		/* enable gen2i speed */
+		ifctl = (ifctl & 0xfff) | 0x9b1000; /* from chip spec */
 		writelfl(ifctl, port_mmio + SATA_INTERFACE_CTL);
 	}
 
@@ -2252,7 +2253,8 @@
 			void __iomem *port_mmio = mv_port_base(mmio, port);
 
 			u32 ifctl = readl(port_mmio + SATA_INTERFACE_CTL);
-			ifctl |= (1 << 12);
+			ifctl |= (1 << 7);		/* enable gen2i speed */
+			ifctl = (ifctl & 0xfff) | 0x9b1000; /* from chip spec */
 			writelfl(ifctl, port_mmio + SATA_INTERFACE_CTL);
 		}
 
@@ -2353,6 +2355,7 @@
 	if (rc) {
 		return rc;
 	}
+	pci_set_master(pdev);
 
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc) {
