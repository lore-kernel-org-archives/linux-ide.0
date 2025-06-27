Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98A1224893
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021735; cv=none; b=P6dsyqIS/+tCWV+KdL1aGczvAmzWTRDQSW9Arn3y0mFLHF7ayRKCFzy6lntTKxgkj+2eqmr2T8ihh5pnWT9FKn8KPRP1EDB0j/bpEMqONRsUNLHfWlUNV+dfpxoTYrqAEgzQty7rJq4sp+feUV8VyQnb+PCD4JzwmIsqMaTDX5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021735; c=relaxed/simple;
	bh=4PIRSuxe8RwRwXX/FFF5vVf2OQQ3TECMPE4Hb4OYY+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7wBz79+NKp4gO4DUXR1aQxoIyBJkG4tH+tuf7mROW20vHOxEfGGssI08DJC+MjaQE6OKPtnGl0sStLGd9tYf92C4GuZyzK0OMFnPVKF58PgAC8LFd10JRqi6P/fJaPhvfqY8XthpDoCnICksZvpJNlLQ1/rSrHSqw8AIDZXTqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3ttCtba; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3ttCtba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BB9C4CEE3;
	Fri, 27 Jun 2025 10:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751021735;
	bh=4PIRSuxe8RwRwXX/FFF5vVf2OQQ3TECMPE4Hb4OYY+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R3ttCtbaW+qStfwN9kpFw7iUgzxBLAnPWAbcIQxyN4MfDBMU1sfwy9DCwrHmTQ+kt
	 vmP3f9ERtTUwW5sv8WEjnVC62G6ue6qDSx8BCR1MqpZi4f1dhS76/WClVAtcoAsd4J
	 jibo/azMemANrLn3XyRfxHw6I1x/Q2L47DarkaS3UWGPc7NvTquQN/FBNVyamjy7tA
	 7Y6qwr7WuU+jMjTfCcmRwER3f2wa5cMzV9akepLSe8uWpy26B508rKgnKum5LyRy+8
	 ds7YChyXBP/9NHUst7F2pQA2nQkItroxQmaff2qv/DmRkTOgFn8Cqa82Nux+Whx6x6
	 2l8Z//O9b0yBg==
Date: Fri, 27 Jun 2025 12:55:31 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 5/6] ata: ahci: Clarify mobile_lpm_policy description
Message-ID: <aF54o3OI1QqF5vPd@ryzen>
References: <20250627075207.23969-1-dlemoal@kernel.org>
 <20250627075207.23969-6-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627075207.23969-6-dlemoal@kernel.org>

On Fri, Jun 27, 2025 at 04:52:06PM +0900, Damien Le Moal wrote:
> Despite its name, the mobile_lpm_policy module parameter defines the
> default LPM policy to use for an AHCI adapter for all chipsets,
> including desktop and server chipsets. Clarify this point in the
> parameter description.
> 
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/ahci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index e5e5c2e81d09..9347d0ec8793 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -674,7 +674,9 @@ MODULE_PARM_DESC(marvell_enable, "Marvell SATA via AHCI (1 = enabled)");
>  
>  static int mobile_lpm_policy = -1;
>  module_param(mobile_lpm_policy, int, 0644);
> -MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
> +MODULE_PARM_DESC(mobile_lpm_policy,
> +		 "Default LPM policy. Despite its name, this parameter applies "
> +		 "to all chipsets, including desktop and servers chipsets");

Nit: desktop is singular, servers is plural.
Make both singular or both plural.

(I think both in singular sounds slightly better.)


Reviewed-by: Niklas Cassel <cassel@kernel.org>
