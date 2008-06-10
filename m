From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 14/14] ide: remove needless includes from setup-pci.c
Date: Tue, 10 Jun 2008 22:53:15 +0200
Message-ID: <20080610205315.18469.27468.sendpatchset@localhost.localdomain>
References: <20080610205059.18469.44856.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.184]:29680 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758374AbYFJUvj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jun 2008 16:51:39 -0400
Received: by gv-out-0910.google.com with SMTP id e6so669622gvc.37
        for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2008 13:51:38 -0700 (PDT)
In-Reply-To: <20080610205059.18469.44856.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/setup-pci.c |    5 -----
 1 file changed, 5 deletions(-)

Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -6,19 +6,14 @@
  *  May be copied or modified under the terms of the GNU General Public License
  */
 
-#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/init.h>
-#include <linux/timer.h>
-#include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/ide.h>
-#include <linux/dma-mapping.h>
 
 #include <asm/io.h>
-#include <asm/irq.h>
 
 /**
  *	ide_setup_pci_baseregs	-	place a PCI IDE controller native
