From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 2/8] pcmcia: yet another IDE ID
Date: Sun, 19 Nov 2006 11:39:23 -0500
Message-ID: <20061119163923.GC2924@dominikbrodowski.de>
References: <20061119163427.GA2924@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.239.214.66]:63167 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1756767AbWKSQpR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Nov 2006 11:45:17 -0500
Content-Disposition: inline
In-Reply-To: <20061119163427.GA2924@dominikbrodowski.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-pcmcia@lists.infradead.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk


From: Marcin Juszkiewicz <openembedded@hrw.one.pl>
Date: Mon, 30 Oct 2006 22:28:09 +0100
Subject: [PATCH] pcmcia: yet another IDE ID

Microdrive reported by one of OpenEmbedded developers.

product info: "WEIDA", "TWTTI", ""
manfid: 0x000a, 0x0000
function: 4 (fixed disk)

(equivalent update to pata_pcmcia.c by Dominik Brodowski)

Signed-off-by: Marcin Juszkiewicz <openembedded@hrw.one.pl>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/ata/pata_pcmcia.c   |    1 +
 drivers/ide/legacy/ide-cs.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index e587e73..03f77f3 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -359,6 +359,7 @@ static struct pcmcia_device_id pcmcia_de
 	PCMCIA_DEVICE_PROD_ID12("TRANSCEND", "TS1GCF80", 0x709b1bf1, 0x2a54d4b1),
 	PCMCIA_DEVICE_PROD_ID12("TRANSCEND", "TS4GCF120", 0x709b1bf1, 0xf54a91c8),
 	PCMCIA_DEVICE_PROD_ID12("WIT", "IDE16", 0x244e5994, 0x3e232852),
+	PCMCIA_DEVICE_PROD_ID12("WEIDA", "TWTTI", 0xcc7cf69c, 0x212bb918),
 	PCMCIA_DEVICE_PROD_ID1("STI Flash", 0xe4a13209),
 	PCMCIA_DEVICE_PROD_ID12("STI", "Flash 5.0", 0xbf2df18d, 0x8cb57a0e),
 	PCMCIA_MFC_DEVICE_PROD_ID12(1, "SanDisk", "ConnectPlus", 0x7a954bd9, 0x74be00c6),
diff --git a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
index 8b04ed4..7e8d778 100644
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -411,6 +411,7 @@ static struct pcmcia_device_id ide_ids[]
 	PCMCIA_DEVICE_PROD_ID12("TRANSCEND", "TS1GCF80", 0x709b1bf1, 0x2a54d4b1),
 	PCMCIA_DEVICE_PROD_ID12("TRANSCEND", "TS4GCF120", 0x709b1bf1, 0xf54a91c8),
 	PCMCIA_DEVICE_PROD_ID12("WIT", "IDE16", 0x244e5994, 0x3e232852),
+	PCMCIA_DEVICE_PROD_ID12("WEIDA", "TWTTI", 0xcc7cf69c, 0x212bb918),
 	PCMCIA_DEVICE_PROD_ID1("STI Flash", 0xe4a13209),
 	PCMCIA_DEVICE_PROD_ID12("STI", "Flash 5.0", 0xbf2df18d, 0x8cb57a0e),
 	PCMCIA_MFC_DEVICE_PROD_ID12(1, "SanDisk", "ConnectPlus", 0x7a954bd9, 0x74be00c6),
-- 
1.4.4

