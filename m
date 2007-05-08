From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: disable_irq() during polling IDENTIFY (take 2)
Date: Tue, 08 May 2007 14:27:06 +0200
Message-ID: <46406C9A.4000802@gmail.com>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com>	<463F0B25.40103@tw.ibm.com>	<463F0DAD.5060307@gmail.com>	<463F1374.1010100@tw.ibm.com>	<463F1509.30100@gmail.com>	<46405F50.5090901@tw.ibm.com>	<20070508130025.7693980c@the-village.bc.nu>	<464066A4.1010008@gmail.com> <20070508132046.70a4d9ed@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:41217 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934430AbXEHM1T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 08:27:19 -0400
Received: by py-out-1112.google.com with SMTP id a29so1460948pyi
        for <linux-ide@vger.kernel.org>; Tue, 08 May 2007 05:27:18 -0700 (PDT)
In-Reply-To: <20070508132046.70a4d9ed@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: albertl@mail.com, albertcc@tw.ibm.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

Hello,

Alan Cox wrote:
>> Oh well, that's how we do PIO data transfer when not polling anyway.  We
>> kick HSM directly from the interrupt handler and do PIO inside the
>> interrupt handler.  The change made here is to make polling PIO act the
>> same way.
> 
> Which is making a horrendous problem worse than it was before. In PIO CD
> mode I'm actually losing serial characters and time its that bad.

Yeap, things get pretty choppy in PIO mode.

> Right now we can push the pio transfer out to run after the IRQ handler a
> variety of ways and the locking for it isn't too bad. Make this change
> and we are sunk.

So, are you suggesting pushing data transfer or the whole HSM to
workqueue?  I'm all for that.  I just thought it didn't make sense to
NACK the patch because it grabs locks while doing polling PIO, which
mostly happens only for EH commands when we do all the heavy lifting PIO
directly from the interrupt handler.

Anyways, if that's the plan, as Albert suggested earlier, we can just
mark that HSM is running in ap->pflags or somewhere and skip Status
clearing if it's running.  It's not like the controller is gonna raise
interrupt while it's transferring data anyway (we always have leading
status checks before data transfer).

One thing I'm worried about is that somehow I'm thinking there are
controllers/devices out there which choke if there PIO data transfer is
interrupted (timing-wise).  Is this something I just imagined up?

Thanks.

-- 
tejun
