From: Tejun Heo <htejun@gmail.com>
Subject: Re: Possibly SATA related freeze killed networking and RAID
Date: Fri, 30 Nov 2007 09:02:21 +0900
Message-ID: <474F530D.8090302@gmail.com>
References: <d00698fb0711201109m23ff096eiabeb22c8f9a917dc@mail.gmail.com> <20071120220512.46b9e975@the-village.bc.nu> <20071126120649.GC4701@ucw.cz> <474CCA82.7030000@gmail.com> <474F3A4B.3080304@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:50160 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763598AbXK3ACa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 19:02:30 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2453309wah
        for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 16:02:28 -0800 (PST)
In-Reply-To: <474F3A4B.3080304@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>, noah <noah123@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Phillip Susi wrote:
> Tejun Heo wrote:
>> Agreed.  Nobody cared on ATA controllers is usually very effective at
>> taking the whole machine down.  Is there any reason why we don't turn on
>> irqpoll on turned off IRQs automatically?
> 
> Why does a single spurious interrupt cause it to be shut down?  I can
> see if the interrupt is stuck on and keeps interrupting constantly, but
> if it's just the occasional spurious interrupt, why not just ignore it
> and move on?

Because SFF ATA controller don't have IRQ pending bit.  You don't know
whether IRQ is raised or not.  Plus, accessing the status register which
clears pending IRQ can be very slow on PATA machines.  It has to go
through the PCI and ATA bus and come back.  So, unconditionally trying
to clear IRQ by accessing Status can incur noticeable overhead if the
IRQ is shared with devices which raise a lot of IRQs.

-- 
tejun
