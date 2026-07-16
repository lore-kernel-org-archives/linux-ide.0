Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C79520DD51;
	Thu, 16 Jul 2026 02:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784169120; cv=none; b=uIQmF9RZh3S9PFgLHBDS8T7y6XvzhkTtC5ocEsTIOzS9IzTlKwyT27xiz4md1g99ojGuoV86mbHOGva7k7O6gyX4B0UUqG/TjrR9RJ7zzsSZNJLBnuqzz6pH03wdtXXP17Cb7BlZcfNpSd7XlIKg6iwk7N91qJ291OmmJXD3Ls0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784169120; c=relaxed/simple;
	bh=tZRRQEimv3BwKo/EIv7fzlI0hZt5xDnzUVKuOTOFSUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PbapypIXZ7/ZmxTvgv5e25OmyX6jpOpzPsJtF9uQtym6fYST2HC25iXVQ4U05WNAuKeSRzj2GFqw0Y3PnUmg1OMC2WI4+Yetu7SXXZfaM9P9qAWdzXDsN8BXd9JMqYiZnMk0oHEWApwIDakyfj/8Gr3hos0poBsPUDg8NNojC2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8260fd4280be11f1aa26b74ffac11d73-20260716
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:1712e837-4403-428a-9085-06779adaa9d2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:2ce057e6627d25534b1f83e017dd60ca,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|817|850|865|898,TC:nil,C
	ontent:-10|-8|-5|14|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8260fd4280be11f1aa26b74ffac11d73-20260716
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1662231309; Thu, 16 Jul 2026 10:31:54 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: arnd@arndb.de
Cc: cassel@kernel.org,
	chenchangcheng@kylinos.cn,
	dlemoal@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nikita.shubin@maquefel.me,
	s.shtylyov@omp.ru,
	vkoul@kernel.org
Subject: Re: [PATCH] pata_ep93xx: fix possible NULL pointer dereference in ep93xx_pata_release_dma()
Date: Thu, 16 Jul 2026 10:31:51 +0800
Message-Id: <20260716023151.50144-1-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <64f3ed43-9276-423f-9db6-2270fa9c2192@app.fastmail.com>
References: <64f3ed43-9276-423f-9db6-2270fa9c2192@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>On Wed, Jul 8, 2026, at 11:27, Chen Changcheng wrote:
>>  static void ep93xx_pata_release_dma(struct ep93xx_pata_data *drv_data)
>>  {
>> - if (drv_data->dma_rx_channel) {
>> + if (!IS_ERR_OR_NULL(drv_data->dma_rx_channel)) {
>>  dma_release_channel(drv_data->dma_rx_channel);
>>  drv_data->dma_rx_channel = NULL;
>>  }
>
>If something requires you to use IS_ERR_OR_NULL(), that is usually
>a bad API design, and you should fix this at the place where
>it gets introduced.
>
>Please fix the probe path instead so it doesn't try to use the
>device without a valid channel.
>
>      Arnd

Thanks for the review. 
I agree that IS_ERR_OR_NULL() is not the right
approach. Please drop this patch.

Chen Changcheng
