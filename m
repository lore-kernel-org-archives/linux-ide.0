Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823571A0BF3
	for <linux-ide@vger.kernel.org>; Mon,  7 Sep 2026 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776910; cv=none; b=oPswNzwMh7VMF2yYJH/rhyHTkwRineImEbpVQz3fLWambIpDNIjNVBfnPyh07MW1fYKjG3H1G9Y7nXhLBR/ENI5dXfThl3iOxqq8yKmmZU/EI0Jo0wdaJpgww0zsvNBXAC7fuh1qs1PBHLUJl78bpjeDl1PdYHfw1mlx42VCsXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776910; c=relaxed/simple;
	bh=rHP8qJHLRiyZ50UWTys8y/pKgCB0FhAjy2/7o2DU4kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2qnwbo8KqKXUlMACViW73yfbsFk1eXLKJkroUtatoeMEb+wdoEeCCriJ4Va+LBFp2XsXi2jDNqJgg3Djw9dVXGV/0de+SDjRX6KnMyuruuDRB2m6yZl4J78SIcbFCFZ5R2C06uBl77qePlseIqwOCUaPx1QYNd6GAZXXzVQxG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WH3euKCw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WH3euKCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0EE1F00A3D;
	Mon,  7 Sep 2026 10:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788776909;
	bh=fTFBwJe8z5HD+mydoN8a+5j/S2ositrTiZG5gjHEHPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WH3euKCwg5cIX5LHRKwpbb261AGoXUs9farQoJG4MCJNlW9Zsw16ERvD/3n5zYpbh
	 HhU5oTylleYvtEIlm7NaPIXQrDOyNCHslkAQl0RslkOQjH0IIAy5Nk2WHaUqjLqR8I
	 UJKhGU4pm78P5o66It4qp/nGhggI0pecWANCBP+e+igN08uw2O0iYewLYjgGXE1PpT
	 ti7qM4dxgqhcxL1H+wKU1ksikJ/Dch/xOY6lG1nltiRX3nWC4iuC7gy8XNQhLbSTyU
	 G4FA+k5CFAwgpahq0EeIMDsWMAxl1dN/OThOUJU2+Dy3mgzExLKvf4RISp4jzOW6IY
	 8tUb8LHlR8uhg==
Date: Mon, 7 Sep 2026 12:28:24 +0200
From: Niklas Cassel <cassel@kernel.org>
To: snoep <snoepke@live.nl>
Cc: "alvinwylim@gmail.com" <alvinwylim@gmail.com>,
	"artmoty@gmail.com" <artmoty@gmail.com>,
	"david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
	"kernel@wantstofly.org" <kernel@wantstofly.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"mario.limonciello@amd.com" <mario.limonciello@amd.com>,
	"mikael1022bzh@gmail.com" <mikael1022bzh@gmail.com>,
	"roland.waltersson@netinsight.net" <roland.waltersson@netinsight.net>
Subject: Re: [PATCH] ahci: force 32-bit DMA for JMicron JMB582/JMB585
Message-ID: <ap6RyP28fxXNjRWS@ryzen>
References: <AM8P193MB2659454F98AD53DEB002CF8AA9B42@AM8P193MB2659.EURP193.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM8P193MB2659454F98AD53DEB002CF8AA9B42@AM8P193MB2659.EURP193.PROD.OUTLOOK.COM>

Hello Sven,

On Sat, Sep 05, 2026 at 09:04:57PM +0000, snoep wrote:
> So I was unable to reproduce the corruption on this Raspberry Pi 5
> with either the normal 64-bit DMA configuration or the Raspberry Pi
> 32-bit PCIe DMA overlay.
> 
> Again, since this JMB585 has no IOMMU group, I do not consider this a
> test of the Intel/ARM IOMMU enforcing-mode case.

Thank you for your testing!

Considering that Rasberry Pi seems to hand out 64-bit PCI addresses by
default, which is why they even have the (from JMB585's point of view)
completely meaningless pcie-32bit-dma-pi5 DT overlay.

Considering that you could run the reproducer for several iterations
without any issues, I am confident that JMB585 does indeed handle
64-bit DMA addresses perfectly fine, and we will drop the JMB585 quirk
as soon as there is fix for the AMD IOMMU issue.


> 
> However, I am still trying to determine what caused the repeated EXT4
> metadata corruption in the original RAID1 setup, and I would appreciate
> guidance on what would be most useful to test next.
> 
> Would repeating a sustained checksumming workload with the original
> two-SSD md RAID1 setup be useful, or is there another workload, tracing
> option, kernel configuration or test that would better help distinguish
> between the JMB585/PCIe path, md RAID1, EXT4, or another component?

I have no idea why you saw corruption on ext4 using 6.12.75+rpt-rpi-2712
downstream kernel.

Considering that they seem okay with carrying dirty workarounds for issues
for several months, that they don't even bother reporting to upstream, I
would strongly recommend running an upstream kernel instead.


I did see some reports from people that the JMB585 could overheat:
https://github.com/geerlingguy/raspberry-pi-pcie-devices/issues/354
https://forums.truenas.com/t/jmb585-m-2-to-sata-card-doesnt-see-ssd/8231

If you don't have a heatsink, perhaps it could be something to try.


Kind regards,
Niklas
