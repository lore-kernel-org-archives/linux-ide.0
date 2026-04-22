Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80983ED5BE;
	Wed, 22 Apr 2026 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868610; cv=none; b=QKvMHuE0yMq0UHqxEaCZbUR7GJ1IZhNs6TfMWZFc6twS+cALBtwTHJ5gjmmZqH9NG+uOCUScw3x9Nhpm8OUHx0e24nuC7zd/yJqOOVuVvpr4NMN9xcTdGueYhPVynTuuv5qA8EUqUitDqvJe0TVZcJs91vB7HqwPDuk4pBL4Us4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868610; c=relaxed/simple;
	bh=xngBYNuEFPfDm+L5D6aKNJLDjNlEOAIX/oY7V8AW1Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFWOv7WxDOR7Ue7appCHboCIOL5PUJ8hgebZuhPFnCzdz25D4a50keeDhxwqiG8laBPlhVahtKaAWSzCnrxCPSZ0em5/BS5OqbdQXwWAY41n1HEbkVOvLyf722hc9r14MIhG7hE/JigqBX5MObb7GSd2EASKMWwBKV3LT7T/wAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNVPX8Bn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNVPX8Bn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A57C19425;
	Wed, 22 Apr 2026 14:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776868610;
	bh=xngBYNuEFPfDm+L5D6aKNJLDjNlEOAIX/oY7V8AW1Yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iNVPX8Bnp45QIxGVfNwfq9hOQOyTx26yBf0p2/tryJJVxhiTJFPfJEi1qOmK89T8q
	 J8Y5mOL4j6yXbCDwhFniHwhB1G6A0n0CmnmaaWOjOveBg7pbQM7jfGOxqOccjOuWOZ
	 IMquv1n7FCIS+1cq3c8uUzEAVrQ3VEE1VuS1tOynMPmPIcJa8lilTSFowWpMtJpKZZ
	 lHX2o34ND3cUUHZvXzwMAi9Y3fsj5uNHBUuc0bPChqs8h0339PI9PxM2C/8bOSGhZg
	 GmyKLd2HwF1+5+0czVrffQvNAbp4x0PNqPhj5rxG+i9ElgXzf0T8zl2F843MqM6O3W
	 FJlO9phs2JfUg==
Date: Wed, 22 Apr 2026 16:36:46 +0200
From: Niklas Cassel <cassel@kernel.org>
To: dayou5941@163.com
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, liyouhong@kylinos.cn
Subject: Re: [PATCH] ata: libahci: fix panic when accessing ports beyond MMIO
 region
Message-ID: <aejc_kqSuU60oRka@ryzen>
References: <20260422080322.1006592-1-dayou5941@163.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422080322.1006592-1-dayou5941@163.com>

Hello liyouhong,

On Wed, Apr 22, 2026 at 04:03:22PM +0800, dayou5941@163.com wrote:
> From: liyouhong <liyouhong@kylinos.cn>
> 
> Commit 18ee7c49f75b ("ata: ahci: Introduce firmware-specific caps
> initialization") introduced a regression where the driver would
> attempt to access port registers beyond the mapped MMIO region when
> HOST_PORTS_IMPL and HOST_CAP contains invalid values.
> 
> This occurs in scenarios where:
> 1. The AHCI controller is disabled by BIOS, causing registers to read
>    as 0xFFFFFFFF.
> 2. HOST_PORTS_IMPL indicates more ports than physically implemented.
> 3. The actual MMIO region is smaller than needed for the indicated
> ports.

I'm not a fan of this patch for two reasons:

1) The AHCI specification, 1.3.1, "10.1.1 Firmware Specific Initialization":

Firmware shall always initialize the following registers and values:
 CAP.SSS (support for staggered spin-up)
 CAP.SMPS (support for mechanical presence switches)
 PI (ports implemented)
  ...

Thus, it is a spec violation to not initialize these registers correctly.

If you have an AHCI controller that is a PCIe card, it will surely expose
the Ports Implemented register correctly.

So this problem should be limited to on-boad AHCI controllers, where
BIOS/platform firmware has violated the specification, and not initialized
the registers required by the specification.

