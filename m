From: Shane Huang <shane.huang@amd.com>
Subject: [PATCH] Soften up the dmesg on SB600 PMP softreset failure recovery
Date: Wed, 5 Aug 2009 10:10:41 +0800
Message-ID: <1249438241.3583.5.camel@zm-desktop>
Reply-To: shane.huang@amd.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:32662 "EHLO
	TX2EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933171AbZHECK6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Aug 2009 22:10:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, tj@kernel.org, pgnet.dev@gmail.com, "Huang, Shane" <Shane.Huang@amd.com>

Too strong words led to spurious bug reports: Novell bugzilla #527748,
RedHat bugzilla #468800. This patch is used to soften up the dmesg on
SB600 PMP softreset failure recovery, so as to remove the scariness and
concern from community.

Reported-by: pgnet Dev <pgnet.dev@gmail.com>
Signed-off-by: Shane Huang <shane.huang@amd.com>
Cc: Tejun Heo <tj@kernel.org>

diff -ruN a/drivers/ata/ahci.c b/drivers/ata/ahci.c
--- a/drivers/ata/ahci.c	2009-07-29 14:38:39.000000000 +0800
+++ b/drivers/ata/ahci.c	2009-08-04 17:24:34.000000000 +0800
@@ -1769,7 +1769,8 @@
 		irq_sts = readl(port_mmio + PORT_IRQ_STAT);
 		if (irq_sts & PORT_IRQ_BAD_PMP) {
 			ata_link_printk(link, KERN_WARNING,
-					"failed due to HW bug, retry pmp=0\n");
+					"applying SB600 PMP SRST workaround "
+					"and retrying\n");
 			rc = ahci_do_softreset(link, class, 0, deadline,
 					       ahci_check_ready);
 		}


