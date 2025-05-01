Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68772DC78C
	for <linux-ide@vger.kernel.org>; Thu,  1 May 2025 18:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125223; cv=none; b=ja4YaMpYutkLcgBdteoVqdny074KP/jA5PiWgZIzzp9mGOxu4FVjOlVgeaytWGMtbmiICiGLYd9vU3G2sp9X/JtN6kLPdj2UdEGP6UhaefQRo3F9oFpxf3eUftR0VFY5DXsjc8dkIik28gpuO/5zJzkRGQxUHI9lsJPzfBISeGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125223; c=relaxed/simple;
	bh=z38bxDyGaJOQ8XN2ICmUoX3TIshdK/um0l+xMjmG+FE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ijTTJfqugdr7oYKXvG7eSaXedQ7alCMJaPpefrSsqXVLvmCw+TrLc+ptlIdmc2zP+Jtw1NmlGDJeR426ycC/sX0VtAWHPj/QFox7cvUOG2bPxr0SXY4cZwSC2fYlDvqr3kX+UGJBkAZrrAyYGPXTamIg/Bcn4MTucUi8OXgqWLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yvx9u4WS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yvx9u4WS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7862C4CEE3;
	Thu,  1 May 2025 18:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125223;
	bh=z38bxDyGaJOQ8XN2ICmUoX3TIshdK/um0l+xMjmG+FE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Yvx9u4WSwXnrMOxrEy6/EPAGkP+XqWL5fk4rLq2SgYBiSNuqb2N88YsO2Sr7npgaG
	 lks2LrxlIJq3FP3S7U5LrDqmS///ZUyTQuPbtUSs912Y/ugBUsyiTkIJPKTy7Iz9+6
	 fxa0P3yusWzzutkEhgX7kMQScgEZQyCE1EFSII8udeauvxPhLjIl6s0vhvNiPkdQjK
	 JxhqeqJh3VwwEmLVaWifQvc/rBKAmRSqMyMvqQZ5a1Fcr3tcx5kghDWtJ6UJjoWfuE
	 /fHoBI6s2v75qj5/pfQqSfWbrVSe0G6gkZEAMJo15PvAt5NnV3fxSpGLwdFdlG1lna
	 Iuo/tFxi8doDQ==
Message-ID: <fe406980-f230-4060-9b1a-16295b6cfa48@kernel.org>
Date: Fri, 2 May 2025 03:47:01 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard
 drives
To: Ioannis Barkas <jnyb.de@gmail.com>, linux-ide@vger.kernel.org,
 Niklas Cassel <Niklas.Cassel@wdc.com>, Mikko Korhonen <mjkorhon@gmail.com>
References: <CADUzMVbneDW06V4vd8si8k=NN_6df3JeejaF3fVk2U=LVC1UHA@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CADUzMVbneDW06V4vd8si8k=NN_6df3JeejaF3fVk2U=LVC1UHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/25 05:36, Ioannis Barkas wrote:
> Hello guys,
> 
> It would be better to have more details on this since only the 2TB
> model is targeted.
> 
> Please provide hdparm, health details from the affected disk, full
> dmesg on the latest kernel you get errors so that we can confirm
> active lpm-pol and see platform in use as well as board & chipset.
> Have you tested this disk at another LPM capable system or HBA?
> 
> If the disk is in mint condition then it should be blacklisted if it
> fails on LPM transitions.

I removed this patch from for-6.15-fixes because the model string "WDC
WD20EFAX-68FB5N0" is wrong: it contains the drive serial number which should not
be there, of course.

Mikko,

As Ioannis suggested, please send the output of "hdparm -I /dev/sdX" for the drive.


> 
> Best regards,
> Ioannis
> 


-- 
Damien Le Moal
Western Digital Research
