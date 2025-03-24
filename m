Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826911953A9
	for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813599; cv=none; b=Je/nbwN+zhK2HlRKEwfhYTFowpsZaDCEp+8V+fY8IoN5UIHWrTRd/zQWK/70pMEAwjVZa817MmI8LslcdB8mY/VFuz6ZkTv2yev1JQR2E83brYEbmjhfHzE1VOqZe1sag5LbsqThckW2vAI51AlxcHDK14ETXD5swQDL1Ltbmi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813599; c=relaxed/simple;
	bh=QHbMLkCvI+ls17TLVs90ZoEm0j+SRAngOjag3OCoFE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rfqOCTimxNTayOwUxJSp54XrOxKoO/BS6tuLKaZXP1l+mxZ9JqhRHUn6MV+hm5Bm3JHoMYbHG2p3m7J5Sla1WGdnKDR9Qdwf71VwhiCf4bgvE3lTe4Kw+MWFNUcfpFgJNzyv3O97U+EGbHL/+qt5+qncfRoYicc2txgjRzkLLw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9m2Jivn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9m2Jivn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8130EC4CEDD;
	Mon, 24 Mar 2025 10:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742813599;
	bh=QHbMLkCvI+ls17TLVs90ZoEm0j+SRAngOjag3OCoFE4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u9m2JivnVer8HQvLuZJmv992SltwyAkUPYGQMe4edwd2RlHuGEkTA93dIFZatStdq
	 4udE0TlGsg2NVU0XKTzXEN5PloRTBJGsQ5MWRQO7rV+bgVtXzjvbHn6DO7W5nk6Mkv
	 vY1LoRXvlcjg83K5TEUk4XWrSKACp5I4k059H8EpSMJK4RjA8EVkr3iIau7JCNPqTS
	 6/WT4o6FooVZVRPmH6vs0ByqjRzMiU+mvTCrpAkkvsDNDLBV3Cz8S/9TaF7qV6PewA
	 bWT0IDXr/RCGolXq/fE8/sAR77F0aDxqGwicB17+qI5CAUisQg2dKFeRnWOkXgXBcs
	 M1rJgH5Suz2nA==
Message-ID: <c874f648-8583-4c6c-9ce5-5ba369ccc731@kernel.org>
Date: Mon, 24 Mar 2025 06:53:17 -0400
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] m68k: amiga_defconfig: enable PATA_CSWARP
To: Paolo Pisati <p.pisati@gmail.com>, Niklas Cassel <cassel@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org
References: <20250324092409.99430-1-p.pisati@gmail.com>
 <20250324092409.99430-2-p.pisati@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250324092409.99430-2-p.pisati@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/03/24 5:24, Paolo Pisati wrote:
> Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
> ---
>  arch/m68k/configs/amiga_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
> index c705247e7b5b..feed92c95394 100644
> --- a/arch/m68k/configs/amiga_defconfig
> +++ b/arch/m68k/configs/amiga_defconfig
> @@ -334,6 +334,7 @@ CONFIG_ATA=y
>  # CONFIG_ATA_VERBOSE_ERROR is not set
>  # CONFIG_ATA_BMDMA is not set
>  CONFIG_PATA_GAYLE=y
> +CONFIG_PATA_CSWARP=y

This needs to be patch 2, otherwise there will be some bisectability issues.
Unless Geert wants to take this patch and we queue patch 1 (the driver) through
libata tree.

Geert,

How do yu want to proceed ? We can take everything through libata, or you can
take both patches through your tree. I do not have a strong preference either way.

>  CONFIG_PATA_BUDDHA=y
>  CONFIG_MD=y
>  CONFIG_BLK_DEV_DM=m


-- 
Damien Le Moal
Western Digital Research
