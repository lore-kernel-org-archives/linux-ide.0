From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ide: Fix crash on repeated reset
Date: Mon, 04 Sep 2006 14:54:01 +0100
Message-ID: <1157378041.30801.78.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:21175 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751324AbWIDNbX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Sep 2006 09:31:23 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

mirq-linux@rere.qmqm.pl (Micha&#322; Miros&#322;aw) [1] reported a
problem (bugzilla #7023) where a user initiated reset while the IDE
layer was already resetting the channel caused a crash, and provided a
rough fix.

This is a slightly cleaner version of the fix which tracks the reset
state and blocks further reset requests while a reset is in progress. 

Note this is not a security issue - random end users can't access the
ioctl in question anyway.


[1] This is what bugzilla.kernel.org calls him anyway


Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/linux/ide.h linux-2.6.18-rc5-mm1/include/linux/ide.h
--- linux.vanilla-2.6.18-rc5-mm1/include/linux/ide.h	2006-09-01 13:39:19.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/linux/ide.h	2006-09-01 13:55:32.000000000 +0100
@@ -825,6 +825,9 @@
 	unsigned int sleeping	: 1;
 		/* BOOL: polling active & poll_timeout field valid */
 	unsigned int polling	: 1;
+	 	/* BOOL: in a polling reset situation. Must not trigger another reset yet */
+	unsigned	resetting  : 1;
+
 		/* current drive */
 	ide_drive_t *drive;
 		/* ptr to current hwif in linked-list */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/ide/ide.c linux-2.6.18-rc5-mm1/drivers/ide/ide.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/ide/ide.c	2006-09-01 13:39:05.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/ide/ide.c	2006-09-01 13:53:03.000000000 +0100
@@ -1370,6 +1370,11 @@
 			 */
 
 			spin_lock_irqsave(&ide_lock, flags);
+			
+			if (HWGROUP(drive)->resetting) {
+				spin_unlock_irqrestore(&ide_lock, flags);
+				return -EBUSY;
+			}
 
 			ide_abort(drive, "drive reset");
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/ide/ide-iops.c linux-2.6.18-rc5-mm1/drivers/ide/ide-iops.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/ide/ide-iops.c	2006-08-30 18:31:46.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/ide/ide-iops.c	2006-09-01 13:53:03.000000000 +0100
@@ -998,6 +998,7 @@
 	}
 	/* done polling */
 	hwgroup->polling = 0;
+	hwgroup->resetting = 0;
 	return ide_stopped;
 }
 
@@ -1057,6 +1058,7 @@
 		}
 	}
 	hwgroup->polling = 0;	/* done polling */
+	hwgroup->resetting = 0; /* done reset attempt */
 	return ide_stopped;
 }
 
@@ -1143,6 +1145,7 @@
 
 	/* For an ATAPI device, first try an ATAPI SRST. */
 	if (drive->media != ide_disk && !do_not_try_atapi) {
+		hwgroup->resetting = 1;
 		pre_reset(drive);
 		SELECT_DRIVE(drive);
 		udelay (20);
@@ -1168,6 +1171,7 @@
 		return ide_stopped;
 	}
 
+	hwgroup->resetting = 1;
 	/*
 	 * Note that we also set nIEN while resetting the device,
 	 * to mask unwanted interrupts from the interface during the reset.

