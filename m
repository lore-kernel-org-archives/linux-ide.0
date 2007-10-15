From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.23]ata_piix: SATA 2port controller port map fix
Date: Mon, 15 Oct 2007 15:40:14 -0400
Message-ID: <4713C21E.5060000@pobox.com>
References: <200710111605.15757.jason.d.gaston@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933286AbXJOTkd@vger.kernel.org>
In-Reply-To: <200710111605.15757.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gaston <jason.d.gaston@intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, htejun@gmail.com
List-Id: linux-ide@vger.kernel.org

Jason Gaston wrote:
> This patch adds a port map for ICH9 and ICH8 SATA controllers that have only 2 ports available in that mode.
> 
> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>
> 
> --- linux-2.6.23/drivers/ata/ata_piix.c.orig	2007-10-09 13:31:38.000000000 -0700
> +++ linux-2.6.23/drivers/ata/ata_piix.c	2007-10-11 15:55:19.000000000 -0700
> @@ -131,6 +131,7 @@
>  	ich8_sata_ahci		= 9,
>  	piix_pata_mwdma		= 10,	/* PIIX3 MWDMA only */
>  	tolapai_sata_ahci	= 11,
> +	ich9_2port_sata		= 12,
>  
>  	/* constants for mapping table */
>  	P0			= 0,  /* port 0 */
> @@ -239,19 +240,19 @@
>  	/* SATA Controller 1 IDE (ICH8) */
>  	{ 0x8086, 0x2820, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
>  	/* SATA Controller 2 IDE (ICH8) */
> -	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
> +	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich9_2port_sata },
>  	/* Mobile SATA Controller IDE (ICH8M) */
>  	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
>  	/* SATA Controller IDE (ICH9) */
>  	{ 0x8086, 0x2920, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
>  	/* SATA Controller IDE (ICH9) */
> -	{ 0x8086, 0x2921, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
> +	{ 0x8086, 0x2921, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich9_2port_sata },
>  	/* SATA Controller IDE (ICH9) */
> -	{ 0x8086, 0x2926, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
> +	{ 0x8086, 0x2926, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich9_2port_sata },
>  	/* SATA Controller IDE (ICH9M) */
> -	{ 0x8086, 0x2928, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
> +	{ 0x8086, 0x2928, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich9_2port_sata },
>  	/* SATA Controller IDE (ICH9M) */
> -	{ 0x8086, 0x292d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
> +	{ 0x8086, 0x292d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich9_2port_sata },
>  	/* SATA Controller IDE (ICH9M) */
>  	{ 0x8086, 0x292e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
>  	/* SATA Controller IDE (Tolapai) */
> @@ -456,6 +457,18 @@
>          },
>  };
>  
> +static const struct piix_map_db ich9_2port_map_db = {
> +        .mask = 0x3,
> +        .port_enable = 0x3,
> +        .map = {
> +                /* PM   PS   SM   SS       MAP */
> +                {  P0,  NA,  P1,  NA }, /* 00b */
> +                {  RV,  RV,  RV,  RV }, /* 01b */
> +                {  RV,  RV,  RV,  RV }, /* 10b */
> +                {  RV,  RV,  RV,  RV },
> +        },
> +};

this was full of spaces, and should be converted to tabs (I did this 
manually)

In the future, make sure to run your patch through 
scripts/checkpatch.pl.  Some of that script's complaints are a bit 
insane, but most are good.

>  static const struct piix_map_db *piix_map_db_table[] = {
>  	[ich5_sata]		= &ich5_map_db,
>  	[ich6_sata]		= &ich6_map_db,
> @@ -463,6 +476,7 @@
>  	[ich6m_sata_ahci]	= &ich6m_map_db,
>  	[ich8_sata_ahci]	= &ich8_map_db,
>  	[tolapai_sata_ahci]	= &tolapai_map_db,
> +	[ich9_2port_sata]	= &ich9_2port_map_db,
>  };
>  
>  static struct ata_port_info piix_port_info[] = {
> @@ -587,6 +601,17 @@
>  		.udma_mask	= ATA_UDMA6,
>  		.port_ops	= &piix_sata_ops,
>  	},
> +
> +	/* ich9_2port_sata: 12: */

changed this to

	[ich9_2port_sata] =

since we have started using the (C99? gcc?) method of initializing 
piix_port_info[] array entries based on the given index, rather than 
simply noting the index in a comment and depending on the order of other 
entries not to change.

	Jeff
