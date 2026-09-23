Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728A021ABC9;
	Wed, 23 Sep 2026 01:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790126575; cv=none; b=gOhig31Vi/ul7PiKhJh5s+gHZptOTwT3RaHQKjh5mFqU/yDk9rQD+l0VbTNRaQaW524nmWQKR122GsagcOj7b+YXnAZ0cb7ApsdCv4sLT9GejrCbI6TwrgeTkF4yPKYP9sPOxrhTx9c/56Zo02ZmOUBctf/kWN6dg6zmDMYnf5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790126575; c=relaxed/simple;
	bh=A+3vYfrTUr9mwE1ZcCgBnFC9WxVY09IUFMKr26VLjwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxKRmEaoAu1kXEWVNNDHsE5lxcIoMCElvG8NYv8H+qoNU6Q4zi/0EGe21JBh2/5h5Yk9wRkthOaSzn8HPz9mA7f2T6iaTL8e/rYhUDUSJkHxpX4xOnz6CDfUx92wUbchQt+9gBiKtwnFJovHCPm+KlPSRyu5gS3aYckReyJMdBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9478f0cab6ec11f19a56ed5b684f684d-20260923
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d80b21c5-c1e1-4552-9cf1-5d341d35dd68,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:60354df2836bd219256cc746932e7531,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|52|99,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9478f0cab6ec11f19a56ed5b684f684d-20260923
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 982311563; Wed, 23 Sep 2026 09:17:44 +0800
Message-ID: <63bf9e57-1edf-4e1d-8195-99be056f075a@kylinos.cn>
Date: Wed, 23 Sep 2026 09:17:41 +0800
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] ata: pata_parport: pin the protocol module before
 device_register()
To: Niklas Cassel <cassel@kernel.org>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1790047457.git.xiaopei01@kylinos.cn>
 <952bac5f61dc69079c3ffe62d6392bcc89f6aac0.1790047457.git.xiaopei01@kylinos.cn>
 <arKWUwJeXUdGHpp0@ryzen>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <arKWUwJeXUdGHpp0@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/9/22 22:53, Niklas Cassel 写道:
> Hello Pei,
> 
> On Tue, Sep 22, 2026 at 11:38:00AM +0800, Pei Xiao wrote:
>> pi_init_one() calls device_register() before try_module_get(). Between
>> these two calls the device is already visible but the module is not
>> pinned yet, so an unload in this window leaves pi->proto dangling:
>>
>>     pi_init_one()                       rmmod -f <proto>
>>     --------------------------------------------------------
>>     device_register(&pi->dev)
>>          device visible on the bus
>>                                            module memory freed
>>          pi->proto = pr        <- writes into freed memory / dangles
>>          try_module_get(...)   <- too late, module already gone
>>
>> Take the module reference before registering the device, and drop it
>> on the device_register() failure path.
>>
>> Fixes: 246a1c4c6b7f ("ata: pata_parport: add driver (PARIDE replacement)")
>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> 
> Looking at the code, this race cannot happen.
> 
> All three callers hold pi_mutex throughout pi_init_one().
> 
> pata_parport_unregister_driver() also acquires the mutex
> before unregistering.
> 
> Thus, unload cannot complete at the same time as pi_init_one().
> So the motivation looks wrong.
> 
> Additionally, rmmod -f bypasses a non-zero module reference count,
> so I don't see how taking a refcount earlier would solve a rmmod -f.
Yes, you're right — force unload doesn't really solve this issue. Thanks
for pointing it out.
  Thanks for your reply, and sorry for the noise.

Pei.
Thanks.
> 
> Are you building your kernel with CONFIG_MODULE_FORCE_UNLOAD ?
> 
> 
> Kind regards,
> Niklas

