Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CC01CC8AE
	for <linux-ide@vger.kernel.org>; Fri,  6 Sep 2024 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618104; cv=none; b=OrPXabOKI54nA/un7OsKMJRaorNwi4peeBys1xpDh5sr0lndjbaQAB2u0QDvSgk+q61Oik+euImkpzBgO6k1dq1qGe6FJ9XhoyIAjAEaAbIu8cxubUsY9haoSCUxGvrV0GrmqLl9XnnzWfypuqkPz4z3caEAmJQ4x7RiHPIpOCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618104; c=relaxed/simple;
	bh=oBy5X/kzz+Qm7cqnA9+WI1/UzykGFezcQ6+1y6SZLiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMbb+I6LD4b25uPm8Qp5ESB1VSCr2aEmvmNKy4cqiMDVpDsh4B5nTZ+JRUP4brzHPl8nlRZykZbeo0i707rWoxZXrtaSe8xVnjwKy3aZR5VyIPOVLLI773R4Px3zi+2MxLE9WNAGq1nqJy38mvIKT6EcdjCQ2freZHQ+D55/goc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtA9GRhs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtA9GRhs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D519C4CEC9;
	Fri,  6 Sep 2024 10:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725618103;
	bh=oBy5X/kzz+Qm7cqnA9+WI1/UzykGFezcQ6+1y6SZLiY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PtA9GRhsuRSZxC1OtFprNrBwp2B2M77K6oxSBw9WtvvXfIOoAvbZjn7934MvWjdzw
	 blXLMPMiu/zXVDqGQajTXV/rDxeboeDNA0r+A0mccfAFBKWDW5JOUlKgmih5lCzEaX
	 5M/OcWNJIUp0cvJW2uNMHiegV66VH0adlro3Ixr2sS8P0gvu6qJEQBqSuahmmmLkqe
	 QJaoweEUEwmuArv63/CGCwIWp4ety7lcglLQQhHM6abG5TC64s06cFPZ3rMOyBpjKp
	 tp7yqxfRtRr19yLH3dtHggITWUowBUOPNFVcpAm0PveIw1plXm/QR9UVb2StpNZ0Rc
	 vq4MdPrzeQRkg==
Message-ID: <8eb3c43d-ec72-4054-ba32-f636a073aad8@kernel.org>
Date: Fri, 6 Sep 2024 19:21:41 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] ata: libata: Improve CDL resource management
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20240906015847.229539-1-dlemoal@kernel.org>
 <20240906015847.229539-10-dlemoal@kernel.org> <ZtrCnMOLAfR5uoUz@ryzen.lan>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZtrCnMOLAfR5uoUz@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/24 17:51, Niklas Cassel wrote:

>> +static int ata_dev_init_cdl_resources(struct ata_device *dev)
>> +{
>> +	struct ata_cdl *cdl = dev->cdl;
>> +	unsigned int err_mask;
>> +
>> +	if (!cdl) {
>> +		cdl = kzalloc(sizeof(*cdl), GFP_KERNEL);
>> +		if (!cdl)
>> +			return -ENOMEM;
>> +		dev->cdl = cdl;
>> +	}
>> +
>> +	err_mask = ata_read_log_page(dev, ATA_LOG_CDL, 0, cdl->desc_log_buf,
>> +				     ATA_LOG_CDL_SIZE / ATA_SECT_SIZE);
>> +	if (err_mask) {
>> +		ata_dev_warn(dev, "Read Command Duration Limits log failed\n");
>> +		return -EIO;
> 
> Usually when a function return error, you expect it to have freed the
> resources that it might have allocated, so perhaps free and set
> dev->cdl to NULL here.

Indeed. I added a call to ata_dev_cleanup_cdl_resources().

>> @@ -2564,37 +2592,20 @@ static void ata_dev_config_cdl(struct ata_device *dev)
>>  		}
>>  	}
>>  
>> -	/*
>> -	 * Allocate a buffer to handle reading the sense data for successful
>> -	 * NCQ Commands log page for commands using a CDL with one of the limit
>> -	 * policy set to 0xD (successful completion with sense data available
>> -	 * bit set).
>> -	 */
>> -	if (!ap->ncq_sense_buf) {
>> -		ap->ncq_sense_buf = kmalloc(ATA_LOG_SENSE_NCQ_SIZE, GFP_KERNEL);
>> -		if (!ap->ncq_sense_buf)
>> -			goto not_supported;
>> -	}
>> -
>> -	/*
>> -	 * Command duration limits is supported: cache the CDL log page 18h
>> -	 * (command duration descriptors).
>> -	 */
>> -	err_mask = ata_read_log_page(dev, ATA_LOG_CDL, 0, dev->sector_buf, 1);
>> -	if (err_mask) {
>> -		ata_dev_warn(dev, "Read Command Duration Limits log failed\n");
>> +	/* CDL is supported: allocate and initialize needed resources. */
>> +	ret = ata_dev_init_cdl_resources(dev);
>> +	if (ret) {
>> +		ata_dev_warn(dev, "Initialize CDL resources failed\n");
>>  		goto not_supported;
>>  	}
>>  
>> -	memcpy(dev->cdl, dev->sector_buf, ATA_LOG_CDL_SIZE);
>>  	dev->flags |= ATA_DFLAG_CDL;
>>  
>>  	return;
>>  
>>  not_supported:
>>  	dev->flags &= ~(ATA_DFLAG_CDL | ATA_DFLAG_CDL_ENABLED);
>> -	kfree(ap->ncq_sense_buf);
>> -	ap->ncq_sense_buf = NULL;
>> +	ata_dev_cleanup_cdl_resources(dev);
> 
> Considering that you now do ata_dev_init_cdl_resources() at the end,
> if you implement my suggestion above, we can remove the call to
> ata_dev_cleanup_cdl_resources() here, since we will only jump here
> if the ata_dev_init_cdl_resources() call failed.

Nope. I think we need to keep that call because this function is going to be
called again for device revalidation, with the CDL resource already allocated.
So if we hit an error before reaching ata_dev_init_cdl_resources(), we should
free the resources. So I prefer to keep it.

> Either way:
> Reviewed-by: Niklas Cassel <cassel@kernel.org>

Thanks.

-- 
Damien Le Moal
Western Digital Research

