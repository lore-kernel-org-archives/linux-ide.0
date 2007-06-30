From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: [PATCH 2.6.22-rc6+mboxjeff 2/3] pata_sis: new PCI ID
Date: Sat, 30 Jun 2007 03:58:11 +0200
Message-ID: <200706300358.12199.uwe.koziolek@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:39607 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752216AbXF3CNI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Jun 2007 22:13:08 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

The SiS966 has an alternate PCI-ID 1180 for an IDE compatible controller
The primaty channel acts as PATA-controller, the secondary channel
acts as SATA-controller in PATA-emulation.

Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>

--- a/drivers/ata/pata_sis.c	2007-06-30 02:52:06.000000000 +0200
+++ b/drivers/ata/pata_sis.c	2007-06-30 02:58:30.000000000 +0200
@@ -1016,6 +1016,7 @@
 static const struct pci_device_id sis_pci_tbl[] = {
 	{ PCI_VDEVICE(SI, 0x5513), },	/* SiS 5513 */
 	{ PCI_VDEVICE(SI, 0x5518), },	/* SiS 5518 */
+	{ PCI_VDEVICE(SI, 0x1180), },	/* SiS 1180 */
 
 	{ }
 };

