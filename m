Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2579F288B5;
	Mon, 19 Aug 2024 01:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724030255; cv=none; b=TgoYred5dagNOvp2ltlCP+5Xosf8HHqQqSiyRS8ELapP20qdqqz6kC8tBYaQvjTwsYIzuqQJXBSmnl9J/FUEIPlZrva9DxYxw41ltiDfM90MPkUIaH+Y0SbeDwU47IYrLe62xFAQoB5ofcValnTdSgjmlMaobqHKcAlBTTzK6sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724030255; c=relaxed/simple;
	bh=Kraybv2bM05Jkd47FisOuLQyJOdH9jsHsaPE0M0zjsU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uRPzv8ARObqoQ3PwE8BTo6mp6vrXv8UMZTgVAtUDXXPamlujX3JkrMg2Am2jDnXcH4+LkBhvAaNPzfhEGAtFN6NWyPv3eLWBXi5efVhfIAcDinuZnsfFmyyfKY2LWQJ042+HUONT6qUSdttBX1oDpYF+9InEP2XblXdvg/JGRTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WnF7Y18Jcz4f3jQv;
	Mon, 19 Aug 2024 09:17:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 308591A018D;
	Mon, 19 Aug 2024 09:17:27 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgBnj4UlncJmGj5YCA--.46393S3;
	Mon, 19 Aug 2024 09:17:27 +0800 (CST)
Subject: Re: [PATCH -next] ata: libata: Fix memory leak for error path in
 ata_host_alloc()
To: Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 Zheng Qixing <zhengqixing@huawei.com>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240816035820.2055747-1-zhengqixing@huawei.com>
 <3dfa5352-01d3-dc16-5a75-0b38e5893246@huaweicloud.com>
 <5949965e-0155-4ad1-a019-df220140b085@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ad59e599-9d6e-211a-957b-410a43eccbdb@huaweicloud.com>
Date: Mon, 19 Aug 2024 09:17:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5949965e-0155-4ad1-a019-df220140b085@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnj4UlncJmGj5YCA--.46393S3
X-Coremail-Antispam: 1UD129KBjvJXoW7trW5ZF4kCF15Ar43Ary5Arb_yoW8Cry5pF
	srWa1UCFWDGrn7uwnFg3W8ZF1rKa18Kr15ury8t34fZrnxtrn5GrZxCas8uFn0kr1kWF1j
	qFW8KryfCFyDZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/08/16 18:32, Damien Le Moal 写道:
> On 8/16/24 15:42, Yu Kuai wrote:
>> 在 2024/08/16 11:58, Zheng Qixing 写道:
>>> In ata_host_alloc(), if ata_port_alloc(host) fails to allocate memory
>>> for a port, the allocated 'host' structure is not freed before returning
>>> from the function. This results in a potential memory leak.
>>>
>>> This patch adds a kfree(host) before the error handling code is executed
>>> to ensure that the 'host' structure is properly freed in case of an
>>> allocation failure.
>>>
>>> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
> 
> I did not receive this patch and I do not see it on the list either. Something
> went wrong...
> Can you resend please ? Thanks.
> 
>>> ---
>>>    drivers/ata/libata-core.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>> index e4023fc288ac..f27a18990c38 100644
>>> --- a/drivers/ata/libata-core.c
>>> +++ b/drivers/ata/libata-core.c
>>> @@ -5663,8 +5663,10 @@ struct ata_host *ata_host_alloc(struct device *dev, int n_ports)
>>>    	}
>>>    
>>>    	dr = devres_alloc(ata_devres_release, 0, GFP_KERNEL);
>>> -	if (!dr)
>>> +	if (!dr) {
>>> +		kfree(host);
>>>    		goto err_out;
>>> +	}
>>
>> Looks correct, dev_set_drvdata(dev, host) is not called yet.
>> ata_devres_release won't free host in this case.
>>
>> I'll suggest to return NULL directly here, and then the 'err_out'
>> tag can be removed as well.
> 
> I do not think so. Since devres_open_group() was called, need to call either
> devres_remove_group() or devres_release_group().

Yes, you're right.

Thanks,
Kuai

> 
>>
>> Anyway, with or without the cleanup:
>> Reviewed-by: Yu Kuai <yukuai3@huawei.com>>
>> Thanks!
>>>    
>>>    	devres_add(dev, dr);
>>>    	dev_set_drvdata(dev, host);
>>>
>>
> 

