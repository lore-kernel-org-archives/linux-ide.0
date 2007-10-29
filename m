From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream 1/2] libata: relocate forcing PIO0 on reset
Date: Mon, 29 Oct 2007 06:22:22 -0400
Message-ID: <4725B45E.6070003@garzik.org>
References: <20071029074109.GO11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50437 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753128AbXJ2KWZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Oct 2007 06:22:25 -0400
In-Reply-To: <20071029074109.GO11853@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Forcing PIO0 on reset was done inside ata_bus_softreset(), which is a
> bit out of place as it should be applied to all resets - hard, soft
> and implementation which don't use ata_bus_softreset().  Relocate it
> such that...
> 
> * For new EH, it's done in ata_eh_reset() before calling prereset.
> 
> * For old EH, it's done before calling ap->ops->phy_reset() in
>   ata_bus_probe().
> 
> This makes PIO0 forced after all resets.  Another difference is that
> reset itself is done after PIO0 is forced.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

applied 1-2 to #upstream-fixes, after renaming existing #upstream to 
#upstream-fixes (thereby assuring those previous changesets will go 
upstream sooner)


