Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56B4267B9D
	for <linux-ide@vger.kernel.org>; Tue, 25 Feb 2025 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494085; cv=none; b=uacR1hjP9SHMyNW2Gx8tZXEmkni8TGgL65GLsZqaWUKEiJsfwdeENhOFOpaOL83PikrR8weuaAVi14jUcSD5/OTTacat8F+I+OFOYNStqiPya1cSVdY+6Lk0GGXtErYTgZzQpdyAj3Eai97eXq+E6Zhhz/WveZTnz2XcQ8ZG/Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494085; c=relaxed/simple;
	bh=cp5n66VFOUypsal4qc0PnWudImT77kliY100rczEbc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=DDYOEspgm0EGncue/3G5ldwszhkMx79Tz60u38ySwo8ZoYT2ayCJjeo9jYth32nu5KLEIbf+qxgw7CyclUMPV+KkaOqjtEhe+JqZ0mphB9Rawx9b92oxE5BK92Ec0U5u7aYNMvH67IX5c960lN8Gj92uSMH/8ywvb7FZen/l/0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QwFWpC26; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QwFWpC26"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250225143440euoutp010a1d9c1864656d21e3a1dbd9622df548~neiUkT-9R0890208902euoutp018
	for <linux-ide@vger.kernel.org>; Tue, 25 Feb 2025 14:34:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250225143440euoutp010a1d9c1864656d21e3a1dbd9622df548~neiUkT-9R0890208902euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740494080;
	bh=2RRagYtLQr8VkhKtVMnFvFXLXcUU68LYaOqDUSce4w0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=QwFWpC26HK8Cxb02uGdw4i3C+7RIjGQD2VCy6YVl+I+QusfLxnQ4IKmqfi8tdB9pl
	 Gf1eVTgiTqzf8s6Qkf5C0h+67gGBtFz5pi6GfApn3l6c8QnEEm9MkcqK9QxahnW947
	 qxMQoKPwJ5JKCq1d6Mr61PqQlgF9vEfs7kL11Ci8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250225143440eucas1p28b304d3746a8da2bfcdc269aabe6385a~neiUQKR-C2265122651eucas1p2Z;
	Tue, 25 Feb 2025 14:34:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 6A.5E.20821.005DDB76; Tue, 25
	Feb 2025 14:34:40 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250225143439eucas1p2554fab3d44e0ad0865a3ae4c3b361339~neiTozMHP2267722677eucas1p2X;
	Tue, 25 Feb 2025 14:34:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250225143439eusmtrp17fdc9a8e4ffd1d64393f5f5ec284e710~neiToK95B1641316413eusmtrp1t;
	Tue, 25 Feb 2025 14:34:39 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-4e-67bdd500f646
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id EC.D1.19920.FF4DDB76; Tue, 25
	Feb 2025 14:34:39 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250225143439eusmtip22083f0cd03274d6048b9ee1677ff105c~neiS3PO2c2671926719eusmtip2C;
	Tue, 25 Feb 2025 14:34:39 +0000 (GMT)
