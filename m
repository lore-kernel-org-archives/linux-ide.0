From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream 2/2] libata: implement spurious irq handling
 for SFF and apply it to piix
Date: Fri, 22 Jan 2010 09:36:36 +0900
Message-ID: <4B58F314.9070606@kernel.org>
References: <4B550EF8.1000009@kernel.org> <4B550F9F.80503@kernel.org> <4B575A84.3030005@garzik.org> <4B579582.4050806@kernel.org> <4B588664.4040602@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55113 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898Ab0AVAem (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Jan 2010 19:34:42 -0500
In-Reply-To: <4B588664.4040602@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Hans Werner <hwerner4@gmx.de>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On 01/22/2010 01:52 AM, Jeff Garzik wrote:
>> Hmmm... I was a bit worried about the case Alan mentioned several
>> times where access to AltStatus while data transfer is going on can
>> lead to silent data corruption.
> 
> If a drive is in Bus-Idle, as I mentioned, then there is no active data
> transfer.

Oh, you meant reading status instead of altstatus?

>> Does this happen often?  What I find more common is just plain
>> timeouts, so I think it would improve our exception latency if we
>> apply different timeouts for each trial.  ie. For the first RW try,
>> set the timeout to 7 secs.  For the second, 15 and then to 30.  This
>> wouldn't harm the correctness while allowing libata to react much
>> faster to transient failures.
> 
> Lost interrupts do not happen often, but they do happen.  Google finds
> plenty of examples.

Yeap, but genuine timeouts seem to happen more commonly and shortening
initial timeout would also work for non-SFF controllers, so I think
it would be better to do that instead.

>> Another thing is I can think of which can improve our robustness is
>> dynamic irqpoll support such that when screaming IRQ happens, IRQ
>> subsystem not only shuts down the IRQ line but also begins selectively
>> irqpolling it.
> 
> Does this ever happen when data transfer is active?  AFAIK this happens
> during probe or reset or set-xfer or bus-idle or some other auxiliary
> moment in time.

It usually does but there are other components too.  A USB host in my
x61s often causes IRQ storm after STR cycle.  There also was a strange
I2C device which shared IRQ line with ATA controller and killed the
IRQ line when the system status changed.  It's just that with
shareable IRQs, there's no reason the kernel should be this
vulnereable to these not-so-uncommon failure modes.

Thanks.

-- 
tejun
