From: David Ahern <dsahern@gmail.com>
Subject: Re: boot failure with 4.13.0-rc6 due to ATA errors
Date: Tue, 29 Aug 2017 09:08:05 -0600
Message-ID: <a5caf398-3ae3-4585-23d2-b2afbbc28d7d@gmail.com>
References: <3117ae58-d432-101e-3f0b-68d72fdee28b@gmail.com>
 <20170828195916.GA491396@devbig577.frc2.facebook.com>
 <37033f6d-2ad0-7817-10b5-cbd7ff565624@gmail.com>
 <20170828212225.GB491396@devbig577.frc2.facebook.com>
 <20170829124206.GA26738@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34453 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbdH2PII (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 29 Aug 2017 11:08:08 -0400
In-Reply-To: <20170829124206.GA26738@lst.de>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Robert Elliott <elliott@hpe.com>

On 8/29/17 6:42 AM, Christoph Hellwig wrote:
> ---
> From e661047ec3a25587648b07c02a687a7dac778f3b Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Tue, 29 Aug 2017 14:35:50 +0200
> Subject: libata: check for trusted computing in IDENTIFY DEVICE data
> 
> ATA-8 and later mirrors the TRUSTED COMPUTING SUPPORTED bit in word 48 of
> the IDENTIFY DEVICE data.  Check this before issuing a READ LOG PAGE
> command to avoid issues with buggy devices.  The only downside is that
> we can't support Security Send / Receive for a device with an older
> revision due to the conflicting use of this field in earlier
> specifications.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/ata/libata-core.c |  3 +++
>  include/linux/ata.h       | 10 +++++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 697f5f896b19..ca57b03ab950 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2413,6 +2413,9 @@ static void ata_dev_config_trusted(struct ata_device *dev)
>  	u64 trusted_cap;
>  	unsigned int err;
>  
> +	if (!ata_id_has_trusted(dev->id))
> +		return;
> +
>  	if (!ata_identify_page_supported(dev, ATA_LOG_SECURITY)) {
>  		ata_dev_warn(dev,
>  			     "Security Log not supported\n");
> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index e65ae4b2ed48..c7a353825450 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -60,7 +60,8 @@ enum {
>  	ATA_ID_FW_REV		= 23,
>  	ATA_ID_PROD		= 27,
>  	ATA_ID_MAX_MULTSECT	= 47,
> -	ATA_ID_DWORD_IO		= 48,
> +	ATA_ID_DWORD_IO		= 48,	/* before ATA-8 */
> +	ATA_ID_TRUSTED		= 48,	/* ATA-8 and later */
>  	ATA_ID_CAPABILITY	= 49,
>  	ATA_ID_OLD_PIO_MODES	= 51,
>  	ATA_ID_OLD_DMA_MODES	= 52,
> @@ -889,6 +890,13 @@ static inline bool ata_id_has_dword_io(const u16 *id)
>  	return id[ATA_ID_DWORD_IO] & (1 << 0);
>  }
>  
> +static inline bool ata_id_has_trusted(const u16 *id)
> +{
> +	if (ata_id_major_version(id) <= 7)
> +		return false;
> +	return id[ATA_ID_TRUSTED] & (1 << 0);
> +}
> +
>  static inline bool ata_id_has_unload(const u16 *id)
>  {
>  	if (ata_id_major_version(id) >= 7 &&
> 

That works for me.

Tested-by: David Ahern <dsahern@gmail.com>
