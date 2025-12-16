Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675D72E03E3
	for <linux-ide@vger.kernel.org>; Tue, 16 Dec 2025 05:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765863280; cv=none; b=lfoafP4Be5tknVFuf5jK/2PRhUsvz75pxZF5lTjaTUJX6LCqdMpTmIniGnrSQB2b0Img0wZGTVKEErLPvFqxQx759sH0z7ET/1s3E667WL7jySeqHHV5b2efcZjkDiO1jsbDdySpUbSaQr08fkCfivt7CXZj/f5ulU9Sq8CX7P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765863280; c=relaxed/simple;
	bh=exe5a1Oh2VduGMiztp9GlVsBeWiruwKGd9QOBdAnakA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fl2njqX84S0LnlFBKTn5pgK1nR17a00Pw20y4j/ODCZdsUILrgB7DNeqQxarSz+RGSuajelYEtvWDhiEr3Ncj8DjZfq33YT2O6CuKqmcscc9zDMeuCy6HvL37ZkryxpqIZbT8QRmgk4knamBGUWeIH63zV/GGtsJomvJVc+lsBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4t5AQTC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4t5AQTC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A138C4CEF1;
	Tue, 16 Dec 2025 05:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765863279;
	bh=exe5a1Oh2VduGMiztp9GlVsBeWiruwKGd9QOBdAnakA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a4t5AQTCmQIpDXjgJdAUuCcUjzYeP/zJ5mZQFoEnkWcuQGmONVtJlTUyI1EPtclxz
	 iF+AeuDt+CUNrjl5idTBRPLXlQdgWl9MDunJxW6KATWMAt/tRsFzXx8/qGrL1wkvw1
	 HkLBnRpgmafV5C5oj0HThsnQAxx7JUWmVDrClmewuIE1xw4jLYNH0md+0C7LE1I1ae
	 Sjvs6FcjHgdebP/UM/gS1OpPUmcn/hqaDJB3TIverNukFJ5ciP8EKTBs0ehfKaPJQa
	 awXRjZnVGYX+CivZr33xmaPeJDThHCy/It52vP1nhP34LY2cVCKGdmBgWRSdthT0c5
	 vq29jx/hJljYw==
Message-ID: <1e9a9ac6-77da-4727-b768-46bd7c496b0e@kernel.org>
Date: Tue, 16 Dec 2025 14:30:11 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Disable LPM on ST2000DM008-2FR102
To: Niklas Cassel <cassel@kernel.org>
Cc: Emerson Pinter <e@pinter.dev>, linux-ide@vger.kernel.org
References: <20251209042359.1467124-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251209042359.1467124-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/25 1:24 PM, Niklas Cassel wrote:
> According to a user report, the ST2000DM008-2FR102 has problems with LPM.
> 
> Reported-by: Emerson Pinter <e@pinter.dev>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220693
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/libata-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index b96105481784..94c0e0ff981f 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4187,6 +4187,9 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>  						ATA_QUIRK_NOLPM },
>  	{ "VB0250EAVER",	"HPG7",		ATA_QUIRK_BROKEN_FPDMA_AA },
>  
> +	/* ST disks with LPM issues */
> +	{ "ST2000DM008-2FR102",	NULL,		ATA_QUIRK_NOLPM },
> +
>  	/* Blacklist entries taken from Silicon Image 3124/3132
>  	   Windows driver .inf file - also several Linux problem reports */
>  	{ "HTS541060G9SA00",    "MB3OC60D",     ATA_QUIRK_NONCQ },
> 
> base-commit: a26a0b4b48e181ff5ff340f9dc83612c74f2ccad

Applied to for-6.19-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research
