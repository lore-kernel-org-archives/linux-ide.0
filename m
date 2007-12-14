From: akpm@linux-foundation.org
Subject: [patch 5/9] libata: add TOSHIBA MK1637GSX to spurious command completion list
Date: Thu, 13 Dec 2007 16:01:40 -0800
Message-ID: <200712140001.lBE01eOZ025438@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59180 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763219AbXLNABz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Dec 2007 19:01:55 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, lakostis@altlinux.org, htejun@gmail.com, lakostis@altlinux.ru, thresh@altlinux.ru

From: "Konstantin A. Lepikhov" <lakostis@altlinux.org>

ata1.00: exception Emask 0x2 SAct 0x1 SErr 0x0 action 0x2 frozen
ata1.00: spurious completions during NCQ issue=0x0 SAct=0x1 FIS=004040a1:00000020
ata1.00: cmd 60/70:00:83:a6:f0/00:00:04:00:00/40 tag 0 cdb 0x0 data 57344 in

Device Model:     TOSHIBA MK1637GSX
Serial Number:    77VBT1CRT
Firmware Version: DL040D

Blacklist it.

Addresses http://bugzilla.kernel.org/show_bug.cgi?id=9410

Signed-off-by: Konstantin A. Lepikhov <lakostis@altlinux.ru>
Acked-by: Pavlov Konstantin <thresh@altlinux.ru>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/ata/libata-core.c~libata-add-toshiba-mk1637gsx-to-spurious-command-completion-list drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c~libata-add-toshiba-mk1637gsx-to-spurious-command-completion-list
+++ a/drivers/ata/libata-core.c
@@ -4152,6 +4152,7 @@ static const struct ata_blacklist_entry 
 	/* NCQ is broken */
 	{ "Maxtor *",		"BANC*",	ATA_HORKAGE_NONCQ },
 	{ "Maxtor 7V300F0",	"VA111630",	ATA_HORKAGE_NONCQ },
+	{ "TOSHIBA MK1637GSX",	"DL040D",	ATA_HORKAGE_NONCQ, },
 	{ "HITACHI HDS7250SASUN500G*", NULL,    ATA_HORKAGE_NONCQ },
 	{ "HITACHI HDS7225SBSUN250G*", NULL,    ATA_HORKAGE_NONCQ },
 	{ "ST380817AS",		"3.42",		ATA_HORKAGE_NONCQ },
_
