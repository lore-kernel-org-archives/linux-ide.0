Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E353845BD
	for <linux-ide@vger.kernel.org>; Thu, 20 Aug 2026 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787204952; cv=none; b=LtxTwprJxmhekR/jdI91AOvrwOi7srm6cDlUaehiTHngEpUTyiw6YeM+9ZsfYFlKgxG2t6KzGMIwwPODKR3HJXIkjL6jX8ww/Ky5A+ZJIIN86nUF9o/sV2AUMWnsz8VJlzsThd9WMtK3XMJzvxUoGRDicvGYfkb/cyRIxCgFBFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787204952; c=relaxed/simple;
	bh=OJZ1Um6BkcYJ7Li948o7VTk5YCbc7hAhUzcQDmdRuWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NAUq5AZmCa7+3D76JT83DNc0Dt9pJHgt4Oaaj0c7nFatgvXP/YfywIfWjAV0kMfaeE2aW2rSNEsaTe3o6Tj1Ut4AYQZuJZuf+m81sSosENBjycMG3pzVqKIsfmihzJhQEiufk0Ad9Cl3tOU728oEYrYphc1oF0XIEVUQX6/wTVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9PyKST0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9PyKST0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097EA1F000E9;
	Thu, 20 Aug 2026 05:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787204950;
	bh=rpjh8dv8C6nWd8F0VS0ABpBX9N66/Jr6GwE8Ywq1tUQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=L9PyKST0I0uZF59eAAKl0MMvJ//NoHrDPyqRV4ymo0e3NMNXTvfHyUltuyx8q0I0t
	 45cq2oHknB/cVPAdbT6uaYFQy/KBEg+EbvicdJI+gGnL5g1xZbPdVJ/u+mDTevRNr+
	 RZgvKJOM7Me0vZjVod7F8giveiJfxLDsYMhduCTc2y84xJ8m54jcy4hrl77pq9K7kP
	 nySRnXL2oIrj61lihoF5ZPAcCQ/826TIA0YCQW1onn0kqNZHbZ7uVSei+FMXPe1DGC
	 SF+tORAJBUXP/jcuKuSqXyn1wc52O9Yn4fZRl5/TwX8YPOs9LPavlhO6E2NYcN17sk
	 nB2rcn7CpB8hA==
Message-ID: <d441aa38-41a4-4833-a0b4-51928a1f2e99@kernel.org>
Date: Thu, 20 Aug 2026 14:49:08 +0900
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
 <0543059b-13c4-4b6e-a236-6d37cbb3245e@kernel.org> <aoQuyYsycb4s8mIP@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aoQuyYsycb4s8mIP@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/26 19:07, Niklas Cassel wrote:
> On Tue, Aug 18, 2026 at 06:52:45PM +0900, Damien Le Moal wrote:
>> On 8/18/26 18:42, Niklas Cassel wrote:
>>> syzbot force-bound ata_generic to 0000:00:03.0 on a QEMU arm64 virt
>>> machine. That device is a virtio-blk-pci device holding the root file
>>> system, and it reports PCI class 0x010000, i.e. PCI_CLASS_STORAGE_SCSI.
>>>
>>> QEMU gives the virtio-blk-pci device a legacy virtio I/O BAR0 and a 4 KiB
>>> MSI-X BAR1, so both resources are non-empty, the port is not discarded,
>>> and the device control register ends up in the middle of the MSI-X table.
>>>
>>> The emulated device rejects the byte write, and arm64 reports the
>>> resulting bus error as a fatal synchronous external abort:
>>>
>>>   Internal error: synchronous external abort: 0000000096000050 [#1]  SMP
>>>   pc : ata_sff_freeze+0x7c/0x90 drivers/ata/libata-sff.c:1606
>>>   Call trace:
>>>    ata_sff_freeze+0x7c/0x90
>>>    ata_eh_freeze_port+0x34/0x5c
>>>    ata_host_start+0x13c/0x228
>>>    ata_pci_sff_activate_host+0x50/0x340
>>>    ata_pci_init_one+0x19c/0x1d8
>>>    ata_pci_bmdma_init_one+0x14/0x20
>>>    ata_generic_init_one+0xc4/0x1ac
>>>    local_pci_probe+0x40/0xa8
>>>    pci_device_probe+0xd8/0x288
>>>    really_probe+0xbc/0x2bc
>>>    device_driver_attach+0x48/0xb4
>>>    bind_store+0x7c/0xd8
>>>
>>> Refuse devices which neither report the IDE class nor appear in our ID
>>> table. Table entries keep binding as before, because some of the listed
>>> controllers cannot be assumed to report the IDE class. A controller which
>>> needs ata_generic but does not report the IDE class should get an ID table
>>> entry, which is what the table is for.
>>>
>>> Binding a driver to unrelated hardware requires root and is what
>>> driver_override is meant to do, so this does not fix a privilege boundary.
>>>
>>> This change only stops ata_generic from binding to a PCI device which it
>>> has no reason to believe to be an IDE controller.
>>>
>>> Reported-by: syzbot+891c7b195b408052e519@syzkaller.appspotmail.com
>>> Closes: https://lore.kernel.org/linux-ide/6a82bc54.10853dc7.22f513.001b.GAE@google.com/
>>> Signed-off-by: Niklas Cassel <cassel@kernel.org>
>>
>> Looks sensible to me, and very surprising that this problem was not cought before...
>>
>> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> 
> I mean, syzbot using driver_override like this is kind of a stupid test.
> 
> If you try to use the generic ATA driver for a PCI device that is something
> completely different, e.g. an Ethernet controller... you kind of get what
> you asked for :)
> 
> But it is such a small patch, so I think it makes sense, even if all it
> does it to stop us from getting more silly reports like this.
> 
> 
> Tell me if you prefer the other patch, which checks BAR type instead.
> BAR type I/O is very rare, since it is old x86 legacy.
> (But such a patch would still allow someone to bind a PCI device with
> BARs marked as type I/O, even if that PCI device does not have storage
> class IDE.)

I definitely prefer the patch as is, checking that the storage class is IDE,
instead of doing guesswork with the BAR types.

> 
> 
> I think the main argument for the patch in $subject... is:
> if your PCI device is not class IDE... just add an entry to the match table.
> (I.e. we don't care that driver_override will not work with a device that
> does not have class IDE... If you really want the driver to work with such
> a device, you will have to add an explicit entry to the match table.)
> 
> 
> Kind regards,
> Niklas


-- 
Damien Le Moal
Western Digital Research
