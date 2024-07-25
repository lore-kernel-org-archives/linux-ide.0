Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D243B7347D
	for <linux-ide@vger.kernel.org>; Thu, 25 Jul 2024 22:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721948160; cv=none; b=LOc8gBOBCKi+jo1RkBS/0C0/LnhOvuT5AgFr9AUBHat9Lbxyl8SDJrlRYOxiPZE6eyvFF2HboAXjqk9d4Aj8nPDxC+I4dKh3g2z67HIsDwgJuKI+z/am8I9sggCegCVr9us20TKJcrsV9E9/NkzRHQKG+qB9ba7TcOzdp5ZKwg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721948160; c=relaxed/simple;
	bh=hR8epoPJUmHmFjZJcdojJ8OritykpWUFdgrNW1pdl+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s++jtOojnJsq01fRwT0sw3muW2B5AYOWbkZnpEvOlx5sJfxGbKntXg+59O2oe5pDtHAzZg7C9SDIC1z/Q+XdxRHSGMLiHP2Addm6zmNIyrjR/mxoqZsJ1rnz6/dhZvZdzYFqhQd+dkh7tYUXCb+fyql/EuIU9BAw5aNYQY/iZvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqlEvNj7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqlEvNj7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21315C116B1;
	Thu, 25 Jul 2024 22:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721948160;
	bh=hR8epoPJUmHmFjZJcdojJ8OritykpWUFdgrNW1pdl+s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eqlEvNj7DLaBAlHx60zI07Ufqs+GKRrtAzvaGpkvJ7181nAu9lDXloSKDAgVg10oH
	 Sk+/ykqAEyq/e6eg5cPvnXkosKI/ezuAarZktR3pojWTkTt7Y3FLoPu+RjolFnvNms
	 DXqPr9yGouRiB+KoIdscHlAUD5GYN9vC2U3tMD0yhUvAZq94Rji6HDnapaerRBZ9WT
	 CFRWuF8N63fSaKqA9p5tBoym7eaA9e2gkujwDufeotW0LJRor8wymgJwhpAjyplg+y
	 6IWGrJKiMvFHDo0xpeA9zZMcw4Bp4iJdJj+X4XAiy5ZvNw/mxtYKdLkebLQgLWCM9m
	 JVNM+qkhFc7EQ==
Message-ID: <4c397fc3-5d6d-4eb2-afa3-5e445bad2320@kernel.org>
Date: Fri, 26 Jul 2024 07:55:59 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] ata: libata: Rename ata_dev_blacklisted()
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20240724054539.182655-1-dlemoal@kernel.org>
 <20240724054539.182655-3-dlemoal@kernel.org> <ZqKAqMqq11fO1exb@ryzen.lan>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZqKAqMqq11fO1exb@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/24 01:43, Niklas Cassel wrote:
