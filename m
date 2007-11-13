From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove stale/incorrect comment from setup-pci.c
Date: Tue, 13 Nov 2007 22:06:30 +0100
Message-ID: <200711132206.30156.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:58240 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759358AbXKMVHj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Nov 2007 16:07:39 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1946508fkz
        for <linux-ide@vger.kernel.org>; Tue, 13 Nov 2007 13:07:38 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/setup-pci.c |    5 -----
 1 file changed, 5 deletions(-)

Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -7,11 +7,6 @@
  *  May be copied or modified under the terms of the GNU General Public License
  */
 
-/*
- *  This module provides support for automatic detection and
- *  configuration of all PCI IDE interfaces present in a system.  
- */
-
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
