From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/3] gayle: add "doubler" parameter
Date: Sun, 23 Mar 2008 21:27:30 +0100
Message-ID: <200803232127.30323.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:33897 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756114AbYCWUQy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Mar 2008 16:16:54 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2596098fgb.17
        for <linux-ide@vger.kernel.org>; Sun, 23 Mar 2008 13:16:53 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

* Add "doubler" parameter to enable support for IDE doublers.

* Obsolete "ide=doubler" kernel parameter.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 Documentation/ide/ide.txt  |    9 +++------
 drivers/ide/ide.c          |    2 +-
 drivers/ide/legacy/gayle.c |    2 ++
 3 files changed, 6 insertions(+), 7 deletions(-)

Index: b/Documentation/ide/ide.txt
===================================================================
--- a/Documentation/ide/ide.txt
+++ b/Documentation/ide/ide.txt
@@ -181,12 +181,6 @@ driver using the "options=" keyword to i
 Summary of ide driver parameters for kernel command line
 --------------------------------------------------------
 
- "ide=doubler"		: probe/support IDE doublers on Amiga
-
-There may be more options than shown -- use the source, Luke!
-
-Everything else is rejected with a "BAD OPTION" message.
-
 For legacy IDE VLB host drivers (ali14xx/dtc2278/ht6560b/qd65xx/umc8672)
 you need to explicitly enable probing by using "probe" kernel parameter,
 i.e. to enable probing for ALI M14xx chipsets (ali14xx host driver) use:
@@ -203,6 +197,9 @@ are detected automatically).
 You also need to use "probe" kernel parameter for ide-4drives driver
 (support for IDE generic chipset with four drives on one port).
 
+To enable support for IDE doublers on Amiga use "doubler" kernel parameter
+for gayle host driver (i.e. "gayle.doubler" if the driver is built-in).
+
 To force ignoring cable detection (this should be needed only if you're using
 short 40-wires cable which cannot be automatically detected - if this is not
 a case please report it as a bug instead) use "ignore_cable" kernel parameter:
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -717,7 +717,7 @@ static int __init ide_setup(char *s)
 
 		printk(" : Enabled support for IDE doublers\n");
 		ide_doubler = 1;
-		return 1;
+		goto obsolete_option;
 	}
 #endif /* CONFIG_BLK_DEV_IDEDOUBLER */
 
Index: b/drivers/ide/legacy/gayle.c
===================================================================
--- a/drivers/ide/legacy/gayle.c
+++ b/drivers/ide/legacy/gayle.c
@@ -63,6 +63,8 @@
 #define GAYLE_HAS_CONTROL_REG	(!ide_doubler)
 #define GAYLE_IDEREG_SIZE	(ide_doubler ? 0x1000 : 0x2000)
 int ide_doubler = 0;	/* support IDE doublers? */
+module_param_named(doubler, ide_doubler, bool, 0);
+MODULE_PARM_DESC(doubler, "enable support for IDE doublers");
 #endif /* CONFIG_BLK_DEV_IDEDOUBLER */
 
 
