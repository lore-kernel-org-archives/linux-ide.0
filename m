From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream 2/2] libata: implement spurious irq handling
 for SFF and apply it to piix
Date: Thu, 21 Jan 2010 11:52:52 -0500
Message-ID: <4B588664.4040602@garzik.org>
References: <4B550EF8.1000009@kernel.org> <4B550F9F.80503@kernel.org> <4B575A84.3030005@garzik.org> <4B579582.4050806@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:55757 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127Ab0AUQwy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jan 2010 11:52:54 -0500
Received: by gxk9 with SMTP id 9so176719gxk.8
        for <linux-ide@vger.kernel.org>; Thu, 21 Jan 2010 08:52:53 -0800 (PST)
In-Reply-To: <4B579582.4050806@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Hans Werner <hwerner4@gmx.de>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On 01/20/2010 06:45 PM, Tejun Heo wrote:
> Hello,
>
> On 01/21/2010 04:33 AM, Jeff Garzik wrote:
>> Overall, as long as the drive is in Bus-Idle mode, it should be safe to
>> go ahead and read Status, for pretty much every controller and drive.
>
> Hmmm... I was a bit worried about the case Alan mentioned several
> times where access to AltStatus while data transfer is going on can
> lead to silent data corruption.

If a drive is in Bus-Idle, as I mentioned, then there is no active data 
transfer.


>> I would make exception only for the new SATA FIS-based controllers,
>> where we know that hitting Status is likely both pointless and wasteful,
>> as well as being superfluous because the newer FIS-based controllers all
>> have irq status registers.
>
> FIS-based ones need their own interrupt handlers anyway so,
> fortunately, things like irq_check callback isn't necessary to begin
> with.  :-)

Yep.


>> Additionally, I think we should have a "fast-timeout" and
>> "slow-timeout", whereby we check Status after a short period (5
>> seconds?) to make sure we did not lose an interrupt.  If Status is !BSY,
>> then we can proceed with handling qc success/failure immediately.
>
> Does this happen often?  What I find more common is just plain
> timeouts, so I think it would improve our exception latency if we
> apply different timeouts for each trial.  ie. For the first RW try,
> set the timeout to 7 secs.  For the second, 15 and then to 30.  This
> wouldn't harm the correctness while allowing libata to react much
> faster to transient failures.

Lost interrupts do not happen often, but they do happen.  Google finds 
plenty of examples.


> Another thing is I can think of which can improve our robustness is
> dynamic irqpoll support such that when screaming IRQ happens, IRQ
> subsystem not only shuts down the IRQ line but also begins selectively
> irqpolling it.

Does this ever happen when data transfer is active?  AFAIK this happens 
during probe or reset or set-xfer or bus-idle or some other auxiliary 
moment in time.

	Jeff



