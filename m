From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATA device reset, shoud I be concerned?
Date: Mon, 21 Jan 2008 22:14:12 +0900
Message-ID: <47949AA4.9090601@gmail.com>
References: <200801140019.20668.g.chulkov@jacobs-university.de>	<20080115025435.1e21b703.akpm@linux-foundation.org>	<20080115113552.75731bf8@lxorguk.ukuu.org.uk>	<4794501E.90306@gmail.com> <20080121130256.2443d7c1@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:11545 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbYAUNO1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 08:14:27 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3711052wah.23
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 05:14:25 -0800 (PST)
In-Reply-To: <20080121130256.2443d7c1@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Georgi Chulkov <g.chulkov@jacobs-university.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

Alan Cox wrote:
>> transmission failure as timeouts.  Of course, if we're ticking the timer
>> while the command is not in flight, that's a bug.  If there are cases
>> where 30 secs isn't enough, can you please point me to those reports?
> 
> I have been, in bugzilla - the raid failure example where old IDE
> eventually reports a media error while libata keeps timing out,
> resetting, repeating.

Maybe the difference is not in timeout but what the driver does after
timeout happens.  After timeout, libata ignores almost everything (it
considers DMA error reported on BMDMA status) and resets the device
while IDE thinks that IRQ might be lost and complete the command if the
TF status register says so.

It could be that the particular device doesn't raise IRQ on certain
error conditions but updates TF registers.  After timeout, IDE completes
the command with the indicated error while libata ignores the status and
resets the device.

libata never touches TF register after timeout because some controllers
lock up hard if TF register is read after certain error conditions
(event the status register).

-- 
tejun
