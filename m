From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] ICS IDE is not a PCI IDE interface
Date: Fri, 20 Feb 2004 19:44:13 +0000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040220194412.C12815@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26888 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261376AbUBTToR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Feb 2004 14:44:17 -0500
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

Don't list icside.o in drivers/ide/pci/Makefile - it's in drivers/ide/arm.

--- orig/drivers/ide/pci/Makefile	Thu Feb  5 15:25:31 2004
+++ linux/drivers/ide/pci/Makefile	Thu Feb  5 15:35:16 2004
@@ -11,7 +11,6 @@ obj-$(CONFIG_BLK_DEV_CY82C693)		+= cy82c
 obj-$(CONFIG_BLK_DEV_HPT34X)		+= hpt34x.o
 obj-$(CONFIG_BLK_DEV_HPT366)		+= hpt366.o
 #obj-$(CONFIG_BLK_DEV_HPT37X)		+= hpt37x.o
-obj-$(CONFIG_BLK_DEV_IDE_ICSIDE)	+= icside.o
 obj-$(CONFIG_BLK_DEV_IT8172)		+= it8172.o
 obj-$(CONFIG_BLK_DEV_NS87415)		+= ns87415.o
 obj-$(CONFIG_BLK_DEV_OPTI621)		+= opti621.o

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
