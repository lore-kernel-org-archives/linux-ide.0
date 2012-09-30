From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] ATA: sata_mv: Fix warnings when no PCI
Date: Sat, 29 Sep 2012 22:23:59 -0400
Message-ID: <20120930022359.GC17765@titan.lakedaemon.net>
References: <1348844650-2957-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:46986 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752108Ab2I3CYI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Sep 2012 22:24:08 -0400
Content-Disposition: inline
In-Reply-To: <1348844650-2957-1-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, jgarzik@pobox.com
Cc: Olof Johansson <olof@lixom.net>, linux-ide@vger.kernel.org, linux ARM <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>

Jeff,

Would you like to take this through your tree?  If not, I'll take it
through my kirkwood tree with your Ack.  Either is fine with me.

thx,

Jason.

On Fri, Sep 28, 2012 at 05:04:10PM +0200, Andrew Lunn wrote:
> Dove can be configured with PCI. We then get a number of warnings:
> 
> warning: 'msi' defined but not used
> warning: 'mv5_sht' defined but not used
> warning: 'mv_dump_pci_cfg' defined but not used.
> 
> Move around variables and add #ifdef as necassary to fix the warnings.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/ata/sata_mv.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 311be18..68f4fb5 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -79,8 +79,8 @@
>   * module options
>   */
>  
> -static int msi;
>  #ifdef CONFIG_PCI
> +static int msi;
>  module_param(msi, int, S_IRUGO);
>  MODULE_PARM_DESC(msi, "Enable use of PCI MSI (0=off, 1=on)");
>  #endif
> @@ -652,12 +652,13 @@ static u8 mv_sff_check_status(struct ata_port *ap);
>   * because we have to allow room for worst case splitting of
>   * PRDs for 64K boundaries in mv_fill_sg().
>   */
> +#ifdef CONFIG_PCI
>  static struct scsi_host_template mv5_sht = {
>  	ATA_BASE_SHT(DRV_NAME),
>  	.sg_tablesize		= MV_MAX_SG_CT / 2,
>  	.dma_boundary		= MV_DMA_BOUNDARY,
>  };
> -
> +#endif
>  static struct scsi_host_template mv6_sht = {
>  	ATA_NCQ_SHT(DRV_NAME),
>  	.can_queue		= MV_MAX_Q_DEPTH - 1,
> @@ -1252,7 +1253,7 @@ static void mv_dump_mem(void __iomem *start, unsigned bytes)
>  	}
>  }
>  #endif
> -
> +#if defined(ATA_DEBUG) || defined(CONFIG_PCI)
>  static void mv_dump_pci_cfg(struct pci_dev *pdev, unsigned bytes)
>  {
>  #ifdef ATA_DEBUG
> @@ -1269,6 +1270,7 @@ static void mv_dump_pci_cfg(struct pci_dev *pdev, unsigned bytes)
>  	}
>  #endif
>  }
> +#endif
>  static void mv_dump_all_regs(void __iomem *mmio_base, int port,
>  			     struct pci_dev *pdev)
>  {
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
