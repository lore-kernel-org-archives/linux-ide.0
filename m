Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBAF3DD52B;
	Mon, 31 Aug 2026 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169804; cv=none; b=kmOaYNj6cCj+NeuHlYVhHT6OHBV3nOu35Bhj4HzNnpkloOe9YJCZEmV7LaSJAqJ6GJYIid/6iw1rjAmtPIf8wEjC1o7HSTYEPXLCx4RWYW5h7aw0U8s92B0LFLovw/NmOaw7YTLtGPWu3OvNCbzBlaqYKhKhCT0oVjtnullP9Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169804; c=relaxed/simple;
	bh=qRCTfW+FEt6jonPSDUNQfJaL97CgTaB7bTl8QWI3qwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNodtQSGYgoiCqLgYH+F6Xc5BTrpP9pAIeuwQHNIpOTxEBG+g/yqlWXX5j6LZCYC/CCpCZnajlbxPL/PtphJcxk80ixg1rMVNh/DS9g41CnvwfYVGDFOPaYbuPsVSYes75NEn6lUPxdFauQlm2hUdRmsgmZqhy+9GlglSIuHbzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 511cb7b2a52111f19a56ed5b684f684d-20260831
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:5d44bb92-dd19-4248-86ea-e88b537ca367,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:762628b54bea45daa416573839494a66,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|52,EDM
	:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 511cb7b2a52111f19a56ed5b684f684d-20260831
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1387274517; Mon, 31 Aug 2026 17:49:53 +0800
Message-ID: <095d7e23-27f5-438a-b881-63fcf0b9baaa@kylinos.cn>
Date: Mon, 31 Aug 2026 17:49:51 +0800
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: pata_parport: Fix use-after-free in
 new_device_store
To: Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, linux@zary.sk,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
References: <77dad1184ebd0e1e7ea541d4207568f8bc5ec01f.1785381141.git.xiaopei01@kylinos.cn>
 <178816836663.189107.12488362030216541340.b4-ty@kernel.org>
 <apVKS5ZSmxplZp7c@ryzen>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <apVKS5ZSmxplZp7c@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/8/31 17:32, Niklas Cassel 写道:
> Hello Pei,
> 
> On Mon, Aug 31, 2026 at 11:26:06AM +0200, Niklas Cassel wrote:
>> On Thu, 30 Jul 2026 11:16:29 +0800, Pei Xiao wrote:
>>> The function new_device_store() calls driver_find() without any
>>> protection against concurrent driver unregistration. This can lead
>>> to a use-after-free (UAF) when a driver is unloaded (via rmmod)
>>> in parallel with a new device addition via sysfs.
>>>
>>> The race window exists because driver_find() returns a pointer to
>>> the driver's private data, but does not increase its reference
>>> count. The caller is responsible for ensuring the driver remains
>>> valid, but new_device_store() did not hold any lock or reference
>>> during the lookup and subsequent use.
>>>
>>> [...]
>>
>> Applied to libata/linux.git (for-7.4), thanks!
>>
>> [1/1] ata: pata_parport: Fix use-after-free in new_device_store
>>       https://git.kernel.org/libata/linux/c/bd46a0b2
> 
> I picked up this patch.
> 
> But here:
> https://lore.kernel.org/linux-ide/dd146e49-33ff-4ae8-a641-1dc614e22733@kylinos.cn/T/#m1cd93326f2935273e707c0aaea3c659a238bf2b6
> 
> Damien asked you:
> "Sashiko had a comment about this that I think is very valid: if rmmod is
> executed with devices attached, what happens here?
> This entire driver seems to be lacking reference counting on the
> modules/drivers, so this all seems very fragile."
hi Maintainer,
I have submitted this patch, and now I'm a bit unsure whether I've
solved this problem.
https://lore.kernel.org/lkml/a8d9807618ab786313654099c904d613075e1b63.1785398816.git.xiaopei01@kylinos.cn/

thanks！
Pei.
> 
> 
> The Sashiko comment he was referring to was not a Sashiko comment posted in
> that same thread, but on an earlier version of your patch. The Sashiko
> comment can be found here:
> https://lore.kernel.org/linux-ide/20260729112609.3CD3A1F000E9@smtp.kernel.org/
> 
> """"
> [Severity: High]
> This is a pre-existing issue, but does pata_parport_unregister_driver() leak
> devices?
> 
> When a protocol module's init function registers multiple protocols (like
> kbic_init registering k951 and k971) and a subsequent registration fails, it
> will call pata_parport_unregister_driver() on the already-registered protocol.
> 
> While the protocol is removed from the IDR and the driver is unregistered, the
> dynamically created pi_adapter devices are not cleaned up. Since the module
> init returns an error, the module loader frees the module memory, bypassing
> the reference held by the devices.
> 
> If these dangling devices are later removed (for example, via sysfs
> delete_device), pi_remove_one() calls pi_disconnect(pi), which dereferences
> the freed pi->proto->disconnect pointer, leading to a kernel crash.
> 
> Should the associated devices be unregistered here as well?
> """"
> 
> 
> Do you perhaps have some spare cycles to address this issue as well?
> 
> 
> Kind regards,
> Niklas

