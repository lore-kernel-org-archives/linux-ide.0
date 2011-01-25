From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_via bus errors fixed?
Date: Tue, 25 Jan 2011 11:50:49 +0100
Message-ID: <20110125105049.GQ27510@htj.dyndns.org>
References: <4D3DA387.8080301@mrc-lmb.cam.ac.uk>
 <20110124170432.GH27510@htj.dyndns.org>
 <4D3EA771.3070206@mrc-lmb.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46810 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab1AYKu4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jan 2011 05:50:56 -0500
Received: by fxm20 with SMTP id 20so5080009fxm.19
        for <linux-ide@vger.kernel.org>; Tue, 25 Jan 2011 02:50:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D3EA771.3070206@mrc-lmb.cam.ac.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Howorth <dhoworth@mrc-lmb.cam.ac.uk>
Cc: linux-ide@vger.kernel.org

Hello,

(please always reply-to-all)

On Tue, Jan 25, 2011 at 10:35:29AM +0000, Dave Howorth wrote:
> dmesg               http://pastebin.com/FF3ZtcXy
> lspci               http://pastebin.com/u5y8XrWm
> smartctl-a-dev-sda  http://pastebin.com/m5YNRw2t
> var-log-messages    http://pastebin.com/mVrkyTF2

Hmmm....

> Yes, a hardware glitch does seem the strongest candidate. But the newish
> kernel does seem to make it completely solid AFAICT. Cash-wise my
> alternative is a new mobo, cpu, ram & psu so there's a bit of an
> incentive to persevere. But mostly I guess it's just a perverse desire
> to understand what's going on that is driving me.

Oh, I love bug reporters with such desire.  I love you. :-)

> I suppose I could try various kernel versions to see if it's possible to
> isolate one change that causes the improved behaviour. That would be a
> bit of a learning curve and I'm not sure how much time it would need.

Yes, that definitely would be a good idea.  The first thing I would
try is disabling the VIA FIFO workaround completely and see whether
that makes any difference.  ie. Comment out the last section of
svia_configure() in the latest kernel and see if the problems occur
again.

If that's the case, it could be that you were seeing two separate
problems on via and sil.  Digging down what sil was complaining about
would be interesting in that case.

If that's not the case, it could be something which seems unrelated -
some ACPI or cpufreq change or whatnot.  The best way to find out
would be bisection.

Thanks.

-- 
tejun
