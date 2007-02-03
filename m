From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: reduce ATA command timeout to 7secs
Date: Sat, 03 Feb 2007 13:45:21 +0900
Message-ID: <45C41361.3060409@gmail.com>
References: <20070202063748.GC1625@htj.dyndns.org> <45C362ED.3040600@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.235]:43274 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946321AbXBCEp1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 23:45:27 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1040673wxd
        for <linux-ide@vger.kernel.org>; Fri, 02 Feb 2007 20:45:26 -0800 (PST)
In-Reply-To: <45C362ED.3040600@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>

[cc'ing Jens, hello]

Mark Lord wrote:
> Tejun Heo wrote:
>> Both ATA and ATAPI devices used the default timeouts defined by SCSI
>> high level driver.  For both disks and ODDs, it was 30secs, which was
>> way too long for disks.  This patch makes most ATA commands time out
>> after 7secs - the de facto ATA command timeout, while leaving ATAPI
>> timeout at 30secs.
> 
> Good patch, LONG overdue.
> 
> But 7 seconds is too short.  I have drives here now that
> take slightly more than 7 seconds to report media errors.
> 
> With this patch, libata will timeout/reset the drive just before
> it had a chance to tell us why it was taking too long.
> 
> The result would be that we might lose data unnecessarily,
> especially in combination with the current SCSI policy of
> blindly failing the entire request when only one sector was bad.

Timeout doesn't indicate media error, so SCSI will retry the command
several times.  So, those two don't interact.

> I've used 10 second timeouts with 100% success over the past 14 years,
> which allows just enough margin (+2) for drives to finish their internal
> retries and report back.
> 
> NACK to 7, ACK to 10 seconds.

Hmmm... I don't care whether 7 or 10.  The biggest reason I chose 7 was
because somebody told me that that's the de-facto default ATA command
timeout && the other os is using it.  I faintly remembers that it was
yourself or Jens.  Or I might be just imagining things again.  :-)

Jens, what do you think about this?

Thanks.

-- 
tejun
