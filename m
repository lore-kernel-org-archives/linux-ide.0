From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ata_timing: ensure t->cycle is always correct
Date: Mon, 23 Apr 2007 11:55:36 +0100
Message-ID: <20070423115536.38a7e43c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39349 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161368AbXDWKwF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Apr 2007 06:52:05 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com


Russell King hit a case where quantisation errors accumulated such that
the cycle time was shorter than rather than equal to the active/recovery
time. The code already knows how to stretch times to fit the cycle time
but does not know about the reverse. 

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc6-mm1/drivers/ata/libata-core.c linux-2.6.21-rc6-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.21-rc6-mm1/drivers/ata/libata-core.c	2007-04-12 14:15:03.000000000 +0100
+++ linux-2.6.21-rc6-mm1/drivers/ata/libata-core.c	2007-04-23 10:47:49.543967256 +0100
@@ -2405,6 +2619,12 @@
 		t->active += (t->cycle - (t->active + t->recover)) / 2;
 		t->recover = t->cycle - t->active;
 	}
+	
+	/* In a few cases quantisation may produce enough errors to
+	   leave t->cycle too low for the sum of active and recovery
+	   if so we must correct this */
+	if (t->active + t->recover > t->cycle)
+		t->cycle = t->active + t->recover;
 
 	return 0;
 }
