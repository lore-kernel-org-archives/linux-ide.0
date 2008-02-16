From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH 5/11v2] ata: replace macro with static inline in
	libata.h
Date: Fri, 15 Feb 2008 16:36:47 -0800
Message-ID: <1203122207.7442.8.camel@brick>
References: <1203113215.15275.53.camel@brick> <20080215223036.2111edd5@core>
	 <1203115574.30938.6.camel@brick> <20080215225339.0e2ed4e6@core>
	 <1203116930.30938.12.camel@brick>  <20080216000557.6f6e9588@core>
	 <1203121391.7442.6.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:26544 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbYBPAg6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Feb 2008 19:36:58 -0500
Received: by py-out-1112.google.com with SMTP id u52so1086675pyb.10
        for <linux-ide@vger.kernel.org>; Fri, 15 Feb 2008 16:36:55 -0800 (PST)
In-Reply-To: <1203121391.7442.6.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 3/3] ata: simplify clock divisor logic in pata_amd.c

Current code is essentially choosing between dividing by 1 or
dividing by two, make the conditions a little more obvious.

As a bonus, removes a sparse error:
drivers/ata/pata_amd.c:59:11: warning: symbol '__x' shadows an earlier one
drivers/ata/pata_amd.c:59:11: originally declared here

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
Thought I'd follow up with just what the 3/3 patch I referenced was.

 drivers/ata/pata_amd.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 4b8d9b5..7ef4847 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -56,7 +56,9 @@ static void timing_setup(struct ata_port *ap, struct ata_device *adev, int offse
 	u8 t;
 
 	T = 1000000000 / amd_clock;
-	UT = T / min_t(int, max_t(int, clock, 1), 2);
+	UT = T;
+	if (clock >= 2)
+		UT = T / 2;
 
 	if (ata_timing_compute(adev, speed, &at, T, UT) < 0) {
 		dev_printk(KERN_ERR, &pdev->dev, "unknown mode %d.\n", speed);
-- 
1.5.4.1.1278.gc75be



