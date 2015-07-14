From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: add ATA_HORKAGE_BROKEN_FPDMA_AA quirk for HP
 250GB SATA disk VB0250EAVER
Date: Tue, 14 Jul 2015 17:59:03 -0400
Message-ID: <20150714215903.GJ2273@mtj.duckdns.org>
References: <1435747710-3270-1-git-send-email-mamlinav@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435747710-3270-1-git-send-email-mamlinav@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksei Mamlin <mamlinav@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello,

Applied to libata/for-4.2-fixes with minor updates.

Thanks.
----- 8< -----
>From 08c85d2a599d967ede38a847f5594447b6100642 Mon Sep 17 00:00:00 2001
From: Aleksei Mamlin <mamlinav@gmail.com>
Date: Wed, 1 Jul 2015 13:48:30 +0300

Enabling AA on HP 250GB SATA disk VB0250EAVER causes errors:

[    3.788362] ata3.00: failed to enable AA (error_mask=0x1)
[    3.789243] ata3.00: failed to enable AA (error_mask=0x1)

Add the ATA_HORKAGE_BROKEN_FPDMA_AA for this specific harddisk.

tj: Collected FPDMA_AA entries and updated comment.

Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/ata/libata-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e83fc3d..58a6db8f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4174,9 +4174,10 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "ST3320[68]13AS",	"SD1[5-9]",	ATA_HORKAGE_NONCQ |
 						ATA_HORKAGE_FIRMWARE_WARN },
 
-	/* Seagate Momentus SpinPoint M8 seem to have FPMDA_AA issues */
+	/* drives which fail FPDMA_AA activation (some may freeze afterwards) */
 	{ "ST1000LM024 HN-M101MBB", "2AR10001",	ATA_HORKAGE_BROKEN_FPDMA_AA },
 	{ "ST1000LM024 HN-M101MBB", "2BA30001",	ATA_HORKAGE_BROKEN_FPDMA_AA },
+	{ "VB0250EAVER",	"HPG7",		ATA_HORKAGE_BROKEN_FPDMA_AA },
 
 	/* Blacklist entries taken from Silicon Image 3124/3132
 	   Windows driver .inf file - also several Linux problem reports */
-- 
2.4.3
