Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEB317588;
	Thu, 22 Aug 2024 03:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724297835; cv=none; b=JE5GvmkvEQduHAJel3e7R2QKfaIAkJGtcgoviKFblkE1ys2boRJxa6X/bY2RDBVXlYA0mOtCW2NrJ8ATmF1c3hBn1gteZUPGgwxaB/d5QCfg6RT6oHgMPI4zBSl9tsLDHx0O73syFmwVQXDWYwp2FxXJ21zGQwNy8AOfgiQw2SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724297835; c=relaxed/simple;
	bh=rP92DGTqflMdiBVbknq9dEhhUqls0pzOWymDC0At810=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AQJdU/SrDcdRwkg/mB/tudrdG5kJnBsdYjF6F5zBe1b99pVVbQp+SW1d6QNRYCjOUcRRjppvzL8NMKVQ1fdVpOTvGBrtoCdIQ0bRGBUw6SbTWPo4VdXhVp+KFA/Mpy+JriA3875XlusbE1WjYIMu0HJxKHdlXKFJgZZlMy3cVog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wq85S2fDZz4f3jtS;
	Thu, 22 Aug 2024 11:37:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 119681A0359;
	Thu, 22 Aug 2024 11:37:10 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgBHboRkssZmnXJ5CQ--.39865S3;
	Thu, 22 Aug 2024 11:37:09 +0800 (CST)
Subject: Re: [PATCH v2] ata: libata: Fix memory leak for error path in
 ata_host_alloc()
To: Zheng Qixing <zhengqixing@huaweicloud.com>, dlemoal@kernel.org,
 cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, zhengqixing@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240822033050.2909195-1-zhengqixing@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <517c5178-bbc8-3496-49e6-5c26d9c1aaf9@huaweicloud.com>
Date: Thu, 22 Aug 2024 11:37:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240822033050.2909195-1-zhengqixing@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHboRkssZmnXJ5CQ--.39865S3
X-Coremail-Antispam: 1UD129KBjvJXoWruw18WF4DGF47KF1kCr43trb_yoW8Jr1Upa
	nrWa18CrZ8Grn7uw1Du3WxAFWfKa1UGr48urW8K34Svr4ayr18Kwn8Aas8X3W29r48Wa43
	JFy8try8CFWUZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2024/08/22 11:30, Zheng Qixing Ð´µÀ:
> From: Zheng Qixing <zhengqixing@huawei.com>
> 
> In ata_host_alloc(), if ata_port_alloc(host) fails to allocate memory
> for a port, the allocated 'host' structure is not freed before returning
> from the function. This results in a potential memory leak.
> 
> This patch adds a kfree(host) before the error handling code is executed
> to ensure that the 'host' structure is properly freed in case of an
> allocation failure.
> 
> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

Thanks.
> ---
> Changes in v2:
>   - error path is wrong in v1
> 
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
>   
>   	devres_add(dev, dr);
>   	dev_set_drvdata(dev, host);
> 

