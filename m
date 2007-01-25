From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_via: don't diddle with ATA_NIEN in ->freeze
Date: Thu, 25 Jan 2007 17:24:07 -0500
Message-ID: <45B92E07.2040904@pobox.com>
References: <20070125114659.GD8606@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40560 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030635AbXAYWYL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Jan 2007 17:24:11 -0500
In-Reply-To: <20070125114659.GD8606@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, j.taimr@chello.nl

Tejun Heo wrote:
> vt6420 completely loses its ability to raise IRQ for ATAPI devices if
> ATA_NIEN is diddled with in ->freeze.  Further investigation is
> necessary to determine whether this problem is shared on other
> controllers but it doesn't seem to be at this point.
> 
> Make vt6420's ->freeze only clear IRQ to fix this problem.  This makes
> vt6420 relatively more prone to IRQ storms but the controller is way
> too braindamaged to worry about that anyway.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Jeff, this fix is verified to fix J. Taimr's case and a few other
> reported that 2.6.20-rc5 fixed their ATAPI detection problems too.  We
> still have several case to hunt down but getting verified fixes in
> early helps separating different causes.  Please include this in
> #upstream-fixes.  Thanks.

applied to #upstream-fixes


> @@ -204,6 +205,15 @@ static void svia_scr_write (struct ata_p
>  	outl(val, ap->ioaddr.scr_addr + (4 * sc_reg));
>  }
>  
> +static void svia_noop_freeze(struct ata_port *ap)
> +{
> +	/* Some VIA controllers choke if ATA_NIEN is manipulated in
> +	 * certain way.  Leave it alone and just clear pending IRQ.
> +	 */
> +	ata_chk_status(ap);
> +	ap->ops->irq_clear(ap);
> +}
> +

please send an update patch to conform to the following minor libata 
policy nit:  when calling a hook inside a driver, you should call the 
hook function directly, rather than bothering with an indirect reference.

	Jeff


