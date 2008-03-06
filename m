From: Tejun Heo <htejun@gmail.com>
Subject: Re: Correct use of  ap->lock  versus  ap->host->lock ?
Date: Fri, 07 Mar 2008 08:04:01 +0900
Message-ID: <47D07861.5030306@gmail.com>
References: <47D01232.1000106@rtr.ca> <47D01D4B.8000506@pobox.com> <47D02642.8040907@rtr.ca> <47D028C5.9070509@rtr.ca> <47D02CC0.6080609@pobox.com> <47D033F5.9090303@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.188]:34285 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbYCFXEN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Mar 2008 18:04:13 -0500
Received: by gv-out-0910.google.com with SMTP id s4so92569gve.37
        for <linux-ide@vger.kernel.org>; Thu, 06 Mar 2008 15:04:09 -0800 (PST)
In-Reply-To: <47D033F5.9090303@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Jeff Garzik wrote:
>> You need to perform your own LLD-specific locking analysis to see if
>> it is safe to do, e.g. __mv_stop_dma() rather than mv_stop_dma().
> 
> And speaking as the probable author of some of the code that takes a
> lock during EH in sata_mv....   reinforcing that the above quoted
> statement is true.
> 
> Generally I would put in a lock during EH around register or data
> manipulations that were locked elsewhere in the driver, thus
> guaranteeing such code is safe.
> 
> However, it may also be the case that such a lock during EH is
> unnecessary because command submission machinery is disabled.  I chose a
> path that potentially added more locking, but was much easier to verify
> correct.

I think it's generally safe not to grab any locks during resets as all
the submission machinery && the interrupt handler are shut down, so it
should be safe to go lockless.  There may be exceptions tho.

-- 
tejun
