Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D917E129E93
	for <linux-ide@vger.kernel.org>; Mon, 26 Aug 2024 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710046; cv=none; b=PzkNKAmFjJkzrRaiXLHfkDZwFFlVv/Cfm8qtljuVZ+HGDsT+NhVYOxV9P6GH962G2rajNf0vGDuxJsvKY1NtyjniDv4B2I97298tz1k6OBFdWgjlFd8p+INgUEr/M/IQSrSagJem9vxcycOKCED0AfkLkIt4ibSEutB0mrB76bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710046; c=relaxed/simple;
	bh=WtJhbqjDA3aKIIj4jqNtzwxAzDyc95yUlBeqcEbD2fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3NU4QfaOC+st8CAKT8CwOcbxnBJJLHMRvKCE0JXWClxHCg58j+izmexp7QOlSMQyddydvDRhgJhZ24QfKvrZkZMSFqtEA8HXfTuVKpg9uPEsYXhs61xHcYNjvrnBwAPnXbFot6k9j5UFGvFMAwCTAXEphA6j+HfML//77IJbAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8TIr7BO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8TIr7BO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28613C8B7AB;
	Mon, 26 Aug 2024 22:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724710045;
	bh=WtJhbqjDA3aKIIj4jqNtzwxAzDyc95yUlBeqcEbD2fk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p8TIr7BOd7/RVbLfmuEN9FL2dI2JmBV6vMsxc+kiCGamQkyHq5SzqCyrY3agQaXpm
	 K1yCdeIYMNRw5TwPILEiB/q6gxwCJYZ3zN4/YzWpBZUKXMhbySmWodpk8A2+pCZUVM
	 dinbCfblsCQvh8cVcPJG8If0rWLSDrkpvwCMjWXpKugYTDZp9TF+kchiHK6bw/Bbis
	 St7iqhcp2/k1SJwaKnHkGSG8u4BAn36xlZaKR3H7yuEMgnxrGOBCBOi9Qb1Be6ZYCE
	 dnipjIKx6VAD8sb7muTW3N2WV0gGKA4H2SjnTT5pXHMmzIbugvwPxBnoK33/C52zaJ
	 tXdvckzJhLWXw==
Message-ID: <289b6005-3cbb-4b52-8845-edaefb728404@kernel.org>
Date: Tue, 27 Aug 2024 07:07:24 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] ata: libata: Improve CDL resource management
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20240826073106.56918-1-dlemoal@kernel.org>
 <20240826073106.56918-8-dlemoal@kernel.org> <ZsyhMdG_Z1o5EbFv@ryzen.lan>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZsyhMdG_Z1o5EbFv@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/24 00:37, Niklas Cassel wrote:
> On Mon, Aug 26, 2024 at 04:31:06PM +0900, Damien Le Moal wrote:
>> The command duration limits (CDL) log buffer of struct ata_device is
>> needed only if a device actually supports CDL. The same applies to the
>> ncq_sense_log buffer.
>>
>> Group these 2 buffers into a new structure ata_cdl defining both buffers
>> as embedded buffers (no allocation needed) and allocate this structure
>> from ata_dev_config_cdl() only for devices that support CDL.
>>
>> The functions ata_dev_init_cdl_resources() and
>> ata_dev_cleanup_cdl_resources() are defined to manage this new structure
>> allocation, initialization and cleanup when a device is removed.
>> ata_dev_cleanup_cdl_resources() is called from ata_tdev_free().
>>
>> Note that the cdl log buffer name is changed to desc_log_buf to make it
>> clearer what it is.
>>
>> This change reduces the size of struct ata_device and reduces memory
>> usage for ATA devices that do not support CDL.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> 
> Like previous comment, as long as sector_buf belongs to struct ata_port,
> it seems a bit weird to keep this in struct ata_device.
> 
> Perhaps we can move sector_buf to struct ata_device?
> (and modify the ata_read_log() functions to not take a buffer,
> as the buffer would not be in the struct ata_device, which we already
> supply to the ata_read_log() functions as the first argument.)
> 
> 
> If we do that, then I think it is okay to keep a struct ata_cdl
> in struct ata_device. Although I still don't like cleaning this
> up in ata_tdev_() functions.

OK. Let me rework this.

-- 
Damien Le Moal
Western Digital Research

