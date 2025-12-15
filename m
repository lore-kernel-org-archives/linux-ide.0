Received: from smtpo63.interia.pl (smtpo63.interia.pl [217.74.67.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CDF2C11CF
	for <linux-ide@vger.kernel.org>; Mon, 15 Dec 2025 04:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.74.67.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765772923; cv=none; b=Doj0jtozGrvmj8Gr9m8SWun0UHzSzbPBPPXBOzqukJq9VukznbCj9euYmvrW94LST13YujXe5U4+0IdgnDSmgNq2QQYBm/jGnMl8L/W24aAyNJLX/Vec4sqxL9H0B+Iy31/pS8x+jUXWQCJ2vFYunga6FS1lpSZjO6YBcWy3Xd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765772923; c=relaxed/simple;
	bh=MLmbGQPqkRVLEAQK8gc6EsBq1W4GEht4s4Axa4od9wQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLD+kdQnBRWNg3yelqJJ7qZX/cQMo2dr11fL2EBfBmH37Qxdk9kf6SCPx8Kwzu7hSgCYK8rMoOckLf3LxCvgsfLnZhVa5jQFMztPwBnoj4eEIWNcPtrxK43S/fVPrj1etIufn6Fnazcq/uHiGqXq1431MY7wJ1H0BlATYTwQUx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=interia.pl; spf=pass smtp.mailfrom=interia.pl; dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b=nG5TQLXK; arc=none smtp.client-ip=217.74.67.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=interia.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=interia.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="nG5TQLXK"
Received: from [10.10.11.15] (host-46-174-211-152.podkarpacki.net [46.174.211.152])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Mon, 15 Dec 2025 05:28:37 +0100 (CET)
Message-ID: <cc94bc84-c5a0-4c29-a249-d0ab99abdc17@interia.pl>
Date: Mon, 15 Dec 2025 05:28:36 +0100
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
Content-Language: pl
From: Bernard Drozd <bernid@interia.pl>
In-Reply-To: <37a2d604-6c20-4913-ad1a-15e727df8a3d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-IPL-Priority-Group: 0-0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl; s=dk;
	t=1765772918; bh=a1AknbohvWJp6KipOnen/7k26wrUdV/bI3WCwlCOI3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=nG5TQLXK52cT9suj/F5GEbvPMtJkxzAytE3ROTNr54IJSzPd6ukkqc4yMeT+I9l8h
	 errs6U9H+1GyEdKPJkNtfAA0YShg2IRx60OssQcAKYAVu7ktIAZlH56gpCofRi07k+
	 5vKf+lBj2kNBwCDRDBDMQpnZtIBeYgvfxkwJ4NII=

Hi Damien,
Thank you for the explanation – I understand now that pre-6.13 behaviour 
was relying on a bug allowing userspace to override unsupported LPM.
I have collected full diagnostics comparing a *working* kernel (6.12) 
and a *regressed* kernel (6.17), both tested with **no SATA devices 
connected**.

Important correction:
The correct SATA controller PCI ID is:
Intel Jasper Lake SATA AHCI Controller [8086:4dd3]
This was mistakenly reported earlier as 4d03.

Key observation:
The LPM disable happens even with no SATA devices attached, so this 
appears to be a **platform-level decision**, not device capability.

Data provided:
1) Full dmesg, Linux 6.12 (LPM works, CPU reaches PC10):
https://www.dropbox.com/scl/fi/pwc0bfgoqgb607babczg9/dmesg-6.12-full.txt?rlkey=o8j88lzeq3rw3cbx2q65oyblv&st=u4dwqv0p&raw=1

2) Full dmesg, Linux 6.17 (LPM forced to max_performance, CPU stuck in PC2):
https://www.dropbox.com/scl/fi/twbyjm7h5ewgmllit02h8/dmesg-6.17-full.txt?rlkey=p3b97lli6ruo5ypg4c2d4jnc2&st=3o3xo47m&raw=1

3) AHCI/SATA diagnostics, Linux 6.12 (no disks attached):
https://www.dropbox.com/scl/fi/mve88utfnrzdilut364p1/6.12.txt?rlkey=zz7x8nqafdslvfjovinzbw26d&st=h0n95d75&raw=1

