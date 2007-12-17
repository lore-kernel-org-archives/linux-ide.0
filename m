From: Joe Perches <joe@perches.com>
Subject: [PATCH] drivers/ide/: Spelling fixes
Date: Mon, 17 Dec 2007 11:30:35 -0800
Message-ID: <5703e57f925f31fc0eb38873bd7f10fc44f99cb4.1197918891.git.joe__25133.6148394786$1197920964$gmane$org@perches.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765213AbXLQTqy@vger.kernel.org>
Message-Id: <5703e57f925f31fc0eb38873bd7f10fc44f99cb4.1197918891.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/ide/pci/cs5535.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/pci/cs5535.c b/drivers/ide/pci/cs5535.c
index 9094916..ddcbeba 100644
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -49,7 +49,7 @@
 #define ATAC_BM0_PRD		0x04
 #define CS5535_CABLE_DETECT	0x48
 
-/* Format I PIO settings. We seperate out cmd and data for safer timings */
+/* Format I PIO settings. We separate out cmd and data for safer timings */
 
 static unsigned int cs5535_pio_cmd_timings[5] =
 { 0xF7F4, 0x53F3, 0x13F1, 0x5131, 0x1131 };
-- 
1.5.3.7.949.g2221a6

