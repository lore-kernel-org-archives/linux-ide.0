Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE071E534
	for <linux-ide@vger.kernel.org>; Fri, 22 Mar 2024 00:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065606; cv=none; b=Za90Vl2Xz+XJb+2sPU/iA59NS97FbrV1WLCjkIPEChSYU8fSrwKUQbSgpxm9zevO42gKvxz2+KbSSJTz9H6hvJj2ja3LVQMPYqiGSyiGiOz6ukwwrbxS8oj06sAQIF7RJe7J9+j+dAzNpEz+6yfbVitLat5OvmrCEbXwnBq39gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065606; c=relaxed/simple;
	bh=jcu39qVEH887pVeNWQXv3ez94IjvgYpj23AP6QWoSXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqK9Y/FAGVGGyUQWM+Emdkjquwm9qlj3NASDnsimgXKpWP/v2nZNWhnnfYUWShNvapfvIxhk8eWJPuqfKQ/7/y3Ntu69SJcq8eRLhdKieYW1kfxegBlUCgGrasXQGyTl/4ddKifBP9NGr1fNzFL23p7gBKjKODDWoHnr+m/aOdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHLHi8Qe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHLHi8Qe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25382C433C7;
	Fri, 22 Mar 2024 00:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711065605;
	bh=jcu39qVEH887pVeNWQXv3ez94IjvgYpj23AP6QWoSXI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tHLHi8Qev61vJeDEOkHXdPbYKeJQ40/9uMuJHBYmKkzvQGW4KeUVAYZ+9WMRbKL2i
	 VReUQZZQWaFdyZqP3BoGRWs+D27/wLxmzKf4i6X+haFaNmSCnsLeUdBCdCgGUX4EkS
	 9GSreiB2KaCiIUPnTTzzGRQGArLl64cmH7x6D42bKz89g/c3/yAeCL6FqZrOacM5rD
	 0a6gsx0hbW5aAv++qP4CIzSkDvdCSDD5mhk/N8Efcog3zcUonTD4TEKHsW/d2/P0EM
	 h/D9kIxe0cCZ7RA9u1C6LflEjTVrcgxSQ6YEh/mMbsOK7L9skM/I8rnCi+quzZY6gy
	 N0SycVepJCJXA==
Message-ID: <07b6a6d4-a9b1-468f-916f-1d4e6b1f92e5@kernel.org>
Date: Fri, 22 Mar 2024 09:00:02 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ASMedia PMP inquiry
Content-Language: en-US
To: Conrad Kostecki <conikost@gentoo.org>, Niklas Cassel <cassel@kernel.org>,
 Szuying Chen <chensiying21@gmail.com>
Cc: linux-ide@vger.kernel.org, Jesse1_Chang@asmedia.com.tw,
 Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
 cryptearth@googlemail.com, temnota.am@gmail.com, hdegoede@redhat.com,
 jnyb.de@gmail.com
References: <20240319091322.10909-1-Chloe_Chen@asmedia.com.tw>
 <ZflnYu5W5WnnzDio@ryzen>
 <emd6ef2021-5996-41a5-97d9-9864d65bb534@e6a850b0.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <emd6ef2021-5996-41a5-97d9-9864d65bb534@e6a850b0.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/24 08:23, Conrad Kostecki wrote:
> Hi Niklas,
> 
> Am 19.03.2024 11:22:26, "Niklas Cassel" <cassel@kernel.org> schrieb:
> 
>> However, from what I've understood from how you have decided to implement
>> PMP support on your HBAs, I assume that setting the PI register to 0xf
>> would also stop Delock 90073 from working with an externally connected
>> port multiplier, so that it probably not a good approach after all.
> 
> I can see, that you have now reverted the changes / merged my patch with 
> additional description.
> Do you see any possibility for overriding saved_port_map as kernel 
> parameter would be possibile for asm devices somehow?
> Of course only as opt-in.

Yes. I will add a libata.force parameter to do that so that setups that do not
use PMPs can avoid long boot times due to probing the broken "virtual ports".
Will post a patch next week for that.

-- 
Damien Le Moal
Western Digital Research

