From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_isapnp: set cable type
Date: Thu, 1 Mar 2007 17:45:22 +0000
Message-ID: <20070301174522.421784b3@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53655 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965362AbXCAQlO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Mar 2007 11:41:14 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2/drivers/ata/pata_isapnp.c linux-2.6.21-rc2/drivers/ata/pata_isapnp.c
--- linux.vanilla-2.6.21-rc2/drivers/ata/pata_isapnp.c	2007-03-01 13:36:03.000000000 +0000
+++ linux-2.6.21-rc2/drivers/ata/pata_isapnp.c	2007-03-01 14:54:55.327036376 +0000
@@ -49,6 +49,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
