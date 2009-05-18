From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH] ata_piix: Add HP Compaq nc6000 to the broken poweroff list
Date: Tue, 19 May 2009 01:37:44 +0300
Message-ID: <1242686264-23173-1-git-send-email-syrjala@sci.fi>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp5.welho.com ([213.243.153.39]:40082 "EHLO smtp5.welho.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756001AbZERWhp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 May 2009 18:37:45 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, rjw@sisk.pl, Ville Syrjala <syrjala@sci.fi>

HP Compaq nc6000 suffers from the double disk spindown issue.
Add it to the broken poweroff DMI list.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---
 drivers/ata/ata_piix.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index d51a17c..1aeb708 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1455,6 +1455,15 @@ static bool piix_broken_system_poweroff(struct pci_dev *pdev)
 			/* PCI slot number of the controller */
 			.driver_data = (void *)0x1FUL,
 		},
+		{
+			.ident = "HP Compaq nc6000",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq nc6000"),
+			},
+			/* PCI slot number of the controller */
+			.driver_data = (void *)0x1FUL,
+		},
 
 		{ }	/* terminate list */
 	};
-- 
1.6.0.6

