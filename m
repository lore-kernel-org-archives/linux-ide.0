Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90BB47CA79
	for <linux-ide@vger.kernel.org>; Fri,  4 Sep 2026 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520447; cv=none; b=SD9U24kGlxbUXMWzUk98EV83F+Grgnh+pfNN+FU6viiUbtVuhQwN4I9aKdgTGjH4Tuix6jzqAVMxnDPpwKFyETofidthMU2ozXDoa/vkqOi8fbT+19P/YbaQJOkJQhJgZsI9nCz38fnvd5fl2r884X86SSvxcGAllKggKWDKp9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520447; c=relaxed/simple;
	bh=MiTmowmkfQGLNz9+EutXaNrn5K5QXJogCdE9MCadfYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfEgwhOSImwvzpfJRBUluAVmDL166/3jZxIjzHudvHpjrgyU8yTUMoFbz1oe6RK+hMv8nDx+rRRI+U7pqzT8FuC/WjvpZeFUr+c3FzOTPFeq8TbSFi5oY0bxAbtepj3YnAZx9tYlR9O1RK+rcveaD5uEDUHB7uyj4uyGMnKSoiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ic9cuQ8h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ic9cuQ8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0295D1F00A3D;
	Fri,  4 Sep 2026 11:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788520445;
	bh=KshH7oS1pYkYOAK8/hcpDhHOqex23+XuqmFlwlf7gZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ic9cuQ8h2AOJ408daCJjBA8bspnQ/wdktr2/BK2joTFOD295qfzL3DY8VbTdLaKOK
	 /DHuGyAjQlJyiMWbLL/I9aX90MNFFiq2hXlgLzfPPhId27qfjdmlw2fJGpYAOGE9dM
	 jbvOuBfK3LtYKilpjd69frh68E56btCWJEMloOiE3LuunpJ0CPL44ooaDSAuprCpWz
	 u/P5pddS4Q6NN4TdZl7l+VVPKcqTaxRfA0691rRhZ3lnXJE8X8n7bNe5/9/2o9RjtW
	 /bT0tfc7p+xTDK/rgj039j7cUmtXox8EtFgc/CbRZMgrOlUNIZrqgI693IgqijuA2I
	 j3dHSF6bOlRrg==
Date: Fri, 4 Sep 2026 13:14:01 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Roland Waltersson <roland.waltersson@netinsight.net>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	"artmoty@gmail.com" <artmoty@gmail.com>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Mikael Etienne <mikael1022bzh@gmail.com>,
	Alvin Lim <alvinwylim@gmail.com>,
	Lennert Buytenhek <kernel@wantstofly.org>
Subject: Re: [PATCH] ahci: force 32-bit DMA for JMicron JMB582/JMB585
Message-ID: <apqn-bdMi4y4l1gE@ryzen>
References: <IA0PR17MB668730A4ECCD65F7A1DC3EDC9EB62@IA0PR17MB6687.namprd17.prod.outlook.com>
 <apnpZ4d-utWZM_Ux@ryzen>
 <78dae3f6-3b3d-43c8-b2a2-595fd6e6a00b@amd.com>
 <IA0PR17MB66878CE05C135A2BA1F1DD079EB52@IA0PR17MB6687.namprd17.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA0PR17MB66878CE05C135A2BA1F1DD079EB52@IA0PR17MB6687.namprd17.prod.outlook.com>

Hello Mario,

On Fri, Sep 04, 2026 at 05:20:06AM +0000, Roland Waltersson wrote:
> Here are some debug printouts. Note that I am on 5.15 so amd_smn_debugfs_enable is not available - I printed the registers anyway:
> 
> root@maglin25:NCA ~ # root=00:00.0
> root@maglin25:NCA ~ # lspci -nn -s $root          # sanity-check: must be a 1022: AMD root complex
> 
> 00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:14e8]
> root@maglin25:NCA ~ #
> root@maglin25:NCA ~ # for a in 0x111401d0 0x111411d0 0x111421d0 0x111431d0 0x111441d0 \
> >          0x112401d0 0x112411d0 0x112421d0 0x112431d0 0x112441d0 0x112451d0 \
> >          0x113401d0 0x114401d0; do
> >     setpci -s $root 60.l=$a
> >     v1=$(setpci -s $root 64.l)
> >     setpci -s $root 60.l=$a
> >     v2=$(setpci -s $root 64.l)
> >     printf '%s: 0x%s%s\n' "$a" "$v1" "$([ "$v1" = "$v2" ] || echo "  MISMATCH 0x$v2")"
> > done
> 0x111401d0: 0x00000100
> 0x111411d0: 0x00000000
> 0x111421d0: 0x00000100
> 0x111431d0: 0x00000100
> 0x111441d0: 0x00000000
> 0x112401d0: 0x00000100
> 0x112411d0: 0x00000100
> 0x112421d0: 0x00000100
> 0x112431d0: 0x00000100
> 0x112441d0: 0x00000100
> 0x112451d0: 0x00000100
> 0x113401d0: 0x00000100
> 0x114401d0: 0x00000100

