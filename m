Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915772627FB
	for <linux-ide@vger.kernel.org>; Tue, 25 Feb 2025 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476080; cv=none; b=YSR5M3DlioVQCJJBMStfxdcSxyotzSPWrbRjm8sY8YY837OEskFVFvIDFQSwUkzbb8IZ4IpOXdfqC+bhZvUeHpG5N2LX/cbwk6B+szMkfL4+tCtwmRFxdvZgDV81ehZf6ocukIsQ95JdUuES0ZmWQlLcFmjnk3CE/yvZfU7Yzyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476080; c=relaxed/simple;
	bh=nSduoX/jrmZAV60iVnQhsrUsGsOkY4vk9BXzZHHTAeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=jdc8I2G25LXixpZ3Dg0ropPzEme/xB9UI9czZSHXpfKnzgjy2pfUTqMSdsXVWM+rBIRNSUaXbenCjCSu4jcu1i/7V2soO7Yk9wpgOy7lx+vC8tB0JeUKHi2hmQDR6it2tChwEUcyvAwijhJ3HTW65BnMDr1AEbyEVma42CrFmgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EfTUoxc1; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EfTUoxc1"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250225093430euoutp016705ce88a88c3774cf256f54986db7a2~nacO6MszG2472824728euoutp01T
	for <linux-ide@vger.kernel.org>; Tue, 25 Feb 2025 09:34:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250225093430euoutp016705ce88a88c3774cf256f54986db7a2~nacO6MszG2472824728euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740476070;
	bh=nhK3+rOLNvNMYVXNrzByNDFoDInCes//O8zWEgD0Tfs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=EfTUoxc1TU782YexRkPSoKUIn8OtpD6JpBGl8fVZTK5qmbEEshJp89ztCKXzkD5oe
	 354kq2f8XqeHgT0NszReuasGsXz9oaVC2uGZ5jgmTB9bl2d/np7ccbVHZdQf3dHBS6
	 mniE937TMw+2b8iSUxj4VDIvOteEB/anF9Qjs40k=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250225093430eucas1p13d345866c39b9d4624875a582743d199~nacOuiM8i2101721017eucas1p16;
	Tue, 25 Feb 2025 09:34:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 61.A7.20409.5AE8DB76; Tue, 25
	Feb 2025 09:34:30 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250225093429eucas1p2ea23b1831e33fcae6e58a7c6ba574232~nacOVJO-71062010620eucas1p2W;
	Tue, 25 Feb 2025 09:34:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250225093429eusmtrp2300d76d20e18e9a7051e235ba97c89f3~nacOUhvBj2489624896eusmtrp2y;
	Tue, 25 Feb 2025 09:34:29 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-06-67bd8ea5ea4a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 89.1C.19920.5AE8DB76; Tue, 25
	Feb 2025 09:34:29 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250225093429eusmtip1da3ec206c7fb8bc4b1e6d0b4cb3640f0~nacNrZVK_1564815648eusmtip1H;
	Tue, 25 Feb 2025 09:34:29 +0000 (GMT)
Message-ID: <10b31dd0-d0bb-4f76-9305-2195c3e17670@samsung.com>
Date: Tue, 25 Feb 2025 10:34:27 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libahci_platform: Do not set mask_port_map when
 not needed
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, Niklas
	Cassel <cassel@kernel.org>
