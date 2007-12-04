From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] sata_mv:  Warn about Highpoint RocketRAID BIOS treatment
 of "Legacy" drives
Date: Mon, 03 Dec 2007 19:20:16 -0500
Message-ID: <47549D40.8020301@rtr.ca>
References: <4751A2DA.6030403@rtr.ca>	<BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com>	<20071203154749.6lah7pulw8ow0s84@email.syntomax.com>	<47543C58.4040106@rtr.ca>	<475447A0.2010101@rtr.ca>	<47544B2F.5080007@pobox.com>	<47544BAA.1020901@rtr.ca>	<BD261180E6D35F4D9D32F3E44FD3D9010ADF35A5@EMPBEDEX.empirix.com>	<47544DA9.3070702@rtr.ca>	<47544E74.3000608@rtr.ca> <20071203184204.1a2d7e35@the-village.bc.nu> <47545503.2070006@rtr.ca> <475469C1.2080700@rtr.ca> <47549869.2040404@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3499 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944AbXLDAUR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Dec 2007 19:20:17 -0500
In-Reply-To: <47549869.2040404@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Morrison, Tom" <tmorrison@empirix.com>, hp@syntomax.com, IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

The Highpoint RocketRAID boards using Marvell 7042 chips
overwrite the 9th sector of attached drives at boot time,
when those drives are configured as "Legacy" (the default)
in the HighPoint BIOS.

This kills GRUB, and probably other stuff.
But it all happens *before* Linux is even loaded.

So, for now we'll log a WARNING when such boards are detected,
and advise users to configure BIOS "JBOD" volumes instead,
which don't appear to suffer from this problem.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

Patch is for 2.6.24.

--- old/drivers/ata/sata_mv.c	2007-12-03 15:29:43.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2007-12-03 19:15:23.000000000 -0500
@@ -2503,6 +2503,15 @@
 
 	case chip_7042:
 		hp_flags |= MV_HP_PCIE;
+		if (pdev->vendor == PCI_VENDOR_ID_TTI
+		 && (pdev->device == 0x2300 || pdev->device == 0x2310))
+		{
+			printk(KERN_WARNING "sata_mv: Highpoint RocketRAID BIOS"
+				" will corrupt attached drives when"
+				" configured as \"Legacy\".  BEWARE!\n");
+			printk(KERN_WARNING "sata_mv: Use BIOS \"JBOD\" volumes"
+				" instead for safety.\n");
+		}
 	case chip_6042:
 		hpriv->ops = &mv6xxx_ops;
 		hp_flags |= MV_HP_GEN_IIE;
