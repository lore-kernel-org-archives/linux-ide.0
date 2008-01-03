From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata-sff: PCI IRQ handling fix
Date: Thu, 3 Jan 2008 17:22:28 +0000
Message-ID: <20080103172228.0e091daf@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36576 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751527AbYACRYL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jan 2008 12:24:11 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

It is legitimate (although annoying and silly) for a PCI IDE controller
not to be assigned an interrupt and to be polled. The libata-sff code
should therefore not try and request IRQ 0 in this case.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc6-mm1/drivers/ata/libata-sff.c linux-2.6.24-rc6-mm1/drivers/ata/libata-sff.c
--- linux.vanilla-2.6.24-rc6-mm1/drivers/ata/libata-sff.c	2008-01-02 16:04:19.000000000 +0000
+++ linux-2.6.24-rc6-mm1/drivers/ata/libata-sff.c	2008-01-02 16:12:39.000000000 +0000
@@ -808,7 +808,10 @@
 	if (rc)
 		goto err_out;
 
-	if (!legacy_mode) {
+	if (!legacy_mode && pdev->irq) {
+		/* We may have no IRQ assigned in which case we can poll. This
+		   shouldn't happen on a sane system but robustness is cheap
+		   in this case */
 		rc = devm_request_irq(dev, pdev->irq, pi->port_ops->irq_handler,
 				      IRQF_SHARED, DRV_NAME, host);
 		if (rc)
@@ -816,7 +819,7 @@
 
 		ata_port_desc(host->ports[0], "irq %d", pdev->irq);
 		ata_port_desc(host->ports[1], "irq %d", pdev->irq);
-	} else {
+	} else if (legacy_mode) {
 		if (!ata_port_is_dummy(host->ports[0])) {
 			rc = devm_request_irq(dev, ATA_PRIMARY_IRQ(pdev),
 					      pi->port_ops->irq_handler,
 
