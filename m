From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: disable_irq() during polling IDENTIFY (take 2)
Date: Tue, 08 May 2007 14:57:21 +0200
Message-ID: <464073B1.80303@gmail.com>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com>	<463F0B25.40103@tw.ibm.com>	<463F0DAD.5060307@gmail.com>	<463F1374.1010100@tw.ibm.com>	<463F1509.30100@gmail.com>	<46405F50.5090901@tw.ibm.com>	<20070508130025.7693980c@the-village.bc.nu>	<464066A4.1010008@gmail.com>	<20070508132046.70a4d9ed@the-village.bc.nu>	<46406C9A.4000802@gmail.com> <20070508134540.509f4704@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:3329 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966752AbXEHM5h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 08:57:37 -0400
Received: by py-out-1112.google.com with SMTP id a29so1469040pyi
        for <linux-ide@vger.kernel.org>; Tue, 08 May 2007 05:57:36 -0700 (PDT)
In-Reply-To: <20070508134540.509f4704@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>
Cc: albertl@mail.com, albertcc@tw.ibm.com, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

Alan Cox wrote:
>> So, are you suggesting pushing data transfer or the whole HSM to
>> workqueue?  I'm all for that.  I just thought it didn't make sense to
> 
> I was thinking data transfer but HSM itself might work too, I'd not even
> thought of push that much out.

I thought pushing the whole HSM out to workqueue will be the simplest to
implement as we already have everything needed for polling.

>> Anyways, if that's the plan, as Albert suggested earlier, we can just
>> mark that HSM is running in ap->pflags or somewhere and skip Status
>> clearing if it's running.  It's not like the controller is gonna raise
>> interrupt while it's transferring data anyway (we always have leading
>> status checks before data transfer).
> 
> And the controllers with a hidden FIFO magically defer the IRQ until the
> FIFO empties so that the events occur in the expected sequence for the
> spec even if the drive transfer to the fifo already finished and the host
> is still emptying it.

Yeah, that sadly makes things a bit tricky tho.  We need to make the
last transfer and clearing HSM running flag atomic; otherwise, we're
likely to get nobody-cared right after we finish the last transfer.

I guess it's about time to listen what Jeff thinks.

Albert, if Jeff agrees with pushing HSM or data transfer to workqueue,
are you interested in doing that?  The HSM is your baby after all.  :-)

Thanks.

-- 
tejun
