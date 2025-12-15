Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CCC18C2C;
	Mon, 15 Dec 2025 01:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765762578; cv=none; b=knpbUgq4lDYeIZquwj7t909CPR2FWRG7SFeWpBUnTcSIXFun5sc1hzRTQQ/pOQjG+sGloNy8PP38CeeWtt6a4y/yfdpmY/KRZOwqRh3osEoSjsYBkdwG+Qjlc9xO3Xqvdo+J1ZoMMAE6Olh6glR/+r88l8rp/oItvL2mSc6NDt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765762578; c=relaxed/simple;
	bh=995KdA1b23zjcKsTS2e8zOw6PIDJ5qky/mveGfdY6JE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oiQJVMJ+oBq+W1UIJa+0kfdcw7ZRuq9m/s0RWi6OfbPenr/ufW6NHzmk4ayR5sU4jMfz9k5QNlZ1fO4MIEn2Gua5BXN5FeR4ew9ugSq7pFsMkxHVkdl8YutQVe8OVXfvF7vbquyFwDTQq5/FtcZGTv3Nk4JBGzct6LaDKKC8hY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1PeL9Xs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1PeL9Xs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847FBC4CEF1;
	Mon, 15 Dec 2025 01:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765762578;
	bh=995KdA1b23zjcKsTS2e8zOw6PIDJ5qky/mveGfdY6JE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q1PeL9XsVgZ5OGk6+58igcG6sE+bkwpjJl3moSjvfZ/fXAJE8/dqDcSQ88e6DtBRg
	 sy9K48IxZSu4WNIesb0rHWw3ZrmeNf9nd1ye3/sxv/kj/co0sebP3Gr1SXKZniMu+3
	 mLMaFKRCzl5SbfXdqea+dnzZTD4HiK3Ub78UJvBQT4WySKgtdyqj8ric1kjXCo4UuN
	 k7W1wvQ652mw1FqP5tvhG8AZm7TqvDQmDT4byQtfK1XQutIj/p3m+S57+sl22zwgt5
	 BHVSyOkyK/XCI3OcGrTHwuh166Iur/CFB/cZw6LgZb4G13CB9ha6mC3b849mHND/wc
	 0hkUcua7PZCDA==
Message-ID: <a7d59365-776f-4e92-9f70-98ad9d101f27@kernel.org>
Date: Mon, 15 Dec 2025 10:36:15 +0900
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

+Niklas

On 12/15/25 00:26, Bernard Drozd wrote:
> Hello,
> 
> I am reporting a power-management regression in libata affecting Intel 
> Jasper Lake platforms, introduced after Linux 6.12.
> 
> Hardware:
> - CPU / SoC: Intel Jasper Lake (Elkhart Lake class)
> - SATA controller: Intel Jasper Lake SATA AHCI Controller (PCI ID 8086:4d03)
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

That is normal if either the device connected to this host or the adapter itself
is identified as not supporting LPM.

> Attempts to change it fail silently or are ignored:
> 
> echo 'med_power_with_dipm' > 
> '/sys/class/scsi_host/host0/link_power_management_policy'
> echo 'med_power_with_dipm' > 
> '/sys/class/scsi_host/host1/link_power_management_policy'

Again, normal in the context described above.

> This worked correctly on kernel 6.12.x and earlier.

Which was a horrible bug: the ata subsystem was identifying the device or
adapter as not supporting LPM, but the sysfs knob was left open for chnages, and
systemd would happily set whatever power management policy it wanted, even if
the device or adapter did not support it. So this "worked correctly" is actually
"that was a really nasty bug".

The problem here is to understand why you adapter/device is identified as not
supporting LPM, even though it seems to do support it.

> Observed effects:
> - SATA devices never enter partial/slumber
> - CPU package C-states are limited (system mostly stuck in PC2 (before 
> the change i had C10))
> - Idle power consumption increases by ~5 W
> - powertop shows SATA LPM tunables as permanently "Bad"

Yes, all normal if LPM is disabled and you are stuck with max performance policy.

> Relevant dmesg output (6.17.x):
>    ata1: SATA link power management disabled due to platform quirk
>    ata2: SATA link power management disabled due to platform quirk

Please send everything that scsi/ahci/ata prints. That is not nearly enough to
understand what is going on here.

Looking at the ahci driver, I do not see any special quirks for PCI ID
8086:4d03. So we need all the messages from the latest kernel to understand this.

> This appears to be caused by the libata change disabling LPM on Intel 
> platforms
> without a per-platform whitelist. Jasper Lake does not exhibit 
> instability with
> LPM enabled and worked reliably on previous kernels.

There is no quirk applied to the adapter PCI ID 8086:4d03 that I can see. So it
will be initialized with board_ahci, meaning that LPM will be allowed, but only
if we detect that the adapter report that as supported. If the adapter does not
have the right bits set reporting LPM support, especially DIPM/HIPM, then LPM
will be disabled. Please send the full dmesg so that we can check.

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
