From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 1/8] pcmcia: Add an id to ide-cs.c
Date: Sun, 19 Nov 2006 11:38:51 -0500
Message-ID: <20061119163851.GB2924@dominikbrodowski.de>
References: <20061119163427.GA2924@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.239.214.66]:3264 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1756774AbWKSQpT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Nov 2006 11:45:19 -0500
Content-Disposition: inline
In-Reply-To: <20061119163427.GA2924@dominikbrodowski.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-pcmcia@lists.infradead.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk


From: Matt Reimer <mattjreimer@gmail.com>
Date: Thu, 26 Oct 2006 15:56:00 -0700
Subject: [PATCH] pcmcia: Add an id to ide-cs.c

Add an ID entry for:

product info: "TRANSCEND", "TS1GCF80", "", ""
manfid: 0x000a, 0x0000
function: 4 (fixed disk)

Signed-off-by: Matt Reimer <mreimer@vpop.net>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/ata/pata_pcmcia.c   |    1 +
 drivers/ide/legacy/ide-cs.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index e93ea27..e587e73 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -356,6 +356,7 @@ static struct pcmcia_device_id pcmcia_de
 	PCMCIA_DEVICE_PROD_ID12("SMI VENDOR", "SMI PRODUCT", 0x30896c92, 0x703cc5f6),
 	PCMCIA_DEVICE_PROD_ID12("TOSHIBA", "MK2001MPL", 0xb4585a1a, 0x3489e003),
 	PCMCIA_DEVICE_PROD_ID1("TRANSCEND    512M   ", 0xd0909443),
+	PCMCIA_DEVICE_PROD_ID12("TRANSCEND", "TS1GCF80", 0x709b1bf1, 0x2a54d4b1),
 	PCMCIA_DEVICE_PROD_ID12("TRANSCEND", "TS4GCF120", 0x709b1bf1, 0xf54a91c8),
 	PCMCIA_DEVICE_PROD_ID12("WIT", "IDE16", 0x244e5994, 0x3e232852),
 	PCMCIA_DEVICE_PROD_ID1("STI Flash", 0xe4a13209),
diff --git a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
index bef4759..8b04ed4 100644
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -408,6 +408,7 @@ static struct pcmcia_device_id ide_ids[]
 	PCMCIA_DEVICE_PROD_ID12("SMI VENDOR", "SMI PRODUCT", 0x30896c92, 0x703cc5f6),
 	PCMCIA_DEVICE_PROD_ID12("TOSHIBA", "MK2001MPL", 0xb4585a1a, 0x3489e003),
 	PCMCIA_DEVICE_PROD_ID1("TRANSCEND    512M   ", 0xd0909443),
+	PCMCIA_DEVICE_PROD_ID12("TRANSCEND", "TS1GCF80", 0x709b1bf1, 0x2a54d4b1),
 	PCMCIA_DEVICE_PROD_ID12("TRANSCEND", "TS4GCF120", 0x709b1bf1, 0xf54a91c8),
 	PCMCIA_DEVICE_PROD_ID12("WIT", "IDE16", 0x244e5994, 0x3e232852),
 	PCMCIA_DEVICE_PROD_ID1("STI Flash", 0xe4a13209),
-- 
1.4.4

