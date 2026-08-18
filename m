Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5C93911B8
	for <linux-ide@vger.kernel.org>; Tue, 18 Aug 2026 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046930; cv=none; b=kqEAMjQV57JFjbaakP6jqc1a1PythUJC5EPxyfClxya2TCxbCoeVct+b3EYX+YYPFFNfYzJ1qCVdnLvbc/WjGH2yi2C0PBMFCLn876wjmm5cckqZESHqrjWDTDteTEiSbS7+47eGoAQpoi5frAqZtjL51xTlB63/E/d8GksX6NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046930; c=relaxed/simple;
	bh=P4EA8ek5ifzcAvItDpuMxu5fq+zMTarDq2uI3bLP/uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8bqqk2oKFdn46DpqS3AgkyDBCspO5V6jwFSlbx7ujtBR0drMbNPsM0SyZxk5TiXYqgrXIx46DX6LWvkUmXMO36xOn/F/z5XArIvgkLCXrqtSC0EZ6jGDeAlBtg/4o+ue/JDsVc8DjZGsJEg3h5DmcBj4D3KgJiJlHaqgDlXs70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CL5pC73Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CL5pC73Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174821F000E9;
	Tue, 18 Aug 2026 09:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787046928;
	bh=vQZ4T0XE8cETK98PP7F2X4jrTUKIm5mYzfa25IvIjtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CL5pC73Y+aPsVQZnxev+k5BA0hAmE7lc8q5S5AnOien9luf+k9g34Ma3bUirpNyJk
	 W9Y6YxKq/ULCqhgg5BX7pc8W9LaK+LRbrHkl2flxKWfHnCIGMe/eKNaoIEO8eEvpG0
	 7dIvdRxp/Ll+ZSxQEYIigblgkH0Zvwe8iupj6PeUHzpTSeN6QQpXrLNRjT64t2VbNS
	 WXtmbxtLHEA1Co/AJ2ZQ43TVvZ8reIqkq+VFG45vT3OEpPxDBvQ4ysgzQrLGCUWHKB
	 7/koShKqy8h7QcU5hFJ7BCDGL2NQGhjtsLeXfwLEh+m+067ywl2cuxYI3K/hCO4j9Q
	 Pya+vSNXHhROQ==
Date: Tue, 18 Aug 2026 11:55:25 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: syzbot+891c7b195b408052e519@syzkaller.appspotmail.com,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: ata_generic: Do not bind to devices that are not
 IDE controllers
Message-ID: <aoQsDQI5eKUHCrMj@ryzen>
References: <20260818094205.2672967-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818094205.2672967-2-cassel@kernel.org>

On Tue, Aug 18, 2026 at 11:42:05AM +0200, Niklas Cassel wrote:
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
> ---
>  drivers/ata/ata_generic.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
> index e70b6c089cf1..f57db4480ad3 100644
> --- a/drivers/ata/ata_generic.c
> +++ b/drivers/ata/ata_generic.c
> @@ -150,6 +150,9 @@ static int is_intel_ider(struct pci_dev *dev)
>	return 1;
>  }
>
> +/* Forward declaration for the pci_match_id() call in ata_generic_init_one() */
> +static const struct pci_device_id ata_generic[];
> +
>  /**
>   *	ata_generic_init_one		-	attach generic IDE
>   *	@dev: PCI device found
> @@ -172,6 +175,19 @@ static int ata_generic_init_one(struct pci_dev *dev, const struct pci_device_id
>	};
>	const struct ata_port_info *ppi[] = { &info, NULL };
>
> +	/*
> +	 * A device matched through driver_override or through an ID added
> +	 * with new_id does not come from our ID table, so pci_match_device()
> +	 * hands us a synthetic ID with no driver_data and none of the checks
> +	 * below apply. Probing maps BAR0 and BAR1 as the ATA command and
> +	 * control blocks and writes to the device control register, so only
> +	 * continue for devices which report the IDE class or which we list
> +	 * ourselves.
> +	 */
> +	if (!pci_match_id(ata_generic, dev) &&
> +	    (dev->class >> 8) != PCI_CLASS_STORAGE_IDE)
> +		return -ENODEV;
> +
>	/* Don't use the generic entry unless instructed to do so */
>	if ((id->driver_data & ATA_GEN_CLASS_MATCH) && all_generic_ide == 0)
>		return -ENODEV;
> --
> 2.55.0
>

Another suggested patch is to something like:


--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2115,6 +2115,14 @@ static bool ata_resources_present(struct pci_dev *pdev, int port)
	/* Check the PCI resources for this channel are enabled */
	port *= 2;
	for (i = 0; i < 2; i++) {
+               /*
+                * The command and control blocks of a native mode PCI IDE
+                * controller are I/O resources, as are the legacy mode
+                * resources which the PCI core fabricates for compatibility
+                * mode controllers.  A memory resource is not a taskfile.
+                */
+               if (!(pci_resource_flags(pdev, port + i) & IORESOURCE_IO))
+                       return false;

Since IDE controllers always have BAR0 and BAR1 as IORESOURCE_IO and not
IORESOURCE_MEM.

Verified that:
ata_generic, ata_piix, pata_rdc and the ~40 other pata_* PCI drivers,
plus sata_nv, sata_sis, sata_uli, sata_via (vt6420/vt8251) all use I/O BARs
for the register blocks.


That would still allow someone to use driver_override to bind a PCI device
that has class code != PCI_CLASS_STORAGE_IDE, but would still fail e.g.
a virtio-pci device, which has the BARs of type MEM and not type I/O.


Kind regards,
Niklas