Message-ID: <1b6d71cd-9ec2-45c5-81ae-4ab69fa5b156@samsung.com>
Date: Tue, 25 Feb 2025 15:34:38 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci: Make ahci_ignore_port() handle empty
 mask_port_map
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>, Josua Mayer <josua@solid-run.com>
Cc: Klaus Kudielka <klaus.kudielka@gmail.com>, linux-ide@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250225141612.942170-2-cassel@kernel.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djPc7oMV/emGzTPULA4NmEFs8WD/fYW
	b45PZ7JYPnkBu8WmZxeYLY7teMTkwOaxc9Zddo9NqzrZPN7vu8rm8a/1MbPH501yAaxRXDYp
	qTmZZalF+nYJXBl/W2cwF+wUr/j19S5LA+NU4S5GTg4JAROJKfc62LsYuTiEBFYwSsx594UJ
	wvnCKPFuchuU85lRYs2pTSwwLRd2n2eFSCxnlFg17xZU/0dGies7XrCDVPEK2Eksb97MCmKz
	CKhKPJhwjAUiLihxcuYTMFtUQF7i/q0ZYPXCAiES578cB5sqIjCFUWJR7yewImYBD4mF3b/Z
	IGxxiVtP5jOB2GwChhJdb7vA4pwCFhLL/7czQ9TISzRvnc0MceoFDolzrUwQtovEyheXoeLC
	Eq+Ob2GHsGUkTk/uYQFZLCHQziix4Pd9JghnAqNEw/NbjBBV1hJ3zv0C2sYBtEFTYv0ufYiw
	o0T70e8sIGEJAT6JG28FIW7gk5i0bTozRJhXoqNNCKJaTWLW8XVwaw9euMQ8gVFpFlKwzELy
	5Swk38xC2LuAkWUVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYOo5/e/4px2Mc1991DvE
	yMTBeIhRgoNZSYSXM3NPuhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeRftb04UE0hNLUrNTUwtS
	i2CyTBycUg1MPpIca/dwr2k7eGDiDGnTgF+MBbt7F5w5tW5+qtZdvxeaJybeTm7M+vbjAl+M
	Z2nmj+sBMhcX1oo8VZt81vgm+4OL7rHhb03L29xUPgmlzuv/k+HC5n2x9QFPp93di5/tPeR3
	azyalC8ot+CUr+Pt20mtyjdPNs3+PFnYIHfTNPcZHzg3vmq+drFRU9Vysr3d3bdPP2pvE926
	baNXg9zPza0ZvJJHlPXdv5WpsVosfvW96B/bpwrGEzN+dZ+Mi/YvuTnx6RW3Z48f+t+4v37j
	ucb5Bd3xhqaxxUy3I/sXCzBl9BnNnZM3UTtK+YBBxqb777cYpitHbV1zeL1nUVnfysfSWgFL
	3vywTdn8/k9UkhJLcUaioRZzUXEiAP1rUQmsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsVy+t/xe7r/r+xNNzh43cDi2IQVzBYP9ttb
	vDk+ncli+eQF7Babnl1gtji24xGTA5vHzll32T02repk83i/7yqbx7/Wx8wenzfJBbBG6dkU
	5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GX8bZ3BXLBT
	vOLX17ssDYxThbsYOTkkBEwkLuw+z9rFyMUhJLCUUWJ+ywtmiISMxMlpDawQtrDEn2tdbBBF
	7xklvvedBiviFbCTWN68GayIRUBV4sGEYywQcUGJkzOfgNmiAvIS92/NYAexhQVCJM5/OQ62
	TURgCqNE09lLYM3MAh4SC7t/Q23oZpSY+uQtG0RCXOLWk/lMIDabgKFE19susDingIXE8v/t
	zBA1ZhJdW7sYIWx5ieats5knMArNQnLILCSjZiFpmYWkZQEjyypGkdTS4tz03GJDveLE3OLS
	vHS95PzcTYzAaNt27OfmHYzzXn3UO8TIxMF4iFGCg1lJhJczc0+6EG9KYmVValF+fFFpTmrx
	IUZTYGhMZJYSTc4HxnteSbyhmYGpoYmZpYGppZmxkjiv2+XzaUIC6YklqdmpqQWpRTB9TByc
	Ug1M6z3Ma31mTTkfepzZXGsOB+PDPScemi+968Ymr3DinoBG5GZrsVquLukKH721TnoMp/+v
	nLriY03D2b++p047Vxx3ELh3ZmvK1aXt9X5fGez73By173zj32Qh+2CfjPec15einUwvBbA/
	O3j1gc4qt8SM9mesAqE7NtRxGQRLnJygVhX+XybgXJDF8dn3J5+vkLx6dvoNJcdS8Y4FqurP
	pfXeqRmmGVd/2hecdaL//OS3Bz5OCT4xWbxGaCHv43t3LLwbSt99mZX88PY88Zq39l+fl2X2
	cXydWX2aPd3P1KKpbPW0XtWdsxJPb1Dd+ttXPskobNZaJgNvv3QpTuHA5NXFk1+1lcvM3xHw
	VDRZiaU4I9FQi7moOBEAUTVS+j8DAAA=
X-CMS-MailID: 20250225143439eucas1p2554fab3d44e0ad0865a3ae4c3b361339
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250225141631eucas1p27bbaae57a4c05ce7d71400dfadc9e94a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250225141631eucas1p27bbaae57a4c05ce7d71400dfadc9e94a
References: <CGME20250225141631eucas1p27bbaae57a4c05ce7d71400dfadc9e94a@eucas1p2.samsung.com>
	<20250225141612.942170-2-cassel@kernel.org>

On 25.02.2025 15:16, Niklas Cassel wrote:
> Commit 8c87215dd3a2 ("ata: libahci_platform: support non-consecutive port
> numbers") added a skip to ahci_platform_enable_phys() for ports that are
> not in mask_port_map.
>
> The code in ahci_platform_get_resources(), will currently set mask_port_map
> for each child "port" node it finds in the device tree.
>
> However, device trees that do not have any child "port" nodes will not have
> mask_port_map set, and for non-device tree platforms mask_port_map will
> only exist as a quirk for specific PCI device + vendor IDs, or as a kernel
> module parameter, but will not be set by default.
>
> Therefore, the common thing is that mask_port_map is only set if you do not
> want to use all ports (as defined by Offset 0Ch: PI – Ports Implemented
> register), but instead only want to use the ports in mask_port_map. If
> mask_port_map is not set, all ports are available.
>
> Thus, ahci_ignore_port() must be able to handle an empty mask_port_map.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Closes: https://lore.kernel.org/linux-ide/10b31dd0-d0bb-4f76-9305-2195c3e17670@samsung.com/
> Co-developed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Fixes: 8c87215dd3a2 ("ata: libahci_platform: support non-consecutive port numbers")
> Fixes: 2c202e6c4f4d ("ata: libahci_platform: Do not set mask_port_map when not needed")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

This fixes the issue I've observed.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   drivers/ata/ahci.h    | 8 ++++++--
>   drivers/ata/libahci.c | 1 +
>   2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index aea30df50c58..b2e0ef4efbdc 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -386,8 +386,12 @@ struct ahci_host_priv {
>   static inline bool ahci_ignore_port(struct ahci_host_priv *hpriv,
>   				    unsigned int portid)
>   {
> -	return portid >= hpriv->nports ||
> -		!(hpriv->mask_port_map & (1 << portid));
> +	if (portid >= hpriv->nports)
> +		return true;
> +	/* mask_port_map not set means that all ports are available */
> +	if (!hpriv->mask_port_map)
> +		return false;
> +	return !(hpriv->mask_port_map & (1 << portid));
>   }
>   
>   extern int ahci_ignore_sss;
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index fdfa7b266218..e7ace4b10f15 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -541,6 +541,7 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>   		hpriv->saved_port_map = port_map;
>   	}
>   
> +	/* mask_port_map not set means that all ports are available */
>   	if (hpriv->mask_port_map) {
>   		dev_warn(dev, "masking port_map 0x%lx -> 0x%lx\n",
>   			port_map,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