If you can disable the controller via BIOS, then the most logical thing is
for these on-boards AHCI controllers to actually get disabled and not show
up in lspci at all. As far as I know, that is how it works on Intel and
AMD systems.


2) Why limit this to AHCI controllers connected via PCI?

Surely device tree platforms with a AHCI controller connected directly to
the AXI bus can also violate the specification and not initialize the PI
(Ports Implemented) register.

Sure, for AHCI controllers connected without a PCI bus, there is the
"ports-implemented" device tree property, that can be used to initialize
this register correctly for platforms without any embedded firmware.

But if we should implement a workaround, why add code that is explcitly
limited to PCI?




I think a better solution is to limit Ports Implemented to CAP.NP.
As Ports Implemented is a bitmask with up to CAP.NP bits.

Ports Implemented is not allowed to be larger than CAP.NP, it can
only mark ports within the CAP.NP MMIO region as "unimplemented".

So the highest bit set in Ports Implemented can not be higher than CAP.NP.
(I.e. a per port MMIO offset is not allowed to be larger than
CAP.NP * MMIO registers per port.)


Looking at the libata code, it looks like we have code for this already:
https://github.com/torvalds/linux/blob/v7.0/drivers/ata/libahci.c#L561-L569

Could you perhaps debug to see why this code in no longer working as
intended?

If you revert 18ee7c49f75b ("ata: ahci: Introduce firmware-specific caps
initialization"), do you see the
"implemented port map (0x%lx) contains more ports than nr_ports (%u), using nr_ports"
warning in the log?

Please share the equivalent to these prints after reverting the commit:
[1825468.337982] ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 Gbps, SATA mode
[1825468.350108] ahci 0000:00:17.0: 8/8 ports implemented (port mask 0xff)


> When mmio_size is 0x1000 and all ports need to be accessed.
> The issue manifests as a panic in __raw_readl() when i=30, as the
> calculated offset (0x1000) equals the typical MMIO region size (0x1000),
> placing the access exactly at the boundary of the mapped region.

AFAICT, port_map gets limited to CAP.NP, and we only access ports that are
within port_map (and this offset < CAP.NP):

	for_each_set_bit(i, &port_map, AHCI_MAX_PORTS) {
		if (hpriv->saved_port_cap[i])
			continue;

		port_mmio = __ahci_port_base(hpriv, i);



Wait a second:

> 3. The actual MMIO region is smaller than needed for the indicated
> ports.

I hope you are not saying that your PCI device is only exposing a BAR
that is smaller than needed to contain the number of ports defined in
CAP.NP in this controller?

That sounds like a seriously buggy controller...

Could you please share the output of (with the PCI BDF of you controller
of course):

$ sudo lspci -vvvnns 0000:00:17.0
00:17.0 SATA controller [0106]: Intel Corporation C620 Series Chipset Family SATA Controller [AHCI mode] [8086:a182] (rev 0a) (prog-if 01 [AHCI 1.0])
        Subsystem: Super Micro Computer Inc Device [15d9:1b62]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 138
        NUMA node: 0
        IOMMU group: 28
        Region 0: Memory at a5984000 (32-bit, non-prefetchable) [size=8K]
        Region 1: Memory at a598a000 (32-bit, non-prefetchable) [size=256]
        Region 2: I/O ports at 4050 [size=8]
        Region 3: I/O ports at 4040 [size=4]
        Region 4: I/O ports at 4000 [size=32]
        Region 5: Memory at a5700000 (32-bit, non-prefetchable) [size=512K]

So we can see PCI vendor ID, PCI device ID, and size of the BARs?

From 3.3 Port Registers (one set per port):

Port offset = 100h + (PI Asserted Bit Position * 80h)

CAP.NP can represent at most 32 ports. (Note that the register field itself
is 0's based, so a value of 0 means 1 port and a value of 31 means 32 ports.)

If you really have 32 ports, then you would need a BAR that has size:
0x100+(31*0x80) + 0x80 (start offset + size of the per port register itself): 0x1100

Then we would need to add a quirk for your PCI device and PCI vendor ID,
which limits the number of ports to 30 (by setting CAP.NP to 29) for your
AHCI controller.


Kind regards,
Niklas
