Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FBBC6FA82
	for <linux-ide@archiver.kernel.org>; Mon, 26 Sep 2022 23:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiIZXFK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 26 Sep 2022 19:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiIZXFJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Sep 2022 19:05:09 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D78CA927F
        for <linux-ide@vger.kernel.org>; Mon, 26 Sep 2022 16:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664233507; x=1695769507;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=eKnkjWI7rvgP1Xc5BeMmuyTOF0H1sFW1ko4/vAeazoE=;
  b=qGtHOiExrTVRzX11zs6RHtdpo6g4s/gAGV8Z99376Y5vQp78EwesTQNu
   xOMszOVfuLiISZ4s21Bnt/Qwl4tlC811donM31Qi0ksSSf3L6hLhhqkpu
   vhdwBUuhZucLp57069NxzS7bNRrNHiSE1GmMOQRxbncsxtcYUQI485DjG
   0U9LGYWMbk2+RbyN1IlvpUIP0RvXawbNkxFxDThbi1f0Uk+kIvlvYY5HT
   W5NRJNX11nMExQWdpsd7997P2B4jIGnp/XAqMi7euoOoAG41Q7nmQjeEA
   lbGXPBkF+59Upywaf5PtSoiBl96KFnNITOgVDJxG75ikNMP8QtYktV++M
   A==;
X-IronPort-AV: E=Sophos;i="5.93,347,1654531200"; 
   d="scan'208";a="316608033"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2022 07:05:03 +0800
IronPort-SDR: Tr+qSYNK9zXdbZbgud0eJ0RzcPwFphT0wYULNNUuR2VwdQAn7TAlhmd8TivX2jzae5u/5CfLXW
 ZzXDznW47LYFMMObziPOVxixq6ly6tmjtUCsUgnPBGJ69WGCbvxtodheY0utQnHOEahBvVNrep
 jk4t42x8C/E3ksTnGsLjBTKCK94eFlJgLLlgLa+9oPycINTsHi3m3VMIWVwScwwoqpC59LOqI0
 5ti1SbOONFeJWeD1R9LpT/WrCWCMJIFFUf4MDaiNnhuwg9ZGh5ND733w/d31O0AeQe3YvHZMdk
 r55vp60cF49aWPncAWUyqVKX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 15:25:01 -0700
IronPort-SDR: 0IJvt5hJ6427cNiV84b6z89c75VS+0i0KlwyJ2r32I1oIQCbgIZEX8G1KiyfXfeX+xqxjRoD0S
 GQ9QhFhMPwdK48Xp58cW54IpuAjJcVyS0G8s9rPdutPcamr6uELuanmUG8iQPQZEwOgpp45gYq
 /ZMPgfk/qSj6dDDrfN5FNIvdJwf/vkHPt8EMwytnyp9cPI1nVpbBnZEZWS+7C2mLqq1aWO1Ng+
 DcUznrNz98cpi4mCdzEP9Sfpd1Ik0Ho6Tx1yZ98YIVsBfrNmmdhnJSG3Ehy/9t8kcuQP0mEu/l
 wJQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 16:05:04 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MbyyR4FMqz1RvTr
        for <linux-ide@vger.kernel.org>; Mon, 26 Sep 2022 16:05:03 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664233502; x=1666825503; bh=eKnkjWI7rvgP1Xc5BeMmuyTOF0H1sFW1ko4
        /vAeazoE=; b=TFCYH2ErgnwJYr5TLuy4c6IIHvgWtd+CSg1U3PTV/8GzyuH2yC7
        3GWi0xB3FbiyaHqMo6VEPoVEGgU2cWiicQLG17ghMeZP92+ejsEZyYYU1yDiRzKR
        Rl061csFTOw2DrzOq912dz0K+FKJYFxIK/0znYbd/yNcZEhDx7E73xUM+WzMUPrR
        vSk7ooj2DGjvKHq5lXmyxH+x1jBVkYz63j2fmeQaavwTk/bs0i3bTDj8pVr9ZGSX
        MPQwCrGV3KR3DkBoABzq+NgFJT+JmeFic32rUFuynQTBonD3JbwR9Ae/sQkH46bn
        eDLkpp8rRZ0R9CLjmtNwWLOv+EPc/wYVXxA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oCEoMMiyjSPx for <linux-ide@vger.kernel.org>;
        Mon, 26 Sep 2022 16:05:02 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MbyyQ15nqz1RvLy;
        Mon, 26 Sep 2022 16:05:01 -0700 (PDT)
