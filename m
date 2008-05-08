From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/5] alim15x3: trivial cleanup for ali_set_pio_mode()
Date: Thu, 8 May 2008 23:03:30 +0200
Message-ID: <200805082303.30236.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:52725 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbYEHUuT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 May 2008 16:50:19 -0400
Received: by fg-out-1718.google.com with SMTP id 19so633176fgg.17
        for <linux-ide@vger.kernel.org>; Thu, 08 May 2008 13:50:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Remove commented out code and stale comment.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/alim15x3.c |   15 ---------------
 1 file changed, 15 deletions(-)

Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -76,11 +76,6 @@ static void ali_set_pio_mode(ide_drive_t
 		a_clc = 0;
 	c_time = ide_pio_timings[pio].cycle_time;
 
-#if 0
-	if ((r_clc = ((c_time - s_time - a_time) * bus_speed + 999) / 1000) >= 16)
-		r_clc = 0;
-#endif
-
 	if (!(r_clc = (c_time * bus_speed + 999) / 1000 - a_clc - s_clc)) {
 		r_clc = 1;
 	} else {
@@ -110,16 +105,6 @@ static void ali_set_pio_mode(ide_drive_t
 	pci_write_config_byte(dev, port, s_clc);
 	pci_write_config_byte(dev, port+drive->select.b.unit+2, (a_clc << 4) | r_clc);
 	local_irq_restore(flags);
-
-	/*
-	 * setup   active  rec
-	 * { 70,   165,    365 },   PIO Mode 0
-	 * { 50,   125,    208 },   PIO Mode 1
-	 * { 30,   100,    110 },   PIO Mode 2
-	 * { 30,   80,     70  },   PIO Mode 3 with IORDY
-	 * { 25,   70,     25  },   PIO Mode 4 with IORDY  ns
-	 * { 20,   50,     30  }    PIO Mode 5 with IORDY (nonstandard)
-	 */
 }
 
 /**