Just to clarify, Roland is not one of the people who has been complaining
about silent corruption after exhausting the 32-bit IOVA space.

Roland complained that the AHCI_HFLAG_32BIT_ONLY quirk is making his JMB585
SATA controller not even detect his drive when probing the driver, so he
can't even mount his filesystem. So this is a separate issue.


You should probably reach out to someone who has seen the 32-bit IOVA space
exhaustion issue, i.e.:

Mikael Etienne - issue with addresses larger than 32-bit on AMD SATA controller
https://lore.kernel.org/linux-ide/178789300872.392066.15963676631650361573@gmail.com/
He claims that he cannot reproduce the corruption when using iommu=pt

or

Arthur Husband - issue with addresses larger than 32-bit on JMicron JMB585
https://lore.kernel.org/linux-ide/20260406222335.379935-1-artmoty@gmail.com/
His github claims that he cannot reproduce the corruption when using amd_iommu=pgtbl_v2
https://github.com/artmoty-dev/n5pro-jmb585-fix

or

Alvin Lim - issue with addresses larger than 32-bit for ASMedia ASM1166
https://lore.kernel.org/linux-ide/20260621100844.1224301-1-alvinwylim@gmail.com/
His github claims that he cannot reproduce it with amd_iommu=off
https://github.com/Alvinwylim/asm1166-iommu-dma-corruption
but it also claims that iommu=pt is insufficient.
Note that we never merged this patch, because we never to any confirmation
from ASMedia that the controller was at fault.


I don't know why Alvin claimed that iommu=pt was insufficient, but for Mikael
the problem was not reproducible with iommu=pt. Could there perhaps be
different versions of the AMD IOMMU?

The only thing that I have seen in common so far, is that all bug reports,
JMicron JMB582/585 / ASMedia ASM1166 / AMD SATA controller, have been using
an AMD IOMMU.


Note that there is one separate problem, Lennert Buytenhek actually got
AMD IOMMU page faults, rather than silent corruption:
https://lore.kernel.org/linux-ide/ZaZ2PIpEId-rl6jv@wantstofly.org/
This was actually verified by ASMedia to be a controller issue that they
only support 43-bit DMA, and they provided a list of affected controllers:
https://lore.kernel.org/linux-ide/ZbopwKZJAKQRA4Xv@x1-carbon/
Note that these controllers where quirked with 43-bit DMA, and that
ASM1166 - which Alvin had issues with even for 32-bit addresses - was not
in that list.


Knowing what we know now, we would never have accepted the 32-bit only DMA
quirk for the JMicron JMB582/585 controllers, without at least seeing a
single bug report from a user with an Intel or ARM IOMMU.


We probably want to send a patch that drops the JMicron JMB582/585 32-bit DMA
quirk. But first we want:

1) Someone with an JMicron JMB582/585 + Intel IOMMU or ARM IOMMU
running in enforcing mode, to run the reproducer written by Mikael:

####
fio, io_uring engine (libaio not tested yet).

Write the canary once:

  fio --name=canary --filename=/srv/12to/.sata-canary --size=256G --bs=128k \
      --ioengine=io_uring --direct=1 --iodepth=32 \
      --verify=crc32c --verify_interval=4096 --rw=write \
      --do_verify=0 --fsync_on_close=1

Then loop the verification until it fails:

  while :; do
      fio --name=canary --filename=/srv/12to/.sata-canary --size=256G --bs=128k \
          --ioengine=io_uring --direct=1 --iodepth=32 \
          --verify=crc32c --verify_interval=4096 --rw=write \
          --verify_only=1 --verify_fatal=1 || break
  done

The reboot-without-rewrite protocol: when it fails, reboot and re-run only the
verification loop above. The canary file is never rewritten. It verifies clean.
####

With the 32-bit only quirk dropped:

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 58f512f8952a..1cee901f8e72 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -215,8 +214,7 @@ static const struct ata_port_info ahci_port_info[] = {
 	},
 	/* JMicron JMB582/585: 64-bit DMA is broken, force 32-bit */
 	[board_ahci_jmb585] = {
-		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR |
-				 AHCI_HFLAG_32BIT_ONLY),
+		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,


To verify that this is actually not a SATA controller problem.


2) A fix for the AMD IOMMU driver to be merged, and backported to stable,
such that us writing a fix that drops the 32-bit only DMA quirk for JMicron
JMB582/585, which when backported to stable, will not cause users with an
AMD IOMMU to silently get their filesystem corrupted.


Kind regards,
Niklas
