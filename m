Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01E2C7EE26
	for <linux-ide@archiver.kernel.org>; Mon, 22 May 2023 12:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbjEVMFY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 22 May 2023 08:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbjEVMFV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 May 2023 08:05:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C590C93
        for <linux-ide@vger.kernel.org>; Mon, 22 May 2023 05:05:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B99261366
        for <linux-ide@vger.kernel.org>; Mon, 22 May 2023 12:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396BDC433EF;
        Mon, 22 May 2023 12:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684757119;
        bh=q2qKHFJe7arNXwdpHcK2NsXWbw93zjeF0glilah/eVc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tnYTnxdCIDLNmMdbiRBCv2kM4kZlsaTEHHFOY2O79p13k6HfrXCknPdOTs+rDuFqx
         lrswaQvLZcgi7KuhdaoCOixjOHf5S9pOfyGtth4MpugCehUbrbKjMLOLdl1h7vEuZy
         5DWyCdaev039Z6+PlBJm7ne0rHdsmeJQaGd05DPewq2puM2wYeqhzK3Hoto2MiBQ/x
         ixIRe7Bh9uJMjxxnreaXXtM7uCyssRDqGvjiszgsyoCOQZLR+r2LrRD7hktfm1NQv3
         da40Av3AScwoSzllA7Lgcuft/cJgwhLNtzS+JMZ6XB/SYsTpAB4oIyTzz/xl4h4PJD
         CpkezobwZLhqA==
Message-ID: <6a7b7e2c-efb9-1c04-97c9-1186584e5ea3@kernel.org>
Date:   Mon, 22 May 2023 21:05:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ata: libata-scsi: Use correct device no in ata_find_dev()
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, linux-ide@vger.kernel.org
Cc:     Jason Yan <yanaijie@huawei.com>,
        Xingui Yang <yangxingui@huawei.com>
References: <20230522112751.266505-1-dlemoal@kernel.org>
 <507d7c2d-ceb3-f03b-0ca0-ca96729ed7ce@oracle.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <507d7c2d-ceb3-f03b-0ca0-ca96729ed7ce@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/22/23 20:48, John Garry wrote:
> On 22/05/2023 12:27, Damien Le Moal wrote:
> 
> Hi Damien,
> 
> Our mails just crossed...
> 
>> For non-pmp attached devices managed directly by libata, the device
>> number is always 0 or 1 and lower to the maximum number of devices
>> returned by ata_link_max_devices(). However, for libsas managed devices,
>> devices are numbered up to the number of device scanned on an HBA port,
> 
> It's not really clear to me which number you mean. For libsas and lib 
> ata, ata_device->devno is configured the same, it's just that the sdev 

devno used in ata_find_dev() is scsidev->id, which is always 0 for a non-pmp
SATA drive (and can be 1 for an IDE slave drive). But with libsas, that number
is 0, 1, 2, 3... numbering the devices found on the HBA port. Hence
ata_find_dev() return NULL always because the ata_link_max_devices() is always 1
for any libsas ata device as they all have their own ata_port & ata_link.

> per ata_device does not have the same numbering scheme for libsas. For 
> libsas - or scsi_transport_sas, to be more exact - the sdev id is per shost.

Yes. So the sdev->id goes beyond 0 and cannot be used as the devno for the
devices as they each have their own port & link.

> 
>> while each device has a regular ata/link setup supporting at most 1
>> device per link. This results in ata_find_dev() always returning NULL
>> except for the first device with device number 0.
>>
>> Fix this by rewriting ata_find_dev() to ignore the device number for
>> non-pmp attached devices with a link with at most 1 device. For these,
>> device number 0 is always used to return the correct ata_device struct
>> of the port link. This change excludes IDE master/slave setups (maximum
>> number of devices per link is 2) and port-multiplier attached devices.
>>
>> Reported-by: Xingui Yang <yangxingui@huawei.com>
>> Fixes: 41bda9c98035 ("libata-link: update hotplug to handle PMP links")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>   drivers/ata/libata-scsi.c | 31 ++++++++++++++++++++++++-------
>>   1 file changed, 24 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index 7bb12deab70c..3ba9cb258394 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -2696,16 +2696,33 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
>>   
>>   static struct ata_device *ata_find_dev(struct ata_port *ap, int devno)
>>   {
>> -	if (!sata_pmp_attached(ap)) {
>> -		if (likely(devno >= 0 &&
>> -			   devno < ata_link_max_devices(&ap->link)))
>> +	if (unlikely(devno < 0))
>> +		return NULL;
>> +
>> +	if (likely(!sata_pmp_attached(ap))) {
>> +		/*
>> +		 * For the non PMP case, the maximum number of devices per link
>> +		 * is 1 (e.g. SATA case), or 2 (IDE master + slave). The former
>> +		 * case includes libsas hosted devices which are numbered up to
>> +		 * the number of devices scanned on an HBA port, but with each
>> +		 * ata device having its own ata port and link. To accommodate
>> +		 * these, ignore devno and always use device number 0.
>> +		 */
>> +		switch (ata_link_max_devices(&ap->link)) {
>> +		case 1:
>> +			return &ap->link.device[0];
>> +		case 2:
>> +			if (devno >= 2)
> 
> How about ATA_MAX_DEVICES?

Indeed. That would be nicer. And ata_link_max_devices() could use that as well.

> 
>> +				return NULL;
>>   			return &ap->link.device[devno];
>> -	} else {
>> -		if (likely(devno >= 0 &&
>> -			   devno < ap->nr_pmp_links))
>> -			return &ap->pmp_link[devno].device[0];
>> +		default:
>> +			return NULL;
>> +		}
>>   	}
>>   
>> +	if (devno < ap->nr_pmp_links)
>> +		return &ap->pmp_link[devno].device[0];
>> +
>>   	return NULL;
>>   }
> 
> This looks ok to me, since we have a big comment about what we're doing. 

I am not super happy about the wording of the comment. Suggestions welcome :)
I will at least reword to mention the counting of devices per shost.

> I did send another suggestion, so I'll leave it to you.

I kind of like the loop as it does not need a devno but it also implies that we
do have a scsi dev already while ata_find_dev() currently does not assume that.
Given that this function is also used in ata_scsi_user_scan() where we do not
have a sdev, it would not work for all cases.

> 
> BTW, I think that we can follow-up to this and remove the add ata_device 
> arg that we added to sas_change_queue_depth()

Yes. I will clean that up after sending this fix for this cycle. The cleanup
will be for 6.5.

> 
> Thanks,
> John
> 

-- 
Damien Le Moal
Western Digital Research

