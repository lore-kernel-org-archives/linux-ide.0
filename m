From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_ixp4xx_cf: Restore cable type method
Date: Thu, 8 Mar 2007 19:39:12 +0000
Message-ID: <20070308193912.4dc5be54@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59145 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932873AbXCHSfH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 13:35:07 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_ixp4xx_cf.c linux-2.6.21-rc3-mm2/drivers/ata/pata_ixp4xx_cf.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_ixp4xx_cf.c	2007-03-08 15:59:20.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_ixp4xx_cf.c	2007-03-08 16:46:35.000000000 +0000
@@ -129,6 +129,7 @@
 	.qc_issue	= ata_qc_issue_prot,
 	.eng_timeout	= ata_eng_timeout,
 	.data_xfer	= ixp4xx_mmio_data_xfer,
+	.cable_detect	= ata_cable_40wire,
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ixp4xx_irq_clear,
