Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223F12F617D
	for <linux-ide@vger.kernel.org>; Mon, 24 Nov 2025 09:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975616; cv=none; b=pw0cERROfZs5X8REzXAoux5/dJCsnq2FSgKvPCcQTkNNbIoStgqKcwxG+2EI7rkwHzIyyeXjPYRHpQeuZl2Df9G+c9uwxE6GuEm3qmgXOY5YU8FBrZmcd3Y4QT2OZDuzDYeIfDPkgSnOa4JyxpoVCIL1DEFZ0k3bWv89uuH2n+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975616; c=relaxed/simple;
	bh=BhJWl1lvmlsycxKq3a504/hVmZ96s5ywQgvm19C1+/w=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JH0AAxn1U7Apt5e7cdd7ZpqHTxpoj7RW87TCyAD3CJnQ6MC0WxjTzhCG6P4Tnl4v5Kklp3IEwbOCcEw7TYJwL0oc74POd3x2dnIJ6yNpv/B8eXIfF+dy92JpBuHYL4OjO1v/lLP458DsiEjWMnq9lxsp/XHgK/SXqLiwFxFSIkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=VkzeN/3s; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="VkzeN/3s"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Y6jOaMHRJj/PZKQdO3z8YNNSVYVnOAEmpWZauj86tZQ=;
	b=VkzeN/3sSRCf0Fl6c8DGX8OD2xYb1ShO0GcpHuHf072GNvmYJe/bqPdzJGE5O1We42Ge8RPXM
	2ZosZcni/ctObI/kfu9zBxscCWrDj7XL9k/0guS61H2sNEc16zeOoTkvyIwbhzceb0eLXG9e6hx
	Jgn9YhLPvaIp+B6lICV1Cao=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dFKnk0yCrzRhR7;
	Mon, 24 Nov 2025 17:11:38 +0800 (CST)
Received: from kwepemh200005.china.huawei.com (unknown [7.202.181.112])
	by mail.maildlp.com (Postfix) with ESMTPS id C0234180484;
	Mon, 24 Nov 2025 17:13:24 +0800 (CST)
Received: from [10.67.120.126] (10.67.120.126) by
 kwepemh200005.china.huawei.com (7.202.181.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 24 Nov 2025 17:13:24 +0800
Subject: Re: [bug report] ata: ahci: IO error with the default
 med_power_with_dipm
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>, Niklas Cassel
	<cassel@kernel.org>
References: <20251121073502.3388239-1-liyihang9@h-partners.com>
 <aSB0ilF_cI5PS8M0@ryzen> <eb6411bf-141f-47a8-bf73-a9f669399c6a@kernel.org>
CC: <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>, <linuxarm@huawei.com>,
	<liuyonglong@huawei.com>, Yihang Li <liyihang9@h-partners.com>
From: Yihang Li <liyihang9@h-partners.com>
Message-ID: <67d02c58-e0d1-a078-e412-cf670326d569@h-partners.com>
Date: Mon, 24 Nov 2025 17:13:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <eb6411bf-141f-47a8-bf73-a9f669399c6a@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemh200005.china.huawei.com (7.202.181.112)

Hi Mario,

On 2025/11/21 22:29, Mario Limonciello (AMD) (kernel.org) wrote:
> 
> 
> It would be ideal to please reproduce on a mainline kernel if you haven't already.
> 
> Also; just to confirm did you reach this result with a bisect?  Or did you encounter this issue with a mainline kernel?
> .
> 

I am using the latest mainline kernel version, linux 6.18.0-rc6 with commit 8b690556d8fe.

By using a bisect method, I found that the issue occurs after merging commit 5433f0e7427ae ("ata: Kconfig: Update
SATA_MOBILE_LPM_POLICY default to med_power_with_dipm").

Thanks,
Yihang
