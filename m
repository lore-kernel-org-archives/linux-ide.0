From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 01/68] piix: add new short cable IDs
Date: Fri, 29 Jan 2010 17:03:14 +0100
Message-ID: <20100129160314.21495.61408.sendpatchset@localhost>
References: <20100129160308.21495.14120.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752355Ab0A2QDa@vger.kernel.org>
In-Reply-To: <20100129160308.21495.14120.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] piix: add new short cable IDs

Based on commits 6034734 and 760cdb7 for ata_piix.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/piix.c |    3 +++
 1 file changed, 3 insertions(+)

Index: b/drivers/ide/piix.c
===================================================================
--- a/drivers/ide/piix.c
+++ b/drivers/ide/piix.c
@@ -256,9 +256,12 @@ static const struct ich_laptop ich_lapto
 	{ 0x27DF, 0x1025, 0x0102 },	/* ICH7 on Acer 5602aWLMi */
 	{ 0x27DF, 0x0005, 0x0280 },	/* ICH7 on Acer 5602WLMi */
 	{ 0x27DF, 0x1025, 0x0110 },	/* ICH7 on Acer 3682WLMi */
+	{ 0x27DF, 0x1028, 0x02b0 },	/* ICH7 on unknown Dell */
 	{ 0x27DF, 0x1043, 0x1267 },	/* ICH7 on Asus W5F */
 	{ 0x27DF, 0x103C, 0x30A1 },	/* ICH7 on HP Compaq nc2400 */
+	{ 0x27DF, 0x103C, 0x361a },	/* ICH7 on unkown HP  */
 	{ 0x27DF, 0x1071, 0xD221 },	/* ICH7 on Hercules EC-900 */
+	{ 0x27DF, 0x152D, 0x0778 },	/* ICH7 on unknown Intel */
 	{ 0x24CA, 0x1025, 0x0061 },	/* ICH4 on Acer Aspire 2023WLMi */
 	{ 0x24CA, 0x1025, 0x003d },	/* ICH4 on ACER TM290 */
 	{ 0x266F, 0x1025, 0x0066 },	/* ICH6 on ACER Aspire 1694WLMi */
