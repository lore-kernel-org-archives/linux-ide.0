From: Mark Lord <liml@rtr.ca>
Subject: Re: Highpoint RocketRaid 1720 support in sata_mv
Date: Sun, 29 Jun 2008 04:45:06 -0400
Message-ID: <48674B92.3030801@rtr.ca>
References: <ae2e8fb00806281400l54d9378ey22b7a952a6315088@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1741 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752037AbYF2IpN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Jun 2008 04:45:13 -0400
In-Reply-To: <ae2e8fb00806281400l54d9378ey22b7a952a6315088@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Petr Jelen <petr.jelen@gmail.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: mlord@pobox.com, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

>Petr Jelen wrote:
> I have a simple patch for sata_mv.c, which adds support for Highpoint
> RocketRaid 1720 adapter (2 SATA2 ports on PCI bus).
> The adapter has Marvel 88SX6042-BCZ1 on board.
> 
> The patch is against 2.6.25.9 and I have tested it. I could normally
> work with my disks (in JBOD mode).
..

Looks simple enough.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

Jeff, can you push this one-liner (or equivalent) out for 2.6.26?
I don't have a dev tree with me on the road here,
so the line offsets probably differ.


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
--
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
