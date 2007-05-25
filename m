From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: [PATCH 2.6.22-rc2] libata: sata_sis fixes
Date: Fri, 25 May 2007 09:48:52 +0200
Message-ID: <200705250948.52588.uwe.koziolek@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:39945 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750916AbXEYHtZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 May 2007 03:49:25 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, htejun@gmail.com, alan@lxorguk.ukuu.org.uk
Cc: linux-ide@vger.kernel.org

The sata_sis driver supports SATA and PATA ports. The broken support
of both types in one controller is fixed.

the PATA-port of SiS180 controller does not support a drive present status
in the pci configspace like the other SiS PATA controllers, check skipped.

Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>

--- a/drivers/ata/sata_sis.c	2007-05-22 11:05:38.000000000 +0200
+++ b/drivers/ata/sata_sis.c	2007-05-23 00:24:28.000000000 +0200
@@ -255,7 +255,7 @@
 {
 	static int printed_version;
 	struct ata_port_info pi = sis_port_info;
-	const struct ata_port_info *ppi[] = { &pi, NULL };
+	const struct ata_port_info *ppi[] = { &pi, &pi };
 	struct ata_host *host;
 	u32 genctl, val;
 	u8 pmr;
--- a/drivers/ata/pata_sis.c	2007-05-22 11:05:38.000000000 +0200
+++ b/drivers/ata/pata_sis.c	2007-05-25 07:50:50.000000000 +0200
@@ -146,7 +146,8 @@
 
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
-	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no]))
+	if ((pdev->device != 0x0180) && (pdev->device != 0x0181) &&
+	    !pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no]))
 		return -ENOENT;
 
 	return ata_std_prereset(ap, deadline);

