Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDADC77B75
	for <linux-ide@archiver.kernel.org>; Tue, 23 May 2023 07:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjEWHFv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 23 May 2023 03:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjEWHFu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 23 May 2023 03:05:50 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F40109
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2023 00:05:44 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QQQG253Vfz18L02;
        Tue, 23 May 2023 15:01:14 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 15:05:42 +0800
Subject: Re: [PATCH v2] ata: libata-scsi: Use correct device no in
 ata_find_dev()
To:     Damien Le Moal <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>
CC:     John Garry <john.g.garry@oracle.com>,
        Xingui Yang <yangxingui@huawei.com>
References: <20230523023219.291253-1-dlemoal@kernel.org>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <a291e973-32e3-f717-4b94-54a78c514800@huawei.com>
Date:   Tue, 23 May 2023 15:05:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230523023219.291253-1-dlemoal@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2023/5/23 10:32, Damien Le Moal wrote:
> For devices not attached to a port multiplier and managed directly by
> libata, the device number passed to ata_find_dev() must always be lower
> than the maximum number of devices returned by ata_link_max_devices().
> That is 1 for SATA devices or 2 for an IDE link with master+slave
> devices. This device number is the scsi device ID which matches these
> constraint as the ID are generated per port and so never exceed the
> link maximum.
> 
> However, for libsas managed devices, scsi device IDs are assigned per
> scsi host, leading to device IDs for SATA devices that can be well in
> excess of libata per-link maximum number of devices. This results in
> ata_find_dev() always returning NULL for libsas managed devices except
> for the first device of the host with ID (device number) 0. This issue
> is visible by executing hdparm command, which fails:
> 
> hdparm -i /dev/sdX
> /dev/sdX:
>    HDIO_GET_IDENTITY failed: No message of desired type
> 
> Fix this by rewriting ata_find_dev() to ignore the device number for
> non-pmp attached devices with a link with at most 1 device, that is SATA
> devices on SATA ports. For these, device number 0 is always used to
> return the correct ata_device struct of the port link. This change
> excludes IDE master/slave setups (maximum number of devices per link
> is 2) and port-multiplier attached devices.
> 
> Reported-by: Xingui Yang <yangxingui@huawei.com>
> Fixes: 41bda9c98035 ("libata-link: update hotplug to handle PMP links")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
> 
> Changes from v1:
>   * Simplify code change (remove uneeded check and remove switch-case)
>   * Reword and improve comments in ata_find_dev()
>   * Reword commit message
> 
>   drivers/ata/libata-scsi.c | 32 +++++++++++++++++++++++++-------
>   1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 7bb12deab70c..d936506a8af9 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2696,16 +2696,34 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
>   
>   static struct ata_device *ata_find_dev(struct ata_port *ap, int devno)
>   {
> -	if (!sata_pmp_attached(ap)) {
> -		if (likely(devno >= 0 &&
> -			   devno < ata_link_max_devices(&ap->link)))
> +	/*
> +	 * For the non PMP case, link_max_devices is 1 (e.g. SATA case),
> +	 * or 2 (IDE master + slave). However, the former case includes
> +	 * libsas hosted devices which are numbered per host, leading
> +	 * to devno potentially being larger than 0 but with each ata device
> +	 * having its own ata port and ata link. To accommodate these, ignore
> +	 * devno and always use device number 0.
> +	 */
> +	if (likely(!sata_pmp_attached(ap))) {
> +		int link_max_devices = ata_link_max_devices(&ap->link);
> +
> +		if (link_max_devices == 1)
> +			return &ap->link.device[0];
> +
> +		if (devno < link_max_devices)
>   			return &ap->link.device[devno];

I wonder if you can change the type of devno to 'unsigned int'? At a 
closer look I found the user can control this value and may pass in a 
bogus channel or id.

proc_scsi_write
     =>scsi_add_single_device
         =>ata_scsi_user_scan
             =>ata_find_dev

Even though the channel or id is unsigned int, It still can be turned 
into a negative value when assigned to an 'int'.

Thanks,
Jason

> -	} else {
> -		if (likely(devno >= 0 &&
> -			   devno < ap->nr_pmp_links))
> -			return &ap->pmp_link[devno].device[0];
> +
> +		return NULL;
>   	}
>   
> +	/*
> +	 * For PMP-attached devices, the device number corresponds to C
> +	 * (channel) of SCSI [H:C:I:L], indicating the port pmp link
> +	 * for the device.
> +	 */
> +	if (devno < ap->nr_pmp_links)
> +		return &ap->pmp_link[devno].device[0];
> +
>   	return NULL;
>   }
>   
> 
