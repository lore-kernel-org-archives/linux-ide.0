Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E555256;
	Mon, 26 Aug 2024 02:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724640574; cv=none; b=W8On4zRIrkRtYxe+ZXZk9aREbSdS3gYODhCK8LwywQ3rlgfA6rQX6Wg16F472FbkH8OoVgwMSrk5b0Q5H55tLGLQieTrxZ8aaguOvBiXIQ/XBNIoz9MAsjbdClj4NuR45AK7kBcfkqk7/B4AhoRKnAiUB5xlwIYLfrBIOLmBLmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724640574; c=relaxed/simple;
	bh=slf0cnSx0YTr94akvuk3CYcV+0+zNfcCPXl+8oshNfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKTQkvCGYApMHVmFW9Kok98aNFao4fhieNHyF3+UTyVxKwYAtBgCzJ879Dn6Ph5h5YMPVaAcggjbEr8Px5s/IpgTDovB9ZZy9BAEYtboDNp/glugpsaikGtiAaMYbOH1Q9j18qvYbN4+QZ9ImyNS3eDx0cIMyiOtICVvG388zNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WsZrR3pxqz4f3l1s;
	Mon, 26 Aug 2024 10:49:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D8A0D1A1124;
	Mon, 26 Aug 2024 10:49:26 +0800 (CST)
Received: from [10.174.178.72] (unknown [10.174.178.72])
	by APP4 (Coremail) with SMTP id gCh0CgCXv4U17ctmRKjwCg--.11969S3;
	Mon, 26 Aug 2024 10:49:26 +0800 (CST)
Message-ID: <080848aa-dece-431a-9974-30a377786b69@huaweicloud.com>
Date: Mon, 26 Aug 2024 10:49:25 +0800
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata: Fix memory leak for error path in
 ata_host_alloc()
To: Damien Le Moal <dlemoal@kernel.org>,
 Zheng Qixing <zhengqixing@huaweicloud.com>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20240822033050.2909195-1-zhengqixing@huaweicloud.com>
 <e5862d36-6f16-469c-9d03-e7681bfb5bf5@kernel.org>
From: Zheng Qixing <zhengqixing@huaweicloud.com>
In-Reply-To: <e5862d36-6f16-469c-9d03-e7681bfb5bf5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXv4U17ctmRKjwCg--.11969S3
X-Coremail-Antispam: 1UD129KBjvJXoW7trW8KrW5uw47JryDJrykAFb_yoW8AFWUpa
	n7Ga15CFZ8Grn7uwnru3WxJFWfKa1UGr4UurZ2g34F9rs0v3W8Ga909as8Wa4j9rs5Wa4U
	JFy8Xry7CFyUZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUSLvNUUUUU=
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/


在 2024/8/23 9:10, Damien Le Moal 写道:
> On 8/22/24 12:30 PM, Zheng Qixing wrote:
>> From: Zheng Qixing <zhengqixing@huawei.com>
>>
>> In ata_host_alloc(), if ata_port_alloc(host) fails to allocate memory
>> for a port, the allocated 'host' structure is not freed before returning
>> from the function. This results in a potential memory leak.
>>
>> This patch adds a kfree(host) before the error handling code is executed
>> to ensure that the 'host' structure is properly freed in case of an
>> allocation failure.
>>
>> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
> This needs a Fixes tag. So I added:
>
> Fixes: 2623c7a5f279 ("libata: add refcounting to ata_host")
> Cc: stable@vger.kernel.org>
>
> and applied to for-6.11-fixes. Thanks.


Based on Niklas Cassel's suggestion, the commit message and the actual
content of the patch do not match.

It should state "if devres_alloc(ata_devres_release, 0, GFP_KERNEL)
fails to allocate memory" instead of "if ata_port_alloc(host) fails to 
allocate
memory for a port".

Should I modify the commit message and submit a new version of the patch?


Zheng Qixing


>> ---
>> Changes in v2:
>>   - error path is wrong in v1
>>
>>   drivers/ata/libata-core.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index e4023fc288ac..f27a18990c38 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -5663,8 +5663,10 @@ struct ata_host *ata_host_alloc(struct device *dev, int n_ports)
>>   	}
>>   
>>   	dr = devres_alloc(ata_devres_release, 0, GFP_KERNEL);
>> -	if (!dr)
>> +	if (!dr) {
>> +		kfree(host);
>>   		goto err_out;
>> +	}
>>   
>>   	devres_add(dev, dr);
>>   	dev_set_drvdata(dev, host);

