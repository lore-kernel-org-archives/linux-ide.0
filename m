From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ata.h: Don't do a SATA check for 40wire_relaxed
Date: Mon, 19 Nov 2007 15:24:34 +0000
Message-ID: <20071119152434.45363e5d@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53327 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753623AbXKSP0W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 10:26:22 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

Without the valid bits at least one set of TSScorp drives report 0 in
word 93 for PATA 40 wire, which we (and the specs) say actually means
SATA. (The SATA version seems to report 80 wire...)

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc2-mm1/include/linux/ata.h linux-2.6.24-rc2-mm1/include/linux/ata.h
--- linux.vanilla-2.6.24-rc2-mm1/include/linux/ata.h	2007-11-16 17:55:20.000000000 +0000
+++ linux-2.6.24-rc2-mm1/include/linux/ata.h	2007-11-16 18:42:20.000000000 +0000
@@ -560,8 +560,6 @@
 
 static inline int ata_drive_40wire_relaxed(const u16 *dev_id)
 {
-	if (ata_id_is_sata(dev_id))
-		return 0;	/* SATA */
 	if ((dev_id[93] & 0x2000) == 0x2000)
 		return 0;	/* 80 wire */
 	return 1;
