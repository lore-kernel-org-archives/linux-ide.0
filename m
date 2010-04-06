From: Mark Lord <kernel@teksavvy.com>
Subject: [PATCH] Fix accesses at LBA28 boundary (old bug, but nasty)
Date: Tue, 06 Apr 2010 18:45:09 -0400
Message-ID: <4BBBB975.7000203@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:39450 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757512Ab0DFWpM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Apr 2010 18:45:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ric Wheeler <rwheeler@redhat.com>

Most drives from Seagate, Hitachi, and possibly other brands,
do not allow LBA28 access to sector number 0x0fffffff (2^28 - 1).
So instead use LBA48 for such accesses.

This bug could bite a lot of systems, especially when the user has
taken care to align partitions to 4KB boundaries.  On misaligned systems,
it is less likely to be encountered, since a 4KB read would end at 0x10000000
rather than at 0x0fffffff.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- linux-2.6.34-rc3/include/linux/ata.h	2010-03-30 12:24:39.000000000 -0400
+++ linux/include/linux/ata.h	2010-04-06 18:39:41.167702612 -0400
@@ -1025,8 +1025,8 @@
  
  static inline int lba_28_ok(u64 block, u32 n_block)
  {
-	/* check the ending block number */
-	return ((block + n_block) < ((u64)1 << 28)) && (n_block <= 256);
+	/* check the ending block number: must be LESS THAN 0x0fffffff */
+	return ((block + n_block) < (u64)((1 << 28) - 1)) && (n_block <= 256);
  }
  
  static inline int lba_48_ok(u64 block, u32 n_block)
