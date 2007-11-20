From: "Konstantin A. Lepikhov" <lakostis@unsafe.ru>
Subject: [PATCH] libata: blacklist TOSHIBA MK1637GSX
Date: Tue, 20 Nov 2007 10:12:08 +0300
Message-ID: <20071120071208.GB13851@lks.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mojo.unsafe.ru ([83.222.2.183]:2321 "EHLO mojo.unsafe.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751714AbXKTHfM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Nov 2007 02:35:12 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

TOSHIBA MK1637GSX do spurious command completion

More details can be found in
http://bugzilla.kernel.org/show_bug.cgi?id=9410

-- 
WBR et al.

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="libata-core-blacklist.patch"

>From 9aca07148a192ece4c6fe085148b3cfb7390d367 Mon Sep 17 00:00:00 2001
From: Konstantin A. Lepikhov <lakostis@altlinux.ru>
Date: Mon, 19 Nov 2007 23:56:25 +0300
Subject: [PATCH] libata: Another one in spurious command completion list:

ata1.00: exception Emask 0x2 SAct 0x1 SErr 0x0 action 0x2 frozen
ata1.00: spurious completions during NCQ issue=0x0 SAct=0x1 FIS=004040a1:00000020
ata1.00: cmd 60/70:00:83:a6:f0/00:00:04:00:00/40 tag 0 cdb 0x0 data 57344 in

Device Model:     TOSHIBA MK1637GSX
Serial Number:    77VBT1CRT
Firmware Version: DL040D

Blacklist it.

Signed-off-by: Konstantin A. Lepikhov <lakostis@altlinux.ru>
Acked-by: Pavlov Konstantin <thresh@altlinux.ru>
---
 drivers/ata/libata-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8189803..0e9cd14 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4236,6 +4236,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "ST980813AS",		"3.ADB",	ATA_HORKAGE_NONCQ, },
 	{ "SAMSUNG HD401LJ",	"ZZ100-15",	ATA_HORKAGE_NONCQ, },
 	{ "Maxtor 7V300F0",	"VA111900",	ATA_HORKAGE_NONCQ, },
+	{ "TOSHIBA MK1637GSX",	"DL040D",	ATA_HORKAGE_NONCQ, },
 
 	/* devices which puke on READ_NATIVE_MAX */
 	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_HORKAGE_BROKEN_HPA, },
-- 
1.5.3.5.GIT


--qMm9M+Fa2AknHoGS--
