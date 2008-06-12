From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/7] ide-pmac: remove bogus comment about pmac_ide_setup_device()
Date: Fri, 13 Jun 2008 01:12:43 +0200
Message-ID: <20080612231243.18335.14596.sendpatchset@localhost.localdomain>
References: <20080612231224.18335.91182.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:23855 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759708AbYFLXLB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jun 2008 19:11:01 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2634645fgg.17
        for <linux-ide@vger.kernel.org>; Thu, 12 Jun 2008 16:11:00 -0700 (PDT)
In-Reply-To: <20080612231224.18335.91182.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ppc/pmac.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -975,10 +975,7 @@ static const struct ide_port_info pmac_p
 
 /*
  * Setup, register & probe an IDE channel driven by this driver, this is
- * called by one of the 2 probe functions (macio or PCI). Note that a channel
- * that ends up beeing free of any device is not kept around by this driver
- * (it is kept in 2.4). This introduce an interface numbering change on some
- * rare machines unfortunately, but it's better this way.
+ * called by one of the 2 probe functions (macio or PCI).
  */
 static int __devinit
 pmac_ide_setup_device(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif, hw_regs_t *hw)
