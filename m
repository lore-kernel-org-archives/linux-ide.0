Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C6414AD0D
	for <linux-ide@vger.kernel.org>; Fri, 20 Mar 2026 03:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773976105; cv=none; b=bV0t51n6yXQ2iJ39WaxcE7fimh3xeB4a9jWFByrkw8f2tH+vSy/U/d+wMOhdOd02TFgrb/pE5cTvcs2jZEPjwx0+hT4vIGfjrsG3bqdeScSE/Cx+fx/vXJ6amj2PUokKuCASChfnk13AEKegJ3HOn58X8B/LXG9/k9NdRx2OLF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773976105; c=relaxed/simple;
	bh=Kq/H/H02OdjlJU0WyKaYyRO3eOySl/0ubV4d1b5k1D4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGQgvW66ji7buglwNiuHBXl03URhegY6Fieu7BSzAD/rEmnmf+CjGDg8hsjL8UFE+hWTs2FKzagxGrgLZ9iR96tZ27vpbta3wsUG3HJl3T9lHP4veVpyVPRvTBDrlBzs9eULEjkMhzVyrRG+459hIK9k6XOFAvafr4csPFEGv/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOS60zGs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOS60zGs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DBFC19424;
	Fri, 20 Mar 2026 03:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773976105;
	bh=Kq/H/H02OdjlJU0WyKaYyRO3eOySl/0ubV4d1b5k1D4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kOS60zGsGchTQFNieGjKJw/k1S/IJapDRr07v3gKNXHtrKn/ezAdhVJoOxutCN1W0
	 Q2bB9tl2Y4+ObM8AxgncVxyq4suFiIuf81PPBOVbnixBlRVkTMgYkbjAeigwRSs4yC
	 sDMFYx4p8ma7lgoFu9E0ipvl9pQetrOrAWbMhkn5zkP8CjJQ2qP+phl1bp+AHrlYKy
	 jL/nSyRWsXGtvx9DV8/Sjzho2z9f+L/uZpGZQ/sFyxGKILcf5TL4FdZl4LHn2+FRw8
	 187uVh9GdmJ4BAHZjEYF+08cAsY2RDC65K9h37LQJVe07T5xhgFhfJXJzjd3ae4xaR
	 5H/jd5oFXGrpg==
Message-ID: <ae9f75cc-23c2-45bc-aaa3-0746ed70e37e@kernel.org>
Date: Fri, 20 Mar 2026 12:08:22 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] ata: libata-scsi: Refactor ata_scsiop_maint_in()
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
References: <20241022024537.251905-1-dlemoal@kernel.org>
 <20241022024537.251905-4-dlemoal@kernel.org>
 <0676888d-e683-4696-8289-ee8bf43beeb0@roeck-us.net>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <0676888d-e683-4696-8289-ee8bf43beeb0@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/26 11:13, Guenter Roeck wrote:
> Hi,
> 
> On Tue, Oct 22, 2024 at 11:45:34AM +0900, Damien Le Moal wrote:
>> Move the check for MI_REPORT_SUPPORTED_OPERATION_CODES from
>> ata_scsi_simulate() into ata_scsiop_maint_in() to simplify
>> ata_scsi_simulate() code.
>>
>> Furthermore, since an rbuff fill actor function returning a non-zero
>> value causes no data to be returned for the command, directly return
>> an error (return 1) for invalid command formt after setting the invalid
>> field in cdb error.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>  drivers/ata/libata-scsi.c | 20 +++++++++++---------
>>  1 file changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index 8097cf318b04..f9c70f650cfc 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -3388,12 +3388,16 @@ static unsigned int ata_scsiop_maint_in(struct ata_scsi_args *args, u8 *rbuf)
>>  	struct ata_device *dev = args->dev;
>>  	u8 *cdb = args->cmd->cmnd;
>>  	u8 supported = 0, cdlp = 0, rwcdlp = 0;
>> -	unsigned int err = 0;
>> +
>> +	if ((cdb[1] & 0x1f) != MI_REPORT_SUPPORTED_OPERATION_CODES) {
>> +		ata_scsi_set_invalid_field(dev, args->cmd, 1, 0xff);
>> +		return 1;
>> +	}
>>  
>>  	if (cdb[2] != 1 && cdb[2] != 3) {
>>  		ata_dev_warn(dev, "invalid command format %d\n", cdb[2]);
>> -		err = 2;
>> -		goto out;
>> +		ata_scsi_set_invalid_field(dev, args->cmd, 1, 0xff);
> 
> Nit, but should this possibly be
> 		ata_scsi_set_invalid_field(dev, args->cmd, 2, 0xff);
> 							   ^
> ?

Absolutely ! Good catch !
I will send a patch immediately.


-- 
Damien Le Moal
Western Digital Research
