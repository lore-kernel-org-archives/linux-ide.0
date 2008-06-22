From: Elias Oltmanns <eo@nebensachen.de>
Subject: [PATCH 3/4] Update documentation of HDIO_DRIVE_RESET ioctl
Date: Mon, 23 Jun 2008 01:35:00 +0200
Message-ID: <87fxr5ujq3.fsf_-_@denkblock.local>
References: <87k5gmz596.fsf@denkblock.local>
	<200806192247.25063.bzolnier@gmail.com>
	<87wskhuk98.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:44620 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755991AbYFVXfI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Jun 2008 19:35:08 -0400
In-Reply-To: <87wskhuk98.fsf@denkblock.local> (Elias Oltmanns's message of
	"Mon, 23 Jun 2008 01:23:31 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>

Alter the entry for HDIO_DRIVE_RESET in Documentation/ioctl/hdio.txt to
reflect a functional change in the driver.  Besides, the entry has been
inaccurate before.

Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
---

 Documentation/ioctl/hdio.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ioctl/hdio.txt b/Documentation/ioctl/hdio.txt
index c19efde..a859734 100644
--- a/Documentation/ioctl/hdio.txt
+++ b/Documentation/ioctl/hdio.txt
@@ -508,12 +508,12 @@ HDIO_DRIVE_RESET		execute a device reset
 
 	error returns:
 	  EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  EBUSY		Device busy:	reset operation in progress already
 
 	notes:
 
-	  Abort any current command, prevent anything else from being
-	  queued, execute a reset on the device, and issue BLKRRPART
-	  ioctl on the block device.
+	  Execute a reset on the device as soon as the current IO
+	  operation has completed.
 
 	  Executes an ATAPI soft reset if applicable, otherwise
 	  executes an ATA soft reset on the controller.
