Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D5D358369;
	Tue, 30 Jun 2026 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811375; cv=none; b=E36rc3Uu9wd8WfgUDiy/Nj2ggZB68XqveYs/1tNNrVRhwv4VYOPTbf7LToFDT0ruzgexrNmAGSPJMD28ItBS6BnNXBMROfUy54lQfJCFbZdWYiIX/vqPqqEow6FgcXqa/cfVertUIJ68NiRdFYDum6gXYVC80uot8Bu5UYM5Xz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811375; c=relaxed/simple;
	bh=XGRKtIIDDzlZkvu3TSmmY+Cl8GT8KngFJJZE1FIsvCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCeD4AXtzwCfriqJg6HfllELot3YR4WzcTX1uS7aY3GKGrvAV5vC0RMu/raoWgFr2DufzzwJ83aCgD57eEhiQGdQVmtGdBFCDohrwtZ6OAntwvSfSJeQJs0j1YQXdNp1HqszhEI8G/UTlimhkHMoWItXsoJPnSZ+92yHp827v08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Khlv9WJe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Khlv9WJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF81C1F00A3A;
	Tue, 30 Jun 2026 09:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782811374;
	bh=YHjzf9LNGqY5IwUvQcbkbMSLn4rbRjAHsdyG4KX59I0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Khlv9WJeOd0xggIDz9LKjfyQB12IIpB1fXDOaKnVb0MbAmJtG5zOPW4kNclvSihSH
	 5YzZztU+qTDyJO2ybF/YQXRiR/OE/h1TV5ockx58P4yfjilVIDPafS2nGuZG/eA9hF
	 PpPi086Sy6URMa66FcL0f+P26iERMM9DRmIBsMIVYzQMbJuKxigCSnJx0AFQdmK8Ly
	 5A4/MhdMnEuFwaN4EEaUTrfOGUmJqzX/u99SNyW03EFL4jBSscHBBCLPlhGMTaAVvl
	 dS+5dwxzntqgjxImt8WSWVG+74eKowQWSeP8646ijJ5ItB1ke5Q63wXARUpd8HMryL
	 7HCHQZqNiRPWQ==
Message-ID: <2865750f-9bab-47d8-b4c9-9cf1cbef7834@kernel.org>
Date: Tue, 30 Jun 2026 18:22:52 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: sata_dwc_460ex: use platform_get_irq()
To: Niklas Cassel <cassel@kernel.org>
Cc: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>
References: <20260628230310.1214770-1-rosenp@gmail.com>
 <akNzEGgiYC5V3rtc@ryzen> <9327f32a-5037-477c-80dc-f99b97ed9740@kernel.org>
 <DF85BCA7-B344-4AD6-8F6B-22CB3A3DF823@kernel.org>
 <CAKxU2N8uWY3k3nHTmdxEn86zEZ_hGJgyPvHWuHt=zRaPk-29kg@mail.gmail.com>
 <CAKxU2N_2N0YWBrF1k82qXCYYyvZxa26GYi09xiyKbBAtUoC_mA@mail.gmail.com>
 <743a2748-a458-4e65-a1d2-f54a6657e7a6@kernel.org> <akOHEDdu3zw9Uhph@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <akOHEDdu3zw9Uhph@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/26 18:06, Niklas Cassel wrote:
> On Tue, Jun 30, 2026 at 06:00:46PM +0900, Damien Le Moal wrote:
>> On 6/30/26 17:52, Rosen Penev wrote:
>>>>> Inside ifdef, that is probably why Sashiko did not catch this new warning.
>>>>>
>>>>> Rosen, I suggest that you use dev->of_node directly within the ifdef, and drop the local np variable.
>>>> device_property_present is probably better. But yeah. I'll whip up a v2.
>>> thinking about this some more. Should use IS_ENABLED to prevent hiding
>>> this code from the compiler.
>>
>> What code are you talking about ?
>> What is in the #ifdef CONFIG_SATA_DWC_OLD_DMA ?
>> CONFIG_SATA_DWC_OLD_DMA is determined automatically by Kconfig. So this is not
>> hidding anything and why I did not see the warning in my compile tests
>> (CONFIG_SATA_DWC_OLD_DMA was enabled for me). The report was for Sparc, and
>> CONFIG_SATA_DWC_OLD_DMA was disabled so the unused variable warning showed up.
> 
> I think he means: keep the local np variable,
> and replace the #ifdef with
> if (IS_ENABLED(CONFIG_SATA_DWC_OLD_DMA) && !of_property_present(np, "dmas")) {
> 
> 
> I think it will work for both CONFIG_SATA_DWC_OLD_DMA=y and
> CONFIG_SATA_DWC_OLD_DMA=n without giving any warnings.

I do not think it will. The if() will be compiled out if IS_ENABLED() is false,
but the variable declaration will remain and so will the warning. Unless that
declaration also goes away, IS_ENABLED() will not solve the issue. But if the
variable is removed, I gree is is a lot cleaner !

> 
> 
> 
> Kind regards,
> Niklas


-- 
Damien Le Moal
Western Digital Research
