From: Elias Oltmanns <eo@nebensachen.de>
Subject: [PATCH 3/4 v2] Update documentation of HDIO_DRIVE_RESET ioctl
Date: Wed, 25 Jun 2008 13:29:52 +0200
Message-ID: <8763rxn45r.fsf_-_@denkblock.local>
References: <87k5gmz596.fsf@denkblock.local>
	<200806240041.42796.bzolnier@gmail.com>
	<87skv3s3d9.fsf@denkblock.local>
	<200806241306.42054.bzolnier@gmail.com>
	<20080624133218.6bccab75@lxorguk.ukuu.org.uk>
	<58cb370e0806240621g61370f56j660e31790dad89c3@mail.gmail.com>
	<20080624143548.24dcf511@lxorguk.ukuu.org.uk>
	<58cb370e0806240719o4a70537p4a6fb64e9086e2d8@mail.gmail.com>
	<87k5gdn4fq.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:35102 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752901AbYFYLaC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Jun 2008 07:30:02 -0400
In-Reply-To: <87k5gdn4fq.fsf@denkblock.local> (Elias Oltmanns's message of
	"Wed, 25 Jun 2008 13:23:53 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>

Alter the entry for HDIO_DRIVE_RESET in Documentation/ioctl/hdio.txt to
reflect a functional change in the driver.  Besides, the entry has been
inaccurate before.

Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
---

 Documentation/ioctl/hdio.txt |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/ioctl/hdio.txt b/Documentation/ioctl/hdio.txt
index c19efde..44d283d 100644
--- a/Documentation/ioctl/hdio.txt
+++ b/Documentation/ioctl/hdio.txt
@@ -511,9 +511,8 @@ HDIO_DRIVE_RESET		execute a device reset
 
 	notes:
 
-	  Abort any current command, prevent anything else from being
-	  queued, execute a reset on the device, and issue BLKRRPART
-	  ioctl on the block device.
+	  Execute a reset on the device as soon as the current IO
+	  operation has completed.
 
 	  Executes an ATAPI soft reset if applicable, otherwise
 	  executes an ATA soft reset on the controller.
