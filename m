From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] [libata] sata_mv: fix compilation error when enabling
 DEBUG
Date: Sat, 01 Dec 2007 17:36:56 -0500
Message-ID: <4751E208.2060109@garzik.org>
References: <1196177168791-git-send-email-saeed@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41915 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753374AbXLAWg7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 17:36:59 -0500
In-Reply-To: <1196177168791-git-send-email-saeed@marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Saeed Bishara <saeed@marvell.com>
Cc: linux-ide@vger.kernel.org, nico@marvell.com, buytenh@marvell.com, Saeed Bishara <saeed.bishara@gmail.com>

Saeed Bishara wrote:
> From: Saeed Bishara <saeed.bishara@gmail.com>
> 
> use sstatus instead status.
> 
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> ---
>  drivers/ata/sata_mv.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index a43f64d..97c3e11 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -2170,7 +2170,7 @@ static void mv_phy_reset(struct ata_port *ap, unsigned int *class,
>  		mv_scr_read(ap, SCR_ERROR, &serror);
>  		mv_scr_read(ap, SCR_CONTROL, &scontrol);
>  		DPRINTK("S-regs after ATA_RST: SStat 0x%08x SErr 0x%08x "
> -			"SCtrl 0x%08x\n", status, serror, scontrol);
> +			"SCtrl 0x%08x\n", sstatus, serror, scontrol);

applied #upstream-fixes


