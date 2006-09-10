From: Jonathan Dieter <jdieter@gmail.com>
Subject: Re: Kernel fix for ICH7M controller
Date: Sun, 10 Sep 2006 22:54:18 +0300
Message-ID: <45046D6A.8000900@gmail.com>
References: <44FAE630.20801@gmail.com> <44FB93B5.1020703@gmail.com> <44FBCD5E.1090007@gmail.com> <44FBE0A7.5070301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:28977 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964807AbWIJTy6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 10 Sep 2006 15:54:58 -0400
Received: by py-out-1112.google.com with SMTP id n25so1849448pyg
        for <linux-ide@vger.kernel.org>; Sun, 10 Sep 2006 12:54:24 -0700 (PDT)
In-Reply-To: <44FBE0A7.5070301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Is there anything else you need me to do or test before the patch goes 
into the mainline kernel?  I've been running it for six days now and 
it's working perfectly.

Thanks again,
Jonathan

Tejun Heo wrote:
> Can you test the attached patch?
>
> Thanks.
>
> ------------------------------------------------------------------------
>
> diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
> index 2d20caf..a9bb3cb 100644
> --- a/drivers/scsi/ata_piix.c
> +++ b/drivers/scsi/ata_piix.c
> @@ -123,7 +123,8 @@ enum {
>  	ich6_sata		= 4,
>  	ich6_sata_ahci		= 5,
>  	ich6m_sata_ahci		= 6,
> -	ich8_sata_ahci		= 7,
> +	ich7m_sata_ahci		= 7,
> +	ich8_sata_ahci		= 8,
>  
>  	/* constants for mapping table */
>  	P0			= 0,  /* port 0 */
> @@ -188,7 +189,7 @@ #endif
>  	/* 82801GB/GR/GH (ICH7, identical to ICH6) */
>  	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
>  	/* 2801GBM/GHM (ICH7M, identical to ICH6M) */
> -	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6m_sata_ahci },
> +	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7m_sata_ahci },
>  	/* Enterprise Southbridge 2 (where's the datasheet?) */
>  	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
>  	/* SATA Controller 1 IDE (ICH8, no datasheet yet) */
> @@ -336,6 +337,24 @@ static const struct piix_map_db ich6m_ma
>  	},
>  };
>  
> +static const struct piix_map_db ich7m_map_db = {
> +	.mask = 0x3,
> +	.port_enable = 0x5,
> +	.present_shift = 4,
> +
> +	/* Map 01b isn't specified in the doc but some notebooks use
> +	 * it anyway.  ATM, the only case spotted carries subsystem ID
> +	 * 1025:0107.  This is the only difference from ich6m.
> +	 */
> +	.map = {
> +		/* PM   PS   SM   SS       MAP */
> +		{  P0,  P2,  RV,  RV }, /* 00b */
> +		{ IDE, IDE,  P1,  P3 }, /* 01b */
> +		{  P0,  P2, IDE, IDE }, /* 10b */
> +		{  RV,  RV,  RV,  RV },
> +	},
> +};
> +
>  static const struct piix_map_db ich8_map_db = {
>  	.mask = 0x3,
>  	.port_enable = 0x3,
> @@ -355,6 +374,7 @@ static const struct piix_map_db *piix_ma
>  	[ich6_sata]		= &ich6_map_db,
>  	[ich6_sata_ahci]	= &ich6_map_db,
>  	[ich6m_sata_ahci]	= &ich6m_map_db,
> +	[ich7m_sata_ahci]	= &ich7m_map_db,
>  	[ich8_sata_ahci]	= &ich8_map_db,
>  };
>  
> @@ -444,6 +464,18 @@ #endif
>  		.port_ops	= &piix_sata_ops,
>  	},
>  
> +	/* ich7m_sata_ahci */
> +	{
> +		.sht		= &piix_sht,
> +		.host_flags	= ATA_FLAG_SATA |
> +				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR |
> +				  PIIX_FLAG_AHCI,
> +		.pio_mask	= 0x1f,	/* pio0-4 */
> +		.mwdma_mask	= 0x07, /* mwdma0-2 */
> +		.udma_mask	= 0x7f,	/* udma0-6 */
> +		.port_ops	= &piix_sata_ops,
> +	},
> +
>  	/* ich8_sata_ahci */
>  	{
>  		.sht		= &piix_sht,
>   

