Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387381BDC3;
	Mon,  9 Dec 2024 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733704497; cv=none; b=P/CKZwX0qpr2pBlP15JmZLllnKU/VXV3/x9W/6ck87KALo+7uDr6VmDTqClR6IHfE0bJihbO/2nBUEeol6GLkCGxbSpriLwEAdK20E65F+efApFxiGAZ/Nh0e4EQtY6u/LDRV7gmzv/IBpiAPoxbf97OpFRorrAhvHY3k9ghNac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733704497; c=relaxed/simple;
	bh=W6IOZ3bStO/Ox8Gg2SAak1Z5Iv/I8uEp8nlZMMvJJBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bhdzYRY6a4s0VdrVFp3yQ63VUdamWqs/ljz63P4hCPeROhzOGsvjl9F0VFma2y2F5bsU9haxB1cfCCjQsHL47j7WOttfLXi9XQJdHgzQEWMpdqW89zAJQxCHy9y5N6qS4AOgkKfjX/0pRLdEiA/ajYOGTQinfmepfB6jiTEwqeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHPBtfME; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHPBtfME"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C3AC4CED2;
	Mon,  9 Dec 2024 00:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733704496;
	bh=W6IOZ3bStO/Ox8Gg2SAak1Z5Iv/I8uEp8nlZMMvJJBY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=VHPBtfMETG6MfKrTHGRreGGdINb0UFSHCgKw5iap7K73aFRu9MZAESunDp8/9DO/c
	 SYSEUd88SolRbP2aCk2SYpYp0r5yj9B2z5gnvJHWAR2Xec5sfvXPzKrcsE+Lh46v5Q
	 e4v8xw6uGZqzIj1rMW11Iw1DJR33pUBVKHYzNOkeQn9t3RG1gk7xJVrJkUQWHtty/2
	 r8Van1s4yGN49GtVSV1D6LcNFvAkBg/1zT6PJlKDPmy8s9AFTrHsyc/D24xc6KGgje
	 XzTwWKamoOSOyCq79V39GFAL1uzTfzpdGBPeLSNAaA8noHpQMlLfrKWVw9EwjX+xMR
	 7t8OJTPybHMdA==
Message-ID: <2475124e-d4a1-4836-b5a0-3c00f5a5a94d@kernel.org>
Date: Mon, 9 Dec 2024 09:34:55 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: possible deadlock in __ata_sff_interrupt
To: Juefei Pu <juefei.pu@email.ucr.edu>, cassel@kernel.org,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CANikGpf3VaRCW+m48E+k7CDGKv89gwd12Q1=qM_uP3N=az-T7A@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CANikGpf3VaRCW+m48E+k7CDGKv89gwd12Q1=qM_uP3N=az-T7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/24 05:46, Juefei Pu wrote:
> Hello,
> We found the following issue using syzkaller on Linux v6.10.

Can you run the same against the latest 6.13-rc2 ?

> A possible deadlock issue was discovered in function
> `__ata_sff_interrupt` when it attempted to acquire lock `host->lock`.
> 
> Unfortunately, the syzkaller failed to generate a reproducer.
> But at least we have the report:
> 
> sr 1:0:0:0: [sr0] tag#0 FAILED Result: hostbyte=DID_ERROR
> driverbyte=DRIVER_OK cmd_age=0s
> sr 1:0:0:0: [sr0] tag#0 CDB: opcode=0x98 98 61 1e 1d 47 a1 77 90 29 76
> 7f 40 b8 5e 03 63
> =====================================================
> WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
> 6.10.0 #13 Not tainted
> -----------------------------------------------------
> syz.1.961/19801 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
> ffff88802d3a4018 (&new->fa_lock){....}-{2:2}, at: kill_fasync_rcu
> fs/fcntl.c:1028 [inline]
> ffff88802d3a4018 (&new->fa_lock){....}-{2:2}, at:
> kill_fasync+0x196/0x4d0 fs/fcntl.c:1049
> 
> and this task is already holding:
> ffff88801ca06018 (&host->lock){-.-.}-{2:2}, at:
> ata_scsi_queuecmd+0x8a/0x520 drivers/ata/libata-scsi.c:4197
> which would create a new lock dependency:
>  (&host->lock){-.-.}-{2:2} -> (&new->fa_lock){....}-{2:2}

[...]

> Chain exists of:
>   &host->lock --> &new->fa_lock --> tasklist_lock
> 
>  Possible interrupt unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(tasklist_lock);
>                                local_irq_disable();
>                                lock(&host->lock);
>                                lock(&new->fa_lock);
>   <Interrupt>
>     lock(&host->lock);

I fail to see how this can happen given that the first thing that
kill_fasync+0x196/0x4d0 fs/fcntl.c:1049 is "write_lock_irq(&fa->fa_lock);" so
IRQs are disabled... Lockdep is confused ?

-- 
Damien Le Moal
Western Digital Research
