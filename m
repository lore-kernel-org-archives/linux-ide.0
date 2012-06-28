From: Mark Nelson <mdnelson8@gmail.com>
Subject: [PATCH 1/1] ahci: Enable SB600 64bit DMA on MSI K9AGM2 (MS-7327)
 v2
Date: Thu, 28 Jun 2012 12:32:14 +1000
Message-ID: <4FEBC22E.1060904@gmail.com>
References: <4FE92267.60106@gmail.com> <4FE9937B.7080503@mvista.com> <4FEAA8AE.8040807@gmail.com> <4FEAF1D5.9000505@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36198 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447Ab2F1CcU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jun 2012 22:32:20 -0400
Received: by dady13 with SMTP id y13so2226692dad.19
        for <linux-ide@vger.kernel.org>; Wed, 27 Jun 2012 19:32:20 -0700 (PDT)
In-Reply-To: <4FEAF1D5.9000505@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, tj@kernel.org

Like e65cc194f7628ecaa02462f22f42fb09b50dcd49 (ahci: Enable SB600 64bit
DMA on MSI K9A2 Platinum) and 3c4aa91f21f65b7b40bdfb015eacbcb8453ccae2
(ahci: Enable SB600 64bit DMA on Asus M3A), this patch enables 64bit DMA
for the AHCI SATA controller of another board that has the SB600
southbridge.

In this case though we're enabling 64bit DMA for another MSI motherboard,
the K9AGM2 or MS-7327. It is new enough that all of the BIOS releases
since the initial release (1.0 from 2007-02-09) work correctly with 64bit
DMA enabled.

Signed-off-by: Mark Nelson <mdnelson8@gmail.com>
---
v2 brings a more fleshed out commit message including the commit
summaries of the commits mentioned

  drivers/ata/ahci.c |   16 ++++++++++++++++
  1 file changed, 16 insertions(+)

Index: linux-2.6/drivers/ata/ahci.c
===================================================================
--- linux-2.6.orig/drivers/ata/ahci.c
+++ linux-2.6/drivers/ata/ahci.c
@@ -777,6 +777,22 @@ static bool ahci_sb600_enable_64bit(stru
  			},
  		},
  		/*
+		 * All BIOS versions for the MSI K9AGM2 (MS-7327) support
+		 * 64bit DMA.
+		 *
+		 * This board also had the typo mentioned above in the
+		 * Manufacturer DMI field (fixed in BIOS version 1.5), so
+		 * match on DMI_BOARD_VENDOR of "MICRO-STAR INTER" again.
+		 */
+		{
+			.ident = "MSI K9AGM2",
+			.matches = {
+				DMI_MATCH(DMI_BOARD_VENDOR,
+					  "MICRO-STAR INTER"),
+				DMI_MATCH(DMI_BOARD_NAME, "MS-7327"),
+			},
+		},
+		/*
  		 * All BIOS versions for the Asus M3A support 64bit DMA.
  		 * (all release versions from 0301 to 1206 were tested)
  		 */
