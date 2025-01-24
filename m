Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3231EEA48
	for <linux-ide@vger.kernel.org>; Fri, 24 Jan 2025 23:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737760360; cv=none; b=XJtuYqR0cG4u575sZyBa3ZlTApdWcdbnnlbK9NoA1DH4c4lX7tdsDJCRzJ0PAnyAU9RMtKFnKp/wTyXBblTEhz8xKh6Zk2pIvH+N4kkOe5umxfqE0MTTdAfDdmOGUQu6/EE4MA+Tay66ePd3AUvUXV2xsV9of6YWde1ZH7yaFgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737760360; c=relaxed/simple;
	bh=bhyzA5kmdeHBmDApfvYeoTJoA3zFyL7aqH0wr604cgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UghZOSrAy1aiI+s9WL5uTVtbQYITA8Zo3CCAEZvpSOYsEhAJavWfkKFGQWMBKoYmBtM2je1z0qGMYkf3Wv251SpZ2QTUhaDppo2kNW05iajexkHd5IkMll90zD4ZDHuDwrL15XazWS+FLmz+zNoJ7kNXg5/dg8H7KfInseyUAJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxglAF9s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxglAF9s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3C9C4CED2;
	Fri, 24 Jan 2025 23:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737760360;
	bh=bhyzA5kmdeHBmDApfvYeoTJoA3zFyL7aqH0wr604cgw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WxglAF9saVagywwzvH9t/ASxPbgCEIiWgNpbfW/hY/KcMOM6OHtdkK81Udpr3JKq0
	 SZ+avbho602Paa81v59UiCQRSpQvD9K/DY/aaaRgKrQbfLUTeG0e285T4QhfJEMZwO
	 Jp6Rf+A/haZRzKqmxXbBv6DvYaEA+caKdUr/h+kB8LApv6koTZcY3Z6tGuJ+aVqYHl
	 sDzEcP1oZYGuyeulmOjDccDYaDSDAR8PJSYp/cKF6SC2906GEEJMaiW2AxK0+GvOdd
	 5votRCtYhLQbE4vbKw/xwbbJ/SpdgxrEBYuQWAwHUGYiCNPgruGc6BIrdYT6kOcok8
	 BVcy6l9A6kzLA==
Message-ID: <4dee6487-4b9a-408c-aa7c-834802781887@kernel.org>
Date: Sat, 25 Jan 2025 08:12:38 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-sff: Ensure that we cannot write outside the
 allocated buffer
To: Niklas Cassel <cassel@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 reveliofuzzing <reveliofuzzing@gmail.com>, linux-ide@vger.kernel.org
References: <20250124141118.3722754-2-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250124141118.3722754-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/25 23:11, Niklas Cassel wrote:
> reveliofuzzing reported that a SCSI_IOCTL_SEND_COMMAND ioctl with out_len
> set to 0xd42, SCSI command set to ATA_16 PASS-THROUGH, ATA command set to
> ATA_NOP, and protocol set to ATA_PROT_PIO, can cause ata_pio_sector() to
> write outside the allocated buffer, overwriting random memory.
> 
> While a ATA device is supposed to abort a ATA_NOP command, there does seem
> to be a bug either in libata-sff or QEMU, where either this status is not
> set, or the status is cleared before read by ata_sff_hsm_move().
> Anyway, that is most likely a separate bug.
> 
> Looking at __atapi_pio_bytes(), it already has a safety check to ensure
> that __atapi_pio_bytes() cannot write outside the allocated buffer.
> 
> Add a similar check to ata_pio_sector(), such that also ata_pio_sector()
> cannot write outside the allocated buffer.
> 
> Reported-by: reveliofuzzing <reveliofuzzing@gmail.com>
> Closes: https://lore.kernel.org/linux-ide/CA+-ZZ_jTgxh3bS7m+KX07_EWckSnW3N2adX3KV63y4g7M4CZ2A@mail.gmail.com/
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good to me. But doesn't this need Fixes + Cc-stable tags ?

> ---
>  drivers/ata/libata-sff.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 67f277e1c3bf..5a46c066abc3 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -601,7 +601,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
>  {
>  	struct ata_port *ap = qc->ap;
>  	struct page *page;
> -	unsigned int offset;
> +	unsigned int offset, count;
>  
>  	if (!qc->cursg) {
>  		qc->curbytes = qc->nbytes;
> @@ -617,25 +617,27 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
>  	page = nth_page(page, (offset >> PAGE_SHIFT));
>  	offset %= PAGE_SIZE;
>  
> -	trace_ata_sff_pio_transfer_data(qc, offset, qc->sect_size);
> +	/* don't overrun current sg */
> +	count = min(qc->cursg->length - qc->cursg_ofs, qc->sect_size);
> +
> +	trace_ata_sff_pio_transfer_data(qc, offset, count);
>  
>  	/*
>  	 * Split the transfer when it splits a page boundary.  Note that the
>  	 * split still has to be dword aligned like all ATA data transfers.
>  	 */
>  	WARN_ON_ONCE(offset % 4);
> -	if (offset + qc->sect_size > PAGE_SIZE) {
> +	if (offset + count > PAGE_SIZE) {
>  		unsigned int split_len = PAGE_SIZE - offset;
>  
>  		ata_pio_xfer(qc, page, offset, split_len);
> -		ata_pio_xfer(qc, nth_page(page, 1), 0,
> -			     qc->sect_size - split_len);
> +		ata_pio_xfer(qc, nth_page(page, 1), 0, count - split_len);
>  	} else {
> -		ata_pio_xfer(qc, page, offset, qc->sect_size);
> +		ata_pio_xfer(qc, page, offset, count);
>  	}
>  
> -	qc->curbytes += qc->sect_size;
> -	qc->cursg_ofs += qc->sect_size;
> +	qc->curbytes += count;
> +	qc->cursg_ofs += count;
>  
>  	if (qc->cursg_ofs == qc->cursg->length) {
>  		qc->cursg = sg_next(qc->cursg);


-- 
Damien Le Moal
Western Digital Research
