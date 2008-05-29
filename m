From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] ata_piix: fix macbook ich8m problems
Date: Thu, 29 May 2008 22:04:22 +0900
Message-ID: <483EA9D6.6040402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:35724 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756694AbYE2NEa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 May 2008 09:04:30 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2265443wra.1
        for <linux-ide@vger.kernel.org>; Thu, 29 May 2008 06:04:29 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>
Cc: MATSUBAYASHI 'Shaolin' Kohji <shaolin@rhythmaning.org>

ICH8M on macbooks are peculiar in that some of them lock up when the
second port is enabled, some return bogus values on SIDPR access while
yet others hang on SIDPR access.  Also, the ich8m_apple_sata entry was
wrongly added below generic ich8m entry making it virtually useless.

This patch works around macbook ich8m problems by

* moving ich8m_apple_sata entry above generic ich8m entry
* dropping PIIX_FLAG_SIDPR from ich8m_apple_sata
* adding subsystem 106b:00a1 as ich8m_apple_sata

Reported and tested by MATSUBAYASHI.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: MATSUBAYASHI 'Shaolin' Kohji <shaolin@rhythmaning.org>
---
 drivers/ata/ata_piix.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index a9027b8..3548ee7 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -247,10 +247,11 @@ static const struct pci_device_id piix_pci_tbl[] = {
 	{ 0x8086, 0x2820, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
 	/* SATA Controller 2 IDE (ICH8) */
 	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
-	/* Mobile SATA Controller IDE (ICH8M) */
-	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
 	/* Mobile SATA Controller IDE (ICH8M), Apple */
 	{ 0x8086, 0x2828, 0x106b, 0x00a0, 0, 0, ich8m_apple_sata },
+	{ 0x8086, 0x2828, 0x106b, 0x00a1, 0, 0, ich8m_apple_sata },
+	/* Mobile SATA Controller IDE (ICH8M) */
+	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
 	/* SATA Controller IDE (ICH9) */
 	{ 0x8086, 0x2920, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
 	/* SATA Controller IDE (ICH9) */
@@ -526,7 +527,7 @@ static struct ata_port_info piix_port_info[] = {
 
 	[ich8m_apple_sata] =
 	{
-		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SIDPR,
+		.flags		= PIIX_SATA_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= ATA_UDMA6,
