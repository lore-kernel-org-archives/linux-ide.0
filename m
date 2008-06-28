From: "Petr Jelen" <petr.jelen@gmail.com>
Subject: Highpoint RocketRaid 1720 support in sata_mv
Date: Sat, 28 Jun 2008 23:00:37 +0200
Message-ID: <ae2e8fb00806281400l54d9378ey22b7a952a6315088@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:22080 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbYF1VAi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Jun 2008 17:00:38 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1091996rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 28 Jun 2008 14:00:37 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mlord@pobox.com
Cc: linux-ide@vger.kernel.org

Hello,

I have a simple patch for sata_mv.c, which adds support for Highpoint
RocketRaid 1720 adapter (2 SATA2 ports on PCI bus).
The adapter has Marvel 88SX6042-BCZ1 on board.

The patch is against 2.6.25.9 and I have tested it. I could normally
work with my disks (in JBOD mode).
Could you please accept the patch?

diff -urN linux-2.6.25.9/drivers/ata/sata_mv.c
linux-2.6.25.9-new/drivers/ata/sata_mv.c
--- linux-2.6.25.9/drivers/ata/sata_mv.c        2008-06-24
23:09:06.000000000 +0200
+++ linux-2.6.25.9-new/drivers/ata/sata_mv.c    2008-06-28
22:36:22.000000000 +0200
@@ -695,7 +695,8 @@
        { PCI_VDEVICE(MARVELL, 0x5041), chip_504x },
        { PCI_VDEVICE(MARVELL, 0x5080), chip_5080 },
        { PCI_VDEVICE(MARVELL, 0x5081), chip_508x },
-       /* RocketRAID 1740/174x have different identifiers */
+       /* RocketRAID 1720/174x have different identifiers */
+       { PCI_VDEVICE(TTI, 0x1720), chip_6042 },
        { PCI_VDEVICE(TTI, 0x1740), chip_508x },
        { PCI_VDEVICE(TTI, 0x1742), chip_508x },


Best Regards,
Petr Jelen
