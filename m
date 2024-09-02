Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505A72D057
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 06:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725258505; cv=none; b=D9Z85LDWbl4grwUJyot8UV3dOD6iTS/Q9EjV3a9bxadl+fWHa7YFM9jN/BcXSmC5Oou8wZvz8OpnJttcIxkWuaC67TUl+A0Nqe6gvPRKS+bsd3MP0ZVin++/pStdWnqO5jr2+F+MEaUz/qRymIwxK9hpmCpqDnQeeG3o0Lf8VSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725258505; c=relaxed/simple;
	bh=La4NA5nzZoK8ZLOPTZ5VD4AYsUitr3E3/I6u06udmoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RdN7NC2lidVbRFmJ0LyEKEaOv4KEIt370CYCGQzbZEucvE0OGQGMI1YxaPPs50w/8M2ylQOadpKzxPZgkoTubPyvX/D07l2CeHEoibJdrhf/c5s3fynlTpnaWAPqs/KhfnAMvJ7A5nWaF7a8CntNNQ75Vcc48W7w9lVXQaQ5g/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btatrcjc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btatrcjc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A855C4CEC2;
	Mon,  2 Sep 2024 06:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725258504;
	bh=La4NA5nzZoK8ZLOPTZ5VD4AYsUitr3E3/I6u06udmoA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=btatrcjc+XaGHbtr3/aPxjhEcqfSMO7ugXuA9fzZeNJ5jhfbHh7EAIO+iYFOGLA8u
	 hjYj4/0AhSzFBWG3LtUNkIsOsdwdWFFvbNLUisRh9fUEXmkSSfHCaCI9Qv3UBc8MJg
	 jGN+9EavSFTDX2E7y2lA+2fkJJ/X5nZGaFTYDIhh0pYUQj247XLLC/MxI0qn+g867p
	 0Sja7nWH0I2UCV8n5wNOhb5uZ3jNyjrAcVwR2MSEDbWg/G9Squ/6vgJNRQzaetDcE6
	 ngRCfTRIbYmxIF7MQC4G0zSYxMxnhAwss+Biltuf4/iZCjlaWqOIsVo3LtLjK5vuT5
	 CjTIqTUfHnhMg==
Message-ID: <4f5521a2-b3cb-48ba-b51a-51db62ff1902@kernel.org>
Date: Mon, 2 Sep 2024 15:28:21 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] ata: libata: Cleanup libata-transport
To: Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20240902000043.155495-1-dlemoal@kernel.org>
 <20240902000043.155495-2-dlemoal@kernel.org>
 <e34aded2-c0f4-44f1-8941-4eb8c3818bc2@suse.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <e34aded2-c0f4-44f1-8941-4eb8c3818bc2@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/24 15:16, Hannes Reinecke wrote:
>>   /*
>>    * ATA device attributes
>>    */
>> @@ -660,14 +525,14 @@ static int ata_tdev_match(struct attribute_container *cont,
>>   }
>>   
>>   /**
>> - * ata_tdev_free  --  free a ATA LINK
>> - * @dev:	ATA PHY to free
>> + * ata_tdev_free  --  free a transport ATA device structure
> 
> Odd wording; maybe 'ATA transport device' ?

Indeed.

> 
>> + * @dev:	target ATA device
> 
> Why 'target ATA device'? Wouldn't 'ATA transport device' be better?

Because that function really takes a pointer to struct ata_dev, not to struct
ata_dev->tdev...

> 
>>    *
>> - * Frees the specified ATA PHY.
>> + * Free the transport ATA device structure for the specified ATA device.
> 
> Same here.
> 
>>    *
>>    * Note:
>> - *   This function must only be called on a PHY that has not
>> - *   successfully been added using ata_tdev_add().
>> + *   This function must only be called on a device that has not successfully
> 
> 'device'? Shouldn't we not use the same wording as in the description?

Not really. Here the reference is to the struct ata_device. Will clarify that.

> 
>> + *   been added using ata_tdev_add().
>>    */
>>   static void ata_tdev_free(struct ata_device *dev)
>>   {
>> @@ -676,10 +541,10 @@ static void ata_tdev_free(struct ata_device *dev)
>>   }
>>   
>>   /**
>> - * ata_tdev_delete  --  remove ATA device
>> - * @ata_dev:	ATA device to remove
>> + * ata_tdev_delete  --  remove an ATA device sysfs entry
>> + * @ata_dev:	target ATA device
>>    *
> 
> And here we should be consistent with whatever wording we've been using
> in ata_tdev_free().

Yep, will fix.

>> +/**
>> + * ata_is_link --  check if a struct device represents a ATA link
>> + * @dev:	device to check
>> + *
>> + * Returns:
>> + *	%1 if the device represents a ATA link, %0 else
>> + */
>> +static int ata_is_link(const struct device *dev)
> 
> Why is this not a boolean ?

It was like that. I can make it a boolean.

> 
>> +{
>> +	return dev->release == ata_tlink_release;
>> +}
>> +
>> +static int ata_tlink_match(struct attribute_container *cont,
>> +			   struct device *dev)
>> +{
>> +	struct ata_internal *i = to_ata_internal(ata_scsi_transport_template);
>> +
>> +	if (!ata_is_link(dev))
>> +		return 0;
>> +	return &i->link_attr_cont.ac == cont;
>> +}
>> +
>> +/**
>> + * ata_tlink_delete  --  remove ATA LINK
>> + * @link:	ATA LINK to remove
> 
> Why is the 'link' in capital letters?

No idea. It was like that. Will clean that up as well.

>> + *
>> + * Initialize an ATA LINK structure for sysfs.  It will be added in the
>> + * device tree below the ATA PORT it belongs to.
>> + *
>> + * Returns %0 on success
> 
> And what on failure?

Another one that I did not touch but clearly needs cleanup too :)


-- 
Damien Le Moal
Western Digital Research

