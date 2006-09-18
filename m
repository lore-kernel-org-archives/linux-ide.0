From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Fix libata resource conflict for legacy mode
Date: Mon, 18 Sep 2006 22:48:42 +0900
Message-ID: <450EA3BA.8010100@gmail.com>
References: <m3ac4xiacr.fsf@anduin.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.204]:49466 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964934AbWIRNtM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Sep 2006 09:49:12 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1594790nzf
        for <linux-ide@vger.kernel.org>; Mon, 18 Sep 2006 06:49:11 -0700 (PDT)
In-Reply-To: <m3ac4xiacr.fsf@anduin.mandriva.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnaud Patard <apatard@mandriva.com>
Cc: linux-ide@vger.kernel.org

Hello,

Arnaud Patard wrote:
> 0100-01fe : pnp 00:09
>   0170-0177 : libata
>   01f0-01f7 : libata

Arghh...

[--snip--]
> Index: linux-2.6/drivers/scsi/libata-bmdma.c
> ===================================================================
> --- linux-2.6.orig/drivers/scsi/libata-bmdma.c
> +++ linux-2.6/drivers/scsi/libata-bmdma.c
> @@ -1016,10 +1016,13 @@ int ata_pci_init_one (struct pci_dev *pd
>  			res.start = 0x1f0;
>  			res.end = 0x1f0 + 8 - 1;
>  			conflict = ____request_resource(&ioport_resource, &res);
> +			if (conflict->child)
> +				conflict = ____request_resource(conflict,&res);

IMHO, having something which is slightly more generic would be better - 
e.g. looping till no child.

>  			if (!strcmp(conflict->name, "libata"))
>  				legacy_mode |= (1 << 0);
>  			else {
>  				disable_dev_on_err = 0;
> +				printk(KERN_WARNING "ata: conflict with %s\n",conflict->name);
>  				printk(KERN_WARNING "ata: 0x1f0 IDE port busy\n");

Please merge two printks into one.  Other than that, I think printing 
conflict name is nice addition.

>  			}
>  		} else

Thanks.

-- 
tejun
