Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2343D3BF
	for <linux-ide@vger.kernel.org>; Tue,  2 Apr 2024 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712100094; cv=none; b=KIWfykIEgHbqsd5uw8pe6v+zGrys2hjvJt8NHCW5wWluYf07wxiKI/RbCv2AcwteQkhQe7GHnGfbO95Pw+VdQCNxTzOnBVORBpeLgBC2gSfQob9TSuy+sHujVuWaoxeptXoUXsm8e7k69mE/zJ6GlfXrH0nz7po2ZE1v5sgn/Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712100094; c=relaxed/simple;
	bh=7fB6vsGvNByVFqYnU48fA2wDOKggEPE1LAoaTbRrHwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwt+H9TYZAEg3Q20iKNQUKLtx15o7D1oRXxEm9pfr0s0A5o7w3BZnc3WkbP3YBWib3QdsrZAwwsj/IZXQQT9pu9KNACtUl1LbtRT3+haYyW0DPp84MZubiK7D3rqX2F9Swd0YqX7iK5EquWqKNgre+91lM2v/sgzHbYY25EuX1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuHkNdae; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuHkNdae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7734C433F1;
	Tue,  2 Apr 2024 23:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712100093;
	bh=7fB6vsGvNByVFqYnU48fA2wDOKggEPE1LAoaTbRrHwM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cuHkNdaeNwOqtbffepMOjcXb/3Qo2RMHcidiSYQe5xR3Ld2Nt0Y4cox3VRQxfuC0Y
	 jOhM2penJtWrNobSCSg9Aec2WX2E9anTE+jBr+ijqVSN09qt3QDX46/7QnoMt2t4xk
	 lhisZLzdnnLSR/tBdbV8dZJYdook6YxcpBB7dmj8YIQBYhsxfxMdDjKxuPFYBgsSvR
	 HlZBTR/9XxX5PaLCOZf09Coy9jzi2slIqpn4eI91un+TMBoGhdN80L0rTrnQS87L2W
	 +m+2mzND2Dh5pHaKNtd9aDsTWFchRzuNn5kWz0x/Ufko1COa2cbwhgRZo2uFJeLZ2Q
	 cYTyyzWW8UAKw==
Message-ID: <b380e76e-73db-4a31-83aa-6662923300dd@kernel.org>
Date: Wed, 3 Apr 2024 08:21:30 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ASMedia PMP inquiry
To: Conrad Kostecki <conikost@gentoo.org>, Niklas Cassel <cassel@kernel.org>,
 Szuying Chen <chensiying21@gmail.com>
Cc: linux-ide@vger.kernel.org, Jesse1_Chang@asmedia.com.tw,
 Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
 cryptearth@googlemail.com, temnota.am@gmail.com, hdegoede@redhat.com,
 jnyb.de@gmail.com
References: <20240319091322.10909-1-Chloe_Chen@asmedia.com.tw>
 <ZflnYu5W5WnnzDio@ryzen>
 <emd6ef2021-5996-41a5-97d9-9864d65bb534@e6a850b0.com>
 <07b6a6d4-a9b1-468f-916f-1d4e6b1f92e5@kernel.org>
 <em1188b33c-20bf-4a1b-87a4-626abdf11c3d@acf693bc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <em1188b33c-20bf-4a1b-87a4-626abdf11c3d@acf693bc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/24 03:31, Conrad Kostecki wrote:
> Hello Damien,
> 
> Am 22.03.2024 01:00:02, "Damien Le Moal" <dlemoal@kernel.org> schrieb:
> 
>> Yes. I will add a libata.force parameter to do that so that setups that do not
>> use PMPs can avoid long boot times due to probing the broken "virtual ports".
>> Will post a patch next week for that.
> any news for the patch?

Been busy. I will get this started as soon as I can.

> 
> Cheers
> Conrad
> 

-- 
Damien Le Moal
Western Digital Research

