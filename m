From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 09/14] sata_mv Restrict max_sectors to 8-bits on GenII
 NCQ
Date: Fri, 25 Jan 2008 23:21:04 -0500
Message-ID: <479AB530.1080105@pobox.com>
References: <4798FB68.70400@rtr.ca> <4798FCBD.1010900@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39465 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752579AbYAZEVG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Jan 2008 23:21:06 -0500
In-Reply-To: <4798FCBD.1010900@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> sata_mv Restrict max_sectors to 8-bits on GenII NCQ.
> 
> The GenII chips have only 8-bits for the sector_count field when 
> performing NCQ.
> Add a dev_config method to restrict this when necessary, taking care not to
> override any other restriction already in place (likely none, but 
> someday.. ?).
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> 
> --- old/drivers/ata/sata_mv.c    2008-01-24 12:35:43.000000000 -0500
> +++ new/drivers/ata/sata_mv.c    2008-01-24 12:40:10.000000000 -0500
> @@ -446,6 +446,7 @@
> static void mv_post_int_cmd(struct ata_queued_cmd *qc);
> static void mv_eh_freeze(struct ata_port *ap);
> static void mv_eh_thaw(struct ata_port *ap);
> +static void mv6_dev_config(struct ata_device *dev);
> static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id 
> *ent);
> 
> static void mv5_phy_errata(struct mv_host_priv *hpriv, void __iomem *mmio,
> @@ -538,6 +539,7 @@
> };
> 
> static const struct ata_port_operations mv6_ops = {
> +    .dev_config             = mv6_dev_config,
>     .tf_load        = ata_tf_load,
>     .tf_read        = ata_tf_read,
>     .check_status        = ata_check_status,
> @@ -1051,6 +1053,17 @@
>         return -EINVAL;
> }
> 
> +static void mv6_dev_config(struct ata_device *adev)
> +{
> +    /*
> +     * We don't have hob_nsect when doing NCQ commands on Gen-II.
> +     * See mv_qc_prep() for more info.
> +     */
> +    if (adev->flags & ATA_DFLAG_NCQ)
> +        if (adev->max_sectors > ATA_MAX_SECTORS)
> +            adev->max_sectors = ATA_MAX_SECTORS;
> +}
> +
> static void mv_edma_cfg(struct mv_port_priv *pp, struct mv_host_priv 
> *hpriv,
>             void __iomem *port_mmio, int want_ncq)
> {

ACK patches 8-9


