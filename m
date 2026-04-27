Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFB237F009
	for <linux-ide@vger.kernel.org>; Mon, 27 Apr 2026 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326464; cv=none; b=XzztKvK9iXZDvFBhC3Sj4M8ZkPVtQNwd/GN2Qe7YlkkyZI39Nv/ErBTmqE7QqEl5ggCQorX8XnRHxskExNmqQ8G96QDQ8MdF4sxbJ9V+U9kF/HVlp/c8RRtKb2xYDVMilqgaryqtP1Vm4nCvwUCRmcptSMWcH9jBR5BXfqV/qhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326464; c=relaxed/simple;
	bh=2DcM1g8muxMehZbCzbVNX2zYZngRlgEKLwXHxIrZOjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvXLwOeHWB6KNW8lK0+YBKrDzLOYEoN7nzrk0wkQkRIWQ+Dp88uPHFlC4vJtd0NfuwXRmMHnFjwkjafrs+pyFvR4qRcN3oEsjxYxL41iN1+io90X0jdcYeA2CRJ21UfhuKZWJwwbn6rDQzDLkh6MFajM305NG8W2B0TfKYy32/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7FY0X42; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7FY0X42"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFA6C19425;
	Mon, 27 Apr 2026 21:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777326463;
	bh=2DcM1g8muxMehZbCzbVNX2zYZngRlgEKLwXHxIrZOjs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J7FY0X42Rpz2C6Eg3RWW/l+rZQIC4qQvrxXAgretrZw5jYrELEFif029zi+FvUx+S
	 YGRxwTJ9Rrlt63RnX2IfCIvNFHm8tLrpoQRPe0wjDmjHSsxf0Xrkn/jEn5UhrPYtut
	 cOH8ukqtjyT6QhHxrQNhZfn3yBvzzTKvx92sUargePsNKbiZ/wISs3TLaUhYqGNxcs
	 5S1ISIatRdbAnonlhUpM5epTqex/2fcokuIg5OgmmYcGEQmXeiyja6H0Y4SF0I+jgi
	 HhT4IV07PZ4VNmOJ+YFlyiefzvhU2QQRrJhrCVXME/h5N4exFLqHJgkWyXbAz+ZPzl
	 eJ3BJuMWzcwxA==
Message-ID: <b135fcde-bff7-4725-87a7-3d3126af9007@kernel.org>
Date: Tue, 28 Apr 2026 06:47:41 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ata: ahci: fail probe if BAR too small for claimed
 ports
To: Niklas Cassel <cassel@kernel.org>, dayou5941@163.com
Cc: linux-ide@vger.kernel.org, liyouhong@kylinos.cn
References: <20260427060546.1407439-1-dayou5941@163.com>
 <ae9TGoaQAi7dOVc0@ryzen> <a805fa86-0fe7-4803-ad2e-45719415f263@kernel.org>
 <6149B806-C296-42DE-BF0E-119E8AF6129B@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <6149B806-C296-42DE-BF0E-119E8AF6129B@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/04/28 5:32, Niklas Cassel wrote:
> On 27 April 2026 22:23:12 CEST, Damien Le Moal <dlemoal@kernel.org> wrote:
>> On 2026/04/27 21:14, Niklas Cassel wrote:
>>>> +			 max_ports, last_port_end,
>>>> +			 (unsigned long long)bar_size);
>>>
>>> Print resource_size_t as %pa instead of casting to unsigned long long
>>> and pass bar_size by reference (&bar_size):
>>> https://docs.kernel.org/core-api/printk-formats.html#physical-address-types-phys-addr-t
>>>
>>>
>>>> +		return -ENODEV;
>>>
>>> return -EIO;
>>
>> I do not agree here. We did not do any I/O. If anything, this should be EINVAL.
>> But I think that ENODEV is safer since we are in the probe context here and we
>> do not want to see that device show up.
> 
> 
> How about -ENXIO?
> 
> No such device or address
> 
> 
> It is the only error code, except for -ENODEV
> that is a valid error code to fail probe():
> https://elixir.bootlin.com/linux/v7.0.1/source/drivers/base/dd.c#L653

That is my point, since we want to fail probe. So I would go with this ENODEV.


-- 
Damien Le Moal
Western Digital Research
