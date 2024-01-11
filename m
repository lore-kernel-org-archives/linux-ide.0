Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BAD59142
	for <linux-ide@vger.kernel.org>; Thu, 11 Jan 2024 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxBbl67H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956C9C433F1;
	Thu, 11 Jan 2024 23:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705014826;
	bh=BwMYYm5+v/ek3PMnRjy/OjV5DGUxSAQj9QInneQa5yo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RxBbl67HNZvvQ/DT3+MiF07gjuxpAujImXxD/v5j8TIcruIK7yzK22I7ukN4IFhlO
	 Zb0HETie/GpEC/8DW82NW4RDy+UZNA07EijiYN5Yqorx5Pz1H9ft5LMlYde2cpzVv1
	 +MtUP4h5FLSYeWBPr34BdcdS2T+INfn0jjpxHVv46/CeXlP3TPaaZL+RSJWLlK741G
	 6ILGko7Rywpwjcc0HOmJrhkWakcMVAQyz3eF5eLFSNvVMVz+mIwpE8j2Z6EDAun+l1
	 1XAzAiXuW33ze0/n0s2nCxuuu7GMKAqnf4c0RUKg/03YSWcPBup9aTLgXoHTE2qf/+
	 AQUijcssSf9Zw==
Message-ID: <0563322c-4093-4e7d-bb48-61712238494e@kernel.org>
Date: Fri, 12 Jan 2024 08:13:45 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ata: libata-core: Revert "ata: libata-core: Fix
 ata_pci_shutdown_one()"
Content-Language: en-US
To: Sergei Shtylyov <sergei.shtylyov@gmail.com>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
Cc: Dieter Mummenschanz <dmummenschanz@web.de>,
 Wang Zhihao <wangzhihao9@hotmail.com>
References: <20240111115123.1258422-1-dlemoal@kernel.org>
 <20240111115123.1258422-3-dlemoal@kernel.org>
 <d63a7b93-d1a3-726e-355c-b4a4608626f4@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <d63a7b93-d1a3-726e-355c-b4a4608626f4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/24 03:10, Sergei Shtylyov wrote:
> On 1/11/24 2:51 PM, Damien Le Moal wrote:
> 
>> This reverts commit fd3a6837d8e18cb7be80dcca1283276290336a7a.
>>
>> Several users have signaled issues with commit fd3a6837d8e1 ("ata:
>> libata-core: Fix ata_pci_shutdown_one()") which causes failure of the
>> system SoC to go to a low power state. The reason for this problem
>> is not well understood but given that this patch is harmless with the
>> improvements to ata_dev_power_set_standby(), restore it to allow system
>> lower power state transitions.
>>
>> For regular system shutdown, ata_dev_power_set_standby() will be
>> executed twice: once the scsi device is removed and another when
>> ata_pci_shutdown_one() executes and EH completes unloading the devices.
>> Make the second call to ata_dev_power_set_standby() do nothing by using
>> ata_dev_power_is_active() and return if the device is already in
>> standby.
>>
>> Fixes: fd3a6837d8e1 ("ata: libata-core: Fix ata_pci_shutdown_one()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>  drivers/ata/libata-core.c | 75 +++++++++++++++++++++++----------------
>>  1 file changed, 45 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index d9f80f4f70f5..20a366942626 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -2001,6 +2001,33 @@ bool ata_dev_power_init_tf(struct ata_device *dev, struct ata_taskfile *tf,
>>  	return true;
>>  }
>>  
>> +static bool ata_dev_power_is_active(struct ata_device *dev)
>> +{
>> +	struct ata_taskfile tf;
>> +	unsigned int err_mask;
>> +
>> +	ata_tf_init(dev, &tf);
>> +	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
> 
>    Why set ATA_TFLAG_ISADDR, BTW? This command doesn't use any taskfile
> regs but the device/head reg. Material for a fix, I guess... :-)

Good point. I will look into it. This code was moved from libata-scsi
translation, so it has been like this for a very long time...

> 
>> +	tf.protocol = ATA_PROT_NODATA;
>> +	tf.command = ATA_CMD_CHK_POWER;
>> +
> [...]
> 
> MBR, Sergey

-- 
Damien Le Moal
Western Digital Research

