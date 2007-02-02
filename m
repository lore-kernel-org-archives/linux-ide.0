From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: reduce ATA command timeout to 7secs
Date: Sat, 03 Feb 2007 00:12:15 +0900
Message-ID: <45C354CF.1020500@gmail.com>
References: <20070202063748.GC1625@htj.dyndns.org> <45C33BCF.2040506@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.237]:51433 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945928AbXBBPMW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 10:12:22 -0500
Received: by wx-out-0506.google.com with SMTP id h31so921110wxd
        for <linux-ide@vger.kernel.org>; Fri, 02 Feb 2007 07:12:21 -0800 (PST)
In-Reply-To: <45C33BCF.2040506@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ric Wheeler <ric@emc.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Ric Wheeler wrote:
> 
> Tejun Heo wrote:
> 
>> Both ATA and ATAPI devices used the default timeouts defined by SCSI
>> high level driver.  For both disks and ODDs, it was 30secs, which was
>> way too long for disks.  This patch makes most ATA commands time out
>> after 7secs - the de facto ATA command timeout, while leaving ATAPI
>> timeout at 30secs.
>>
>> Note that both normal commands and EH commands timeouts are adjusted
>> to 7 secs, but cache flushses still have 30sec timeout.  This is a
>> side effect of the way sd makes use of sdev->timeout, but this is a
>> good side effect in that ATA spec requires cache flushes are given
>> longer timeout.
>>
>>
>>  
>>
> I am not sure that this is really a requirement that ATA (or S-ATA)
> drives can meet.  There are definitely error conditions that will exceed
> 7 seconds and take that 30 second time to respond.
> 
> If the drive is stuck in recovery mode and we retry too soon, we are
> going to be likely to write off a perfectly good disk which would be a
> huge downside ;-)

Hmm... I'm hearing different stories here.  Some say 7sec is good enough
and the supporting argument that the other os is using 7 sec timeout is
pretty convincing.

After command timeout, EH will kick in, reset and revalidate then return
the control to SCSI HLD, sd in this case which will retry the command
several times.  Would the reset make the drive to exit recovery mode
such that it has to start all over again when the command is retried?
Or does the drive stop responding to resets while in recovery mode?  The
latter would be fine.  libata gives and will continue to give more than
30 secs for drive to respond to reset.

Ideas?

-- 
tejun
