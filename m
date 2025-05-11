Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6B733987
	for <linux-ide@vger.kernel.org>; Sun, 11 May 2025 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746989748; cv=none; b=hjsATcxeAhp+mV0qlezAhp5VfXIOePf4gbTkN7lUsPLL1KZ+QzZuOElmhnI0EfSxjUNZg8PnR4o4WWiIWBRUZ7Hi6M9NUU5Lj8iXvlgdtI/74WTVjva3JeXbaA9sBlM3+yHwjGm9bbnq7gGheadobkjxMQG/JayEV1kfTqgRZ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746989748; c=relaxed/simple;
	bh=qk0P1AebyP0iyl3rh749JdXgSav2hEtAZZcfAdaPtyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppXQHcrQWHIYOdtNjBi0FO1khD3XulfLMn5r0houp5dSQq+7pIkVZclodz4yJNyD+5t7ZlMX35e2lKDLuyqo+tcADpinX1yNlJUfvZEG56dqp4ZtnRSG+WpCOHjDCbWl3Ee7rSRYZRFUjGAJIdnGn+9PqLPFZEgzyIz1+USsl4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdYVGz6X; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdYVGz6X"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e740a09eb00so3538254276.0
        for <linux-ide@vger.kernel.org>; Sun, 11 May 2025 11:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746989741; x=1747594541; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u23do5CMbk1KYZA+Hc6cXz2bjQNEzbsDzBDRV2PW0zI=;
        b=SdYVGz6Xqoy3++xf7gUafIgeB/CPYBGIAad4834TgK6rdfIN9f0ooLL09SR6DRx3zI
         NNO5tLdg55/igf07uNJ0eoPZXyyGZPDpaY8bF5RGIfn4Es1RuR43NkZuflcLkOMv4w8x
         Huj25tHopGml1/ce3oNG75UBDgaRKNkj41T56KG+5Tlxfpbd2WKySWjB1zVRk2qU4oL4
         0ESeIJzYzSVpYzBC1bpvGtHHgbV3G+rWFMsSe8cVWnNI33C+SsifCb4pmcfCOUkRCHwX
         tahYO23X6dytPAmyrxd4JGCfYMslGxxcVGvyMOAboDMvw1IQ8KXwUCNf8kttIVyPEMQA
         nGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746989741; x=1747594541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u23do5CMbk1KYZA+Hc6cXz2bjQNEzbsDzBDRV2PW0zI=;
        b=cAjmeVhAH1bcW/69syx4QeOYfvRWW/NOL14ovkZsp/ZnM3OjMJHlJyjz4PY8V0NLjo
         uPNyEXRXrjWDrkGUFjxfDmicMT8+AQZazrvY5UAyJIU4Q0K6+90J7ETctBDBMGKroDOM
         z5tolO3SlTgRZwa+OQ4X0jl1RxUz0F8guMKivgwDEHi0VO2lBWa8NKFP0K86Qn+51Hka
         AiWfzt6/u2jCDHbJ8IS8FBkkj7owDuSAOYiVNJPhqGsx+ceknP9MJktBaey6sCLzzePz
         v0Mu845tDz0F5pbSjPvkH2eQKx6MT4phfoi97WY4sPS+0kYulucs2gaizJ1mfKK4ko4+
         +Dxw==
X-Forwarded-Encrypted: i=1; AJvYcCUtnY2WKGoWk047OPuaLKIFpz5+/e4fz0rGUkhlz2cjD1dF4IJo/QemGmStM7cokXkxInqRco5cRZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQhPik7KjgCCiWA0mKp3ZOfg8xNlX9ri91/gJsLmkl1cCPAptp
	wc8SS89BNZJ7XEdiQ3ELDJHo0k7yXHTrCFr+IR9LXCqQ+qYg0FpciYnd+ZXDOA0nFxyeVluIPFg
	MbDHazMeQ08kI37Y2FBxFl8MFpxAsBtVr
X-Gm-Gg: ASbGncvIf6ZCzKBILkbS3CbixrQh9aC7sIuabTdGtFlJkD62pgTdPnifqSQrv3rtbLK
	juT7ga5PiTTn5U3jI2S4/yFirOWUwadEVqKUOWA+hLOKTzrGo3RlALfCyKLUVVfapK7jzydEhN/
	XdmZNuc6bWThZ5S8wFkn8WAXJgT7/fxO1KJw==
X-Google-Smtp-Source: AGHT+IHkq26PuWO350qTha5TPmr7X8O9RUDCIAfStasohDEU+54QEl0qxQ/zwBv0Pbgyrp2gXjUr+baC//3pSNKTA6k=
X-Received: by 2002:a05:6902:1609:b0:e7a:b192:e5c2 with SMTP id
 3f1490d57ef6-e7ab192ee6bmr4639217276.19.1746989740436; Sun, 11 May 2025
 11:55:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADUzMVbneDW06V4vd8si8k=NN_6df3JeejaF3fVk2U=LVC1UHA@mail.gmail.com>
 <fe406980-f230-4060-9b1a-16295b6cfa48@kernel.org> <88a6fb5f-dc85-41e0-a65d-92704b4c8499@kernel.org>
 <CAAZ0mTeepp7G9CtLFq+U_n0h2+SF8V8j2K=0hkNAp0Fzdc7TAQ@mail.gmail.com>
 <aBjbSt5hTaUP_JhG@ryzen> <CAAZ0mTctoC5UCsDVH56x5OS_500URheBU66USNuq+rwktLrEiw@mail.gmail.com>
 <e1450eab-e8f0-4519-9e9f-9bf52a51c2ee@kernel.org>
In-Reply-To: <e1450eab-e8f0-4519-9e9f-9bf52a51c2ee@kernel.org>
From: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Date: Sun, 11 May 2025 21:55:04 +0300
X-Gm-Features: AX0GCFu90GjllZNPyEXdIYDvUFINoeQ6nuekRnP_GDOqWAUjInP4Qn7Qb9-0-tk
Message-ID: <CAAZ0mTeH4AOa9Y56TR+QkjAZgac5g_tVy4Gv27Eto+48DF_dgw@mail.gmail.com>
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>, linux-ide@vger.kernel.org, 
	Niklas Cassel <Niklas.Cassel@wdc.com>
Content-Type: text/plain; charset="UTF-8"

