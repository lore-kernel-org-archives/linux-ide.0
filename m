From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/9] piix: remove stale comments
Date: Thu, 27 Dec 2007 20:12:00 +0100
Message-ID: <20071227191200.1357.71766.sendpatchset@localhost.localdomain>
References: <20071227191153.1357.63211.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:6105 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbXL0TBH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Dec 2007 14:01:07 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1692943ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 27 Dec 2007 11:01:06 -0800 (PST)
In-Reply-To: <20071227191153.1357.63211.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/piix.c |   47 +----------------------------------------------
 1 file changed, 1 insertion(+), 46 deletions(-)

Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -8,53 +8,8 @@
  *
  *  May be copied or modified under the terms of the GNU General Public License
  *
- *  PIO mode setting function for Intel chipsets.
- *  For use instead of BIOS settings.
+ * Documentation:
  *
- * 40-41
- * 42-43
- * 
- *                 41
- *                 43
- *
- * | PIO 0       | c0 | 80 | 0 |
- * | PIO 2 | SW2 | d0 | 90 | 4 |
- * | PIO 3 | MW1 | e1 | a1 | 9 |
- * | PIO 4 | MW2 | e3 | a3 | b |
- *
- * sitre = word40 & 0x4000; primary
- * sitre = word42 & 0x4000; secondary
- *
- * 44 8421|8421    hdd|hdb
- *
- * 48 8421         hdd|hdc|hdb|hda udma enabled
- *
- *    0001         hda
- *    0010         hdb
- *    0100         hdc
- *    1000         hdd
- *
- * 4a 84|21        hdb|hda
- * 4b 84|21        hdd|hdc
- *
- *    ata-33/82371AB
- *    ata-33/82371EB
- *    ata-33/82801AB            ata-66/82801AA
- *    00|00 udma 0              00|00 reserved
- *    01|01 udma 1              01|01 udma 3
- *    10|10 udma 2              10|10 udma 4
- *    11|11 reserved            11|11 reserved
- *
- * 54 8421|8421    ata66 drive|ata66 enable
- *
- * pci_read_config_word(HWIF(drive)->pci_dev, 0x40, &reg40);
- * pci_read_config_word(HWIF(drive)->pci_dev, 0x42, &reg42);
- * pci_read_config_word(HWIF(drive)->pci_dev, 0x44, &reg44);
- * pci_read_config_byte(HWIF(drive)->pci_dev, 0x48, &reg48);
- * pci_read_config_word(HWIF(drive)->pci_dev, 0x4a, &reg4a);
- * pci_read_config_byte(HWIF(drive)->pci_dev, 0x54, &reg54);
- *
- * Documentation
  *	Publically available from Intel web site. Errata documentation
  * is also publically available. As an aide to anyone hacking on this
  * driver the list of errata that are relevant is below.going back to
