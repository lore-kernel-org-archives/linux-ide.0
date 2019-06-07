From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: [PATCH] drivers/ata: remove flood "Enabling discard_zeroes_data"
Date: Fri, 07 Jun 2019 10:34:29 +0300
Message-ID: <155989286981.1471.16344793966539115439.stgit@buzz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
List-Id: linux-ide@vger.kernel.org

Printing this at each SCSI READ_CAPACITY command is too verbose.

Flag "discard_zeroes_data" is deprecated since commit 48920ff2a5a9
("block: remove the discard_zeroes_data flag").

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 drivers/ata/libata-scsi.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 391ac0503dc0..a475e94944b7 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2735,10 +2735,8 @@ static unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf)
 			rbuf[14] |= 0x80; /* LBPME */
 
 			if (ata_id_has_zero_after_trim(args->id) &&
-			    dev->horkage & ATA_HORKAGE_ZERO_AFTER_TRIM) {
-				ata_dev_info(dev, "Enabling discard_zeroes_data\n");
+			    dev->horkage & ATA_HORKAGE_ZERO_AFTER_TRIM)
 				rbuf[14] |= 0x40; /* LBPRZ */
-			}
 		}
 		if (ata_id_zoned_cap(args->id) ||
 		    args->dev->class == ATA_DEV_ZAC)
