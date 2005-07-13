From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Add SanDisk ConnectPlus to the device table
Date: Wed, 13 Jul 2005 16:33:57 -0400
Message-ID: <1121286837.2763.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:46003
	"HELO roinet.com") by vger.kernel.org with SMTP id S262792AbVGMUeD
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Jul 2005 16:34:03 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: pcmcia <linux-pcmcia@lists.infradead.org>, linux-ide@vger.kernel.org

Hello!

Sorry for cross-post, not sure who should apply this patch.

SanDisk ConnectPlus has two functions.  Function 0 is prism2 card,
currently only supported by HostAP (not in the kernel).  Function 1 is
128M flash, supported by ide-cs.  This patch adds an entry for function
1 to ide-cs.c.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -481,6 +481,7 @@ static struct pcmcia_device_id ide_ids[]
 	PCMCIA_DEVICE_PROD_ID12("TOSHIBA", "MK2001MPL", 0xb4585a1a, 0x3489e003),
 	PCMCIA_DEVICE_PROD_ID12("WIT", "IDE16", 0x244e5994, 0x3e232852),
 	PCMCIA_DEVICE_PROD_ID1("STI Flash", 0xe4a13209),
+	PCMCIA_MFC_DEVICE_PROD_ID12(1, "SanDisk", "ConnectPlus", 0x7a954bd9, 0x74be00c6),
 	PCMCIA_DEVICE_NULL,
 };
 MODULE_DEVICE_TABLE(pcmcia, ide_ids);


-- 
Regards,
Pavel Roskin

