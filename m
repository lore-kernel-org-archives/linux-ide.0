From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 8/8] libata: ack more unsolicited INTRQ
Date: Thu, 17 May 2007 11:25:59 +0200
Message-ID: <464C1FA7.20503@gmail.com>
References: <464AACDF.1030903@tw.ibm.com>	<464AB2F3.7030103@tw.ibm.com> <20070516140201.29d0f6f0@the-village.bc.nu> <464C1972.6050205@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.230]:2501 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995AbXEQJ0i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 May 2007 05:26:38 -0400
Received: by nz-out-0506.google.com with SMTP id r28so883816nza
        for <linux-ide@vger.kernel.org>; Thu, 17 May 2007 02:26:38 -0700 (PDT)
In-Reply-To: <464C1972.6050205@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>

Hello, Albert.

Albert Lee wrote:
> Back to the problem that the patch was trying to solve,
> i.e. unsolicited interrupt when HSM doing data transfer in the wq,
> is there any experience about how often such situation occurs?
> 
> IMHO, it seems not something that happens often. If the cable/devices
> are well configured, the intrq would mostly occur when it should.
> 
> Even if the unsolicited irq happens, maybe the current code has
> good chance to handle it?
> e.g. ata_irq_task() already reads the status before data transfer,
> thus possibly clearing some of unsolicited irqs.
> e.g. maybe the data transfer in the workqueue is quick enough?
> If yes, hopefully the ATA_PFLAG_HSM_WQ is soon cleared, and
> then the interrupt handler can come in ack the irq. (Much the same
> way when the irq handler encounters "early irq" by bad devices.)

The problem is that if you have only one cpu and the unsolicited IRQ
happens, you never get to execute any non-IRQ handler code.  IRQ is
raised immediately again when the IRQ handler is complete, so nothing
can be quick enough.

I don't really know how to fix this.  It seems the only options are 1.
disable_irq() as IDE does which sucks if the IRQ is shared 2. doing PIO
transfers with local IRQ disabled and spinlock locked which makes the
system stutter like hell.  Oh crap, all this because we don't have
simple reliable IRQ pending bit.  :-(

Oh, BTW, we do have reliable IRQ pending bit on ata_piix's.  The IRQ bit
in BMDMA status acts as a IRQ pending even if the command isn't a DMA
one.  This is why we clear BMDMA IRQ even after nodata or PIO commands,
so we can probably solve the problem nicely for ata_piix by calling
ata_port_freeze() if IRQ is received while ATA_PFLAG_HSM_WQ is set.
sata_sil also has reliable IRQ pending bit.

Thanks.

-- 
tejun
