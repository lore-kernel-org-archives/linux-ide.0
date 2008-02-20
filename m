From: Johann Felix Soden <johfel@gmx.de>
Subject: [PATCH] ide-generic: Fix no initalization of idx in some case
Date: Wed, 20 Feb 2008 14:55:35 +0100
Message-ID: <1203515735.26116.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:36923 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758238AbYBTNz4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Feb 2008 08:55:56 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, linux-ide@vger.kernel.org

From: Johann Felix Soden <johfel@users.sourceforge.net>

If the slot is already occupied, there should be written 0xff to idx[i].
In the ongoing code and in this case there are no writings to idx[i], so
garbage stays in idx. The kernel get into a endless loop printing:

: I/O resource 0x0-0x0 not free.
Trying to free nonexistent resource <0000000000000000-0000000000000000>
Trying to free nonexistent resource <0000000000000000-0000000000000000>

This patch solves http://article.gmane.org/gmane.linux.ide/28810 .

Signed-off-by: Johann Felix Soden <johfel@users.sourceforge.net>
CC: Sergei Shtylyov <sshtylyov@ru.mvista.com>
---
 drivers/ide/ide-generic.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
index 5499a77..fb9865c 100644
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -103,7 +103,10 @@ static int __init ide_generic_init(void)
 			 */
 			hwif = ide_find_port();
 			if (hwif == NULL || hwif->index != i)
+			{
+				idx[i] = 0xff;
 				continue;
+			}
 
 			memset(&hw, 0, sizeof(hw));
 			ide_std_init_ports(&hw, io_addr, io_addr + 0x206);
-- 
1.5.4.2

