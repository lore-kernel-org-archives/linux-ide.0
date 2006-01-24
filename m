From: Tejun Heo <htejun@gmail.com>
Subject: Re: PATCH convert libata-core to the new debugging scheme
Date: Tue, 24 Jan 2006 22:08:38 +0900
Message-ID: <43D626D6.60507@gmail.com>
References: <20060117105702.5e5a5cb5.randy_d_dunlap@linux.intel.com> <20060124090724.GA7897@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.200]:2906 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750942AbWAXNIp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jan 2006 08:08:45 -0500
Received: by xproxy.gmail.com with SMTP id i30so785259wxd
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2006 05:08:44 -0800 (PST)
In-Reply-To: <20060124090724.GA7897@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: Randy Dunlap <randy_d_dunlap@linux.intel.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Borislav Petkov wrote:
> On Tue, Jan 17, 2006 at 10:57:02AM -0800, Randy Dunlap wrote:
> Hi Jeff, Randy,
>    
>    here's a rehash against 2.6.16-rc1 of the 2nd patch I sent then but it somehow 
>    got lost along the way. It converts the libata-core.c to the new debugging scheme.
> 
>    Problem: In the ata_dev_classify() function we don't have access to an 
>    ata_host struct probably because we're still probing so maybe we'll have to 
>    print debugging statements in a different manner. Same for early init 
>    routines like ata_device_add(),  ata_probe_ent_alloc(), ata_pci_init_one().
> 
>    Also, Jeff, if you'd still like to have a way of setting/getting debugging 
>    levels from userspace, please elaborate more on that so that I have some
>    directions (ioctl, proc, etc).

I'm not Jeff, but my 5 Won (that's like half a cent) would be on sysfs. 
  People hate ioctl and proc these days.

> 
>    Thanks,
>    Boris.
> 
>    p.s. Please CC me since I'm not subscribed to the linux-ide ML.
> 
>    Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>
> 
> 
> --- 16-rc1/drivers/scsi/libata-core.c.orig	2006-01-21 09:42:53.000000000 +0100
> +++ 16-rc1/drivers/scsi/libata-core.c	2006-01-24 09:58:00.000000000 +0100
> @@ -115,13 +115,15 @@ static void ata_tf_load_pio(struct ata_p
>  		outb(tf->hob_lbal, ioaddr->lbal_addr);
>  		outb(tf->hob_lbam, ioaddr->lbam_addr);
>  		outb(tf->hob_lbah, ioaddr->lbah_addr);
> -		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
> -			tf->hob_feature,
> -			tf->hob_nsect,
> -			tf->hob_lbal,
> -			tf->hob_lbam,
> -			tf->hob_lbah);
> -	}
> +		if (ata_msg_ctl(ap)) 
> +			printk(KERN_DEBUG "%s: hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
> +				__FUNCTION__,
> +				tf->hob_feature,
> +				tf->hob_nsect,
> +				tf->hob_lbal,
> +				tf->hob_lbam,
> +				tf->hob_lbah);
> +		}

Wouldn't it be better to wrap 'if (ata_msg_ctl(ap)) printk' into some 
pretty macro?  Debug messages tend to be long and 8 characters can be 
used better.  IMHO, 'if' clauses for debug messages lower readability a bit.

-- 
tejun
