From: Daeseok Youn <daeseok.youn@gmail.com>
Subject: [PATCH v2] ata: libahci: make ahci_pmp_retry_softreset() as static
Date: Thu, 20 Feb 2014 08:34:27 +0900
Message-ID: <1784085.43ZIZYgGND@daeseok-laptop.cloud.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:49381 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbaBSXed (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Feb 2014 18:34:33 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net, tj@kernel.org
Cc: sergei.shtylyov@cogentembedded.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

>From 6f865fde2e48ddc09f940ec30ebfc144cf074fd1 Mon Sep 17 00:00:00 2001
From: Daeseok Youn <daeseok.youn@gmail.com>
Date: Wed, 19 Feb 2014 10:56:37 +0900
Subject: [PATCH] ata: libahci: make ahci_pmp_retry_softreset() as static

sparse says:

drivers/ata/libahci.c:1390:5: warning:
 symbol 'ahci_pmp_retry_softreset' was not declared. Should it be static?

Signed-off-by: Daeseok Youn <daeseok.youn@gmail.com>
---
 drivers/ata/libahci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 36605ab..4789950 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1387,8 +1387,8 @@ static int ahci_bad_pmp_check_ready(struct ata_link *link)
 	return ata_check_ready(status);
 }
 
-int ahci_pmp_retry_softreset(struct ata_link *link, unsigned int *class,
-				unsigned long deadline)
+static int ahci_pmp_retry_softreset(struct ata_link *link, unsigned int *class,
+				    unsigned long deadline)
 {
 	struct ata_port *ap = link->ap;
 	void __iomem *port_mmio = ahci_port_base(ap);
-- 
1.7.9.5

---
