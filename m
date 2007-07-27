From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: implement piix_borken_suspend()
Date: Fri, 27 Jul 2007 14:53:28 +0900
Message-ID: <46A98858.5090209@gmail.com>
References: <20070710063605.GA21994@htj.dyndns.org>	<20070710065543.GA23568@htj.dyndns.org>	<46A66842.6040803@garzik.org> <20070724225747.1dd4d141@the-village.bc.nu> <46A677C3.9090107@garzik.org> <46A98607.7000401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:32025 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758358AbXG0Fxf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jul 2007 01:53:35 -0400
Received: by rv-out-0910.google.com with SMTP id k20so79545rvb
        for <linux-ide@vger.kernel.org>; Thu, 26 Jul 2007 22:53:34 -0700 (PDT)
In-Reply-To: <46A98607.7000401@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, greg@kroah.com, linux-ide@vger.kernel.org, owner-linux-pci@atrey.karlin.mff.cuni.cz

Separate out broken suspend blacklist matching into
piix_broken_suspend().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ata_piix.c |   60 ++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

Index: work/drivers/ata/ata_piix.c
===================================================================
--- work.orig/drivers/ata/ata_piix.c
+++ work/drivers/ata/ata_piix.c
@@ -890,37 +890,38 @@ static void ich_set_dmamode (struct ata_
 }
 
 #ifdef CONFIG_PM
-static struct dmi_system_id piix_broken_suspend_dmi_table[] = {
-	{
-		.ident = "TECRA M5",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "TECRA M5"),
-		},
-	},
-	{
-		.ident = "Satellite U200",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite U200"),
+static int piix_broken_suspend(void)
+{
+	static struct dmi_system_id sysids[] = {
+		{
+			.ident = "TECRA M5",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "TECRA M5"),
+			},
 		},
-	},
-	{
-		.ident = "Satellite U205",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite U205"),
+		{
+			.ident = "Satellite U205",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "Satellite U205"),
+			},
 		},
-	},
-	{
-		.ident = "Portege M500",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE M500"),
+		{
+			.ident = "Portege M500",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE M500"),
+			},
 		},
-	},
-	{ }
-};
+		{ }
+	};
+
+	if (dmi_check_system(sysids))
+		return 1;
+
+	return 0;
+}
 
 static int piix_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
@@ -937,8 +938,7 @@ static int piix_pci_device_suspend(struc
 	 * cycles and power trying to do something to the sleeping
 	 * beauty.
 	 */
-	if (dmi_check_system(piix_broken_suspend_dmi_table) &&
-	    mesg.event == PM_EVENT_SUSPEND) {
+	if (piix_broken_suspend() && mesg.event == PM_EVENT_SUSPEND) {
 		pci_save_state(pdev);
 
 		/* mark its power state as "unknown", since we don't
