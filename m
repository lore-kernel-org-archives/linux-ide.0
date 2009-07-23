From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [RFC] add DMA setup FIS auto-activate feature
Date: Thu, 23 Jul 2009 12:07:13 -0600
Message-ID: <4A68A6D1.4090508@gmail.com>
References: <1248320734.9035.22.camel@sli10-desk.sh.intel.com> <4A67E00F.40808@pobox.com> <20090723054007.GA7473@sli10-desk.sh.intel.com> <4A67F8ED.2070204@kernel.org> <4A67FE1A.1050408@pobox.com> <4A67FF56.5040708@kernel.org> <4A6807A8.30403@pobox.com> <20090723072518.GA3545@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f186.google.com ([209.85.216.186]:36480 "EHLO
	mail-px0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbZGWSMO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Jul 2009 14:12:14 -0400
Received: by pxi16 with SMTP id 16so91036pxi.33
        for <linux-ide@vger.kernel.org>; Thu, 23 Jul 2009 11:12:14 -0700 (PDT)
In-Reply-To: <20090723072518.GA3545@sli10-desk.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <tj@kernel.org>, linux-ide <linux-ide@vger.kernel.org>

On 07/23/2009 01:25 AM, Shaohua Li wrote:
> On Thu, Jul 23, 2009 at 02:48:08PM +0800, Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> Jeff Garzik wrote:
>>>> AA was added in SATA II, and the SATA II specs specifically mention that
>>>> AA was not present in SATA 1.0.
>>> Yeap, it wasn't in SATA 1.0 but it was in ahci 1.0 so _theoretically_
>>> all ahcis should be fine with it.  We can introduce ATA_FLAG_FPDMA_AA
>>> and let the drivers set it.
>>
>> Yep -- that was the logical conclusion of my rhetorical question at the
>> beginning of this thread ;-)
> Something like below?
>
> Add SATA DMA setup FIS auto-activate feature in AHCI.
>
> Signed-off-by: Shaohua Li<shaohua.li@intel.com>
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 336eb1e..d5d67b8 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -2802,7 +2802,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>
>   	/* prepare host */
>   	if (hpriv->cap&  HOST_CAP_NCQ)
> -		pi.flags |= ATA_FLAG_NCQ;
> +		pi.flags |= ATA_FLAG_NCQ | ATA_FLAG_FPDMA_AA;
>
>   	if (hpriv->cap&  HOST_CAP_PMP)
>   		pi.flags |= ATA_FLAG_PMP;
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 2c6aeda..62355cf 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2303,6 +2303,7 @@ static void ata_dev_config_ncq(struct ata_device *dev,
>   {
>   	struct ata_port *ap = dev->link->ap;
>   	int hdepth = 0, ddepth = ata_id_queue_depth(dev->id);
> +	const u16 *id = dev->id;
>
>   	if (!ata_id_has_ncq(dev->id)) {
>   		desc[0] = '\0';
> @@ -2317,6 +2318,10 @@ static void ata_dev_config_ncq(struct ata_device *dev,
>   		dev->flags |= ATA_DFLAG_NCQ;
>   	}
>
> +	if ((ap->flags&  ATA_FLAG_FPDMA_AA)&&  ata_id_has_fpdma_aa(id))
> +		ata_dev_set_feature(dev, SETFEATURES_SATA_ENABLE,
> +			SATA_FPDMA_AA);
> +
>   	if (hdepth>= ddepth)
>   		snprintf(desc, desc_sz, "NCQ (depth %d)", ddepth);
>   	else
> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index 9c75921..f549405 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -306,6 +306,7 @@ enum {
>   	/* SETFEATURE Sector counts for SATA features */
>   	SATA_AN			= 0x05,  /* Asynchronous Notification */
>   	SATA_DIPM		= 0x03,  /* Device Initiated Power Management */
> +	SATA_FPDMA_AA		= 0x02,  /* DMA Setup FIS Auto-Activate */
>
>   	/* feature values for SET_MAX */
>   	ATA_SET_MAX_ADDR	= 0x00,
> @@ -525,6 +526,9 @@ static inline int ata_is_data(u8 prot)
>   #define ata_id_has_atapi_AN(id)	\
>   	( (((id)[76] != 0x0000)&&  ((id)[76] != 0xffff))&&  \
>   	  ((id)[78]&  (1<<  5)) )
> +#define ata_id_has_fpdma_aa(id)	\
> +	( (((id)[76] != 0x0000)&&  ((id)[76] != 0xffff))&&  \
> +	  ((id)[78]&  (1<<  2)) )
>   #define ata_id_iordy_disable(id) ((id)[ATA_ID_CAPABILITY]&  (1<<  10))
>   #define ata_id_has_iordy(id) ((id)[ATA_ID_CAPABILITY]&  (1<<  11))
>   #define ata_id_u32(id,n)	\
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 79b6d7f..ca210d8 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -190,6 +190,7 @@ enum {
>   	ATA_FLAG_NO_POWEROFF_SPINDOWN = (1<<  11), /* don't spindown before poweroff */
>   	ATA_FLAG_NO_HIBERNATE_SPINDOWN = (1<<  12), /* don't spindown before hibernation */
>   	ATA_FLAG_DEBUGMSG	= (1<<  13),
> +	ATA_FLAG_FPDMA_AA		= (1<<  14), /* driver supports Auto-Activate */
>   	ATA_FLAG_IGN_SIMPLEX	= (1<<  15), /* ignore SIMPLEX */
>   	ATA_FLAG_NO_IORDY	= (1<<  16), /* controller lacks iordy */
>   	ATA_FLAG_ACPI_SATA	= (1<<  17), /* need native SATA ACPI layout */

Seems reasonable to me, though we may want to print something out during 
device identification to indicate that we're using AA (like we do for 
ATAPI AN).
