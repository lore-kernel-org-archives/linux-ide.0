Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C636430C617;
	Mon, 15 Dec 2025 01:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765763090; cv=none; b=dijIvY3Jc+8T6zxf0DerC0ud5pg+hreMZA7v/4bwk5cBHZkRJPSc5B6VslbsARN8mn7F51yDYo58P1gAHd9VNlKUijjDbk3W3AmuzGhaNgdDeZYFKJLSCAdyTb2751OVqRwf9m3CL4J9fPBdtHZjak1DUwttv8cC3bWjLB4bc94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765763090; c=relaxed/simple;
	bh=b3QaKqVJl2gSzPHOPJcT+pq/qo5sWU5Vh0w4z5IXC/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JwQGdIIS2kNAOiTXsLFuSb4PJaeiz01TKP8VGPMI/xclrJU/vawPZaCrI2tdt6iATb+foOku/5BcnHQjSVHGhh47+XfyMrOi0D3WgpMfNtCEVpEhkA+ooGGDBWSiONkZRUOf1uPjJvKitv/aFsRPO2auYJKaAZ4isHnkJoeZE6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAYLlArN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAYLlArN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2333C4CEF1;
	Mon, 15 Dec 2025 01:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765763090;
	bh=b3QaKqVJl2gSzPHOPJcT+pq/qo5sWU5Vh0w4z5IXC/w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VAYLlArNIEygi1kQ+CIfOPJuOBJ2uu11G5tZtc4L8m1nPOmz/XtaPdScCxOQa4r8O
	 0ZrvQnAWo04fyIpUqkozYUutsr8Ec8rmV15Mtq7ryVByEPFeVKQgvD2IETLXn2ZWwi
	 jd9zfSdwG4bHBktdaoN1ky/wDv4s8Pn/NzzYjxcseOwBL55lf8dhI2ILQUCbIRoHio
	 UmFTpY0ys58k85P4bNkC9U8RJ60zi7CYxex9unTMsRG7EYI8dqAXUV3KsNXKkNHq6m
	 TtoRgIj0OPLi6QuX/FgQDYx6DJ4msMm8ZZQuf+r/d8Xuvnk3y3GQJSz5XbKc6E0CFV
	 Rq9X3HWQa5EBQ==
Message-ID: <37a2d604-6c20-4913-ad1a-15e727df8a3d@kernel.org>
Date: Mon, 15 Dec 2025 10:44:48 +0900
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
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <635cb04f-eda3-49ec-b8bc-62f4e8c7926f@interia.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/15/25 00:26, Bernard Drozd wrote:
> Hello,
> 
> I am reporting a power-management regression in libata affecting Intel 
> Jasper Lake platforms, introduced after Linux 6.12.
> 
> Hardware:
> - CPU / SoC: Intel Jasper Lake (Elkhart Lake class)
> - SATA controller: Intel Jasper Lake SATA AHCI Controller (PCI ID 8086:4d03)

Byt the way, I see this:

ahci.c: /* Elkhart Lake IDs 0x4b60 & 0x4b62 https://sata-io.org/product/8803 not
tested yet */
ahci.c: { PCI_VDEVICE(INTEL, 0x4b63), board_ahci_pcs_quirk }, /* Elkhart Lake
AHCI */

So the same "Elkhart Lake", but different PCI ID. Looking at PCI IDs databases,
I do not find anything with ID 8086:4d03. Can you please check your PCI ID ?

Though board_ahci_pcs_quirk does not disable LPM...


> - Drives tested: SATA SSD + SATA HDD (multiple vendors)
> - Distribution: Debian 13 (Trixie)
> - Kernel versions tested:
>    - 6.12.x  → OK
>    - 6.17.x  → REGRESSION
> 
> Problem description:
> Since kernel >= 6.13, SATA Link Power Management (LPM) is forcibly disabled.
> The sysfs interface still exists but only reports:
> 
>    /sys/class/scsi_host/host*/link_power_management_policy = max_performance
> 
> Attempts to change it fail silently or are ignored:
> 
> echo 'med_power_with_dipm' > 
> '/sys/class/scsi_host/host0/link_power_management_policy'
> echo 'med_power_with_dipm' > 
> '/sys/class/scsi_host/host1/link_power_management_policy'
> 
> This worked correctly on kernel 6.12.x and earlier.
> 
> Observed effects:
> - SATA devices never enter partial/slumber
> - CPU package C-states are limited (system mostly stuck in PC2 (before 
> the change i had C10))
> - Idle power consumption increases by ~5 W
> - powertop shows SATA LPM tunables as permanently "Bad"
> 
> Relevant dmesg output (6.17.x):
>    ata1: SATA link power management disabled due to platform quirk
>    ata2: SATA link power management disabled due to platform quirk
> 
> This appears to be caused by the libata change disabling LPM on Intel 
> platforms
> without a per-platform whitelist. Jasper Lake does not exhibit 
> instability with
> LPM enabled and worked reliably on previous kernels.
> 
> Expectation:
> - Either re-enable LPM for Intel Jasper Lake
> - Or provide a kernel parameter to override the forced LPM disable
>    (e.g. libata.allow_lpm=1)
> 
> This regression significantly impacts low-power systems and fanless mini-PCs
> based on Jasper Lake.
> 
> Please let me know if additional logs or testing are needed.
> 
> Best regards,
> bern
> 
> 


-- 
Damien Le Moal
Western Digital Research
