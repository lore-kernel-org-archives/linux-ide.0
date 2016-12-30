From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/3] ata: allow subsystem to be used on m68k arch
Date: Fri, 30 Dec 2016 15:01:16 +0100
Message-ID: <1483106478-1382-2-git-send-email-b.zolnierkie@samsung.com>
References: <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20161230140141epcas5p161d9467e10e294f502863b5347e351d5@epcas5p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Michael Schmitz <schmitzmic@gmail.com>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-ide@vger.kernel.org

When libata was merged m68k lacked IOMAP support.  This has not been
true for a long time now so allow subsystem to be used on m68k.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 2c8be74..da19fc9 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -14,7 +14,7 @@ menuconfig ATA
 	tristate "Serial ATA and Parallel ATA drivers (libata)"
 	depends on HAS_IOMEM
 	depends on BLOCK
-	depends on !(M32R || M68K || S390) || BROKEN
+	depends on !(M32R || S390) || BROKEN
 	select SCSI
 	select GLOB
 	---help---
-- 
1.9.1
