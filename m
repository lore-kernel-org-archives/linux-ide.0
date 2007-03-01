From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_winbond: set cable type
Date: Thu, 1 Mar 2007 17:57:05 +0000
Message-ID: <20070301175705.6f2a7902@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45869 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965381AbXCAQyh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Mar 2007 11:54:37 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2/drivers/ata/pata_winbond.c linux-2.6.21-rc2/drivers/ata/pata_winbond.c
--- linux.vanilla-2.6.21-rc2/drivers/ata/pata_winbond.c	2007-03-01 13:36:03.000000000 +0000
+++ linux-2.6.21-rc2/drivers/ata/pata_winbond.c	2007-03-01 15:16:12.697846496 +0000
@@ -152,6 +152,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
