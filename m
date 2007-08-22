From: Rusty Conover <rconover@infogears.com>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Wed, 22 Aug 2007 00:56:19 -0600
Message-ID: <D2865984-EF5E-400F-9B71-1F95363D4C3F@infogears.com>
References: <EA70552E-75C2-451D-BF58-A73482FBB14D@infogears.com> <46C5E3A6.9020907@gmail.com> <DFEB0E31-D017-4527-85A4-8D18D379CB0B@infogears.com> <98147300-A282-4909-A393-079365833BD8@infogears.com> <46CBA78D.2070405@gmail.com> <F3FDFA8B-A2EF-4EEE-ACE2-E67776650CF4@infogears.com> <46CBCD18.7070507@gmail.com> <B209C20A-580B-4AD6-A6A0-B4377499B8FC@infogears.com> <46CBDA17.6010009@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.infogears.com ([69.51.90.143]:41842 "EHLO
	mail.infogears.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbXHVG4W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 02:56:22 -0400
In-Reply-To: <46CBDA17.6010009@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org


On Aug 22, 2007, at 12:39 AM, Tejun Heo wrote:

> Does the attached patch make any difference?
>
> --  
> tejun
> ---
>  drivers/ata/libata-core.c |    1 +
>  1 file changed, 1 insertion(+)
>
> Index: work1/drivers/ata/libata-core.c
> ===================================================================
> --- work1.orig/drivers/ata/libata-core.c
> +++ work1/drivers/ata/libata-core.c
> @@ -6211,6 +6211,7 @@ int sata_link_init_spd(struct ata_link *
>  	spd = (scontrol >> 4) & 0xf;
>  	if (spd)
>  		link->hw_sata_spd_limit &= (1 << spd) - 1;
> +	link->hw_sata_spd_limit = 1
>
>  	link->sata_spd_limit = link->hw_sata_spd_limit;
>


Hi Tejun,

After adding a semicolon to the added line, and recompiling there are  
still timeouts like before on the PMP ports.

It did have the effect of setting the SATA speed to 1.5 rather then  
3.0 on boot though.

Thanks,

Rusty
