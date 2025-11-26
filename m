Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCF03191DC
	for <linux-ide@vger.kernel.org>; Wed, 26 Nov 2025 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146896; cv=none; b=QztJ+jejRPqOLgS0C+DnhL4idPYTDzjKOcFTgiJ3wO39Omx3Bj+P97bc4xOq/FHHfgPyYD7exg75YXyt00Di7IaMxmkP62yWa4JL+PuQNgMwXOWAS+tK/KSPKRCqBcHVn0OFlN77wziGb5H/GK/v2QKrHsn+UorJOtZGIiwsQLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146896; c=relaxed/simple;
	bh=mcphvo5d6J1+45FsztQ5nqhlqIXysZ8t16lZgr2Fa24=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mPw6Mt97w5ngDuQTi8F2XuumiqgOyW04b4O0Q2ZvNxPFyN2W+isxRlxERGS7NK7cKyxK/CBw19/RTkWsY39J26jknk4XeSsW+mpTJMjEtkB3h/8hYf0Bs+mKf8BRRl44qE1OXsr+0gPjyuhQj/rCJO13y7ivndBuLpTnQX9ofqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=d3gcwxvk; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="d3gcwxvk"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GYbtJxP4t/WIHvfSmzuGV0hzybR3Kyo8my2I7qPrPzU=;
	b=d3gcwxvkK+OCAOLGkla0NZCUzbxIr3CG/tbnQG1y99hfFU4xXXR2M+Abjn6dwr0cQOWcU+xRm
	ZETb0X6JLiBaB325n2IPb3nLzOEKab8pUOmtsymNQi8T99M6pDI5NMY4dDq5QoFOTnUwdS2+joF
	mGST38pA5ZX35L2IxW3fAxY=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dGY7G6rNzzpT18;
	Wed, 26 Nov 2025 16:46:02 +0800 (CST)
Received: from kwepemh200005.china.huawei.com (unknown [7.202.181.112])
	by mail.maildlp.com (Postfix) with ESMTPS id 2814B1401E0;
	Wed, 26 Nov 2025 16:48:10 +0800 (CST)
Received: from [10.67.120.126] (10.67.120.126) by
 kwepemh200005.china.huawei.com (7.202.181.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 26 Nov 2025 16:48:09 +0800
Subject: Re: [PATCH] ata: libata-core: Disable LPM on Silicon Motion
 MD619HXCLDE3TC
To: Niklas Cassel <cassel@kernel.org>
References: <20251124163433.3082331-2-cassel@kernel.org>
 <8850d82e-6818-b67f-9acb-cdfe78b7cedd@h-partners.com>
 <aSWgnwVzGDAqPf0i@ryzen>
CC: Damien Le Moal <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>, Yihang
 Li <liyihang9@h-partners.com>
From: Yihang Li <liyihang9@h-partners.com>
Message-ID: <5c2c5cbd-b13c-8ba1-86c8-670f0a34fcf3@h-partners.com>
Date: Wed, 26 Nov 2025 16:48:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aSWgnwVzGDAqPf0i@ryzen>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemh200005.china.huawei.com (7.202.181.112)

Hi Niklas,

On 2025/11/25 20:27, Niklas Cassel wrote:
> Ok, really nice that we have a patch that fixes your problem.
> 
> However, like I wrote in the comment section:
> 
> Before we apply this patch, it would be nice if you could try another SSD,
> that supports LPM (HIPM and DIPM) with your AHCI controller:
> Huawei Technologies Co., Ltd. HiSilicon AHCI HBA [19e5:a235] (rev 30)
> 
> Note: You can see if your drive supports HIPM and DIPM from the
> ata_dev_print_features() print to dmesg during boot, e.g.:
> ata6.00: Features: Trust Dev-Sleep HIPM DIPM NCQ-sndrcv NCQ-prio
> 
> Just so we can verify that it is the MD619HXCLDE3TC SSD that is not
> handling LPM correctly, and that it is not the AHCI HBA that is at fault.
> 
> E.g. there have been some weird bugs with this AHCI controller before,
> see e.g. 234e6d2c18f5 ("ata: ahci: Disable SXS for Hisilicon Kunpeng920").
> 
> 
> 
> Do you have any other drive, other than MD619HXCLDE3TC and MD619GXCLDE3TC,
> which supports LPM, and you can see that the drive works as intended,
> with LPM enabled, so we can be certain that it is not the HBA that has
> broken LPM support?
> 

I checked all the drives I own, but unfortunately, none of them support LPM (HIPM and DIPM).
:(

Thanks,
Yihang
