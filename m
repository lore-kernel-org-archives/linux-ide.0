Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517A23D47D8;
	Tue, 10 Mar 2026 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163668; cv=none; b=XWKWEbCutDvmk3DH3rQ5CAOT57VFbfE4vebqevAInCwMa3QS27r5PFpnibVS5KN1aBGo+rKgwQAoDMofjJPOeXsePvuuImnhWQhNa6wLKE5FvYsaon2xSf6l1J9MJ/RZZzL67BltDXwzjOsgke8WEgjYsFQElHDtkXMy3u0S29c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163668; c=relaxed/simple;
	bh=8k6+2abKwkDQxvLESUhZeMTdTq3ctRr0NHU6ZzwNG2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbQEH0dorGovwDEJPVlwd9nOipYu4NuhBM1cTO1AR5CpiVdSWNsNve2VWFSTAvh/wuOCqDbnPucJC+/aeq5u3l5HlBjZZyoSy919XLqOlSgUu/4kD2IZXkQVM252h2oiOXQjiMPsU3Ysy+fNKUQXZNpVJKXxYFpoICfQmjzz4j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWfGc6mH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWfGc6mH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABFBC19423;
	Tue, 10 Mar 2026 17:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773163668;
	bh=8k6+2abKwkDQxvLESUhZeMTdTq3ctRr0NHU6ZzwNG2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QWfGc6mHhBBzIgpy2Dt8rfnhYuZ3Meom2bpvwMjqYdZNn9aaTHjNV8v2PcnSmKJ0V
	 F0ZBJkB7UbJ6bmJLU8LOp/XZzHY+wVfOr/q3v7ftlk1kQORCgyy2MSm+ax3ELyIOBa
	 Dv1GeNnhFTDKexFZ+IlE50gSaNpuxfNJhURXHRnF6hduWXBw/eOOSafroY3OSFXGM3
	 U4O+OgpX9STq4Xrk0xSqG/EiBY4Lhx3TNqz+8cqLPeTT3UNG1QZdH1W2Lz422iIsiC
	 i+szIuxhpdlG8K0Lzvag1lNerehlEKyiYFxgAwO9DLp1d+WbNonqnXIllmmSZ9ACVG
	 yFwdYTkZwxYNg==
Date: Tue, 10 Mar 2026 18:27:27 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Ruslan Valiyev <linuxoid@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: ahci: Add AMD 600 Series Chipset SATA Controller
 (0x43f6)
Message-ID: <abBUdlxKa4DpVsPI@ryzen>
References: <20260310154956.743071-1-linuxoid@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310154956.743071-1-linuxoid@gmail.com>

Hello Ruslan,

On Tue, Mar 10, 2026 at 03:49:56PM +0000, Ruslan Valiyev wrote:
> Add PCI ID 0x43f6 for the AMD 600 Series Chipset (B850/X870) SATA
> controller to ahci_pci_tbl. Without this entry, the AHCI driver does
> not bind to the controller and SATA devices are invisible at boot.
> 
> Users can work around the issue with:
>   echo "1022 43f6" > /sys/bus/pci/drivers/ahci/new_id
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221193
> Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
> ---
>  drivers/ata/ahci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 931d0081169b9..a4935f9b80789 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -466,6 +466,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AMD Hudson-2 (AHCI mode) */
>  	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>  	{ PCI_VDEVICE(AMD, 0x7901), board_ahci }, /* AMD Green Sardine */
> +	{ PCI_VDEVICE(AMD, 0x43f6), board_ahci }, /* AMD 600 Series Chipset */
>  	/* AMD is using RAID class only for ahci controllers */
>  	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>  	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },

The AHCI driver already has these two entries:

        /* AMD is using RAID class only for ahci controllers */
        { PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
          PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },

and

        /* Generic, PCI class code for AHCI */
        { PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
          PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },


If the ahci driver fails to bind, that means that the class code for this
AMD AHCI contorller is
not PCI_CLASS_STORAGE_RAID and is not PCI_CLASS_STORAGE_SATA_AHCI.


I'm honestly curious... what is the PCI class code of this controller then? :)

My AMD AHCI controller is:
$ lspci -v | grep AHCI
6a:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset SATA Controller (rev 01) (prog-if 01 [AHCI 1.0])

$ sudo lspci -nnvs 6a:00.0
6a:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset SATA Controller [1022:43f6] (rev 01) (prog-if 01 [AHCI 1.0])
        Subsystem: ASMedia Technology Inc. Device [1b21:1062]
        Flags: bus master, fast devsel, latency 0, IRQ 48, IOMMU group 20
        Memory at 81080000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at 81000000 [disabled] [size=512K]
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [70] Power Management version 3
        Capabilities: [80] Express Legacy Endpoint, IntMsgNum 0
        Capabilities: [100] Advanced Error Reporting
        Kernel driver in use: ahci


include/linux/pci_ids.h:#define PCI_CLASS_STORAGE_SCSI          0x0100
include/linux/pci_ids.h:#define PCI_CLASS_STORAGE_IDE           0x0101
include/linux/pci_ids.h:#define PCI_CLASS_STORAGE_FLOPPY        0x0102
include/linux/pci_ids.h:#define PCI_CLASS_STORAGE_IPI           0x0103
include/linux/pci_ids.h:#define PCI_CLASS_STORAGE_RAID          0x0104
include/linux/pci_ids.h:#define PCI_CLASS_STORAGE_SATA          0x0106
include/linux/pci_ids.h:#define PCI_CLASS_STORAGE_SATA_AHCI     0x010601
include/linux/pci_ids.h:#define PCI_CLASS_STORAGE_SAS           0x0107
include/linux/pci_ids.h:#define PCI_CLASS_STORAGE_EXPRESS       0x010802
include/linux/pci_ids.h:#define PCI_CLASS_STORAGE_OTHER         0x0180


Kind regards,
Niklas
