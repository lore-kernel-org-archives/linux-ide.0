From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/4] libata: make ata_set_mode() responsible for failure
 handling
Date: Mon, 13 Mar 2006 03:37:17 -0500
Message-ID: <44152F3D.50307@pobox.com>
References: <11422375531645-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:49633 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932123AbWCMIhZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 03:37:25 -0500
In-Reply-To: <11422375531645-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Make ata_set_mode() responsible for determining whether to take port
> or device offline on failure.  ata_dev_set_xfermode() and
> ata_dev_set_mode() indicate error to the caller instead of disabling
> port directly on failure.  Also, for consistency, ata_dev_present()
> check is done in ata_set_mode() instead of ata_dev_set_mode().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/libata-core.c |   56 ++++++++++++++++++++++++++++----------------
>  1 files changed, 36 insertions(+), 20 deletions(-)
> 
> 07934616ecb83d7bac2adfe9eb32f5173feb32ff
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index b7595bf..6826181 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -64,7 +64,8 @@
>  static unsigned int ata_dev_init_params(struct ata_port *ap,
>  					struct ata_device *dev);
>  static void ata_set_mode(struct ata_port *ap);
> -static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev);
> +static unsigned int ata_dev_set_xfermode(struct ata_port *ap,
> +					 struct ata_device *dev);
>  static void ata_dev_xfermask(struct ata_port *ap, struct ata_device *dev);
>  
>  static unsigned int ata_unique_id = 1;
> @@ -1754,20 +1755,28 @@ int ata_timing_compute(struct ata_device
>  	return 0;
>  }

ACK 1-4 in this patchset, but dropping due to dropped patches in 
previous patchset.

I have the following concern with this patch (#3) however:

> -static void ata_dev_set_mode(struct ata_port *ap, struct ata_device *dev)
> +static int ata_dev_set_mode(struct ata_port *ap, struct ata_device *dev)
>  {
> -	if (!ata_dev_present(dev) || (ap->flags & ATA_FLAG_PORT_DISABLED))
> -		return;

I think you drop too many ATA_FLAG_PORT_DISABLED tests in this patch, 
leading the code to potentially miss a previously-flagged PORT_DISABLED 
(perhaps by an LLDD).

	Jeff