ke 7.5.2025 klo 12.00 Damien Le Moal (dlemoal@kernel.org) kirjoitti:
>
> On 5/6/25 2:09 AM, Mikko Juhani Korhonen wrote:
> > ma 5.5.2025 klo 18.37 Niklas Cassel (cassel@kernel.org) kirjoitti:
> >
> >> On Mon, May 05, 2025 at 10:58:22AM +0300, Mikko Juhani Korhonen wrote:
> >>>>> On 5/1/25 05:36, Ioannis Barkas wrote:
> >>>>>> It would be better to have more details on this since only the 2TB
> >>>>>> model is targeted.
> >>> I have two WD20EFAX-68FB5N0 and both behave consistently, unusable
> >>> from 6.9.0 on as they just keep resetting the SATA link , but they
> >>> have worked flawlessly with 6.8.x for a year and also now with the
> >>> quirk applied.
> >>> I have also tested a different WDC model with med_power_with_dipm on
> >>> the same SATA port and there are no problems.
> >>> But after you guys got suspicious I found there is in fact a SATA port
> >>> on my motherboard where the WD20EFAX-68FB5N0 works with LPM on
> >> This motherboard looks to be AMD chipset, so I assume AMD AHCI controller.
> >>
> >> Could you send the output of:
> >> $ lspci -nn | grep -E "SATA|AHCI"
> >
> > mjkorhon@taavi:~$ sudo lspci -nn | grep -E "SATA|AHCI"
> > 01:00.1 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] 500
> > Series Chipset SATA Controller [1022:43eb]
>
> Mikko,
>
> could you also please try this patch on top of a vanilla 6.15 kernel (no quirk
> patch applied) ?
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 163ac909bd06..a09b7b825780 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -52,6 +52,7 @@ enum board_ids {
>         board_ahci_ign_iferr,
>         board_ahci_no_debounce_delay,
>         board_ahci_no_msi,
> +       board_ahci_no_dipm,
>         /*
>          * board_ahci_pcs_quirk is for legacy Intel platforms.
>          * Modern Intel platforms should use board_ahci instead.
> @@ -152,6 +153,12 @@ static const struct ata_port_info ahci_port_info[] = {
>                 .udma_mask      = ATA_UDMA6,
>                 .port_ops       = &ahci_ops,
>         },
> +       [board_ahci_no_dipm] = {
> +               .flags          = AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
> +               .pio_mask       = ATA_PIO4,
> +               .udma_mask      = ATA_UDMA6,
> +               .port_ops       = &ahci_ops,
> +       },
>         [board_ahci_no_msi] = {
>                 AHCI_HFLAGS     (AHCI_HFLAG_NO_MSI),
>                 .flags          = AHCI_FLAG_COMMON,
> @@ -466,6 +473,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>         { PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AMD
> Hudson-2 (AHCI mode) */
>         { PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>         { PCI_VDEVICE(AMD, 0x7901), board_ahci }, /* AMD Green Sardine */
> +       { PCI_VDEVICE(AMD, 0x43EB), board_ahci_no_dipm }, /* 500 Series Chipset */
>         /* AMD is using RAID class only for ahci controllers */
>         { PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>           PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
>
>
> --
> Damien Le Moal
> Western Digital Research

Hello Damien,
Yes this seems to work (sorry accidentally on top of 6.14, I can try
on top 6.15).
-------------------
[    0.000000] Linux version 6.14.5ahci-no-dipm (mjkorhon@taavi) (gcc
(Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #6
SMP PREEMPT_DYNAMIC Sun May 11 20:11:30 EEST 2025
[    0.000000] Command line:
BOOT_IMAGE=/boot/vmlinuz-6.14.5ahci-no-dipm
root=UUID=c056bf20-f617-4c4a-8d3c-28ac04ff6a3a ro lockdown=integrity
splash
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009d1efff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009d1f000-0x0000000009ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a210fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000000a211000-0x000000000affffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000b000000-0x000000000b01ffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000b020000-0x00000000c3276fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000c3277000-0x00000000c3277fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000c3278000-0x00000000c9e43fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000c9e44000-0x00000000ca1fafff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ca1fb000-0x00000000ca3bcfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000ca3bd000-0x00000000cab5bfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cab5c000-0x00000000cb9fefff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cb9ff000-0x00000000ccffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cd000000-0x00000000cfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd200000-0x00000000fd2fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd600000-0x00000000fd7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fea00000-0x00000000fea0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feb80000-0x00000000fec01fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec30000-0x00000000fec30fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedc2000-0x00000000fedcffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedd4000-0x00000000fedd5fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000082f2fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000082f300000-0x000000082fffffff] reserved
[    0.000000] Kernel is locked down from command line; see man
kernel_lockdown.7
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] e820: update [mem 0xabc75018-0xabc84067] usable ==> usable
[    0.000000] e820: update [mem 0xabc55018-0xabc74a57] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem
0x0000000000000000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem
0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem
0x0000000000100000-0x0000000009d1efff] usable
[    0.000000] reserve setup_data: [mem
0x0000000009d1f000-0x0000000009ffffff] reserved
[    0.000000] reserve setup_data: [mem
0x000000000a000000-0x000000000a1fffff] usable
[    0.000000] reserve setup_data: [mem
0x000000000a200000-0x000000000a210fff] ACPI NVS
[    0.000000] reserve setup_data: [mem
0x000000000a211000-0x000000000affffff] usable
[    0.000000] reserve setup_data: [mem
0x000000000b000000-0x000000000b01ffff] reserved
[    0.000000] reserve setup_data: [mem
0x000000000b020000-0x00000000abc55017] usable
[    0.000000] reserve setup_data: [mem
0x00000000abc55018-0x00000000abc74a57] usable
[    0.000000] reserve setup_data: [mem
0x00000000abc74a58-0x00000000abc75017] usable
[    0.000000] reserve setup_data: [mem
0x00000000abc75018-0x00000000abc84067] usable
[    0.000000] reserve setup_data: [mem
0x00000000abc84068-0x00000000c3276fff] usable
[    0.000000] reserve setup_data: [mem
0x00000000c3277000-0x00000000c3277fff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000c3278000-0x00000000c9e43fff] usable
[    0.000000] reserve setup_data: [mem
0x00000000c9e44000-0x00000000ca1fafff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000ca1fb000-0x00000000ca3bcfff] ACPI data
[    0.000000] reserve setup_data: [mem
0x00000000ca3bd000-0x00000000cab5bfff] ACPI NVS
[    0.000000] reserve setup_data: [mem
0x00000000cab5c000-0x00000000cb9fefff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000cb9ff000-0x00000000ccffffff] usable
[    0.000000] reserve setup_data: [mem
0x00000000cd000000-0x00000000cfffffff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000f0000000-0x00000000f7ffffff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000fd200000-0x00000000fd2fffff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000fd600000-0x00000000fd7fffff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000fea00000-0x00000000fea0ffff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000feb80000-0x00000000fec01fff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000fec30000-0x00000000fec30fff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000fed40000-0x00000000fed44fff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000fedc2000-0x00000000fedcffff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000fedd4000-0x00000000fedd5fff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem
0x0000000100000000-0x000000082f2fffff] usable
[    0.000000] reserve setup_data: [mem
0x000000082f300000-0x000000082fffffff] reserved
[    0.000000] efi: EFI v2.7 by American Megatrends
[    0.000000] efi: ACPI=0xca3bc000 ACPI 2.0=0xca3bc014
TPMFinalLog=0xcab11000 SMBIOS=0xcb7f0000 SMBIOS 3.0=0xcb7ef000
MEMATTR=0xc59c9818 ESRT=0xc64d1898 MOKvar=0xcb84c000 INITRD=0xc08a2a98
RNG=0xca3a3c18 TPMEventLog=0xca245018
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem83: MMIO range=[0xf0000000-0xf7ffffff]
(128MB) from e820 map
[    0.000000] e820: remove [mem 0xf0000000-0xf7ffffff] reserved
[    0.000000] efi: Remove mem84: MMIO range=[0xfd200000-0xfd2fffff]
(1MB) from e820 map
[    0.000000] e820: remove [mem 0xfd200000-0xfd2fffff] reserved
[    0.000000] efi: Remove mem85: MMIO range=[0xfd600000-0xfd7fffff]
(2MB) from e820 map
[    0.000000] e820: remove [mem 0xfd600000-0xfd7fffff] reserved
[    0.000000] efi: Not removing mem86: MMIO
range=[0xfea00000-0xfea0ffff] (64KB) from e820 map
[    0.000000] efi: Remove mem87: MMIO range=[0xfeb80000-0xfec01fff]
(0MB) from e820 map
[    0.000000] e820: remove [mem 0xfeb80000-0xfec01fff] reserved
[    0.000000] efi: Not removing mem88: MMIO
range=[0xfec10000-0xfec10fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem89: MMIO
range=[0xfec30000-0xfec30fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem90: MMIO
range=[0xfed00000-0xfed00fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem91: MMIO
range=[0xfed40000-0xfed44fff] (20KB) from e820 map
[    0.000000] efi: Not removing mem92: MMIO
range=[0xfed80000-0xfed8ffff] (64KB) from e820 map
[    0.000000] efi: Not removing mem93: MMIO
range=[0xfedc2000-0xfedcffff] (56KB) from e820 map
[    0.000000] efi: Not removing mem94: MMIO
range=[0xfedd4000-0xfedd5fff] (8KB) from e820 map
[    0.000000] efi: Remove mem95: MMIO range=[0xff000000-0xffffffff]
(16MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.3.0 present.
[    0.000000] DMI: ASUS System Product Name/ROG STRIX B550-F GAMING
(WI-FI), BIOS 3621 01/13/2025
[    0.000000] DMI: Memory slots populated: 2/4
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3792.762 MHz processor
[    0.000483] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000485] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000494] last_pfn = 0x82f300 max_arch_pfn = 0x400000000
[    0.000499] MTRR map: 7 entries (3 fixed + 4 variable; max 20),
built from 9 variable MTRRs
[    0.000500] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.000934] e820: update [mem 0xca550000-0xca55ffff] usable ==> reserved
[    0.000938] e820: update [mem 0xd0000000-0xffffffff] usable ==> reserved
[    0.000942] last_pfn = 0xcd000 max_arch_pfn = 0x400000000
[    0.004573] esrt: Reserving ESRT space from 0x00000000c64d1898 to
0x00000000c64d18d0.
[    0.004579] e820: update [mem 0xc64d1000-0xc64d1fff] usable ==> reserved
[    0.004597] Using GB pages for direct mapping
[    0.005725] Secure boot enabled
[    0.005726] RAMDISK: [mem 0xabc85000-0xb3a27fff]
[    0.006017] ACPI: Early table checksum verification disabled
[    0.006020] ACPI: RSDP 0x00000000CA3BC014 000024 (v02 ALASKA)
[    0.006023] ACPI: XSDT 0x00000000CA3BB728 0000D4 (v01 ALASKA A M I
  01072009 AMI  01000013)
[    0.006028] ACPI: FACP 0x00000000CA3B4000 000114 (v06 ALASKA A M I
  01072009 AMI  00010013)
[    0.006031] ACPI: DSDT 0x00000000CA3A8000 00B15E (v02 ALASKA A M I
  01072009 INTL 20120913)
[    0.006033] ACPI: FACS 0x00000000CAB41000 000040
[    0.006035] ACPI: SSDT 0x00000000CA3BA000 00092A (v02 AMD
AmdTable 00000002 MSFT 04000000)
[    0.006037] ACPI: SSDT 0x00000000CA3B6000 003B8E (v02 AMD    AMD
AOD  00000001 INTL 20120913)
[    0.006039] ACPI: SSDT 0x00000000CA3B5000 000309 (v02 ALASKA
CPUSSDT  01072009 AMI  01072009)
[    0.006041] ACPI: FIDT 0x00000000CA3A7000 00009C (v01 ALASKA A M I
  01072009 AMI  00010013)
[    0.006042] ACPI: MCFG 0x00000000CA3A5000 00003C (v01 ALASKA A M I
  01072009 MSFT 00010013)
[    0.006044] ACPI: HPET 0x00000000CA3A4000 000038 (v01 ALASKA A M I
  01072009 AMI  00000005)
[    0.006046] ACPI: IVRS 0x00000000CA3A2000 0000D0 (v02 AMD
AmdTable 00000001 AMD  00000001)
[    0.006048] ACPI: BGRT 0x00000000CA3A1000 000038 (v01 ALASKA A M I
  01072009 AMI  00010013)
[    0.006050] ACPI: WPBT 0x00000000CA26B000 00003C (v01 ALASKA A M I
  00000001 ASUS 00000001)
[    0.006051] ACPI: TPM2 0x00000000CA26A000 00004C (v04 ALASKA A M I
  00000001 AMI  00000000)
[    0.006053] ACPI: PCCT 0x00000000CA269000 00006E (v02 AMD
AmdTable 00000001 AMD  00000001)
[    0.006055] ACPI: SSDT 0x00000000CA262000 0061A3 (v02 AMD
AmdTable 00000001 AMD  00000001)
[    0.006056] ACPI: CRAT 0x00000000CA260000 0016D0 (v01 AMD
AmdTable 00000001 AMD  00000001)
[    0.006058] ACPI: CDIT 0x00000000CA25F000 000029 (v01 AMD
AmdTable 00000001 AMD  00000001)
[    0.006060] ACPI: SSDT 0x00000000CA25E000 000259 (v02 AMD
ArticDGP 00000001 INTL 20120913)
[    0.006062] ACPI: SSDT 0x00000000CA25A000 003E6E (v02 AMD    ArticN
  00000001 INTL 20120913)
[    0.006063] ACPI: WSMT 0x00000000CA259000 000028 (v01 ALASKA A M I
  01072009 AMI  00010013)
[    0.006065] ACPI: APIC 0x00000000CA258000 00015E (v04 ALASKA A M I
  01072009 AMI  00010013)
[    0.006067] ACPI: SSDT 0x00000000CA257000 00007D (v02 AMD
ArticDIS 00000001 INTL 20120913)
[    0.006068] ACPI: SSDT 0x00000000CA256000 0000BF (v01 AMD
AmdTable 00001000 INTL 20120913)
[    0.006070] ACPI: FPDT 0x00000000CA255000 000044 (v01 ALASKA A M I
  01072009 AMI  01000013)
[    0.006072] ACPI: Reserving FACP table memory at [mem 0xca3b4000-0xca3b4113]
[    0.006072] ACPI: Reserving DSDT table memory at [mem 0xca3a8000-0xca3b315d]
[    0.006073] ACPI: Reserving FACS table memory at [mem 0xcab41000-0xcab4103f]
[    0.006074] ACPI: Reserving SSDT table memory at [mem 0xca3ba000-0xca3ba929]
[    0.006074] ACPI: Reserving SSDT table memory at [mem 0xca3b6000-0xca3b9b8d]
[    0.006075] ACPI: Reserving SSDT table memory at [mem 0xca3b5000-0xca3b5308]
[    0.006075] ACPI: Reserving FIDT table memory at [mem 0xca3a7000-0xca3a709b]
[    0.006076] ACPI: Reserving MCFG table memory at [mem 0xca3a5000-0xca3a503b]
[    0.006076] ACPI: Reserving HPET table memory at [mem 0xca3a4000-0xca3a4037]
[    0.006077] ACPI: Reserving IVRS table memory at [mem 0xca3a2000-0xca3a20cf]
[    0.006077] ACPI: Reserving BGRT table memory at [mem 0xca3a1000-0xca3a1037]
[    0.006078] ACPI: Reserving WPBT table memory at [mem 0xca26b000-0xca26b03b]
[    0.006078] ACPI: Reserving TPM2 table memory at [mem 0xca26a000-0xca26a04b]
[    0.006079] ACPI: Reserving PCCT table memory at [mem 0xca269000-0xca26906d]
[    0.006079] ACPI: Reserving SSDT table memory at [mem 0xca262000-0xca2681a2]
[    0.006080] ACPI: Reserving CRAT table memory at [mem 0xca260000-0xca2616cf]
[    0.006080] ACPI: Reserving CDIT table memory at [mem 0xca25f000-0xca25f028]
[    0.006081] ACPI: Reserving SSDT table memory at [mem 0xca25e000-0xca25e258]
[    0.006081] ACPI: Reserving SSDT table memory at [mem 0xca25a000-0xca25de6d]
[    0.006082] ACPI: Reserving WSMT table memory at [mem 0xca259000-0xca259027]
[    0.006082] ACPI: Reserving APIC table memory at [mem 0xca258000-0xca25815d]
[    0.006083] ACPI: Reserving SSDT table memory at [mem 0xca257000-0xca25707c]
[    0.006083] ACPI: Reserving SSDT table memory at [mem 0xca256000-0xca2560be]
[    0.006084] ACPI: Reserving FPDT table memory at [mem 0xca255000-0xca255043]
[    0.006134] No NUMA configuration found
[    0.006134] Faking a node at [mem 0x0000000000000000-0x000000082f2fffff]
[    0.006141] NODE_DATA(0) allocated [mem 0x82f2d5680-0x82f2fffff]
[    0.006341] Zone ranges:
[    0.006341]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.006342]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.006343]   Normal   [mem 0x0000000100000000-0x000000082f2fffff]
[    0.006344]   Device   empty
[    0.006345] Movable zone start for each node
[    0.006346] Early memory node ranges
[    0.006347]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.006348]   node   0: [mem 0x0000000000100000-0x0000000009d1efff]
[    0.006348]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
[    0.006349]   node   0: [mem 0x000000000a211000-0x000000000affffff]
[    0.006349]   node   0: [mem 0x000000000b020000-0x00000000c3276fff]
[    0.006350]   node   0: [mem 0x00000000c3278000-0x00000000c9e43fff]
[    0.006351]   node   0: [mem 0x00000000cb9ff000-0x00000000ccffffff]
[    0.006351]   node   0: [mem 0x0000000100000000-0x000000082f2fffff]
[    0.006354] Initmem setup node 0 [mem 0x0000000000001000-0x000000082f2fffff]
[    0.006360] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.006373] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.006485] On node 0, zone DMA32: 737 pages in unavailable ranges
[    0.006496] On node 0, zone DMA32: 17 pages in unavailable ranges
[    0.009932] On node 0, zone DMA32: 32 pages in unavailable ranges
[    0.010078] On node 0, zone DMA32: 1 pages in unavailable ranges
[    0.010162] On node 0, zone DMA32: 7099 pages in unavailable ranges
[    0.010438] On node 0, zone Normal: 12288 pages in unavailable ranges
[    0.010463] On node 0, zone Normal: 3328 pages in unavailable ranges
[    0.010656] ACPI: PM-Timer IO Port: 0x808
[    0.010664] CPU topo: Ignoring hot-pluggable APIC ID 0 in present package.
[    0.010667] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.010679] IOAPIC[0]: apic_id 25, version 33, address 0xfec00000, GSI 0-23
[    0.010684] IOAPIC[1]: apic_id 26, version 33, address 0xfec01000, GSI 24-55
[    0.010686] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.010687] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.010690] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.010691] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.010700] e820: update [mem 0xc53ae000-0xc54a1fff] usable ==> reserved
[    0.010716] CPU topo: Max. logical packages:   1
[    0.010717] CPU topo: Max. logical dies:       1
[    0.010717] CPU topo: Max. dies per package:   1
[    0.010721] CPU topo: Max. threads per core:   2
[    0.010721] CPU topo: Num. cores per package:    12
[    0.010722] CPU topo: Num. threads per package:  24
[    0.010722] CPU topo: Allowing 24 present CPUs plus 0 hotplug CPUs
[    0.010723] CPU topo: Rejected CPUs 8
[    0.010747] PM: hibernation: Registered nosave memory: [mem
0x00000000-0x00000fff]
[    0.010748] PM: hibernation: Registered nosave memory: [mem
0x000a0000-0x000fffff]
[    0.010750] PM: hibernation: Registered nosave memory: [mem
0x09d1f000-0x09ffffff]
[    0.010751] PM: hibernation: Registered nosave memory: [mem
0x0a200000-0x0a210fff]
[    0.010752] PM: hibernation: Registered nosave memory: [mem
0x0b000000-0x0b01ffff]
[    0.010754] PM: hibernation: Registered nosave memory: [mem
0xc3277000-0xc3277fff]
[    0.010755] PM: hibernation: Registered nosave memory: [mem
0xc53ae000-0xc54a1fff]
[    0.010756] PM: hibernation: Registered nosave memory: [mem
0xc64d1000-0xc64d1fff]
[    0.010758] PM: hibernation: Registered nosave memory: [mem
0xc9e44000-0xcb9fefff]
[    0.010759] PM: hibernation: Registered nosave memory: [mem
0xcd000000-0xffffffff]
[    0.010760] [mem 0xd0000000-0xfe9fffff] available for PCI devices
[    0.010761] Booting paravirtualized kernel on bare hardware
[    0.010763] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.014510] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:24
nr_cpu_ids:24 nr_node_ids:1
[    0.015823] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 u524288
[    0.015832] pcpu-alloc: s233472 r8192 d28672 u524288 alloc=1*2097152
[    0.015834] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07
[    0.015837] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15
[    0.015840] pcpu-alloc: [0] 16 17 18 19 [0] 20 21 22 23
[    0.015858] Kernel command line:
BOOT_IMAGE=/boot/vmlinuz-6.14.5ahci-no-dipm
root=UUID=c056bf20-f617-4c4a-8d3c-28ac04ff6a3a ro lockdown=integrity
splash
[    0.015906] Unknown kernel command line parameters "splash
BOOT_IMAGE=/boot/vmlinuz-6.14.5ahci-no-dipm", will be passed to user
space.
[    0.015923] printk: log_buf_len individual max cpu contribution: 4096 bytes
[    0.015924] printk: log_buf_len total cpu_extra contributions: 94208 bytes
[    0.015925] printk: log_buf_len min size: 131072 bytes
[    0.016078] printk: log buffer data + meta data: 262144 + 917504 =
1179648 bytes
[    0.016079] printk: early log buf free: 113480(86%)
[    0.018746] Dentry cache hash table entries: 4194304 (order: 13,
33554432 bytes, linear)
[    0.020071] Inode-cache hash table entries: 2097152 (order: 12,
16777216 bytes, linear)
[    0.020220] Fallback order for Node 0: 0
[    0.020227] Built 1 zonelists, mobility grouping on.  Total pages: 8365009
[    0.020228] Policy zone: Normal
[    0.020236] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.020269] software IO TLB: area num 32.
[    0.040149] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=24, Nodes=1
[    0.040204] ftrace: allocating 46051 entries in 180 pages
[    0.052483] ftrace: allocated 180 pages with 4 groups
[    0.053009] Dynamic Preempt: voluntary
[    0.053074] rcu: Preemptible hierarchical RCU implementation.
[    0.053074] rcu:     RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=24.
[    0.053075]     Trampoline variant of Tasks RCU enabled.
[    0.053076]     Rude variant of Tasks RCU enabled.
[    0.053076]     Tracing variant of Tasks RCU enabled.
[    0.053076] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.053077] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=24
[    0.053089] RCU Tasks: Setting shift to 5 and lim to 1
rcu_task_cb_adjust=1 rcu_task_cpu_ids=24.
[    0.053092] RCU Tasks Rude: Setting shift to 5 and lim to 1
rcu_task_cb_adjust=1 rcu_task_cpu_ids=24.
[    0.053095] RCU Tasks Trace: Setting shift to 5 and lim to 1
rcu_task_cb_adjust=1 rcu_task_cpu_ids=24.
[    0.056832] NR_IRQS: 524544, nr_irqs: 1160, preallocated irqs: 16
[    0.057022] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.057091] Console: colour dummy device 80x25
[    0.057093] printk: legacy console [tty0] enabled
[    0.057423] ACPI: Core revision 20240827
[    0.057518] clocksource: hpet: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 133484873504 ns
[    0.057535] APIC: Switch to symmetric I/O mode setup
[    0.057961] AMD-Vi: Using global IVHD EFR:0x0, EFR2:0x0
[    0.376947] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.377586] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.397542] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x6d57467e29d, max_idle_ns: 881590815800 ns
[    0.397547] Calibrating delay loop (skipped), value calculated
using timer frequency.. 7585.52 BogoMIPS (lpj=15171048)
[    0.397563] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.397612] LVT offset 1 assigned for vector 0xf9
[    0.397747] LVT offset 2 assigned for vector 0xf4
[    0.397784] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.397786] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
[    0.397789] process: using mwait in idle threads
[    0.397791] Spectre V1 : Mitigation: usercopy/swapgs barriers and
__user pointer sanitization
[    0.397794] Spectre V2 : Mitigation: Retpolines
[    0.397795] Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB on
context switch and VMEXIT
[    0.397798] Spectre V2 : Enabling Speculation Barrier for firmware calls
[    0.397799] RETBleed: Mitigation: untrained return thunk
[    0.397802] Spectre V2 : mitigation: Enabling conditional Indirect
Branch Prediction Barrier
[    0.397804] Spectre V2 : Selecting STIBP always-on mode to
complement retbleed mitigation
[    0.397806] Spectre V2 : User space: Mitigation: STIBP always-on protection
[    0.397808] Speculative Store Bypass: Mitigation: Speculative Store
Bypass disabled via prctl
[    0.397810] Speculative Return Stack Overflow: Mitigation: Safe RET
[    0.397815] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
point registers'
[    0.397817] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.397819] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.397821] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.397823] x86/fpu: Enabled xstate features 0x7, context size is
832 bytes, using 'compacted' format.
[    0.418807] Freeing SMP alternatives memory: 40K
[    0.418812] pid_max: default: 32768 minimum: 301
[    0.424280] LSM: initializing
lsm=lockdown,capability,landlock,yama,apparmor,tomoyo,bpf,ipe,ima,evm
[    0.424359] landlock: Up and running.
[    0.424362] Yama: becoming mindful.
[    0.424452] AppArmor: AppArmor initialized
[    0.424481] TOMOYO Linux initialized
[    0.424708] LSM support for eBPF active
[    0.424812] Mount-cache hash table entries: 65536 (order: 7, 524288
bytes, linear)
[    0.424853] Mountpoint-cache hash table entries: 65536 (order: 7,
524288 bytes, linear)
[    0.535467] smpboot: CPU0: AMD Ryzen 9 3900X 12-Core Processor
(family: 0x17, model: 0x71, stepping: 0x0)
[    0.535715] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    0.535741] ... version:                0
[    0.535745] ... bit width:              48
[    0.535748] ... generic registers:      6
[    0.535751] ... value mask:             0000ffffffffffff
[    0.535755] ... max period:             00007fffffffffff
[    0.535759] ... fixed-purpose events:   0
[    0.535763] ... event mask:             000000000000003f
[    0.535873] signal: max sigframe size: 1776
[    0.535913] rcu: Hierarchical SRCU implementation.
[    0.535917] rcu:     Max phase no-delay instances is 1000.
[    0.535960] Timer migration: 2 hierarchy levels; 8 children per
group; 2 crossnode level
[    0.538417] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.538596] smp: Bringing up secondary CPUs ...
[    0.538697] smpboot: x86: Booting SMP configuration:
[    0.538701] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
#8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23
[    0.567547] Spectre V2 : Update user space SMT mitigation: STIBP always-on
[    0.591548] smp: Brought up 1 node, 24 CPUs
[    0.591548] smpboot: Total of 24 processors activated (182052.57 BogoMIPS)
[    0.625564] node 0 deferred pages initialised in 32ms
[    0.626309] Memory: 32617832K/33460036K available (15505K kernel
code, 2501K rwdata, 11928K rodata, 4200K init, 4856K bss, 823240K
reserved, 0K cma-reserved)
[    0.626863] devtmpfs: initialized
[    0.626863] x86/mm: Memory block size: 128MB
[    0.632385] ACPI: PM: Registering ACPI NVS region [mem
0x0a200000-0x0a210fff] (69632 bytes)
[    0.632385] ACPI: PM: Registering ACPI NVS region [mem
0xca3bd000-0xcab5bfff] (7991296 bytes)
[    0.632385] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.632385] futex hash table entries: 8192 (order: 7, 524288 bytes, linear)
[    0.632385] pinctrl core: initialized pinctrl subsystem
[    0.632385] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.633921] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.634256] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for
atomic allocations
[    0.634569] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool
for atomic allocations
[    0.634586] audit: initializing netlink subsys (disabled)
[    0.634599] audit: type=2000 audit(1746988156.260:1):
state=initialized audit_enabled=0 res=1
[    0.634599] thermal_sys: Registered thermal governor 'fair_share'
[    0.634599] thermal_sys: Registered thermal governor 'bang_bang'
[    0.634599] thermal_sys: Registered thermal governor 'step_wise'
[    0.634599] thermal_sys: Registered thermal governor 'user_space'
[    0.634599] thermal_sys: Registered thermal governor 'power_allocator'
[    0.634599] cpuidle: using governor ladder
[    0.634599] cpuidle: using governor menu
[    0.634599] Detected 1 PCC Subspaces
[    0.634599] Registering PCC driver as Mailbox controller
[    0.634599] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.634599] PCI: ECAM [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
for domain 0000 [bus 00-7f]
[    0.634599] PCI: Using configuration type 1 for base access
[    0.634599] kprobes: kprobe jump-optimization is enabled. All
kprobes are optimized if possible.
[    0.634599] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.634599] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.634599] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.634599] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.634599] ACPI: Added _OSI(Module Device)
[    0.634599] ACPI: Added _OSI(Processor Device)
[    0.634599] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.634599] ACPI: Added _OSI(Processor Aggregator Device)
[    0.647932] ACPI: 9 ACPI AML tables successfully acquired and loaded
[    0.650306] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.654407] ACPI: Interpreter enabled
[    0.654424] ACPI: PM: (supports S0 S3 S4 S5)
[    0.654428] ACPI: Using IOAPIC for interrupt routing
[    0.657899] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    0.657906] PCI: Ignoring E820 reservations for host bridge windows
[    0.658253] ACPI: Enabled 5 GPEs in block 00 to 1F
[    0.682114] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.682124] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI HPX-Type3]
[    0.682232] acpi PNP0A08:00: _OSC: platform does not support
[PCIeHotplug SHPCHotplug PME LTR]
[    0.682428] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability]
[    0.682441] acpi PNP0A08:00: [Firmware Info]: ECAM [mem
0xf0000000-0xf7ffffff] for domain 0000 [bus 00-7f] only partially
covers this bridge
[    0.682980] PCI host bridge to bus 0000:00
[    0.682986] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.682992] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.682997] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.683002] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.683008] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000dffff window]
[    0.683014] pci_bus 0000:00: root bus resource [mem
0xd0000000-0xfec2ffff window]
[    0.683020] pci_bus 0000:00: root bus resource [mem
0xfee00000-0xffffffff window]
[    0.683027] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.683046] pci 0000:00:00.0: [1022:1480] type 00 class 0x060000
conventional PCI endpoint
[    0.683167] pci 0000:00:00.2: [1022:1481] type 00 class 0x080600
conventional PCI endpoint
[    0.683280] pci 0000:00:01.0: [1022:1482] type 00 class 0x060000
conventional PCI endpoint
[    0.683367] pci 0000:00:01.2: [1022:1483] type 01 class 0x060400
PCIe Root Port
[    0.683391] pci 0000:00:01.2: PCI bridge to [bus 01-05]
[    0.683401] pci 0000:00:01.2:   bridge window [mem 0xfc200000-0xfc5fffff]
[    0.683420] pci 0000:00:01.2: enabling Extended Tags
[    0.683484] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.683700] pci 0000:00:02.0: [1022:1482] type 00 class 0x060000
conventional PCI endpoint
[    0.683784] pci 0000:00:03.0: [1022:1482] type 00 class 0x060000
conventional PCI endpoint
[    0.683867] pci 0000:00:03.1: [1022:1483] type 01 class 0x060400
PCIe Root Port
[    0.683890] pci 0000:00:03.1: PCI bridge to [bus 06]
[    0.683898] pci 0000:00:03.1:   bridge window [io  0xf000-0xffff]
[    0.683905] pci 0000:00:03.1:   bridge window [mem 0xfb000000-0xfc0fffff]
[    0.683917] pci 0000:00:03.1:   bridge window [mem
0xd0000000-0xe20fffff 64bit pref]
[    0.683988] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
[    0.684368] pci 0000:00:04.0: [1022:1482] type 00 class 0x060000
conventional PCI endpoint
[    0.684451] pci 0000:00:05.0: [1022:1482] type 00 class 0x060000
conventional PCI endpoint
[    0.684533] pci 0000:00:07.0: [1022:1482] type 00 class 0x060000
conventional PCI endpoint
[    0.684617] pci 0000:00:07.1: [1022:1484] type 01 class 0x060400
PCIe Root Port
[    0.684639] pci 0000:00:07.1: PCI bridge to [bus 07]
[    0.684658] pci 0000:00:07.1: enabling Extended Tags
[    0.684709] pci 0000:00:07.1: PME# supported from D0 D3hot D3cold
[    0.684851] pci 0000:00:08.0: [1022:1482] type 00 class 0x060000
conventional PCI endpoint
[    0.684936] pci 0000:00:08.1: [1022:1484] type 01 class 0x060400
PCIe Root Port
[    0.684957] pci 0000:00:08.1: PCI bridge to [bus 08]
[    0.684966] pci 0000:00:08.1:   bridge window [mem 0xfc600000-0xfc8fffff]
[    0.684983] pci 0000:00:08.1: enabling Extended Tags
[    0.685037] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.685211] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
conventional PCI endpoint
[    0.685332] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
conventional PCI endpoint
[    0.685473] pci 0000:00:18.0: [1022:1440] type 00 class 0x060000
conventional PCI endpoint
[    0.685523] pci 0000:00:18.1: [1022:1441] type 00 class 0x060000
conventional PCI endpoint
[    0.685575] pci 0000:00:18.2: [1022:1442] type 00 class 0x060000
conventional PCI endpoint
[    0.685624] pci 0000:00:18.3: [1022:1443] type 00 class 0x060000
conventional PCI endpoint
[    0.685675] pci 0000:00:18.4: [1022:1444] type 00 class 0x060000
conventional PCI endpoint
[    0.685725] pci 0000:00:18.5: [1022:1445] type 00 class 0x060000
conventional PCI endpoint
[    0.685774] pci 0000:00:18.6: [1022:1446] type 00 class 0x060000
conventional PCI endpoint
[    0.685822] pci 0000:00:18.7: [1022:1447] type 00 class 0x060000
conventional PCI endpoint
[    0.685944] pci 0000:01:00.0: [1022:43ee] type 00 class 0x0c0330
PCIe Legacy Endpoint
[    0.685993] pci 0000:01:00.0: BAR 0 [mem 0xfc5a0000-0xfc5a7fff 64bit]
[    0.686010] pci 0000:01:00.0: enabling Extended Tags
[    0.686075] pci 0000:01:00.0: PME# supported from D3hot D3cold
[    0.686276] pci 0000:01:00.1: [1022:43eb] type 00 class 0x010601
PCIe Legacy Endpoint
[    0.686330] pci 0000:01:00.1: BAR 5 [mem 0xfc580000-0xfc59ffff]
[    0.686336] pci 0000:01:00.1: ROM [mem 0xfc500000-0xfc57ffff pref]
[    0.686347] pci 0000:01:00.1: enabling Extended Tags
[    0.686400] pci 0000:01:00.1: PME# supported from D3hot D3cold
[    0.686523] pci 0000:01:00.2: [1022:43e9] type 01 class 0x060400
PCIe Switch Upstream Port
[    0.686558] pci 0000:01:00.2: PCI bridge to [bus 02-05]
[    0.686571] pci 0000:01:00.2:   bridge window [mem 0xfc200000-0xfc4fffff]
[    0.686601] pci 0000:01:00.2: enabling Extended Tags
[    0.686660] pci 0000:01:00.2: PME# supported from D3hot D3cold
[    0.686816] pci 0000:00:01.2: PCI bridge to [bus 01-05]
[    0.686958] pci 0000:02:00.0: [1022:43ea] type 01 class 0x060400
PCIe Switch Downstream Port
[    0.686994] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.687032] pci 0000:02:00.0: enabling Extended Tags
[    0.687103] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.687249] pci 0000:02:08.0: [1022:43ea] type 01 class 0x060400
PCIe Switch Downstream Port
[    0.687284] pci 0000:02:08.0: PCI bridge to [bus 04]
[    0.687297] pci 0000:02:08.0:   bridge window [mem 0xfc400000-0xfc4fffff]
[    0.687328] pci 0000:02:08.0: enabling Extended Tags
[    0.687398] pci 0000:02:08.0: PME# supported from D3hot D3cold
[    0.687539] pci 0000:02:09.0: [1022:43ea] type 01 class 0x060400
PCIe Switch Downstream Port
[    0.687574] pci 0000:02:09.0: PCI bridge to [bus 05]
[    0.687587] pci 0000:02:09.0:   bridge window [mem 0xfc200000-0xfc3fffff]
[    0.687618] pci 0000:02:09.0: enabling Extended Tags
[    0.687689] pci 0000:02:09.0: PME# supported from D3hot D3cold
[    0.687829] pci 0000:01:00.2: PCI bridge to [bus 02-05]
[    0.687894] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.688000] pci 0000:04:00.0: [8086:2723] type 00 class 0x028000
PCIe Endpoint
[    0.688083] pci 0000:04:00.0: BAR 0 [mem 0xfc400000-0xfc403fff 64bit]
[    0.688226] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    0.688454] pci 0000:02:08.0: PCI bridge to [bus 04]
[    0.688563] pci 0000:05:00.0: [8086:15f3] type 00 class 0x020000
PCIe Endpoint
[    0.688640] pci 0000:05:00.0: BAR 0 [mem 0xfc200000-0xfc2fffff]
[    0.688652] pci 0000:05:00.0: BAR 3 [mem 0xfc300000-0xfc303fff]
[    0.688797] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[    0.689065] pci 0000:02:09.0: PCI bridge to [bus 05]
[    0.689183] pci 0000:06:00.0: [10de:1f08] type 00 class 0x030000
PCIe Legacy Endpoint
[    0.689230] pci 0000:06:00.0: BAR 0 [mem 0xfb000000-0xfbffffff]
[    0.689237] pci 0000:06:00.0: BAR 1 [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.689244] pci 0000:06:00.0: BAR 3 [mem 0xe0000000-0xe1ffffff 64bit pref]
[    0.689251] pci 0000:06:00.0: BAR 5 [io  0xf000-0xf07f]
[    0.689257] pci 0000:06:00.0: ROM [mem 0xfc000000-0xfc07ffff pref]
[    0.689288] pci 0000:06:00.0: Video device with shadowed ROM at
[mem 0x000c0000-0x000dffff]
[    0.689346] pci 0000:06:00.0: PME# supported from D0 D3hot
[    0.689439] pci 0000:06:00.0: 32.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s PCIe x16 link at 0000:00:03.1 (capable of 126.016
Gb/s with 8.0 GT/s PCIe x16 link)
[    0.689614] pci 0000:06:00.1: [10de:10f9] type 00 class 0x040300
PCIe Endpoint
[    0.689661] pci 0000:06:00.1: BAR 0 [mem 0xfc080000-0xfc083fff]
[    0.689829] pci 0000:06:00.2: [10de:1ada] type 00 class 0x0c0330
PCIe Endpoint
[    0.689876] pci 0000:06:00.2: BAR 0 [mem 0xe2000000-0xe203ffff 64bit pref]
[    0.689885] pci 0000:06:00.2: BAR 3 [mem 0xe2040000-0xe204ffff 64bit pref]
[    0.689942] pci 0000:06:00.2: PME# supported from D0 D3hot
[    0.690041] pci 0000:06:00.3: [10de:1adb] type 00 class 0x0c8000
PCIe Endpoint
[    0.690087] pci 0000:06:00.3: BAR 0 [mem 0xfc084000-0xfc084fff]
[    0.690148] pci 0000:06:00.3: PME# supported from D0 D3hot
[    0.690280] pci 0000:00:03.1: PCI bridge to [bus 06]
[    0.690339] pci 0000:07:00.0: [1022:148a] type 00 class 0x130000
PCIe Endpoint
[    0.690375] pci 0000:07:00.0: enabling Extended Tags
[    0.690556] pci 0000:00:07.1: PCI bridge to [bus 07]
[    0.690632] pci 0000:08:00.0: [1022:1485] type 00 class 0x130000
PCIe Endpoint
[    0.690673] pci 0000:08:00.0: enabling Extended Tags
[    0.690858] pci 0000:08:00.1: [1022:1486] type 00 class 0x108000
PCIe Endpoint
[    0.690892] pci 0000:08:00.1: BAR 2 [mem 0xfc700000-0xfc7fffff]
[    0.690899] pci 0000:08:00.1: BAR 5 [mem 0xfc808000-0xfc809fff]
[    0.690910] pci 0000:08:00.1: enabling Extended Tags
[    0.691067] pci 0000:08:00.3: [1022:149c] type 00 class 0x0c0330
PCIe Endpoint
[    0.691102] pci 0000:08:00.3: BAR 0 [mem 0xfc600000-0xfc6fffff 64bit]
[    0.691115] pci 0000:08:00.3: enabling Extended Tags
[    0.691171] pci 0000:08:00.3: PME# supported from D0 D3hot D3cold
[    0.691312] pci 0000:08:00.4: [1022:1487] type 00 class 0x040300
PCIe Endpoint
[    0.691345] pci 0000:08:00.4: BAR 0 [mem 0xfc800000-0xfc807fff]
[    0.691359] pci 0000:08:00.4: enabling Extended Tags
[    0.691411] pci 0000:08:00.4: PME# supported from D0 D3hot D3cold
[    0.691566] pci 0000:00:08.1: PCI bridge to [bus 08]
[    0.691978] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.692030] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.692076] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.692130] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.692180] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.692222] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.692264] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.692306] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.693356] iommu: Default domain type: Translated
[    0.693356] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.695334] pps_core: LinuxPPS API ver. 1 registered
[    0.695339] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.695347] PTP clock support registered
[    0.695361] EDAC MC: Ver: 3.0.0
[    0.695469] efivars: Registered efivars operations
[    0.695469] NetLabel: Initializing
[    0.695469] NetLabel:  domain hash size = 128
[    0.695469] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.695469] NetLabel:  unlabeled traffic allowed by default
[    0.695469] PCI: Using ACPI for IRQ routing
[    0.699902] PCI: pci_cache_line_size set to 64 bytes
[    0.699972] e820: reserve RAM buffer [mem 0x09d1f000-0x0bffffff]
[    0.699975] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
[    0.699976] e820: reserve RAM buffer [mem 0x0b000000-0x0bffffff]
[    0.699978] e820: reserve RAM buffer [mem 0xabc55018-0xabffffff]
[    0.699979] e820: reserve RAM buffer [mem 0xabc75018-0xabffffff]
[    0.699981] e820: reserve RAM buffer [mem 0xc3277000-0xc3ffffff]
[    0.699982] e820: reserve RAM buffer [mem 0xc53ae000-0xc7ffffff]
[    0.699984] e820: reserve RAM buffer [mem 0xc64d1000-0xc7ffffff]
[    0.699985] e820: reserve RAM buffer [mem 0xc9e44000-0xcbffffff]
[    0.699987] e820: reserve RAM buffer [mem 0xcd000000-0xcfffffff]
[    0.699988] e820: reserve RAM buffer [mem 0x82f300000-0x82fffffff]
[    0.700065] pci 0000:06:00.0: vgaarb: setting as boot VGA device
[    0.700065] pci 0000:06:00.0: vgaarb: bridge control possible
[    0.700065] pci 0000:06:00.0: vgaarb: VGA device added:
decodes=io+mem,owns=io+mem,locks=none
[    0.700065] vgaarb: loaded
[    0.700065] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.700065] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.701600] clocksource: Switched to clocksource tsc-early
[    0.701782] VFS: Disk quotas dquot_6.6.0
[    0.701798] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.702007] AppArmor: AppArmor Filesystem Enabled
[    0.702033] pnp: PnP ACPI init
[    0.702126] system 00:00: [mem 0xf0000000-0xf7ffffff] has been reserved
[    0.702220] system 00:01: [mem 0xfd200000-0xfd2fffff] has been reserved
[    0.702419] system 00:03: [io  0x0290-0x029f] has been reserved
[    0.702426] system 00:03: [io  0x0200-0x021f] has been reserved
[    0.702716] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.702723] system 00:04: [io  0x040b] has been reserved
[    0.702729] system 00:04: [io  0x04d6] has been reserved
[    0.702735] system 00:04: [io  0x0c00-0x0c01] has been reserved
[    0.702741] system 00:04: [io  0x0c14] has been reserved
[    0.702747] system 00:04: [io  0x0c50-0x0c51] has been reserved
[    0.702754] system 00:04: [io  0x0c52] has been reserved
[    0.702760] system 00:04: [io  0x0c6c] has been reserved
[    0.702766] system 00:04: [io  0x0c6f] has been reserved
[    0.702772] system 00:04: [io  0x0cd8-0x0cdf] has been reserved
[    0.702778] system 00:04: [io  0x0800-0x089f] has been reserved
[    0.702784] system 00:04: [io  0x0b00-0x0b0f] has been reserved
[    0.702791] system 00:04: [io  0x0b20-0x0b3f] has been reserved
[    0.702797] system 00:04: [io  0x0900-0x090f] has been reserved
[    0.702803] system 00:04: [io  0x0910-0x091f] has been reserved
[    0.702810] system 00:04: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.702817] system 00:04: [mem 0xfec01000-0xfec01fff] could not be reserved
[    0.702824] system 00:04: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    0.702831] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.702838] system 00:04: [mem 0xfed80000-0xfed8ffff] could not be reserved
[    0.702846] system 00:04: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.702853] system 00:04: [mem 0xff000000-0xffffffff] has been reserved
[    0.703416] pnp: PnP ACPI: found 5 devices
[    0.709600] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
[    0.709664] NET: Registered PF_INET protocol family
[    0.709834] IP idents hash table entries: 262144 (order: 9, 2097152
bytes, linear)
[    0.722631] tcp_listen_portaddr_hash hash table entries: 16384
(order: 6, 262144 bytes, linear)
[    0.722668] Table-perturb hash table entries: 65536 (order: 6,
262144 bytes, linear)
[    0.722812] TCP established hash table entries: 262144 (order: 9,
2097152 bytes, linear)
[    0.723143] TCP bind hash table entries: 65536 (order: 9, 2097152
bytes, linear)
[    0.723227] TCP: Hash tables configured (established 262144 bind 65536)
[    0.723382] MPTCP token hash table entries: 32768 (order: 7, 786432
bytes, linear)
[    0.723485] UDP hash table entries: 16384 (order: 8, 1048576 bytes, linear)
[    0.723604] UDP-Lite hash table entries: 16384 (order: 8, 1048576
bytes, linear)
[    0.723720] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.723731] NET: Registered PF_XDP protocol family
[    0.723758] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.723776] pci 0000:02:08.0: PCI bridge to [bus 04]
[    0.723785] pci 0000:02:08.0:   bridge window [mem 0xfc400000-0xfc4fffff]
[    0.723798] pci 0000:02:09.0: PCI bridge to [bus 05]
[    0.723806] pci 0000:02:09.0:   bridge window [mem 0xfc200000-0xfc3fffff]
[    0.723818] pci 0000:01:00.2: PCI bridge to [bus 02-05]
[    0.723826] pci 0000:01:00.2:   bridge window [mem 0xfc200000-0xfc4fffff]
[    0.723838] pci 0000:00:01.2: PCI bridge to [bus 01-05]
[    0.723845] pci 0000:00:01.2:   bridge window [mem 0xfc200000-0xfc5fffff]
[    0.723857] pci 0000:00:03.1: PCI bridge to [bus 06]
[    0.723862] pci 0000:00:03.1:   bridge window [io  0xf000-0xffff]
[    0.723869] pci 0000:00:03.1:   bridge window [mem 0xfb000000-0xfc0fffff]
[    0.723876] pci 0000:00:03.1:   bridge window [mem
0xd0000000-0xe20fffff 64bit pref]
[    0.723886] pci 0000:00:07.1: PCI bridge to [bus 07]
[    0.723897] pci 0000:00:08.1: PCI bridge to [bus 08]
[    0.723903] pci 0000:00:08.1:   bridge window [mem 0xfc600000-0xfc8fffff]
[    0.723914] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.723921] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.723927] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.723932] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.723938] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff window]
[    0.723945] pci_bus 0000:00: resource 9 [mem 0xd0000000-0xfec2ffff window]
[    0.723950] pci_bus 0000:00: resource 10 [mem 0xfee00000-0xffffffff window]
[    0.723957] pci_bus 0000:01: resource 1 [mem 0xfc200000-0xfc5fffff]
[    0.723963] pci_bus 0000:02: resource 1 [mem 0xfc200000-0xfc4fffff]
[    0.723969] pci_bus 0000:04: resource 1 [mem 0xfc400000-0xfc4fffff]
[    0.723974] pci_bus 0000:05: resource 1 [mem 0xfc200000-0xfc3fffff]
[    0.723980] pci_bus 0000:06: resource 0 [io  0xf000-0xffff]
[    0.723984] pci_bus 0000:06: resource 1 [mem 0xfb000000-0xfc0fffff]
[    0.723990] pci_bus 0000:06: resource 2 [mem 0xd0000000-0xe20fffff
64bit pref]
[    0.723996] pci_bus 0000:08: resource 1 [mem 0xfc600000-0xfc8fffff]
[    0.724266] pci 0000:06:00.1: extending delay after power-on from
D3hot to 20 msec
[    0.724304] pci 0000:06:00.1: D0 power state depends on 0000:06:00.0
[    0.724378] pci 0000:06:00.2: D0 power state depends on 0000:06:00.0
[    0.724524] pci 0000:06:00.3: D0 power state depends on 0000:06:00.0
[    0.724696] PCI: CLS 64 bytes, default 64
[    0.724721] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
[    0.724781] Trying to unpack rootfs image as initramfs...
[    0.724812] pci 0000:00:00.0: Adding to iommu group 0
[    0.724844] pci 0000:00:01.0: Adding to iommu group 1
[    0.724885] pci 0000:00:01.2: Adding to iommu group 2
[    0.724929] pci 0000:00:02.0: Adding to iommu group 3
[    0.724962] pci 0000:00:03.0: Adding to iommu group 4
[    0.724986] pci 0000:00:03.1: Adding to iommu group 5
[    0.725016] pci 0000:00:04.0: Adding to iommu group 6
[    0.725047] pci 0000:00:05.0: Adding to iommu group 7
[    0.725078] pci 0000:00:07.0: Adding to iommu group 8
[    0.725101] pci 0000:00:07.1: Adding to iommu group 9
[    0.725133] pci 0000:00:08.0: Adding to iommu group 10
[    0.725157] pci 0000:00:08.1: Adding to iommu group 11
[    0.725197] pci 0000:00:14.0: Adding to iommu group 12
[    0.725220] pci 0000:00:14.3: Adding to iommu group 12
[    0.725315] pci 0000:00:18.0: Adding to iommu group 13
[    0.725339] pci 0000:00:18.1: Adding to iommu group 13
[    0.725362] pci 0000:00:18.2: Adding to iommu group 13
[    0.725385] pci 0000:00:18.3: Adding to iommu group 13
[    0.725407] pci 0000:00:18.4: Adding to iommu group 13
[    0.725431] pci 0000:00:18.5: Adding to iommu group 13
[    0.725454] pci 0000:00:18.6: Adding to iommu group 13
[    0.725477] pci 0000:00:18.7: Adding to iommu group 13
[    0.725526] pci 0000:01:00.0: Adding to iommu group 14
[    0.725552] pci 0000:01:00.1: Adding to iommu group 14
[    0.725578] pci 0000:01:00.2: Adding to iommu group 14
[    0.725588] pci 0000:02:00.0: Adding to iommu group 14
[    0.725599] pci 0000:02:08.0: Adding to iommu group 14
[    0.725614] pci 0000:02:09.0: Adding to iommu group 14
[    0.725624] pci 0000:04:00.0: Adding to iommu group 14
[    0.725634] pci 0000:05:00.0: Adding to iommu group 14
[    0.725693] pci 0000:06:00.0: Adding to iommu group 15
[    0.725719] pci 0000:06:00.1: Adding to iommu group 15
[    0.725745] pci 0000:06:00.2: Adding to iommu group 15
[    0.725772] pci 0000:06:00.3: Adding to iommu group 15
[    0.725794] pci 0000:07:00.0: Adding to iommu group 16
[    0.725819] pci 0000:08:00.0: Adding to iommu group 17
[    0.725844] pci 0000:08:00.1: Adding to iommu group 18
[    0.725868] pci 0000:08:00.3: Adding to iommu group 19
[    0.725893] pci 0000:08:00.4: Adding to iommu group 20
[    0.729189] AMD-Vi: Extended features (0x58f77ef22294a5a, 0x0): PPR
NX GT IA PC GA_vAPIC
[    0.729211] AMD-Vi: Interrupt remapping enabled
[    0.729329] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.729335] software IO TLB: mapped [mem
0x00000000bcc22000-0x00000000c0c22000] (64MB)
[    0.729400] LVT offset 0 assigned for vector 0x400
[    0.729608] perf: AMD IBS detected (0x000003ff)
[    0.740872] amd_uncore: 4 amd_df counters detected
[    0.740889] amd_uncore: 6 amd_l3 counters detected
[    0.745065] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[    0.745963] Initialise system trusted keyrings
[    0.745978] Key type blacklist registered
[    0.746030] workingset: timestamp_bits=36 max_order=23 bucket_order=0
[    0.746044] zbud: loaded
[    0.746159] fuse: init (API version 7.42)
[    0.746420] integrity: Platform Keyring initialized
[    0.746429] integrity: Machine keyring initialized
[    0.766739] Key type asymmetric registered
[    0.766751] Asymmetric key parser 'x509' registered
[    1.045146] Freeing initrd memory: 128652K
[    1.049847] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 246)
[    1.049897] io scheduler mq-deadline registered
[    1.052248] ledtrig-cpu: registered to indicate activity on CPUs
[    1.052731] pcieport 0000:00:07.1: AER: enabled with IRQ 29
[    1.052898] pcieport 0000:00:08.1: AER: enabled with IRQ 30
[    1.053603] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.054241] Monitor-Mwait will be used to enter C-1 state
[    1.065864] Estimated ratio of average max frequency by base
frequency (times 1024): 1141
[    1.066137] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.066361] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud =
115200) is a 16550A
[    1.066845] Linux agpgart interface v0.103
[    1.140005] tpm_crb MSFT0101:00: Disabling hwrng
[    1.141662] i8042: PNP: No PS/2 controller found.
[    1.141716] mousedev: PS/2 mouse device common for all mice
[    1.141739] rtc_cmos 00:02: RTC can wake from S4
[    1.141966] rtc_cmos 00:02: registered as rtc0
[    1.141998] rtc_cmos 00:02: setting system clock to
2025-05-11T18:29:17 UTC (1746988157)
[    1.142030] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram
[    1.460116] Relocating firmware framebuffer to offset
0x0000000001000000[d] within [mem 0xe0000000-0xe1ffffff flags
0x14220c]
[    1.460151] efifb: probing for efifb
[    1.460165] efifb: framebuffer at 0xe1000000, using 8100k, total 8100k
[    1.460170] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    1.460175] efifb: scrolling: redraw
[    1.460178] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.463047] Console: switching to colour frame buffer device 240x67
[    1.465811] fb0: EFI VGA frame buffer device
[    1.465979] NET: Registered PF_INET6 protocol family
[    1.469979] Segment Routing with IPv6
[    1.469999] In-situ OAM (IOAM) with IPv6
[    1.470028] mip6: Mobile IPv6
[    1.470039] NET: Registered PF_PACKET protocol family
[    1.470087] mpls_gso: MPLS GSO support
[    1.471805] microcode: Current revision: 0x08701035
[    1.472305] resctrl: L3 allocation detected
[    1.472318] resctrl: MB allocation detected
[    1.472329] resctrl: L3 monitoring detected
[    1.472381] IPI shorthand broadcast: enabled
[    1.474598] sched_clock: Marking stable (1156001392,
316497007)->(1699118391, -226619992)
[    1.474823] registered taskstats version 1
[    1.475031] Loading compiled-in X.509 certificates
[    1.488998] Loaded X.509 cert 'Mikon kernel-avain: XXXXXXXXXXXXXXXXXX'
[    1.491609] Demotion targets for Node 0: null
[    1.491762] Key type .fscrypt registered
[    1.491774] Key type fscrypt-provisioning registered
[    1.507586] Key type encrypted registered
[    1.507601] AppArmor: AppArmor sha256 policy hashing enabled
[    1.507697] integrity: Loading X.509 certificate: UEFI:db
[    1.507884] integrity: Loaded X.509 cert 'ASUSTeK MotherBoard SW
Key Certificate: da83b990422ebc8c441f8d8b039a65a2'
[    1.507914] integrity: Loading X.509 certificate: UEFI:db
[    1.508091] integrity: Loaded X.509 cert 'ASUSTeK Notebook SW Key
Certificate: b8e581e4df77a5bb4282d5ccfc00c071'
[    1.508120] integrity: Loading X.509 certificate: UEFI:db
[    1.508156] integrity: Loaded X.509 cert 'Microsoft Corporation
UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    1.508187] integrity: Loading X.509 certificate: UEFI:db
[    1.508220] integrity: Loaded X.509 cert 'Microsoft Windows
Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    1.508251] integrity: Loading X.509 certificate: UEFI:db
[    1.508410] integrity: Loaded X.509 cert 'Canonical Ltd. Master
Certificate Authority: ad91990bc22ab1f517048c23b6655a268e345a63'
[    1.510160] integrity: Loading X.509 certificate: UEFI:MokListRT
(MOKvar table)
[    1.510316] integrity: Loaded X.509 cert 'Debian Secure Boot CA:
6ccece7e4c6c0d1f6149f3dd27dfcc5cbb419ea1'
[    1.510344] integrity: Loading X.509 certificate: UEFI:MokListRT
(MOKvar table)
[    1.510493] integrity: Loaded X.509 cert 'DKMS module signing key:
XXXXXXXXXXXXXXXX'
[    1.510519] integrity: Loading X.509 certificate: UEFI:MokListRT
(MOKvar table)
[    1.510937] integrity: Loaded X.509 cert 'Mikon kernel-avain:
XXXXXXXXXXXXXXXXXXXXX'
[    1.510965] ima: Allocated hash algorithm: sha256
[    1.622079] audit: type=1807 audit(1746988157.975:2):
action=measure func=KEXEC_KERNEL_CHECK res=1
[    1.622109] evm: Initialising EVM extended attributes:
[    1.622112] audit: type=1807 audit(1746988157.975:3):
action=measure func=MODULE_CHECK res=1
[    1.622156] evm: security.selinux
[    1.622900] evm: security.SMACK64 (disabled)
[    1.623637] evm: security.SMACK64EXEC (disabled)
[    1.624366] evm: security.SMACK64TRANSMUTE (disabled)
[    1.625095] evm: security.SMACK64MMAP (disabled)
[    1.625810] evm: security.apparmor
[    1.626514] evm: security.ima
[    1.627213] evm: security.capability
[    1.627902] evm: HMAC attrs: 0x1
[    1.629785] RAS: Correctable Errors collector initialized.
[    1.642938] Lockdown: swapper/0: hibernation is restricted; see man
kernel_lockdown.7
[    1.643694] clk: Disabling unused clocks
[    1.644393] PM: genpd: Disabling unused power domains
[    1.646681] Freeing unused decrypted memory: 2028K
[    1.648109] Freeing unused kernel image (initmem) memory: 4200K
[    1.648836] Write protecting the kernel read-only data: 28672k
[    1.650031] Freeing unused kernel image (text/rodata gap) memory: 876K
[    1.650847] Freeing unused kernel image (rodata/data gap) memory: 360K
[    1.710478] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.711181] Run /init as init process
[    1.711892]   with arguments:
[    1.711894]     /init
[    1.711895]     splash
[    1.711897]   with environment:
[    1.711898]     HOME=/
[    1.711899]     TERM=linux
[    1.711901]     BOOT_IMAGE=/boot/vmlinuz-6.14.5ahci-no-dipm
[    1.726644] tpm tpm0: auth session is active
[    1.752511] tsc: Refined TSC clocksource calibration: 3792.874 MHz
[    1.753236] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x6d5818a734c, max_idle_ns: 881590694765 ns
[    1.753996] clocksource: Switched to clocksource tsc
[    1.869727] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.871694] ACPI: button: Power Button [PWRB]
[    1.872483] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    1.873434] ACPI: button: Power Button [PWRF]
[    1.923182] Intel(R) 2.5G Ethernet Linux Driver
[    1.923919] Copyright(c) 2018 Intel Corporation.
[    1.924744] igc 0000:05:00.0: PCIe PTM not supported by PCIe bus/controller
[    1.929896] piix4_smbus 0000:00:14.0: SMBus Host Controller at
0xb00, revision 0
[    1.930643] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus
port selection
[    1.933115] i2c i2c-1: Successfully instantiated SPD at 0x52
[    1.934271] SCSI subsystem initialized
[    1.934484] i2c i2c-1: Successfully instantiated SPD at 0x53
[    1.935809] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host
Controller at 0xb20
[    1.946470] ACPI: bus type USB registered
[    1.947247] usbcore: registered new interface driver usbfs
[    1.948005] usbcore: registered new interface driver hub
[    1.948763] usbcore: registered new device driver usb
[    1.955832] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    1.956646] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO address
[    1.957513] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec (nowayout=0)
[    1.966612] libata version 3.00 loaded.
[    1.979015] igc 0000:05:00.0 (unnamed net_device) (uninitialized): PHC added
[    1.989252] ahci 0000:01:00.1: version 3.0
[    1.989371] ahci 0000:01:00.1: SSS flag set, parallel bus scan disabled
[    1.990168] ahci 0000:01:00.1: AHCI vers 0001.0301, 32 command
slots, 6 Gbps, SATA mode
[    1.990912] ahci 0000:01:00.1: 6/6 ports implemented (port mask 0x3f)
[    1.991647] ahci 0000:01:00.1: flags: 64bit ncq sntf stag pm led
clo only pmp pio slum part sxs deso sadm sds apst
[    1.993122] scsi host0: ahci
[    1.994052] scsi host1: ahci
[    1.994176] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    1.994902] scsi host2: ahci
[    1.995481] xhci_hcd 0000:01:00.0: new USB bus registered, assigned
bus number 1
[    1.996313] scsi host3: ahci
[    1.997710] scsi host4: ahci
[    1.998524] scsi host5: ahci
[    1.999246] ata1: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580100 irq 42 lpm-pol 3
[    1.999924] ata2: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580180 irq 42 lpm-pol 3
[    2.000594] ata3: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580200 irq 42 lpm-pol 3
[    2.001243] ata4: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580280 irq 42 lpm-pol 3
[    2.001881] ata5: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580300 irq 42 lpm-pol 3
[    2.002506] ata6: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580380 irq 42 lpm-pol 3
[    2.004085] igc 0000:05:00.0: 4.000 Gb/s available PCIe bandwidth
(5.0 GT/s PCIe x1 link)
[    2.004723] igc 0000:05:00.0 eth0: MAC: d4:5d:64:d7:c3:fe
[    2.052381] xhci_hcd 0000:01:00.0: hcc params 0x0200ef81 hci
version 0x110 quirks 0x0000000000000010
[    2.053408] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    2.054035] xhci_hcd 0000:01:00.0: new USB bus registered, assigned
bus number 2
[    2.054668] xhci_hcd 0000:01:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[    2.055370] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 6.14
[    2.056020] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.056676] usb usb1: Product: xHCI Host Controller
[    2.057326] usb usb1: Manufacturer: Linux 6.14.5ahci-no-dipm xhci-hcd
[    2.057985] usb usb1: SerialNumber: 0000:01:00.0
[    2.058821] hub 1-0:1.0: USB hub found
[    2.059487] hub 1-0:1.0: 10 ports detected
[    2.072468] usb usb2: We don't know the algorithms for LPM for this
host, disabling LPM.
[    2.073163] usb usb2: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 6.14
[    2.073825] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.074484] usb usb2: Product: xHCI Host Controller
[    2.075136] usb usb2: Manufacturer: Linux 6.14.5ahci-no-dipm xhci-hcd
[    2.075790] usb usb2: SerialNumber: 0000:01:00.0
[    2.076555] hub 2-0:1.0: USB hub found
[    2.077210] hub 2-0:1.0: 4 ports detected
[    2.083441] xhci_hcd 0000:06:00.2: xHCI Host Controller
[    2.084094] xhci_hcd 0000:06:00.2: new USB bus registered, assigned
bus number 3
[    2.085369] xhci_hcd 0000:06:00.2: hcc params 0x0180ff05 hci
version 0x110 quirks 0x0000000000000010
[    2.086186] xhci_hcd 0000:06:00.2: xHCI Host Controller
[    2.086838] xhci_hcd 0000:06:00.2: new USB bus registered, assigned
bus number 4
[    2.087486] xhci_hcd 0000:06:00.2: Host supports USB 3.1 Enhanced SuperSpeed
[    2.088172] usb usb3: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 6.14
[    2.088825] usb usb3: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.089461] usb usb3: Product: xHCI Host Controller
[    2.090089] usb usb3: Manufacturer: Linux 6.14.5ahci-no-dipm xhci-hcd
[    2.090717] usb usb3: SerialNumber: 0000:06:00.2
[    2.091435] hub 3-0:1.0: USB hub found
[    2.092064] hub 3-0:1.0: 2 ports detected
[    2.092834] usb usb4: We don't know the algorithms for LPM for this
host, disabling LPM.
[    2.093489] usb usb4: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 6.14
[    2.094120] usb usb4: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.094748] usb usb4: Product: xHCI Host Controller
[    2.095369] usb usb4: Manufacturer: Linux 6.14.5ahci-no-dipm xhci-hcd
[    2.095994] usb usb4: SerialNumber: 0000:06:00.2
[    2.096711] hub 4-0:1.0: USB hub found
[    2.097330] hub 4-0:1.0: 4 ports detected
[    2.098150] xhci_hcd 0000:08:00.3: xHCI Host Controller
[    2.098766] xhci_hcd 0000:08:00.3: new USB bus registered, assigned
bus number 5
[    2.099496] xhci_hcd 0000:08:00.3: hcc params 0x0278ffe5 hci
version 0x110 quirks 0x0000000000000010
[    2.100393] xhci_hcd 0000:08:00.3: xHCI Host Controller
[    2.101024] xhci_hcd 0000:08:00.3: new USB bus registered, assigned
bus number 6
[    2.101652] xhci_hcd 0000:08:00.3: Host supports USB 3.1 Enhanced SuperSpeed
[    2.102308] usb usb5: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 6.14
[    2.102941] usb usb5: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.103565] usb usb5: Product: xHCI Host Controller
[    2.104185] usb usb5: Manufacturer: Linux 6.14.5ahci-no-dipm xhci-hcd
[    2.104811] usb usb5: SerialNumber: 0000:08:00.3
[    2.105528] hub 5-0:1.0: USB hub found
[    2.106144] hub 5-0:1.0: 4 ports detected
[    2.106955] usb usb6: We don't know the algorithms for LPM for this
host, disabling LPM.
[    2.107602] usb usb6: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 6.14
[    2.108225] usb usb6: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.108850] usb usb6: Product: xHCI Host Controller
[    2.109469] usb usb6: Manufacturer: Linux 6.14.5ahci-no-dipm xhci-hcd
[    2.110097] usb usb6: SerialNumber: 0000:08:00.3
[    2.110816] hub 6-0:1.0: USB hub found
[    2.111443] hub 6-0:1.0: 4 ports detected
[    2.312178] ata1: SATA link down (SStatus 0 SControl 330)
[    2.352530] usb 5-4: new high-speed USB device number 2 using xhci_hcd
[    2.384504] usb 1-5: new full-speed USB device number 2 using xhci_hcd
[    2.492071] usb 5-4: New USB device found, idVendor=05e3,
idProduct=0608, bcdDevice=77.63
[    2.492752] usb 5-4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    2.493407] usb 5-4: Product: USB2.0 Hub
[    2.551048] hub 5-4:1.0: USB hub found
[    2.552189] hub 5-4:1.0: 4 ports detected
[    2.625160] ata2: SATA link down (SStatus 0 SControl 330)
[    2.773451] usb 1-5: New USB device found, idVendor=8087,
idProduct=0029, bcdDevice= 0.01
[    2.774232] usb 1-5: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.836549] usb 5-4.4: new full-speed USB device number 3 using xhci_hcd
[    2.944340] usb 5-4.4: New USB device found, idVendor=046d,
idProduct=c52b, bcdDevice=12.10
[    2.945006] usb 5-4.4: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[    2.945643] usb 5-4.4: Product: USB Receiver
[    2.946271] usb 5-4.4: Manufacturer: Logitech
[    2.972631] usb 1-6: new full-speed USB device number 3 using xhci_hcd
[    3.092957] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.096218] ata3.00: ATA-8: WDC WD5000AAKX-001CA0, 15.01H15, max UDMA/133
[    3.097300] ata3.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    3.099596] ata3.00: configured for UDMA/133
[    3.100425] scsi 2:0:0:0: Direct-Access     ATA      WDC
WD5000AAKX-0 1H15 PQ: 0 ANSI: 5
[    3.342818] usb 1-6: config 1 has an invalid interface number: 2 but max is 1
[    3.343488] usb 1-6: config 1 has no interface number 1
[    3.355742] usb 1-6: New USB device found, idVendor=0b05,
idProduct=1939, bcdDevice= 1.00
[    3.356423] usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.357100] usb 1-6: Product: AURA LED Controller
[    3.357746] usb 1-6: Manufacturer: AsusTek Computer Inc.
[    3.358388] usb 1-6: SerialNumber: 9876543210
[    3.548950] usb 1-7: new high-speed USB device number 4 using xhci_hcd
[    3.568949] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.570704] ata4.00: ATAPI: TSSTcorp CDDVDW SH-S223F, SB03, max UDMA/100
[    3.572053] ata4.00: configured for UDMA/100
[    3.573600] scsi 3:0:0:0: CD-ROM            TSSTcorp CDDVDW
SH-S223F  SB03 PQ: 0 ANSI: 5
[    3.772257] usb 1-7: New USB device found, idVendor=05e3,
idProduct=0610, bcdDevice=60.60
[    3.772965] usb 1-7: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    3.773619] usb 1-7: Product: USB2.0 Hub
[    3.784744] hub 1-7:1.0: USB hub found
[    3.789244] hub 1-7:1.0: 4 ports detected
[    4.092954] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    4.094315] ata5.00: ATA-10: WDC WD20EFAX-68FB5N0, 82.00A82, max UDMA/133
[    4.107152] ata5.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    4.107827] ata5.00: Features: NCQ-prio
[    4.121489] ata5.00: configured for UDMA/133
[    4.122320] scsi 4:0:0:0: Direct-Access     ATA      WDC
WD20EFAX-68F 0A82 PQ: 0 ANSI: 5
[    4.592949] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    4.594631] ata6.00: ATA-10: WDC WD20EFAX-68FB5N0, 82.00A82, max UDMA/133
[    4.607547] ata6.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    4.608235] ata6.00: Features: NCQ-prio
[    4.621958] ata6.00: configured for UDMA/133
[    4.622798] scsi 5:0:0:0: Direct-Access     ATA      WDC
WD20EFAX-68F 0A82 PQ: 0 ANSI: 5
[    4.626081] igc 0000:05:00.0 enp5s0: renamed from eth0
[    4.645183] sd 2:0:0:0: [sda] 976773168 512-byte logical blocks:
(500 GB/466 GiB)
[    4.645184] sd 4:0:0:0: [sdb] 3907029168 512-byte logical blocks:
(2.00 TB/1.82 TiB)
[    4.645196] sd 2:0:0:0: [sda] Write Protect is off
[    4.645524] sd 5:0:0:0: [sdc] 3907029168 512-byte logical blocks:
(2.00 TB/1.82 TiB)
[    4.645529] sd 5:0:0:0: [sdc] 4096-byte physical blocks
[    4.645538] sd 5:0:0:0: [sdc] Write Protect is off
[    4.645541] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    4.645562] sd 5:0:0:0: [sdc] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    4.645598] sd 5:0:0:0: [sdc] Preferred minimum I/O size 4096 bytes
[    4.645897] sd 4:0:0:0: [sdb] 4096-byte physical blocks
[    4.646555] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.647275] sd 4:0:0:0: [sdb] Write Protect is off
[    4.647891] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    4.648554] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    4.649232] sd 2:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    4.649938] sd 4:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    4.653991] sd 4:0:0:0: [sdb] Preferred minimum I/O size 4096 bytes
[    4.660594] hid: raw HID events driver (C) Jiri Kosina
[    4.719884]  sdc: sdc1 sdc2 sdc3 sdc4
[    4.720709] sd 5:0:0:0: [sdc] Attached SCSI disk
[    4.742974]  sdb: sdb1 sdb2 sdb3 sdb4
[    4.743821] sd 4:0:0:0: [sdb] Attached SCSI disk
[    4.749032]  sda: sda1 sda2 sda3 sda4
[    4.749842] sd 2:0:0:0: [sda] Attached SCSI disk
[    4.781471] usbcore: registered new interface driver usbhid
[    4.782141] usbhid: USB HID core driver
[    4.792471] input: Logitech USB Receiver as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.0/0003:046D:C52B.0001/input/input2
[    4.814410] sr 3:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer
dvd-ram cd/rw xa/form2 cdda tray
[    4.815120] cdrom: Uniform CD-ROM driver Revision: 3.20
[    4.873121] sr 3:0:0:0: Attached scsi CD-ROM sr0
[    4.960559] hid-generic 0003:046D:C52B.0001: input,hidraw0: USB HID
v1.11 Keyboard [Logitech USB Receiver] on usb-0000:08:00.3-4.4/input0
[    4.961471] input: Logitech USB Receiver Mouse as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.1/0003:046D:C52B.0002/input/input3
[    4.962302] input: Logitech USB Receiver Consumer Control as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.1/0003:046D:C52B.0002/input/input4
[    5.020547] input: Logitech USB Receiver System Control as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.1/0003:046D:C52B.0002/input/input5
[    5.021393] hid-generic 0003:046D:C52B.0002: input,hiddev0,hidraw1:
USB HID v1.11 Mouse [Logitech USB Receiver] on
usb-0000:08:00.3-4.4/input1
[    5.022315] hid-generic 0003:046D:C52B.0003: hiddev1,hidraw2: USB
HID v1.11 Device [Logitech USB Receiver] on
usb-0000:08:00.3-4.4/input2
[    5.023197] hid-generic 0003:0B05:1939.0004: hiddev2,hidraw3: USB
HID v1.11 Device [AsusTek Computer Inc. AURA LED Controller] on
usb-0000:01:00.0-6/input2
[    5.328691] md/raid1:md0: active with 2 out of 2 mirrors
[    5.329492] md0: detected capacity change from 0 to 39026688
[    5.349069] logitech-djreceiver 0003:046D:C52B.0003:
hiddev0,hidraw0: USB HID v1.11 Device [Logitech USB Receiver] on
usb-0000:08:00.3-4.4/input2
[    5.351152] md/raid1:md2: active with 2 out of 2 mirrors
[    5.385352] md2: detected capacity change from 0 to 3671392256
[    5.398375] md/raid1:md1: active with 2 out of 2 mirrors
[    5.399190] md1: detected capacity change from 0 to 195178496
[    5.466924] input: Logitech Wireless Device PID:4050 Keyboard as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.2/0003:046D:C52B.0003/0003:046D:4050.0005/input/input7
[    5.632729] input: Logitech Wireless Device PID:4050 Mouse as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.2/0003:046D:C52B.0003/0003:046D:4050.0005/input/input8
[    5.633688] hid-generic 0003:046D:4050.0005: input,hidraw1: USB HID
v1.11 Keyboard [Logitech Wireless Device PID:4050] on
usb-0000:08:00.3-4.4/input2:1
[    5.640728] input: Logitech K270 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.2/0003:046D:C52B.0003/0003:046D:4003.0006/input/input12
[    5.921188] logitech-hidpp-device 0003:046D:4003.0006:
input,hidraw2: USB HID v1.11 Keyboard [Logitech K270] on
usb-0000:08:00.3-4.4/input2:2
[    5.950695] input: Logitech M335 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.2/0003:046D:C52B.0003/0003:046D:4050.0005/input/input13
[    6.053137] logitech-hidpp-device 0003:046D:4050.0005:
input,hidraw1: USB HID v1.11 Keyboard [Logitech M335] on
usb-0000:08:00.3-4.4/input2:1
[   11.208685] raid6: avx2x4   gen() 36290 MB/s
[   11.276552] raid6: avx2x2   gen() 34407 MB/s
[   11.344507] raid6: avx2x1   gen() 27939 MB/s
[   11.345429] raid6: using algorithm avx2x4 gen() 36290 MB/s
[   11.412499] raid6: .... xor() 9838 MB/s, rmw enabled
[   11.413430] raid6: using avx2x2 recovery algorithm
[   11.421753] xor: automatically using best checksumming function   avx
[   11.429485] async_tx: api initialized (async)
[   21.142579] logitech-hidpp-device 0003:046D:4003.0006: HID++ 2.0
device connected.
[   45.507382] EXT4-fs (md1): mounted filesystem
c056bf20-f617-4c4a-8d3c-28ac04ff6a3a ro with ordered data mode. Quota
mode: none.
[   46.071864] Not activating Mandatory Access Control as
/sbin/tomoyo-init does not exist.
[   48.928758] systemd[1]: Inserted module 'autofs4'
[   49.311280] systemd[1]: systemd 257.5-2 running in system mode
(+PAM +AUDIT +SELINUX +APPARMOR +IMA +IPE +SMACK +SECCOMP +GCRYPT
-GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC
+KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2
+PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD
+BPF_FRAMEWORK +BTF -XKBCOMMON -UTMP +SYSVINIT +LIBARCHIVE)
[   49.313106] systemd[1]: Detected architecture x86-64.
[   49.387047] systemd[1]: Hostname set to <taavi>.
[   49.390247] Lockdown: systemd: /dev/mem,kmem,port is restricted;
see man kernel_lockdown.7
[   49.826719] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[   53.579649] systemd[1]: Queued start job for default target graphical.target.
[   53.658689] systemd[1]: Created slice system-getty.slice - Slice
/system/getty.
[   53.660685] systemd[1]: Created slice system-modprobe.slice - Slice
/system/modprobe.
[   53.663412] systemd[1]: Created slice system-postgresql.slice -
Slice /system/postgresql.
[   53.665861] systemd[1]: Created slice
system-systemd\x2dcryptsetup.slice - Encrypted Volume Units Service
Slice.
[   53.668855] systemd[1]: Created slice system-systemd\x2dfsck.slice
- Slice /system/systemd-fsck.
[   53.671007] systemd[1]: Created slice system-wg\x2dquick.slice -
Slice /system/wg-quick.
[   53.672846] systemd[1]: Created slice user.slice - User and Session Slice.
[   53.673867] systemd[1]: Started systemd-ask-password-wall.path -
Forward Password Requests to Wall Directory Watch.
[   53.676179] systemd[1]: Set up automount
proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats
File System Automount Point.
[   53.677688] systemd[1]: Expecting device
dev-disk-by\x2duuid-9F4E\x2d5291.device -
/dev/disk/by-uuid/9F4E-5291...
[   53.678696] systemd[1]: Expecting device
dev-disk-by\x2duuid-d60e5f36\x2d66b8\x2d4bd5\x2dae74\x2d0e1e32fde8bb.device
- /dev/disk/by-uuid/d60e5f36-66b8-4bd5-ae74-0e1e32fde8bb...
[   53.680738] systemd[1]: Expecting device
dev-mapper-crypthome.device - /dev/mapper/crypthome...
[   53.681817] systemd[1]: Expecting device
dev-mapper-cryptswap.device - /dev/mapper/cryptswap...
[   53.683944] systemd[1]: Expecting device dev-md0.device - /dev/md0...
[   53.685093] systemd[1]: Reached target integritysetup.target -
Local Integrity Protected Volumes.
[   53.687330] systemd[1]: Reached target nss-lookup.target - Host and
Network Name Lookups.
[   53.689648] systemd[1]: Reached target nss-user-lookup.target -
User and Group Name Lookups.
[   53.692016] systemd[1]: Reached target remote-fs.target - Remote
File Systems.
[   53.693276] systemd[1]: Reached target slices.target - Slice Units.
[   53.695674] systemd[1]: Reached target snapd.mounts-pre.target -
Mounting snaps.
[   53.698163] systemd[1]: Reached target veritysetup.target - Local
Verity Protected Volumes.
[   53.701078] systemd[1]: Listening on syslog.socket - Syslog Socket.
[   53.803329] systemd[1]: Listening on systemd-coredump.socket -
Process Core Dump Socket.
[   53.805477] systemd[1]: Listening on systemd-creds.socket -
Credential Encryption/Decryption.
[   53.806714] systemd[1]: Listening on systemd-initctl.socket -
initctl Compatibility Named Pipe.
[   53.808982] systemd[1]: Listening on
systemd-journald-dev-log.socket - Journal Socket (/dev/log).
[   53.811256] systemd[1]: Listening on systemd-journald.socket -
Journal Sockets.
[   53.813350] systemd[1]: systemd-pcrextend.socket - TPM PCR
Measurements was skipped because of an unmet condition check
(ConditionSecurity=measured-uki).
[   53.813384] systemd[1]: systemd-pcrlock.socket - Make TPM PCR
Policy was skipped because of an unmet condition check
(ConditionSecurity=measured-uki).
[   53.813593] systemd[1]: Listening on systemd-udevd-control.socket -
udev Control Socket.
[   53.817800] systemd[1]: Listening on systemd-udevd-kernel.socket -
udev Kernel Socket.
[   53.897498] systemd[1]: Mounting dev-hugepages.mount - Huge Pages
File System...
[   53.900007] systemd[1]: Mounting dev-mqueue.mount - POSIX Message
Queue File System...
[   53.903341] systemd[1]: Mounting run-lock.mount - Legacy Locks
Directory /run/lock...
[   53.937389] systemd[1]: Mounting sys-kernel-debug.mount - Kernel
Debug File System...
[   53.939760] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel
Trace File System...
[   53.944019] systemd[1]: Starting keyboard-setup.service - Set the
console keyboard layout...
[   53.946805] systemd[1]: Starting kmod-static-nodes.service - Create
List of Static Device Nodes...
[   53.949324] systemd[1]: Starting modprobe@configfs.service - Load
Kernel Module configfs...
[   53.952810] systemd[1]: Starting modprobe@drm.service - Load Kernel
Module drm...
[   53.955842] systemd[1]: Starting modprobe@efi_pstore.service - Load
Kernel Module efi_pstore...
[   53.959039] systemd[1]: Starting modprobe@fuse.service - Load
Kernel Module fuse...
[   53.962218] systemd[1]: Starting nftables.service - nftables...
[   53.963817] systemd[1]: systemd-fsck-root.service - File System
Check on Root Device was skipped because of an unmet condition check
(ConditionPathExists=!/run/initramfs/fsck-root).
[   53.963918] systemd[1]: systemd-hibernate-clear.service - Clear
Stale Hibernate Storage Info was skipped because of an unmet condition
check (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[   53.968952] systemd[1]: Starting systemd-journald.service - Journal
Service...
[   53.978968] systemd[1]: Starting systemd-modules-load.service -
Load Kernel Modules...
[   53.980130] systemd[1]: systemd-pcrmachine.service - TPM PCR
Machine ID Measurement was skipped because of an unmet condition check
(ConditionSecurity=measured-uki).
[   53.983934] systemd[1]: Starting systemd-remount-fs.service -
Remount Root and Kernel File Systems...
[   53.986038] systemd[1]: systemd-tpm2-setup-early.service - Early
TPM SRK Setup was skipped because of an unmet condition check
(ConditionSecurity=measured-uki).
[   53.988554] systemd[1]: Starting
systemd-udev-load-credentials.service - Load udev Rules from
Credentials...
[   53.992973] systemd[1]: Starting systemd-udev-trigger.service -
Coldplug All udev Devices...
[   54.024449] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
[   54.025932] systemd[1]: Mounted dev-mqueue.mount - POSIX Message
Queue File System.
[   54.028327] systemd[1]: Mounted run-lock.mount - Legacy Locks
Directory /run/lock.
[   54.030739] systemd[1]: Mounted sys-kernel-debug.mount - Kernel
Debug File System.
[   54.033180] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel
Trace File System.
[   54.037019] systemd[1]: Finished kmod-static-nodes.service - Create
List of Static Device Nodes.
[   54.041904] systemd[1]: Starting
systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes
in /dev gracefully...
[   54.060142] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[   54.061561] systemd[1]: Finished modprobe@fuse.service - Load
Kernel Module fuse.
[   54.128765] pstore: Using crash dump compression: deflate
[   54.131472] pstore: Registered efi_pstore as persistent store backend
[   54.134152] systemd[1]: modprobe@efi_pstore.service: Deactivated
successfully.
[   54.134689] systemd[1]: Finished modprobe@efi_pstore.service - Load
Kernel Module efi_pstore.
[   54.213289] systemd[1]: modprobe@configfs.service: Deactivated successfully.
[   54.214641] systemd[1]: Finished modprobe@configfs.service - Load
Kernel Module configfs.
[   54.287290] ACPI: bus type drm_connector registered
[   54.290060] systemd[1]: modprobe@drm.service: Deactivated successfully.
[   54.291434] systemd[1]: Finished modprobe@drm.service - Load Kernel
Module drm.
[   54.328403] EXT4-fs (md1): re-mounted
c056bf20-f617-4c4a-8d3c-28ac04ff6a3a r/w. Quota mode: none.
[   54.330624] systemd[1]: Finished systemd-remount-fs.service -
Remount Root and Kernel File Systems.
[   54.332205] systemd[1]: systemd-hwdb-update.service - Rebuild
Hardware Database was skipped because of an unmet condition check
(ConditionNeedsUpdate=/etc).
[   54.332289] systemd[1]: systemd-pstore.service - Platform
Persistent Storage Archival was skipped because of an unmet condition
check (ConditionDirectoryNotEmpty=/sys/fs/pstore).
[   54.335125] systemd[1]: Starting systemd-random-seed.service -
Load/Save OS Random Seed...
[   54.337169] systemd[1]: systemd-tpm2-setup.service - TPM SRK Setup
was skipped because of an unmet condition check
(ConditionSecurity=measured-uki).
[   54.405613] systemd[1]: Finished
systemd-udev-load-credentials.service - Load udev Rules from
Credentials.
[   54.429165] lp: driver loaded but no devices found
[   54.447586] ppdev: user-space parallel port driver
[   54.454737] systemd-journald[981]: Collecting audit messages is disabled.
[   54.529090] systemd[1]: Started systemd-journald.service - Journal Service.
[   54.940722] nct6775: Found NCT6798D or compatible chip at 0x2e:0x290
[   55.093874] systemd-journald[981]: Received client request to flush
runtime journal.
[   56.283223] loop: module loaded
[   56.283925] loop0: detected capacity change from 0 to 104232
[   56.285135] loop1: detected capacity change from 0 to 1034424
[   56.285240] loop2: detected capacity change from 0 to 130600
[   56.285301] loop3: detected capacity change from 0 to 75960
[   56.285359] loop4: detected capacity change from 0 to 495608
[   56.285422] loop5: detected capacity change from 0 to 113384
[   56.285488] loop6: detected capacity change from 0 to 367608
[   56.285549] loop7: detected capacity change from 0 to 130568
[   56.287892] loop14: detected capacity change from 0 to 140080
[   56.288012] loop18: detected capacity change from 0 to 166424
[   56.288696] loop20: detected capacity change from 0 to 8
[   56.289216] loop13: detected capacity change from 0 to 827600
[   56.289358] loop23: detected capacity change from 0 to 151328
[   56.289828] loop21: detected capacity change from 0 to 187776
[   56.289926] loop11: detected capacity change from 0 to 828160
[   56.290156] loop10: detected capacity change from 0 to 494688
[   56.290173] loop19: detected capacity change from 0 to 716168
[   56.290265] loop28: detected capacity change from 0 to 424736
[   56.290316] loop22: detected capacity change from 0 to 151320
[   56.290373] loop27: detected capacity change from 0 to 433128
[   56.290463] loop8: detected capacity change from 0 to 136728
[   56.290523] loop26: detected capacity change from 0 to 716176
[   56.290526] loop9: detected capacity change from 0 to 367448
[   56.290529] loop12: detected capacity change from 0 to 337560
[   56.290598] loop25: detected capacity change from 0 to 135624
[   56.290598] loop15: detected capacity change from 0 to 1056784
[   56.290782] loop16: detected capacity change from 0 to 113384
[   56.291679] loop17: detected capacity change from 0 to 137568
[   56.291739] loop24: detected capacity change from 0 to 337560
[   56.304012] loop29: detected capacity change from 0 to 91024
[   56.524037] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   57.597490] nvidia: loading out-of-tree module taints kernel.
[   57.598159] nvidia: module license 'NVIDIA' taints kernel.
[   57.598809] Disabling lock debugging due to kernel taint
[   57.599460] nvidia: module license taints kernel.
[   58.129705] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters,
163840 ms ovfl timer
[   58.129925] sd 2:0:0:0: Attached scsi generic sg0 type 0
[   58.130418] RAPL PMU: hw unit of domain package 2^-16 Joules
[   58.130420] RAPL PMU: hw unit of domain core 2^-16 Joules
[   58.130709] ee1004 1-0052: 512 byte EE1004-compliant SPD EEPROM, read-only
[   58.131207] sr 3:0:0:0: Attached scsi generic sg1 type 5
[   58.132517] ee1004 1-0053: 512 byte EE1004-compliant SPD EEPROM, read-only
[   58.132677] nvidia-nvlink: Nvlink Core is being initialized, major
device number 242
[   58.133301] sd 4:0:0:0: Attached scsi generic sg2 type 0

