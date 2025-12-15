Received: from smtpo75.interia.pl (smtpo75.interia.pl [217.74.67.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203D0314B71
	for <linux-ide@vger.kernel.org>; Mon, 15 Dec 2025 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.74.67.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765791013; cv=none; b=UKD7gS1C90onO63zFk269b5t1nb8kMuEsgS6IXIFRre/d3UZKULES3mO+RygRijVWtL4xyKRApic/zTF2mAz8TyCT2fLuXRexMjaTVXV0WbAZqh0UWO7ezKNYFhuhxfki/4Sh4f2ZaJwtIZdVDMZdDD5PJ//VCqFwWc73pt0U1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765791013; c=relaxed/simple;
	bh=T61FxLDQS9pjorwiJ0kuDb7BD/EDBUIsXsfM2GKUxM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bb37KQMWJR5LOMVfrlhlZN5PISp9Fa2/Q+dztPWTS9172MCIxfozE393fuagRK0/C2L7Gmt8swqv8aXQYaxZAyyfrp34IEGi8BtL8YrVe0CI5RY9EqGRZ+9QNT+wUmgNnPb708m4GYGTJQDFz9cDyseMrhmsPYRZY2zyJvkHaBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=interia.pl; spf=pass smtp.mailfrom=interia.pl; dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b=fnJjH3l1; arc=none smtp.client-ip=217.74.67.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=interia.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=interia.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="fnJjH3l1"
Received: from [10.10.11.15] (host-46-174-211-152.podkarpacki.net [46.174.211.152])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Mon, 15 Dec 2025 10:30:07 +0100 (CET)
Message-ID: <5a74106a-d9db-4e63-b3e6-3857f30a1190@interia.pl>
Date: Mon, 15 Dec 2025 10:30:07 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] libata: SATA LPM forcibly disabled on Intel Jasper
 Lake since Linux 6.13
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
References: <635cb04f-eda3-49ec-b8bc-62f4e8c7926f@interia.pl>
 <37a2d604-6c20-4913-ad1a-15e727df8a3d@kernel.org>
 <cc94bc84-c5a0-4c29-a249-d0ab99abdc17@interia.pl>
 <be700824-09a2-4ebe-bc87-0b5bd71c20b7@kernel.org>
Content-Language: pl
From: Bernard Drozd <bernid@interia.pl>
In-Reply-To: <be700824-09a2-4ebe-bc87-0b5bd71c20b7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-IPL-Priority-Group: 0-0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl; s=dk;
	t=1765791008; bh=8DW8UkANgOJfZhYwBzOkfqfLU5hK6h6s7sXkx2JOpTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=fnJjH3l1nayUSsq0Kh6plfM78KNiJgUfNW2mBRGeR27zJ8BgHE+t7eCHHTp/qfJzd
	 rRkD+Q6jXkQ7OLfq1SXE0/i2/1MsYFLNo2H8U4LE45ykfVEoNVlNU1KEdVUTgGcy19
	 TJq8qlSLx3o/wQeAtj5EGQ6lf8LGsTigrg4sFJX8=

Hi Damien,

thank you for the detailed explanation – that was exactly the missing piece.
You were absolutely right: the issue was caused by all SATA ports being 
reported by the BIOS as external (hot-pluggable).

In my BIOS (AMI Aptio), all SATA ports had Hot Plug enabled by default:
https://www.dropbox.com/scl/fi/9gi68rlxg1mcd37yrwcva/Hot_PLUG_SATA.jpg?rlkey=cse0i5j7qr4va0xjw9o7fv6r4&st=dn6r6q0k&raw=1
After disabling Hot Plug for the SATA ports, LPM works correctly again.

Results:
- Kernel: 6.17.8-1~bpo13+1
- link_power_management_policy can now be set to: med_power_with_dipm
- SATA links enter partial/slumber
- CPU package reaches deep C-states again (PC10)
- Idle power consumption back to ~2.5 W (same as with 6.12)

So this was not a kernel regression, but a correct behavior exposed by 
the libata fix after 6.12, combined with an unfortunate BIOS default.
Thanks again for the clear analysis and for pointing out 
ahci.mask_port_ext as a fallback – very helpful.

Best regards,
Bernard

On 15/12/2025 07:47, Damien Le Moal wrote:
> On 12/15/25 13:28, Bernard Drozd wrote:
>> Hi Damien,
>> Thank you for the explanation – I understand now that pre-6.13 behaviour
>> was relying on a bug allowing userspace to override unsupported LPM.
>> I have collected full diagnostics comparing a *working* kernel (6.12)
>> and a *regressed* kernel (6.17), both tested with **no SATA devices
>> connected**.
>>
>> Important correction:
>> The correct SATA controller PCI ID is:
>> Intel Jasper Lake SATA AHCI Controller [8086:4dd3]
>> This was mistakenly reported earlier as 4d03.
>>
>> Key observation:
>> The LPM disable happens even with no SATA devices attached, so this
>> appears to be a **platform-level decision**, not device capability.
>>
>> Data provided:
>> 1) Full dmesg, Linux 6.12 (LPM works, CPU reaches PC10):
>> https://www.dropbox.com/scl/fi/pwc0bfgoqgb607babczg9/dmesg-6.12-full.txt?rlkey=o8j88lzeq3rw3cbx2q65oyblv&st=u4dwqv0p&raw=1
>>
>> 2) Full dmesg, Linux 6.17 (LPM forced to max_performance, CPU stuck in PC2):
>> https://www.dropbox.com/scl/fi/twbyjm7h5ewgmllit02h8/dmesg-6.17-full.txt?rlkey=p3b97lli6ruo5ypg4c2d4jnc2&st=3o3xo47m&raw=1
> Got it: your AHCI adapter has:
>
> ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 Gbps, SATA mode
> ahci 0000:00:17.0: 2/2 ports implemented (port mask 0x3)
> ahci 0000:00:17.0: flags: 64bit ncq sntf pm led clo only pio slum part deso sadm sds
>
> Partial and slumber are supported, so all good.
>
> BUT ! your ports are...
>
> ata1: SATA max UDMA/133 abar m2048@0x80102000 port 0x80102100 irq 142 lpm-pol 1 ext
> ata2: SATA max UDMA/133 abar m2048@0x80102000 port 0x80102180 irq 142 lpm-pol 1 ext
>
> ...external. That is, the adapter is saying that these are
> external/hot-pluggable ports, and for these, power management is a bad
> idea/should be disabled, which we do. The reason is that otherwise, we cannot
> catch hot-plug/unplug events (IRQs).
>
> So to enable low-power policies, you need to go into your BIOS settings and
> disable the hot-plugging capability for the ports. Many BIOSes have such setting
> for SATA ports. If your BIOS does not have this, yu can use the mask_port_ext
> AHCI module parameter. Simply add:
>
> ahci.mask_port_ext=0x3 to your kernel command line and the "ext" flag of the
> ports will be ignored and LPM enabled.
>
>

