From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] fix pata-rb532-cf
Date: Sat, 01 Nov 2008 19:26:34 +0300
Message-ID: <490C833A.7010702@ru.mvista.com>
References: <20081101160930.GA10321@nuty> <1225555965-27557-1-git-send-email-n0-1@freewrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:40248 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751612AbYKAQ0i (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Nov 2008 12:26:38 -0400
In-Reply-To: <1225555965-27557-1-git-send-email-n0-1@freewrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: linux-ide@vger.kernel.org

Hello.

Phil Sutter wrote:

> After applying the following changes I could verify functionality by
> mounting a filesystem on the cfdisk and reading/writing files in it.
>
> The symbols rb532_gpio_set_ilevel and rb532_gpio_set_istat are not yet
> available in a vanilla kernel, an appropriate patch has already been
> sent to the linux-mips mailinglist.
>
> Also change rb532_pata_data_xfer() so it reads and writes 4-byte blocks,
> like the original driver did. Rename the offset definition of the
> buffered data register for clearness.
>   


   Looks ike I'll have to NAK this part...

> diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
> index f8b3ffc..bdf413e 100644
> --- a/drivers/ata/pata_rb532_cf.c
> +++ b/drivers/ata/pata_rb532_cf.c
>   
[...]
> @@ -39,9 +40,11 @@
>  #define RB500_CF_MAXPORTS	1
>  #define RB500_CF_IO_DELAY	400
>  
> -#define RB500_CF_REG_CMD	0x0800
> +#define RB500_CF_REG_BASE	0x0800
>  #define RB500_CF_REG_CTRL	0x080E
> -#define RB500_CF_REG_DATA	0x0C00
> +/* 32bit buffered data register offset */
> +#define RB500_CF_REG_DBUF32	0x0C00
> +#define RB500_CF_REG_ERR	0x080D
>   

   Wouldn't hurt to have the macros in the ascending address order...

> @@ -72,21 +75,26 @@ static void rb532_pata_exec_command(struct ata_port *ap,
>  	rb532_pata_finish_io(ap);
>  }
>  
> -static void rb532_pata_data_xfer(struct ata_device *adev, unsigned char *buf,
> +static unsigned int rb532_pata_data_xfer(struct ata_device *adev, unsigned char *buf,
>  				unsigned int buflen, int write_data)
>  {
> +	int i;
>  	struct ata_port *ap = adev->link->ap;
>  	void __iomem *ioaddr = ap->ioaddr.data_addr;
>  
> +	BUG_ON(buflen % sizeof(u32));
> +
>  	if (write_data) {
> -		for (; buflen > 0; buflen--, buf++)
> -			writeb(*buf, ioaddr);
> +		for(i = 0; i < buflen / sizeof(u32); i++)
> +			writel(((u32 *)buf)[i], ioaddr);
>  	} else {
> -		for (; buflen > 0; buflen--, buf++)
> -			*buf = readb(ioaddr);
> +		for(i = 0; i < buflen / sizeof(u32); i++)
> +			((u32 *)buf)[i] = readl(ioaddr);
>  	}

   So, I didn't get what was wrong with using readsl() and writesl()?
   Besides, using readl() and witel() this way would be wrong on BE mode 
since the data is expected to be stored to memory in the LE order.

MBR, Sergei


