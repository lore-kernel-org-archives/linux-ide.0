From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATA device reset, shoud I be concerned?
Date: Tue, 22 Jan 2008 02:02:24 +0900
Message-ID: <4794D020.4060204@gmail.com>
References: <200801140019.20668.g.chulkov@jacobs-university.de>	<20080115025435.1e21b703.akpm@linux-foundation.org>	<20080115113552.75731bf8@lxorguk.ukuu.org.uk>	<4794501E.90306@gmail.com>	<20080121130256.2443d7c1@lxorguk.ukuu.org.uk>	<47949AA4.9090601@gmail.com>	<20080121141425.45aa9c61@lxorguk.ukuu.org.uk>	<4794ACAF.70505@gmail.com> <20080121164744.2f7d0ed1@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:1549 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbYAURCg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 12:02:36 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3832876wah.23
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 09:02:36 -0800 (PST)
In-Reply-To: <20080121164744.2f7d0ed1@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Georgi Chulkov <g.chulkov@jacobs-university.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

Alan Cox wrote:
>> Can you elaborate a bit?  I don't really think completing a command
>> after 30sec timeout contributes a lot to driver stability.
> 
> Timeout, timeout, timeout, reset, timeout.. (repeat), failed I/O
> 
> This gives the end user no information about the fault, nor does it let
> the upper layers of SCSI and above distinguish between a random passing
> sulk and media errors which need the disk replacing.

I still don't think it's worth the trouble.  There's currently only one
reported device which forgets to raise IRQ on media error.  The behavior
is out of spec and rare.  I don't think it's a good idea to change EH
behavior for it.

>>> Should that not then be a per host flag ?
>> Yeah, that would be the best.  The problem is that there are several
>> different kinds of timeouts and we don't know which controller locks up
>> after which timeout and investigating them is really difficult.
> 
> PATA controllers don't lock up in that case so its quite easy. The one
> exception is if the device jams IORDY but in that case you are dead
> anyway the next I/O (except on a SIL680 which has a timer we could use).
> 
> Old IDE says it works for PATA. For SATA I can see it might need more
> care and you might simply not be able to get the info.

Old IDE often locks up the machine hard after timeouts.  I'm all for
gathering more info but benefit vs. risk equation just doesn't look good
here.  Why take risk for a rare device which forgets to raise IRQ on
media error?  If such behavior is wide spread among PATA drives && we
can verify that TF register access after timeout is safe for PATA
controllers, sure, but currently we aren't sure about either.

Thanks.

-- 
tejun
