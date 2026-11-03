Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739862;
	b=at9tDB8Rrjf9+0yaeAcJI16asbgPQ82+0R1/ip7F9hKpugqD2540x+tAHIp3yPJKHqXI
	 ZsR1tGxrlP81xnc7zo4Gzk8n1PDkPK1DlTVOaV3rvOCfHxnBbJa8LXvrauC3PpkBXVZlg
	 MpsS0rLalbOj4FWNO2PP4B6+lNqcfMbTVjcwkQKdbAl0RQLqJjOihWtNe/5GeKNPaRpr9
	 flS0bwmJGH2588c3ZSuW/ADQnmcuBCYRDXIs0ACTI23EKXMrB//vp9BodChpvCJc0Zqxu
	 Kgvz4VQiVPkkHnnl+gSndPvAMLBI2NxZrXBxuxhEPIsqu/lPB9oJJGPZQyzyT1dJ3FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739862;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8k4gz/3ybTJXRYGy3F6IbTDee6GmQaSgUAobNc20ItI=;
	b=gnVsxiVuy6zCxNNahyccvvtdZHQrkyNxGNgXKHQ9RB1S7xUuBbqgQQVWJ6eWw7tsAUiG
	 shfFLmRIRbigQj86km2rc1KGAkUcl1EqC+gnQaQUbq3aXufc0JefIV55xvVpkkjC8Kh9c
	 E2o5V9tSJhbUjdU6qgla8i8BqYPJwlMzN6Sw38yu1htjlKOeTvEwW0qt9zHOOP4BIH9Rm
	 5czYoLcxqCryX4xHMgPzksozPj9XEdhHTtR8KDbFOC8bz4iomW+mlDoxB35KqgJXPOi2c
	 i+0T8Zrpy6c7Pr/mmIF9HBZkxCoOy8d5ZMucVGmGJ8nzJCpm3mDYO729FCxvY7bDFQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQETP6e7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B69606A324
	for <linux-ide@vger.kernel.org>; Tue,  3 Nov 2026 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQETP6e7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86E11F000C1;
	Tue,  3 Nov 2026 21:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793739861;
	bh=8k4gz/3ybTJXRYGy3F6IbTDee6GmQaSgUAobNc20ItI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fQETP6e7kSHQhWn1/V+n7tj7lZpn06YnjOCDLI8a0dotVvld3r+rnDtEe34t006jQ
	 MkT1oHzdWRfqPaVgb0q0qWntxcxPZBabN+kCZ6xaGVgFF3MPfuWrGSYMGWbxS4ng/K
	 77wfGcXHMuglP9IYEq6avU5prz49pOreC27XUYmyxbeuQQTuqzWTUlAqTTAbw1LaBR
	 5uIUxwUW65MRAcJnyl/NG3ssa3j7uJnx/YCyWqTZYAlfz5czeZ8RxO0N5ntuCU3d5r
	 ga8y1jR3BDulvyJjb008f51w1n2g2knwXfxMY4MKeR03OX/v3S7ox/5iZgFSYkZOOc
	 pS2tbqDajHP1A==
Date: Tue, 3 Nov 2026 22:04:18 +0100
From: Niklas Cassel <cassel@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-scsi: set the field pointer when rejecting
 CDL
Message-ID: <aupMUrNn7PkrJg6W@ryzen>
References: <202610291903148135Df-fh-xl3zWuRJkq8AXn@zte.com.cn>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202610291903148135Df-fh-xl3zWuRJkq8AXn@zte.com.cn>

Hello Shao,

On Thu, Oct 29, 2026 at 07:03:14PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> ata_mselect_control_ata_feature() rejects enabling CDL while NCQ
> priority is enabled, but unlike its other error branches it returns
> without setting *fp.
> 
> ata_scsi_mode_select_xlat() initializes fp to 0xffff and, when the
> handler fails, adds the mode select header and block descriptor lengths
> to it.  The resulting sense data then reports a field pointer far
> outside of the submitted parameter list instead of the byte that has to
> be changed.
> 
> Set *fp to the beginning of the mode page data, as the other branches of
> this function do.
> 
> Fixes: df60f9c64576 ("scsi: ata: libata: Add ATA feature control sub-page translation")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 5cde90fe594e..c07c1ff09757 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -4494,6 +4494,7 @@ static int ata_mselect_control_ata_feature(struct ata_queued_cmd *qc,
>  		if (dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED) {
>  			ata_dev_err(dev,
>  				"NCQ priority must be disabled to enable CDL\n");
> +			*fp = 0;
>  			return -EINVAL;
>  		}
>  		ata_dev_dbg(dev, "Enabling CDL\n");


Setting fp to zero looks very wrong to me, even though with the current
overly complicated code where buf and fp was using completely different
offsets, it was actually correct.

I reworked and included your patch in my series:
https://lore.kernel.org/linux-ide/20261103205448.931471-17-cassel@kernel.org/

This way we can set the fp to the logical value for anyone actually
looking at the definition of this mode page in the SAT spec.

(Where the CDL_CTRL field is at offset 4 in the ATA Feature Control mode page)


Kind regards,
Niklas
