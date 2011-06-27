From: Mark Nelson <mdnelson8@gmail.com>
Subject: [PATCH 1/1] ahci: Enable SB600 64bit DMA on Asus M3A
Date: Mon, 27 Jun 2011 16:33:44 +1000
Message-ID: <BANLkTimMU+t4iFA=w-bbcCjAxTXtHn_n5A@mail.gmail.com>
References: <BANLkTimcLiba=7E4vp-_VyhNWM8_EGzTFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39168 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755319Ab1F0Gdp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jun 2011 02:33:45 -0400
Received: by vws1 with SMTP id 1so3092040vws.19
        for <linux-ide@vger.kernel.org>; Sun, 26 Jun 2011 23:33:44 -0700 (PDT)
In-Reply-To: <BANLkTimcLiba=7E4vp-_VyhNWM8_EGzTFg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

Like e65cc194f7628ecaa02462f22f42fb09b50dcd49 this patch enables 64bit DMA
for the AHCI SATA controller of a board that has the SB600 southbridge. In
this case though we're enabling 64bit DMA for the Asus M3A motherboard. It
is a new enough board that all of the BIOS releases since the initial
release (0301 from 2007-10-22) work correctly with 64bit DMA enabled.

Signed-off-by: Mark Nelson <mdnelson8@gmail.com>
---
 drivers/ata/ahci.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: linux-2.6/drivers/ata/ahci.c
===================================================================
--- linux-2.6.orig/drivers/ata/ahci.c
+++ linux-2.6/drivers/ata/ahci.c
@@ -811,6 +811,18 @@ static bool ahci_sb600_enable_64bit(stru
 				DMI_MATCH(DMI_BOARD_NAME, "MS-7376"),
 			},
 		},
+		/*
+		 * All BIOS versions for the Asus M3A support 64bit DMA.
+		 * (all release versions from 0301 to 1206 were tested)
+		 */
+		{
+			.ident = "ASUS M3A",
+			.matches = {
+				DMI_MATCH(DMI_BOARD_VENDOR,
+					  "ASUSTeK Computer INC."),
+				DMI_MATCH(DMI_BOARD_NAME, "M3A"),
+			},
+		},
 		{ }
 	};
 	const struct dmi_system_id *match;
