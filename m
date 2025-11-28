Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20D22900A8
	for <linux-ide@vger.kernel.org>; Fri, 28 Nov 2025 02:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764298470; cv=none; b=ZJhQz5PFPOJz3X9m/zTdlOIcxREC3s1z5mSGDgxCcNu2hFs1QvyHpYKVWkZJNZL0EDySrkDl+E64DUlCvqlyFpCQG3Ewlnc4q018KZIfsiIKHad9u9jPCbqpuah/AwzNOHOn9w9fOaZj1vec3rWQ01N3rr1LYEYWI/mYcrmuQTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764298470; c=relaxed/simple;
	bh=EqSk2/IFuIbNI0nyCeChaVTw+BUa3mItX/lH1eWkqEc=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rn+x0OG6KiSP58tiU50p41sJ/+tDUf8ppP3UCx8ptRsoCSFYe8s5wJkV/CXI9jcOLiNcQOUtFgHUORN7Ao8IcShr69pbfJSp5gx7PZolxEQRP9mtQ+muFrsSaGuc9frWXM2twt+63VmXl2CIor1h1hKye/olt4VXuepxqx+UDqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=FT+3sX8Y; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="FT+3sX8Y"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cqLQRW1aXHA4VvwSa/OWtydtCKERso2nQjqfTt89aCM=;
	b=FT+3sX8YddWwczC9fX8h1TpQe3RnTd3ch0qtHfuoDrEmI2kmM/R50NiExJQklMmAfAH4KCfyk
	O9Yvj3siEC8TU+64+kKbFgTNoeYHeQ114Vgqo4BvAmuG/v+4R2dQc0LaCTWsQbbU7pXd+i7Z06X
	RPlK2pfbU+Fcq/86ESc9a4Y=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dHd9n4kBcznTXP;
	Fri, 28 Nov 2025 10:51:57 +0800 (CST)
Received: from kwepemh200005.china.huawei.com (unknown [7.202.181.112])
	by mail.maildlp.com (Postfix) with ESMTPS id 222E8140275;
	Fri, 28 Nov 2025 10:54:22 +0800 (CST)
Received: from [10.67.120.126] (10.67.120.126) by
 kwepemh200005.china.huawei.com (7.202.181.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Nov 2025 10:54:21 +0800
Subject: Re: [PATCH] ata: libata-core: Disable LPM on Silicon Motion
 MD619HXCLDE3TC
To: Niklas Cassel <cassel@kernel.org>
References: <20251124163433.3082331-2-cassel@kernel.org>
 <8850d82e-6818-b67f-9acb-cdfe78b7cedd@h-partners.com>
 <aSWgnwVzGDAqPf0i@ryzen>
 <5c2c5cbd-b13c-8ba1-86c8-670f0a34fcf3@h-partners.com>
 <aSbs7HOYr_8waEZZ@ryzen>
CC: Damien Le Moal <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>, Yihang
 Li <liyihang9@h-partners.com>
From: Yihang Li <liyihang9@h-partners.com>
Message-ID: <479136e6-12d1-7593-bedd-e11b53063a3b@h-partners.com>
Date: Fri, 28 Nov 2025 10:54:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aSbs7HOYr_8waEZZ@ryzen>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemh200005.china.huawei.com (7.202.181.112)



On 2025/11/26 20:05, Niklas Cassel wrote:
> Well, it should be sufficient that they support either HIPM and DIPM.
> 
> Ideally, they should support the same as:
> MD619HXCLDE3TC and MD619GXCLDE3TC.
> (Not sure if they supported HIPM and DIPM or only one of them).
> 
> But the device should work fine to read / write / mount, etc. without showing
> the same errors as you got with MD619HXCLDE3TC and MD619GXCLDE3TC.
> 

I found an SSD that supports DIPM and connected it to my AHCI controller for testing:
ata7.00: Features: DIPM NCQ-sndrcv

And it did not show the same errors as MD619HXCLDE3TC and MD619GXCLDE3TC.
So, I think we can confirm that the issue is not with the AHCI controller.

Thanks,
Yihang
