From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_hpt3x2n: add enablebits checking
Date: Fri, 27 Nov 2009 19:55:52 +0100
Message-ID: <200911271955.52643.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:62522 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbZK0S6O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Nov 2009 13:58:14 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>

There shouldn't be any problems with it as IDE hpt366 host driver
has been supporting enablebits checking for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_hpt3x2n.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: b/drivers/ata/pata_hpt3x2n.c
===================================================================
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -153,8 +153,17 @@ static int hpt3x2n_cable_detect(struct a
 
 static int hpt3x2n_pre_reset(struct ata_link *link, unsigned long deadline)
 {
+	static const struct pci_bits hpt37x_enable_bits[] = {
+		{ 0x50, 1, 0x04, 0x04 },
+		{ 0x54, 1, 0x04, 0x04 }
+	};
+
 	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+
+	if (!pci_test_config_bits(pdev, &hpt37x_enable_bits[ap->port_no]))
+		return -ENOENT;
+
 	/* Reset the state machine */
 	pci_write_config_byte(pdev, 0x50 + 4 * ap->port_no, 0x37);
 	udelay(100);
