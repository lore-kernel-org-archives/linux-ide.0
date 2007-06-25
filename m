From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2.6.22-rc5] libata: add HTS541616J9SA00 to NCQ blacklist
Date: Mon, 25 Jun 2007 11:28:59 +0900
Message-ID: <467F286B.40607@gmail.com>
References: <fa.sspu6LOivd/touNtS2IsMKPqHa0@ifi.uio.no> <fa.19XJG1Asdp1zwcWLxolIH6F+5lY@ifi.uio.no> <467EC909.9040006@shaw.ca> <467F2495.3080509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754312AbXFYC3W@vger.kernel.org>
In-Reply-To: <467F2495.3080509@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Robert Hancock <hancockr@shaw.ca>, Andrew Morton <akpm@linux-foundation.org>, enricoss@tiscali.it, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
List-Id: linux-ide@vger.kernel.org

Another member of HTS5416* family doing spurious NCQ completion.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Enrico Sardi <enricoss@tiscali.it>
---
 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index adfae9d..fbca8d8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3803,6 +3803,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* Drives which do spurious command completion */
 	{ "HTS541680J9SA00",	"SB2IC7EP",	ATA_HORKAGE_NONCQ, },
 	{ "HTS541612J9SA00",	"SBDIC7JP",	ATA_HORKAGE_NONCQ, },
+	{ "Hitachi HTS541616J9SA00", "SB4OC70P", ATA_HORKAGE_NONCQ, },
 	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ, },
 
 	/* Devices with NCQ limits */
