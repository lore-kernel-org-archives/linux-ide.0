From: Mark Lord <mlord@pobox.com>
Subject: Re: multiple sata_mv boards with same DevID ?
Date: Tue, 27 Jan 2009 11:54:47 -0500
Message-ID: <497F3C57.9000006@pobox.com>
References: <20080731213509.5C8573CF98@mail.pozicom.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040909030907000007090005"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbZA0Qyx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Jan 2009 11:54:53 -0500
In-Reply-To: <20080731213509.5C8573CF98@mail.pozicom.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: eric@pozicom.net
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------040909030907000007090005
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

eric wrote:
..
>>> We have the HighPoint 1740 SATAII RAID card.  I had to modify the 
>>> sata_mv.c
>>> (attached) to get it to work with my card.  The interesting bits are 
>>> as
>>> follows:
>>>
>>> /* RocketRAID 1740/174x have different identifiers */
>>>
>>> /* { PCI_VDEVICE(TTI, 0x1740), chip_508x }, */
>>>
>>> /* Pozicom: GenII 1740 cards use 88sx6042 chip */
>>>
>>> { PCI_VDEVICE(TTI, 0x1740), chip_6042 },
>>>
>>> { PCI_VDEVICE(TTI, 0x1742), chip_508x },
>>>
>>>  
>>> It appears the same card has different chip set depending upon when 
>>> you purchased your card.  Looking through the code, the GenI vs. GenII
> vs.
>>> GenIIe is done after the call to mv_pci_init_one thus passing a table 
>>> of values that are incorrect.  It would appear to make sense to solve 
>>> this by creating two or more tables and make mv_pci_tbl a 
>>> pci_device_id global
>>> * and
>>> reference it accordingly after the Rev. level was determined.
..

Eric,

I'm patching this (finally, sorry for the delay) for the 2.6.29 kernel.
Can you confirm that the attached patch works on your system there?
It should apply/work on any of 2.6.27, 2.6.28, 2.6.29-rc,
and possibly also on older kernels.

Thanks
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

--------------040909030907000007090005
Content-Type: text/x-diff;
 name="08_sata_mv_workaround_duplicate_pci_id_1740.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="08_sata_mv_workaround_duplicate_pci_id_1740.patch"

Apparently Highpoint has recycled the same PCI ID on two different
RocketRAID products.  PCI DEV_ID 1740 could have either a 5081 chip,
or a modern 6042 chip.  Yuck.  Deal with it.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-01-27 10:41:34.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-01-27 11:47:07.000000000 -0500
@@ -663,6 +663,13 @@
 	{ PCI_VDEVICE(MARVELL, 0x5081), chip_508x },
 	/* RocketRAID 1720/174x have different identifiers */
 	{ PCI_VDEVICE(TTI, 0x1720), chip_6042 },
+	/*
+	 * There appear to be *two* different Highpoint cards
+	 * which share the exact same "1740" PCI-ID (yuck).
+	 * PCI-Rev.2 is actually chip_6042, whereas
+	 * earlier PCI-Revs are chip_508x.
+	 * We'll distinguish those later on in the code.
+	 */
 	{ PCI_VDEVICE(TTI, 0x1740), chip_508x },
 	{ PCI_VDEVICE(TTI, 0x1742), chip_508x },
 
@@ -2903,7 +2910,7 @@
 	struct pci_dev *pdev = to_pci_dev(host->dev);
 	struct mv_host_priv *hpriv = host->private_data;
 	u32 hp_flags = hpriv->hp_flags;
-
+try_again:
 	switch (board_idx) {
 	case chip_5080:
 		hpriv->ops = &mv5xxx_ops;
@@ -2926,13 +2933,14 @@
 
 	case chip_504x:
 	case chip_508x:
-		hpriv->ops = &mv5xxx_ops;
-		hp_flags |= MV_HP_GEN_I;
-
 		switch (pdev->revision) {
 		case 0x0:
 			hp_flags |= MV_HP_ERRATA_50XXB0;
 			break;
+		case 0x2:
+			/* Highpoint RocketRAID 1740 Rev.2 uses a newer chip */
+			board_idx = chip_6042;
+			goto try_again;
 		case 0x3:
 			hp_flags |= MV_HP_ERRATA_50XXB2;
 			break;
@@ -2942,6 +2950,8 @@
 			hp_flags |= MV_HP_ERRATA_50XXB2;
 			break;
 		}
+		hpriv->ops = &mv5xxx_ops;
+		hp_flags |= MV_HP_GEN_I;
 		break;
 
 	case chip_604x:

--------------040909030907000007090005--
