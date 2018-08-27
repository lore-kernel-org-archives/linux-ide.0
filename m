From: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] MAINTAINERS: libata pata: fix Jens Axboe's email address
Date: Mon, 27 Aug 2018 07:29:35 +0300
Message-ID: <d99162f25e4860bb04f1f56f031d11ceab1fc725.1535344175.git.baruch@tkos.co.il>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>
List-Id: linux-ide@vger.kernel.org

Commit 7634ccd2da (libata: maintainership update) added an invalid email
address. Fix that.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..9ae5cdef37a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8255,7 +8255,7 @@ F:	drivers/ata/pata_arasan_cf.c
 
 LIBATA PATA DRIVERS
 M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
-M:	Jens Axboe <kernel.dk>
+M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-ide@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git
 S:	Maintained
-- 
2.18.0
