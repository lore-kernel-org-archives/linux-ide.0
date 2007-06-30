From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 15/15] ide: remove stale changelog from setup-pci.c
Date: Sat, 30 Jun 2007 21:13:19 +0200
Message-ID: <200706302113.19713.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:9971 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510AbXF3TAX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jun 2007 15:00:23 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1014814ugf
        for <linux-ide@vger.kernel.org>; Sat, 30 Jun 2007 12:00:23 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/setup-pci.c |    6 ------
 1 file changed, 6 deletions(-)

Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -5,12 +5,6 @@
  *
  *  Copyright (c) 1995-1998  Mark Lord
  *  May be copied or modified under the terms of the GNU General Public License
- *
- *  Recent Changes
- *	Split the set up function into multiple functions
- *	Use pci_set_master
- *	Fix misreporting of I/O v MMIO problems
- *	Initial fixups for simplex devices
  */
 
 /*
