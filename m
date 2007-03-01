From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_ixp4xx_cf - set cable type
Date: Thu, 1 Mar 2007 17:47:15 +0000
Message-ID: <20070301174715.78dd2686@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34876 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965359AbXCAQnO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Mar 2007 11:43:14 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2/drivers/ata/pata_ixp4xx_cf.c linux-2.6.21-rc2/drivers/ata/pata_ixp4xx_cf.c
--- linux.vanilla-2.6.21-rc2/drivers/ata/pata_ixp4xx_cf.c	2007-03-01 13:36:03.000000000 +0000
+++ linux-2.6.21-rc2/drivers/ata/pata_ixp4xx_cf.c	2007-03-01 14:56:13.873095560 +0000
@@ -129,6 +129,7 @@
 	.qc_issue	= ata_qc_issue_prot,
 	.eng_timeout	= ata_eng_timeout,
 	.data_xfer	= ixp4xx_mmio_data_xfer,
+	.cable_detect	= ata_cable_40wire,
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ixp4xx_irq_clear,
