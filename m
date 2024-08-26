Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238278B60
	for <linux-ide@vger.kernel.org>; Mon, 26 Aug 2024 06:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654140; cv=none; b=hzNvr9Mvl6iZQLu8zMAsGcH9ulrCHp2fwe83YpRe1m1dwIAHHPYWBWzAqR66iJDhvimf/eJPqVjfALl0+ny53lLTaRWt8HoSbdjha/EXD6e1irbhlnzO6xuqqJ68wt9nJIRPWV10D4ujbAW5hNJmCLxRlDfeMtX5AYMZrxQiyV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654140; c=relaxed/simple;
	bh=xKySZsrj9z6qRjIduHL0KPPr2h/dfdHuA1ybQmZ9TxU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uE+UhDPsy4JstrOzJuQrEooQPFFMTuHIZnu9vrUst05zRgKCK1P1O1/gmrY+dG00i8x+T+zVZT/moEQrZIbgaas3t/LqXgRDet6hSS7aKPzwf0y6U9n32kzDgqGKf442yefubaM6EC9Ynn26OXV8Ef88XhUt7W/Y5Wf22+OunHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WsgsW0SQ5z1j7Bd;
	Mon, 26 Aug 2024 14:35:27 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 6102D1A0188;
	Mon, 26 Aug 2024 14:35:35 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 26 Aug 2024 14:35:34 +0800
Subject: Re: [PATCH -next] ata: libata: Remove obsoleted declaration for
 ata_sff_irq_clear
To: Damien Le Moal <dlemoal@kernel.org>, <cassel@kernel.org>
CC: <linux-ide@vger.kernel.org>
References: <20240824121449.2522086-1-cuigaosheng1@huawei.com>
 <51e7d53e-2a15-4401-96f1-bb6300bff535@kernel.org>
From: cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <24838cbf-952b-2fc4-f2a5-9ab44d92b10b@huawei.com>
Date: Mon, 26 Aug 2024 14:35:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <51e7d53e-2a15-4401-96f1-bb6300bff535@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200011.china.huawei.com (7.221.188.251)


On 2024/8/26 12:10, Damien Le Moal wrote:
> On 8/24/24 9:14 PM, Gaosheng Cui wrote:
>> The ata_sff_irq_clear() have been removed since
>> commit 37f65b8bc262 ("libata-sff: ata_sff_irq_clear() is BMDMA
>> specific"), and now it is useless, so remove it.
> Same comment as previous patch, the writing could be better. Furthermore, I
> think the 2 patches should be squashed since they are both modifying the same
> file. E.g., something like this would be better:
>
> ata: libata: Remove obsolete functions declaration
>
> The function ata_schedule_scsi_eh() was removed with commit f8bbfc247efb
> ("[PATCH] SCSI: make scsi_implement_eh() generic API for SCSI transports"). And
> the function ata_sff_irq_clear() was removed with commit 37f65b8bc262
> ("libata-sff: ata_sff_irq_clear() is BMDMA specific").
>
> Remove the now useless declarations of these functions in drivers/ata/libata.h.
>
> And a single patch to remove both declarations. Can you resend with this change
> please ?
>

I hava re-sent a new patch v2 with this change, thanks.

>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>> ---
>>   include/linux/libata.h | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index 0279c0a6302f..6552e90753ae 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
>> @@ -2006,7 +2006,6 @@ extern unsigned int ata_sff_data_xfer(struct ata_queued_cmd *qc,
>>   extern unsigned int ata_sff_data_xfer32(struct ata_queued_cmd *qc,
>>   			unsigned char *buf, unsigned int buflen, int rw);
>>   extern void ata_sff_irq_on(struct ata_port *ap);
>> -extern void ata_sff_irq_clear(struct ata_port *ap);
>>   extern int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
>>   			    u8 status, int in_wq);
>>   extern void ata_sff_queue_work(struct work_struct *work);
