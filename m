Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F25349B19
	for <linux-ide@vger.kernel.org>; Thu,  3 Sep 2026 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788471661; cv=none; b=Qm65rOuDKnXYbWqkrkQTxIpCTnxy8vxianzq57CuBGoeWDe6UA32tS319h3/VKorRWf9rdOImbJHehMh80DqK0TCufrWy+i0QtVkChWYeaJce1fFMgl0mfJ4lJuQOBYOL34O5wxbVRF2Wrfk+umHAKtoGt2qs/oGXWHJM+6CcyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788471661; c=relaxed/simple;
	bh=9y5bFzBlB42cXrlDN5TS/k0bwTgmnvGxsP+p4Bkw73k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuK5MiDUiMgSbfrPae9508ViIuS6xlkSjeP3A+udNFh+wfiPBJoKd7y3Yw6Vj7+cu2QmdKk8YWkhn5a5F28Adde+QtYW1UUIiWGue8on3I7VryLRB09pO1Hc9zB43P26GdZr8SV7NFU+IFqShzKuL3I78zgeyCaIVhyxRT7vyOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0MELjGY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0MELjGY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD381F00A3D;
	Thu,  3 Sep 2026 21:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788471659;
	bh=isRpB9lGVyFLBO5PfgiyqW2oZ5zS8lDhF5XAC9LfJPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J0MELjGYIooIrhndOUpGiMvc5BGgXwY4HMDfzq3w8sonHXZTNvIJjnZqVHXcjaxxA
	 RcgKHnpPc5lro56WsFGA1BconvGsEaNzbTvepHjFsW97q5TMAsqzqfpBXQjSs41CRM
	 0W6bnTedoqHllvIckNDz4TNerfCg8sF1T3+keoR0IFPEnk9ILIihbtyHsKAiRst72d
	 rGDGktOMX7smu34BOesHl3DhlqbLYXWNPVNtFGiAtl5dw/IChBuT6OU15WDoda8dY1
	 AQ/ZZVIHAiaQQD4TqXvtt+mdMukmI1ACk809aHka/cmkH1V2n/bEcjvxsXpi1Owd0B
	 KuFTtEoLSrsOA==
Date: Thu, 3 Sep 2026 23:40:55 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Roland Waltersson <roland.waltersson@netinsight.net>
Cc: "artmoty@gmail.com" <artmoty@gmail.com>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] ahci: force 32-bit DMA for JMicron JMB582/JMB585
Message-ID: <apnpZ4d-utWZM_Ux@ryzen>
References: <IA0PR17MB668730A4ECCD65F7A1DC3EDC9EB62@IA0PR17MB6687.namprd17.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA0PR17MB668730A4ECCD65F7A1DC3EDC9EB62@IA0PR17MB6687.namprd17.prod.outlook.com>

Hallå Roland,

