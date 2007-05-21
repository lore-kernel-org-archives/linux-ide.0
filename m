From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Allow a controller specific post bus reset method
Date: Mon, 21 May 2007 17:10:11 +0200
Message-ID: <4651B653.8010201@gmail.com>
References: <20070521152843.0f202d6b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:48625 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762697AbXEUPKg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 11:10:36 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1419100wra
        for <linux-ide@vger.kernel.org>; Mon, 21 May 2007 08:10:35 -0700 (PDT)
In-Reply-To: <20070521152843.0f202d6b@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, jeff@garzik.org
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> The IT821x firmware mode isn't smart enough to pass the post bus reset
> checks that libata does so allow it to be over-ridden. Not sure this is
> the best long term solution but it'll do for now.
> 
> Possibly a better option would be a libata-eh set of methods for
> controllers where we don't want to reset and re-identify devices.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc1-mm1/drivers/ata/libata-core.c linux-2.6.22-rc1-mm1/drivers/ata/libata-core.c
> --- linux.vanilla-2.6.22-rc1-mm1/drivers/ata/libata-core.c	2007-05-18 16:22:53.000000000 +0100
> +++ linux-2.6.22-rc1-mm1/drivers/ata/libata-core.c	2007-05-18 16:40:23.000000000 +0100
> @@ -3128,7 +3135,10 @@
>  	if (ata_check_status(ap) == 0xFF)
>  		return -ENODEV;
>  
> -	return ata_bus_post_reset(ap, devmask, deadline);
> +	if (ap->ops->bus_post_reset)
> +		return ap->ops->bus_post_reset(ap, devmask, deadline);
> +	else
> +		return ata_bus_post_reset(ap, devmask, deadline);
>  }

ata_bus_post_reset() is a separate function only because it was written
that way at the beginning.  It's really not a separate logical API and I
was thinking of folding it into ata_bus_softreset() or
ata_std_softreset() after old EH is gone.  Also it's a bit ugly to call
ap->ops->* from a ap->ops callback.  I think the correct solution here
is to write a separate ->softreset method.

Hmmm... I guess what's failing is the nsect==1 && lbal==1 test, right?
Jeff, do we really need that test?  dev0 doesn't clear BSY till PDIAG-
is asserted from dev1 anyway.  Maybe just limit the waiting there to a
few secs?

-- 
tejun
