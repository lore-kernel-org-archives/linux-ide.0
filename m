From: Alan Cox <alan@redhat.com>
Subject: PATCH: second small comment/formatting only patch from IDE
Date: Sun, 15 Aug 2004 10:38:04 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040815143804.GA6474@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:50646 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266705AbUHOOi4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Aug 2004 10:38:56 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

Want to get the "noise" and the big changes seperate

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/ide.c linux-2.6.8-rc3/drivers/ide/ide.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/ide.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/ide.c	2004-08-12 17:55:05.000000000 +0100
@@ -1188,6 +1412,15 @@
 	return val;
 }
 
+/**
+ *	ide_spin_wait_hwgroup	-	wait for group
+ *	@drive: drive in the group
+ *
+ *	Wait for an IDE device group to go non busy and then return
+ *	holding the ide_lock which guards the hwgroup->busy status
+ *	and right to use it.
+ */
+ 
 int ide_spin_wait_hwgroup (ide_drive_t *drive)
 {
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
@@ -1229,6 +1462,7 @@
  *	to the driver to change settings, and then wait on a sema for completion.
  *	The current scheme of polling is kludgy, though safe enough.
  */
+
 int ide_write_setting (ide_drive_t *drive, ide_settings_t *setting, int val)
 {
 	int i;
