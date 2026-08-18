Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E4621254B
	for <linux-ide@vger.kernel.org>; Tue, 18 Aug 2026 10:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047630; cv=none; b=GwORr363fyS+RZDBH79t0v/8l4QB9HdgqCYSxsFptkHy1pEzttwiucKiniZbEakadk51nHsy8u+KaaI6bCnw1VeTBqH08wf/7wvmlFUwjY53l+kLmWbwR8T/AnrjDg8DvGxzmKEbl9/MsPuwM/qJPMV24reacjeveeyfG85qHpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047630; c=relaxed/simple;
	bh=MLGHsRSGBIb7tUGqg9tjkYj65gskYRyOJhria+20pMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3F4dBPBpjVoFW7sw6ALvfPEbvffgsNh3Tohhuiy81JR0xEi7ZVdCv5k0tQRAmcRToyx7lTzHS+p4vqY4z/9iRdpzIbUFdC696aox0bS3a53EwbFctUHR+YhGKSNF/eYi6CUugLDDiqaney4/jlTZZrdd0YVzKSt/+J/yXabejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXVjzxSK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXVjzxSK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD2E1F000E9;
	Tue, 18 Aug 2026 10:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787047628;
	bh=HmE8p6cnDmBc6HWrbSbgynp+c+D5yKH3MfWMcV5jai4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dXVjzxSKwWIJEdyhD3lIyha/uGdXBt9qIVo98UaJsJ7k8633O/8lSKiRtps+hZAL5
	 iaYV3G8twhRdkDr3L6Ehnri4IPjxq2ORhKzs+cOgFgggIlQvaVIiDeFfFTQRYr0Ige
	 qhoB1R42SJkWYQR2g8eCSXpaV5xjFXt3onssruoohAL183Ugp9Thsl9ok9fEfn8ndS
	 32yudsPC62gcsB0+Xs4lcAWLMwGxubtT4fGx2moeu2oOvvpHcLWvJY8PFL6RwDF8Th
	 UwlUUKjn80CkNrLrYJ1u1KY8NH8qAuyADued8RrLESHu6M602AmJFfl+u/Jpe4aN0P
	 ZIYbklhbbOGcw==
Date: Tue, 18 Aug 2026 12:07:05 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: syzbot+891c7b195b408052e519@syzkaller.appspotmail.com,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: ata_generic: Do not bind to devices that are not
 IDE controllers
Message-ID: <aoQuyYsycb4s8mIP@ryzen>
References: <20260818094205.2672967-2-cassel@kernel.org>
 <0543059b-13c4-4b6e-a236-6d37cbb3245e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0543059b-13c4-4b6e-a236-6d37cbb3245e@kernel.org>

On Tue, Aug 18, 2026 at 06:52:45PM +0900, Damien Le Moal wrote:
> On 8/18/26 18:42, Niklas Cassel wrote:
> > syzbot force-bound ata_generic to 0000:00:03.0 on a QEMU arm64 virt
> > machine. That device is a virtio-blk-pci device holding the root file
> > system, and it reports PCI class 0x010000, i.e. PCI_CLASS_STORAGE_SCSI.
> > 
> > QEMU gives the virtio-blk-pci device a legacy virtio I/O BAR0 and a 4 KiB
> > MSI-X BAR1, so both resources are non-empty, the port is not discarded,
> > and the device control register ends up in the middle of the MSI-X table.
> > 
> > The emulated device rejects the byte write, and arm64 reports the
> > resulting bus error as a fatal synchronous external abort:
> > 
> >   Internal error: synchronous external abort: 0000000096000050 [#1]  SMP
> >   pc : ata_sff_freeze+0x7c/0x90 drivers/ata/libata-sff.c:1606
> >   Call trace:
> >    ata_sff_freeze+0x7c/0x90
> >    ata_eh_freeze_port+0x34/0x5c
> >    ata_host_start+0x13c/0x228
> >    ata_pci_sff_activate_host+0x50/0x340
> >    ata_pci_init_one+0x19c/0x1d8
> >    ata_pci_bmdma_init_one+0x14/0x20
> >    ata_generic_init_one+0xc4/0x1ac
> >    local_pci_probe+0x40/0xa8
> >    pci_device_probe+0xd8/0x288
> >    really_probe+0xbc/0x2bc
> >    device_driver_attach+0x48/0xb4
> >    bind_store+0x7c/0xd8
> > 
> > Refuse devices which neither report the IDE class nor appear in our ID
> > table. Table entries keep binding as before, because some of the listed
> > controllers cannot be assumed to report the IDE class. A controller which
> > needs ata_generic but does not report the IDE class should get an ID table
> > entry, which is what the table is for.
> > 
> > Binding a driver to unrelated hardware requires root and is what
> > driver_override is meant to do, so this does not fix a privilege boundary.
> > 
> > This change only stops ata_generic from binding to a PCI device which it
> > has no reason to believe to be an IDE controller.
> > 
> > Reported-by: syzbot+891c7b195b408052e519@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/linux-ide/6a82bc54.10853dc7.22f513.001b.GAE@google.com/
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> Looks sensible to me, and very surprising that this problem was not cought before...
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

I mean, syzbot using driver_override like this is kind of a stupid test.

If you try to use the generic ATA driver for a PCI device that is something
completely different, e.g. an Ethernet controller... you kind of get what
you asked for :)

But it is such a small patch, so I think it makes sense, even if all it
does it to stop us from getting more silly reports like this.


Tell me if you prefer the other patch, which checks BAR type instead.
BAR type I/O is very rare, since it is old x86 legacy.
(But such a patch would still allow someone to bind a PCI device with
BARs marked as type I/O, even if that PCI device does not have storage
class IDE.)


I think the main argument for the patch in $subject... is:
if your PCI device is not class IDE... just add an entry to the match table.
(I.e. we don't care that driver_override will not work with a device that
does not have class IDE... If you really want the driver to work with such
a device, you will have to add an explicit entry to the match table.)


Kind regards,
Niklas
