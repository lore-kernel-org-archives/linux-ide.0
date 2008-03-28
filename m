From: akpm@linux-foundation.org
Subject: [patch 1/3] git-libata: fix CONFIG_PCI=n build
Date: Fri, 28 Mar 2008 14:33:45 -0700
Message-ID: <200803282133.m2SLXj7h011457@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40817 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756723AbYC1Vdy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Mar 2008 17:33:54 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, htejun@gmail.com

From: Andrew Morton <akpm@linux-foundation.org>

sh allmodconfig:

drivers/ata/libata-core.c:127: error: `ata_pci_default_filter' undeclared here (not in a function)
drivers/ata/libata-core.c:127: error: initializer element is not constant
drivers/ata/libata-core.c:127: error: (near initialization for `ata_bmdma_port_ops.mode_filter')

Cc: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/ata/libata-core.c~git-libata-fix-config_pci=n-build drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c~git-libata-fix-config_pci=n-build
+++ a/drivers/ata/libata-core.c
@@ -123,9 +123,9 @@ const struct ata_port_operations ata_sff
 
 const struct ata_port_operations ata_bmdma_port_ops = {
 	.inherits		= &ata_sff_port_ops,
-
+#ifdef CONFIG_PCI
 	.mode_filter		= ata_pci_default_filter,
-
+#endif
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
_
