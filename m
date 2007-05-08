From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: disable_irq() during polling IDENTIFY (take 2)
Date: Tue, 8 May 2007 13:45:40 +0100
Message-ID: <20070508134540.509f4704@the-village.bc.nu>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58432 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S934367AbXEHMmd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 08:42:33 -0400
In-Reply-To: <46406C9A.4000802@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, albertcc@tw.ibm.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

> So, are you suggesting pushing data transfer or the whole HSM to
> workqueue?  I'm all for that.  I just thought it didn't make sense to

I was thinking data transfer but HSM itself might work too, I'd not even
thought of push that much out.

> Anyways, if that's the plan, as Albert suggested earlier, we can just
> mark that HSM is running in ap->pflags or somewhere and skip Status
> clearing if it's running.  It's not like the controller is gonna raise
> interrupt while it's transferring data anyway (we always have leading
> status checks before data transfer).

And the controllers with a hidden FIFO magically defer the IRQ until the
FIFO empties so that the events occur in the expected sequence for the
spec even if the drive transfer to the fifo already finished and the host
is still emptying it.
