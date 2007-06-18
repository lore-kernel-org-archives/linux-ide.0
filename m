From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH/RFC 5/9] libata: use freeze()/thaw() for polling
Date: Mon, 18 Jun 2007 14:13:25 +0900
Message-ID: <46761475.8080509@gmail.com>
References: <46720353.90209@tw.ibm.com> <4672067B.5070609@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:13965 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbXFRFNc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 01:13:32 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2037280wah
        for <linux-ide@vger.kernel.org>; Sun, 17 Jun 2007 22:13:31 -0700 (PDT)
In-Reply-To: <4672067B.5070609@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <mlord@pobox.com>

Hello,

Albert Lee wrote:
> Patch 5/9:
> 
>   This patch changes polling codes to use freeze()/thaw() for irq off/on.
> ata_qc_set_polling() is also removed since now unused.
> 
> The reason for freeze()/thaw(): some ATAPI devices raises INTRQ even if nIEN = 1.
> Using the host adapter irq mask mechanism, if available, is more reliable than using the device nIEN bit.
> 
> Considerations:
>  1. the semantic of freeze()/thaw() maybe more than irq off/on?

It usually is irq off/on.

>  2. HSM, the new user of freeze()/thaw(), will call freeze()/thaw() more frequently than EH.
>     Can current implemention of freeze()/thaw() handle it?

Yeah, I don't see any reason why it can't be used that way but please
audit each freeze/thaw implementation.

> @@ -5442,7 +5442,7 @@ unsigned int ata_qc_issue_prot(struct at
>  
>  	case ATA_PROT_PIO:
>  		if (qc->tf.flags & ATA_TFLAG_POLLING)
> -			ata_qc_set_polling(qc);
> +			ap->ops->freeze(ap);
>  
>  		ata_tf_to_host(ap, &qc->tf);

Wouldn't ata_tf_load() change the ctl value to qc->tf.ctl when issuing
the command?

I'm not really sure about this change because most controller which have
dedicated IRQ mask bit also have dedicated IRQ pending bit (and probably
IRQ clear bit too).  With those bits, IRQ during polling is not a big
problem (sata_sil for example).  So, the change doesn't really help the
controllers which actually have problems dealing with devices which
raise IRQ regardless of ATA_NIEN.

I don't see any easy way out other than manipulating host IRQ on/off as
IDE does.  If we choose to go that way, we can use them in
ata_bmdma_freeze/thaw (they should be named ata_sff_freeze/thaw really)
and use this patch on top of it.  Maybe it's better to drop ->freeze()
and ->thaw() altogether and use ->irq_on() and ->irq_off() instead.
Their names are more intuitive IMHO but that's minor.

Jeff, Alan, what do you think about adopting IDE's irq off/on mechanism.
 It's ugly and may cause some problems if the IRQ is shared but then
again it has been used for a long time without too much problem and
occasional lost IRQ is much better than dead machine due to screaming
IRQs followed by nobody cared.

Thanks.

-- 
tejun
