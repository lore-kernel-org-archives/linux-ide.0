From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ide: hpt366: mark expected switch fall-throughs
Date: Thu, 10 Jan 2019 10:34:23 -0600
Message-ID: <20190110163423.GA17072@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-ide@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that, in this particular case, I removed the "else: "
part from the comment. As we are now using Warning level 3:
-Wimplicit-fallthrough=3, this is what GCC is expecting to
find.

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
