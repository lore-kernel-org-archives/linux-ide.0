From: "James Ausmus" <james.ausmus@gmail.com>
Subject: [PATCH 1/1] ide: Allow disabling of UDMA for Compact Flash devices
Date: Mon, 17 Apr 2006 16:11:22 -0700
Message-ID: <b79f23070604171611j784cc9afpd1bc6660cd25eed5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.196]:25471 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750899AbWDQXLY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Apr 2006 19:11:24 -0400
Received: by xproxy.gmail.com with SMTP id t10so421450wxc
        for <linux-ide@vger.kernel.org>; Mon, 17 Apr 2006 16:11:22 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Some IDE -> Compact Flash media adapters are not capable of supporting
UDMA, which can cause very slow boot times when the CF media itself
reports as capable of UDMA transfer speeds. Create Kconfig option to
turn off the UDMA capability bit when media is identified as Compact
Flash.

Signed-off-by: James Ausmus <james.ausmus@gmail.com>

---

diff -uprN -X linux-2.6.16.5/Documentation/dontdiff
linux-2.6.16.5.orig/drivers/ide/Kconfig
linux-2.6.16.5/drivers/ide/Kconfig
--- linux-2.6.16.5.orig/drivers/ide/Kconfig     2006-04-17
13:37:47.000000000 -0700
+++ linux-2.6.16.5/drivers/ide/Kconfig  2006-04-17 13:43:37.000000000 -0700
@@ -447,6 +447,18 @@ config IDEDMA_ONLYDISK

          Generally say N here.

+config IDE_COMPACT_FLASH_NO_UDMA
+       bool "Disable UDMA for Compact Flash Devices"
+       help
+         This turns off the UDMA capability flag bit for any IDE device
+         that identifies as Compact Flash - This is a workaround for
+         cheap Compact Flash -> IDE adapters that don't support UDMA
+         transfer speeds even if the CF card does.
+
+         Enable this if you are using a Compact Flash card as an IDE
+         device and you see re-occuring 0x41 DMA Timeout errors from
+         your IDE driver.
+
 config BLK_DEV_AEC62XX
        tristate "AEC62XX chipset support"
        help
diff -uprN -X linux-2.6.16.5/Documentation/dontdiff
linux-2.6.16.5.orig/drivers/ide/ide-probe.c
linux-2.6.16.5/drivers/ide/ide-probe.c
--- linux-2.6.16.5.orig/drivers/ide/ide-probe.c 2006-04-17
13:37:48.000000000 -0700
+++ linux-2.6.16.5/drivers/ide/ide-probe.c      2006-04-17
13:44:45.000000000 -0700
@@ -248,6 +248,11 @@ static inline void do_identify (ide_driv
        if ((id->config != 0x848a) && (id->config & (1<<7)))
                drive->removable = 1;

+#if defined(CONFIG_IDE_COMPACT_FLASH_NO_UDMA)
+       if (id->config == 0x848a)
+               id->capability &= ~1;
+#endif
+
        drive->media = ide_disk;
        printk("%s DISK drive\n", (id->config == 0x848a) ? "CFA" : "ATA" );
        QUIRK_LIST(drive);
