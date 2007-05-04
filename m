From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH pata-2.6 fix queue] hpt366: don't check enablebits for HPT36x
Date: Fri, 4 May 2007 23:18:37 +0400
Message-ID: <200705042318.37367.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:16674 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422765AbXEDTRF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 May 2007 15:17:05 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, michal.kepien@poczta.onet.pl
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

HPT36x chip don't seem to have the channel enable bits, so prevent the IDE core
from checking them...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Michal, sorry for unintended breakage, please verify the patch... :-)

 drivers/ide/pci/hpt366.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/ide/pci/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/hpt366.c
+++ linux-2.6/drivers/ide/pci/hpt366.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 1.02	Apr 18, 2007
+ * linux/drivers/ide/pci/hpt366.c		Version 1.03	May 4, 2007
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -1527,7 +1527,12 @@ static int __devinit init_setup_hpt366(s
 	if (rev > 2)
 		goto init_single;
 
+	/*
+	 * HPT36x chips are single channel and
+	 * do not seem to have the channel enable bit...
+	 */
 	d->channels = 1;
+	d->enablebits[0].reg = 0;
 
 	if ((dev2 = pci_get_slot(dev->bus, dev->devfn + 1)) != NULL) {
 	  	u8  pin1 = 0, pin2 = 0;

