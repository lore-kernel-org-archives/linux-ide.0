From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/10] ide-generic: remove "no_pci_devices()" quirk from ide_default_io_base()
Date: Mon, 7 Jul 2008 23:53:06 +0200
Message-ID: <200807072353.06335.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:12845 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758238AbYGGWAv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jul 2008 18:00:51 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1051975ywe.1
        for <linux-ide@vger.kernel.org>; Mon, 07 Jul 2008 15:00:49 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Since the decision to probe for ISA ide2-6 is now left to the user
"no_pci_devices()" quirk is no longer needed and may be removed.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/asm-mips/mach-generic/ide.h |   18 ++++--------------
 include/asm-x86/ide.h               |   18 ++++--------------
 2 files changed, 8 insertions(+), 28 deletions(-)

Index: b/include/asm-mips/mach-generic/ide.h
===================================================================
--- a/include/asm-mips/mach-generic/ide.h
+++ b/include/asm-mips/mach-generic/ide.h
@@ -72,23 +72,13 @@ static __inline__ int ide_default_irq(un
 
 static __inline__ unsigned long ide_default_io_base(int index)
 {
-	/*
-	 *      If PCI is present then it is not safe to poke around
-	 *      the other legacy IDE ports. Only 0x1f0 and 0x170 are
-	 *      defined compatibility mode ports for PCI. A user can
-	 *      override this using ide= but we must default safe.
-	 */
-	if (no_pci_devices()) {
-		switch (index) {
-		case 2: return 0x1e8;
-		case 3: return 0x168;
-		case 4: return 0x1e0;
-		case 5: return 0x160;
-		}
-	}
 	switch (index) {
 	case 0: return 0x1f0;
 	case 1: return 0x170;
+	case 2: return 0x1e8;
+	case 3: return 0x168;
+	case 4: return 0x1e0;
+	case 5: return 0x160;
 	default:
 		return 0;
 	}
Index: b/include/asm-x86/ide.h
===================================================================
--- a/include/asm-x86/ide.h
+++ b/include/asm-x86/ide.h
@@ -36,23 +36,13 @@ static __inline__ int ide_default_irq(un
 
 static __inline__ unsigned long ide_default_io_base(int index)
 {
-	/*
-	 *	If PCI is present then it is not safe to poke around
-	 *	the other legacy IDE ports. Only 0x1f0 and 0x170 are
-	 *	defined compatibility mode ports for PCI. A user can 
-	 *	override this using ide= but we must default safe.
-	 */
-	if (no_pci_devices()) {
-		switch(index) {
-			case 2: return 0x1e8;
-			case 3: return 0x168;
-			case 4: return 0x1e0;
-			case 5: return 0x160;
-		}
-	}
 	switch (index) {
 		case 0:	return 0x1f0;
 		case 1:	return 0x170;
+		case 2: return 0x1e8;
+		case 3: return 0x168;
+		case 4: return 0x1e0;
+		case 5: return 0x160;
 		default:
 			return 0;
 	}
