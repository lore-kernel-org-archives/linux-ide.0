From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATA device reset, shoud I be concerned?
Date: Tue, 22 Jan 2008 09:31:31 +0900
Message-ID: <47953963.3040101@gmail.com>
References: <200801140019.20668.g.chulkov@jacobs-university.de>	<20080115025435.1e21b703.akpm@linux-foundation.org>	<20080115113552.75731bf8@lxorguk.ukuu.org.uk>	<4794501E.90306@gmail.com>	<20080121130256.2443d7c1@lxorguk.ukuu.org.uk>	<47949AA4.9090601@gmail.com>	<20080121141425.45aa9c61@lxorguk.ukuu.org.uk>	<4794ACAF.70505@gmail.com>	<20080121164744.2f7d0ed1@lxorguk.ukuu.org.uk>	<4794D020.4060204@gmail.com> <20080121172715.0e3e5e4d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:24928 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbYAVAbj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 19:31:39 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4037008wah.23
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 16:31:38 -0800 (PST)
In-Reply-To: <20080121172715.0e3e5e4d@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Georgi Chulkov <g.chulkov@jacobs-university.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

Hello,

Alan Cox wrote:
>> I still don't think it's worth the trouble.  There's currently only one
>> reported device which forgets to raise IRQ on media error.  The behavior
> 
> Most people wouldn't realise what is going on.

Yeap, true but I don't think we have many timeouts due to media errors.
 I've seen lots of SMART logs for drives which caused timeouts but
haven't seen any which logged related media errors.

>>> Old IDE says it works for PATA. For SATA I can see it might need more
>>> care and you might simply not be able to get the info.
>> Old IDE often locks up the machine hard after timeouts.  I'm all for
> 
> The code paths are racy - it didn't use to in 2.4 (except for the promise
> drain bug)

My jmicron locks up hard under certain conditions.  I haven't
investigated it too deep but it looks like a hard lockup (controller
dying while holding PCI bus).  NMI watchdog doesn't work afterwards.

>> gathering more info but benefit vs. risk equation just doesn't look good
>> here.  Why take risk for a rare device which forgets to raise IRQ on
>> media error?  If such behavior is wide spread among PATA drives && we
>> can verify that TF register access after timeout is safe for PATA
>> controllers, sure, but currently we aren't sure about either.
> 
> We lose IRQs in lots of other cases. Promise PATA is particularly bad at
> forgetting to give us the completion interrupt.

In that case, completing commands after 30secs doesn't really help as
long as normal operation can be recovered afterward.  The driver should
take measures against lost interrupts like polling for interrupts after
a while.  Those are two different problems and require different almost
opposite solutions.  Some controllers need registers polled once in a
while while others die when registers are read unexpectedly.

Thanks.

-- 
tejun
