From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Intel device IDs SATA
Date: Tue, 3 Nov 2015 14:31:44 -0500
Message-ID: <20151103193144.GA5749@mtj.duckdns.org>
References: <1446577791-3087-1-git-send-email-alexandra.yates@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35650 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932236AbbKCTbs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Nov 2015 14:31:48 -0500
Content-Disposition: inline
In-Reply-To: <1446577791-3087-1-git-send-email-alexandra.yates@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexandra Yates <alexandra.yates@linux.intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Nov 03, 2015 at 11:09:51AM -0800, Alexandra Yates wrote:
> @@ -161,6 +162,13 @@ static const struct ata_port_info ahci_port_info[] = {
>  		.port_ops	= &ahci_ops,
>  	},
>  	/* by chipsets */
> +	[board_ahci_lbg] = {
> +		.flags		= AHCI_FLAG_COMMON,
> +		.pio_mask	= ATA_PIO4,
> +		.udma_mask	= ATA_UDMA6,
> +		.port_ops	= &ahci_ops,
> +	},
> +
>  	[board_ahci_avn] = {
>  		.flags		= AHCI_FLAG_COMMON,
>  		.pio_mask	= ATA_PIO4,
> @@ -314,6 +322,16 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x1f37), board_ahci_avn }, /* Avoton RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1f3e), board_ahci_avn }, /* Avoton RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1f3f), board_ahci_avn }, /* Avoton RAID */
> +	{ PCI_VDEVICE(INTEL, 0xa182), board_ahci_lbg }, /* Lewisburg AHCI*/
> +	{ PCI_VDEVICE(INTEL, 0xa202), board_ahci_lbg }, /* Lewisburg AHCI*/
> +	{ PCI_VDEVICE(INTEL, 0xa184), board_ahci_lbg }, /* Lewisburg RAID*/
> +	{ PCI_VDEVICE(INTEL, 0xa204), board_ahci_lbg }, /* Lewisburg RAID*/
> +	{ PCI_VDEVICE(INTEL, 0xa186), board_ahci_lbg }, /* Lewisburg RAID*/
> +	{ PCI_VDEVICE(INTEL, 0xa206), board_ahci_lbg }, /* Lewisburg RAID*/
> +	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci_lbg }, /* Lewisburg RAID*/
> +	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci_lbg }, /* Lewisburg RAID*/
> +	{ PCI_VDEVICE(INTEL, 0xa18e), board_ahci_lbg }, /* Lewisburg RAID*/
> +	{ PCI_VDEVICE(INTEL, 0xa20e), board_ahci_lbg }, /* Lewisburg RAID*/

Just use board_ahci?

Thanks.

-- 
tejun
