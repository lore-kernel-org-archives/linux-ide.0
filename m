From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] libata: Blacklist queued TRIM on all Samsung 800-series
Date: Mon,  4 May 2015 12:20:29 -0400
Message-ID: <1430756429-2258-1-git-send-email-martin.petersen@oracle.com>
References: <mi84f3@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:35354 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbbEDQUl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 May 2015 12:20:41 -0400
In-Reply-To: <mi84f3@ger.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org
Cc: g.wal@web.de, sven.koehler@gmail.com, "Martin K. Petersen" <martin.petersen@oracle.com>, stable@vger.kernel.org

The queued TRIM problems appear to be generic to Samsung's firmware and
not tied to a particular model. A recent update to the 840 EVO firmware
introduced the same issue as we saw on 850 Pro.

Blacklist queued TRIM on all 800-series drives while we work this issue
with Samsung.

Reported-by: G=C3=BCnter Waller <g.wal@web.de>
Reported-by: Sven K=C3=B6hler <sven.koehler@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: stable@vger.kernel.org
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f6cb1f1b30b7..4476fb590733 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4235,7 +4235,7 @@ static const struct ata_blacklist_entry ata_devic=
e_blacklist [] =3D {
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Crucial_CT*MX100*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
-	{ "Samsung SSD 850 PRO*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+	{ "Samsung SSD 8*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
=20
 	/*
--=20
1.9.3

