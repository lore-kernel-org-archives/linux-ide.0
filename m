From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: disable_irq() during polling IDENTIFY (take 2)
Date: Tue, 08 May 2007 13:41:02 +0200
Message-ID: <464061CE.3030205@gmail.com>
References: <463EAB4D.3000309@tw.ibm.com> <463ED8B9.4060501@gmail.com> <463F0B25.40103@tw.ibm.com> <463F0DAD.5060307@gmail.com> <463F1374.1010100@tw.ibm.com> <463F1509.30100@gmail.com> <46405F50.5090901@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:4048 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967235AbXEHLlU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 07:41:20 -0400
Received: by py-out-1112.google.com with SMTP id a29so1450958pyi
        for <linux-ide@vger.kernel.org>; Tue, 08 May 2007 04:41:20 -0700 (PDT)
In-Reply-To: <46405F50.5090901@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>

Hello, Albert.

Just a few comments.

Albert Lee wrote:
> +			/* prevent ata_interrupt() from reading
> +			 * status when transfering data for safty
> +			 */
> +			if (in_wq)
> +				spin_lock_irqsave(ap->lock, flags);
> +

Can't we just remove in_wq and run the HSM the same way whether we're
invoking it from the interrupt handler or work queue?  The worker can
grab and release the lock outside of the HSM function and HSM can just
assume that it's running with lock held.  Am I missing something?

> @@ -5227,6 +5254,9 @@ irqreturn_t ata_interrupt (int irq, void
>  			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
>  			    (qc->flags & ATA_QCFLAG_ACTIVE))
>  				handled |= ata_host_intr(ap, qc);
> +			else
> +				/* ack possibly unexpected irq */
> +				ata_chk_status(ap);

I'm not so sure whether poking TF Status even when no command is flight
is a good idea.  The IRQ can be shared with a fairly busy device (e.g.
gigabit ethernet) and we'll be reading the status register a lot for
nothing.  I think we shouldn't do anything as before if no command is in
flight.

Also, please split it into two separate patches.  Both are pretty
significant changes and I think each deserves separate patch.

Thanks.

-- 
tejun
