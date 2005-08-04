From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH linux-2.6.13-rc3] SATA: rewritten sil24 driver
Date: Thu, 4 Aug 2005 11:20:25 +0900
Message-ID: <20050804022025.GA19237@htj.dyndns.org>
References: <20050728013622.GA14026@htj.dyndns.org> <42E93FB9.6090800@pobox.com> <20050730081734.GA14242@htj.dyndns.org> <42EFFA05.8010003@google.com> <42F04361.4020001@pobox.com> <20050803142812.GA25446@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.192]:21134 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261710AbVHDCUa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Aug 2005 22:20:30 -0400
Received: by wproxy.gmail.com with SMTP id i20so34513wra
        for <linux-ide@vger.kernel.org>; Wed, 03 Aug 2005 19:20:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20050803142812.GA25446@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Edward Falk <efalk@google.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Carlos Pardo <Carlos.Pardo@siliconimage.com>

 Hello, Edward.

 One more question.

> > >
> > >I think this will work (adapted from sil_interrupt():
> > >
> > >static void sil_irq_clear(struct ata_port *ap)
> > >{
> > >        struct sil_port_priv *pp = ap->private_data;
> > >        struct Port_Registers *port_base = pp->pregs;
> > >    unsigned long port_int;
> > >
> > >    port_int  = readl((void *)&port_base->IntStatus);
> > >    writel(port_int, &port_base->IntStatus);
> > >}
> > >
> > >I'm assuming that this entry point is expected to clear all interrupts, no?
> > 
> > Correct.
> > 
> 
>  I'll verify with the error register clearing part of the original
> driver and submit a patch.
> 

 Command completion interrupt is automatcally cleared by reading
PORT_SLOT_STAT register (SlotStatus in the original driver), and error
registers should be manually cleared by writing to PORT_IRQ_STAT
(IntStatus).

 I agree that above code should clear both.  Just wanna verify.  Have
you tested it and/or do you have any information confirming this?  If
we don't have any further info, I think we should read PORT_SLOT_STAT
before clearing PORT_IRQ_STAT to be on the safe side.

 Thanks.

-- 
tejun
