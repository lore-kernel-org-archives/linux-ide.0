Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041681553A3
	for <linux-ide@vger.kernel.org>; Mon, 26 Aug 2024 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683694; cv=none; b=mHrRDDK+2epFKXkf61yciOtSACokBxaBqMcekJPrIcFpm12KL03XA5aeR7mnEQOZwTMNEWu4VCUxrCkWOFiHP6if3ycQ65dprFHD2uwxIYTjWKH8T4hATbH6Qh2QLppp9KmZ1Js4MoSSivHwsObxKYUCyFeRiVHJKEy12PODM+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683694; c=relaxed/simple;
	bh=oLwa6RKOEUfTG6Y1OpitaXhm9ePmxCCwvbJTRceLT6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGADQhGeq/sJlECahJvMH67igjXbhhZhsmpPHJG0PoEb5gqb84GDV4R7uKmt+6w9LlOFehZo4Mn3rUHVQ47btB8p0pCQdL4V7tm4EK3pSIIyTraRX5fIqL5AayRLv87qGfahGC2q9aV3eoNyKVYHA3f/SLmDVQs9UYUzopIZMso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJ6Gc7UO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJ6Gc7UO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E5BC52FC0;
	Mon, 26 Aug 2024 14:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724683693;
	bh=oLwa6RKOEUfTG6Y1OpitaXhm9ePmxCCwvbJTRceLT6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJ6Gc7UO5ZweOyMMlTqoBTRNqA8fnBo8ukAP1bJfah4h2+veoeoOf+6UOvi8itr6w
	 u9T1iFnVSn2x1VFYT/mN7s72tjhXvzkayVKfddjNiqRqzSbnSwCSlJe7v0kJCgkk0S
	 jRTRtToWesXB3mMUgWj+PebNUU+1rzfZRpwMp9r5mPqteNNi8tVEw4aDJqGgQVAXts
	 uodJwgThNgRGRH+EGgQecxq6MkzCUsyAzYCkcOlji/ibdoyOYO9QKHoGsbqtRAXJ7R
	 JQRPgvv+1B/3sIVX7/9/+rPl7hFKuLsbx/wbC1hfK+ocgaJ9JiTrUzpr4TZfoMGwFi
	 2DbnF8djqiUKQ==
Date: Mon, 26 Aug 2024 16:48:09 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 6/7] ata: libata: Move ncq_sense_buf to struct ata_device
Message-ID: <ZsyVqTYDDNwGDCoo@ryzen.lan>
References: <20240826073106.56918-1-dlemoal@kernel.org>
 <20240826073106.56918-7-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826073106.56918-7-dlemoal@kernel.org>

On Mon, Aug 26, 2024 at 04:31:05PM +0900, Damien Le Moal wrote:
> The ncq_sense_buf buffer field of struct ata_port is allocated and used
> only for devices that support command duration limits. So move this
> field out of struct ata_port and into struct ata_device together with
> the CDL log buffer.

The ncq_sense_buf buf is currently only allocated if the device supports CDL,
so the currently extra space that we take up in struct ata_port, for non-CDL
devices is just an empty pointer.

Additionally, sector_buf, which we use for reading all the log pages belongs
to struct ata_port, not struct ata_device.

If you also still keep sector_buf in struct ata_port, then I think that this
change makes the code more inconsistent. I would suggest to either move both
or move none. But even then I don't really see the value of moving this from
struct ata_port to ata_device.


> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-core.c      | 11 +++++------
>  drivers/ata/libata-sata.c      |  2 +-
>  drivers/ata/libata-transport.c |  3 +++
>  include/linux/libata.h         |  4 ++--
>  4 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index b5a051bbb01f..6a1d300dd1f5 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2581,9 +2581,9 @@ static void ata_dev_config_cdl(struct ata_device *dev)
>  	 * policy set to 0xD (successful completion with sense data available
>  	 * bit set).
>  	 */
> -	if (!ap->ncq_sense_buf) {
> -		ap->ncq_sense_buf = kmalloc(ATA_LOG_SENSE_NCQ_SIZE, GFP_KERNEL);
> -		if (!ap->ncq_sense_buf)
> +	if (!dev->ncq_sense_buf) {
> +		dev->ncq_sense_buf = kmalloc(ATA_LOG_SENSE_NCQ_SIZE, GFP_KERNEL);
> +		if (!dev->ncq_sense_buf)
>  			goto not_supported;
>  	}
>  
> @@ -2604,8 +2604,8 @@ static void ata_dev_config_cdl(struct ata_device *dev)
>  
>  not_supported:
>  	dev->flags &= ~(ATA_DFLAG_CDL | ATA_DFLAG_CDL_ENABLED);
> -	kfree(ap->ncq_sense_buf);
> -	ap->ncq_sense_buf = NULL;
> +	kfree(dev->ncq_sense_buf);
> +	dev->ncq_sense_buf = NULL;
>  }
>  
>  static int ata_dev_config_lba(struct ata_device *dev)
> @@ -5462,7 +5462,6 @@ void ata_port_free(struct ata_port *ap)
>  
>  	kfree(ap->pmp_link);
>  	kfree(ap->slave_link);
> -	kfree(ap->ncq_sense_buf);
>  	ida_free(&ata_ida, ap->print_id);
>  	kfree(ap);
>  }
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 020893da900d..50ea254a213d 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1505,7 +1505,7 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
>  {
>  	struct ata_device *dev = link->device;
>  	struct ata_port *ap = dev->link->ap;
> -	u8 *buf = ap->ncq_sense_buf;
> +	u8 *buf = dev->ncq_sense_buf;
>  	struct ata_queued_cmd *qc;
>  	unsigned int err_mask, tag;
>  	u8 *sense, sk = 0, asc = 0, ascq = 0;
> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
> index 474816a9efa1..14f50c91ceb9 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -671,6 +671,9 @@ static int ata_tdev_match(struct attribute_container *cont,
>   */
>  static void ata_tdev_free(struct ata_device *dev)
>  {
> +	kfree(dev->ncq_sense_buf);
> +	dev->ncq_sense_buf = NULL;
> +

I don't like that you are freeing ncq_sense_buf in ata_tdev_free(),
a function that is use to free the sysfs entry for a struct ata_device.

ata_tdev_add() and ata_tdev_delete() is about adding and removing the sysfs
entry for a certain struct ata_device. It is not where the ata_device is
allocated and freed, so it seems out of place to do free struct ata_device
struct members here.


ata_device is allocated when calling ata_port_alloc().
(struct ata_port has a "struct ata_link link;", and struct ata_link has a
"struct ata_device device[ATA_MAX_DEVICES]", so struct ata_device is allocated
by ata_port_alloc(), then initialized by ata_link_init(), which calls
ata_dev_init().)

If you want to free the ncq_sense_buf, then I think you should do so where we
free the ata_device, which is currently when we free the struct ata_port.
So I still think the best place to currently free this is in ata_port_free().


Considering both review comments, doesn't it make more sense to just keep
ncq_sense_buf in struct ata_port?


>  	transport_destroy_device(&dev->tdev);
>  	put_device(&dev->tdev);
>  }
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index e07a9b5d45df..3fb6980c8aa1 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -762,7 +762,8 @@ struct ata_device {
>  	/* Concurrent positioning ranges */
>  	struct ata_cpr_log	*cpr_log;
>  
> -	/* Command Duration Limits log support */
> +	/* Command Duration Limits support */
> +	u8			*ncq_sense_buf;
>  	u8			cdl[ATA_LOG_CDL_SIZE];
>  
>  	/* error history */
> @@ -915,7 +916,6 @@ struct ata_port {
>  	struct ata_acpi_gtm	__acpi_init_gtm; /* use ata_acpi_init_gtm() */
>  #endif
>  	/* owned by EH */
> -	u8			*ncq_sense_buf;
>  	u8			sector_buf[ATA_SECT_SIZE] ____cacheline_aligned;
>  };
>  
> -- 
> 2.46.0
> 
