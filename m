From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCH] 2.6.x libata bug fix
Date: Tue, 26 Oct 2004 12:02:47 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041026160247.GA23459@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:15289 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261325AbUJZQDt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Oct 2004 12:03:49 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, axboe@suse.de


When I added ioctl handling, I returned EOPNOTSUPP for the "I didn't
recognize that ioctl you wanted to execute" return code.

The block layer will execute certain ioctl operations IFF the low-level
driver returns ENOTTY, signalling to the block layer that that driver
does not support the specified ioctl.

The net effect of libata returning EOPNOTSUPP was such that it
__broke__ BLSFLSBUF ioctl, simply by implementing ->ioctl.

So, we return the proper return code, and ioctls we don't handle
start to work again.  Overall, though, this is a fragile way to do
things in the block layer, IMHO.

Please do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/libata-scsi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

through these ChangeSets:

<jgarzik@pobox.com> (04/10/26 1.2068)
   [libata] return ENOTTY rather than EOPNOTSUPP for unknown-ioctl

diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2004-10-26 11:56:47 -04:00
+++ b/drivers/scsi/libata-scsi.c	2004-10-26 11:56:47 -04:00
@@ -97,7 +97,7 @@
 		return 0;
 
 	default:
-		rc = -EOPNOTSUPP;
+		rc = -ENOTTY;
 		break;
 	}
 
