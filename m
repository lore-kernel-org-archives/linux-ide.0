From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] RESEND #3 libata: Correct handling of TSS DVD
Date: Thu, 3 Jan 2008 17:14:12 +0000
Message-ID: <20080103171412.25b30f98@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57028 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751026AbYACRPz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jan 2008 12:15:55 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

Devices that misreport the validity bit for word 93 look like SATA. If
they are on the blacklist then we must not test for SATA but assume 40
wire in the 40 wire case (The TSSCorp reports 80 wire on SATA it seems!)

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc6-mm1/include/linux/ata.h linux-2.6.24-rc6-mm1/include/linux/ata.h
--- linux.vanilla-2.6.24-rc6-mm1/include/linux/ata.h	2008-01-02 16:04:25.000000000 +0000
+++ linux-2.6.24-rc6-mm1/include/linux/ata.h	2008-01-02 16:18:56.000000000 +0000
@@ -639,8 +639,6 @@
 
 static inline int ata_drive_40wire_relaxed(const u16 *dev_id)
 {
-	if (ata_id_is_sata(dev_id))
-		return 0;	/* SATA */
 	if ((dev_id[93] & 0x2000) == 0x2000)
 		return 0;	/* 80 wire */
 	return 1;