4) AHCI/SATA diagnostics, Linux 6.17 (no disks attached):
https://www.dropbox.com/scl/fi/viedk35gor5mry49qlkby/6.17.txt?rlkey=fmp4zaizbl22hd2fh6jg4rx8w&st=alwlux85&raw=1

Summary of difference:
- 6.12:
     lpm-pol = 0
     link_power_management_policy = med_power_with_dipm
     ahci.mobile_lpm_policy=3 works
- 6.17:
     lpm-pol = 1 ext
     link_power_management_policy = max_performance (write rejected)
     ahci.mobile_lpm_policy ignored
     CPU package cannot enter deep C-states

This results in ~5W higher idle power on fanless Jasper Lake systems.

Please let me know:
- which capability/quirk check changed after 6.12
- and whether a kernel parameter or quirk override could be used for testing

Best regards,
Bernard

On 15/12/2025 02:44, Damien Le Moal wrote:
> On 12/15/25 00:26, Bernard Drozd wrote:
>> Hello,
>>
>> I am reporting a power-management regression in libata affecting Intel
>> Jasper Lake platforms, introduced after Linux 6.12.
>>
>> Hardware:
>> - CPU / SoC: Intel Jasper Lake (Elkhart Lake class)
>> - SATA controller: Intel Jasper Lake SATA AHCI Controller (PCI ID 8086:4d03)
> Byt the way, I see this:
>
> ahci.c: /* Elkhart Lake IDs 0x4b60 & 0x4b62 https://sata-io.org/product/8803 not
> tested yet */
> ahci.c: { PCI_VDEVICE(INTEL, 0x4b63), board_ahci_pcs_quirk }, /* Elkhart Lake
> AHCI */
>
> So the same "Elkhart Lake", but different PCI ID. Looking at PCI IDs databases,
> I do not find anything with ID 8086:4d03. Can you please check your PCI ID ?
>
> Though board_ahci_pcs_quirk does not disable LPM...
>
>
>> - Drives tested: SATA SSD + SATA HDD (multiple vendors)
>> - Distribution: Debian 13 (Trixie)
>> - Kernel versions tested:
>>     - 6.12.x  → OK
>>     - 6.17.x  → REGRESSION
>>
>> Problem description:
>> Since kernel >= 6.13, SATA Link Power Management (LPM) is forcibly disabled.
>> The sysfs interface still exists but only reports:
>>
>>     /sys/class/scsi_host/host*/link_power_management_policy = max_performance
>>
>> Attempts to change it fail silently or are ignored:
>>
>> echo 'med_power_with_dipm' >
>> '/sys/class/scsi_host/host0/link_power_management_policy'
>> echo 'med_power_with_dipm' >
>> '/sys/class/scsi_host/host1/link_power_management_policy'
>>
>> This worked correctly on kernel 6.12.x and earlier.
>>
>> Observed effects:
>> - SATA devices never enter partial/slumber
>> - CPU package C-states are limited (system mostly stuck in PC2 (before
>> the change i had C10))
>> - Idle power consumption increases by ~5 W
>> - powertop shows SATA LPM tunables as permanently "Bad"
>>
>> Relevant dmesg output (6.17.x):
>>     ata1: SATA link power management disabled due to platform quirk
>>     ata2: SATA link power management disabled due to platform quirk
>>
>> This appears to be caused by the libata change disabling LPM on Intel
>> platforms
>> without a per-platform whitelist. Jasper Lake does not exhibit
>> instability with
>> LPM enabled and worked reliably on previous kernels.
>>
>> Expectation:
>> - Either re-enable LPM for Intel Jasper Lake
>> - Or provide a kernel parameter to override the forced LPM disable
>>     (e.g. libata.allow_lpm=1)
>>
>> This regression significantly impacts low-power systems and fanless mini-PCs
>> based on Jasper Lake.
>>
>> Please let me know if additional logs or testing are needed.
>>
>> Best regards,
>> bern
>>
>>
>

