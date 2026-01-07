Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC026368292
	for <linux-ide@vger.kernel.org>; Wed,  7 Jan 2026 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767799012; cv=none; b=Npi8ezFqRe+6xbDmpVMUoNXeC07Y7gUiyFOkqNCaZ5NZLQdiUNuTBi2jvs6iMoaXIFieLzYUXVSt9ShtzJjRqPZ5qRLXlsOelIsulBdBI0462EJDPvYFGkStTGPIa1IzDqrJDl5xGe4QzF2R9Mr+f5kJs0bye8SLDb2K/tri0YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767799012; c=relaxed/simple;
	bh=ZvSKYi7J+HgVOZKigHnH4pjHbLWJRNCdw63lRSjijPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hviANOFJjUBZq9vd+LqxXMHNFN9RvjE9o/GyhpVMIZbQRmtDCoiKLnXiPterY9a3Cf0jvSlXCi3mzm83xMgHnXgTfGxOghPmGiicf0Nq6Vfk8MZWOeSmd/7gMVve86Hfg1e/o/DGTlcL5jcEeLKq8ZYZAASPKfNNLNI7jWjoML0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOX//zYd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOX//zYd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B92DC4CEF7;
	Wed,  7 Jan 2026 15:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767799011;
	bh=ZvSKYi7J+HgVOZKigHnH4pjHbLWJRNCdw63lRSjijPk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MOX//zYd7NxhTLrmITyi5RoAYYGrQGMMcM/vJKqDtfeBam1Gollbr1WQToLHwhgKl
	 ayWa9gNeIM20U8iFmWbkqMZjtFu+NOEzc43znhYXf7NHlAiKDDXkQWGcaNMLTgcWuv
	 G8I8sZbvpdKm9Pjh08zWTVMiQsJkDyCpPbpjvJGJ0LCuoRLx9hyvJGCc4HzxXm5n+A
	 PFV95BtQ6HX7eyoYj/Gkz/p8WcTBH2DNrmStcw+HuyqXP2IhJXv/SLMRSC502sH2fC
	 AasB9YZQrDHPio0FBFgTemf6yiQKzS3AI0MP+ZuYOTGrwrKDzcQiRqsxm7JAtuNreP
	 zNNwpoAiOqcjQ==
Message-ID: <7e24ae2e-4483-46fb-accd-5c0e3a066e89@kernel.org>
Date: Wed, 7 Jan 2026 16:16:48 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] libata: SATA LPM forcibly disabled on Intel Raptor
 Lake since Linux 6.14.
To: Niklas Cassel <cassel@kernel.org>
Cc: wolf@yoxt.cc, linux-ide@vger.kernel.org
References: <605b34a7723436284699c9a8e524907b@yoxt.cc>
 <aV4yBZkxVD2Olg3X@ryzen> <85cae643-f3bc-43db-966c-3f57d8daa6b6@kernel.org>
 <aV5BjOXc1uK2HSZA@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aV5BjOXc1uK2HSZA@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/26 12:20, Niklas Cassel wrote:
> I think the problem is:
> 
> [    3.010059] ata8.00: ATA-11: ST16000NM000J-2TW103, SN06, max UDMA/133
> [    3.010079] ata7.00: ATA-11: ST16000NM000J-2TW103, SN06, max UDMA/133
> [    3.012748] ata6.00: ATAPI: PIONEER BD-RW  BDR-S12JX, 1.01, max UDMA/100
> [    3.012779] ata5.00: ATAPI: PIONEER BD-RW  BDR-S12JX, 1.01, max UDMA/100
> [    3.061873] ata8.00: Features: DIPM NCQ-sndrcv
> [    3.065319] ata7.00: Features: DIPM NCQ-sndrcv
> 
> The ST drives advertise support for DIPM, so these two ports should enter
> a lower power state.
> 
> 
> For the PIONEER optical drives however, we don't seem to get any "Features: "
> print at all. My guess is that the support neither HIPM nor DIPM, and thus
> stops the whole system from entering a lower power state.
> 
> 
> What I think happens:
> 
> For a device that does not support HIPM, we will clear flag ATA_LPM_HIPM from
> hints:
> https://github.com/torvalds/linux/blob/v6.19-rc4/drivers/ata/libata-eh.c#L2168-L2169
> 
> If flag ATA_LPM_HIPM is not set, we will disable HIPM (ALPE) for the port:
> https://github.com/torvalds/linux/blob/v6.19-rc4/drivers/ata/libahci.c#L835-L847
> 
> Thus the HBA will never tell the device to enter a low power state.
> (And if DIPM is not supported, the device itself will never enter a low
> power state.)
> 
> 
> Questions:
> -Why was this not a problem on older kernels?
> 
> If you are willing try some patches from us, we could give you a patch with more
> debug prints, to show for each device, when we {enable,disable} {HIPM,DIPM}.
> 
> 
> -Why don't we get the Features: print for ATAPI devices?
> 
> We probably need something like this:

Before doing this, one simple test to do would be to unplug the 2 ATAPI devices
(CD/DVD drives) and reboot to see if LPM works then.

> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index fc250b494ce3..a8af200ac24f 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3161,11 +3161,13 @@ int ata_dev_configure(struct ata_device *dev)
>                 /* print device info to dmesg */
>                 if (print_info)
>                         ata_dev_info(dev,
> -                                    "ATAPI: %s, %s, max %s%s%s%s\n",
> +                                    "ATAPI: %s, %s, max %s%s%s%s%s%s\n",
>                                      modelbuf, fwrevbuf,
>                                      ata_mode_string(xfer_mask),
>                                      cdb_intr_string, atapi_an_string,
> -                                    dma_dir_string);
> +                                    dma_dir_string,
> +                                    ata_id_has_hipm(dev->id) ? " HIPM" : "",
> +                                    ata_id_has_dipm(dev->id) ? " DIPM" : "");
>         }
>  
>         /* determine max_sectors */
> 
> 
> 
> Kind regards,
> Niklas


-- 
Damien Le Moal
Western Digital Research
