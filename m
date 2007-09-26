From: Andreas Messer <andreas.messer@stud-mail.uni-wuerzburg.de>
Subject: [PATCH] libata, ata_piix, add notebook to short cable list
Date: Wed, 26 Sep 2007 12:52:07 +0200
Message-ID: <20070926125207.5cd489ef@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:52907 "EHLO
	mailrelay.rz.uni-wuerzburg.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754273AbXIZLVx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Sep 2007 07:21:53 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id F090AAEEF
	for <linux-ide@vger.kernel.org>; Wed, 26 Sep 2007 12:52:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id E2AE6AFBB
	for <linux-ide@vger.kernel.org>; Wed, 26 Sep 2007 12:52:09 +0200 (CEST)
Received: from localhost (wthp178.physik.uni-wuerzburg.de [132.187.40.178])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id C4CD8AEEF
	for <linux-ide@vger.kernel.org>; Wed, 26 Sep 2007 12:52:09 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello, 

hopefully the right place for this small patch. My new notebook uses
a short 40 pin ide-cable, ata_piix therefore disabled UDMA>33. I added
the chipset ids to the short-cable list and now everything working fine
with UDMA100.

regards
---
--- linux-2.6.22/drivers/ata/ata_piix.c	2007-07-09 01:32:17.000000000 +0200
+++ linux/drivers/ata/ata_piix.c	2007-09-13 21:08:07.000000000 +0200
@@ -578,6 +578,7 @@
 	{ 0x27DF, 0x0005, 0x0280 },	/* ICH7 on Acer 5602WLMi */
 	{ 0x27DF, 0x1025, 0x0110 },	/* ICH7 on Acer 3682WLMi */
 	{ 0x27DF, 0x1043, 0x1267 },	/* ICH7 on Asus W5F */
+	{ 0x27DF, 0x103C, 0x30A1 },	/* ICH7 on HP Compaq nc2400 */
 	{ 0x24CA, 0x1025, 0x0061 },	/* ICH4 on ACER Aspire 2023WLMi */
 	/* end marker */
 	{ 0, }
