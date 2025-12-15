Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C05923AE87;
	Mon, 15 Dec 2025 06:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765781256; cv=none; b=F1Wt+icRPSgMVN6YbiIPu6OfnyACqKMbAd4lHZ1bU/0/b7etKJukEM7qap7s1q1VVKOsW+jTO83PqmTa65UIJ1v1WsivKuSJYsKpgwuMHvewN3/spp6jT5WysDFcwEplEuXZjyNArYgXJ+fE4k1KLHCvYeb/luMIi7Q14nqJLKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765781256; c=relaxed/simple;
	bh=QbZDeielAT/7MonO7SqhnIm+38TaXu7Dq5ciEvhzlY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSzwii9qMuq4jPcAxN0QruTS2aqy8Ni6hee6262zURE7+PjeNWLc0gdWVeS+NVOGl4VEO7kjibZYmIpzCIb2t6u6AvoYgv2LzHkIVavjpSrKeg40NUtsBb1UFpFXk5dTH1FZ1HB5vtBSbb9dWysHEOof/vpfV94CCPNzJaEAb88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJyvko0C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJyvko0C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677AAC4CEF5;
	Mon, 15 Dec 2025 06:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765781256;
	bh=QbZDeielAT/7MonO7SqhnIm+38TaXu7Dq5ciEvhzlY8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KJyvko0Colmzf5Gf6FPfhYg12bw3bDKLEtlA3Zb1ZYXPLQPkVwUge+jCtRSHBDd7+
	 h9IPchKq+tlfP8CE1rJzLQWTdtrXPpexBgN33AQKCOzcbz6sh4u+orWk3cdT5CYuSY
	 8ObRKC25SvqFm58gX49GOUGsYE49GMu0WYIwTcVYZuPe9Ae608TXzakKZ4GRsLSyYb
	 +1XSQJr9nR92BXrsR1YtFmJzK4BVy3PZYJDPihG+w8FcCmX6fgNJ8J5SnPGD935LB+
	 ZPtOBjLnUdveHbYopOdK1wsnTtLOz19eZFWdHsT+l6VmI9AHGNmA/ZeOj1H0oq49r2
	 TQmGT5RA2xDwg==
Message-ID: <be700824-09a2-4ebe-bc87-0b5bd71c20b7@kernel.org>
Date: Mon, 15 Dec 2025 15:47:34 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] libata: SATA LPM forcibly disabled on Intel Jasper
 Lake since Linux 6.13
To: Bernard Drozd <bernid@interia.pl>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
References: <635cb04f-eda3-49ec-b8bc-62f4e8c7926f@interia.pl>
 <37a2d604-6c20-4913-ad1a-15e727df8a3d@kernel.org>
 <cc94bc84-c5a0-4c29-a249-d0ab99abdc17@interia.pl>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <cc94bc84-c5a0-4c29-a249-d0ab99abdc17@interia.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/15/25 13:28, Bernard Drozd wrote:
> Hi Damien,
> Thank you for the explanation – I understand now that pre-6.13 behaviour 
> was relying on a bug allowing userspace to override unsupported LPM.
> I have collected full diagnostics comparing a *working* kernel (6.12) 
> and a *regressed* kernel (6.17), both tested with **no SATA devices 
> connected**.
> 
> Important correction:
> The correct SATA controller PCI ID is:
> Intel Jasper Lake SATA AHCI Controller [8086:4dd3]
> This was mistakenly reported earlier as 4d03.
> 
> Key observation:
> The LPM disable happens even with no SATA devices attached, so this 
> appears to be a **platform-level decision**, not device capability.
> 
> Data provided:
> 1) Full dmesg, Linux 6.12 (LPM works, CPU reaches PC10):
> https://www.dropbox.com/scl/fi/pwc0bfgoqgb607babczg9/dmesg-6.12-full.txt?rlkey=o8j88lzeq3rw3cbx2q65oyblv&st=u4dwqv0p&raw=1
> 
> 2) Full dmesg, Linux 6.17 (LPM forced to max_performance, CPU stuck in PC2):
> https://www.dropbox.com/scl/fi/twbyjm7h5ewgmllit02h8/dmesg-6.17-full.txt?rlkey=p3b97lli6ruo5ypg4c2d4jnc2&st=3o3xo47m&raw=1

Got it: your AHCI adapter has:

ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 Gbps, SATA mode
ahci 0000:00:17.0: 2/2 ports implemented (port mask 0x3)
ahci 0000:00:17.0: flags: 64bit ncq sntf pm led clo only pio slum part deso sadm sds

Partial and slumber are supported, so all good.

BUT ! your ports are...

ata1: SATA max UDMA/133 abar m2048@0x80102000 port 0x80102100 irq 142 lpm-pol 1 ext
ata2: SATA max UDMA/133 abar m2048@0x80102000 port 0x80102180 irq 142 lpm-pol 1 ext

...external. That is, the adapter is saying that these are
external/hot-pluggable ports, and for these, power management is a bad
idea/should be disabled, which we do. The reason is that otherwise, we cannot
catch hot-plug/unplug events (IRQs).

So to enable low-power policies, you need to go into your BIOS settings and
disable the hot-plugging capability for the ports. Many BIOSes have such setting
for SATA ports. If your BIOS does not have this, yu can use the mask_port_ext
AHCI module parameter. Simply add:

ahci.mask_port_ext=0x3 to your kernel command line and the "ext" flag of the
ports will be ignored and LPM enabled.


-- 
Damien Le Moal
Western Digital Research
