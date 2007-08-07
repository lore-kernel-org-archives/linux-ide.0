From: Greg KH <gregkh@suse.de>
Subject: [2.6.22.2 review 67/84] libata: add FUJITSU MHV2080BH to NCQ
	blacklist
Date: Tue, 7 Aug 2007 13:48:29 -0700
Message-ID: <20070807204829.GQ23028@kroah.com>
References: <20070807204034.882009319@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:59835 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965044AbXHGU4H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 16:56:07 -0400
Content-Disposition: inline; filename="libata-add-fujitsu-mhv2080bh-to-ncq-blacklist.patch"
In-Reply-To: <20070807204157.GA23028@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@kernel.org, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Serge van Thillo <nulleke@hotmail.com>
Cc: Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Michael Krufky <mkrufky@linuxtv.org>, Chuck Ebbert <cebbert@redhat.com>, Domenico Andreoli <cavokz@gmail.com>, torvalds@linux-foundation.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, Tejun Heo <htejun@gmail.com>

From: Tejun Heo <htejun@gmail.com>

Please warmly welcome the first member from FUJITSU to the prestigious
NCQ spurious completion club.

This is reported by Serge Van Thillo in bugzilla bug 8730.

  http://bugzilla.kernel.org/show_bug.cgi?id=8730

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Serge van Thillo <nulleke@hotmail.com>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3800,6 +3800,7 @@ static const struct ata_blacklist_entry 
 	{ "HTS541612J9SA00",	"SBDIC7JP",	ATA_HORKAGE_NONCQ, },
 	{ "Hitachi HTS541616J9SA00", "SB4OC70P", ATA_HORKAGE_NONCQ, },
 	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ, },
+	{ "FUJITSU MHV2080BH",	"00840028",	ATA_HORKAGE_NONCQ, },
 
 	/* Devices with NCQ limits */
 

-- 
