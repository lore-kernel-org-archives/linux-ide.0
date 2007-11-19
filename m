From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: port enable for the first SATA controller of
	ICH8 is 0xf not 0x3
Date: Mon, 19 Nov 2007 13:17:31 +0900
Message-ID: <20071119041731.GC30919@htj.mynetwork.cxm>
References: <20071119041459.GA30919@htj.mynetwork.cxm> <20071119041600.GB30919@htj.mynetwork.cxm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:58284 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975AbXKSERh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 23:17:37 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1835192wah
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 20:17:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20071119041600.GB30919@htj.mynetwork.cxm>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
Cc: tr@tng.de

ICH8 and 9 use two SFF controllers to show 6 SATA ports.  The first
controllre hosts the first 4 ports while the second one hosts the last
2.  The PCS register of the first controller encompasses the first
four ports or all six ports depending on configuration while PCS of
the second controller controls the last two ports.  Using 0xf for the
first controller and 0x3 for the second controller always result in
the correct configuration.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
applied to #tj-upstream-fixes

 drivers/ata/ata_piix.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index d5ff1d8..671e796 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -430,7 +430,7 @@ static const struct piix_map_db ich6m_map_db = {
 
 static const struct piix_map_db ich8_map_db = {
 	.mask = 0x3,
-	.port_enable = 0x3,
+	.port_enable = 0xf,
 	.map = {
 		/* PM   PS   SM   SS       MAP */
 		{  P0,  P2,  P1,  P3 }, /* 00b (hardwired when in AHCI) */
-- 
1.5.2.4

