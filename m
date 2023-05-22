Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD28C7EE26
	for <linux-ide@archiver.kernel.org>; Mon, 22 May 2023 13:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjEVNJW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 22 May 2023 09:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbjEVNJV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 May 2023 09:09:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C10AB
        for <linux-ide@vger.kernel.org>; Mon, 22 May 2023 06:09:19 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QPyPm2YvkzLpQD;
        Mon, 22 May 2023 21:06:20 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 21:09:15 +0800
Subject: Re: [PATCH] ata: libata-scsi: Use correct device no in ata_find_dev()
To:     Damien Le Moal <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>
CC:     John Garry <john.g.garry@oracle.com>,
        Xingui Yang <yangxingui@huawei.com>
References: <20230522112751.266505-1-dlemoal@kernel.org>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <4807fd76-22e3-acde-67b6-13b46e05d002@huawei.com>
Date:   Mon, 22 May 2023 21:09:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230522112751.266505-1-dlemoal@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2023/5/22 19:27, Damien Le Moal wrote:
> For non-pmp attached devices managed directly by libata, the device
> number is always 0 or 1 and lower to the maximum number of devices
> returned by ata_link_max_devices(). However, for libsas managed devices,
> devices are numbered up to the number of device scanned on an HBA port,
> while each device has a regular ata/link setup supporting at most 1
> device per link. This results in ata_find_dev() always returning NULL
> except for the first device with device number 0.
> 
> Fix this by rewriting ata_find_dev() to ignore the device number for
> non-pmp attached devices with a link with at most 1 device. For these,
> device number 0 is always used to return the correct ata_device struct
> of the port link. This change excludes IDE master/slave setups (maximum
> number of devices per link is 2) and port-multiplier attached devices.
> 
> Reported-by: Xingui Yang <yangxingui@huawei.com>
> Fixes: 41bda9c98035 ("libata-link: update hotplug to handle PMP links")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 31 ++++++++++++++++++++++++-------
>   1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 7bb12deab70c..3ba9cb258394 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2696,16 +2696,33 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
>   
>   static struct ata_device *ata_find_dev(struct ata_port *ap, int devno)
>   {
> -	if (!sata_pmp_attached(ap)) {
> -		if (likely(devno >= 0 &&
> -			   devno < ata_link_max_devices(&ap->link)))
> +	if (unlikely(devno < 0))
> +		return NULL;

devno is either scsidev->id or scsidev->channel, which will never < 0. 
Actually it is unsigned int. So I doubt if we need this check here.

> +
> +	if (likely(!sata_pmp_attached(ap))) {
> +		/*
> +		 * For the non PMP case, the maximum number of devices per link
> +		 * is 1 (e.g. SATA case), or 2 (IDE master + slave). The former
> +		 * case includes libsas hosted devices which are numbered up to
> +		 * the number of devices scanned on an HBA port, but with each
> +		 * ata device having its own ata port and link. To accommodate
> +		 * these, ignore devno and always use device number 0.
> +		 */
> +		switch (ata_link_max_devices(&ap->link)) {
> +		case 1:
> +			return &ap->link.device[0];
> +		case 2:
> +			if (devno >= 2)
> +				return NULL;
>   			return &ap->link.device[devno];
> -	} else {
> -		if (likely(devno >= 0 &&
> -			   devno < ap->nr_pmp_links))
> -			return &ap->pmp_link[devno].device[0];
> +		default:
> +			return NULL;
> +		}
>   	}
>   
> +	if (devno < ap->nr_pmp_links)
> +		return &ap->pmp_link[devno].device[0];
> +
>   	return NULL;
>   }

This change looks good to me.

Thanks,
Jason