> On Wed, Jul 24, 2024 at 02:45:37PM +0900, Damien Le Moal wrote:
>> Rename the function ata_dev_blacklisted() to ata_dev_horkage() as this
>> new name:
>> 1) Does not use an expression that can be considered as negatively loaded.
>> 2) The name does not reflect what the function actually does, which is
>>    returning a set of horkage flag for the device, of which only one
>>    flag will completely disable the device.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
>> ---
>>  drivers/ata/libata-core.c | 19 +++++++++----------
>>  1 file changed, 9 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index a35bce4236d3..272770f09609 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -84,7 +84,7 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
>>  					u16 heads, u16 sectors);
>>  static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
>>  static void ata_dev_xfermask(struct ata_device *dev);
>> -static unsigned long ata_dev_blacklisted(const struct ata_device *dev);
>> +static unsigned long ata_dev_horkage(const struct ata_device *dev);
>>  
>>  static DEFINE_IDA(ata_ida);
>>  
>> @@ -2223,7 +2223,7 @@ static inline u8 ata_dev_knobble(struct ata_device *dev)
>>  {
>>  	struct ata_port *ap = dev->link->ap;
>>  
>> -	if (ata_dev_blacklisted(dev) & ATA_HORKAGE_BRIDGE_OK)
>> +	if (ata_dev_horkage(dev) & ATA_HORKAGE_BRIDGE_OK)
>>  		return 0;
>>  
>>  	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
>> @@ -2830,7 +2830,7 @@ int ata_dev_configure(struct ata_device *dev)
>>  	}
>>  
>>  	/* set horkage */
>> -	dev->horkage |= ata_dev_blacklisted(dev);
>> +	dev->horkage |= ata_dev_horkage(dev);
>>  	ata_force_horkage(dev);
>>  
>>  	if (dev->horkage & ATA_HORKAGE_DISABLE) {
>> @@ -3987,13 +3987,13 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
>>  	return rc;
>>  }
>>  
>> -struct ata_blacklist_entry {
>> +struct ata_dev_horkage_entry {
>>  	const char *model_num;
>>  	const char *model_rev;
>>  	unsigned long horkage;
>>  };
>>  
>> -static const struct ata_blacklist_entry ata_device_blacklist [] = {
>> +static const struct ata_dev_horkage_entry ata_dev_horkages[] = {
>>  	/* Devices with DMA related problems under Linux */
>>  	{ "WDC AC11000H",	NULL,		ATA_HORKAGE_NODMA },
>>  	{ "WDC AC22100H",	NULL,		ATA_HORKAGE_NODMA },
>> @@ -4111,7 +4111,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>>  
>>  	/* Devices which get the IVB wrong */
>>  	{ "QUANTUM FIREBALLlct10 05", "A03.0900", ATA_HORKAGE_IVB },
>> -	/* Maybe we should just blacklist TSSTcorp... */
>> +	/* Maybe we should just add all TSSTcorp devices... */
>>  	{ "TSSTcorp CDDVDW SH-S202[HJN]", "SB0[01]",  ATA_HORKAGE_IVB },
>>  
>>  	/* Devices that do not need bridging limits applied */
>> @@ -4266,11 +4266,11 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>>  	{ }
>>  };
>>  
>> -static unsigned long ata_dev_blacklisted(const struct ata_device *dev)
>> +static unsigned long ata_dev_horkage(const struct ata_device *dev)
> 
> So it turns that the term "horkage" is only used by libata:
> $ git grep -i horkage
> 
> See also:
> https://unix.stackexchange.com/questions/752755/what-is-horkage
> 
> I have mixed emotions about this. In one way I want to preserve the legacy,
> but in one way, the term quirk/quirks is used everywhere else in the kernel,
> so it is way more intuitive for other kernel developers to understand what
> this is if we just use the common terminology.
> 
> I do think that the name ata_dev_horkage() is not good because it sounds
> like you can just have a single horkage, but in fact a devices can have
> serveral quirks. So should the name be ata_dev_horkages() ?
> 
> Search the kernel tree gives zero results for this before your patch:
> $ git grep -i horkages origin/master  | wc -l
> 0
> 
> So maybe the plural of horkage is horkage???
> 
> To me, this again suggests that quirk/quirks is way clearer.
> (And we do also use the term quirk in libata:
> $ git grep -i quirk drivers/ata
> so in one way renaming would also make us more consistent...)
> 
> I do see that you have used "horkages" in this patch however.
> 
> So either migrate to quirk/quirks, or we continue to make up our own words.
> 
> I prefer the former.
> dev->quirks |= ata_dev_quirks(dev);
> 
> 
> If we choose the latter, may I suggest that we change this line:
> dev->horkage |= ata_dev_horkage(dev);
> to:
> dev->horkages |= ata_dev_horkages(dev);
> 
> to make it clearer that we can have several *whatever the plural of horkage*.
> 
> see e.g. how nvme does it:
> ctrl->quirks = quirks;
> and
> if (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)

Yep, when writing these patches, I thought about doing such renaming but end
choosing the lazy path :)

I completely agree about it, so will add patches to do that.

-- 
Damien Le Moal
Western Digital Research