Cc: Klaus Kudielka <klaus.kudielka@gmail.com>, Josua Mayer
	<josua@solid-run.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250207232915.1439174-1-dlemoal@kernel.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduzned1lfXvTDWYfY7I4NmEFs8WD/fYW
	yycvYLfY9OwCs8WxHY+YHFg9ds66y+6xaVUnm8e/1sfMHp83yQWwRHHZpKTmZJalFunbJXBl
	XJ7ZzFLQrlWx9U0nUwPjQ6UuRk4OCQETiTULNjN1MXJxCAmsYJRoPf8PyvnCKPH01w02COcz
	o8SMC6dZYFpmLLjMDJFYzijxrG81K4TzkVHi86snzCBVvAJ2Eq0f3oDZLAKqEkvOTmCEiAtK
	nJz5BGySqIC8xP1bM9hBbGGBSImdC78D1XBwiAikS1xq9QcJMwsESdx5eIQZwhaXuPVkPhOI
	zSZgKNH1tosNxOYUsJI4eeQLG0SNvETz1tlgx0kInOCQmNQNkZAQcJH48LcbyhaWeHV8CzuE
	LSPxf+d8JoiGdkaJBb/vQzkTGCUant9ihKiylrhz7hcbyHXMApoS63fpQ4QdJXad3gB2tIQA
	n8SNt4IQR/BJTNo2nRkizCvR0SYEUa0mMev4Ori1By9cYp7AqDQLKVRmIXlzFpJ3ZiHsXcDI
	sopRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMwyZz+d/zLDsblrz7qHWJk4mA8xCjBwawk
	wsuZuSddiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+i/a3pQgLpiSWp2ampBalFMFkmDk6pBqZi
	6z1nv08taFLkOh0eWPOJzYWvdnP6C9tnvGlPz176wXg9uCxza9/vkK0fTt5qT4w5fdXw8Ikr
	HXzTucXmfI5cJH2n5Py39ZOfLrVeznS5vcZa114o5vvjqmw2ve+CGTyTf3/d1fc+07w35fjZ
	3oZJM/3ZlLVmmb9PNGfbvmRP+Q2R+llZvi/9eN4XMzftLQ9QnPtffueSmPZFpTvqDnIZJ6yY
	OO8sZ+STU29u3faIfV9z80HFmYnzT/AY5kt6ukd9F9f5pGJqImTssWmx/tlLX6xONu4w2O5V
	ueGRYo3LZ4O3dSHPpnPt8ma81cpW5n5K4W2uJ2Pq7ftfbTW3MEWJytsvsDVeNKN0oe22NUuV
	WIozEg21mIuKEwFAHNtUoQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xu7pL+/amG/zfrWFxbMIKZosH++0t
	lk9ewG6x6dkFZotjOx4xObB67Jx1l91j06pONo9/rY+ZPT5vkgtgidKzKcovLUlVyMgvLrFV
	ija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLuDyzmaWgXati65tOpgbGh0pd
	jJwcEgImEjMWXGbuYuTiEBJYyiix48x0ZoiEjMTJaQ2sELawxJ9rXWwQRe8ZJWY0LGQCSfAK
	2Em0fngD1sAioCqx5OwERoi4oMTJmU9YQGxRAXmJ+7dmsIPYwgKREjsXfgeq4eAQEUiXaFqR
	BhJmFgiSeLNzCVirkIClxNsdyxkh4uISt57MB1vFJmAo0fUW5AZODk4BK4mTR76wQdSYSXRt
	7YKql5do3jqbeQKj0CwkV8xCMmoWkpZZSFoWMLKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93E
	CIypbcd+bt7BOO/VR71DjEwcjIcYJTiYlUR4OTP3pAvxpiRWVqUW5ccXleakFh9iNAUGxURm
	KdHkfGBU55XEG5oZmBqamFkamFqaGSuJ87pdPp8mJJCeWJKanZpakFoE08fEwSnVwOTd9Xh3
	sz6bsmzT1Ddim7R3FtWbJD259/QC9/XWqpua+04vONJ656ba3oOdfNtTIzg82MrFnrUEJE3a
	dMrrjf6MaUc8slgefTwqrcFSJ2RR/ZO/+Fr8VV/fGzm1zCGzuf4p77U9zLJ00ZTdcvLnEldq
	zzSvmPT8+cQ+l3cGGzNv9sVxf7V/d8zeVHD7e1dugf/zBLXEOE9vWPqV93+UYEVOgYWCfH1o
	XoD7j2Pb9F9f4ngt+11NYs2NXQ6X84115ZP717SI/7Dd1/P8wtMdm1/xFzrxhS3UdfjOvcv9
	1IN9x5nmdFjPFL5rs+3f7hJdj12cPfsZJ2Vr3dPont30aclsRolNOz0vf13L3rj/xBwlluKM
	REMt5qLiRACltRwAMgMAAA==
X-CMS-MailID: 20250225093429eucas1p2ea23b1831e33fcae6e58a7c6ba574232
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250225093429eucas1p2ea23b1831e33fcae6e58a7c6ba574232
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250225093429eucas1p2ea23b1831e33fcae6e58a7c6ba574232
References: <20250207232915.1439174-1-dlemoal@kernel.org>
	<CGME20250225093429eucas1p2ea23b1831e33fcae6e58a7c6ba574232@eucas1p2.samsung.com>

Hi Damien,

