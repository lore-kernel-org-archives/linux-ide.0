From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_winbond
Date: Wed, 11 Apr 2007 00:14:09 +0100
Message-ID: <20070411001409.00469647@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:49233 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161044AbXDJXLE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Apr 2007 19:11:04 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

Not a PCI device so doesn't need PCI includes

Signed-off-by: Alan Cox <alan@redhat.com>

diff --git a/drivers/ata/pata_winbond.c b/drivers/ata/pata_winbond.c
index 5199432..434f14f 100644
--- a/drivers/ata/pata_winbond.c
+++ b/drivers/ata/pata_winbond.c
@@ -8,7 +8,6 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