Message-ID: <92d87d6c-9bd0-0cf9-1ced-bac104ea2d66@opensource.wdc.com>
Date:   Tue, 27 Sep 2022 08:05:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/2] ata: libata-sata: Fix device queue depth control
To:     John Garry <john.garry@huawei.com>, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20220925230817.91542-1-damien.lemoal@opensource.wdc.com>
 <20220925230817.91542-3-damien.lemoal@opensource.wdc.com>
 <5bab7eb9-7b91-8c06-e8c3-f2076bac78dc@huawei.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <5bab7eb9-7b91-8c06-e8c3-f2076bac78dc@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/26/22 20:31, John Garry wrote:
> On 26/09/2022 00:08, Damien Le Moal wrote:
>> The function __ata_change_queue_depth() uses the helper
>> ata_scsi_find_dev() to get the ata_device structure of a scsi device and
>> set that device maximum queue depth. However, when the ata device is
>> managed by libsas,
> 
> Yeah, this current code is utterly broken. Just a nit is that it would 
> be good to mention that the sdev id is assigned by scsi_transport_sas 
> (and not libata) for when using libsas.
> 
> In my series "Allocate SCSI device earlier for ata port probe" I 
> mentioned this problem of different id assignment scheme. It would be 
> nice to try to commonize this.
> 
>> ata_scsi_find_dev() returns NULL, turning
>> __ata_change_queue_depth() into a nop, which prevents the user from
>> setting the maximum queue depth of ATA devices used with libsas based
>> HBAs.
>>
>> Fix this by renaming __ata_change_queue_depth() to
>> ata_change_queue_depth() and adding a pointer to the ata_device
>> structure of the target device as argument. This pointer is provided by
>> ata_scsi_change_queue_depth() using ata_scsi_find_dev() in the case of
>> a libata managed device and by sas_change_queue_depth() using
>> sas_to_ata_dev() in the case of a libsas managed ata device.
> 
> This seems ok. But could you alternatively use ata_for_each_dev() and 
> match by ata_device.sdev pointer? That pointer is set quite late in the 
> probe, though, so maybe it would not work.

Not sure I understand why we should search for the ata device again using
ata_for_each_dev() when sas_to_ata_dev() gives us directly what we need
for the libsas controlled device... Can you clarify ?

