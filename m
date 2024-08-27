Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A54747F;
	Tue, 27 Aug 2024 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724723233; cv=none; b=oI+wj2xkWgFy6ET4u90970AO7A8xAnfbBCV/Xkpt/sdkPiI29DyWHNW2sXFIwII4+BJ0A6z9LlKY6bMyUSYysgh+06BkPNIhcjf5I+HlE0Yn+ptP6CKzCsorZ+5SBG/JDkAPwovv2U4YRxMfRbWb1zH4EYRWjCuBtuYnL8nl8oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724723233; c=relaxed/simple;
	bh=+qXgfVSsBGBPpHpA/O/XEXoWNBsYcQ9jrk5rfYzsaFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kr8wXtLhSBPTixGm5IQVi6Wbqdsiwe5eLxzVgC5Bt40AKrHHSG5i22DyhlRgqsvaQo7WJ5v9ZACKkTcL1LsJDT/fnzS50PS2FAgCLYi7k/Rd2BzIILLuTS8HsRDy2VLiCJQC3CWbWIHXX1SfTOWSDE2SR3YyIPs5G8YK4z/siBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wt9Px6hFXz4f3jrx;
	Tue, 27 Aug 2024 09:46:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6E7981A0568;
	Tue, 27 Aug 2024 09:47:00 +0800 (CST)
Received: from [10.174.178.72] (unknown [10.174.178.72])
	by APP4 (Coremail) with SMTP id gCh0CgBXzIISMM1m_8xLCw--.14243S3;
	Tue, 27 Aug 2024 09:47:00 +0800 (CST)
Message-ID: <96b9bedb-891e-4db3-abfe-bf6ff18c6048@huaweicloud.com>
Date: Tue, 27 Aug 2024 09:46:58 +0800
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata: Fix memory leak for error path in
 ata_host_alloc()
To: Damien Le Moal <dlemoal@kernel.org>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20240822033050.2909195-1-zhengqixing@huaweicloud.com>
 <e5862d36-6f16-469c-9d03-e7681bfb5bf5@kernel.org>
 <080848aa-dece-431a-9974-30a377786b69@huaweicloud.com>
 <ab0b512c-2d02-4eec-876c-2340284583fe@kernel.org>
From: Zheng Qixing <zhengqixing@huaweicloud.com>
In-Reply-To: <ab0b512c-2d02-4eec-876c-2340284583fe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXzIISMM1m_8xLCw--.14243S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4furyUKryfKr43tFy7Jrb_yoW5Gw48pF
	s7Ga15CFZ8Jrn7Jw1qgw1xAFySkw4UG3WUWr4kXa4I9wsavr1FgFWDZas0gF1jkr48W3WU
	JFy8Jry7uFyUZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/


在 2024/8/26 12:02, Damien Le Moal 写道:
> On 8/26/24 11:49 AM, Zheng Qixing wrote:
>> 在 2024/8/23 9:10, Damien Le Moal 写道:
>>> On 8/22/24 12:30 PM, Zheng Qixing wrote:
>>>> From: Zheng Qixing <zhengqixing@huawei.com>
>>>>
>>>> In ata_host_alloc(), if ata_port_alloc(host) fails to allocate memory
>>>> for a port, the allocated 'host' structure is not freed before returning
>>>> from the function. This results in a potential memory leak.
>>>>
>>>> This patch adds a kfree(host) before the error handling code is executed
>>>> to ensure that the 'host' structure is properly freed in case of an
>>>> allocation failure.
>>>>
>>>> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
>>> This needs a Fixes tag. So I added:
>>>
>>> Fixes: 2623c7a5f279 ("libata: add refcounting to ata_host")
>>> Cc: stable@vger.kernel.org>
>>>
>>> and applied to for-6.11-fixes. Thanks.
>>
>> Based on Niklas Cassel's suggestion, the commit message and the actual
>> content of the patch do not match.
>>
>> It should state "if devres_alloc(ata_devres_release, 0, GFP_KERNEL)
>> fails to allocate memory" instead of "if ata_port_alloc(host) fails to allocate
>> memory for a port".
>>
>> Should I modify the commit message and submit a new version of the patch?
> No need. I fixed it up. The commit message now is:
>
>      ata: libata: Fix memory leak for error path in ata_host_alloc()
>
>      In ata_host_alloc(), if devres_alloc() fails to allocate the device host
>      resource data pointer, the already allocated ata_host structure is not
>      freed before returning from the function. This results in a potential
>      memory leak.
>
>      Call kfree(host) before jumping to the error handling path to ensure
>      that the ata_host structure is properly freed if devres_alloc() fails.


Thanks.  :)


Zheng Qixing

>
>>
>> Zheng Qixing
>>
>>
>>>> ---
>>>> Changes in v2:
>>>>    - error path is wrong in v1
>>>>
>>>>    drivers/ata/libata-core.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>>> index e4023fc288ac..f27a18990c38 100644
>>>> --- a/drivers/ata/libata-core.c
>>>> +++ b/drivers/ata/libata-core.c
>>>> @@ -5663,8 +5663,10 @@ struct ata_host *ata_host_alloc(struct device *dev,
>>>> int n_ports)
>>>>        }
>>>>          dr = devres_alloc(ata_devres_release, 0, GFP_KERNEL);
>>>> -    if (!dr)
>>>> +    if (!dr) {
>>>> +        kfree(host);
>>>>            goto err_out;
>>>> +    }
>>>>          devres_add(dev, dr);
>>>>        dev_set_drvdata(dev, host);
>>

