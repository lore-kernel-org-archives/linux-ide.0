From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-2.6] AHCI: compiler warning fix
Date: Wed, 23 Mar 2005 00:15:14 -0500
Message-ID: <4240FB62.7080208@pobox.com>
References: <20050311212108.4BB4514FB1@lns1032.lss.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14468 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262788AbVCWFP1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Mar 2005 00:15:27 -0500
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
> +

I really don't like defines.  They aren't visible to debuggers and other 
post-cpp checking tools.

It should kill the warning if you move it into a separate enum, and add 
a UL suffix to the constant, I should think?

	Jeff



