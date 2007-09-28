From: Tejun Heo <htejun@gmail.com>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Fri, 28 Sep 2007 09:48:44 -0700
Message-ID: <46FD306C.3050205@gmail.com>
References: <1190521193410-git-send-email-htejun@gmail.com> <46F9BF3E.5050708@garzik.org> <46FA1B4E.8090103@gmail.com> <46FD079F.3010007@garzik.org> <46FD0D50.8030602@gmail.com> <46FD1C4A.8010101@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:51291 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbXI1QuY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Sep 2007 12:50:24 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3598088wah
        for <linux-ide@vger.kernel.org>; Fri, 28 Sep 2007 09:50:23 -0700 (PDT)
In-Reply-To: <46FD1C4A.8010101@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Jeff Garzik wrote:
>> Aieee... Another merge delay.  I wish the review process proceeded a bit
>> swifter.   The patchset has been around literally for years now and
>> submitted for review six times if I have the take number right.  :-(
> 
> Well the vast majority of the patches are in, what five out of six
> original patchsets?

Yeah, I'm frustrated mainly because I've been telling people that
mainline will probably have PMP support when 2.6.24 comes out and it
seems we'll miss the merge window again.  Oh, well...

> Sorry I didn't catch the polling requirement beforehand, it was not
> really clear from a quick read.

->pmp_read/write stuff is something which I've been meaning to change
anyway.  When developing the PMP code, PMP register access while frozen
seemed necessary but now I think we can be just as safe without it.  I
was thinking about changing it after merge because the current code
received a lot of testing and I didn't want to destabilize it right
before merging.

I'll be back home mid next week.  I'll try to re-test and re-submit the
changes ASAP.

Thanks.

-- 
tejun
