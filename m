From: Ben Dooks <ben-linux@fluff.org>
Subject: IDE: fix sparse signed-ness errors with host->host_busy
Date: Tue, 13 Jan 2009 17:28:08 +0000
Message-ID: <20090113172808.616407105@fluff.org.uk>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:48079 "EHLO
	teyla.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753053AbZAMR24 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Jan 2009 12:28:56 -0500
Content-Disposition: inline; filename=simtec/sparse-fix/ide-fix-host-busy.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, linux-ide@vger.kernel.org
Cc: Ben Dooks <ben-linux@fluff.org>

The host_busy field in struct ide_host defaults to a
signed-long, where most arch's test_and_set_bit_*
macros use an unsigned long.

Change to using an unsigned long, which on ARM removes
the following sparse errors:

drivers/ide/ide-io.c:681:8: warning: incorrect type in argument 2 (different signedness)
drivers/ide/ide-io.c:681:8:    expected unsigned long volatile *p
drivers/ide/ide-io.c:681:8:    got long volatile *<noident>
drivers/ide/ide-io.c:681:8: warning: incorrect type in argument 2 (different signedness)
drivers/ide/ide-io.c:681:8:    expected unsigned long volatile *p
drivers/ide/ide-io.c:681:8:    got long volatile *<noident>
drivers/ide/ide-io.c:695:3: warning: incorrect type in argument 2 (different signedness)
drivers/ide/ide-io.c:695:3:    expected unsigned long volatile *p
drivers/ide/ide-io.c:695:3:    got long volatile *<noident>
drivers/ide/ide-io.c:695:3: warning: incorrect type in argument 2 (different signedness)
drivers/ide/ide-io.c:695:3:    expected unsigned long volatile *p
drivers/ide/ide-io.c:695:3:    got long volatile *<noident>
drivers/ide/ide-io.c:695:3: warning: incorrect type in argument 2 (different signedness)
drivers/ide/ide-io.c:695:3:    expected unsigned long volatile *p
drivers/ide/ide-io.c:695:3:    got long volatile *<noident>
drivers/ide/ide-io.c:695:3: warning: incorrect type in argument 2 (different signedness)
drivers/ide/ide-io.c:695:3:    expected unsigned long volatile *p
drivers/ide/ide-io.c:695:3:    got long volatile *<noident>
drivers/ide/ide-io.c:695:3: warning: incorrect type in argument 2 (different signedness)
drivers/ide/ide-io.c:695:3:    expected unsigned long volatile *p
drivers/ide/ide-io.c:695:3:    got long volatile *<noident>
drivers/ide/ide-io.c:695:3: warning: incorrect type in argument 2 (different signedness)
drivers/ide/ide-io.c:695:3:    expected unsigned long volatile *p
drivers/ide/ide-io.c:695:3:    got long volatile *<noident>
drivers/ide/ide-io.c:695:3: warning: incorrect type in argument 2 (different signedness)
drivers/ide/ide-io.c:695:3:    expected unsigned long volatile *p
drivers/ide/ide-io.c:695:3:    got long volatile *<noident>
drivers/ide/ide-io.c:695:3: warning: incorrect type in argument 2 (different signedness)
drivers/ide/ide-io.c:695:3:    expected unsigned long volatile *p
drivers/ide/ide-io.c:695:3:    got long volatile *<noident>

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Index: linux.git/include/linux/ide.h
===================================================================
--- linux.git.orig/include/linux/ide.h	2009-01-09 14:38:45.000000000 +0000
+++ linux.git/include/linux/ide.h	2009-01-09 14:39:03.000000000 +0000
@@ -871,7 +871,7 @@ struct ide_host {
 	ide_hwif_t	*cur_port;	/* for hosts requiring serialization */
 
 	/* used for hosts requiring serialization */
-	volatile long	host_busy;
+	volatile unsigned long	host_busy;
 };
 
 #define IDE_HOST_BUSY 0

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
