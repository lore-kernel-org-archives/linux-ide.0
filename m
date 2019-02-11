From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ide: mark expected switch fall-through
Date: Mon, 11 Feb 2019 16:17:20 -0600
Message-ID: <20190211221720.GA5631@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Kees Cook <keescook@chromium.org>
List-Id: linux-ide@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

drivers/ide/ide-floppy.c: In function ‘ide_floppy_get_capacity’:
drivers/ide/ide-floppy.c:424:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (!(drive->atapi_flags & IDE_AFLAG_CLIK_DRIVE))
       ^
drivers/ide/ide-floppy.c:431:3: note: here
   case CAPACITY_CURRENT:
   ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/ide/ide-floppy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 780d33ccc5d8..1ea2f9e82bf8 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -427,7 +427,7 @@ static int ide_floppy_get_capacity(ide_drive_t *drive)
 				 * (maintains previous driver behaviour)
 				 */
 				break;
-			/* else: fall through */
+			/* fall through */
 		case CAPACITY_CURRENT:
 			/* Normal Zip/LS-120 disks */
 			if (memcmp(cap_desc, &floppy->cap_desc, 8))
-- 
2.20.1
