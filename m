Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2434F25A64C
	for <linux-ide@vger.kernel.org>; Fri, 21 Nov 2025 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763734671; cv=none; b=RPiOdYAHyVRAmOIjrEPJb742UYH9a5NQjqqlGboJcbS1ziYaTHNyKBJnOUuk8/uDmcwMjj/aBD1DzOH0zMQFq1fTBj3Zg8Isbz/PW5LBsqkljnSE0OuwA8kLgbdQLFWVVPNjd34RNCyxoEfrdS+xK2LRCjx1ZLCd4e4h8nX0HKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763734671; c=relaxed/simple;
	bh=9bRACAMTAzRs8jztCl1ez/4HSDFPL/8XvwKveQTta5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDedeRx8q6qLTvUlvy+geILM3aJbw1ICcdeQxAFPhZ2XazfSXHVUmFxtyfGcB5FX3kaCdkge54Ai6u93pxdR8+7GoZYXxUp6Zcz6vIrHrfEeKgDgpHuUteTSohNoPHd6QCdrf+2anWQkdzrqxmJyE/8ohIADhjRsuT6RYiELYSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwzhlV8r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwzhlV8r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5E4C4CEF1;
	Fri, 21 Nov 2025 14:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763734670;
	bh=9bRACAMTAzRs8jztCl1ez/4HSDFPL/8XvwKveQTta5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WwzhlV8rS1wNP0KCiDIVLmoOdqazwE1UGiqzhYm+zPqZNSVaThX4EI1oNNZyco6xS
	 Wd8PNECZvfZcMrTZQGTeaHMj69giBmzLDHCYBPrJB7WGSggzr/dOwdDSK3SU7h+Tj4
	 2jDIFNxoVE6bKOt2T+A70tqL5GBKYERUZI1+kbEYip4iMsvhfcFZPfnjqC14M2boYD
	 IHNJnUzCP0UAy+qaaT4hxBC1aI+J2Ye3qVWq4taPgnTHVLGTjrYiBPJ1CXZArgItxy
	 v4T7vxIX0rmyN5EMheE5VdUi+Q4QIa80lALOwWshHpbruLzVN50uRckjYUhmWOHBhk
	 6kbPr4oNgafpg==
Date: Fri, 21 Nov 2025 15:17:46 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Yihang Li <liyihang9@h-partners.com>
Cc: mario.limonciello@amd.com, dlemoal@kernel.org,
	linux-ide@vger.kernel.org, linuxarm@huawei.com,
	liuyonglong@huawei.com
Subject: Re: [bug report] ata: ahci: IO error with the default
 med_power_with_dipm
Message-ID: <aSB0ilF_cI5PS8M0@ryzen>
References: <20251121073502.3388239-1-liyihang9@h-partners.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251121073502.3388239-1-liyihang9@h-partners.com>

On Fri, Nov 21, 2025 at 03:35:02PM +0800, Yihang Li wrote:
> Hello Mario, Damien,
> 
> After commit 5433f0e7427ae ("ata: Kconfig: Update SATA_MOBILE_LPM_POLICY
> default to med_power_with_dipm") from linux v6.11, I am seeing the error,
> and eventually, my file system became read-only and could no longer
> be used. Please help check whether this is reasonable and how to resolve
> this issue?
> 
> I am using an standard AHCI controller, connected to a SATA disk, and
> using this disk as the system drive.
> 
> # lsblk
> NAME               MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
> sda                  8:0    0 447.1G  0 disk 
> ├─sda1               8:1    0   600M  0 part /boot/efi
> ├─sda2               8:2    0     1G  0 part /boot
> └─sda3               8:3    0 445.5G  0 part 
>   ├─openeuler-root 252:0    0    70G  0 lvm  /
>   ├─openeuler-swap 252:1    0     4G  0 lvm  [SWAP]
>   └─openeuler-home 252:2    0 371.5G  0 lvm  /home
> 
> Any suggestions on the problem are welcome.

Hello Yihang Li,

As far as we can tell, it appears that a lot of vendors have not
implemented LPM properly, or have issues with LPM in their firmware.

The way we solve it is to quirk these broken devices, see e.g.:
https://github.com/torvalds/linux/blob/v6.18-rc6/drivers/ata/libata-core.c#L4209-L4213


Please tell us which the model of your drive:

$ lsblk -o MODEL /dev/sdX

and the firmware version
$ lsblk -o REV /dev/sdX


So we can create a quirk.


It would also be helpful if you could share which AHCI adapter you are using:
$ lspci -nn | grep -i ahci
$ lspci -nn | grep -i sata


If you want to verify that disabling LPM works for your drive, you can add:

libata.force=nolpm on the kernel command line.


Kind regards,
Niklas