On Thu, Sep 03, 2026 at 01:35:40PM +0000, Roland Waltersson wrote:
> 
> (analysis provided by Claude)
> Hello,
> 
> Commit 105c42566a55 ("ata: ahci: force 32-bit DMA for JMicron
> JMB582/JMB585") makes a JMicron JMB585 unusable on our board.  I
> believe the cause is not the quirk itself but a pre-existing gap in
> ahci_start_fis_rx(), which the quirk newly exposes for this
> controller.
> 
> Hardware
> --------
> 
>   - congatec conga-TCR8 COM Express Type 6 module
>     (AMD Ryzen Embedded 8000, Zen 4), BIOS TCR8R904 dated 2025-11-11
>   - JMicron JMB585 SATA controller on our own carrier board,
>     at PCI 0000:02:00.0
>   - AMD-Vi IOMMU enabled, default (lazy DMA) domain type
> 
> Symptom
> -------
> 
> The controller's link never comes up and the boot dies:
> 
>   ahci 0000:02:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0001 address=0x80fffc0440 flags=0x0030]
>   ahci 0000:02:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0001 address=0x80fffc0000 flags=0x0010]
>   ata2: softreset failed (1st FIS failed)
>   ata2: reset failed, giving up
> 
> The disk never appears, so our initramfs cannot mount the rootfs and
> switch_root panics with "Attempted to kill init!".
> 
> Analysis
> --------
> 
> AHCI_HFLAG_32BIT_ONLY causes ahci_save_initial_config() to clear
> HOST_CAP_64.  In ahci_start_fis_rx(), the upper halves of the command
> list and FIS receive base addresses are written only when HOST_CAP_64
> is set:
> 
>       if (hpriv->cap & HOST_CAP_64)
>             writel((pp->cmd_slot_dma >> 16) >> 16,
>                    port_mmio + PORT_LST_ADDR_HI);
>       writel(pp->cmd_slot_dma & 0xffffffff, port_mmio + PORT_LST_ADDR);
> 
>       if (hpriv->cap & HOST_CAP_64)
>             writel((pp->rx_fis_dma >> 16) >> 16,
>                    port_mmio + PORT_FIS_ADDR_HI);
>       writel(pp->rx_fis_dma & 0xffffffff, port_mmio + PORT_FIS_ADDR);
> 
> There is no else branch, so with the quirk active PxCLBU and PxFBU are
> never written and retain whatever firmware left in them.
> 
> The fault addresses decompose accordingly:
> 
>   0x80fffc0000  ->  low 0xfffc0000, high 0x00000080
>   0x80fffc0440  ->  low 0xfffc0440, high 0x00000080
> 
> The low halves are exactly the IOVAs dma-iommu hands out for a
> 32-bit-masked PCI device (the allocator works downward from the top of
> the range, so the command list and FIS receive area land just under
> 4 GB).  The constant 0x80 in the high half is a value the kernel never
> wrote; on this platform it places the DMA target at 512 GB, inside the
> above-4G PCIe MMIO window.
> 
> This also explains why booting with iommu=off does not help: without
> the IOMMU the transfer simply goes to that MMIO address silently
> instead of faulting, and the FIS still never arrives.
> 
> Confirmation
> ------------
> 
> Reverting 105c42566a55 restores normal operation.  That is obviously
> not a fix, since it reinstates the broken 64-bit DMA the commit exists
> to prevent.
> 
> 
> I have only reproduced this on 5.15.215 (the quirk reached us as
> 4fc637dcad14 in v5.15.209); I have not tested mainline.  The
> ahci_start_fis_rx() code above is however unchanged in current
> mainline, so I expect any AHCI_HFLAG_32BIT_ONLY controller sitting
> behind an IOMMU whose firmware leaves PxCLBU/PxFBU non-zero to hit the
> same problem.
> 
> I can test patches on this hardware.

Thank you for the detailed analysis.

I have sent a patch here:
https://lore.kernel.org/linux-ide/20260903200349.1316460-2-cassel@kernel.org/

Which I hope will solve your problem.



Side note:
While it seems like you have found a real problem for devices that actually
need AHCI_HFLAG_32BIT_ONLY. It appears that most devices that have either
AHCI_HFLAG_32BIT_ONLY or AHCI_HFLAG_43BIT_ONLY does not need it at all,
which AFAICT, includes all ASMedia and JMicron SATA controllers.
(So ideally, we should drop these for the ASMedia and JMicron SATA controllers.)

The only controller that actually seems to need it is ATA SB600.

If you look at:
https://github.com/artmoty-dev/n5pro-jmb585-fix

It seems like adding amd_iommu=pgtbl_v2 to the kernel command line
works around the problem (without the need for any quirk).

If this was an actual problem with JMB585, changing the AMD IOMMU
page table format would not solve the problem.

AMD themselves have even confirmed that their IOMMU is buggy,
and will misbehave once the 32-bit IOVA space is exhausted:
https://lore.kernel.org/linux-ide/d49add14-c8de-4b6b-9049-4a07e5692ee9@amd.com/

And that the workaround is to use amd_iommu=pgtbl_v2.

It also explains the weirdness that the problem could not be reproduced when
disabling the AMD IOMMU:
https://lore.kernel.org/linux-ide/20260621100844.1224301-1-alvinwylim@gmail.com/T/#u

So, since you have already shared that you have an AMD IOMMU enabled,
I strongly suggest that you enable amd_iommu=pgtbl_v2 to workaround issues
with this IOMMU. Yes, the AHCI_HFLAG_32BIT_ONLY will workaround the problem
for your SATA controller, but you probably have other devices behind your
IOMMU as well.

Ideally, AMD would send a patch that forces the driver to use pgtbl_v2 for
all IOMMU versions that supports pgtbl_v2 (amd_iommu_v2_pgtbl_supported()).


Kind regards,
Niklas
