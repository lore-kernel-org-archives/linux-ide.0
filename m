From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: implement BROKEN_HPA horkage and apply it to
 HDS724040KLSA80
Date: Tue, 7 Aug 2007 16:25:29 +0100
Message-ID: <20070807162529.1781b21c@the-village.bc.nu>
References: <20070807054250.GQ13674@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36118 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750888AbXHGPSw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 11:18:52 -0400
In-Reply-To: <20070807054250.GQ13674@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org, kelk1@comcast.net, lcapitulino@mandriva.com.br

On Tue, 7 Aug 2007 14:42:50 +0900
Tejun Heo <htejun@gmail.com> wrote:

> HDS724040KLSA80 reports that it supports HPA && LBA48 but craps itself
> on READ_NATIVE_MAX_EXT.  Implement BROKEN_HPA horkage and apply it to
> the drive.  If the horkage is set, all HPA operations are skipped.

I'd rather know what is going on here. A drive can legitimately
support LBA48 and HPA and refuse READ_NATIVE_MAX_EXT. In addition just
about every OS I know queries the HPA which means that something other
than HPA support being broken is probably at the root. We thus want to
find the real fix.

What do the actual traces look like ?

Does it crap out of it gets READ_NATIVE_MAX ?

> 
> While at it, make HPA test a bit more reliable by also checking
> ata_id_has_hpa().

>  
> -			if (ata_id_hpa_enabled(dev->id))
> +			if (!(dev->horkage & ATA_HORKAGE_BROKEN_HPA) &&
> +			    ata_id_has_hpa(id) && ata_id_hpa_enabled(dev->id))
>  				dev->n_sectors = ata_hpa_resize(dev);

A drive cannot set hpa_enabled without setting has_hpa so this does
nothing and I've never seen a drive d what you try to cover here. I'd
like to see actual evidence.

