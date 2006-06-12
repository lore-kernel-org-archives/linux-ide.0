From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_sil: update device hotplug handling, take #2
Date: Mon, 12 Jun 2006 09:38:41 -0400
Message-ID: <448D6E61.1060704@pobox.com>
References: <20060612051822.GE9166@htj.dyndns.org> <448D04C5.9030603@pobox.com> <448D1AD7.3000807@gmail.com> <20060612094555.GA5751@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:61586 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751972AbWFLNio (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jun 2006 09:38:44 -0400
In-Reply-To: <20060612094555.GA5751@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> SIEN on some 3112 controllers doesn't mask SATA IRQ properly.  IRQ
> stays asserted even after SIEN is masked and IRQ is acked.  Also, even
> while frozen, any SATA PHY event including hardreset raises SATA IRQ.
> Clearing SError seems to be the only way to deassert SATA IRQ.
> 
> This patch makes sil_host_intr() clear SError on SATA IRQs and ignore
> SATA IRQs reported while frozen so that hardreset doesn't trigger
> hotplug event (which ends up hardresetting again).
> 
> In such cases, the port still gets re-frozen to minimize the danger of
> screaming interrupts.  This results in one nil EH repeat on
> controllers with broken SIEN but other than that does no harm.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
> Here's the revised version.  The PCMCIA 3112 controller simply cannot
> mask SATA IRQs w/ SIEN.  I've tested it w/ discrete 3112 and 3114
> cards and the PCMCIA one.  All work fine with this patch applied.

Applied.

Note that it is helpful to read the FreeBSD 311x driver, to see what 
error handling they use.  It seems like they reset the chip much more 
frequently than we do.

	Jeff



