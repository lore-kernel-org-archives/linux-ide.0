From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] ata_piix: kill ich6_sata_ahci and clean up
Date: Fri, 04 Apr 2008 03:40:38 -0400
Message-ID: <47F5DB76.7070304@garzik.org>
References: <47E9F162.3010806@gmail.com> <47E9F4AA.1000401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40109 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752710AbYDDHkl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Apr 2008 03:40:41 -0400
In-Reply-To: <47E9F4AA.1000401@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, romal@gmx.de

Tejun Heo wrote:
> ich6_sata_ahci and ich6_sata are identical.  Kill ich6_sata_ahci and
> drop _ahci postfixes from controller ids, which doesn't really mean
> anything at this point.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/ata_piix.c |   61 ++++++++++++++++++++-----------------------------
>  1 file changed, 25 insertions(+), 36 deletions(-)
> 
> Index: work/drivers/ata/ata_piix.c
> ===================================================================
> --- work.orig/drivers/ata/ata_piix.c
> +++ work/drivers/ata/ata_piix.c
> @@ -138,12 +138,11 @@ enum piix_controller_ids {
>  	ich_pata_100,		/* ICH up to UDMA 100 */
>  	ich5_sata,
>  	ich6_sata,
> -	ich6_sata_ahci,
> -	ich6m_sata_ahci,
> -	ich8_sata_ahci,
> +	ich6m_sata,
> +	ich8_sata,
>  	ich8_2port_sata,
> -	ich8m_apple_sata_ahci,	/* locks up on second port enable */
> -	tolapai_sata_ahci,
> +	ich8m_apple_sata,	/* locks up on second port enable */
> +	tolapai_sata,
>  	piix_pata_vmw,			/* PIIX4 for VMware, spurious DMA_ERR */
>  };
>  
> @@ -234,27 +233,27 @@ static const struct pci_device_id piix_p
>  	/* 82801FB/FW (ICH6/ICH6W) */
>  	{ 0x8086, 0x2651, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata },
>  	/* 82801FR/FRW (ICH6R/ICH6RW) */
> -	{ 0x8086, 0x2652, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
> +	{ 0x8086, 0x2652, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata },
>  	/* 82801FBM ICH6M (ICH6R with only port 0 and 2 implemented).
>  	 * Attach iff the controller is in IDE mode. */
>  	{ 0x8086, 0x2653, PCI_ANY_ID, PCI_ANY_ID,
> -	  PCI_CLASS_STORAGE_IDE << 8, 0xffff00, ich6m_sata_ahci },
> +	  PCI_CLASS_STORAGE_IDE << 8, 0xffff00, ich6m_sata },
>  	/* 82801GB/GR/GH (ICH7, identical to ICH6) */
> -	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
> +	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata },
>  	/* 2801GBM/GHM (ICH7M, identical to ICH6M) */
> -	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6m_sata_ahci },
> +	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6m_sata },
>  	/* Enterprise Southbridge 2 (631xESB/632xESB) */
> -	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
> +	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata },
>  	/* SATA Controller 1 IDE (ICH8) */
> -	{ 0x8086, 0x2820, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
> +	{ 0x8086, 0x2820, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
>  	/* SATA Controller 2 IDE (ICH8) */
>  	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
>  	/* Mobile SATA Controller IDE (ICH8M) */
> -	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
> +	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
>  	/* Mobile SATA Controller IDE (ICH8M), Apple */
> -	{ 0x8086, 0x2828, 0x106b, 0x00a0, 0, 0, ich8m_apple_sata_ahci },
> +	{ 0x8086, 0x2828, 0x106b, 0x00a0, 0, 0, ich8m_apple_sata },
>  	/* SATA Controller IDE (ICH9) */
> -	{ 0x8086, 0x2920, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
> +	{ 0x8086, 0x2920, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
>  	/* SATA Controller IDE (ICH9) */
>  	{ 0x8086, 0x2921, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
>  	/* SATA Controller IDE (ICH9) */
> @@ -264,15 +263,15 @@ static const struct pci_device_id piix_p
>  	/* SATA Controller IDE (ICH9M) */
>  	{ 0x8086, 0x292d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
>  	/* SATA Controller IDE (ICH9M) */
> -	{ 0x8086, 0x292e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
> +	{ 0x8086, 0x292e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
>  	/* SATA Controller IDE (Tolapai) */
> -	{ 0x8086, 0x5028, PCI_ANY_ID, PCI_ANY_ID, 0, 0, tolapai_sata_ahci },
> +	{ 0x8086, 0x5028, PCI_ANY_ID, PCI_ANY_ID, 0, 0, tolapai_sata },
>  	/* SATA Controller IDE (ICH10) */
> -	{ 0x8086, 0x3a00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
> +	{ 0x8086, 0x3a00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
>  	/* SATA Controller IDE (ICH10) */
>  	{ 0x8086, 0x3a06, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
>  	/* SATA Controller IDE (ICH10) */
> -	{ 0x8086, 0x3a20, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
> +	{ 0x8086, 0x3a20, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
>  	/* SATA Controller IDE (ICH10) */
>  	{ 0x8086, 0x3a26, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
>  
> @@ -553,12 +552,11 @@ static const struct piix_map_db tolapai_
>  static const struct piix_map_db *piix_map_db_table[] = {
>  	[ich5_sata]		= &ich5_map_db,
>  	[ich6_sata]		= &ich6_map_db,
> -	[ich6_sata_ahci]	= &ich6_map_db,
> -	[ich6m_sata_ahci]	= &ich6m_map_db,
> -	[ich8_sata_ahci]	= &ich8_map_db,
> +	[ich6m_sata]		= &ich6m_map_db,
> +	[ich8_sata]		= &ich8_map_db,
>  	[ich8_2port_sata]	= &ich8_2port_map_db,
> -	[ich8m_apple_sata_ahci]	= &ich8m_apple_map_db,
> -	[tolapai_sata_ahci]	= &tolapai_map_db,
> +	[ich8m_apple_sata]	= &ich8m_apple_map_db,
> +	[tolapai_sata]		= &tolapai_map_db,
>  };
>  
>  static struct ata_port_info piix_port_info[] = {
> @@ -624,7 +622,7 @@ static struct ata_port_info piix_port_in
>  		.port_ops	= &piix_sata_ops,
>  	},
>  
> -	[ich6_sata_ahci] =
> +	[ich6m_sata] =
>  	{
>  		.flags		= PIIX_SATA_FLAGS,
>  		.pio_mask	= 0x1f,	/* pio0-4 */
> @@ -633,16 +631,7 @@ static struct ata_port_info piix_port_in
>  		.port_ops	= &piix_sata_ops,
>  	},
>  
> -	[ich6m_sata_ahci] =
> -	{
> -		.flags		= PIIX_SATA_FLAGS,
> -		.pio_mask	= 0x1f,	/* pio0-4 */
> -		.mwdma_mask	= 0x07, /* mwdma0-2 */
> -		.udma_mask	= ATA_UDMA6,
> -		.port_ops	= &piix_sata_ops,
> -	},
> -
> -	[ich8_sata_ahci] =
> +	[ich8_sata] =
>  	{
>  		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SIDPR,
>  		.pio_mask	= 0x1f,	/* pio0-4 */
> @@ -660,7 +649,7 @@ static struct ata_port_info piix_port_in
>  		.port_ops	= &piix_sata_ops,
>  	},
>  
> -	[tolapai_sata_ahci] =
> +	[tolapai_sata] =
>  	{
>  		.flags		= PIIX_SATA_FLAGS,
>  		.pio_mask	= 0x1f,	/* pio0-4 */
> @@ -669,7 +658,7 @@ static struct ata_port_info piix_port_in
>  		.port_ops	= &piix_sata_ops,
>  	},
>  
> -	[ich8m_apple_sata_ahci] =
> +	[ich8m_apple_sata] =
>  	{
>  		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SIDPR,
>  		.pio_mask	= 0x1f,	/* pio0-4 */

applied both ata_piix patches


