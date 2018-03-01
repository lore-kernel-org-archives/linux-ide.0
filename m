From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] pata_falcon: clarify license version and use SPDX header
Date: Thu, 01 Mar 2018 12:13:35 +0100
Message-ID: <2054548.du6VOAbhqL@amdc3058>
References: <CGME20180301111338epcas1p3986304526e78000c4f7b00f7154fc92a@epcas1p3.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

- clarify license version (it should be GPL 2.0)
- use SPDX header

Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/pata_falcon.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: b/drivers/ata/pata_falcon.c
===================================================================
--- a/drivers/ata/pata_falcon.c	2018-01-30 18:00:36.384918948 +0100
+++ b/drivers/ata/pata_falcon.c	2018-03-01 12:04:30.369550503 +0100
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * Atari Falcon PATA controller driver
  *
@@ -7,10 +9,6 @@
  * Based on falconide.c:
  *
  *     Created 12 Jul 1997 by Geert Uytterhoeven
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/kernel.h>
@@ -180,5 +178,5 @@ module_init(pata_falcon_init_one);
 
 MODULE_AUTHOR("Bartlomiej Zolnierkiewicz");
 MODULE_DESCRIPTION("low-level driver for Atari Falcon PATA");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_VERSION(DRV_VERSION);
