Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD66E309F09
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 03:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788836953; cv=none; b=jpDukfRX0u83ZsQiiyoyzBfXx1HG4+U1O/VfDyb3KVmq9uKfI8H9RSiRQcorvUx8FF8knVpupEGR4pNX5SZ40vdlybDowTdU/uTcinG+V5laE+aCnvhSaMFL3uTu3CsMpWaKzZkxMFmfS8B1hBtkYSQMBY4fRZxVUG8xjQq8aDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788836953; c=relaxed/simple;
	bh=tBuU+9/zAuSgwp7WcGK0Hk58wIg8I9bVT8GMq09GVYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PtWDWrYxdhZ656J4BRAj+9vkKCmNREK1PoKdRsX+kmSUf9zLdNAigU8NeNvNvOT2N3wVV8a9d6gJ9Wo+EECJA3iO6MT5CvxCLMFaV0Zc8sptd//UAiSbWCuEJBxvs1uUa1gXTnT3cqtCr2+mG959mb8KkMDXF6b6tTQrYhUsQWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a1aff5ecab3211f19a56ed5b684f684d-20260908
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d782ae84-d1e7-4f6d-86e2-05159aedf17d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:8e45ff6a0dd9a6922978862f1e8545b2,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|52|99,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a1aff5ecab3211f19a56ed5b684f684d-20260908
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 966926733; Tue, 08 Sep 2026 11:08:57 +0800
Message-ID: <ad9fd316-018b-4ad2-b49e-45f8d9dfe2fd@kylinos.cn>
Date: Tue, 8 Sep 2026 11:08:51 +0800
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ata: pata_parport: pin the protocol module before
 device_register()
To: Niklas Cassel <cassel@kernel.org>, sashiko-reviews@lists.linux.dev
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org
References: <cover.1788349317.git.xiaopei01@kylinos.cn>
 <eae63a4231a9d669f3dc140f34c7b90c860cad72.1788349317.git.xiaopei01@kylinos.cn>
 <20260902120609.635581F000E9@smtp.kernel.org> <apryADzYkvYwj358@ryzen>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <apryADzYkvYwj358@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/9/5 00:29, Niklas Cassel 写道:
> On Wed, Sep 02, 2026 at 12:06:08PM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Low] Unused label `out_unreg_dev` causes compiler warning.
>> --
>>
>> commit 99f7607699410f6446da6e37e3bed84251a51bd8
>> Author: Pei Xiao <xiaopei01@kylinos.cn>
>>
>> ata: pata_parport: pin the protocol module before device_register()
>>
>> Take the module reference before registering the device to prevent a race
>> condition where the device is visible but the protocol module is not yet
>> pinned. Also ensure the reference is dropped on the device_register()
>> failure path.
>>
>>> diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
>>> index cf81a6128f552..7462f9b1acc57 100644
>>> --- a/drivers/ata/pata_parport/pata_parport.c
>>> +++ b/drivers/ata/pata_parport/pata_parport.c
>>
>> [ ... ]
>>
>>> @@ -517,15 +525,12 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
>>>  	pi->dev.id = id;
>>>  	dev_set_name(&pi->dev, "pata_parport.%u", pi->dev.id);
>>>  	if (device_register(&pi->dev)) {
>>> +		module_put(pi->proto->owner);
>>>  		put_device(&pi->dev);
>>>  		/* pata_parport_dev_release will do ida_free(dev->id) and kfree(pi) */
>>>  		return NULL;
>>>  	}
>>>  
>>> -	pi->proto = pr;
>>> -
>>> -	if (!try_module_get(pi->proto->owner))
>>> -		goto out_unreg_dev;
>>
>> [Severity: Low]
>> Does removing this goto leave the out_unreg_dev label unused at the bottom
>> of pi_init_one()?
>>
>> If the label is no longer referenced, compiling the kernel will emit a
>> -Wunused-label warning. This can cause build failures in configurations
>> that enforce -Werror.
> 
> We don't want to introduce any new build warnings.
> 
> W=1 builds are important too, even if not default.
My fault. Thanks for pointing out. I will send v2

Pei.
Thanks!
> 
> 
> Kind regards,
> Niklas

