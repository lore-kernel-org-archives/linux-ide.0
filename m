Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18BA2F261C
	for <linux-ide@vger.kernel.org>; Fri, 20 Mar 2026 02:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773972805; cv=none; b=aL31wDxUYuSTInxXaRGLtpu3UjFpavGTqpqi9U9mUT5cOQxbwbK6BCQ2UO/tcjSVkijhkSaUAQ1DwZ9ZjUvydysR6R1p72LJ95HpeIxmL0C3sAGp5WIt6Ax5gBVtZdI0OEfKSuBOrz++uBql5iCltmYkvrD58D07+7MxSztCwg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773972805; c=relaxed/simple;
	bh=0PcA3aE/1meNQLkz/e1gLwMKc0OagQXWNnKGwo4atA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJDdsMySquw6xpIrzVskF3rP4XfZ3CzdhKTQ8NCtpcl+LzbaRW5hqFOs7uv3NV06ZSe4B34kMW72lExArSO/7vLIyd0aqAPRIucS3t8snuGpwNUoa1vCspSovbb/rIt/6/BiXrE8Udqq5ddpQsUNGSDp3nGxctBveINN6rJx+64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3/tZ1Ul; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3/tZ1Ul"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c0fa90d47bso584039eec.0
        for <linux-ide@vger.kernel.org>; Thu, 19 Mar 2026 19:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773972802; x=1774577602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPZQH0Hyy5nc4kHUPsfCF/IaqEqcY4HuvY5FeRNLL4k=;
        b=F3/tZ1UlSVGpe7I258nicLor2VzmuqOg8z2cD8oR5bos6zACK6xn9YQl3Fp4WNBM5g
         YtKVhO+9saMtcdMLBSpidfR3irR36VhNEVDldP5l783ZiGGs5+w3zndbRSl/w/rt3GcJ
         coQg8kaIwhshsp4abj5wn1NdxgVOiu8fnJhyQHDn3EwRJ4A5DqLO6QK3BE2jOKFa9yFX
         SYFmC5yjWIN1JwmSEJ/VvjjmVEs+o+ZjNe86PctkqSmyglVps/CK4pfEXBjl00N83UMY
         yzPcuYP45Lej/H50L76IWTttsZ2biv/EUkCBEVWdfKH3GazW6LbQ5T+GoOpnNB2M8T6f
         zdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773972802; x=1774577602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DPZQH0Hyy5nc4kHUPsfCF/IaqEqcY4HuvY5FeRNLL4k=;
        b=e0fignQtAtOfUbPB0K2eSq6d7Aszelx3SIxkMFwNviVXhQgqwMwhA9VBICsXCyN/YW
         KqumOLJNwcLB/kWA75u8YaeklY9gOeixEuEkFNyk43VTGZOUAtwDzPkUHHVMW7u1m20G
         y1QIKL3c+lXeSthugqOHKw83luThVYC3p9X4abmftHB5UlH3Gm0rfAEEBXWqsiTBJW2D
         4tQaUpHulyhuyMDv4FWpWPCOvvFoTEHSl4n5As+iCVFL8GHWWdEsRJlTSLMSj7S8B4UJ
         FzPt/NtvhTugdAYEtVD6SCzZBCDI4sQY7f4BIq8bWR/3PerRp4iSvOkYxUw57ke1LirL
         Zvrw==
X-Gm-Message-State: AOJu0Yxffy0Rr9gJe8SL5n/XF3OFVwzMSDvH93pIaoBFFaDRt46wcUna
	a/QCYmtbjIiaUonthailwIkQaYyhHYOpGkfZZvOcf82lK0/L/xtigDDW
