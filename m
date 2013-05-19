From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] make ata_exec_internal_sg honor DMADIR
Date: Mon, 20 May 2013 08:38:18 +0900
Message-ID: <20130519233818.GA4482@mtj.dyndns.org>
References: <CA+WQ+_13jrv6eKy7j5_Y8Tj0pvfnoWVWsb5JQtyttNONk84vKw@mail.gmail.com>
 <201305171920.11127.plr.vincent@gmail.com>
 <20130517184732.GD12632@mtj.dyndns.org>
 <201305191531.23110.plr.vincent@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:53876 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653Ab3ESXiW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 May 2013 19:38:22 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj3so5161684pad.15
        for <linux-ide@vger.kernel.org>; Sun, 19 May 2013 16:38:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201305191531.23110.plr.vincent@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vincent Pelletier <plr.vincent@gmail.com>
Cc: linux-ide@vger.kernel.org, Csaba =?iso-8859-1?Q?Hal=E1sz?= <csaba.halasz@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Hello,

On Sun, May 19, 2013 at 03:31:22PM +0200, Vincent Pelletier wrote:
> Now that I got it working, I'm thining it would be better to automatically 
> fallback to enabling DMADIR per-device level during initialisation (just like 
> current fallbacks to 1.5Gbps and UDMA/33:PIO3, as visible in 1/2 commit 
> message).
> I believe it will slow down boot when such device is plugged in, though, any 
> idea on how this can be avoided ?

I don't really wanna go that way.  Those bridges always have been
something fringe and broken in ways which aren't fundamentally
fixable.  Fixing one would break another without anyway to properly
detect them.

So, I'm okay with having a knob for cases where the user knows what to
do but I don't think even that is something of much importance, and
I'm definitely not gonna do anything which may affect !bridge case
adversely.  Those bridges have always been a second-class citizen and
their importance has waned a lot.

> > While better, please go into more details.  The problem here is that
> > the bridge requires DMADIR and while libata makes use of DMADIR for
> > regular commands, it doesn't do that for internal commands which are
> > used during EH, right?
> 
> Just to be clear about EH: the timeout happens during device  initialisation 
> (both at boot or on hotplug), not during error handling (or, maybe it happens 
> in both places, but for the same reason).
> I'm not comfortable with calling device discovery/initialisation as "error 
> handling", but maybe it's unambiguous when used to libata.

EH stands for exception handling and discovery / init definitely are
part of exception handling in libata speak.

> Subject: [1/2] libata: make ata_exec_internal_sg honor DMADIR
...
> ---
>  drivers/ata/libata-core.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 63c743b..d121db7 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1600,8 +1600,13 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
>  
>  	/* prepare & issue qc */
>  	qc->tf = *tf;
> -	if (cdb)
> +	if (cdb) {
>  		memcpy(qc->cdb, cdb, ATAPI_CDB_LEN);
> +		if ((dev->flags & ATA_DFLAG_DMADIR) &&
> +		    (dma_dir == DMA_FROM_DEVICE))
> +			/* some SATA bridges need us to indicate data xfer direction */
> +			qc->tf.feature |= ATAPI_DMADIR;
> +	}

So, nope, I really don't want this.

> Subject: [2/2] [RFC] libata: Add a per-device sysfs control for atapi_dmadir
...
> +atapi_dmadir
> +
> +	Bitmask enabling dmadir for corresponding device if ATAPI.
> +	1:	Enable dmadir for port's device 0
> +	2:	Enable dmadir for port's device 1
> +	(etc)
> +	See also libata's atapi_dmadir module parameter.

Shouldn't this be a device property?

Thanks.

-- 
tejun
