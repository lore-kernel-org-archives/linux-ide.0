From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 2/3] libata: Add support for SEND/RECEIVE FPDMA QUEUED
Date: Fri, 23 Aug 2013 12:06:24 -0400
Message-ID: <20130823160624.GH3277@htj.dyndns.org>
References: <1377250847-24132-1-git-send-email-marc.ceeeee@gmail.com>
 <1377250847-24132-3-git-send-email-marc.ceeeee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f48.google.com ([209.85.128.48]:35456 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755334Ab3HWQG2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Aug 2013 12:06:28 -0400
Received: by mail-qe0-f48.google.com with SMTP id 1so432466qec.7
        for <linux-ide@vger.kernel.org>; Fri, 23 Aug 2013 09:06:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1377250847-24132-3-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello, Marc.

On Fri, Aug 23, 2013 at 02:40:46AM -0700, Marc C wrote:
> From: Marc Carino <marc.ceeeee@gmail.com>
> 
> Add support for the following ATA opcodes, which are present
> in SATA 3.1 and T13 ATA ACS-3:
> 
>         SEND FPDMA QUEUED
>         RECEIVE FPDMA QUEUED
> 
> Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
> ---
>  drivers/ata/libata-core.c | 20 ++++++++++++++++++++
>  include/linux/ata.h       | 23 +++++++++++++++++++++++
>  include/linux/libata.h    |  4 ++++
>  3 files changed, 47 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 9062aa0..34ccadb 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2141,6 +2141,26 @@ static int ata_dev_config_ncq(struct ata_device *dev,
>  	else
>  		snprintf(desc, desc_sz, "NCQ (depth %d/%d)%s", hdepth,
>  			ddepth, aa_desc);
> +
> +	if ((ap->flags & ATA_FLAG_FPDMA_AUX) &&
> +		ata_id_has_ncq_send_and_recv(dev->id)) {
> +		err_mask = ata_read_log_page(dev,
> +					     ATA_LOG_NCQ_SEND_RECV,
> +					     0,
> +					     ap->sector_buf,
> +					     1);

Can you please fill to 80 col instead?  I know the other invocation is
breaking line for each argument but let's not spread that.

> +		if (err_mask) {
> +			ata_dev_dbg(dev,
> +				    "failed to get NCQ Send/Recv Log "
> +				    "Emask 0x%x\n",

And no need to break line for format strings.

> +static inline bool ata_id_has_ncq_send_and_recv(const u16 *id)
> +{
> +	if (id[ATA_ID_SATA_CAPABILITY_2] & BIT(6))
> +		return true;
> +	return false;
> +}

 return id[ATA_ID_SATA_CAPABILITY_2] & BIT(6);

thanks.

-- 
tejun
