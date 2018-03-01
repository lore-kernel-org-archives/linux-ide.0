From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] pata_bk3710: clarify license version and use SPDX header
Date: Thu, 01 Mar 2018 12:16 +0100
Message-ID: <1760511.OZqiSOBhjW@amdc3058>
References: <CGME20180301111603epcas1p20d8448be4c055efdc39e23551bd7f68e@epcas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

- clarify license version (it should be GPL 2.0)
- use SPDX header

Cc: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/pata_bk3710.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: b/drivers/ata/pata_bk3710.c
===================================================================
--- a/drivers/ata/pata_bk3710.c	2017-11-22 14:11:06.120729358 +0100
+++ b/drivers/ata/pata_bk3710.c	2018-03-01 12:10:36.293559718 +0100
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * Palmchip BK3710 PATA controller driver
  *
@@ -8,10 +10,6 @@
  *
  * Copyright (C) 2006 Texas Instruments.
  * Copyright (C) 2007 MontaVista Software, Inc., <source@mvista.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/ata.h>
@@ -379,4 +377,4 @@ static int __init pata_bk3710_init(void)
 }
 
 module_init(pata_bk3710_init);
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
