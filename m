From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 07/11] sata_sil24: add hardreset
Date: Thu, 09 Feb 2006 02:08:39 -0500
Message-ID: <43EAEA77.9080809@pobox.com>
References: <11388720002336-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:50841 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422853AbWBIHIp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2006 02:08:45 -0500
In-Reply-To: <11388720002336-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Now that libata is smart enough to handle both soft and hard resets,
> add hardreset method.  Note that sil24 hardreset doesn't supply
> signature; still, the new reset mechanism can make good use of it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/sata_sil24.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 
> 8ef9da7d26ee574c1d719609c86b6c86543ab496
> diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
> index a529628..c2df4b6 100644
> --- a/drivers/scsi/sata_sil24.c
> +++ b/drivers/scsi/sata_sil24.c
> @@ -484,10 +484,19 @@ static int sil24_softreset(struct ata_po
>  	return 0;
>  }
>  
> +static int sil24_hardreset(struct ata_port *ap, int verbose,
> +			   unsigned int *class)
> +{
> +	unsigned int dummy_class;
> +
> +	/* sil24 doesn't report device signature after hard reset */
> +	return sata_std_hardreset(ap, verbose, &dummy_class);
> +}

ACK for sil24, though as a comment, we should move away from the 
practice of assuming we'll get a device signature from hard reset.  It's 
IMO easier to presume that SRST will always follow a hard reset, and 
you'll get the signature that way.  But that's an additional step from 
the current libata reset, so that's a separate patch to explore that 
train of thought...

	Jeff


