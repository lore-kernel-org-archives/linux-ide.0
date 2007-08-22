From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH 2.6.23-rc3] pata_via cable override for Arima W730-K8
Date: Wed, 22 Aug 2007 11:26:03 +0200 (MEST)
Message-ID: <200708220926.l7M9Q3eb014746@alkaid.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:40992 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753169AbXHVJ0K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Aug 2007 05:26:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: linux-ide@vger.kernel.org

On Fri, 3 Aug 2007 23:32:17 +0100, Alan Cox wrote:
>On Fri, 3 Aug 2007 20:28:39 +0200 (MEST)
>Mikael Pettersson <mikpe@it.uu.se> wrote:
>
>> The machine is an Athlon64 laptop with a K8T800 chipset. With the IDE
>> VIA driver the disk is detected as udma/100:
>
>Currently old IDE via driver has a hack in it which goes 'did the BIOS
>set UDMA3+' then I guess the cable is 80 wire regardless. libata doesn't
>do that as it breaks with hotplug, breaks with suspend/resume before the
>driver is loaded and other bits.
>
>Instead we have two things - an ACPI snoop and a table of wonky laptops
>(eg those that use 40 wire ultrashort cables which are valid for UDMA133
>but not detected as 80 wire). If your laptop is done that way then it
>just needs adding to the magic list and/or 2.6.23-rc1-mm should spot it
>by ACPI. I'd prefer the table entry anyway as I don't like relying on ACPI
>so an lspci -vvxx would be appreciated

This patch updates the pata_via cable override DMI table to also
recognise my Targa Visionary 811 laptop (== Arima W730-K8).
With this patch pata_via does UDMA100 just like the old IDE driver.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
 drivers/ata/pata_via.c |    7 +++++++
 1 files changed, 7 insertions(+)

--- linux-2.6.23-rc3/drivers/ata/pata_via.c.~1~	2007-08-21 00:45:11.000000000 +0200
+++ linux-2.6.23-rc3/drivers/ata/pata_via.c	2007-08-21 01:01:27.000000000 +0200
@@ -136,6 +136,13 @@ static struct dmi_system_id cable_dmi_ta
 			DMI_MATCH(DMI_BOARD_NAME, "Ferrari 3400"),
 		},
 	},
+	{
+		.ident = "Arima W730-K8",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ACTEBIS"),
+			DMI_MATCH(DMI_BOARD_NAME, "SAM#451B"),
+		},
+	},
 	{ }
 };
 
