Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F91126C18
	for <linux-ide@vger.kernel.org>; Tue, 25 Feb 2025 14:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493466; cv=none; b=RbkLpZyQpKJqgh4V0vOtH1sem2HYZggsfJIquHzeWSPId9DXsXerQTHTejd7kc9A3AtgSvo0f6kvFuUMuZ6HqY1BhmY7MHLmXY4mFE+6GzjHwt+UKcw1Dp2K0ETkILT2QFaSGQYCZmbRpbtjhbVwufjUaFyGHuh9wTfzSEEdReU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493466; c=relaxed/simple;
	bh=yMpQIDf7jQLdoKX5Dh3Qz24PYCI5Lsg2Zsi/L8pNA5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbUUz8t0dfBmbYkNwX3SGkM0tiG6FE8VFegk7636QMhlKYTsAekjlcEeXJyrGZ65H/pSdulZD9m5u+//+Q2DCfZrotypaC21afzYdaoK63A+9XNujLj49eOXHKwAemR0ttdfDnr6MNcv32ZzGLZ0YwysciWuiqlhEVL5XeBhFT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvU8ReCw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvU8ReCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459B2C4CEDD;
	Tue, 25 Feb 2025 14:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740493465;
	bh=yMpQIDf7jQLdoKX5Dh3Qz24PYCI5Lsg2Zsi/L8pNA5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gvU8ReCwPtNUYQIOM41fKWWw/3mwvzW5AtZkgGL3Axa2hMKSSHmjDdq1vrdHkQAfU
	 Am88WF9kO2pvxCA/yo262CsCIEOI1PDGUVtSGCO27P34HU14Ph1O7mCqgFquW1pjlP
	 haJK09yLmZAv87/qQ7R48/Tag6QlMlkPCHtRoiRtM6mHWGJ/5uIxGV5wNagOp5w/RD
	 ypLAVWICcybtQWxg9a0AqyqO2kSnq5tH853AA5F43eZ2nJAdzB4J0ANBr42lpbtnCY
	 NpmQwUNOjLTm+fwqC8WVI79aUlVFdjvazgdRq8wIvTuY8pKeuwMpATW+EDelPcFQX2
	 XAPj5m/GJHjjg==
Date: Tue, 25 Feb 2025 15:24:21 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	Klaus Kudielka <klaus.kudielka@gmail.com>,
	Josua Mayer <josua@solid-run.com>
Subject: Re: [PATCH v2] ata: libahci_platform: Do not set mask_port_map when
 not needed
Message-ID: <Z73SlTkfI2sKPXab@ryzen>
References: <20250207232915.1439174-1-dlemoal@kernel.org>
 <CGME20250225093429eucas1p2ea23b1831e33fcae6e58a7c6ba574232@eucas1p2.samsung.com>
 <10b31dd0-d0bb-4f76-9305-2195c3e17670@samsung.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10b31dd0-d0bb-4f76-9305-2195c3e17670@samsung.com>

Hello Marek,

On Tue, Feb 25, 2025 at 10:34:27AM +0100, Marek Szyprowski wrote:
> with the $subject patch reverted:
> 
> [    0.938268] libata version 3.00 loaded.
> [    2.283918] ahci-dwc 122f0000.sata: supply ahci not found, using 
> dummy regulator
> [    2.290714] ahci-dwc 122f0000.sata: supply phy not found, using dummy 
> regulator
> [    2.298064] ahci-dwc 122f0000.sata: supply target not found, using 
> dummy regulator
> [    2.312275] ahci-dwc 122f0000.sata: forcing port_map 0x0 -> 0x1
> [    2.316847] ahci-dwc 122f0000.sata: masking port_map 0x1 -> 0x1
> [    2.322791] ahci-dwc 122f0000.sata: AHCI vers 0001.0300, 32 command 
> slots, 6 Gbps, platform mode
> [    2.331464] ahci-dwc 122f0000.sata: 1/1 ports implemented (port mask 
> 0x1)
> [    2.338258] ahci-dwc 122f0000.sata: flags: ncq sntf pm led clo only 
> pmp pio slum part ccc apst
> [    2.359896] ata1: SATA max UDMA/133 mmio [mem 0x122f0000-0x122f01fe] 
> port 0x100 irq 101 lpm-pol 0
> [    2.687374] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    2.744673] ata1.00: HPA detected: current 117229295, native 117231408
> [    2.757119] ata1.00: ATA-8: Corsair CSSD-F60GB2, 1.1, max UDMA/133
> [    2.772062] ata1.00: 117229295 sectors, multi 1: LBA48 NCQ (depth 32)
> [    2.834520] ata1.00: configured for UDMA/133

Could you please test this patch:
https://lore.kernel.org/linux-ide/20250225141612.942170-2-cassel@kernel.org/T/#u
and see if it helps.


Kind regards,
Niklas
