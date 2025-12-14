Received: from smtpo49.interia.pl (smtpo49.interia.pl [217.74.67.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BFB2BE7BA
	for <linux-ide@vger.kernel.org>; Sun, 14 Dec 2025 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.74.67.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765726197; cv=none; b=QLLoMtbF3OWLansIC7Up0aSZAjls/vOyV7Medslz3LmVPinOqisrmCzL4fsUDkIj+PugzOw0940lCb1HVUk1FB4PsJ6XFZ35RIkBsqI+0sHYr+W0W5ZWLX+cJ3HRNTtc4wbAd6ymZmIkRPOylD4MkhHSpzdxdJj7xN1dJw0jfdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765726197; c=relaxed/simple;
	bh=r9jl588+AB2bhKoIUevD21DpcMayOaINrcKPtcIZ7wg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=khX7yxZTYY3j4YoIt88JRbO42IgZWz/u+kvOJD0KJ7wou9s/3C/iON/W9sXwQYP2ZSZxvyH4ajYnwQ0/6HbWGrtjNv0eD4gRVSniImH1Pju+tZlNjkeXQhXvhoS1BpS1FWfXi6cshA2x5b57kmZjVHavhCuTW7KPpqJE+kTDHAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=interia.pl; spf=pass smtp.mailfrom=interia.pl; dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b=BQheKZaj; arc=none smtp.client-ip=217.74.67.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=interia.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=interia.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="BQheKZaj"
Received: from [10.10.11.15] (host-46-174-211-152.podkarpacki.net [46.174.211.152])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Sun, 14 Dec 2025 16:26:56 +0100 (CET)
Message-ID: <635cb04f-eda3-49ec-b8bc-62f4e8c7926f@interia.pl>
Date: Sun, 14 Dec 2025 16:26:55 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: pl
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: damien.lemoal@opensource.wdc.com
From: Bernard Drozd <bernid@interia.pl>
Subject: [REGRESSION] libata: SATA LPM forcibly disabled on Intel Jasper Lake
 since Linux 6.13
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-IPL-Priority-Group: 0-0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl; s=dk;
	t=1765726017; bh=uvzF3WLusyfFzertzUam0GzBAhZQPkSgxjsiOgCrrk0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type;
	b=BQheKZaj4i8JlHVY/tgNM1xQ5pjU3lsMf6jk9OiH1gt4Jy+AEvNWalle5qbtOXBb/
	 2U9wDBckBMoXUeop26bZ+I52VKaAaU+zmFTVU3d+7cA7Gra4a92fBdTqRru4Eyp+C9
	 sh6YwWE15Se80IleeEueOM8FUsc+6HqdAnWLegLE=

Hello,

I am reporting a power-management regression in libata affecting Intel 
Jasper Lake platforms, introduced after Linux 6.12.

Hardware:
- CPU / SoC: Intel Jasper Lake (Elkhart Lake class)
- SATA controller: Intel Jasper Lake SATA AHCI Controller (PCI ID 8086:4d03)
- Drives tested: SATA SSD + SATA HDD (multiple vendors)
- Distribution: Debian 13 (Trixie)
- Kernel versions tested:
   - 6.12.x  → OK
   - 6.17.x  → REGRESSION

Problem description:
Since kernel >= 6.13, SATA Link Power Management (LPM) is forcibly disabled.
The sysfs interface still exists but only reports:

   /sys/class/scsi_host/host*/link_power_management_policy = max_performance

Attempts to change it fail silently or are ignored:

echo 'med_power_with_dipm' > 
'/sys/class/scsi_host/host0/link_power_management_policy'
echo 'med_power_with_dipm' > 
'/sys/class/scsi_host/host1/link_power_management_policy'

This worked correctly on kernel 6.12.x and earlier.

Observed effects:
- SATA devices never enter partial/slumber
- CPU package C-states are limited (system mostly stuck in PC2 (before 
the change i had C10))
- Idle power consumption increases by ~5 W
- powertop shows SATA LPM tunables as permanently "Bad"

Relevant dmesg output (6.17.x):
   ata1: SATA link power management disabled due to platform quirk
   ata2: SATA link power management disabled due to platform quirk

This appears to be caused by the libata change disabling LPM on Intel 
platforms
without a per-platform whitelist. Jasper Lake does not exhibit 
instability with
LPM enabled and worked reliably on previous kernels.

Expectation:
- Either re-enable LPM for Intel Jasper Lake
- Or provide a kernel parameter to override the forced LPM disable
   (e.g. libata.allow_lpm=1)

This regression significantly impacts low-power systems and fanless mini-PCs
based on Jasper Lake.

Please let me know if additional logs or testing are needed.

Best regards,
bern

