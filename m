From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 0/10] libata: irq_on/off restructuring
Date: Thu, 05 Jul 2007 19:48:34 +0900
Message-ID: <468CCC82.6050008@gmail.com>
References: <468B5C97.1000803@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:39132 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042AbXGEKsp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Jul 2007 06:48:45 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1813875nze
        for <linux-ide@vger.kernel.org>; Thu, 05 Jul 2007 03:48:44 -0700 (PDT)
In-Reply-To: <468B5C97.1000803@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Mark Lord <mlord@pobox.com>

Albert Lee wrote:
> For ATA, there are two levels of mechanism available to turn irq on/off.
> - device level: nIEN bit in the control register. This masks INTRQ from the device.
> - host adapter level: some controller can mask out per-port irq from the host adapter.
> 
> Currently various parts of libata deal with irq on/off.
>   ex. tf_load() can alter the nIEN bit.
>   ex. irq_on() also alters the device level nIEN bit.
>   ex. freeze()/thaw() deal with the host adapter irq mask.
> 
> It seems these irq on/off codes could be better structured.
> Patches against libata-dev tree for your review/advice, thanks.
> 
> 1/10: remove irq_on from ata_bus_reset() and ata_std_postreset()
> 2/10: add ->irq_off() for symmetry
> 3/10: implement ->irq_off() in LLDDs
> 4/10: use irq_off from bmdma_freeze()
> 5/10: use freeze()/thaw() for polling
> 6/10: add freeze()/thaw() to old EH LLDDs
> 7/10: pdc_freeze() semantic change
> 8/10: remove writing of tf->ctl from ata_tf_load()
> 9/10: integrate freeze()/thaw() with irq_on/off.
> 10/10: integrate freeze/thaw with irq_on/off in LLDDs

I like the whole series.  Just a few nits.

* 9 and 10 need to be oen patch.  As it currently stands, compile will
fail after 9.

* Please don't include "Patch n/10" in message body.

* Add freeze/thaw to all, merge, kill freeze/thaw from all sequence is a
bit odd.  It would be better if we can do things more directly but I
haven't thought about how that can be done too hard, so if it's too
difficult, it's probably not worth it.

Alan, Jeff, I think we'll need to do what IDE has been doing for IRQ
masking to get acceptable PIO behavior after all and that will also make
us more resistant against deadly IRQ storms on controllers which don't
have pending IRQ bits (most SFF ones), and this change will ease our way
toward that direction.  What do you guys think?

Thanks.

-- 
tejun
