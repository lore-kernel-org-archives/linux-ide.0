From: Mark Nelson <mdnelson8@gmail.com>
Subject: [PATCH] ahci: Enable SB600 64bit DMA on MSI K9A2 Platinum
Date: Mon, 26 Oct 2009 16:03:09 +1100
Message-ID: <65a6ef750910252203s58af446fv268c857191e698d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f208.google.com ([209.85.219.208]:63601 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587AbZJZFDF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Oct 2009 01:03:05 -0400
Received: by ewy4 with SMTP id 4so3296202ewy.37
        for <linux-ide@vger.kernel.org>; Sun, 25 Oct 2009 22:03:09 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, jeff@garzik.org

Like the Asus M2A-VM, MSI's K9A2 Platinum (MS-7376) can also support 64bit
DMA. According to MSI tech support, 64bit DMA is known to work with BIOS
versions 1.7 and later.

Earlier BIOSs most likey work also, but we'll be safe here and just enable
64bit DMA on 1.7 and newer.

Signed-off-by: Mark Nelson <mdnelson8@gmail.com>
---
 drivers/ata/ahci.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

Index: upstream/drivers/ata/ahci.c
===================================================================
--- upstream.orig/drivers/ata/ahci.c
+++ upstream/drivers/ata/ahci.c
@@ -2718,6 +2718,20 @@ static bool ahci_sb600_enable_64bit(stru
 			},
 			.driver_data = "20071026",	/* yyyymmdd */
 		},
+		/*
+		 * BIOS version 1.7 and up are known to support 64bit DMA
+		 * 1.7 was released on 2009-01-13.
+		 * Enable 64bit DMA on 1.7 and anything newer.
+		 */
+		{
+			.ident = "MSI K9A2 Platinum",
+			.matches = {
+				DMI_MATCH(DMI_BOARD_VENDOR,
+					  "MICRO-STAR INTERNATIONAL CO.,LTD"),
+				DMI_MATCH(DMI_BOARD_NAME, "MS-7376"),
+			},
+			.driver_data = "20090113",	/* yyyymmdd */
+		},
 		{ }
 	};
 	const struct dmi_system_id *match;
