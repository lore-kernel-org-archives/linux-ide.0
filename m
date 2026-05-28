Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95713191C8;
	Thu, 28 May 2026 05:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779946039; cv=none; b=eQnvpUmTZ171or0Pj0UmOfJuMAMpo0pX0CAiBXoluY73AwiRT6VPkj6wydauOZZLgZ1PBYQm0RrsJ8miC+FLph4Viy8m0D0a5CHE3zjaCprGy9aXiIS5hqdzItMNEykqo5MxntnSH+e/9WUmx8MY2fiTIDkF13msDzvzv85LDzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779946039; c=relaxed/simple;
	bh=E3XyTp9RGuSc9yckjisdvvH3fsVmBawW+Lcq9iajIqk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=d5WWT1pxz1ucIDvTlP/+NpoKlwQPOOiHSiNqpBb1cId0d8Gd6MIcOgQ6aEe8upZfMhcPKuaOdK/Is3+pgBXr6dDG8LIpZaqflafU7vSQPG1WbvoxSPTBtEFEpTbPNWblt1d8QoL+EYxu8+1rkeAshSulAmYnmKUtVQu2bZ9TbIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtjMPBQ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtjMPBQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626351F00A3A;
	Thu, 28 May 2026 05:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779946038;
	bh=k7zRJPN0sUGVAxSJFbzlVLbNOK1SN3swxsMHUt2ju7M=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=AtjMPBQ4bQAEwvkFlJwHrKljx6MMLTYRiQzGLbQ01q2r0CfpAtAdmDGwqSudzkRS3
	 nLkk/Vs3Vs1v+ejqS9QRx12HB9yCpl8hLXKuE5uuDUvOWFGlORFXJtGgxzxt6/qDQT
	 ZVsIptflv4PzqtQR/cbDcG39J02Ze+mhrKmLBlPsdk9NjMUFiXHS7VHKG8/+j+UlIP
	 WuxIlIGW6of/OYmLkTojmKvsuOFjmN7Rmz5RAP4lp2SzOt4VVQGP0i5oNz0vntmVT7
	 UrBJ/NnEXRxVjRKe7DYLBmXDNVRlIOJBq7RzSDJHwSJbfqohJY9+kjKIMQeWj6fPPd
	 PSNep0XJr01FA==
Message-ID: <ca92885c-0a61-4574-9136-bed6596dd72a@kernel.org>
Date: Thu, 28 May 2026 14:27:15 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ahci: use hweight_long() to count port_map bits
From: Damien Le Moal <dlemoal@kernel.org>
To: kensanya@163.com, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 TanZheng <tanzheng@kylinos.cn>
References: <20260527091729.266582-1-kensanya@163.com>
 <cd21e56b-04de-4b29-bc4a-d936ac8d29bb@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <cd21e56b-04de-4b29-bc4a-d936ac8d29bb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/26 03:18, Damien Le Moal wrote:
> On 2026/05/27 18:17, kensanya@163.com wrote:
>> From: TanZheng <tanzheng@kylinos.cn>
>>
>> Replace the open loop used to calculate the number of set bits
>> in the port mapping with the `hweight_long()` function, which
>> simplifies the code without altering its functionality.
>>
>> Signed-off-by: TanZheng <tanzheng@kylinos.cn>
> 
> This looks good to me. But as Niklas commented, if this needs a Suggested-by
> tag, please add it.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Note: the patch title should be:

ata: libahci: use hweight_long() to count port_map bits

Maybe Niklas can fix this when applying.


-- 
Damien Le Moal
Western Digital Research
