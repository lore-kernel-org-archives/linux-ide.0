From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 8/8] libata: ack more unsolicited INTRQ
Date: Thu, 17 May 2007 10:28:05 +0100
Message-ID: <20070517102805.1f5add4b@the-village.bc.nu>
References: <464AACDF.1030903@tw.ibm.com>
	<464AB2F3.7030103@tw.ibm.com>
	<20070516140201.29d0f6f0@the-village.bc.nu>
	<464C1972.6050205@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53825 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754612AbXEQJYT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 May 2007 05:24:19 -0400
In-Reply-To: <464C1972.6050205@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: albertcc@tw.ibm.com, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>

> Even if the unsolicited irq happens, maybe the current code has
> good chance to handle it?
> e.g. ata_irq_task() already reads the status before data transfer,
> thus possibly clearing some of unsolicited irqs.
> e.g. maybe the data transfer in the workqueue is quick enough?

Probably not given the PIO cycle time.

> If yes, hopefully the ATA_PFLAG_HSM_WQ is soon cleared, and
> then the interrupt handler can come in ack the irq. (Much the same
> way when the irq handler encounters "early irq" by bad devices.)

We seem to have three classes of controller here

- Those that need IRQs off for transfers anyway (eg ancient VIA)
- Those that we must not touch the status bits for but can otherwise
  behave sanely (Some PIIX, ICH and possibly some others)
- Those that behave sanely

The first lot are really "No change" and not found on SMP boxes anyway
The final ones would I think work with your patch (some testing required)

The best I can see that we could do with the Intel ones would be to use
disable_irq/enable_irq, especially as they are rarely found in native
mode so usually have a private IRQ. The only problem is that we must
disable_irq before we take the other locks otherwise we can deadlock in
disable_irq waiting for the irq handlers to finish while the IRQ handler
is trying to take the lock so never does.


