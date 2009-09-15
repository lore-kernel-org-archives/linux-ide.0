From: Tejun Heo <htejun@gmail.com>
Subject: Re: Gigabyte GA-MA69VM-S2 can't do 64bit DMA
Date: Wed, 16 Sep 2009 04:09:33 +0900
Message-ID: <4AAFE66D.8050807@gmail.com>
References: <4AAE8252.8000206@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040404030600070806030806"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:38902 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758337AbZIOTJk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Sep 2009 15:09:40 -0400
Received: by fxm17 with SMTP id 17so1805012fxm.37
        for <linux-ide@vger.kernel.org>; Tue, 15 Sep 2009 12:09:43 -0700 (PDT)
In-Reply-To: <4AAE8252.8000206@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Holger Hasselmann <hhasselm@web.de>
Cc: linux-ide@vger.kernel.org, Shane.Huang@amd.com

This is a multi-part message in MIME format.
--------------040404030600070806030806
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Holger Hasselmann wrote:
> Hello Tejun,
> 
> I want let you know, that the following laptop would need to be included
> in the list of the 32bit DMA boards.
> 
> First I have used the snapshot 2.6.31-git and was not able to boot until
> I reversed the patch 58a09b38cfcd700b796ea07ae3d2e0efbb28b561.
> 
> I have tried it with the snapshot 2.6.31-git2 and was not able to boot.
> 
> I have checked the latest bios (1.10c) for this laptop and it did not
> worked.
> 
> I will attache the dmidecoder output (don't know if this helps).

Can you please verify the attached patch fixes the problem?  This should
apply cleanly to 2.6.31.

Thanks.

-- 
tejun

--------------040404030600070806030806
Content-Type: text/x-patch;
 name="amilo-pa-2510-32bit-only.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="amilo-pa-2510-32bit-only.patch"

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index d4cd9c2..95ac661 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2688,6 +2688,20 @@ static bool ahci_sb600_32bit_only(struct pci_dev *pdev)
 				DMI_MATCH(DMI_BOARD_NAME, "GA-MA69VM-S2"),
 			},
 		},
+		/*
+		 * This laptop can't do 64bit DMA either.  The latest
+		 * BIOS as of this writing (1.10c) doesn't fix the
+		 * problem either.
+		 *
+		 * http://thread.gmane.org/gmane.linux.ide/42716
+		 */
+		{
+			.ident = "Fujitsu-Siemens AMILO Pa 2510",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pa 2510"),
+			},
+		},
 		{ }
 	};
 	const struct dmi_system_id *match;

--------------040404030600070806030806--
