Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B2C12FF6E;
	Thu, 11 Jul 2024 22:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720736541; cv=none; b=QqCjsOVUfnyTYkcasOp/DjU3dfz/wHWgUkzXUhJt3xv1aMwm+v909b4mlMbt1wjoLlgzJjdwXSaRBqoTvJru2qk0JhYkcendjUNwbvjica3dCMUKJL+ATPQgcOA5Z06/3wvdmwo0k41GHcaxc2PT/7uLxWlGeoIms3+2TXFTME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720736541; c=relaxed/simple;
	bh=S8+sMbBaIXU0ECLByTpf+s/x+2jnhjByGTthrbm8Src=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LpiUGt3HIWMqBWot0o9ShONG8NTCKid1csPNTpERXZqisNLiIrGbTfvP3LInUCjQ3o8/uObN/F8hKtdFS00KX5pXFDwQz4roBFPg29Ike4m4xEuzLIeNuam/sYZuwVP2kLQekIwcyvu5b7I2m4AZI4Xa4haz+JzIUHQCbGcnhoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJ2PcQ/L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJ2PcQ/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBA4C116B1;
	Thu, 11 Jul 2024 22:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720736541;
	bh=S8+sMbBaIXU0ECLByTpf+s/x+2jnhjByGTthrbm8Src=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rJ2PcQ/LzXpmbirXp5OuVsmjJDftpqEkzZhvxdMx2G8fLf1mdu5XPjzwyGdO8fj0z
	 pYg9jTYDNKedG7Jn4Mtg3L7VntrayFs6CXbvhkpYP+JRvnWEZFp2y92gvf5h2Efwq9
	 ViHY6kmiqdCZRoP6DSvOiwZRRm3dNt7lIv+t+u3Cr6pWF2Up4NqzjH2LeSpdxSg0YB
	 rKDf4vkYcmobjxeF3wOYr10qtXw9iMjS/2u6Nqwo03gZ9m/btSWUDddqfibTvFEgw+
	 suTykYe7PfNSGiu6uarlYin7jWT1GiM+tCw/p9ctUCWaLFQCjXx4a93mtahnqGRnMD
	 s3tvpbLGfzBlQ==
Message-ID: <0c2dac55-d20e-4132-be62-0623900a62e1@kernel.org>
Date: Fri, 12 Jul 2024 07:22:19 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5.10/5.15] ata: libata-scsi: check cdb length for
 VARIABLE_LENGTH_CMD commands
To: Artem Sadovnikov <ancowi69@gmail.com>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240711151546.341491-1-ancowi69@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240711151546.341491-1-ancowi69@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/12/24 00:15, Artem Sadovnikov wrote:
> Fuzzing of 5.10 stable branch reports a slab-out-of-bounds error in
> ata_scsi_pass_thru.
> 
> The error is fixed in 5.18 by commit ce70fd9a551a ("scsi: core: Remove the
> cmd field from struct scsi_request") upstream.
> 
> The problem is that the length of the received SCSI command is not
> validated if scsi_op == VARIABLE_LENGTH_CMD. It can lead to out-of-bounds
> reading if the user sends a request with SCSI command of length less than
> 32.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>
> Signed-off-by: Mikhail Ivanov <iwanov-23@bk.ru>
> Signed-off-by: Mikhail Ukhin <mish.uxin2012@yandex.ru>

Looks good, so please feel free to add:

Acked-by: Damien Le Moal <dlemoal@kernel.org>

However, you did not address this patch to linux-stable and Greg, so it will go
nowhere as is since I cannot apply that to stable. So please check:

Documentation/process/stable-kernel-rules.rst

and see "option 2".

> ---
>  drivers/ata/libata-scsi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 36f32fa052df..4397986db053 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3949,6 +3949,9 @@ static unsigned int ata_scsi_var_len_cdb_xlat(struct ata_queued_cmd *qc)
>  	const u8 *cdb = scmd->cmnd;
>  	const u16 sa = get_unaligned_be16(&cdb[8]);
>  
> +	if (scmd->cmd_len != 32)
> +		return 1;
> +
>  	/*
>  	 * if service action represents a ata pass-thru(32) command,
>  	 * then pass it to ata_scsi_pass_thru handler.

-- 
Damien Le Moal
Western Digital Research