> 
> As an aside, one other thing I noticed is that ata_device.private_data 
> is unused. Maybe we should delete it - apparently it was added just for 
> symmetry of libata structures.
> 
> Thanks,
> John
> 
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>   drivers/ata/libata-sata.c           | 24 ++++++++++++------------
>>   drivers/scsi/libsas/sas_scsi_host.c |  3 ++-
>>   include/linux/libata.h              |  4 ++--
>>   3 files changed, 16 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
>> index 7a5fe41aa5ae..13b9d0fdd42c 100644
>> --- a/drivers/ata/libata-sata.c
>> +++ b/drivers/ata/libata-sata.c
>> @@ -1018,26 +1018,25 @@ DEVICE_ATTR(sw_activity, S_IWUSR | S_IRUGO, ata_scsi_activity_show,
>>   EXPORT_SYMBOL_GPL(dev_attr_sw_activity);
>>   
>>   /**
>> - *	__ata_change_queue_depth - helper for ata_scsi_change_queue_depth
>> - *	@ap: ATA port to which the device change the queue depth
>> + *	ata_change_queue_depth - Set a device maximum queue depth
>> + *	@ap: ATA port of the target device
>> + *	@dev: target ATA device
>>    *	@sdev: SCSI device to configure queue depth for
>>    *	@queue_depth: new queue depth
>>    *
>> - *	libsas and libata have different approaches for associating a sdev to
>> - *	its ata_port.
>> + *	Helper to set a device maximum queue depth, usable with both libsas
>> + *	and libata.
>>    *
>>    */
>> -int __ata_change_queue_depth(struct ata_port *ap, struct scsi_device *sdev,
>> -			     int queue_depth)
>> +int ata_change_queue_depth(struct ata_port *ap, struct ata_device *dev,
>> +			   struct scsi_device *sdev, int queue_depth)
>>   {
>> -	struct ata_device *dev;
>>   	unsigned long flags;
>>   
>> -	if (queue_depth < 1 || queue_depth == sdev->queue_depth)
>> +	if (!dev || !ata_dev_enabled(dev))
>>   		return sdev->queue_depth;
>>   
>> -	dev = ata_scsi_find_dev(ap, sdev);
>> -	if (!dev || !ata_dev_enabled(dev))
>> +	if (queue_depth < 1 || queue_depth == sdev->queue_depth)
>>   		return sdev->queue_depth;
>>   
>>   	/* NCQ enabled? */
>> @@ -1059,7 +1058,7 @@ int __ata_change_queue_depth(struct ata_port *ap, struct scsi_device *sdev,
>>   
>>   	return scsi_change_queue_depth(sdev, queue_depth);
>>   }
>> -EXPORT_SYMBOL_GPL(__ata_change_queue_depth);
>> +EXPORT_SYMBOL_GPL(ata_change_queue_depth);
>>   
>>   /**
>>    *	ata_scsi_change_queue_depth - SCSI callback for queue depth config
>> @@ -1080,7 +1079,8 @@ int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
>>   {
>>   	struct ata_port *ap = ata_shost_to_port(sdev->host);
>>   
>> -	return __ata_change_queue_depth(ap, sdev, queue_depth);
>> +	return ata_change_queue_depth(ap, ata_scsi_find_dev(ap, sdev),
>> +				      sdev, queue_depth);
>>   }
>>   EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
>>   
>> diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
>> index 9c82e5dc4fcc..a36fa1c128a8 100644
>> --- a/drivers/scsi/libsas/sas_scsi_host.c
>> +++ b/drivers/scsi/libsas/sas_scsi_host.c
>> @@ -872,7 +872,8 @@ int sas_change_queue_depth(struct scsi_device *sdev, int depth)
>>   	struct domain_device *dev = sdev_to_domain_dev(sdev);
>>   
>>   	if (dev_is_sata(dev))
>> -		return __ata_change_queue_depth(dev->sata_dev.ap, sdev, depth);
>> +		return ata_change_queue_depth(dev->sata_dev.ap,
>> +					      sas_to_ata_dev(dev), sdev, depth);
>>   
>>   	if (!sdev->tagged_supported)
>>   		depth = 1;
>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index 698032e5ef2d..20765d1c5f80 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
>> @@ -1136,8 +1136,8 @@ extern int ata_scsi_slave_config(struct scsi_device *sdev);
>>   extern void ata_scsi_slave_destroy(struct scsi_device *sdev);
>>   extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
>>   				       int queue_depth);
>> -extern int __ata_change_queue_depth(struct ata_port *ap, struct scsi_device *sdev,
>> -				    int queue_depth);
>> +extern int ata_change_queue_depth(struct ata_port *ap, struct ata_device *dev,
>> +				  struct scsi_device *sdev, int queue_depth);
>>   extern struct ata_device *ata_dev_pair(struct ata_device *adev);
>>   extern int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
>>   extern void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap);
> 

-- 
Damien Le Moal
Western Digital Research

