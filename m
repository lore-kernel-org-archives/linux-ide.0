From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] pata-rb532-cf: read and write data in 4-byte blocks
Date: Mon, 3 Nov 2008 14:45:32 +0100
Message-ID: <200811031445.32872.bzolnier@gmail.com>
References: <490E1A63.3040507@ru.mvista.com> <1225718954-8307-1-git-send-email-n0-1@freewrt.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:50190 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181AbYKCNr5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Nov 2008 08:47:57 -0500
Received: by ey-out-2122.google.com with SMTP id 6so832669eyi.37
        for <linux-ide@vger.kernel.org>; Mon, 03 Nov 2008 05:47:55 -0800 (PST)
In-Reply-To: <1225718954-8307-1-git-send-email-n0-1@freewrt.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

On Monday 03 November 2008, Phil Sutter wrote:
> * rename the offset definition to avoid abiguity with the standard ATA
>   IO address
> * read and write four bytes at once
> * use writesl() and readsl() which implicitly iterate over the data
> * fix the signature of rb532_pata_data_xfer() to match the function
>   pointer definition and return the number of bytes consumed
> 
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>
> Acked-by: Sergei Shtyltov <sshtylyov@ru.mvista.com>

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Jeff, please apply.

> ---
>  drivers/ata/pata_rb532_cf.c |   21 ++++++++++-----------
>  1 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
> index 7b11f40..a220992 100644
> --- a/drivers/ata/pata_rb532_cf.c
> +++ b/drivers/ata/pata_rb532_cf.c
> @@ -43,7 +43,8 @@
>  #define RB500_CF_REG_BASE	0x0800
>  #define RB500_CF_REG_ERR	0x080D
>  #define RB500_CF_REG_CTRL	0x080E
> -#define RB500_CF_REG_DATA	0x0C00
> +/* 32bit buffered data register offset */
> +#define RB500_CF_REG_DBUF32	0x0C00
>  
>  struct rb532_cf_info {
>  	void __iomem	*iobase;
> @@ -74,21 +75,19 @@ static void rb532_pata_exec_command(struct ata_port *ap,
>  	rb532_pata_finish_io(ap);
>  }
>  
> -static void rb532_pata_data_xfer(struct ata_device *adev, unsigned char *buf,
> -				unsigned int buflen, int write_data)
> +static unsigned int rb532_pata_data_xfer(struct ata_device *adev,
> +		unsigned char *buf, unsigned int buflen, int write_data)
>  {
>  	struct ata_port *ap = adev->link->ap;
>  	void __iomem *ioaddr = ap->ioaddr.data_addr;
>  
> -	if (write_data) {
> -		for (; buflen > 0; buflen--, buf++)
> -			writeb(*buf, ioaddr);
> -	} else {
> -		for (; buflen > 0; buflen--, buf++)
> -			*buf = readb(ioaddr);
> -	}
> +	if (write_data)
> +		writesl(ioaddr, buf, buflen / sizeof(u32));
> +	else
> +		readsl(ioaddr, buf, buflen / sizeof(u32));
>  
>  	rb532_pata_finish_io(adev->link->ap);
> +	return buflen;
>  }
>  
>  static void rb532_pata_freeze(struct ata_port *ap)
> @@ -156,7 +155,7 @@ static void rb532_pata_setup_ports(struct ata_host *ah)
>  
>  	ata_sff_std_ports(&ap->ioaddr);
>  
> -	ap->ioaddr.data_addr	= info->iobase + RB500_CF_REG_DATA;
> +	ap->ioaddr.data_addr	= info->iobase + RB500_CF_REG_DBUF32;
>  	ap->ioaddr.error_addr	= info->iobase + RB500_CF_REG_ERR;
>  }
