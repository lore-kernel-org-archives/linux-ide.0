From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ide: hpt366: mark expected switch fall-throughs
Date: Tue, 12 Feb 2019 15:46:51 -0600
Message-ID: <20190212214651.GA7476@embeddedor>
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

drivers/ide/hpt366.c: In function ‘hpt3xx_udma_filter’:
drivers/ide/hpt366.c:574:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (!HPT370_ALLOW_ATA100_5 ||
      ^
drivers/ide/hpt366.c:578:2: note: here
  case HPT372 :
  ^~~~
drivers/ide/hpt366.c: In function ‘hpt3xx_mdma_filter’:
drivers/ide/hpt366.c:602:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (ata_id_is_sata(drive->id))
      ^
drivers/ide/hpt366.c:605:2: note: here
  default:
  ^~~~~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/ide/hpt366.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/hpt366.c b/drivers/ide/hpt366.c
index 4d565b0c5a6e..0a3f9bcc8b04 100644
--- a/drivers/ide/hpt366.c
+++ b/drivers/ide/hpt366.c
@@ -574,7 +574,7 @@ static u8 hpt3xx_udma_filter(ide_drive_t *drive)
 		if (!HPT370_ALLOW_ATA100_5 ||
 		    check_in_drive_list(drive, bad_ata100_5))
 			return ATA_UDMA4;
-		/* else: fall through */
+		/* fall through */
 	case HPT372 :
 	case HPT372A:
 	case HPT372N:
@@ -601,7 +601,7 @@ static u8 hpt3xx_mdma_filter(ide_drive_t *drive)
 	case HPT374 :
 		if (ata_id_is_sata(drive->id))
 			return 0x00;
-		/* else: fall through */
+		/* fall through */
 	default:
 		return 0x07;
 	}
-- 
2.20.1