X-Gm-Gg: ATEYQzyWgrJir7vK3otjPfX8QQBciAGX8c4wON3MDTigantbjRR8o/2r325K3Xtryv9
	uG9bSmqmu3iWbPIRMzx6To6olLIPMnCOpY6/sJLFQ4zpFjs2gX6meDVS6onSJv2ekQPGBYubBiJ
	WObPMmK3588KLaQq20/SnW4dQW/nGhGB3qfZHL927o5XYRvQ9i6xSqA4V09144fKKCD2Y3dV1d0
	YNgJMqLV+rrgqIe+maVtSyLt67GwCxIbU7RhNA93Sbqf0vJ4VzlRvXcayn0SrkoIydtDDDAtMw0
	D1FeD666Yzq+sm4KB1qK0SyPBsPErTLEvjquxcRsS1HwgWvnP3pslxEDeKbuFu7Ko2NKp1NNZAa
	OIzw8y7gA4ts0P8K3EidzXFdqnYyNLr7/0MSSxnWpmAvF2M0d5epknaWUbdxB0Pb16f/NUS8waA
	yR09a6ldcAgl8e9ecog9/EnZ196uoc7A1vqwEV
X-Received: by 2002:a05:7300:fb89:b0:2be:88f2:3c98 with SMTP id 5a478bee46e88-2c1096e250amr626504eec.1.1773972801889;
        Thu, 19 Mar 2026 19:13:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b29d28csm1529357eec.19.2026.03.19.19.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 19:13:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 19 Mar 2026 19:13:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH 3/6] ata: libata-scsi: Refactor ata_scsiop_maint_in()
Message-ID: <0676888d-e683-4696-8289-ee8bf43beeb0@roeck-us.net>
References: <20241022024537.251905-1-dlemoal@kernel.org>
 <20241022024537.251905-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022024537.251905-4-dlemoal@kernel.org>

Hi,

On Tue, Oct 22, 2024 at 11:45:34AM +0900, Damien Le Moal wrote:
> Move the check for MI_REPORT_SUPPORTED_OPERATION_CODES from
> ata_scsi_simulate() into ata_scsiop_maint_in() to simplify
> ata_scsi_simulate() code.
> 
> Furthermore, since an rbuff fill actor function returning a non-zero
> value causes no data to be returned for the command, directly return
> an error (return 1) for invalid command formt after setting the invalid
> field in cdb error.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-scsi.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 8097cf318b04..f9c70f650cfc 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3388,12 +3388,16 @@ static unsigned int ata_scsiop_maint_in(struct ata_scsi_args *args, u8 *rbuf)
>  	struct ata_device *dev = args->dev;
>  	u8 *cdb = args->cmd->cmnd;
>  	u8 supported = 0, cdlp = 0, rwcdlp = 0;
> -	unsigned int err = 0;
> +
> +	if ((cdb[1] & 0x1f) != MI_REPORT_SUPPORTED_OPERATION_CODES) {
> +		ata_scsi_set_invalid_field(dev, args->cmd, 1, 0xff);
> +		return 1;
> +	}
>  
>  	if (cdb[2] != 1 && cdb[2] != 3) {
>  		ata_dev_warn(dev, "invalid command format %d\n", cdb[2]);
> -		err = 2;
> -		goto out;
> +		ata_scsi_set_invalid_field(dev, args->cmd, 1, 0xff);

Nit, but should this possibly be
		ata_scsi_set_invalid_field(dev, args->cmd, 2, 0xff);
							   ^
?

Thanks,
Guenter

> +		return 1;
>  	}
>  
>  	switch (cdb[3]) {
> @@ -3461,11 +3465,12 @@ static unsigned int ata_scsiop_maint_in(struct ata_scsi_args *args, u8 *rbuf)
>  	default:
>  		break;
>  	}
> -out:
> +
>  	/* One command format */
>  	rbuf[0] = rwcdlp;
>  	rbuf[1] = cdlp | supported;
> -	return err;
> +
> +	return 0;
>  }
>  
>  /**
> @@ -4377,10 +4382,7 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
>  		break;
>  
>  	case MAINTENANCE_IN:
> -		if ((scsicmd[1] & 0x1f) == MI_REPORT_SUPPORTED_OPERATION_CODES)
> -			ata_scsi_rbuf_fill(&args, ata_scsiop_maint_in);
> -		else
> -			ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
> +		ata_scsi_rbuf_fill(&args, ata_scsiop_maint_in);
>  		break;
>  
>  	/* all other commands */
> -- 
> 2.47.0
> 
