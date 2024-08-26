Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF242D052;
	Mon, 26 Aug 2024 04:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724644944; cv=none; b=D+91gwy6uKm5qOip5p9S/nrLtIQ1y3S+Omk3M+2grf2obsv8uyR6eC7ga4cWtFra8VL9L1V+og4cvvTLV5hJfQq+OTYf9ijr/IRnxAZ7kzuppyqeLYW0umbUAoYjM17CIcDrkyotHo9erB+c31tVK4IhB8/DeR/4RCUpn4Vi6Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724644944; c=relaxed/simple;
	bh=AjH5pEyXc0+xxc6LRgaucLwumSeZDdXzNMpJgBfQ5B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VoNnJdrq0VeTIFdzJx7TMpkO+wy7dfVhx6MY0IhDCiHZz1DbxArQaaEacUcrjUoJNYrP3Gf9GdLlkf+dMxUuOYJSIO0KyAmKF/NQy0zgsAbqex+zhugEt2028584vFfjZxLa9uD604XuBqmgFMkVR6YkQK8PfyXbIFvPZALwdP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYkgrfdx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYkgrfdx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421B4C32786;
	Mon, 26 Aug 2024 04:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724644943;
	bh=AjH5pEyXc0+xxc6LRgaucLwumSeZDdXzNMpJgBfQ5B0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PYkgrfdxjiVYuQG++6O51oxmp+HZbGp8/2e2P+OCoqOO7GEaauI/bae75Xt78u1Ld
	 jSogZBbI8vWY7y9gS8uCNfj+cyHHuul2a9aG9J98AFfkUlDU6C306IFTS0SNnjB+kW
	 A57otHXv7Zo7YPFiCiBYrgXv3VVvWq8+C7dfE3LjVo2VErejy5ozh/T89GmSgLsMpI
	 c2sG6HPe6Xwa+sD4ZzhPUeNzkzaKBmZV44pc2HioMAhflHDvMa+HaB39FnCAgN7p+y
	 /Zr+EAAD7U5M9bjTPIVYuCJgEy5CMLSGEQS6Dah88sjPp6ip4VrLQZWZTZbgIL1pi5
	 QblEWJ1+D3ALA==
Message-ID: <ab0b512c-2d02-4eec-876c-2340284583fe@kernel.org>
Date: Mon, 26 Aug 2024 13:02:21 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata: Fix memory leak for error path in
 ata_host_alloc()
To: Zheng Qixing <zhengqixing@huaweicloud.com>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20240822033050.2909195-1-zhengqixing@huaweicloud.com>
 <e5862d36-6f16-469c-9d03-e7681bfb5bf5@kernel.org>
 <080848aa-dece-431a-9974-30a377786b69@huaweicloud.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <080848aa-dece-431a-9974-30a377786b69@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/26/24 11:49 AM, Zheng Qixing wrote:
> 
> 在 2024/8/23 9:10, Damien Le Moal 写道:
>> On 8/22/24 12:30 PM, Zheng Qixing wrote:
>>> From: Zheng Qixing <zhengqixing@huawei.com>
>>>
>>> In ata_host_alloc(), if ata_port_alloc(host) fails to allocate memory
>>> for a port, the allocated 'host' structure is not freed before returning
>>> from the function. This results in a potential memory leak.
>>>
>>> This patch adds a kfree(host) before the error handling code is executed
>>> to ensure that the 'host' structure is properly freed in case of an
>>> allocation failure.
>>>
>>> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
>> This needs a Fixes tag. So I added:
>>
>> Fixes: 2623c7a5f279 ("libata: add refcounting to ata_host")
>> Cc: stable@vger.kernel.org>
>>
>> and applied to for-6.11-fixes. Thanks.
> 
> 
> Based on Niklas Cassel's suggestion, the commit message and the actual
> content of the patch do not match.
> 
> It should state "if devres_alloc(ata_devres_release, 0, GFP_KERNEL)
> fails to allocate memory" instead of "if ata_port_alloc(host) fails to allocate
> memory for a port".
> 
> Should I modify the commit message and submit a new version of the patch?

No need. I fixed it up. The commit message now is:

    ata: libata: Fix memory leak for error path in ata_host_alloc()

    In ata_host_alloc(), if devres_alloc() fails to allocate the device host
    resource data pointer, the already allocated ata_host structure is not
    freed before returning from the function. This results in a potential
    memory leak.

    Call kfree(host) before jumping to the error handling path to ensure
    that the ata_host structure is properly freed if devres_alloc() fails.

> 
> 
> Zheng Qixing
> 
> 
>>> ---
>>> Changes in v2:
>>>   - error path is wrong in v1
>>>
>>>   drivers/ata/libata-core.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>> index e4023fc288ac..f27a18990c38 100644
>>> --- a/drivers/ata/libata-core.c
>>> +++ b/drivers/ata/libata-core.c
>>> @@ -5663,8 +5663,10 @@ struct ata_host *ata_host_alloc(struct device *dev,
>>> int n_ports)
>>>       }
>>>         dr = devres_alloc(ata_devres_release, 0, GFP_KERNEL);
>>> -    if (!dr)
>>> +    if (!dr) {
>>> +        kfree(host);
>>>           goto err_out;
>>> +    }
>>>         devres_add(dev, dr);
>>>       dev_set_drvdata(dev, host);
> 
> 

-- 
Damien Le Moal
Western Digital Research

