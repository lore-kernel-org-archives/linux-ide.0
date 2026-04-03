Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BEC29D266
	for <linux-ide@vger.kernel.org>; Fri,  3 Apr 2026 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775203965; cv=none; b=WTLUAUeY4ctnPdOeQgpcmBbMdBdPHMWwfPl7mxepG/gBvidt+m1q9yhXSdatFT3TWkrubA3I+PlMngDDmtNm4HQsdIHKyTFKBHIhW6nORmrJK+6m1eGEZnntas/MzXw1y6sS4YUH5E6nJVXxUdDoDZMb1mSQmoT4NArz4ELPz0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775203965; c=relaxed/simple;
	bh=8T9e2Rz4NOKzrtMqHOEWMInjhF08LF90cYjI1ys0Pdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0Psc0I1+kZMyhD38EFmffvjKIQ+ulCPNcqUbWLlC5VdmIZ108v3h66sCYAjNHoXd/atSn2Y930UcrQ/5kAq2sOpWa0uulXM2h1CyBYUWRFfWB0BvBobVmBcmgot0xYkQcANXVgGqi63lRV0xbGK6XLKOwcfdA9cbsf1AOyIM0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qH5FQrcE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qH5FQrcE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C631C4CEF7;
	Fri,  3 Apr 2026 08:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775203965;
	bh=8T9e2Rz4NOKzrtMqHOEWMInjhF08LF90cYjI1ys0Pdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qH5FQrcEQ8EN/mr2s8bx+/D3Jq9cXmwU5A96eflfO8sM42IwI2K8Gl4hIORkJR1F/
	 Ar7z+LwPDEmPJje+50fgTx3fJgty1ShnLvYq3tBF4QxFF1JVNwN1sddJtk4gW/vRkK
	 /1yClZn7b7jRrtChmHZPQfBvuA1q0E8EuS9wJDAUycqjfH+eRgmStjE/qGFYzny1G3
	 opBgIm6j44A2cH4+kRtDWhEVuibmlqA0tXfJEgxC0dILkgRDBWHOQ4RrNvvsR5tOcT
	 spb/YRGxeMl1aIv/ytAE6pkipMoAfUf6WlB9rQX6SjPDYhC7+X5hGlM35e8vTdGiIA
	 cFxU9HwKXbxDA==
Date: Fri, 3 Apr 2026 10:12:41 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Arthur Husband <artmoty@gmail.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH] ahci: force 32-bit DMA for JMicron JMB582/JMB585
Message-ID: <ac92eQ4mKy1GSIo_@ryzen>
References: <20260403050418.50398-1-artmoty@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260403050418.50398-1-artmoty@gmail.com>

On Thu, Apr 02, 2026 at 10:04:18PM -0700, Arthur Husband wrote:
> The JMicron JMB585 (and JMB582) SATA controllers advertise 64-bit DMA
> support via the S64A bit in the AHCI CAP register, but their 64-bit DMA
> implementation is defective. Under sustained I/O, DMA transfers targeting
> addresses above 4GB silently corrupt data — writes land at incorrect
> memory addresses with no errors logged.
> 
> This has been confirmed on multiple platforms (Minisforum N5 Pro,
> Raspberry Pi, Unraid, Proxmox, TrueNAS) and is consistent with the
> controller truncating or mishandling upper address bits during 64-bit
> DMA transactions.

This does not make sense to me (probably because it is AI generated).

What is a platform here? Rasperry Pi is a SBC, TrueNAS is a Linux distro
based on Debian.

I would just drop this whole paragraph.


> 
> The failure pattern is identical to the ASMedia ASM1062 (commit
> edb96a15dc18), which also falsely advertised 64-bit DMA and was fixed
> with AHCI_HFLAG_32BIT_ONLY.

Please use the normal kernel style to reference commits, i.e.:
"commit '12 character SHA1' (description)"

git --no-pager show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n"

Also, the SHA1 you are referencing does not exist in mainline.

Most likely you are thinking of:
commit 20730e9b2778 ("ahci: add 43-bit DMA address quirk for ASMedia
ASM1061 controllers")

However, this commit uses flag AHCI_HFLAG_43BIT_ONLY
(and not AHCI_HFLAG_32BIT_ONLY as claimed by AI).


> 
> On the Minisforum N5 Pro specifically, the combination of the JMB585's
> broken 64-bit DMA with the AMD Family 1Ah (Strix Point) IOMMU causes
> silent data corruption that is only detectable via checksumming
> filesystems (BTRFS/ZFS scrub). The corruption occurs when 32-bit IOVA

We don't usually mention out of tree filesystems (ZFS) in our commit logs.


Thank you for the patch!


Kind regards,
Niklas