On 08.02.2025 00:29, Damien Le Moal wrote:
> Commit 8c87215dd3a2 ("ata: libahci_platform: support non-consecutive
> port numbers") modified ahci_platform_get_resources() to allow
> identifying the ports of a controller that are defined as child nodes of
> the controller node in order to support non-consecutive port numbers (as
> defined by the platform device tree).
>
> However, this commit also erroneously sets bit 0 of
> hpriv->mask_port_map when the platform devices tree does not define port
> child nodes, to match the fact that the temporary default number of
> ports used in that case is 1 (which is also consistent with the fact
> that only index 0 of hpriv->phys[] is initialized with the call to
> ahci_platform_get_phy(). But doing so causes ahci_platform_init_host()
> to initialize and probe only the first port, even if this function
> determines that the controller has in fact multiple ports using the
> capability register of the controller (through a call to
> ahci_nr_ports()). This can be seen with the ahci_mvebu driver (Armada
> 385 SoC) with the second port declared as "dummy":
>
> ahci-mvebu f10a8000.sata: masking port_map 0x3 -> 0x1
> ahci-mvebu f10a8000.sata: AHCI vers 0001.0000, 32 command slots, 6 Gbps, platform mode
> ahci-mvebu f10a8000.sata: 1/2 ports implemented (port mask 0x1)
> ahci-mvebu f10a8000.sata: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs
> scsi host0: ahci-mvebu
> scsi host1: ahci-mvebu
> ata1: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] port 0x100 irq 40 lpm-pol 0
> ata2: DUMMY
>
> Fix this issue by removing setting bit 0 of hpriv->mask_port_map when
> the platform device tree does not define port child nodes.
>
> Reported-by: Klaus Kudielka <klaus.kudielka@gmail.com>
> Fixes: 8c87215dd3a2 ("ata: libahci_platform: support non-consecutive port numbers")
> Tested-by: Klaus Kudielka <klaus.kudielka@gmail.com>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

This patch landed yesterday in linux-next as commit 2c202e6c4f4d ("ata: 
libahci_platform: Do not set mask_port_map when not needed"). 
Unfortunately it breaks SATA operation on legacy ARM Exynos5250 Arndale 
board (arch/arm/boot/dts/samsung/exynos5250-arndale.dts). I wonder if 
this patch is really correct as if I understand code correctly, it 
disables support for any legacy of-based, single port.

Here is the log from that board:

[    0.937868] libata version 3.00 loaded.
[    2.322611] ahci-dwc 122f0000.sata: supply ahci not found, using 
dummy regulator
[    2.329389] ahci-dwc 122f0000.sata: supply phy not found, using dummy 
regulator
[    2.336745] ahci-dwc 122f0000.sata: supply target not found, using 
dummy regulator
[    2.344254] ahci-dwc 122f0000.sata: forcing port_map 0x0 -> 0x1
[    2.349517] ahci-dwc 122f0000.sata: AHCI vers 0001.0300, 32 command 
slots, 6 Gbps, platform mode
[    2.358128] ahci-dwc 122f0000.sata: 1/1 ports implemented (port mask 
0x1)
[    2.364921] ahci-dwc 122f0000.sata: flags: ncq sntf pm led clo only 
pmp pio slum part ccc apst
[    2.385620] ata1: SATA max UDMA/133 mmio [mem 0x122f0000-0x122f01fe] 
port 0x100 irq 101 lpm-pol 0
[    2.716379] ata1: SATA link down (SStatus 0 SControl 300)

with the $subject patch reverted:

[    0.938268] libata version 3.00 loaded.
[    2.283918] ahci-dwc 122f0000.sata: supply ahci not found, using 
dummy regulator
[    2.290714] ahci-dwc 122f0000.sata: supply phy not found, using dummy 
regulator
[    2.298064] ahci-dwc 122f0000.sata: supply target not found, using 
dummy regulator
[    2.312275] ahci-dwc 122f0000.sata: forcing port_map 0x0 -> 0x1
[    2.316847] ahci-dwc 122f0000.sata: masking port_map 0x1 -> 0x1
[    2.322791] ahci-dwc 122f0000.sata: AHCI vers 0001.0300, 32 command 
slots, 6 Gbps, platform mode
[    2.331464] ahci-dwc 122f0000.sata: 1/1 ports implemented (port mask 
0x1)
[    2.338258] ahci-dwc 122f0000.sata: flags: ncq sntf pm led clo only 
pmp pio slum part ccc apst
[    2.359896] ata1: SATA max UDMA/133 mmio [mem 0x122f0000-0x122f01fe] 
port 0x100 irq 101 lpm-pol 0
[    2.687374] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.744673] ata1.00: HPA detected: current 117229295, native 117231408
[    2.757119] ata1.00: ATA-8: Corsair CSSD-F60GB2, 1.1, max UDMA/133
[    2.772062] ata1.00: 117229295 sectors, multi 1: LBA48 NCQ (depth 32)
[    2.834520] ata1.00: configured for UDMA/133


> ---
> Changes from v1:
>   - Improved commit message (fixed typos, added example and removed
>     cc-stable tag).
>
>   drivers/ata/libahci_platform.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 53b2c7719dc5..91d44302eac9 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -651,8 +651,6 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>   		 * If no sub-node was found, keep this for device tree
>   		 * compatibility
>   		 */
> -		hpriv->mask_port_map |= BIT(0);
> -
>   		rc = ahci_platform_get_phy(hpriv, 0, dev, dev->of_node);
>   		if (rc)
>   			goto err_out;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

