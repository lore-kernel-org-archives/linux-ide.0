Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15FF84DE0;
	Fri, 16 Aug 2024 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723790587; cv=none; b=KceJGRQT6uHKpc0bbGV/gktvbiuHZaLldI/RR3FQs1STN+ivtLTiOnKiFpXXi+Ttx/DXKxnkQuXwXpcfdzQNzaViH8Zlz8pbhTNADxnRUiuYkMeIBsCEYZijuDQCng21+wUsb/EEMDYxqY3sKqp5QL/D0D//gbc0rTYBUZAW4Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723790587; c=relaxed/simple;
	bh=A7XUGVo4bLb36C2A9FMtN1T5FMonrDrgrw/tjiSER3Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ID6JPcWOV2uMx9lEG2torfP1uOGR+32Ib+fzgPV2aCWQw3gcocmitfTwAJ/rWaPpo9bCqBMkdjixvZ9vXbX7n/cjAP0qOol/hLvs88sQHMroYpfDe41plsJ5e8EZGJ3Q/kLJMIQOQSldOzZ9GEt08P70eu6y86SvwzQHsxHEcFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WlXVY6Nfzz4f3jZ1;
	Fri, 16 Aug 2024 14:42:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5160C1A1316;
	Fri, 16 Aug 2024 14:42:55 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgAXPoTt9L5mFo1UBw--.63231S3;
	Fri, 16 Aug 2024 14:42:55 +0800 (CST)
Subject: Re: [PATCH -next] ata: libata: Fix memory leak for error path in
 ata_host_alloc()
To: Zheng Qixing <zhengqixing@huawei.com>, dlemoal@kernel.org,
 cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240816035820.2055747-1-zhengqixing@huawei.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3dfa5352-01d3-dc16-5a75-0b38e5893246@huaweicloud.com>
Date: Fri, 16 Aug 2024 14:42:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240816035820.2055747-1-zhengqixing@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXPoTt9L5mFo1UBw--.63231S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFW7Wr4xJFW8AFy5Xr4xZwb_yoW8Gry8pa
	nrWayrCrZ8Grs7ur1Dua1xZFWSga15GrW5urWxW34Svr43Ar18GrZ8Cas8X3Wakr4vga45
	JFW8tFy8CFWDZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHD
	UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2024/08/16 11:58, Zheng Qixing Ð´µÀ:
> In ata_host_alloc(), if ata_port_alloc(host) fails to allocate memory
> for a port, the allocated 'host' structure is not freed before returning
> from the function. This results in a potential memory leak.
> 
> This patch adds a kfree(host) before the error handling code is executed
> to ensure that the 'host' structure is properly freed in case of an
> allocation failure.
> 
> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
> ---
>   drivers/ata/libata-core.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index e4023fc288ac..f27a18990c38 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5663,8 +5663,10 @@ struct ata_host *ata_host_alloc(struct device *dev, int n_ports)
>   	}
>   
>   	dr = devres_alloc(ata_devres_release, 0, GFP_KERNEL);
> -	if (!dr)
> +	if (!dr) {
> +		kfree(host);
>   		goto err_out;
> +	}

Looks correct, dev_set_drvdata(dev, host) is not called yet.
ata_devres_release won't free host in this case.

I'll suggest to return NULL directly here, and then the 'err_out'
tag can be removed as well.

Anyway, with or without the cleanup:
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

Thanks!
>   
>   	devres_add(dev, dr);
>   	dev_set_drvdata(dev, host);
> 

