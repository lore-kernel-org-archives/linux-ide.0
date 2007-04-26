From: akpm@linux-foundation.org
Subject: [patch 10/10] ata_timing: ensure t->cycle is always correct
Date: Thu, 26 Apr 2007 00:19:28 -0700
Message-ID: <200704260719.l3Q7JSYQ023706@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:35373 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933267AbXDZHT4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Apr 2007 03:19:56 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, htejun@gmail.com, rmk@arm.linux.org.uk

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Russell King hit a case where quantisation errors accumulated such that the
cycle time was shorter than rather than equal to the active/recovery time. 
The code already knows how to stretch times to fit the cycle time but does
not know about the reverse.

Signed-off-by: Alan Cox <alan@redhat.com>
Cc: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-core.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff -puN drivers/ata/libata-core.c~ata_timing-ensure-t-cycle-is-always-correct drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c~ata_timing-ensure-t-cycle-is-always-correct
+++ a/drivers/ata/libata-core.c
@@ -2618,6 +2618,12 @@ int ata_timing_compute(struct ata_device
 		t->recover = t->cycle - t->active;
 	}
 
+	/* In a few cases quantisation may produce enough errors to
+	   leave t->cycle too low for the sum of active and recovery
+	   if so we must correct this */
+	if (t->active + t->recover > t->cycle)
+		t->cycle = t->active + t->recover;
+
 	return 0;
 }
 
_
