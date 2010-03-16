From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] ahci: use BIOS date in broken_suspend list
Date: Tue, 16 Mar 2010 09:50:26 +0900
Message-ID: <4B9ED5D2.2030805@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54206 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937253Ab0CPAuk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Mar 2010 20:50:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, stable@kernel.org
Cc: tigerfishdaisy@gmail.com

HP is recycling both DMI_PRODUCT_NAME and DMI_BIOS_VERSION making
ahci_broken_suspend() trigger for later products which are not
affected by the original problems.  Match BIOS date instead of version
and add references to bko's so that full information can be found
easier later.

This fixes http://bugzilla.kernel.org/show_bug.cgi?id=15462

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: tigerfishdaisy@gmail.com
---
 drivers/ata/ahci.c |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 6bd930b..9e122ea 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -3022,6 +3022,14 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
 		 * On HP dv[4-6] and HDX18 with earlier BIOSen, link
 		 * to the harddisk doesn't become online after
 		 * resuming from STR.  Warn and fail suspend.
+		 *
+		 * http://bugzilla.kernel.org/show_bug.cgi?id=12276
+		 *
+		 * Use dates instead of versions to match as HP is
+		 * apparently recycling both product and version
+		 * strings.
+		 *
+		 * http://bugzilla.kernel.org/show_bug.cgi?id=15462
 		 */
 		{
 			.ident = "dv4",
@@ -3030,7 +3038,7 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
 				DMI_MATCH(DMI_PRODUCT_NAME,
 					  "HP Pavilion dv4 Notebook PC"),
 			},
-			.driver_data = "F.30", /* cutoff BIOS version */
+			.driver_data = "20090105",	/* F.30 */
 		},
 		{
 			.ident = "dv5",
@@ -3039,7 +3047,7 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
 				DMI_MATCH(DMI_PRODUCT_NAME,
 					  "HP Pavilion dv5 Notebook PC"),
 			},
-			.driver_data = "F.16", /* cutoff BIOS version */
+			.driver_data = "20090506",	/* F.16 */
 		},
 		{
 			.ident = "dv6",
@@ -3048,7 +3056,7 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
 				DMI_MATCH(DMI_PRODUCT_NAME,
 					  "HP Pavilion dv6 Notebook PC"),
 			},
-			.driver_data = "F.21",	/* cutoff BIOS version */
+			.driver_data = "20090423",	/* F.21 */
 		},
 		{
 			.ident = "HDX18",
@@ -3057,7 +3065,7 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
 				DMI_MATCH(DMI_PRODUCT_NAME,
 					  "HP HDX18 Notebook PC"),
 			},
-			.driver_data = "F.23",	/* cutoff BIOS version */
+			.driver_data = "20090430",	/* F.23 */
 		},
 		/*
 		 * Acer eMachines G725 has the same problem.  BIOS
@@ -3065,6 +3073,8 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
 		 * work.  Inbetween, there are V1.06, V2.06 and V3.03
 		 * that we don't have much idea about.  For now,
 		 * blacklist anything older than V3.04.
+		 *
+		 * http://bugzilla.kernel.org/show_bug.cgi?id=15104
 		 */
 		{
 			.ident = "G725",
@@ -3072,19 +3082,21 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
 				DMI_MATCH(DMI_SYS_VENDOR, "eMachines"),
 				DMI_MATCH(DMI_PRODUCT_NAME, "eMachines G725"),
 			},
-			.driver_data = "V3.04",	/* cutoff BIOS version */
+			.driver_data = "20091216",	/* V3.04 */
 		},
 		{ }	/* terminate list */
 	};
 	const struct dmi_system_id *dmi = dmi_first_match(sysids);
-	const char *ver;
+	int year, month, date;
+	char buf[9];
 
 	if (!dmi || pdev->bus->number || pdev->devfn != PCI_DEVFN(0x1f, 2))
 		return false;
 
-	ver = dmi_get_system_info(DMI_BIOS_VERSION);
+	dmi_get_date(DMI_BIOS_DATE, &year, &month, &date);
+	snprintf(buf, sizeof(buf), "%04d%02d%02d", year, month, date);
 
-	return !ver || strcmp(ver, dmi->driver_data) < 0;
+	return strcmp(buf, dmi->driver_data) < 0;
 }
 
 static bool ahci_broken_online(struct pci_dev *pdev)
