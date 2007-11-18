From: Thomas Rohwer <tr@tng.de>
Subject: Re: Hang during boot in piix_init_pcs (ata_piix.c) with macbook pro
Date: Sun, 18 Nov 2007 19:00:56 +0100
Message-ID: <47407DD8.10301@tng.de>
References: <47371586.9090409@tng.de> <47386F3E.8000906@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000206040208050108040403"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from liadriel1.tng.de ([213.178.66.91]:55140 "EHLO smtp.tng.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751287AbXKRSA7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 18 Nov 2007 13:00:59 -0500
In-Reply-To: <47386F3E.8000906@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, "Gaston, Jason D" <jason.d.gaston@intel.com>

This is a multi-part message in MIME format.
--------------000206040208050108040403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello Tejun,

> Yes, adding a separate entry for ich8m is the correct approach w/
> port_enable=1 seems like the correct approach.  Does it fix the problem?

yes, the hang did not occur anymore after the change.
A patch with respect to linux-2.6.24-rc3 is included as attachment
(Signed-off-by: Thomas Rohwer <tr@tng.de>).
In the pci_device_id table I limited the new mapping to the specific
subvendor (0x106b, 0x00a0), because in general the ich8m can have up to
3 ports. I tested this only on my hardware and I am not sure if this
is the best fix for the issue.

Sincerely,

Thomas Rohwer

--------------000206040208050108040403
Content-Type: text/x-diff;
 name="ata_piix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ata_piix.patch"

--- linux-2.6.24-rc3/drivers/ata/ata_piix.c	2007-11-17 06:16:36.000000000 +0100
+++ linux/drivers/ata/ata_piix.c	2007-11-18 02:45:11.000000000 +0100
@@ -131,6 +131,7 @@
 	piix_pata_mwdma		= 10,	/* PIIX3 MWDMA only */
 	tolapai_sata_ahci	= 11,
 	ich9_2port_sata		= 12,
+	ich8m_apple_sata_ahci= 13,
 
 	/* constants for mapping table */
 	P0			= 0,  /* port 0 */
@@ -240,6 +241,8 @@
 	{ 0x8086, 0x2820, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
 	/* SATA Controller 2 IDE (ICH8) */
 	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich9_2port_sata },
+	/* Mobile SATA Controller IDE (ICH8M), Apple */
+	{ 0x8086, 0x2828, 0x106b, 0x00a0, 0, 0, ich8m_apple_sata_ahci },
 	/* Mobile SATA Controller IDE (ICH8M) */
 	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
 	/* SATA Controller IDE (ICH9) */
@@ -461,6 +464,18 @@
 	},
 };
 
+static const struct piix_map_db ich8m_apple_map_db = {
+	.mask = 0x3,
+	.port_enable = 0x1,
+	.map = {
+		/* PM   PS   SM   SS       MAP */
+		{  P0,  NA,  NA,  NA }, /* 00b */
+		{  RV,  RV,  RV,  RV },
+		{  P0,  P2, IDE, IDE }, /* 10b */
+		{  RV,  RV,  RV,  RV },
+	},
+};
+
 static const struct piix_map_db *piix_map_db_table[] = {
 	[ich5_sata]		= &ich5_map_db,
 	[ich6_sata]		= &ich6_map_db,
@@ -469,6 +484,7 @@
 	[ich8_sata_ahci]	= &ich8_map_db,
 	[tolapai_sata_ahci]	= &tolapai_map_db,
 	[ich9_2port_sata]	= &ich9_2port_map_db,
+	[ich8m_apple_sata_ahci]	= &ich8m_apple_map_db,
 };
 
 static struct ata_port_info piix_port_info[] = {
@@ -595,6 +611,18 @@
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &piix_sata_ops,
 	},
+
+	[ich8m_apple_sata_ahci] =
+	{
+		.sht		= &piix_sht,
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
+				  PIIX_FLAG_AHCI,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &piix_sata_ops,
+	},
+
 };
 
 static struct pci_bits piix_enable_bits[] = {

--------------000206040208050108040403--
