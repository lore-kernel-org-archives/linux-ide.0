Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC7B2F659F
	for <linux-ide@vger.kernel.org>; Wed,  7 Jan 2026 10:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767781186; cv=none; b=GVSNnVyJ1MHE8Zh0fcnik7zvDL7a742LSrxY6CyIPmEoilY4aVnvuARD967B7Ar7vB6CiXK4kpWznWLJrfqcZPYo+CRfYaSQlJWoLYSlgdK4MlPdkrSwqxw366GRI/atGEOQJBHnSmatu+iliUwBjAjuwMiOQ4sSN8mSrDf+44A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767781186; c=relaxed/simple;
	bh=BTHVrb2StRkRb/+bRhY7cWMEk9OUryrW0iS3lP/S9Cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0g0uzy+0jwUezCuTHB7/DFl61ZglmbrLuoUkMp9x2C6otrbjsp+sM1/J2cugiYwLrMPRqAG0JskD+tHA/IVHvs58zMu8qaSMDgBCAj5FnfpAB19wK7EE2eQrkaLTEhqVt776bKvRrlkwv6Eh2O4IX5N3cjwpzPUjgdtnKO5qvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DixWy6dY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DixWy6dY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6782AC16AAE;
	Wed,  7 Jan 2026 10:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767781185;
	bh=BTHVrb2StRkRb/+bRhY7cWMEk9OUryrW0iS3lP/S9Cc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DixWy6dYVo1vJIb8j9xuICnuQU189tXWwP8cL4yhGmbCUlBpn22TRYQ9o7QUB9Jmh
	 7wEJlhBiGxnt0cK0BaRlincbc3qt86wvoYTZhjycl9+9uZ0gYSy7u7FGSPE5rDaxZo
	 j5CiJivz4Ushywanvvg9DR5uf43DASjZV9gxiChJnFG1gUgXBiU9d+PJiYP/EuqEYK
	 DyHnNArWAy6nvErAXkgRt0FDrevXByTfvSNPK/pVuG0suaVsmT+Z9OtPk5SkC0vfX3
	 g7cOWnlztMCVKR9Ts5SsPrucpJalg6CbMso3WZ5OU3s1nOQfmqDeVtzZrcwdcIPgvq
	 M12A74LN1ASKw==
Message-ID: <85cae643-f3bc-43db-966c-3f57d8daa6b6@kernel.org>
Date: Wed, 7 Jan 2026 11:19:42 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] libata: SATA LPM forcibly disabled on Intel Raptor
 Lake since Linux 6.14.
To: Niklas Cassel <cassel@kernel.org>, wolf@yoxt.cc
Cc: linux-ide@vger.kernel.org, tj@kernel.org
References: <605b34a7723436284699c9a8e524907b@yoxt.cc>
 <aV4yBZkxVD2Olg3X@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aV4yBZkxVD2Olg3X@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/26 11:14, Niklas Cassel wrote:
> On Tue, Jan 06, 2026 at 08:57:07PM +0100, wolf@yoxt.cc wrote:
>> Hello,
>>
>> I am reporting a power-management regression in libata affecting the Intel
>> Raptor Lake SATA AHCI Controller, introduced after Linux 6.14.
> 
> (snip)
> 
>> and 4 apparent dummy ports might be unexpected?
>>
>> Manually setting LPM on the affected hosts fails with:
>> echo med_power_with_dipm >
>> /sys/class/scsi_host/host*/link_power_management_policy
>> -bash: echo: write error: Operation not supported

This will not work with the dummy ports. Can you do that successfully with the
valid ports ?

> 
> This is most likely because your ports are marked as External / Hotplug
> capable by BIOS.

I do not think so. There is no "ext" advertized in the log for the valid ports.
But still worth trying to see if the BIOS has a hotplug option and disable it if
it does.

> 
> LPM and Hotplug are mutually exlusive in SATA.
> So in order allow your ports to detect a hotplug event, LPM cannot be
> disabled.
> 
> 
> Things you can do:
> -Go into your BIOS settings and disable the hot-plugging capability for the
>  ports.
> -If you don't have such a setting, you can use the mask_port_ext AHCI module
>  parameter. Simply add:
>  ahci.mask_port_ext=<your portmask here> to your kernel command line
> 
> 
> For more info, see this thread:
> https://lore.kernel.org/linux-ide/5a74106a-d9db-4e63-b3e6-3857f30a1190@interia.pl/T/
> 
> 
> Kind regards,
> Niklas


-- 
Damien Le Moal
Western Digital Research
