From: <Stuart_Hayes@Dell.com>
Subject: RE: ide-cd question
Date: Fri, 4 Feb 2005 10:21:33 -0600
Message-ID: <7A8F92187EF7A249BF847F1BF4903C040AFC4F@ausx2kmpc103.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:1066 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S264965AbVBDQVj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Feb 2005 11:21:39 -0500
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Thu, 3 Feb 2005 14:34:42 -0600, Stuart_Hayes@dell.com
> <Stuart_Hayes@dell.com> wrote: 
>> 
>> Why does ide-cd use "DRIVER(drive)->end_request()" instead of
>> "cdrom_end_request()" in the function ide_cdrom_error when it wants
>> to end a request that's exceeded ERROR_MAX errors?  (See code below.)
> 
> Please always give the kernel version you are referring to.
> ide_cdrom_error() is gone in 2.6.11-rc2.
> 

I was looking at 2.6.10, sorry about that.  I'll have a look at
2.6.11-rc2.

> If there is a bug, it is in ide_cdrom_driver declaration.
> .end_request is not set to ide_cdrom_error.
> 

I wondered about that.  I'll give that a try.

>> With certain requests (GET_CONFIGURATION (0x46), in particular),
>> DRIVER(drive)->end_request() is not actually ending the request,
>> because rq->bio is not NULL--but it also is not clearing rq->errors,
>> so this request ends up getting retried forever, but no more resets
>> are attempted because rq->errors has exceeded ERROR_MAX.
> 
> I don't get this, maybe I'm looking at the wrong kernel version?
> 
> Bartlomiej

I should have explained this better.  DRIVER(drive)->end_request() is
actually calling default_end_request(), which calls ide_end_reuqest(),
which ends up calling __ide_end_request().  And that will only end
the request if end_that_request_first() (in ll_rw_blk.c) returns 0.
However, end_that_request_first() returns 1 because rq->bio is not
NULL (in the case of GPCMD_GET_CONFIGURATION, anyway).

So, the request isn't ended, but neither is rq->errors cleared.

Anyway, I'll have a look at 2.6.11-rc2.  Thanks for the response!




