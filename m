From: Alan Cox <alan@redhat.com>
Subject: PATCH: minor IDE clean up I noticed
Date: Thu, 30 Sep 2004 13:54:30 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040930175430.GA688@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:34511 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269379AbUI3Ryp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Sep 2004 13:54:45 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Nowdays a drive always has a driver


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc3/drivers/ide/ide-proc.c linux-2.6.9rc3/drivers/ide/ide-proc.c
--- linux.vanilla-2.6.9rc3/drivers/ide/ide-proc.c	2004-09-30 15:35:48.169975152 +0100
+++ linux-2.6.9rc3/drivers/ide/ide-proc.c	2004-09-30 16:33:46.423200288 +0100
@@ -365,20 +365,7 @@
 	{
 		unsigned short *val = (unsigned short *) page;
 		
-		/*
-		 *	The current code can't handle a driverless
-		 *	identify query taskfile. Now the right fix is
-		 *	to add a 'default' driver but that is a bit
-		 *	more work. 
-		 *
-		 *	FIXME: this has to be fixed for hotswap devices
-		 */
-		 
-		if(DRIVER(drive))
-			err = taskfile_lib_get_identify(drive, page);
-		else	/* This relies on the ID changes */
-			val = (unsigned short *)drive->id;
-
+		err = taskfile_lib_get_identify(drive, page);
 		if(!err)
 		{						
 			char *out = ((char *)page) + (SECTOR_WORDS * 4);
