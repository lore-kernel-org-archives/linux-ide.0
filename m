Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC24233D88
	for <linux-ide@vger.kernel.org>; Thu,  3 Jul 2025 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751537403; cv=none; b=KTPUftw+XLT/VV1i5zAp/U4KxUZ53LRh1pb54eaQzA7hGl7cJhSST6h9mopwTGr5WxI66XtTfjh1w1Q+o/5OTSjF4Q2uZVhwStBbWHWvHzDxlpqCH5oekm7+GKbTrtet8mB8OtnBf0/eQlY/2pYWSEfKZzvHRxhnXj8caNP8c2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751537403; c=relaxed/simple;
	bh=kok6jzBRwevUCqS4kCwDUHIAjw7vP2JKcMFYh4sPRjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRsjuNSJHTRLcMMtnAAFqgMXVaBaHju/N59y2vUV1b666uAcpGQqY7QgPd3CFbKbEkKrFk+4eM7BT/2U+E2RYdOlqY9L3ToUlCBg5v/ctIBvWzsJFpb3e/AqFws/A5Nf9W5Xo/y35eeOOxxSuij/efdtxd3+SBJYW7ZJGoAoBw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fz7+VBQb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fz7+VBQb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE610C4CEE3;
	Thu,  3 Jul 2025 10:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751537403;
	bh=kok6jzBRwevUCqS4kCwDUHIAjw7vP2JKcMFYh4sPRjw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fz7+VBQbxLmNt6B6dkSfpdsSFMboABdlxZqu6g3u1rWHF529wino0UyPdYvN40XE+
	 e7i+obrFu3YcAtSgo+bJbUnnel8GjdkZR5geIl1qxSk/99x+xiOrMFMehB5dE6a1YW
	 f9rrf6suvJOrsyqvElHlWKEoNhVDtgYlmdAmJzlLWuE0YaeizD359hbackdvrAVNII
	 AfbzjbddXutybu4OOiK/CiNxQxlawhzLucyYNt3Q5Nc/1aXUOUUYfxqMGVLVevcRuB
	 LhX/ygCL6r3ECuh/Pi6B08+y/N5viD4pkGd7jkpgt5tx95ri7oirKZnRDv46kySKbl
	 txSKy9NxZCXYA==
Message-ID: <7447c27e-2e68-4a34-b37f-c8f7faffca29@kernel.org>
Date: Thu, 3 Jul 2025 19:07:52 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ata: libata-core: Cache the general purpose log
 directory
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20250703071541.278243-1-dlemoal@kernel.org>
 <20250703071541.278243-2-dlemoal@kernel.org> <aGZSRX8K_0jUqZAj@ryzen>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <aGZSRX8K_0jUqZAj@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/25 6:49 PM, Niklas Cassel wrote:
>> +static int ata_read_log_directory(struct ata_device *dev)
>> +{
>> +	u16 version;
>> +
>> +	/* If the log page is already cached, do nothing. */
>> +	version = get_unaligned_le16(&dev->gp_log_dir[0]);
>> +	if (version == 0x0001)
>> +		return 0;
>> +
>> +	if (ata_read_log_page(dev, ATA_LOG_DIRECTORY, 0, dev->gp_log_dir, 1)) {
>> +		ata_clear_log_directory(dev);
> 
> Why do we need to clear the log here?
> 
> If we had something cached, we would have returned in the if-statement above
> already.
> 
> And if the read failed, wouldn't the buffer be unmodified?
> 
> Since we are only reading a single sector, which is the smallest unit we
> can read, I would expect the buffer to be unmodified on failure.
> 
> Is that an incorrect assumption?

I do not think it is needed either. It is a little bit of paranoia, e.g. in
case we lost the link in the middle of transfers and have a half-full buffer.

> 
> 
>> +		return -EIO;
>> +	}
>> +
>> +	version = get_unaligned_le16(&dev->gp_log_dir[0]);
>> +	if (version != 0x0001) {
>> +		ata_dev_err(dev, "Invalid log directory version 0x%04x\n",
>> +			    version);
>> +		return -EINVAL;
> 
> Don't you want to call ata_clear_log_directory() here?

Yep. Forgot to add it. And I think we should also set ATA_QUIRK_NO_LOG_DIR if
we ever get this error because it will be pointless to retry.

>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index 7462218312ad..78a4addc6659 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
>> @@ -761,6 +761,9 @@ struct ata_device {
>>  		u32		gscr[SATA_PMP_GSCR_DWORDS]; /* PMP GSCR block */
>>  	} ____cacheline_aligned;
>>  
>> +	/* General Purpose Log Directory log page */
>> +	u8			gp_log_dir[ATA_SECT_SIZE] ____cacheline_aligned;
> 
> Why align this to a cacheline?
> 
> It shouldn't be needed for get_unaligned_le16() to work correctly.
> 
> Is it just to increase the chance of this being in the cache?
> 
> If so, do we really access this that often that it needs to be
> cacheline aligned? (We mostly access it during probe time, no?)

It is used as the buffer for the read log command, so similar to the
sector_buf, I made it cacheline aligned. Better for DMA I guess.


-- 
Damien Le Moal
Western Digital Research
