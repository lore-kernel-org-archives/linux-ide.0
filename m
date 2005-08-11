From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Date: Thu, 11 Aug 2005 14:24:43 -0600
Message-ID: <200508111424.43150.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:4773 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932432AbVHKUYr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 16:24:47 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org

IA64 boxes only have PCI IDE devices, so there's no need to blindly poke
around in I/O port space.  Poking at things that don't exist causes MCAs
on HP ia64 systems.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-vga/drivers/ide/Kconfig
===================================================================
--- work-vga.orig/drivers/ide/Kconfig	2005-08-10 14:57:47.000000000 -0600
+++ work-vga/drivers/ide/Kconfig	2005-08-10 14:58:02.000000000 -0600
@@ -276,6 +276,7 @@
 
 config IDE_GENERIC
 	tristate "generic/default IDE chipset support"
+	depends on !IA64
 	default y
 	help
 	  If unsure, say Y.
