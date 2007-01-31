From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ide-floppy: Fix unformatted media crash
Date: Wed, 31 Jan 2007 17:41:23 +0000
Message-ID: <20070131174123.17aba9d1@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55590 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030377AbXAaR3E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 12:29:04 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, bzolnier@google.com

A ZIP or similar with unformatted media will cause crashes when attempts
are made to read/write it in some cases. This is because bs_factor is
zero and we divide by it causing an oops.

As the size of a non-accessible/non-existant media is really a bit of a
zen question it doesn't matter if non-existant media is 512 bytes per
sector or zero. Setting it to 1 causes us to generate 512 bytes/sector
accesses and error properly.

Signed-off-by: Alan Cox <alan@redhat.com>

Based on a fix found lurking in an ancient bugzilla entry since about 2004 (ugghhh)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc6-mm3/drivers/ide/ide-floppy.c linux-2.6.20-rc6-mm3/drivers/ide/ide-floppy.c
--- linux.vanilla-2.6.20-rc6-mm3/drivers/ide/ide-floppy.c	2007-01-31 14:20:40.000000000 +0000
+++ linux-2.6.20-rc6-mm3/drivers/ide/ide-floppy.c	2007-01-31 14:33:42.000000000 +0000
@@ -1434,7 +1434,8 @@
 	
 	drive->bios_cyl = 0;
 	drive->bios_head = drive->bios_sect = 0;
-	floppy->blocks = floppy->bs_factor = 0;
+	floppy->blocks = 0;
+	floppy->bs_factor = 1;
 	set_capacity(floppy->disk, 0);
 
 	idefloppy_create_read_capacity_cmd(&pc);

