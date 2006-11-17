From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2/2] libata: make sure IRQ is cleared after ata_bmdma_freeze()
Date: Thu, 16 Nov 2006 22:27:58 -0500
Message-ID: <455D2C3E.8010509@rtr.ca>
References: <20061117030621.GD2184@htj.dyndns.org> <20061117030750.GE2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:58887 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1424760AbWKQD2A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Nov 2006 22:28:00 -0500
In-Reply-To: <20061117030750.GE2184@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> 
> Note that ->freeze() handler is always called under ap->lock held and
> irq disabled.  Even if CTL manipulation causes stuck IRQ, it's cleared
> immediately.  This should be safe (enough) even in SMP environment.
> More correct solution is to mask the IRQ from IRQ controller but that
> would be an overkill.

Could this possibly lead to a "nobody cared" message from the IRQ layer,
followed by the kernel then disabling this IRQ?

Just wondering, because that's what can happen if we trigger an IRQ
but then don't report "handled" for it from our interrupt handler.

I'm puzzling through a similar situation in sata_qstor right now,
and the fix will involve manipulating the NIEN bit, with the same risk.

???

Thanks
