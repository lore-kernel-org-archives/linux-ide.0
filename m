Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BC42E62D1;
	Fri,  4 Apr 2025 03:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743739002; cv=none; b=UjX2AFd/2tbdaQVi5us6CyJGumTSpRJJNmCJQbDuND1fsCetOqw8bbb/hXU6lCjkpWuXaMRx79k6XBaeYLCydvU7Nzve16jCJguDxcR4GmxKQrnWYMZVZVHfJZztK5zGn0J+5HM6gi0XMUjQ9hTLoIzqmDLXgnB4xpONR8X9XLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743739002; c=relaxed/simple;
	bh=5rMiYbAprqqTwWXdtrkSon4Lc0AkCYf8j1nWdf5MXi4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PFGYFAA19Jb76VxWyp8rwSTPc12k7zcEgWtPdI8yWy0Xx4LWnyMNf0I+hHGFVZrbD13DojMHkGbQelvAWQEXswscwZq0U8H90PUak1DnwXGgDnaE5PrKnmnBFHPQATyPIH06pw3eRtNTBL1jqdWVtiRwnimPu4Zg6WmK4QbPBak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tf987Nxf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tf987Nxf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238A4C4CEDD;
	Fri,  4 Apr 2025 03:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743739001;
	bh=5rMiYbAprqqTwWXdtrkSon4Lc0AkCYf8j1nWdf5MXi4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Tf987NxfSzIqIkWIXvmdoOSPJ98tnrzmaJBmuEKJnAEgJQjrxfr9bYhTAnJ+qg/g/
	 m/rdu0DIslj49O2yczTiLFrraVhGmOaJ/KhxmT9ChbOFJLAZbFftB/6soZXX6A2isl
	 d5V0DBVnmDJK1Gu6dDFsTPFcCR+uEFbBqI28aJmxzcW3BO4pjGwnf6SAqV7rT0JTn8
	 9HnumzQYAfrC9zpoN9gAW0ltVOZZTUc/STI/QM4zSgQEtSGNHpa2HufHHQ3CSMXeO4
	 /NNaQDs2SCCPM6xwocw/ly7yfh7G0gtNkUK5ENuEeI/XsYg6AXorzfPD20ul2Fb/SZ
	 gkkqvhhyn7z1w==
Message-ID: <1969f3a1-3088-49e1-a9d6-b074ff25605f@kernel.org>
Date: Fri, 4 Apr 2025 12:55:57 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libata: Add error handling for pdc20621_i2c_read().
From: Damien Le Moal <dlemoal@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250403103957.2550-1-vulab@iscas.ac.cn>
 <6eef4b75-2a2c-42f2-a35e-558260143dba@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <6eef4b75-2a2c-42f2-a35e-558260143dba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/25 12:54 PM, Damien Le Moal wrote:
> On 4/3/25 7:39 PM, Wentao Liang wrote:

Also forgot to mention that the patch title should be:

ata: sata_sx4: Add error handling for pdc20621_i2c_read()

And no period at the end of it please.

>> The pdc20621_prog_dimm0() calls the pdc20621_i2c_read(), but does not
> 
> The function pdc20621_prog_dimm0() calls the function pdc20621_i2c_read() but
> does...
> 
> 
>> handle the error if the read fails. This could lead to process with
>> invalid data. A proper inplementation can be found in
> 
> s/inplementation/implementation
> 
>> pdc20621_prog_dimm_global(). As mentioned in its commit:
>> bb44e154e25125bef31fa956785e90fccd24610b, the variable spd0 might be
>> used uninitialized when pdc20621_i2c_read() fails.
>>
>> Add error handling to the pdc20621_i2c_read(). If a read operation fails,
>> an error message is logged via dev_err(), and return an under-zero value
>> to represent error situlation.
> 
> and return a negative error code.
> 
>>
>> Add error handling to pdc20621_prog_dimm0() in pdc20621_dimm_init(), and
>> return a none-zero value when pdc20621_prog_dimm0() fails.
> 
> return a negative error code if pdc20621_prog_dimm0() fails.
> 
>>
>> Fixes: 4447d3515616 ("libata: convert the remaining SATA drivers to new init model")
>> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
>> ---
>>  drivers/ata/sata_sx4.c | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
>> index a482741eb181..a4027eb2fb66 100644
>> --- a/drivers/ata/sata_sx4.c
>> +++ b/drivers/ata/sata_sx4.c
>> @@ -1117,9 +1117,14 @@ static int pdc20621_prog_dimm0(struct ata_host *host)
>>  	mmio += PDC_CHIP0_OFS;
>>  
>>  	for (i = 0; i < ARRAY_SIZE(pdc_i2c_read_data); i++)
>> -		pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
>> -				  pdc_i2c_read_data[i].reg,
>> -				  &spd0[pdc_i2c_read_data[i].ofs]);
>> +		if (!pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
>> +				       pdc_i2c_read_data[i].reg,
>> +				       &spd0[pdc_i2c_read_data[i].ofs])){
>> +			dev_err(host->dev,
>> +				"Failed in i2c read at index %d: device=%#x, reg=%#x\n",
>> +				i, PDC_DIMM0_SPD_DEV_ADDRESS, pdc_i2c_read_data[i].reg);
>> +			return -1;
> 
> 			return -EIO;
>> +		}
>>  
>>  	data |= (spd0[4] - 8) | ((spd0[21] != 0) << 3) | ((spd0[3]-11) << 4);
>>  	data |= ((spd0[17] / 4) << 6) | ((spd0[5] / 2) << 7) |
>> @@ -1284,6 +1289,8 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
>>  
>>  	/* Programming DIMM0 Module Control Register (index_CID0:80h) */
>>  	size = pdc20621_prog_dimm0(host);
>> +	if (size < 0)
>> +		return 1;
> 
> 		return size;
> 
>>  	dev_dbg(host->dev, "Local DIMM Size = %dMB\n", size);
>>  
>>  	/* Programming DIMM Module Global Control Register (index_CID0:88h) */
> 
> 


-- 
Damien Le Moal
Western Digital Research
