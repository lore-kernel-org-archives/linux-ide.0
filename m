From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata git tree, mbox queue status and contents
Date: Sat, 04 Aug 2007 17:14:50 +0900
Message-ID: <46B4357A.2080502@gmail.com>
References: <46B35344.3090208@garzik.org> <20070803172040.52853316@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:42690 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078AbXHDIPv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Aug 2007 04:15:51 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1100745wah
        for <linux-ide@vger.kernel.org>; Sat, 04 Aug 2007 01:15:51 -0700 (PDT)
In-Reply-To: <20070803172040.52853316@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Alan Cox wrote:
>> * Albert: irq_on/off.  Really need to give this some thought.  Not sure 
>> I like where this model is going.  Polling and twiddling irq on/off 
>> should be kept to a minimum, because it's sorta an admission that the 
>> host state machine has broken down, and we need to bandaid.  Its a 
>> bandaid not a root-cause solution.
> 
> I think of it more as an admission that the IDE design is lacking in a
> few areas. No suprise as its an emulation of a 15 year old interface that
> was normally used polled.

I second Alan's opinion.  The root cause of the problem is that the
controller lacks reliable IRQ masking and pending register.  If you add
a slightly malfunctioning controller and/or device into the mix, it's
guaranteed to break.

And there's another addition to the mess from SATA land which I
discovered a few days ago.  Some SATA controllers with SFF interface
don't send non-command H2D Reg FIS when ATA_NIEN is toggled, so the
updated ATA_NIEN is sent together with the next command && some SATA
devices don't honor ATA_NIEN on command H2D Reg FIS.  Fun!

I think we should go combined IRQ + polling mode Jeff once mentioned so
that we automatically fallback to polling if IRQ doesn't work for some
reason.  To do that, we need reliable IRQ masking && the only way to
achieve proper IRQ masking on SFF controllers seems plugging it from the
host side.

Thanks.

-- 
tejun
