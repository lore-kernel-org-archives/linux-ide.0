From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] major libata update
Date: Wed, 17 May 2006 12:05:01 +0900
Message-ID: <446A92DD.4040201@gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A63F6.5030706@gmail.com> <446A6615.6050701@garzik.org> <446A678E.8030403@garzik.org> <446A6E6F.8010201@gmail.com> <446A7794.80909@garzik.org> <446A7BF6.3090103@gmail.com> <446A89D3.60002@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:36919 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751183AbWEQDFN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 23:05:13 -0400
Received: by wr-out-0506.google.com with SMTP id i3so123727wra
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 20:05:12 -0700 (PDT)
In-Reply-To: <446A89D3.60002@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: ric@emc.com, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>

Jeff Garzik wrote:
> A spurious SDB FIS updating SActive is bad news, yes.  But with a busy 
> AHCI controller, perhaps sharing PCI interrupts, I think there is 
> distinct potential to be flagged as a spurious interrupt, when not.

You are talking about cases where the controller raises SDB IRQ without 
actually receiving one, right?  That is certainly possible and if this 
is the case, I'm very okay with eating the IRQ.

> But I'm taking a higher level view than that, from two angles:
> 
> 1) I think its a waste of time to even worry about this.  We should just 
> program AHCI to spec, and  let the controller and devices talk to each 
> other as they will.  If there are spurious completions, that should show 
> up elsewhere via tag poisoning and/or tag rotation.  Or data corruption, 
> if nothing else.  We'll know, even without the potentially-questionable 
> spurious interrupt detection code.
> 
> 2) Given the factors mentioned above -- shared irq and busy 
> multi-controller controller -- highly asynchronous conditions combine to 
> create a higher probability of seeing events arrive while you're 
> processing other events.  Overall, I feel that trying to accurately 
> account for everything going on in silicon leads to madness and 
> complexity :)  Just hand things to silicon, and trust that it either 
> accurately accounts SDB FISs, or will be quite obviously broken under 
> stress.

I see your point.  But I'm quite worried about this one, because

* This won't occur often and even when it occurs at the hardware level, 
it might be masked by processing delays in the kernel.  But when it 
blows, it will corrupt data silently.  We might not see such a report 
for months and even when it strikes pinpointing the origin will be 
extremely difficult.

* The danger of the race condition is not theoretical.  I think I can 
trigger it with AHCI.  AHCI delegates management of SActive register to 
the driver.

Remember the lost command completion bug in very early AHCI NCQ 
implementation?  It was caused by setting SActive after issuing the 
command.  Command completion SDB was received before SActive was cleared 
and when the IRQ handler kicks in afterward, it saw the bit which was 
set after completion and thus couldn't complete the command resulting in 
timeout.

This problem is similar except that it's the other way around.  From 
ahci_qc_issue()...

	if (qc->tf.protocol == ATA_PROT_NCQ)
		writel(1 << qc->tag, port_mmio + PORT_SCR_ACT);
	writel(1 << qc->tag, port_mmio + PORT_CMD_ISSUE);

Let's say we insert mdelay(10) between SActive setting and actual 
command issuance.  It will drastically increase the chance of receiving 
the spurious SDB FISes inbetween.  The following sequence is likely when 
such event occurs.

1. driver sets SActive bit for tag x
2. disk issues spurious SDB completion for tag x
3. ahci receives the SDB FIS, clears the corresponding SActive bit and 
raises interrupt
4. driver issues command for tag x and complete command issuance
5. IRQ handler kicks in sees that SActive for tag x is clear and 
completes the corresponding qc.
6. we now have data corruption.

I want to emphasize that SActive manipulation correctness is highly 
critical for NCQ integrity.  It's the thin thread the whole NCQ protocol 
hangs on.  Spurious SDB FIS amounts to random command completion without 
synchronization.  This is a serious problem which requires handling and 
I'm pretty sure I'm not being paranoid here.

I think detection of this problem proves the necessity for spurious 
interrupt reporting, at least until NCQ driver and hardware mature.  We 
still don't know how drives act with NCQ commands and definitely need to 
learn what sorts of culprits they have and how to work around them.  The 
spurious interrupt handling allows us to detect and diagnose such 
problems much better.

Am I making any sense?  I really wish I could write better.  Please give 
it some thoughts even if my writing sucks.  :-)

-- 
tejun
