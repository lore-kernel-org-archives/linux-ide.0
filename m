Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2283F1CD02;
	Thu, 22 Aug 2024 03:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724297368; cv=none; b=JQiU2EPVkm9IbD1evPPzDAWxbLMFzITL8jraxJuQT0DSGADFEusd9aLsNYw7DFwQwd4uFFx5jhlObh1crPvBlXbovrH29uKdQ8e0CZ4e2HUUqtESsOXm6ciHg1cgNP26LFWaSS7jJuy4f9SRBptsaWEO6JMyR+Lhs2bPYhBTYWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724297368; c=relaxed/simple;
	bh=tt2iy/zfSU9t4sXLvAJHIKqx3BuOcIRpOrPHzPbvaDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Bk4iiXzmDxkjRRgbehvL0EjaJf0GVP0fIejBTmclRUKivMfoDQh/DZ43PjMbAEgbvydYxh6yb+SLBdS++TZ16dXX8giw6ax0F4wlf7DvYYc+HSirBn8T7Zs0Vri5pPxFjdq3ZTcnXBzjgwsnMdwAVvww/QThyRM0H0n+1XYfWqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wq7wY2gGQz1S8VG;
	Thu, 22 Aug 2024 11:29:17 +0800 (CST)
Received: from kwepemh100003.china.huawei.com (unknown [7.202.181.85])
	by mail.maildlp.com (Postfix) with ESMTPS id 282231400DD;
	Thu, 22 Aug 2024 11:29:21 +0800 (CST)
Received: from [10.174.178.72] (10.174.178.72) by
 kwepemh100003.china.huawei.com (7.202.181.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 22 Aug 2024 11:29:20 +0800
Message-ID: <af7a5219-76e7-4d1e-b05f-9674919abc62@huawei.com>
Date: Thu, 22 Aug 2024 11:29:19 +0800
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata:Fix memory leak for error path in ata_host_alloc()
To: Zheng Qixing <zhengqixing@huaweicloud.com>, <dlemoal@kernel.org>
CC: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai3@huawei.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20240822031742.2721254-1-zhengqixing@huaweicloud.com>
From: Zheng Qixing <zhengqixing@huawei.com>
In-Reply-To: <20240822031742.2721254-1-zhengqixing@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh100003.china.huawei.com (7.202.181.85)


在 2024/8/22 11:17, Zheng Qixing 写道:
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
> ---
>   drivers/ata/libata-core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index ee18c09c39b6..cb3ace759699 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5610,9 +5610,10 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
>   		struct ata_port *ap;
>   
>   		ap = ata_port_alloc(host);
> -		if (!ap)
> +		if (!ap) {
>   			kfree(host);
>   			goto err_out;
> +		}
>   
>   		ap->port_no = i;
>   		host->ports[i] = ap;

Sorry, this patch is wrong, i will send a new version.


Zheng Qixing

