From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream-fixes] libata: update	atapi_eh_request_sense()
 such that lbam/lbah contains buffer size
Date: Wed, 12 Dec 2007 17:16:09 +0900
Message-ID: <475F98C9.6080804@gmail.com>
References: <475F51AE.1010305@gmail.com> <1197446739.3467.4.camel@Athas>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:33116 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbXLLIQQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Dec 2007 03:16:16 -0500
Received: by wa-out-1112.google.com with SMTP id v27so242924wah.23
        for <linux-ide@vger.kernel.org>; Wed, 12 Dec 2007 00:16:16 -0800 (PST)
In-Reply-To: <1197446739.3467.4.camel@Athas>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Will Trives <will@trivescon.com.au>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, yannick.dirou@axetic.com, Alan Cox <alan@lxorguk.ukuu.org.uk>

Will Trives wrote:
> Hello guys,
> 
> Yannick does it work ok for you when you try to blank a dvd+rw disc ?
> Mine no longer jams up the drive now but it does say that the media or
> drive does not support blanking. I'm thinking its either because these
> discs just do multisession so this is what was meant to happen all along
> or there's still something going on. 

Does the kernel complain about anything?

> This drive or media does not support the 'BLANK media' command
> wodim: Cannot blank disk, aborting.
> wodim: Some drives do not support all blank types.
> wodim: Try again with wodim blank=all.

wodim suggests "blank=all", does it work?

-- 
tejun
