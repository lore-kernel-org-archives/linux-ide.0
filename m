From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 14/40] libata: sync NCQ blacklist with upstream
Date: Wed, 14 Nov 2007 22:44:38 -0800
Message-ID: <20071115064438.GO19218@kroah.com>
References: <20071115062710.885284510@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:57950 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932184AbXKOGrK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Nov 2007 01:47:10 -0500
Content-Disposition: inline; filename="libata-sync-ncq-blacklist-with-upstream.patch"
In-Reply-To: <20071115064302.GA19218@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@kernel.org, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Michael Krufky <mkrufky@linuxtv.org>, Chuck Ebbert <cebbert@redhat.com>, Domenico Andreoli <cavokz@gmail.com>, torvalds@linux-foundation.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, Tejun Heo <htejun@gmail.com>


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Tejun Heo <htejun@gmail.com>

Synchronize NCQ blacklist with the current upstream.  Based on changes
already in Linus's 2.6.24-rc kernel tree.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/ata/libata-core.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3793,11 +3793,17 @@ static const struct ata_blacklist_entry 
 	/* Drives which do spurious command completion */
 	{ "HTS541680J9SA00",	"SB2IC7EP",	ATA_HORKAGE_NONCQ, },
 	{ "HTS541612J9SA00",	"SBDIC7JP",	ATA_HORKAGE_NONCQ, },
+	{ "HDT722516DLA380",	"V43OA96A",	ATA_HORKAGE_NONCQ, },
 	{ "Hitachi HTS541616J9SA00", "SB4OC70P", ATA_HORKAGE_NONCQ, },
 	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ, },
+	{ "WDC WD3200AAJS-00RYA0", "12.01B01",	ATA_HORKAGE_NONCQ, },
 	{ "FUJITSU MHV2080BH",	"00840028",	ATA_HORKAGE_NONCQ, },
+	{ "ST9120822AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
 	{ "ST9160821AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
-	{ "ST3160812AS",	"3.AD",		ATA_HORKAGE_NONCQ, },
+	{ "ST9160821AS",	"3.ALD",	ATA_HORKAGE_NONCQ, },
+	{ "ST9160821AS",	"3.CCD",	ATA_HORKAGE_NONCQ, },
+	{ "ST3160812AS",	"3.ADJ",	ATA_HORKAGE_NONCQ, },
+	{ "ST980813AS",		"3.ADB",	ATA_HORKAGE_NONCQ, },
 	{ "SAMSUNG HD401LJ",	"ZZ100-15",	ATA_HORKAGE_NONCQ, },
 
 	/* devices which puke on READ_NATIVE_MAX */

-- 
