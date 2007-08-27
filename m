From: Adrian Bunk <bunk@kernel.org>
Subject: [-mm patch] unexport noautodma
Date: Mon, 27 Aug 2007 23:28:00 +0200
Message-ID: <20070827212800.GR4121@stusta.de>
References: <20070822020648.5ea3a612.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765690AbXH0Vc3@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070822020648.5ea3a612.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Aug 22, 2007 at 02:06:48AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.23-rc2-mm2:
>...
> +ide-ide-remove-hwif-autodma-and-drive-autodma.patch
>...
>  IDE tree updates
>...

noautodma can now be unexported.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
957dc7601c050cb14a7afc842db0c2d62aaf3509 
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index b3b5f00..5b09066 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -100,8 +100,6 @@ static int ide_scan_direction; /* THIS was formerly 2.2.x pci=reverse */
 
 int noautodma = 0;
 
-EXPORT_SYMBOL(noautodma);
-
 #ifdef CONFIG_BLK_DEV_IDEACPI
 int ide_noacpi = 0;
 int ide_noacpitfs = 1;
