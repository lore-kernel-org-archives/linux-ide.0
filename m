From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: skip probing port if "hdx=noprobe" was used for both devices on it
Date: Fri, 22 Feb 2008 23:57:43 +0100
Message-ID: <200802222357.43673.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:50285 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759431AbYBVWpJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Feb 2008 17:45:09 -0500
Received: by ug-out-1314.google.com with SMTP id z38so8549ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 22 Feb 2008 14:45:08 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

* Skip probing port if "hdx=noprobe" parameter was used for both devices on it.

* Obsolete "idex=noprobe" parameter - it only works for ide_generic, cmd640
  and PCI hosts in Compatibility mode (on alpha/x86/ia64/m32r/mips/ppc32).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
goes after "ide: remove redundant comment from ide_unregister()" patch
in IDE quilt tree

 Documentation/ide.txt    |    2 --
 drivers/ide/ide-probe.c  |    3 ++-
 drivers/ide/ide.c        |    2 +-
 drivers/ide/pci/cmd640.c |    3 ++-
 4 files changed, 5 insertions(+), 5 deletions(-)

Index: b/Documentation/ide.txt
===================================================================
--- a/Documentation/ide.txt
+++ b/Documentation/ide.txt
@@ -258,8 +258,6 @@ Summary of ide driver parameters for ker
 			  As for VLB, it is safest to not specify it.
 			  Bigger values are safer than smaller ones.
 
- "idex=noprobe"		: do not attempt to access/use this interface
- 
  "idex=base"		: probe for an interface at the addr specified,
 			  where "base" is usually 0x1f0 or 0x170
 			  and "ctl" is assumed to be "base"+0x206
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -756,7 +756,8 @@ static int ide_probe_port(ide_hwif_t *hw
 
 	BUG_ON(hwif->present);
 
-	if (hwif->noprobe)
+	if (hwif->noprobe ||
+	    (hwif->drives[0].noprobe && hwif->drives[1].noprobe))
 		return -EACCES;
 
 	/*
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1444,7 +1444,7 @@ static int __init ide_setup(char *s)
 
 			case -1: /* "noprobe" */
 				hwif->noprobe = 1;
-				goto done;
+				goto obsolete_option;
 
 			case 1:	/* base */
 				vals[1] = vals[0] + 0x206; /* default ctl */
Index: b/drivers/ide/pci/cmd640.c
===================================================================
--- a/drivers/ide/pci/cmd640.c
+++ b/drivers/ide/pci/cmd640.c
@@ -787,7 +787,8 @@ static int __init cmd640x_init(void)
 	/*
 	 * Try to enable the secondary interface, if not already enabled
 	 */
-	if (cmd_hwif1->noprobe) {
+	if (cmd_hwif1->noprobe ||
+	    (cmd_hwif1->drives[0].noprobe && cmd_hwif1->drives[1].noprobe)) {
 		port2 = "not probed";
 	} else {
 		b = get_cmd640_reg(CNTRL);
