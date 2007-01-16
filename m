From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_via: add PCI ID 0x5337
Date: Tue, 16 Jan 2007 12:55:04 +0900
Message-ID: <20070116035504.GM10987@htj.dyndns.org>
References: <200701110943.50988.luca.pedrielli@barradev.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [221.139.199.108] ([221.139.199.108]:56480 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932203AbXAPDzM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Jan 2007 22:55:12 -0500
Content-Disposition: inline
In-Reply-To: <200701110943.50988.luca.pedrielli@barradev.it>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: luca pedrielli <luca.pedrielli@barradev.it>, linux-ide@vger.kernel.org

From: Luca Pedrielli <luca.pedrielli@barradev.it>

Add PCI ID 0x5337 to supported PCI ID.  This is VT8237 in IDE mode.

Signed-off-by: Luca Pedrielli <luca.pedrielli@barradev.it>
Signed-off-by: Tejun Heo <htejun@gmail.com>
---

Luca, I formatted the patch in the form Jeff can take.  Please format
patches like this next time.

This was verified by another bug reporter too.

diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 1f1d71e..4b24354 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -85,6 +85,7 @@ static void vt6421_set_dma_mode(struct ata_port *ap, struct ata_device *adev);
 static int vt6421_port_start(struct ata_port *ap);
 
 static const struct pci_device_id svia_pci_tbl[] = {
+	{ PCI_VDEVICE(VIA, 0x5337), vt6420 },
 	{ PCI_VDEVICE(VIA, 0x0591), vt6420 },
 	{ PCI_VDEVICE(VIA, 0x3149), vt6420 },
 	{ PCI_VDEVICE(VIA, 0x3249), vt6421 },
