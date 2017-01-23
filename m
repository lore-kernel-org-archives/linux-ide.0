From: "tj@kernel.org" <tj@kernel.org>
Subject: [PATCH] pata_octeon_cf: remove unused local variables from
 octeon_cf_set_piomode()
Date: Mon, 23 Jan 2017 14:31:18 -0500
Message-ID: <20170123193118.GB7820@htj.duckdns.org>
References: <VI1PR08MB1022E4D2E06B02E7B6BFCB5E9C720@VI1PR08MB1022.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36290 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdAWTcQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jan 2017 14:32:16 -0500
Content-Disposition: inline
In-Reply-To: <VI1PR08MB1022E4D2E06B02E7B6BFCB5E9C720@VI1PR08MB1022.eurprd08.prod.outlook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Binderman <dcb314@hotmail.com>
Cc: "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

>From d786b91f422c6ad4c0d9bb9c1bef2dd5008e3d9d Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Mon, 23 Jan 2017 14:28:51 -0500

@t1 and @t2i are calculated along with @t2 but never used.  Drop them.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: David Binderman <dcb314@hotmail.com>
---
Applied to libata/for-4.11.  Thanks.

 drivers/ata/pata_octeon_cf.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index e94e7ca..f524a90 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -138,9 +138,7 @@ static void octeon_cf_set_piomode(struct ata_port *ap, struct ata_device *dev)
 	int trh;
 	int pause;
 	/* These names are timing parameters from the ATA spec */
-	int t1;
 	int t2;
-	int t2i;
 
 	/*
 	 * A divisor value of four will overflow the timing fields at
@@ -154,15 +152,9 @@ static void octeon_cf_set_piomode(struct ata_port *ap, struct ata_device *dev)
 
 	BUG_ON(ata_timing_compute(dev, dev->pio_mode, &timing, T, T));
 
-	t1 = timing.setup;
-	if (t1)
-		t1--;
 	t2 = timing.active;
 	if (t2)
 		t2--;
-	t2i = timing.act8b;
-	if (t2i)
-		t2i--;
 
 	trh = ns_to_tim_reg(div, 20);
 	if (trh)
-- 
2.9.3

