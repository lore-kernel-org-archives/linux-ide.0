From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH]ata: sata_nv fix mcp51 timeout with SWNCQ
Date: Fri, 26 Oct 2007 20:58:36 +0200
Message-ID: <200710262058.36553.bzolnier@gmail.com>
References: <15F501D1A78BD343BE8F4D8DB854566B059FE1DB@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:56918 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbXJZSxA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 14:53:00 -0400
Received: by nf-out-0910.google.com with SMTP id g13so863547nfb
        for <linux-ide@vger.kernel.org>; Fri, 26 Oct 2007 11:52:59 -0700 (PDT)
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B059FE1DB@hkemmail01.nvidia.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kuan Luo <kluo@nvidia.com>
Cc: jeff@garzik.org, akpm@linux-foundation.org, linux-ide@vger.kernel.org, Peer Chen <pchen@nvidia.com>, Andrew <andrew@nelless.net>


[ added Andrew to cc: ]

Hi,

On Friday 26 October 2007, Kuan Luo wrote:
> From Kuan Luo <kluo@nvidia.com>
> 
> The patch will avoid ncq function use of sata_nv when swncq is zero by
> default.

It also completely removes SWNCQ support for MPC61 (something
like that should be mentioned in the patch description).

Otherwise patch looks fine and mine can be dumped.

PS Please always at least Cc: people involved in the debugging
of the problem (crediting them in the patch description would be
even nicer :).

> signed-off-by: Kuan Luo <kluo@nvidia.com>
> ---
> 
>  sata_nv.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
> index 240a892..e6b6455 100644
> --- a/drivers/ata/sata_nv.c
> +++ b/drivers/ata/sata_nv.c
> @@ -365,9 +365,9 @@ static const struct pci_device_id nv_pci_tbl[] = {
>  	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2),
> SWNCQ },
>  	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA),
> SWNCQ },
>  	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2),
> SWNCQ },
> -	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA),
> SWNCQ },
> -	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA2),
> SWNCQ },
> -	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3),
> SWNCQ },
> +	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA),
> GENERIC },
> +	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA2),
> GENERIC },
> +	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3),
> GENERIC },
>  
>  	{ } /* terminate list */
>  };
> @@ -2383,6 +2383,9 @@ static int nv_init_one (struct pci_dev *pdev,
> const struct pci_device_id *ent)
>  		type = ADMA;
>  	}
>  
> +	if (type == SWNCQ && !swncq_enabled)
> +		type = GENERIC;
> +
>  	ppi[0] = &nv_port_info[type];
>  	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
>  	if (rc)
