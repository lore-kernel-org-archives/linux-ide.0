From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-2.6] AHCI: compiler warning fix
Date: Fri, 11 Mar 2005 23:58:05 -0500
Message-ID: <423276DD.8060209@pobox.com>
References: <20050311212108.4BB4514FB1@lns1032.lss.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17350 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261859AbVCLE6U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Mar 2005 23:58:20 -0500
In-Reply-To: <20050311212108.4BB4514FB1@lns1032.lss.emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: linux-ide@vger.kernel.org

Brett Russ wrote:
> This fixes the compile warning below, which seems due to the enum
> being signed:
> drivers/scsi/ahci.c:199: warning: overflow in implicit constant
> conversion
> 
> Signed-off-by: Brett Russ <russb@emc.com>
> 
> ===== drivers/scsi/ahci.c 1.17 vs edited =====
> --- 1.17/drivers/scsi/ahci.c	Thu Feb 24 14:52:41 2005
> +++ edited/drivers/scsi/ahci.c	Wed Mar  9 17:29:36 2005
> @@ -44,7 +44,6 @@
>  enum {
>  	AHCI_PCI_BAR		= 5,
>  	AHCI_MAX_SG		= 168, /* hardware max is 64K */
> -	AHCI_DMA_BOUNDARY	= 0xffffffff,
>  	AHCI_USE_CLUSTERING	= 0,
>  	AHCI_CMD_SLOT_SZ	= 32 * 32,
>  	AHCI_RX_FIS_SZ		= 256,
> @@ -135,6 +134,8 @@
>  	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
>  };
>  
> +#define AHCI_DMA_BOUNDARY	0xffffffff

hmmmm, I think there's a better way to fix this.  A separate enum, and 
adding the suffix 'UL' to 0xffffffff should work, I would think.

In general, I try to avoid adding #defines of any nature.  It's just as 
efficient as an enum, and type/symbol information is available to the 
compiler and debugger when you use an enum.

	Jeff



