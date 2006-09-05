From: Tejun Heo <htejun@gmail.com>
Subject: Re: faulty disk testing
Date: Tue, 05 Sep 2006 16:08:40 +0200
Message-ID: <44FD84E8.8000705@gmail.com>
References: <44FCD328.3020800@emc.com> <44FD662A.6060404@gmail.com> <44FD803B.3040000@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.239]:55833 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965050AbWIEOIz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Sep 2006 10:08:55 -0400
Received: by wx-out-0506.google.com with SMTP id s14so2273146wxc
        for <linux-ide@vger.kernel.org>; Tue, 05 Sep 2006 07:08:55 -0700 (PDT)
In-Reply-To: <44FD803B.3040000@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Ric Wheeler <ric@emc.com>, Linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Hello, Mark.

Mark Lord wrote:
> Sure it does.  It can determine the number of consecutive failures on
> the same drive/channel, and it can also count intervening successes, if any.
> 
> From that, at a minimum, it could notice that the same drive has gone 'round
> the error treadmill (say) 20 times in a row, with no other I/O possible on it
> because it has yet to successfully complete the reset+reinit phase.

If a device fails reset+reinit phase a few times, libata surely drops 
the device, but I don't think the kernel can drop a device because it 
failed, say, 20 consecutive IO commands when it can respond to reset and 
reinit.  That's where policy needs to come in, IMHO.

For Ric's case, I'm waiting for more info.  If EH is looping forever 
without reporting to upper layer, it definitely needs fixing, but I 
don't think that's the case.

> Such a drive is a candidate for pushing the error upstairs,
> and possibly for getting offlined.
> 
> Fancier fault-handling is also possible, but the bare minimum is that we
> must not get stuck forever looping in the EH code.  Eventually a failed 
> status
> has to be returned to the layers above, I think.

Error is always pushed upstairs.  libata itself doesn't initiate any 
kind of retrials.  That's upto high level driver - in this case, sd.

One of the problems is that currently libata EH can take some minutes 
recovering from an error condition.  With partial request retry from sd, 
  a batch of consecutive bad sectors can make recovery take a really 
long time.  This needs fixing.

Thanks.

-- 
tejun
