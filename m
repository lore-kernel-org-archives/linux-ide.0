From: <Stuart_Hayes@Dell.com>
Subject: RE: ide-cd question
Date: Thu, 10 Feb 2005 15:41:46 -0600
Message-ID: <7A8F92187EF7A249BF847F1BF4903C04010EE89F@ausx2kmpc103.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:23843 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261623AbVBJVlv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2005 16:41:51 -0500
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, bzolnier@gmail.com


> 
> I'd recommend applying this patch if nobody sees any problems with it.
> 
> 
> --- ide-cd.c.orig	2005-02-07 10:56:42.000000000 -0500
> +++ ide-cd.c	2005-02-07 10:57:06.000000000 -0500
> @@ -3301,6 +3301,7 @@ static ide_driver_t ide_cdrom_driver = {
>  	.supports_dsc_overlap	= 1,
>  	.cleanup		= ide_cdrom_cleanup,
>  	.do_request		= ide_do_rw_cdrom,
> +	.end_request		= cdrom_end_request,
>  	.capacity		= ide_cdrom_capacity,
>  	.attach			= ide_cdrom_attach,
>  	.drives			=
> LIST_HEAD_INIT(ide_cdrom_driver.drives),
> 
> 

I took the lack of responses to mean that either nobody cared, or the 
patch was so bad that it wasn't worthy of comment, so I took a closer 
look at it.  After looking at it more carefully, I suspect that the 
function cdrom_end_request() was meant to be an internal function, and 
not the end_request function for the driver (in part because the 
number of parameters for cdrom_end_request() isn't the same as 
ide_end_request()!).

Here's another patch that fixes the issue I'm seeing, and is less likely

to cause any other problems.  This will make sure that requests that are

ended in ide_atapi_error() because they failed too many times (even
after
a couple reset attempts) are completely ended, even if they didn't
finish 
transferring all the data that was expected.

Please apply if you don't see any problems with it.

Thanks!
Stuart



--- ide-io.c.orig	2005-02-10 15:23:52.000000000 -0500
+++ ide-io.c.new	2005-02-10 15:23:31.000000000 -0500
@@ -515,7 +515,18 @@ static ide_startstop_t ide_atapi_error(i
 		hwif->OUTB(WIN_IDLEIMMEDIATE, IDE_COMMAND_REG);
 
 	if (rq->errors >= ERROR_MAX) {
-		drive->driver->end_request(drive, 0, 0);
+		/* 
+		 * make sure request is fully ended--otherwise bio might
get updated and the
+		 * command will be retried without rq->errors getting
reset to zero, which
+		 * could cause us to get stuck in a loop with infinite
retries without any 
+		 * more reset attempts (borrowed from cdrom_end_request)
+		 */
+		int nsectors;
+		if (blk_pc_request(rq))
+			nsectors = (rq->data_len + 511) >> 9;
+		if (!nsectors)
+			nsectors = 1;
+		drive->driver->end_request(drive, 0, nsectors);
 	} else {
 		if ((rq->errors & ERROR_RESET) == ERROR_RESET) {
 			++rq->errors;



