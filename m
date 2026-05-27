Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29E430EF88
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 08:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870465; cv=none; b=ZaSoprGDMxN2UZGrxD986Dx8o8piz+2z7leq+WK9hSrfv2oPBJx83BNN2F6ifRtjVFLX6HDLGNqQmyyBC4ovUsOVlJKDZ3CYm28uQpwNtW4G7HZcWWmOdG3eF2MbIHQexQIYylzoQQpVVjtnZwq32yIrOdCsoZIr3YonRsQuE/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870465; c=relaxed/simple;
	bh=aFR/bkygkce1qVtRmzHsSmms9FR7xUBKLjel9rddf4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DHXJ5T5sX22OOR6A2eWLoFIgBrAAR/Qgxe50N6HQ90ZiTzKIf8FWMBN8Shmeb6IDjTU+uRg5YYCRQuBuyAUlhYSSGig4oqdskHxlk1G+nvivkrbFtfqfFP8ZO7woY67Gxsl4/VhzmfaZMGgbmXVR6/HXBck/I9iLKMIMcH5VMdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGhxaNbs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGhxaNbs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC521F000E9;
	Wed, 27 May 2026 08:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779870463;
	bh=Utgw9sg5AAX9YHaLQVMQMikQe0I1gxqQEYmRjrJ5zy8=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=ZGhxaNbsQ4VWqDHudbwAzQGVTcNgBFqrEoyoeBeAXk5PAfw+ZJLQD0pLhXzV8atsI
	 8Ful/6brMrKfi3AwCm7ec+TpSe2d3MISX7E6Nz3ZWYzMgNzZWZqVCcPTF0lIFzSNDB
	 P6u6PKY4UwO9pC+jg6peNtJtcn0RkGBIq8+KeUB0nkNFOFe4ucjkesAzpZ9QBYNnRp
	 NTKjMzeK+YUp/QT8SeejxaIDpZ4wpnQMBVlocwRtaNJmLo5zBE3sdpig+kXf9ci+H+
	 Gv3ZENeR9SkhKRZWR/gDk1ZM2KiuNw1IBaD7rc3fBWo+NAHxz1sJS7ZebAfioimck6
	 okCpmUb4/L60Q==
Message-ID: <6c4af01f-f57c-4b40-bd99-9746bb062bcf@kernel.org>
Date: Wed, 27 May 2026 17:27:37 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] libata/ahci: three MMIO trust boundary issues under hostile
 hardware model
To: Michael Lazin <microlaser@gmail.com>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <CALdcr8dMyX+ZRj3ARv6iFkLKXL2+onQbhCkX+=rnXKX3o4SDUw@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CALdcr8dMyX+ZRj3ARv6iFkLKXL2+onQbhCkX+=rnXKX3o4SDUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/27/26 12:38 PM, Michael Lazin wrote:
> To the linux-ide maintainers and list,
> 
> Apologies in advance if this hits a moderation queue — I am sending
> from Gmail and am in the process of subscribing to the list. I am a
> Debian developer (debian-devel) with a background in network security.
> I would ask that you judge the technical content on its merits rather
> than the sending domain.
> 
> I have been auditing the AHCI driver against a zero-trust hardware
> model — specifically the threat of malicious or malfunctioning PCIe
> peripherals. I have mapped three issues I believe warrant discussion.
> I can send patches for issues 1 and 2; issue 3 requires broader IOMMU
> policy discussion. All references are against drivers/ata/ in the
> current mainline tree.
> 
> ---
> 
> ISSUE 1: Port map not bounded against cap.np (libahci.c,
> ahci_save_initial_config)
> 
> The driver reads HOST_CAP and HOST_PORTS_IMPL as independent MMIO
> values without enforcing consistency between them. A hostile device
> returning HOST_CAP.np = 0 (implying 1 port) alongside HOST_PORTS_IMPL
> = 0xFFFFFFFF (32 ports asserted) causes the host struct to be
> allocated for one port while the activation loop walks 32, producing
> out-of-bounds reads and writes into adjacent kernel heap objects.
> 
> Proposed fix: after reading both registers, clamp port_map to the
> range implied by cap.np before any allocation or iteration depends on
> it:
> 
>     u32 cap_ports = min((cap & 0x1f) + 1, AHCI_MAX_PORTS);
>     port_map &= GENMASK(cap_ports - 1, 0);
>     if (hweight32(port_map) > cap_ports)
>         port_map = (1U << cap_ports) - 1;

Looks sensible, but we should WARN about a device that has a weird port_map
that shows ports beyond the number of ports.
Note that the reverse is common: number of ports is high, but the port_map is
only a small subset of the max ports.

> ISSUE 2: Unbounded interrupt loop in ahci_thunderx_irq_handler (ahci_thunderx.c)
> 
> The ThunderX handler re-polls interrupt status in a loop without an
> iteration bound. A hostile or malfunctioning controller holding its
> interrupt line asserted permanently can trap the CPU in interrupt
> context indefinitely, causing a hard lockup with no recovery path even
> on systems with the NMI watchdog enabled (detection latency 10–30
> seconds).
> 
> Proposed fix: introduce a loop ceiling (e.g. 64 iterations) with
> disable_irq_nosync and a dev_warn on breach, following the standard
> Linux pattern for interrupt storm handling.

Sounds good.

> ISSUE 3: DMA scope not bounded to allocated buffers (libahci.c, ahci_port_start)
> 
> This is an architectural issue rather than a localized bug. The DMA
> mask configuration tells the kernel what addresses the device can
> address — it does not restrict the device to only the buffers
> allocated for it. Without strict IOMMU mapping (iommu.strict=1,
> available since 5.11), a compromised PCIe AHCI controller can issue
> DMA writes to arbitrary physical addresses, including kernel text.
> 
> The driver-level mitigation is validation of PRDT physical addresses
> against the allocated scatter-gather list in the completion path
> before acting on them. The system-level fix is enforcing strict IOMMU
> domain isolation per device.

This would need a little more digging: ahci_fill_sg() uses the SG list passed
from SCSI layer, but I am not sure if these are built using the dma API to
validate/set the iommu.

> I am happy to follow up with formatted patches for issues 1 and 2 if
> there is interest. Feedback on the framing of issue 3 welcome — I
> recognize it touches policy outside the driver itself.

Please do ! Patches that fix issues and improve the code are always welcome !



-- 
Damien Le Moal
Western Digital Research
