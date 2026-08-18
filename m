Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE1C43F0B8
	for <linux-ide@vger.kernel.org>; Tue, 18 Aug 2026 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046768; cv=none; b=kjN8m6SdKDwVRKG/r7kYwQSv5Ypsn+Y+tePJRFsOCcR0cCCXMebxL1QpGwjiZ+net3+P5jjMSm1XXPARGHH+VsP4LHL3DSOpmHnangUbULxjBv05CC4qN6wN7B1zdsJSnHVt1fRFlisDX6o684CdGAz422QBcFNf82/45ZU7DWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046768; c=relaxed/simple;
	bh=tGt8Ykre1f/NguqxJ32m1/9Xp0Pu84FS6VZ9JRwKUgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WXOj/nJMkP/q/LISgKnbE9tOHAtgmq4ULEFNRtZyvlddXBnWjCJKTgsjHeBb4a/0Q+nmoKtjMofNMu47tQw6t+cRPZYEI5Ft566EuHfEiraArOxyQxxQLtq5n7milBIa+9YDJdx/TQ/05QF87HWej89q69/XJpOMcqq78X0gd0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJeQbaRN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJeQbaRN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC001F00A3A;
	Tue, 18 Aug 2026 09:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787046766;
	bh=aha+TLUcIFCes5GxcZot7nL6Chouu03rHSxYQAsy22A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XJeQbaRNB83OGh2L/CCb76arbMM9YN1+9s+h6Mevxh3xrOUeDyERbW3pJ4z4Cgf30
	 piRd/ndtxcAoh+LABV1rHF5763uMcLzIPJZlRn9RXFNk7nWjx+z2hC68WZa16Ovpoj
	 ettkhsnR6DJa3SO1xihQcQubsMY75QrdWU+vD2rYxu4px5kXmW2Lw7VOnWVgIb3DPO
	 UE5Oe5LYxZ2tP0X/PWXWnmWm1XSKz/Q6gDj2S01QDUmD2Zhs8xiP679bxBcE5bdOJA
	 +ot5UMoFnHH5TYBNtrsYyoZfAVcAk6NUwC2B7D3TU32UECUloYRXjHxiJRGw+qL0sO
	 HCSABOv+rE/0g==
Message-ID: <0543059b-13c4-4b6e-a236-6d37cbb3245e@kernel.org>
Date: Tue, 18 Aug 2026 18:52:45 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ata_generic: Do not bind to devices that are not IDE
 controllers
To: Niklas Cassel <cassel@kernel.org>
Cc: syzbot+891c7b195b408052e519@syzkaller.appspotmail.com,
 linux-ide@vger.kernel.org
References: <20260818094205.2672967-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260818094205.2672967-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/26 18:42, Niklas Cassel wrote:
> syzbot force-bound ata_generic to 0000:00:03.0 on a QEMU arm64 virt
> machine. That device is a virtio-blk-pci device holding the root file
> system, and it reports PCI class 0x010000, i.e. PCI_CLASS_STORAGE_SCSI.
> 
> QEMU gives the virtio-blk-pci device a legacy virtio I/O BAR0 and a 4 KiB
> MSI-X BAR1, so both resources are non-empty, the port is not discarded,
> and the device control register ends up in the middle of the MSI-X table.
> 
> The emulated device rejects the byte write, and arm64 reports the
> resulting bus error as a fatal synchronous external abort:
> 
>   Internal error: synchronous external abort: 0000000096000050 [#1]  SMP
>   pc : ata_sff_freeze+0x7c/0x90 drivers/ata/libata-sff.c:1606
>   Call trace:
>    ata_sff_freeze+0x7c/0x90
>    ata_eh_freeze_port+0x34/0x5c
>    ata_host_start+0x13c/0x228
>    ata_pci_sff_activate_host+0x50/0x340
>    ata_pci_init_one+0x19c/0x1d8
>    ata_pci_bmdma_init_one+0x14/0x20
>    ata_generic_init_one+0xc4/0x1ac
>    local_pci_probe+0x40/0xa8
>    pci_device_probe+0xd8/0x288
>    really_probe+0xbc/0x2bc
>    device_driver_attach+0x48/0xb4
>    bind_store+0x7c/0xd8
> 
> Refuse devices which neither report the IDE class nor appear in our ID
> table. Table entries keep binding as before, because some of the listed
> controllers cannot be assumed to report the IDE class. A controller which
> needs ata_generic but does not report the IDE class should get an ID table
> entry, which is what the table is for.
> 
> Binding a driver to unrelated hardware requires root and is what
> driver_override is meant to do, so this does not fix a privilege boundary.
> 
> This change only stops ata_generic from binding to a PCI device which it
> has no reason to believe to be an IDE controller.
> 
> Reported-by: syzbot+891c7b195b408052e519@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-ide/6a82bc54.10853dc7.22f513.001b.GAE@google.com/
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks sensible to me, and very surprising that this problem was not cought before...

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
