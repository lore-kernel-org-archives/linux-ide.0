Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A69245008;
	Thu, 30 Jul 2026 01:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785376071; cv=none; b=jXEwgV3Atabx/W9k9SfehDMgjaKX1ynksy2PGqa3HlJi6qthCbBOT0J/MNh7gTpGSxRdXVi9E7LsTpwGBMHHWcv7480+tmwO3IXJChupFet2idoIfDuHKVhHNpeWUrfD5qS8KAd+ji0cfB4Wg/IMuL6LiEoSzuslXulKPqy27IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785376071; c=relaxed/simple;
	bh=SX/etS+h3jb+bhY60AgNahsDQBERPK2tDz68yV3RY5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aT8m9prjSm3jP97JDPAUm7a5pPrBbmxC0RZ87woMr2nZpb0fVMs22Wd3zZ9g31bsUYrLLOkzc2mNB2/yUPmqff1hMIH5G+YzewR6lirh8nqcm7QuZCKPOnnfnUdlmsYK+d//b59ly267g7Q5RS8pBPod+BEsyFqmU0izF+wOSmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a7e572968bb811f1aa26b74ffac11d73-20260730
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:970f899c-864b-413d-b33c-f990197212c4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:ae6ebced720b64d34df3a33405ace47e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a7e572968bb811f1aa26b74ffac11d73-20260730
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1540911931; Thu, 30 Jul 2026 09:47:43 +0800
Message-ID: <e98b166b-3ab1-42e5-ba96-38d58ac9a4a2@kylinos.cn>
Date: Thu, 30 Jul 2026 09:47:39 +0800
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_parport: Fix use-after-free in new_device_store
To: Niklas Cassel <cassel@kernel.org>
Cc: dlemoal@kernel.org, linux@zary.sk, axboe@kernel.dk,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 shuangpeng.kernel@gmail.com
References: <7a9734be161cd051063ccc3bdeb377c55a83c4bf.1785327915.git.xiaopei01@kylinos.cn>
 <amn7udA2btlcum-N@ryzen>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <amn7udA2btlcum-N@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/7/29 21:10, Niklas Cassel 写道:
> On Wed, Jul 29, 2026 at 08:27:53PM +0800, Pei Xiao wrote:
> 
> (snip)
> 
>> Fixes: 72f2b0b21850 ("drivers/block: Move PARIDE protocol modules to drivers/ata/pata_parport")
> 
> This does not look like the correct Fixes tag, since it is simply moving
> files.
> 
Thank you for your reply. Perhaps I didn’t know how to use the --follow
option correctly, so the oldest commit I saw was the rename commit. But
now I’ve learned to use --follow, and I found the commit:

Fixes: 246a1c4c6b7f ("ata: pata_parport: add driver (PARIDE replacement)")
> Not saying that it is super important to have a Fixes tag.
> 
> Without having looked, I'm guessing that there is a chance that this has
> been racy/broken since the driver was introduced.
> 
> 
> Kind regards,
> Niklas

