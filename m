From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ata: fix spelling mistake: "directon" -> "direction"
Date: Sun, 29 Apr 2018 13:01:11 +0100
Message-ID: <20180429120111.9948-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in sil24_cerr_info message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/ata/sata_sil24.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 4b1995e2d044..010ca101d412 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -285,13 +285,13 @@ static const struct sil24_cerr_info {
 	[PORT_CERR_INCONSISTENT] = { AC_ERR_HSM, ATA_EH_RESET,
 				     "protocol mismatch" },
 	[PORT_CERR_DIRECTION]	= { AC_ERR_HSM, ATA_EH_RESET,
-				    "data directon mismatch" },
+				    "data direction mismatch" },
 	[PORT_CERR_UNDERRUN]	= { AC_ERR_HSM, ATA_EH_RESET,
 				    "ran out of SGEs while writing" },
 	[PORT_CERR_OVERRUN]	= { AC_ERR_HSM, ATA_EH_RESET,
 				    "ran out of SGEs while reading" },
 	[PORT_CERR_PKT_PROT]	= { AC_ERR_HSM, ATA_EH_RESET,
-				    "invalid data directon for ATAPI CDB" },
+				    "invalid data direction for ATAPI CDB" },
 	[PORT_CERR_SGT_BOUNDARY] = { AC_ERR_SYSTEM, ATA_EH_RESET,
 				     "SGT not on qword boundary" },
 	[PORT_CERR_SGT_TGTABRT]	= { AC_ERR_HOST_BUS, ATA_EH_RESET,
-- 
2.17.0
