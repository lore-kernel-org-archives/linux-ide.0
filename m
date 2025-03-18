Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A012585260
	for <linux-ide@vger.kernel.org>; Tue, 18 Mar 2025 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287336; cv=none; b=JwRa7jAvUB2p704Kbzq5AEwjXW5MvOV6DA+6i2FwmtqrkvGDHN7AJ5aGMfhLDrgslMHCxCjMxqYGIZR/wPahMBn1mjKFatlRsMr2XJzUOzoQu32FlxLYPbOnr8otSmpASbAlmheFL60reYtrrvjbgFQaaCQ9dykUOwMMWBQa7Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287336; c=relaxed/simple;
	bh=GUNEQA3s5H0VsUuLjrI7klahxbLxLsfr5OMpAji3taw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1zSCuBmYtji7qjicdDRhY1Sy7Npoze4HUQVx8paLsnJUJYdq4AbpLd5tcYj4VluNxCq5fMroqd7oaimLAH06YiqR89ljcNKP+b30vl+5vuzwplVFJKXeelJSqoqW6R6pvrxYFGyYs4rr2sNtJQx3RPmLpepJUSXF5mNUnl6PYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+xBy9k/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+xBy9k/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170F5C4CEE9;
	Tue, 18 Mar 2025 08:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742287335;
	bh=GUNEQA3s5H0VsUuLjrI7klahxbLxLsfr5OMpAji3taw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R+xBy9k/vyndQ7YYm8b0n9jat1RZ2d9PBSx34YgCWzf0DvAdtWqTYmrDcToYzU5w2
	 wUvuN58QxTEAYzpIAZsJcB2ypAKf9CVtQE4A3cFZR3jcvJeRGoRqXXOZe7HagafZpx
	 LuJJYa3u7ZcuX1krrIep6kiCQ1rYZ5IoJtrH3zTJYgTM6BWXxP6nDrTlqhmqfG5sy9
	 VDge7B/8GYOgKS+pYd7LFz3ZsgEcdBsbKSvmO9BQK5mPqK6YL6LcyTwGzCFWjvfAWG
	 oQyAYRRiNR+awzoRl8ir9OLPKrNJy7tBrjIifp40QFORUEF7dulz7cN3kpnXkvcvAo
	 HuU95gdm2QtiQ==
Message-ID: <9a19142f-4e93-46cd-9c23-3aaa0ebed5a5@kernel.org>
Date: Tue, 18 Mar 2025 17:41:43 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Add ATA_QUIRK_NO_LPM_ON_ATI for certain
 Samsung SSDs
To: Niklas Cassel <cassel@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Jian-Hong Pan <jhp@endlessos.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
 Hans de Goede <hdegoede@redhat.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 Eric <eric.4.debian@grabatoulnz.fr>, linux-ide@vger.kernel.org
References: <20250317170348.1748671-2-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250317170348.1748671-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 2:03 AM, Niklas Cassel wrote:
> Before commit 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> the ATI AHCI controllers specified board type 'board_ahci' rather than
> board type 'board_ahci'. This means that LPM was historically not enabled
> for the ATI AHCI controllers.
> 
> By looking at commit 7a8526a5cd51 ("libata: Add ATA_HORKAGE_NO_NCQ_ON_ATI
> for Samsung 860 and 870 SSD."), it is clear that, for some unknown reason,
> that Samsung SSDs do not play nice with ATI AHCI controllers. (When using
> other AHCI controllers, NCQ can be enabled on these Samsung SSDs without
> issues.)
> 
> In a similar way, from user reports, it is clear the ATI AHCI controllers
> can enable LPM on e.g. Maxtor HDDs perfectly fine, but when enabling LPM
> on certain Samsung SSDs, things break. (E.g. the SSDs will not get detected
> by the ATI AHCI controller even after a COMRESET.)
> 
> Yet, when using LPM on these Samsung SSDs with other AHCI controllers, e.g.
> Intel AHCI controllers, these Samsung drives appear to work perfectly fine.
> 
> Considering that the combination of ATI + Samsung, for some unknown reason,
> does not seem to work well, disable LPM when detecting an ATI AHCI
> controller with a problematic Samsung SSD.
> 
> Apply this new ATA_QUIRK_NO_LPM_ON_ATI quirk for all Samsung SSDs that have
> already been reported to not play nice with ATI (ATA_QUIRK_NO_NCQ_ON_ATI).
> 
> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> Reported-by: Eric <eric.4.debian@grabatoulnz.fr>
> Closes: https://lore.kernel.org/linux-ide/Z8SBZMBjvVXA7OAK@eldamar.lan/
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
