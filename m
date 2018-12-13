From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 12/16] libata: whitelist all SAMSUNG MZ7KM* solid-state disks
Date: Wed, 12 Dec 2018 23:33:39 -0500
Message-ID: <20181213043343.76896-12-sashal@kernel.org>
References: <20181213043343.76896-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213043343.76896-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Juha-Matti Tilli <juha-matti.tilli@iki.fi>, Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Juha-Matti Tilli <juha-matti.tilli@iki.fi>

[ Upstream commit fd6f32f78645db32b6b95a42e45da2ddd6de0e67 ]

These devices support read zero after trim (RZAT), as they advertise to
the OS. However, the OS doesn't believe the SSDs unless they are
explicitly whitelisted.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6629a5deccbd..e155998e4696 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4295,6 +4295,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "SSD*INTEL*",			NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Samsung*SSD*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "SAMSUNG*SSD*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "SAMSUNG*MZ7KM*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "ST[1248][0248]0[FH]*",	NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
 
 	/* devices that don't properly handle TRIM commands */
-- 
2.19.1
