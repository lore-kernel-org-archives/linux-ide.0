From: <Stuart_Hayes@Dell.com>
Subject: RE: ide-cd question
Date: Mon, 7 Feb 2005 11:22:58 -0600
Message-ID: <7A8F92187EF7A249BF847F1BF4903C04010EE86E@ausx2kmpc103.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:6271 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261210AbVBGRXA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Feb 2005 12:23:00 -0500
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org


>> If there is a bug, it is in ide_cdrom_driver declaration.
>> .end_request is not set to ide_cdrom_error.
>> 
> 
> I wondered about that.  I'll give that a try.
> 

OK, 2.6.11-rc3 has the same issue.  The function ide_atapi_error() is
calling
drive->driver->end_request() when rq->errors exceeds ERROR_MAX, but, for
a
CD-ROM, this is calling the default end_request function.  The default
end
request function won't end the request in certain cases as described
below,
and they can get stuck being retried forever with no more resets
attempted.

It works great if I apply this patch.  I don't know if there's a reason
that
the CD-ROM driver has an end_request function but doesn't put it in the
driver
struct, or if that was an oversight, but I am assuming it was an
oversight.

I'd recommend applying this patch if nobody sees any problems with it.


--- ide-cd.c.orig	2005-02-07 10:56:42.000000000 -0500
+++ ide-cd.c	2005-02-07 10:57:06.000000000 -0500
@@ -3301,6 +3301,7 @@ static ide_driver_t ide_cdrom_driver = {
 	.supports_dsc_overlap	= 1,
 	.cleanup		= ide_cdrom_cleanup,
 	.do_request		= ide_do_rw_cdrom,
+	.end_request		= cdrom_end_request,
 	.capacity		= ide_cdrom_capacity,
 	.attach			= ide_cdrom_attach,
 	.drives			=
LIST_HEAD_INIT(ide_cdrom_driver.drives),



> I should have explained this better.  DRIVER(drive)->end_request() is 
> actually calling default_end_request(), which calls ide_end_reuqest(),

> which ends up calling __ide_end_request().  And that will only end the

> request if end_that_request_first() (in ll_rw_blk.c) returns 0.
> However, end_that_request_first() returns 1 because rq->bio is not
NULL 
> (in the case of GPCMD_GET_CONFIGURATION, anyway).
> 
> So, the request isn't ended, but neither is rq->errors cleared.

