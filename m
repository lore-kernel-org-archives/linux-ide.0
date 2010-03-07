From: Todd Merrill <turmlos@comcast.net>
Subject: [PATCH] ahci: Enable SB600 64bit DMA on Gateway SJM11-YK
Date: Sun, 07 Mar 2010 00:51:21 -0500
Message-ID: <1267941081.3382.16.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qmta08.westchester.pa.mail.comcast.net ([76.96.62.80]:50648
	"EHLO qmta08.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751177Ab0CGF5O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Mar 2010 00:57:14 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

ahci: Enable SB600 64bit DMA on Gateway SJM11-YK

The SJM11-YK motherboard, found in Gateway LT31 series netbooks, can
also support 64bit DMA. Tested with the earliest and latest known BIOS
versions.

Applies to kernel 2.6.33.

Signed-off-by: Todd Merrill <turmlos@comcast.net>

--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2758,6 +2758,19 @@ static bool ahci_sb600_enable_64bit(stru
 				DMI_MATCH(DMI_BOARD_NAME, "MS-7376"),
 			},
 		},
+		/*
+		 * The BIOS on the Gateway SJM11-YK, found in Gateway
+		 * LT31 series netbooks, supports 64bit DMA. Tested with
+		 * BIOS versions 1.3103 and 1.3302.
+		 */
+		{
+			.ident = "Gateway SJM11-YK",
+			.matches = {
+				DMI_MATCH(DMI_BOARD_VENDOR,
+					  "Gateway"),
+				DMI_MATCH(DMI_BOARD_NAME, "SJM11-YK"),
+			},
+		},
 		{ }
 	};
 	const struct dmi_system_id *match;


