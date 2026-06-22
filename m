Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3EB53E0B;
	Mon, 22 Jun 2026 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782128223; cv=none; b=PwprhDnRzNBT8Hu8e89gywjhYlPBasVKSbzepDFBuEWy+eXNgIHb8ojV0iJRgLns6O2eWGgYjE/GPf7tLuPsS7yE/GvzBlVCW41DzXeM061wxp2zidQMPbjpvJuWmQPZa4dEudCZN7dD4Czh1mW2WWFuNx2wPdEYHHdXP2HNkEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782128223; c=relaxed/simple;
	bh=bpbpweSVSYm78988m2JEidooGtwJRBQmcFh78BSS6GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OmK6MciHu9JbNYWnjdVgrnk9Ip5Le2gBjx9WFpN0tOOLU6dLHn68w4bSu6Awjyqq6tX/yJLBivIBYa80FTH2F5sJXpslC2mXi9cx1VDG5ebOzNzMMbubGD4O5qDohPBK81A6rPjAW8rnCpCmgPufupmI1Vkm9diHSzNmMBZzBEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vqe1YNp3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vqe1YNp3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EADC1F000E9;
	Mon, 22 Jun 2026 11:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782128221;
	bh=Gy2Mm9F7KbVweFgVUcxdZdtjtgqrhfSTSZ2mOyx51g8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Vqe1YNp3ujal6PA7mgBNf2rXOtMkMhCmS8HoRKTyXbYlPYRb5+9lH98P5TsSTXc7U
	 Jc5zQx1tg7ugLfUwx01Cg3Mms8Tivct/BG3+54iOLW90/1nHLS4aM7ReemQNk3aj17
	 jnClVv0JECzy3F/9m6zVS+RXYTXEfJVfX/NVU1D2HpSfLRjpG3PDxrIkreSGJIhbKu
	 Xa5majluir1zunZJNk9ZtOXDxKUAG+pTWghwYkBwiHUs7aiS0gJhnW7fogqYctabep
	 RN5S44Ni1tEfSp5QgU1KtzdS9NrbsoenhYQ06uNSugte4oMGAXE9H+2MXYPXTKO/mO
	 x5UtS6Sen1a4w==
Message-ID: <3c3c4501-b91f-4066-9865-db734e1e77cd@kernel.org>
Date: Mon, 22 Jun 2026 20:36:59 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ata: libata-core: Clamp the concurrent positioning
 ranges count
To: hexlabsecurity@proton.me, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260619-b4-disp-6200c44e-v1-0-4624a4707d9e@proton.me>
 <20260619-b4-disp-6200c44e-v1-1-4624a4707d9e@proton.me>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260619-b4-disp-6200c44e-v1-1-4624a4707d9e@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/26 11:36, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> ata_dev_config_cpr() sizes the log buffer from the length reported in
> the GPL directory but takes the number of range descriptors from buf[0],
> which the device reports independently. A device advertising a small log
> but a large count makes the descriptor loop read past the buffer: a
> one-sector log with buf[0] = 255 reaches up to 7704 bytes beyond the
> 512-byte allocation, a slab out-of-bounds read whose contents are then
> handed to the initiator through INQUIRY VPD page B9h.
> 
> Clamp the descriptor count to what the allocated buffer holds, as
> sd_read_cpr() already does on the SCSI side.
> 
> Fixes: c745dfc541e7 ("libata: fix reading concurrent positioning ranges log")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
>  drivers/ata/libata-core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 3d0027ec33c2..e8d708f0810e 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2832,6 +2832,17 @@ static void ata_dev_config_cpr(struct ata_device *dev)
>  	if (!nr_cpr)
>  		goto out;
>  
> +	/*
> +	 * The log size is reported in the GPL directory independently of the
> +	 * number of range descriptors in buf[0]. Clamp the count to what the
> +	 * allocated buffer holds so the loop below cannot read past it.
> +	 */
> +	if (buf_len < 64 + (size_t)nr_cpr * 32) {
> +		nr_cpr = buf_len > 64 ? (buf_len - 64) / 32 : 0;
> +		if (!nr_cpr)
> +			goto out;
> +	}

If the device gives an invalid number of ranges, we should not try to fix the
broken value and warn and ignore it entirely. So let's simplify this:

	if (buf_len < 64 + (size_t)nr_cpr * 32) {
		ata_dev_warn(dev,
			"Invalid number of concurrent positioning ranges\n");
		goto out;
	}


-- 
Damien Le Moal
Western Digital Research
