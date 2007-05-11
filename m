From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 5/7] libata: move and reduce locking to the pio data
 xfer functions
Date: Fri, 11 May 2007 18:46:51 +0100
Message-ID: <20070511184651.0543d5ac@the-village.bc.nu>
References: <463EAB4D.3000309@tw.ibm.com>
	<463ED8B9.4060501@gmail.com>
	<463F0B25.40103@tw.ibm.com>
	<463F0DAD.5060307@gmail.com>
	<463F1374.1010100@tw.ibm.com>
	<463F1509.30100@gmail.com>
	<46405F50.5090901@tw.ibm.com>
	<20070508130025.7693980c@the-village.bc.nu>
	<464066A4.1010008@gmail.com>
	<20070508132046.70a4d9ed@the-village.bc.nu>
	<46406C9A.4000802@gmail.com>
	<20070508134540.509f4704@the-village.bc.nu>
	<464073B1.80303@gmail.com>
	<4644192A.8090809@tw.ibm.com>
	<46441CA9.4030109@tw.ibm.com>
	<46447FB5.3040306@gmail.com>
	<20070511155504.37e12a12@the-village.bc.nu>
	<46448469.7070704@gmail.com>
	<20070511161252.14b61207@the-village.bc.nu>
	<4644885B.3050006@gmail.com>
	<20070511163953.5060c670@the-village.bc.nu>
	<4644A109.6010704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60729 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754492AbXEKRmv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 13:42:51 -0400
In-Reply-To: <4644A109.6010704@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

> > 	clear_bit(COMPLETION_RUN, ->flags);
> > 	xfer bytes
> > 	if (test_and_set_bit(COMPLETION_RUN, ->flags) == 0)
> > 		run_completion_routine();
> > 	->active-ignore-irq = 0;
> > 
> > and in the IRQ case after checking we are not active-ignore-IRQ we
> > similarly do
> > 
> > 	if (test_and_set_bit(COMPLETION_RUN, ->flags) == 0)
> > 		run_completion_routine_irq();
> > 
> > Now if we are unlucky and the IRQ gets in between the last byte of
> > transfer and clearing the active ignore IRQ flag we will still run the
> > completion handler
> 
> I don't really get this.  What happens if the IRQ is shared and the
> other device raises interrupt while the data transfer is still in
> progress?  What prevents it from running the completion routine?

Before the transfer begins you set your flag to indicate you want to
ignore this IRQ. You then set the flag indicating completion has not
occurred.

Next you do the data transfer

An IRQ during the transfer will not complete as we are ignoring the
IRQ/polling at the driver level.

On completion either

a) the IRQ beats the test_and_set_bit in which case it runs the completion

or

b) the test_and_set_bit in the I/O path beats the IRQ handler in which
case the IRQ handler will not run the completion as the bit is atomically
set

or

c) the IRQ beats the clearing of the ignore irq flag in which case it
won't execute the handler but the data transfer path will


I'm sure there are even simpler ways we can do this they key is to make
sure that whatever the event order we only run the completion path once,
and it doesn't matter which path runs it.

