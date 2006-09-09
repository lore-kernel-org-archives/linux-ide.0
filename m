From: Andres Salomon <dilinger@debian.org>
Subject: Re: weird port status w/ sata_mv
Date: Sat, 09 Sep 2006 01:40:31 -0400
Message-ID: <1157780431.6131.33.camel@localhost.localdomain>
References: <1157612390.32204.40.camel@localhost.localdomain>
	 <1157613748.32204.43.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-aSNouNDAac5KMY0mdyxq"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mouth.voxel.net ([69.9.180.118]:6546 "EHLO mail.squishy.cc")
	by vger.kernel.org with ESMTP id S932156AbWIIFk0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Sep 2006 01:40:26 -0400
In-Reply-To: <1157613748.32204.43.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: linux-ide@vger.kernel.org


--=-aSNouNDAac5KMY0mdyxq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2006-09-07 at 03:22 -0400, Andres Salomon wrote:
> On Thu, 2006-09-07 at 02:59 -0400, Andres Salomon wrote:
> [...]
> > 
> > What does 0x4 in the SCR_STATUS register actually mean?  Is there
> > something that can be initialized or reset to coax the port to a normal
> > status/state?
> > 
> > 
> 
> Ok, so to answer my own question: according to
> <http://www.monkey.org/openbsd/archive/misc/0408/msg01454.html>, it
> would appear that 0x4 means the PHY is in offline mode.  So the question
> is, why is it offline, and what can be done to reset it?


I've attached a patch that fixes a bug w/ the sstatus variable in
mv_phy_reset().  This patch should definitely be applied; even if it's
not fixing the bug I'm seeing, it could be affecting others.

I _think_ it fixes my bug, but I won't be certain for a little while
(since it's hard to reproduce).




--=-aSNouNDAac5KMY0mdyxq
Content-Disposition: attachment; filename=0002-sata_mv.patch
Content-Type: text/x-patch; name=0002-sata_mv.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

>From 8961af7328fc9a31f18e734a3aa4c6d2eaaa56a9 Mon Sep 17 00:00:00 2001
From: Andres Salomon <dilinger@debian.org>
Date: Sat, 9 Sep 2006 05:21:35 +0000
Subject: [PATCH] sata_mv: errata check buglet fix
Fix a buglet; the errata check below this code is assuming the value in
the sstatus variable is what was pulled out of the SCR_STATUS register.
However, the status checks in the timeout loop clobber everything but the
first 4 bits of sstatus, so the errata checks are invalid.

This patch changes it to not clobber sstatus.

Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/scsi/sata_mv.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 65c9ce6..404b4d3 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -1961,8 +1961,7 @@ comreset_retry:
 	timeout = jiffies + msecs_to_jiffies(200);
 	do {
 		sata_scr_read(ap, SCR_STATUS, &sstatus);
-		sstatus &= 0x3;
-		if ((sstatus == 3) || (sstatus == 0))
+		if (((sstatus & 0x3) == 3) || ((sstatus & 0x3) == 0))
 			break;
 
 		__msleep(1, can_sleep);
-- 
1.4.1.1


--=-aSNouNDAac5KMY0mdyxq--

