From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: reduce ATA command timeout to 7secs
Date: Fri, 02 Feb 2007 11:12:29 -0500
Message-ID: <45C362ED.3040600@rtr.ca>
References: <20070202063748.GC1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2999 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161141AbXBBQMb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Feb 2007 11:12:31 -0500
In-Reply-To: <20070202063748.GC1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Both ATA and ATAPI devices used the default timeouts defined by SCSI
> high level driver.  For both disks and ODDs, it was 30secs, which was
> way too long for disks.  This patch makes most ATA commands time out
> after 7secs - the de facto ATA command timeout, while leaving ATAPI
> timeout at 30secs.

Good patch, LONG overdue.

But 7 seconds is too short.  I have drives here now that
take slightly more than 7 seconds to report media errors.

With this patch, libata will timeout/reset the drive just before
it had a chance to tell us why it was taking too long.

The result would be that we might lose data unnecessarily,
especially in combination with the current SCSI policy of
blindly failing the entire request when only one sector was bad.

I've used 10 second timeouts with 100% success over the past 14 years,
which allows just enough margin (+2) for drives to finish their internal
retries and report back.

NACK to 7, ACK to 10 seconds.
