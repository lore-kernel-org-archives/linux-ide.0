From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] MAINTAINERS: Fix remaining pointers to obsolete libata.git
Date: Wed,  7 Nov 2018 10:47:57 +0100
Message-ID: <20181107094757.31210-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Mikael Pettersson <mikpelinux@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-ide@vger.kernel.org

libata.git no longer exists.  Replace the remaining pointers to it by
pointers to the block tree, which is where all libata development
happens now.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 662208773a68f374..1c8adcb3a2fe4ffa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8383,7 +8383,7 @@ F:	drivers/media/dvb-frontends/lgdt3305.*
 LIBATA PATA ARASAN COMPACT FLASH CONTROLLER
 M:	Viresh Kumar <vireshk@kernel.org>
 L:	linux-ide@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
 S:	Maintained
 F:	include/linux/pata_arasan_cf_data.h
 F:	drivers/ata/pata_arasan_cf.c
@@ -8400,7 +8400,7 @@ F:	drivers/ata/ata_generic.c
 LIBATA PATA FARADAY FTIDE010 AND GEMINI SATA BRIDGE DRIVERS
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-ide@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
 S:	Maintained
 F:	drivers/ata/pata_ftide010.c
 F:	drivers/ata/sata_gemini.c
@@ -8419,7 +8419,7 @@ F:	include/linux/ahci_platform.h
 LIBATA SATA PROMISE TX2/TX4 CONTROLLER DRIVER
 M:	Mikael Pettersson <mikpelinux@gmail.com>
 L:	linux-ide@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
 S:	Maintained
 F:	drivers/ata/sata_promise.*
 
-- 
2.17.1
