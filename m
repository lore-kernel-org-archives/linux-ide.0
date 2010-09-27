From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/2] hpt366: add debounce delay to cable_detect() method
Date: Mon, 27 Sep 2010 18:08:15 +0400
Message-ID: <201009271808.15710.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:45552 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750865Ab0I0OPj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Sep 2010 10:15:39 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: linux-ide@vger.kernel.org, stable@kernel.org, bzolnier@gmail.com, alan@lxorguk.ukuu.org.uk

Alan Cox reported that cable detection sometimes works unreliably
for HPT3xxN and that the issue is fixed by adding debounce delay
as used by the vendor drivers.

While at it, get rid of unneeded parens/space in the vicinity...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: stable@kernel.org

---
The patcn is atop of ide-2.6.git tree...

 drivers/ide/hpt366.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

Index: ide-2.6/drivers/ide/hpt366.c
===================================================================
--- ide-2.6.orig/drivers/ide/hpt366.c
+++ ide-2.6/drivers/ide/hpt366.c
@@ -1173,8 +1173,9 @@ static u8 hpt3xx_cable_detect(ide_hwif_t
 		u16 mcr;
 
 		pci_read_config_word(dev, mcr_addr, &mcr);
-		pci_write_config_word(dev, mcr_addr, (mcr | 0x8000));
-		/* now read cable id register */
+		pci_write_config_word(dev, mcr_addr, mcr | 0x8000);
+		/* Debounce, then read cable ID register */
+		udelay(10);
 		pci_read_config_byte(dev, 0x5a, &scr1);
 		pci_write_config_word(dev, mcr_addr, mcr);
 	} else if (chip_type >= HPT370) {
@@ -1185,10 +1186,11 @@ static u8 hpt3xx_cable_detect(ide_hwif_t
 		u8 scr2 = 0;
 
 		pci_read_config_byte(dev, 0x5b, &scr2);
-		pci_write_config_byte(dev, 0x5b, (scr2 & ~1));
-		/* now read cable id register */
+		pci_write_config_byte(dev, 0x5b, scr2 & ~1);
+		/* Debounce, then read cable ID register */
+		udelay(10);
 		pci_read_config_byte(dev, 0x5a, &scr1);
-		pci_write_config_byte(dev, 0x5b,  scr2);
+		pci_write_config_byte(dev, 0x5b, scr2);
 	} else
 		pci_read_config_byte(dev, 0x5a, &scr1);
 