[   58.134748] sd 5:0:0:0: Attached scsi generic sg3 type 0
[   58.136836] nvidia 0000:06:00.0: vgaarb: VGA decodes changed:
olddecodes=io+mem,decodes=none:owns=io+mem
[   58.186004] NVRM: loading NVIDIA UNIX x86_64 Kernel Module
545.29.06  Thu Nov 16 01:59:08 UTC 2023
[   58.187906] ccp 0000:08:00.1: enabling device (0000 -> 0002)
[   58.188965] ccp 0000:08:00.1: ccp: unable to access the device: you
might be running a broken BIOS.
[   58.189099] ccp 0000:08:00.1: psp enabled
[   58.256007] input: PC Speaker as /devices/platform/pcspkr/input/input14
[   58.288145] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[   58.289100] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   58.290026] Loaded X.509 cert 'wens:
61c038651aabdcf94bd0ac7ff06c7248db18c600'
[   58.606047] cryptd: max_cpu_qlen set to 1000
[   58.942275] AES CTR mode by8 optimization enabled
[   58.967077] Intel(R) Wireless WiFi driver for Linux
[   58.967912] iwlwifi 0000:04:00.0: enabling device (0000 -> 0002)
[   58.973082] iwlwifi 0000:04:00.0: Detected crf-id 0x3617, cnv-id
0x100530 wfpm id 0x80000000
[   58.973898] iwlwifi 0000:04:00.0: PCI dev 2723/0084, rev=0x340, rfid=0x10a100
[   58.974683] iwlwifi 0000:04:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MHz
[   59.092307] Bluetooth: Core ver 2.22
[   59.093103] NET: Registered PF_BLUETOOTH protocol family
[   59.093860] Bluetooth: HCI device and connection manager initialized
[   59.094618] Bluetooth: HCI socket layer initialized
[   59.095364] Bluetooth: L2CAP socket layer initialized
[   59.096117] Bluetooth: SCO socket layer initialized
[   59.097239] asus_wmi: ASUS WMI generic driver loaded
[   59.104065] iwlwifi 0000:04:00.0: TLV_FW_FSEQ_VERSION: FSEQ
Version: 89.3.35.37
[   59.139486] asus_wmi: Initialization: 0x0
[   59.140260] asus_wmi: BIOS WMI version: 0.9
[   59.141249] asus_wmi: SFUN value: 0x0
[   59.141295] eeepc-wmi eeepc-wmi: Detected ASUSWMI, use DCTS
[   59.143607] input: Eee PC WMI hotkeys as
/devices/platform/eeepc-wmi/input/input15
[   59.147345] iwlwifi 0000:04:00.0: loaded firmware version
77.2753b721.0 cc-a0-77.ucode op_mode iwlmvm
[   59.173020] Error: Driver 'pcspkr' is already registered, aborting...
[   59.329030] cfg80211: loaded regulatory.db is malformed or
signature is missing/invalid
[   59.496501] usbcore: registered new interface driver btusb
[   59.758029] nvidia-modeset: Loading NVIDIA Kernel Mode Setting
Driver for UNIX platforms  545.29.06  Thu Nov 16 01:47:29 UTC 2023
[   60.027881] snd_hda_intel 0000:06:00.1: Disabling MSI
[   60.028692] snd_hda_intel 0000:06:00.1: Handle vga_switcheroo audio client
[   60.029537] snd_hda_intel 0000:08:00.4: enabling device (0000 -> 0002)
[   60.057484] kvm_amd: TSC scaling supported
[   60.058246] kvm_amd: Nested Virtualization enabled
[   60.058995] kvm_amd: Nested Paging enabled
[   60.059752] kvm_amd: LBR virtualization supported
[   60.060487] kvm_amd: SEV enabled (ASIDs 1 - 509)
[   60.061220] kvm_amd: SEV-ES disabled (ASIDs 0 - 0)
[   60.061960] kvm_amd: Virtual VMLOAD VMSAVE supported
[   60.062683] kvm_amd: Virtual GIF supported
[   60.106573] MCE: In-kernel MCE decoding enabled.
[   60.152279] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.sfi
[   60.153075] Bluetooth: hci0: Boot Address: 0x24800
[   60.153839] Bluetooth: hci0: Firmware Version: 132-3.24
[   60.154601] Bluetooth: hci0: Firmware already loaded
[   60.165196] Bluetooth: hci0: HCI LE Coded PHY feature bit is set,
but its usage is not supported.
[   60.295238] input: HDA NVidia HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:03.1/0000:06:00.1/sound/card0/input16
[   60.296043] input: HDA NVidia HDMI/DP,pcm=7 as
/devices/pci0000:00/0000:00:03.1/0000:06:00.1/sound/card0/input17
[   60.296845] input: HDA NVidia HDMI/DP,pcm=8 as
/devices/pci0000:00/0000:00:03.1/0000:06:00.1/sound/card0/input18
[   60.297019] input: HDA NVidia HDMI/DP,pcm=9 as
/devices/pci0000:00/0000:00:03.1/0000:06:00.1/sound/card0/input19
[   60.321466] snd_hda_codec_realtek hdaudioC1D0: autoconfig for
ALC1220: line_outs=3 (0x14/0x15/0x16/0x0/0x0) type:line
[   60.322238] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
[   60.323008] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1
(0x1b/0x0/0x0/0x0/0x0)
[   60.323758] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
[   60.324513] snd_hda_codec_realtek hdaudioC1D0:    dig-out=0x1e/0x0
[   60.325252] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[   60.325254] snd_hda_codec_realtek hdaudioC1D0:      Rear Mic=0x18
[   60.326707] snd_hda_codec_realtek hdaudioC1D0:      Front Mic=0x19
[   60.326709] snd_hda_codec_realtek hdaudioC1D0:      Line=0x1a
[   60.341375] input: HD-Audio Generic Rear Mic as
/devices/pci0000:00/0000:00:08.1/0000:08:00.4/sound/card1/input20
[   60.342127] input: HD-Audio Generic Front Mic as
/devices/pci0000:00/0000:00:08.1/0000:08:00.4/sound/card1/input21
[   60.342862] input: HD-Audio Generic Line as
/devices/pci0000:00/0000:00:08.1/0000:08:00.4/sound/card1/input22
[   60.343864] input: HD-Audio Generic Line Out Front as
/devices/pci0000:00/0000:00:08.1/0000:08:00.4/sound/card1/input23
[   60.344808] input: HD-Audio Generic Line Out Surround as
/devices/pci0000:00/0000:00:08.1/0000:08:00.4/sound/card1/input24
[   60.344971] input: HD-Audio Generic Line Out CLFE as
/devices/pci0000:00/0000:00:08.1/0000:08:00.4/sound/card1/input25
[   60.345270] input: HD-Audio Generic Front Headphone as
/devices/pci0000:00/0000:00:08.1/0000:08:00.4/sound/card1/input26
[   60.382191] iwlwifi 0000:04:00.0: Detected RF HR B3, rfid=0x10a100
[   60.447667] iwlwifi 0000:04:00.0: base HW address: 5c:80:b6:0f:b9:aa
[   60.569705] iwlwifi 0000:04:00.0 wlp4s0: renamed from wlan0
[   60.749060] intel_rapl_common: Found RAPL domain package
[   60.749871] intel_rapl_common: Found RAPL domain core
[   61.074689] amd_atl: AMD Address Translation Library initialized
[   61.321493] [drm] [nvidia-drm] [GPU ID 0x00000600] Loading driver
[   61.885140] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is
disabled. Duplicate IMA measurements will not be recorded in the IMA
log.
[   61.885178] device-mapper: uevent: version 1.0.3
[   61.885265] device-mapper: ioctl: 4.49.0-ioctl (2025-01-17)
initialised: dm-devel@lists.linux.dev
[   62.269030] [drm] Initialized nvidia-drm 0.0.0 for 0000:06:00.0 on minor 0
[   66.393151] Adding 19496956k swap on /dev/mapper/cryptswap.
Priority:-2 extents:1 across:19496956k
[   68.932828] EXT4-fs (dm-0): mounted filesystem
51f7641b-40e8-42b0-b875-856556acda60 r/w with ordered data mode. Quota
mode: none.
[   70.136187] audit: type=1400 audit(1746988226.487:4):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="QtWebEngineProcess" pid=1716 comm="apparmor_parser"
[   70.136958] audit: type=1400 audit(1746988226.487:5):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="cam" pid=1724 comm="apparmor_parser"
[   70.137545] audit: type=1400 audit(1746988226.487:6):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="devhelp" pid=1731 comm="apparmor_parser"
[   70.138135] audit: type=1400 audit(1746988226.487:7):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="buildah" pid=1722 comm="apparmor_parser"
[   70.138719] audit: type=1400 audit(1746988226.487:8):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="1password" pid=1713 comm="apparmor_parser"
[   70.139307] audit: type=1400 audit(1746988226.487:9):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="brave" pid=1721 comm="apparmor_parser"
[   70.139896] audit: type=1400 audit(1746988226.487:10):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="evolution" pid=1734 comm="apparmor_parser"
[   70.140481] audit: type=1400 audit(1746988226.487:11):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="flatpak" pid=1736 comm="apparmor_parser"
[   70.141073] audit: type=1400 audit(1746988226.491:12):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="chromium" pid=1728 comm="apparmor_parser"
[   70.141655] audit: type=1400 audit(1746988226.491:13):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="ch-checkns" pid=1725 comm="apparmor_parser"
[   75.702593] logitech-hidpp-device 0003:046D:4050.0005: HID++ 4.5
device connected.
[   79.317814] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   79.318561] Bluetooth: BNEP filters: protocol multicast
[   79.319298] Bluetooth: BNEP socket layer initialized
[   79.322332] Bluetooth: MGMT ver 1.23
[   79.376852] NET: Registered PF_ALG protocol family
[   80.178901] Bluetooth: RFCOMM TTY layer initialized
[   80.179618] Bluetooth: RFCOMM socket layer initialized
[   80.180329] Bluetooth: RFCOMM ver 1.11
[   85.975382] NET: Registered PF_QIPCRTR protocol family
[   87.143530] loop30: detected capacity change from 0 to 8
[   97.400903] iwlwifi 0000:04:00.0: Registered PHC clock:
iwlwifi-PTP, with index: 1
[   98.387124] kauditd_printk_skb: 166 callbacks suppressed
[   98.387130] audit: type=1400 audit(1746988254.739:180):
apparmor="DENIED" operation="open" class="file"
profile="/usr/sbin/cupsd" name="/etc/paperspecs" pid=2336 comm="cupsd"
requested_mask="r" denied_mask="r" fsuid=0 ouid=0
[   99.828974] igc 0000:05:00.0 enp5s0: NIC Link is Up 1000 Mbps Full
Duplex, Flow Control: RX/TX
[  101.237948] audit: type=1400 audit(1746988257.591:181):
apparmor="DENIED" operation="capable" class="cap"
profile="/snap/snapd/24505/usr/lib/snapd/snap-confine" pid=2339
comm="snap-confine" capability=12  capname="net_admin"
