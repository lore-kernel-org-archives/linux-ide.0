From: Brett Russ <russb@emc.com>
Subject: Re: [PATCH] Re: AHCI: support for tf_read (RFC)
Date: Thu, 10 Mar 2005 11:50:56 -0500
Message-ID: <42307AF0.4030309@emc.com>
References: <20050224232413.4869514FC5@lns1032.lss.emc.com> <421FB272.4030502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from mailhub.lss.emc.com ([168.159.2.31]:51781 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S262744AbVCJQvH
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Mar 2005 11:51:07 -0500
In-Reply-To: <421FB272.4030502@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, ric@emc.com

Jeff Garzik wrote:
> I checked the attached patch into a local repository, but haven't yet 
> merged it into libata-dev-2.6, or tested it.

Jeff,

The below works for me in testing.  Can you push into libata-2.6?

Thanks,
BR

> ------------------------------------------------------------------------
> 
> # This is a BitKeeper generated diff -Nru style patch.
> #
> # ChangeSet
> #   2005/02/25 18:18:09-05:00 jgarzik@pobox.com 
> #   [libata ahci] support ->tf_read hook
> # 
> # drivers/scsi/ahci.c
> #   2005/02/25 18:18:03-05:00 jgarzik@pobox.com +11 -0
> #   [libata ahci] support ->tf_read hook
> # 
> diff -Nru a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
> --- a/drivers/scsi/ahci.c	2005-02-25 18:18:23 -05:00
> +++ b/drivers/scsi/ahci.c	2005-02-25 18:18:23 -05:00
> @@ -177,6 +177,7 @@
>  static int ahci_port_start(struct ata_port *ap);
>  static void ahci_port_stop(struct ata_port *ap);
>  static void ahci_host_stop(struct ata_host_set *host_set);
> +static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
>  static void ahci_qc_prep(struct ata_queued_cmd *qc);
>  static u8 ahci_check_status(struct ata_port *ap);
>  static u8 ahci_check_err(struct ata_port *ap);
> @@ -209,6 +210,8 @@
>  	.check_err		= ahci_check_err,
>  	.dev_select		= ata_noop_dev_select,
>  
> +	.tf_read		= ahci_tf_read,
> +
>  	.phy_reset		= ahci_phy_reset,
>  
>  	.qc_prep		= ahci_qc_prep,
> @@ -460,6 +463,14 @@
>  	void *mmio = (void *) ap->ioaddr.cmd_addr;
>  
>  	return (readl(mmio + PORT_TFDATA) >> 8) & 0xFF;
> +}
> +
> +static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
> +{
> +	struct ahci_port_priv *pp = ap->private_data;
> +	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
> +
> +	ata_tf_from_fis(d2h_fis, tf);
>  }
>  
>  static void ahci_fill_sg(struct ata_queued_cmd *qc)

