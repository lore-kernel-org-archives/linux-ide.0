From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ata: Add defines for the iordy bits
Date: Mon, 5 Feb 2007 16:17:19 +0000
Message-ID: <20070205161719.5345de9b@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56039 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751392AbXBEQEf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 11:04:35 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, akpm@osdl.org, linux-ide@vger.kernel.org

IORDY and IORDY enable/disable flags.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc6-mm3/include/linux/ata.h linux-2.6.20-rc6-mm3/include/linux/ata.h
--- linux.vanilla-2.6.20-rc6-mm3/include/linux/ata.h	2007-01-31 14:20:43.000000000 +0000
+++ linux-2.6.20-rc6-mm3/include/linux/ata.h	2007-02-05 10:53:45.000000000 +0000
@@ -299,6 +300,8 @@
 #define ata_id_queue_depth(id)	(((id)[75] & 0x1f) + 1)
 #define ata_id_removeable(id)	((id)[0] & (1 << 7))
 #define ata_id_has_dword_io(id)	((id)[50] & (1 << 0))
+#define ata_id_iordy_disable(id) ((id)[49] & (1 << 10))
+#define ata_id_has_iordy(id) ((id)[49] & (1 << 9))
 #define ata_id_u32(id,n)	\
 	(((u32) (id)[(n) + 1] << 16) | ((u32) (id)[(n)]))
 #define ata_id_u64(id,n)	\
