From: Tejun Heo <tj@kernel.org>
Subject: Re: [nForce4] - Repeatable issues with nForce 4
Date: Tue, 2 Dec 2014 10:17:10 -0500
Message-ID: <20141202151710.GA6596@htj.dyndns.org>
References: <CAO18KQjN88PjQSh0bMo+YgqmSSE--eaxL3Lgo5QeUjg3vMu6iQ@mail.gmail.com>
 <20140914093721.GA9028@mtj.dyndns.org>
 <CADLC3L397fmyWa1CpzZfkTkZavyKPG4M7JccdgbgTRTsUp8VVQ@mail.gmail.com>
 <CAO18KQjP785u-jiucmRFczNTRLPJMnbXm7ukvRBNvdSaW6KUhg@mail.gmail.com>
 <CADLC3L1BvbouQEqbdu2iDuk73-UO6a_O84gCpfaYfD6pPuLvoA@mail.gmail.com>
 <CAO18KQgEn8qWozNmySU_S7vT1XSN+FfXM-1uqRWaVdOMc6sPbw@mail.gmail.com>
 <CADLC3L3wRkmz-1qvVptiERQAPUhtRmSid5oQ-dfNveLrPFkg2A@mail.gmail.com>
 <CAO18KQhQghMPv0PR01FCgYAmgdLRGAvZ-WFLxLeoz4H9ct-b0Q@mail.gmail.com>
 <CADLC3L2nTrowBeBU=TRVELUjRahOnJxqkUTqxXSbjj9sQ+U2NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:57814 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178AbaLBPRO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Dec 2014 10:17:14 -0500
Received: by mail-qa0-f46.google.com with SMTP id n8so2813597qaq.19
        for <linux-ide@vger.kernel.org>; Tue, 02 Dec 2014 07:17:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CADLC3L2nTrowBeBU=TRVELUjRahOnJxqkUTqxXSbjj9sQ+U2NQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Jacobo Pantoja <jacobopantoja@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Sun, Nov 30, 2014 at 11:52:40PM -0600, Robert Hancock wrote:
> Looks like it's doing a hardreset now (apparently successfully).
> However the reason it still does a softreset anyway is this at the end
> of nv_hardreset:
> 
>         /* device signature acquisition is unreliable */
>         return -EAGAIN;
> 
> Try changing that to:
> 
>         return 0;
> 
> and see if that changes the behavior. That should make it skip the
> soft-reset. Whether or not the device works or not after that, or if
> it still locks up at some later point, we'll see.

There have been some PMP devices which have trouble with SRST and
acquiring device signature, so there are link flags to deal with them
- ATA_LFLAG_NO_[SH]RST and ATA_LFLAG_ASSUME_*.  Not sure how useful
they'd be in this case tho.

Thanks.

-- 
tejun
