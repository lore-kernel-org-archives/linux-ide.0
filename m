From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 2/2] ide-generic: handle probing of legacy io-ports
Date: Sun, 3 Aug 2008 09:38:43 +0200
Message-ID: <20080803073842.GB8762@gollum.tnic>
References: <20080715053356.GA18628@gollum.tnic> <200808021902.12191.bzolnier@gmail.com> <20080802183253.GA2239@gollum.tnic> <200808022046.16990.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:43818 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbYHCHir (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Aug 2008 03:38:47 -0400
Received: by fg-out-1718.google.com with SMTP id 19so799755fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 03 Aug 2008 00:38:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200808022046.16990.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

From: Borislav Petkov <petkovbb@gmail.com>
Date: Sun, 3 Aug 2008 09:28:53 +0200
Subject: [PATCH 2/2] ide-generic: handle probing of legacy io-ports

Avoid probing the io-ports in case an IDE PCI controller is present and it uses
the legacy iobases. If we still want to enforce the probing, we do

ide_generic.probe_mask=0x3f

on the kernel command line.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-generic.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
index 8fe8b5b..7d79616 100644
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -27,7 +27,7 @@
 
 #define DRV_NAME	"ide_generic"
 
-static int probe_mask = 0x03;
+static int probe_mask = 0x00;
 module_param(probe_mask, int, 0);
 MODULE_PARM_DESC(probe_mask, "probe mask for legacy ISA IDE ports");
 
@@ -105,18 +105,31 @@ static int __init ide_generic_init(void)
 	hw_regs_t hw[MAX_HWIFS], *hws[MAX_HWIFS];
 	struct ide_host *host;
 	unsigned long io_addr;
-	int i, rc;
+	int i, rc, dummy, primary = 0, secondary = 0;
 
 #ifdef CONFIG_MIPS
 	if (!ide_probe_legacy())
 		return -ENODEV;
 #endif
-	printk(KERN_INFO DRV_NAME ": please use \"probe_mask=0x3f\" module "
-			 "parameter for probing all legacy ISA IDE ports\n");
+	ata_legacy_check_iobases(&primary, &secondary, &dummy);
+
+	if (primary) {
+		if (probe_mask) {
+			printk(KERN_WARNING "%s: enforcing probing of io ports "
+			       "upon user request.\n", DRV_NAME);
+			primary = 0;
+			secondary = 0;
+		} else
+			printk(KERN_INFO DRV_NAME ": please use "
+			       \"probe_mask=0x3f\" module parameter for probing"
+			       "all legacy ISA IDE ports\n");
+
+	} else
+		probe_mask = 0x3;
 
 	memset(hws, 0, sizeof(hw_regs_t *) * MAX_HWIFS);
 
-	for (i = 0; i < ARRAY_SIZE(legacy_bases); i++) {
+	for (i = primary + secondary; i < ARRAY_SIZE(legacy_bases); i++) {
 		io_addr = legacy_bases[i];
 
 		hws[i] = NULL;
-- 
1.5.5.4

-- 
Regards/Gruss,
    Boris.
