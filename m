From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2.6.20-rc2-mm1] HPT36x PCI clock detection fix
Date: Sat, 30 Dec 2006 22:36:36 +0300
Message-ID: <200612302236.36285.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:64660 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030313AbWL3Tgy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Dec 2006 14:36:54 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Fix minor coding mistake in the HPT36x PCI clock detection code noticed by
Bartlomiej Zolnierkiewicz -- it always reported 33 MHz due to the missing
'break' statements.  This, however, most probably never mattered -- in fact,
I was thinking of removing the 25/40 MHz cases completely since HPT36x BIOSes
didn't seem to set any other value than 7 into the 'cmd_high_time' field, i.e.
supported only 33 MHz PCI.

Note that in the original driver there was another bug: 25 and 40 MHz cases
were interchanged.  Since the 'cmd_high_time' field is in units of PCI clocks,
a lower clock count just *cannot* correspond to a higher frequency, i. e. it
should be 5 for 25 MHz PCI and 9 for 40 MHz PCI, not the other way around.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ide/pci/hpt366.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/ide/pci/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/hpt366.c
+++ linux-2.6/drivers/ide/pci/hpt366.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 1.00	Jun 25, 2006
+ * linux/drivers/ide/pci/hpt366.c		Version 1.01	Dec 23, 2006
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -107,7 +107,8 @@
  *   frequency
  * - switch to using the  DPLL clock and enable UltraATA/133 mode by default on
  *   anything  newer than HPT370/A
- * - fold PCI clock detection and DPLL setup code into init_chipset_hpt366();
+ * - fold PCI clock detection and DPLL setup code into init_chipset_hpt366(),
+ *   also fixing the interchanged 25/40 MHz PCI clock cases for HPT36x chips;
  *   unify HPT36x/37x timing setup code and the speedproc handlers by joining
  *   the register setting lists into the table indexed by the clock selected
  *	Sergei Shtylyov, <sshtylyov@ru.mvista.com> or <source@mvista.com>
@@ -1125,11 +1126,14 @@ static unsigned int __devinit init_chips
 		switch((itr1 >> 8) & 0x07) {
 			case 0x09:
 				pci_clk = 40;
+				break;
 			case 0x05:
 				pci_clk = 25;
+				break;
 			case 0x07:
 			default:
 				pci_clk = 33;
+				break;
 		}
 	}
 

