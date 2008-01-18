From: Chuck Short <zulcss@ubuntu.com>
Subject: [PATCH 2/7] ata: blacklist FUJITSU MHW2160BH PL
Date: Fri, 18 Jan 2008 13:21:16 -0500
Message-ID: <E1KKl4I-00068E-Ob@swissweb.swissdisk.com>
References: <24762.90.138.930.038.1036103001.ben.collins@canonical.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760400AbYGUEfy@vger.kernel.org>
In-Reply-To: <24762.90.138.930.038.1036103001.ben.collins@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Reference: https://launchpad.net/bugs/175834

CC: linux-ide@vger.kernel.org
Signed-off-by: Chuck Short <zulcss@ubuntu.com>
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
Signed-off-by: Ben Collins <ben.collins@canonical.com>
---
 drivers/ata/libata-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9bef1a8..2664082 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3935,6 +3935,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "HTS541060G9SA00",    "MB3OC60D",     ATA_HORKAGE_NONCQ, },
 	{ "HTS541080G9SA00",    "MB4OC60D",     ATA_HORKAGE_NONCQ, },
 	{ "HTS541010G9SA00",    "MBZOC60D",     ATA_HORKAGE_NONCQ, },
+	{ "FUJITSU MHW2160BH PL", "0084001E",   ATA_HORKAGE_NONCQ, },
 
 	/* devices which puke on READ_NATIVE_MAX */
 	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_HORKAGE_BROKEN_HPA, },
-- 
1.5.4.3
