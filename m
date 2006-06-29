From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/9] libata: change debugging macros/adjust dbg levels
Date: Fri, 30 Jun 2006 01:27:30 +0900
Message-ID: <44A3FF72.8090404@gmail.com>
References: <20060629160926.GB23122@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:13210 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750914AbWF2Q1N (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 12:27:13 -0400
Received: by nf-out-0910.google.com with SMTP id a4so101088nfc
        for <linux-ide@vger.kernel.org>; Thu, 29 Jun 2006 09:27:12 -0700 (PDT)
In-Reply-To: <20060629160926.GB23122@zmei.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Hello,

Generally looks good to me.  Just a few comments.

Borislav Petkov wrote:
> change debugging macros ata_(port|dev)_printk and adjust debugging levels
> 
> Signed-off-by: <petkov@math.uni-muenster.de>
> 
> 
> --- libata-dev/include/linux/libata.h	2006-06-29 17:17:50.000000000 +0200
> +++ libata-dev/include/linux/libata.h.new	2006-06-28 17:23:30.000000000 +0200
> @@ -67,24 +67,26 @@
>  #define HAVE_LIBATA_MSG 1
>  
>  enum {
> -	ATA_MSG_DRV	= 0x0001,
> -	ATA_MSG_INFO	= 0x0002,
> -	ATA_MSG_PROBE	= 0x0004,
> -	ATA_MSG_WARN	= 0x0008,
> -	ATA_MSG_MALLOC	= 0x0010,
> -	ATA_MSG_CTL	= 0x0020,
> -	ATA_MSG_INTR	= 0x0040,
> -	ATA_MSG_ERR	= 0x0080,
> -};
> -
> -#define ata_msg_drv(p)    ((p)->msg_enable & ATA_MSG_DRV)
> -#define ata_msg_info(p)   ((p)->msg_enable & ATA_MSG_INFO)
> -#define ata_msg_probe(p)  ((p)->msg_enable & ATA_MSG_PROBE)
> -#define ata_msg_warn(p)   ((p)->msg_enable & ATA_MSG_WARN)
> -#define ata_msg_malloc(p) ((p)->msg_enable & ATA_MSG_MALLOC)
> -#define ata_msg_ctl(p)    ((p)->msg_enable & ATA_MSG_CTL)
> -#define ata_msg_intr(p)   ((p)->msg_enable & ATA_MSG_INTR)
> -#define ata_msg_err(p)    ((p)->msg_enable & ATA_MSG_ERR)
> +	ATA_MSG_ERR	= 0x0001,
> +	ATA_MSG_WARN	= 0x0002,
> +	ATA_MSG_DRV	= 0x0004,

Comment for ATA_MSG_DRV please.  Also, I'm not sure we need separate DRV 
from INFO.

> +	ATA_MSG_INFO	= 0x0008, /* revalidation messages, EH progress */
> +	ATA_MSG_VDEBUG	= 0x0010, /* verbose hot path */
> +	ATA_MSG_CMD	= 0x0020, /* issue / completion */
> +	ATA_MSG_SG	= 0x0040, /* SG map/unmap handling */
> +	ATA_MSG_TRACE	= 0x0080, /* function tracing, e.g. enter/exit */
> +};
> +
> +const char *__ata_msg_lvs[] = {
> +	[ATA_MSG_ERR]	 = KERN_ERR,
> +	[ATA_MSG_WARN]	 = KERN_WARNING,
> +	[ATA_MSG_DRV]	 = KERN_INFO,
> +	[ATA_MSG_INFO]	 = KERN_INFO,
> +	[ATA_MSG_VDEBUG] = KERN_DEBUG,
> +	[ATA_MSG_CMD]	 = KERN_DEBUG,
> +	[ATA_MSG_SG]	 = KERN_DEBUG,
> +	[ATA_MSG_TRACE]	 = KERN_DEBUG
> +};

Please declare the array here and define it in libata-core.c.

>  static inline u32 ata_msg_init(int dval, int default_msg_enable_bits)
>  {
> @@ -805,11 +807,16 @@ extern void ata_do_eh(struct ata_port *a
>  /*
>   * printk helpers
>   */
> -#define ata_port_printk(ap, lv, fmt, args...) \
> -	printk(lv"ata%u: "fmt, (ap)->id , ##args)
> +#define ata_port_printk(ap, lv, fmt, args...) do { \
> +	if (unlikely((ap)->msg_enable & (0xFF & (lv)))) \
                                          ^^^^why?

> +		printk("%sata%u: "fmt, __ata_msg_lvs[lv], (ap)->id , ##args); \
> +} while (0)
>  
> -#define ata_dev_printk(dev, lv, fmt, args...) \
> -	printk(lv"ata%u.%02u: "fmt, (dev)->ap->id, (dev)->devno , ##args)
> +#define ata_dev_printk(dev, lv, fmt, args...) do { \
> +	if (unlikely((dev->ap)->msg_enable & (0xFF & (lv)))) \
                                               ^^^^ditto

> +		printk("%sata%u.%02u: "fmt, __ata_msg_lvs[lv], \
> +				(dev)->ap->id, (dev)->devno , ##args); \
> +} while (0)
>  
>  /*
>   * ata_eh_info helpers
> @@ -997,9 +1004,8 @@ static inline u8 ata_wait_idle(struct at
>  
>  	if (status & (ATA_BUSY | ATA_DRQ)) {
>  		unsigned long l = ap->ioaddr.status_addr;
> -		if (ata_msg_warn(ap))
> -			printk(KERN_WARNING "ATA: abnormal status 0x%X on port 0x%lX\n",
> -				status, l);
> +		ata_port_printk(ap, ATA_MSG_WARN, 
> +			"ATA: abnormal status 0x%X on port 0x%lX\n", status, l);
                          ^^^^^ you can drop the header.

-- 
tejun
