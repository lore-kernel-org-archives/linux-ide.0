Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AACAC77B75
	for <linux-ide@archiver.kernel.org>; Tue, 23 May 2023 11:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbjEWLwf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 23 May 2023 07:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjEWLwf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 23 May 2023 07:52:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0010D118
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2023 04:52:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8929062607
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2023 11:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CDBC433EF;
        Tue, 23 May 2023 11:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684842752;
        bh=3F60oSUlrFfrv4sj1I0amJ+8kg7+6gfUycVcRb2wAhk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oHEP0t/BeMddEmbtYIheCbNoEE3Qj0PvhGPJODqxxxdpAaB8cFoloiDTo8eDJjWg7
         p1cqYxu2GMZofCM//mdvRgr548Kgtb7sj71p8gmZg2vfPvQsqmTvhLHJVcEUoNPI+L
         Z/lbbJzacmdUrH3b0sFM5D6L/IqJ0mktVTfIc957mVT3JUiQqNhuZa6iY/6d2Z2QEw
         9w03/wwulZNU0eDD2ofkrOYHLe/j/dedLDGLWMNy7wUeM5XTqWKHkPrRVPU712AP9J
         ARakWO62wY8uZzW9xb14ecAamlrdf7dtIVD0IXpfGO1+Qfv0ftEpDzh0d3TpHyhJr9
         NAsmIiPDLYuzQ==
Message-ID: <301a5198-9686-e3b5-74d8-4e5e85e6fc08@kernel.org>
Date:   Tue, 23 May 2023 20:52:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] ata: libata-scsi: Use correct device no in
 ata_find_dev()
Content-Language: en-US
To:     Jason Yan <yanaijie@huawei.com>, linux-ide@vger.kernel.org
Cc:     John Garry <john.g.garry@oracle.com>,
        Xingui Yang <yangxingui@huawei.com>
References: <20230523023219.291253-1-dlemoal@kernel.org>
 <a291e973-32e3-f717-4b94-54a78c514800@huawei.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <a291e973-32e3-f717-4b94-54a78c514800@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/23/23 16:05, Jason Yan wrote:
> On 2023/5/23 10:32, Damien Le Moal wrote:
>> For devices not attached to a port multiplier and managed directly by
>> libata, the device number passed to ata_find_dev() must always be lower
>> than the maximum number of devices returned by ata_link_max_devices().
>> That is 1 for SATA devices or 2 for an IDE link with master+slave
>> devices. This device number is the scsi device ID which matches these
>> constraint as the ID are generated per port and so never exceed the
>> link maximum.
>>
>> However, for libsas managed devices, scsi device IDs are assigned per
>> scsi host, leading to device IDs for SATA devices that can be well in
>> excess of libata per-link maximum number of devices. This results in
>> ata_find_dev() always returning NULL for libsas managed devices except
>> for the first device of the host with ID (device number) 0. This issue
>> is visible by executing hdparm command, which fails:
>>
>> hdparm -i /dev/sdX
>> /dev/sdX:
>>    HDIO_GET_IDENTITY failed: No message of desired type
>>
>> Fix this by rewriting ata_find_dev() to ignore the device number for
>> non-pmp attached devices with a link with at most 1 device, that is SATA
>> devices on SATA ports. For these, device number 0 is always used to
>> return the correct ata_device struct of the port link. This change
>> excludes IDE master/slave setups (maximum number of devices per link
>> is 2) and port-multiplier attached devices.
>>
>> Reported-by: Xingui Yang <yangxingui@huawei.com>
>> Fixes: 41bda9c98035 ("libata-link: update hotplug to handle PMP links")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>
>> Changes from v1:
>>   * Simplify code change (remove uneeded check and remove switch-case)
>>   * Reword and improve comments in ata_find_dev()
>>   * Reword commit message
>>
>>   drivers/ata/libata-scsi.c | 32 +++++++++++++++++++++++++-------
>>   1 file changed, 25 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index 7bb12deab70c..d936506a8af9 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -2696,16 +2696,34 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
>>   
>>   static struct ata_device *ata_find_dev(struct ata_port *ap, int devno)
>>   {
>> -	if (!sata_pmp_attached(ap)) {
>> -		if (likely(devno >= 0 &&
>> -			   devno < ata_link_max_devices(&ap->link)))
>> +	/*
>> +	 * For the non PMP case, link_max_devices is 1 (e.g. SATA case),
>> +	 * or 2 (IDE master + slave). However, the former case includes
>> +	 * libsas hosted devices which are numbered per host, leading
>> +	 * to devno potentially being larger than 0 but with each ata device
>> +	 * having its own ata port and ata link. To accommodate these, ignore
>> +	 * devno and always use device number 0.
>> +	 */
>> +	if (likely(!sata_pmp_attached(ap))) {
>> +		int link_max_devices = ata_link_max_devices(&ap->link);
>> +
>> +		if (link_max_devices == 1)
>> +			return &ap->link.device[0];
>> +
>> +		if (devno < link_max_devices)
>>   			return &ap->link.device[devno];
> 
> I wonder if you can change the type of devno to 'unsigned int'? At a 
> closer look I found the user can control this value and may pass in a 
> bogus channel or id.
> 
> proc_scsi_write
>      =>scsi_add_single_device
>          =>ata_scsi_user_scan
>              =>ata_find_dev

Reading more about scsi_add_single_device(), the comment says "Note: this seems
to be aimed exclusively at SCSI parallel busses.". So I don't think we should
worry about it. But then I also do not understand why libata is wired to this at
all. Cannot have ATA device on a parallel SCSI bus...

On my system, I cannot get

echo "scsi add-single-device X 0 100 0" >/proc/scsi/scsi

to do anything and so I do not see how ata_scsi_user_scan can ever be called...

> 
> Even though the channel or id is unsigned int, It still can be turned 
> into a negative value when assigned to an 'int'.
> 
> Thanks,
> Jason
> 
>> -	} else {
>> -		if (likely(devno >= 0 &&
>> -			   devno < ap->nr_pmp_links))
>> -			return &ap->pmp_link[devno].device[0];
>> +
>> +		return NULL;
>>   	}
>>   
>> +	/*
>> +	 * For PMP-attached devices, the device number corresponds to C
>> +	 * (channel) of SCSI [H:C:I:L], indicating the port pmp link
>> +	 * for the device.
>> +	 */
>> +	if (devno < ap->nr_pmp_links)
>> +		return &ap->pmp_link[devno].device[0];
>> +
>>   	return NULL;
>>   }
>>   
>>

-- 
Damien Le Moal
Western Digital Research

