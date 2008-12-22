From: =?UTF-8?B?THVib23DrXIgQnVsZWo=?= <lubomir.bulej@dsrg.mff.cuni.cz>
Subject: [PATCH] libata: blacklist NCQ on OCZ CORE 2 SSD (resend)
Date: Mon, 22 Dec 2008 11:35:22 +0100
Message-ID: <494F6D6A.2010406@dsrg.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dsrg.mff.cuni.cz ([195.113.20.55]:56787 "EHLO dsrg.mff.cuni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991AbYLVKfT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Dec 2008 05:35:19 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org


The patchlet below blacklists NCQ on OCZ CORE v2 SSD drive(s). Even though the 
drive advertises NCQ support with queue depth 1, it responds with all-zeroes 
FIS to NCQ commands which triggers ata error handling several times before the 
kernel decides to disable NCQ on the drive.


signed-off-by: Lubomir Bulej <lubomir.bulej@dsrg.mff.cuni.cz>


diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5e2eb74..ba38eb8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4048,6 +4048,7 @@ static const struct ata_blacklist_entry 
ata_device_blacklist [] = {
  	{ "Maxtor 7V300F0",	"VA111630",	ATA_HORKAGE_NONCQ },
  	{ "ST380817AS",		"3.42",		ATA_HORKAGE_NONCQ },
  	{ "ST3160023AS",	"3.42",		ATA_HORKAGE_NONCQ },
+	{ "OCZ CORE_SSD",	"02.10104",	ATA_HORKAGE_NONCQ },

  	/* Seagate NCQ + FLUSH CACHE firmware bug */
  	{ "ST31500341AS",	"9JU138",	ATA_HORKAGE_NONCQ |
