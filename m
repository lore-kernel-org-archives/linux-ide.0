From: Martin Hicks <mort@bork.org>
Subject: Re: [PATCH] libata:  PHY reset requires writing 0x4 to SControl
Date: Wed, 5 Jul 2006 15:11:48 -0400
Message-ID: <20060705191148.GE16658@bork.org>
References: <20060705190613.GD16658@bork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from galileo.bork.org ([134.117.69.57]:30344 "EHLO galileo.bork.org")
	by vger.kernel.org with ESMTP id S964991AbWGETLt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jul 2006 15:11:49 -0400
Content-Disposition: inline
In-Reply-To: <20060705190613.GD16658@bork.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org


Whoops.  I should have pointed out that this is untested.  Only the ahci
and sata_nv use this function, I think.  I don't have hardware for
either.

mh

On Wed, Jul 05, 2006 at 03:06:13PM -0400, Martin Hicks wrote:
> 
> Hi,
> 
> Reading the Intel VSC and AHCI it seems like writing 0x302 is incorrect.
> The only valid values are 4, 1 and 0.  Writing 4 disables the
> PHY.
> 
> Signed-off-by: Martin Hicks <mort@bork.org>
> 
> ---
> 
>  drivers/scsi/libata-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> 99377743755ef015100ab52fd79ee950a783141b
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index 6c66877..577fbcc 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -2705,7 +2705,7 @@ int sata_std_hardreset(struct ata_port *
>  		if ((rc = sata_scr_read(ap, SCR_CONTROL, &scontrol)))
>  			return rc;
>  
> -		scontrol = (scontrol & 0x0f0) | 0x302;
> +		scontrol = (scontrol & 0x0f0) | 0x304;
>  
>  		if ((rc = sata_scr_write(ap, SCR_CONTROL, scontrol)))
>  			return rc;
> -- 
> 1.3.2
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Martin Hicks || mort@bork.org || PGP/GnuPG: 0x4C7F2BEE
