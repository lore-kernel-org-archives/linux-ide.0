Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67EC256C6D;
	Wed, 12 Mar 2025 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794480; cv=none; b=Xp+r+rgSTqynSKZzmcgycSce9Oee6Teo9RGBs486VqDT7gV8uvw+tRVzC4NqnVekk0SrdOy/8eLTYhe+rVFkwysmqGNvXJVrQvVestyurxwZGZKlVZgXqzuR2/wNNpk4wLBYpLktsg9TeAOZ2brSMh/k9ymdJKktXykKZJcmFNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794480; c=relaxed/simple;
	bh=xZGEGddQAAW7/yGDhA8u+37v7YUeSlhDPtoJBT8h62o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wrd0l756Ye4UvrzyCjFkk+aIG8stRahvkyt9O0wwHrZfzgfQKBsNCseXy4p0Qk4s1DfBSo6bFTadRrvJiKu1Pn8OfwF8dcIyr2ipvSnkxTx25N8iwcNicJI4iaWlHT9gtd09ODG27WUoJKQP+P3yh/wV9gsFqsToL8nWZsQOo34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmDm0hLM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmDm0hLM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13104C4CEEC;
	Wed, 12 Mar 2025 15:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741794480;
	bh=xZGEGddQAAW7/yGDhA8u+37v7YUeSlhDPtoJBT8h62o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmDm0hLMHoWfLsnHiEVSsS4m5frg1cGQ53ZKF+tSw+e5gYtOWdCbYv3Qv6iNacbEU
	 RCyqLjuqW2NtmN+nK8Q1GcevZr2GCEFO4v70OGdTNkPxrhBE8TqWYRVtxb1GflpBAW
	 z5Bz6GmDUzLfw0vSnDklSCSom05IVsmM+j5eAmZBPfjVwMUEBwmtJfJPMYTiCtwtDS
	 BrNcnloffk5YE+fHqhZ3Flgrio5DS+icspfUzV48CGyDBd6u6HB2WUwZEyRvSdSUL9
	 p5lusziZ0NxuK5E7BhFX8w/VReco8Lr4AKoERAikqSEuvtcl3A3pMAm11rLWjy8mpN
	 5xzUS2AOGFmUw==
Date: Wed, 12 Mar 2025 16:47:55 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, Daniel Kral <d.kral@proxmox.com>,
	linux-kernel@vger.kernel.org, Yuli Wang <wangyuli@uniontech.com>,
	Jie Fan <fanjie@uniontech.com>, Erpeng Xu <xuerpeng@uniontech.com>
Subject: Re: [PATCH V3] ahci: Marvell 88SE9215 controllers prefer DMA for
 ATAPI
Message-ID: <Z9Gsq9Yz7nDQ_fOx@ryzen>
References: <20250312134654.6699-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312134654.6699-1-chenhuacai@loongson.cn>

On Wed, Mar 12, 2025 at 09:46:54PM +0800, Huacai Chen wrote:
> We use CD/DVD drives under Marvell 88SE9215 SATA controller on many
> Loongson-based machines. We found its PIO doesn't work well, and on the
> opposite its DMA seems work very well. We don't know the detail of the
> 88SE9215 SATA controller, but we have tested different CD/DVD drives
> and they all have problems under 88SE9215 (but they all work well under
> an Intel SATA controller). So we can define a new dedicated AHCI board
> id named board_ahci_yes_fbs_atapi_dma for 88SE9215, and for this id we
> set the AHCI_HFLAG_ATAPI_DMA_QUIRK and ATA_QUIRK_ATAPI_MOD16_DMA flags
> on the SATA controller to prefer ATAPI DMA.

This is a wall of text.

Could you please use paragraphs? (with an empty line between paragraphs).

(There can be multiple sentences in one paragraph.)

This is a good example:

commit 6bdbb73dc8d99fbb77f5db79dbb6f108708090b4
Author: Bibo Mao <maobibo@loongson.cn>
Date:   Sat Mar 8 13:52:04 2025 +0800

    LoongArch: KVM: Fix GPA size issue about VM
    
    Physical address space is 48 bit on Loongson-3A5000 physical machine,
    however it is 47 bit for VM on Loongson-3A5000 system. Size of physical
    address space of VM is the same with the size of virtual user space (a
    half) of physical machine.
    
    Variable cpu_vabits represents user address space, kernel address space
    is not included (user space and kernel space are both a half of total).
    Here cpu_vabits, rather than cpu_vabits - 1, is to represent the size of
    guest physical address space.
    
    Also there is strict checking about page fault GPA address, inject error
    if it is larger than maximum GPA address of VM.
    
    Cc: stable@vger.kernel.org
    Signed-off-by: Bibo Mao <maobibo@loongson.cn>
    Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>



Otherwise, this looks good to me.


Daniel, could you please test on your system as well?



Kind regards,
Niklas
