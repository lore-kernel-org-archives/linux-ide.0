Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4821B424A
	for <linux-ide@vger.kernel.org>; Mon,  5 May 2025 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746431948; cv=none; b=afjJyjwi3jEBE8eN74+3V1hlYw2T2Wn+6UU8vOYVYVgHtxzjK8FbKAEu6ztIZ6ryc8YYSzcAVO0EnmINYoJnLUlUT7NKrhu3U5vFx6kwJWboyxgP8AbLnucgY1JEDF2Rq1bQDS6Pv2l2pAxdvnzIBDEw2DBvkn1JolHffpbvxiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746431948; c=relaxed/simple;
	bh=t53tHQG8gotpPLnBQMCZ6J3DgkaVkoZBmaNo3WNw1/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClnPwzLykolhB8Xco6eFoXbhsP28+GPdJ4bD2RJk85APbQeRnzubK9nzX8wpfD7ce6dCdnujayfh+/dS+m+QSa6SjSaex0XL64b2Dn3uWy9P3RchbGkBKAJ+U4z4vM8KGCn5biEYb/4oruN4QG4hSzccTKCQnQ8WlvT2aRZlf8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hrsg0cQD; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hrsg0cQD"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e7387d4a336so3225647276.2
        for <linux-ide@vger.kernel.org>; Mon, 05 May 2025 00:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746431942; x=1747036742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SoiXJ3TyeCjxQr/pr54Doi6LdjqpWwN0xyoNdYlOVc=;
        b=Hrsg0cQDzOT+tsP4ElguQQHmSz3v9NtOYxtkHJgbnxoi0MU9QBMtfTzmm2ekSHVKgh
         eXuICanAj20EIkbdCe4LebS35UIBv6nxK1ctTuI7jXW/1y377oBs21/mlKu4LqGviq1B
         KmdM1e1nN5oICVeuwyOmsQ8yB5f5piB/lV8gKqct5yZL2EB98kV2oB+SW1iLJs5sDZNw
         YtpXPYQQWYTj8Oo/uuhuCkNDk+ko0xepB4ENMkRJv07xm9DvgEKl8gmiK+0IObUl+3uP
         gXutZigVLFJLYFiot3fJgk7TD8/QHrsZlcXY2PVSPVMQN1vVl1+BDW/k0ve8HOwSeSp2
         SwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746431942; x=1747036742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SoiXJ3TyeCjxQr/pr54Doi6LdjqpWwN0xyoNdYlOVc=;
        b=Q1b+zjXEeg+SatihqW+bGxaswSFsHpEsD3yukiyecePKvUu/9JuCmnuIi/lNk9pUGn
         MJHruDKR2zCI4uRwlgoRdmpCy1xtOjG62IPdPhGcOzXCIn+Tb6uZjonRcXRRgJKplIwG
         r8XaICazJt7hpfTEMMEoagBAvARU0jv9XR0GGnyJauDjnf41ZQnUsuvhMIf8ef8AgCVF
         bzXIZHJdLFvTZgTON5ou3EgtSRI2mX2Qq+pdNOw26S9uJIwQHpTtMP64A8ChBHXmbck+
         uIu3yHQYXTDDTo4RI/WG/ybdWNVzFnCzQe1vyWy7ppL09qo0z2F2oFxBN3Zjy/PT5MIZ
         d4kQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0MxaHwIPO0cku3vQUO44GNNplTtOZwbbbNVLwTxCfCy2Nnuw5/gr5bVdQjuF+/5tQc0QlAwGIicY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc/c+QM1NGH5WKRScfSkPzIV0cn7mKEXcyufrEdCFF9NIsfv/J
	wVsGBPWgzTd90ZxDoaqgjcap3pVokeF0NA1Uijsi37CfN0JIPziyu18/c3DAjWN/3fYuVUYQkiK
	F7xe+jK7oA/4jOzqHAwP/cjNOrv8=
X-Gm-Gg: ASbGncvFS2JFjC4xz74s0jH5S/3zWwN1MIvNHF0OUJVuzN6eiRQbbdEZ5q1/aLwWYh7
	8NnWt2n+Fk2GaT/l3v/d8XWMJEdT0ypVBzh4ECIGMVCLIHn7eY15akHHhCdSo9P3YGeWxMh4CPU
	HRkbRu60riL8zoJIqk+4RTMkw=
X-Google-Smtp-Source: AGHT+IElKwEgdK0phcN/W50pLnwFYbFPSDT/Wq/8FGc1oEKK4hqUQqPKDMZVxuFtLkLAfrT6acv31Y9fLGS+ooNNbcA=
X-Received: by 2002:a05:6902:2b0f:b0:e72:fc04:7921 with SMTP id
 3f1490d57ef6-e757d35c516mr8616423276.33.1746431940965; Mon, 05 May 2025
 00:59:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADUzMVbneDW06V4vd8si8k=NN_6df3JeejaF3fVk2U=LVC1UHA@mail.gmail.com>
 <fe406980-f230-4060-9b1a-16295b6cfa48@kernel.org> <88a6fb5f-dc85-41e0-a65d-92704b4c8499@kernel.org>
In-Reply-To: <88a6fb5f-dc85-41e0-a65d-92704b4c8499@kernel.org>
From: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Date: Mon, 5 May 2025 10:58:22 +0300
X-Gm-Features: ATxdqUEBV73Si_Xv-MuuHwu5CguKN-1_9s0d2BAqaGrtv6MYDLTdVsv-C_Hv4ZE
Message-ID: <CAAZ0mTeepp7G9CtLFq+U_n0h2+SF8V8j2K=0hkNAp0Fzdc7TAQ@mail.gmail.com>
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Ioannis Barkas <jnyb.de@gmail.com>, linux-ide@vger.kernel.org, 
	Niklas Cassel <Niklas.Cassel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > On 5/1/25 05:36, Ioannis Barkas wrote:
> >> It would be better to have more details on this since only the 2TB
> >> model is targeted.

Hello guys,
first of all thanks for helping me with git format-patch, I should
have read instructions about not using gmail text mode. The last patch
I sent (or not can't remember for sure) was a dot matrix printer
driver for something like 1.1.95 :)

I have two WD20EFAX-68FB5N0 and both behave consistently, unusable
from 6.9.0 on as they just keep resetting the SATA link , but they
have worked flawlessly with 6.8.x for a year and also now with the
quirk applied.

I have also tested a different WDC model with med_power_with_dipm on
the same SATA port and there are no problems.

But after you guys got suspicious I found there is in fact a SATA port
on my motherboard where the WD20EFAX-68FB5N0 works with LPM on. So I
guess it's entirely possible that this is after all some kind of
interoperating issue between a certain SATA port of a ASUS B550 F
Gaming WiFi and the WDC, either unique to my items or in a larger
production batch.

Best regards,
Mikko
-----------------------
touko 05 09:18:59 taavi kernel: Linux version 6.14.5 (mjkorhon@taavi)
(gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44)
#2 SMP PREEMPT_DYNAMIC Sun May  4 23:34:05 EEST 2025
touko 05 09:18:59 taavi kernel: Command line:
BOOT_IMAGE=3D/boot/vmlinuz-6.14.5
root=3DUUID=3Dc056bf20-f617-4c4a-8d3c-28ac04ff6a3a ro lockdown=3Dintegrity
splash
touko 05 09:18:59 taavi kernel: BIOS-provided physical RAM map:
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x0000000000000000-0x000000000009ffff] usable
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x00000000000a0000-0x00000000000fffff] reserved
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x0000000000100000-0x0000000009d1efff] usable
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x0000000009d1f000-0x0000000009ffffff] reserved
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x000000000a000000-0x000000000a1fffff] usable
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x000000000a200000-0x000000000a210fff] ACPI NVS
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x000000000a211000-0x000000000affffff] usable
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x000000000b000000-0x000000000b01ffff] reserved
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x000000000b020000-0x00000000c9e26fff] usable
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x00000000c9e27000-0x00000000ca1ddfff] reserved
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x00000000ca1de000-0x00000000ca39ffff] ACPI data
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x00000000ca3a0000-0x00000000cab3efff] ACPI NVS
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x00000000cab3f000-0x00000000cb9fefff] reserved
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x00000000cb9ff000-0x00000000ccffffff] usable
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x00000000cd000000-0x00000000cfffffff] reserved
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x00000000f0000000-0x00000000f7ffffff] reserved
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x00000000fd200000-0x00000000fd2fffff] reserved
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x00000000fd600000-0x00000000fd7fffff] reserved
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x00000000fea00000-0x00000000fea0ffff] reserved
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x00000000feb80000-0x00000000fec01fff] reserved
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x00000000fec10000-0x00000000fec10fff] reserved
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x00000000fec30000-0x00000000fec30fff] reserved
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x00000000fed00000-0x00000000fed00fff] reserved
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x00000000fed40000-0x00000000fed44fff] reserved
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x00000000fed80000-0x00000000fed8ffff] reserved
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x00000000fedc2000-0x00000000fedcffff] reserved
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x00000000fedd4000-0x00000000fedd5fff] reserved
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x00000000ff000000-0x00000000ffffffff] reserved
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x0000000100000000-0x000000082f2fffff] usable
touko 05 09:18:59 taavi kernel: BIOS-e820: [mem
0x000000082f300000-0x000000082fffffff] reserved
touko 05 09:18:59 taavi kernel: Kernel is locked down from command
line; see man kernel_lockdown.7
touko 05 09:18:59 taavi kernel: NX (Execute Disable) protection: active
touko 05 09:18:59 taavi kernel: APIC: Static calls initialized
touko 05 09:18:59 taavi kernel: e820: update [mem
0xab0e5018-0xab0f4067] usable =3D=3D> usable
touko 05 09:18:59 taavi kernel: e820: update [mem
0xab0c5018-0xab0e4a57] usable =3D=3D> usable
touko 05 09:18:59 taavi kernel: extended physical RAM map:
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x0000000000000000-0x000000000009ffff] usable
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000000a0000-0x00000000000fffff] reserved
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x0000000000100000-0x0000000009d1efff] usable
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x0000000009d1f000-0x0000000009ffffff] reserved
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x000000000a000000-0x000000000a1fffff] usable
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x000000000a200000-0x000000000a210fff] ACPI NVS
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x000000000a211000-0x000000000affffff] usable
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x000000000b000000-0x000000000b01ffff] reserved
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x000000000b020000-0x00000000ab0c5017] usable
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000ab0c5018-0x00000000ab0e4a57] usable
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000ab0e4a58-0x00000000ab0e5017] usable
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000ab0e5018-0x00000000ab0f4067] usable
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000ab0f4068-0x00000000c9e26fff] usable
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000c9e27000-0x00000000ca1ddfff] reserved
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000ca1de000-0x00000000ca39ffff] ACPI data
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000ca3a0000-0x00000000cab3efff] ACPI NVS
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000cab3f000-0x00000000cb9fefff] reserved
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000cb9ff000-0x00000000ccffffff] usable
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000cd000000-0x00000000cfffffff] reserved
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000f0000000-0x00000000f7ffffff] reserved
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000fd200000-0x00000000fd2fffff] reserved
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000fd600000-0x00000000fd7fffff] reserved
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000fea00000-0x00000000fea0ffff] reserved
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000feb80000-0x00000000fec01fff] reserved
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000fec10000-0x00000000fec10fff] reserved
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000fec30000-0x00000000fec30fff] reserved
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000fed00000-0x00000000fed00fff] reserved
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000fed40000-0x00000000fed44fff] reserved
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000fed80000-0x00000000fed8ffff] reserved
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000fedc2000-0x00000000fedcffff] reserved
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000fedd4000-0x00000000fedd5fff] reserved
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x00000000ff000000-0x00000000ffffffff] reserved
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x0000000100000000-0x000000082f2fffff] usable
touko 05 09:18:59 taavi kernel: reserve setup_data: [mem
0x000000082f300000-0x000000082fffffff] reserved
touko 05 09:18:59 taavi kernel: efi: EFI v2.7 by American Megatrends
touko 05 09:18:59 taavi kernel: efi: ACPI=3D0xca39f000 ACPI
2.0=3D0xca39f014 TPMFinalLog=3D0xcaaf4000 SMBIOS=3D0xcb7f0000 SMBIOS
3.0=3D0xcb7ef000 MEMATTR=3D0xc7c48018 ESRT=3D0xc64d4118 MOKvar=3D0xcb84c000
INITRD=3D0xc0159598 RNG=3D0xca386c18 TPMEventLog=3D0xca229018
touko 05 09:18:59 taavi kernel: random: crng init done
touko 05 09:18:59 taavi kernel: efi: Remove mem71: MMIO
range=3D[0xf0000000-0xf7ffffff] (128MB) from e820 map
touko 05 09:18:59 taavi kernel: e820: remove [mem
0xf0000000-0xf7ffffff] reserved
touko 05 09:18:59 taavi kernel: efi: Remove mem72: MMIO
range=3D[0xfd200000-0xfd2fffff] (1MB) from e820 map
touko 05 09:18:59 taavi kernel: e820: remove [mem
0xfd200000-0xfd2fffff] reserved
touko 05 09:18:59 taavi kernel: efi: Remove mem73: MMIO
range=3D[0xfd600000-0xfd7fffff] (2MB) from e820 map
touko 05 09:18:59 taavi kernel: e820: remove [mem
0xfd600000-0xfd7fffff] reserved
touko 05 09:18:59 taavi kernel: efi: Not removing mem74: MMIO
range=3D[0xfea00000-0xfea0ffff] (64KB) from e820 map
touko 05 09:18:59 taavi kernel: efi: Remove mem75: MMIO
range=3D[0xfeb80000-0xfec01fff] (0MB) from e820 map
touko 05 09:18:59 taavi kernel: e820: remove [mem
0xfeb80000-0xfec01fff] reserved
touko 05 09:18:59 taavi kernel: efi: Not removing mem76: MMIO
range=3D[0xfec10000-0xfec10fff] (4KB) from e820 map
touko 05 09:18:59 taavi kernel: efi: Not removing mem77: MMIO
range=3D[0xfec30000-0xfec30fff] (4KB) from e820 map
touko 05 09:18:59 taavi kernel: efi: Not removing mem78: MMIO
range=3D[0xfed00000-0xfed00fff] (4KB) from e820 map
touko 05 09:18:59 taavi kernel: efi: Not removing mem79: MMIO
range=3D[0xfed40000-0xfed44fff] (20KB) from e820 map
touko 05 09:18:59 taavi kernel: efi: Not removing mem80: MMIO
range=3D[0xfed80000-0xfed8ffff] (64KB) from e820 map
touko 05 09:18:59 taavi kernel: efi: Not removing mem81: MMIO
range=3D[0xfedc2000-0xfedcffff] (56KB) from e820 map
touko 05 09:18:59 taavi kernel: efi: Not removing mem82: MMIO
range=3D[0xfedd4000-0xfedd5fff] (8KB) from e820 map
touko 05 09:18:59 taavi kernel: efi: Remove mem83: MMIO
range=3D[0xff000000-0xffffffff] (16MB) from e820 map
touko 05 09:18:59 taavi kernel: e820: remove [mem
0xff000000-0xffffffff] reserved
touko 05 09:18:59 taavi kernel: SMBIOS 3.3.0 present.
touko 05 09:18:59 taavi kernel: DMI: ASUS System Product Name/ROG
STRIX B550-F GAMING (WI-FI), BIOS 3611 09/29/2024
touko 05 09:18:59 taavi kernel: DMI: Memory slots populated: 2/4
touko 05 09:18:59 taavi kernel: tsc: Fast TSC calibration using PIT
touko 05 09:18:59 taavi kernel: tsc: Detected 3792.976 MHz processor
touko 05 09:18:59 taavi kernel: e820: update [mem
0x00000000-0x00000fff] usable =3D=3D> reserved
touko 05 09:18:59 taavi kernel: e820: remove [mem 0x000a0000-0x000fffff] us=
able
touko 05 09:18:59 taavi kernel: last_pfn =3D 0x82f300 max_arch_pfn =3D 0x40=
0000000
touko 05 09:18:59 taavi kernel: MTRR map: 7 entries (3 fixed + 4
variable; max 20), built from 9 variable MTRRs
touko 05 09:18:59 taavi kernel: x86/PAT: Configuration [0-7]: WB  WC
UC- UC  WB  WP  UC- WT
touko 05 09:18:59 taavi kernel: e820: update [mem
0xca530000-0xca53ffff] usable =3D=3D> reserved
touko 05 09:18:59 taavi kernel: e820: update [mem
0xd0000000-0xffffffff] usable =3D=3D> reserved
touko 05 09:18:59 taavi kernel: last_pfn =3D 0xcd000 max_arch_pfn =3D 0x400=
000000
touko 05 09:18:59 taavi kernel: esrt: Reserving ESRT space from
0x00000000c64d4118 to 0x00000000c64d4150.
touko 05 09:18:59 taavi kernel: e820: update [mem
0xc64d4000-0xc64d4fff] usable =3D=3D> reserved
touko 05 09:18:59 taavi kernel: Using GB pages for direct mapping
touko 05 09:18:59 taavi kernel: Secure boot disabled
touko 05 09:18:59 taavi kernel: RAMDISK: [mem 0xab0f5000-0xb2d93fff]
touko 05 09:18:59 taavi kernel: ACPI: Early table checksum verification dis=
abled
touko 05 09:18:59 taavi kernel: ACPI: RSDP 0x00000000CA39F014 000024
(v02 ALASKA)
touko 05 09:18:59 taavi kernel: ACPI: XSDT 0x00000000CA39E728 0000D4
(v01 ALASKA A M I    01072009 AMI  01000013)
touko 05 09:18:59 taavi kernel: ACPI: FACP 0x00000000CA397000 000114
(v06 ALASKA A M I    01072009 AMI  00010013)
touko 05 09:18:59 taavi kernel: ACPI: DSDT 0x00000000CA38B000 00B15E
(v02 ALASKA A M I    01072009 INTL 20120913)
touko 05 09:18:59 taavi kernel: ACPI: FACS 0x00000000CAB24000 000040
touko 05 09:18:59 taavi kernel: ACPI: SSDT 0x00000000CA39D000 00092A
(v02 AMD    AmdTable 00000002 MSFT 04000000)
touko 05 09:18:59 taavi kernel: ACPI: SSDT 0x00000000CA399000 003B8E
(v02 AMD    AMD AOD  00000001 INTL 20120913)
touko 05 09:18:59 taavi kernel: ACPI: SSDT 0x00000000CA398000 000309
(v02 ALASKA CPUSSDT  01072009 AMI  01072009)
touko 05 09:18:59 taavi kernel: ACPI: FIDT 0x00000000CA38A000 00009C
(v01 ALASKA A M I    01072009 AMI  00010013)
touko 05 09:18:59 taavi kernel: ACPI: MCFG 0x00000000CA388000 00003C
(v01 ALASKA A M I    01072009 MSFT 00010013)
touko 05 09:18:59 taavi kernel: ACPI: HPET 0x00000000CA387000 000038
(v01 ALASKA A M I    01072009 AMI  00000005)
touko 05 09:18:59 taavi kernel: ACPI: IVRS 0x00000000CA385000 0000D0
(v02 AMD    AmdTable 00000001 AMD  00000001)
touko 05 09:18:59 taavi kernel: ACPI: BGRT 0x00000000CA384000 000038
(v01 ALASKA A M I    01072009 AMI  00010013)
touko 05 09:18:59 taavi kernel: ACPI: WPBT 0x00000000CA24E000 00003C
(v01 ALASKA A M I    00000001 ASUS 00000001)
touko 05 09:18:59 taavi kernel: ACPI: TPM2 0x00000000CA24D000 00004C
(v04 ALASKA A M I    00000001 AMI  00000000)
touko 05 09:18:59 taavi kernel: ACPI: PCCT 0x00000000CA24C000 00006E
(v02 AMD    AmdTable 00000001 AMD  00000001)
touko 05 09:18:59 taavi kernel: ACPI: SSDT 0x00000000CA245000 0061A3
(v02 AMD    AmdTable 00000001 AMD  00000001)
touko 05 09:18:59 taavi kernel: ACPI: CRAT 0x00000000CA243000 0016D0
(v01 AMD    AmdTable 00000001 AMD  00000001)
touko 05 09:18:59 taavi kernel: ACPI: CDIT 0x00000000CA242000 000029
(v01 AMD    AmdTable 00000001 AMD  00000001)
touko 05 09:18:59 taavi kernel: ACPI: SSDT 0x00000000CA241000 000259
(v02 AMD    ArticDGP 00000001 INTL 20120913)
touko 05 09:18:59 taavi kernel: ACPI: SSDT 0x00000000CA23D000 003E6E
(v02 AMD    ArticN   00000001 INTL 20120913)
touko 05 09:18:59 taavi kernel: ACPI: WSMT 0x00000000CA23C000 000028
(v01 ALASKA A M I    01072009 AMI  00010013)
touko 05 09:18:59 taavi kernel: ACPI: APIC 0x00000000CA23B000 00015E
(v04 ALASKA A M I    01072009 AMI  00010013)
touko 05 09:18:59 taavi kernel: ACPI: SSDT 0x00000000CA23A000 00007D
(v02 AMD    ArticDIS 00000001 INTL 20120913)
touko 05 09:18:59 taavi kernel: ACPI: SSDT 0x00000000CA239000 0000BF
(v01 AMD    AmdTable 00001000 INTL 20120913)
touko 05 09:18:59 taavi kernel: ACPI: FPDT 0x00000000CA238000 000044
(v01 ALASKA A M I    01072009 AMI  01000013)
touko 05 09:18:59 taavi kernel: ACPI: Reserving FACP table memory at
[mem 0xca397000-0xca397113]
touko 05 09:18:59 taavi kernel: ACPI: Reserving DSDT table memory at
[mem 0xca38b000-0xca39615d]
touko 05 09:18:59 taavi kernel: ACPI: Reserving FACS table memory at
[mem 0xcab24000-0xcab2403f]
touko 05 09:18:59 taavi kernel: ACPI: Reserving SSDT table memory at
[mem 0xca39d000-0xca39d929]
touko 05 09:18:59 taavi kernel: ACPI: Reserving SSDT table memory at
[mem 0xca399000-0xca39cb8d]
touko 05 09:18:59 taavi kernel: ACPI: Reserving SSDT table memory at
[mem 0xca398000-0xca398308]
touko 05 09:18:59 taavi kernel: ACPI: Reserving FIDT table memory at
[mem 0xca38a000-0xca38a09b]
touko 05 09:18:59 taavi kernel: ACPI: Reserving MCFG table memory at
[mem 0xca388000-0xca38803b]
touko 05 09:18:59 taavi kernel: ACPI: Reserving HPET table memory at
[mem 0xca387000-0xca387037]
touko 05 09:18:59 taavi kernel: ACPI: Reserving IVRS table memory at
[mem 0xca385000-0xca3850cf]
touko 05 09:18:59 taavi kernel: ACPI: Reserving BGRT table memory at
[mem 0xca384000-0xca384037]
touko 05 09:18:59 taavi kernel: ACPI: Reserving WPBT table memory at
[mem 0xca24e000-0xca24e03b]
touko 05 09:18:59 taavi kernel: ACPI: Reserving TPM2 table memory at
[mem 0xca24d000-0xca24d04b]
touko 05 09:18:59 taavi kernel: ACPI: Reserving PCCT table memory at
[mem 0xca24c000-0xca24c06d]
touko 05 09:18:59 taavi kernel: ACPI: Reserving SSDT table memory at
[mem 0xca245000-0xca24b1a2]
touko 05 09:18:59 taavi kernel: ACPI: Reserving CRAT table memory at
[mem 0xca243000-0xca2446cf]
touko 05 09:18:59 taavi kernel: ACPI: Reserving CDIT table memory at
[mem 0xca242000-0xca242028]
touko 05 09:18:59 taavi kernel: ACPI: Reserving SSDT table memory at
[mem 0xca241000-0xca241258]
touko 05 09:18:59 taavi kernel: ACPI: Reserving SSDT table memory at
[mem 0xca23d000-0xca240e6d]
touko 05 09:18:59 taavi kernel: ACPI: Reserving WSMT table memory at
[mem 0xca23c000-0xca23c027]
touko 05 09:18:59 taavi kernel: ACPI: Reserving APIC table memory at
[mem 0xca23b000-0xca23b15d]
touko 05 09:18:59 taavi kernel: ACPI: Reserving SSDT table memory at
[mem 0xca23a000-0xca23a07c]
touko 05 09:18:59 taavi kernel: ACPI: Reserving SSDT table memory at
[mem 0xca239000-0xca2390be]
touko 05 09:18:59 taavi kernel: ACPI: Reserving FPDT table memory at
[mem 0xca238000-0xca238043]
touko 05 09:18:59 taavi kernel: No NUMA configuration found
touko 05 09:18:59 taavi kernel: Faking a node at [mem
0x0000000000000000-0x000000082f2fffff]
touko 05 09:18:59 taavi kernel: NODE_DATA(0) allocated [mem
0x82f2d5680-0x82f2fffff]
touko 05 09:18:59 taavi kernel: Zone ranges:
touko 05 09:18:59 taavi kernel:   DMA      [mem
0x0000000000001000-0x0000000000ffffff]
touko 05 09:18:59 taavi kernel:   DMA32    [mem
0x0000000001000000-0x00000000ffffffff]
touko 05 09:18:59 taavi kernel:   Normal   [mem
0x0000000100000000-0x000000082f2fffff]
touko 05 09:18:59 taavi kernel:   Device   empty
touko 05 09:18:59 taavi kernel: Movable zone start for each node
touko 05 09:18:59 taavi kernel: Early memory node ranges
touko 05 09:18:59 taavi kernel:   node   0: [mem
0x0000000000001000-0x000000000009ffff]
touko 05 09:18:59 taavi kernel:   node   0: [mem
0x0000000000100000-0x0000000009d1efff]
touko 05 09:18:59 taavi kernel:   node   0: [mem
0x000000000a000000-0x000000000a1fffff]
touko 05 09:18:59 taavi kernel:   node   0: [mem
0x000000000a211000-0x000000000affffff]
touko 05 09:18:59 taavi kernel:   node   0: [mem
0x000000000b020000-0x00000000c9e26fff]
touko 05 09:18:59 taavi kernel:   node   0: [mem
0x00000000cb9ff000-0x00000000ccffffff]
touko 05 09:18:59 taavi kernel:   node   0: [mem
0x0000000100000000-0x000000082f2fffff]
touko 05 09:18:59 taavi kernel: Initmem setup node 0 [mem
0x0000000000001000-0x000000082f2fffff]
touko 05 09:18:59 taavi kernel: On node 0, zone DMA: 1 pages in
unavailable ranges
touko 05 09:18:59 taavi kernel: On node 0, zone DMA: 96 pages in
unavailable ranges
touko 05 09:18:59 taavi kernel: On node 0, zone DMA32: 737 pages in
unavailable ranges
touko 05 09:18:59 taavi kernel: On node 0, zone DMA32: 17 pages in
unavailable ranges
touko 05 09:18:59 taavi kernel: On node 0, zone DMA32: 32 pages in
unavailable ranges
touko 05 09:18:59 taavi kernel: On node 0, zone DMA32: 7128 pages in
unavailable ranges
touko 05 09:18:59 taavi kernel: On node 0, zone Normal: 12288 pages in
unavailable ranges
touko 05 09:18:59 taavi kernel: On node 0, zone Normal: 3328 pages in
unavailable ranges
touko 05 09:18:59 taavi kernel: ACPI: PM-Timer IO Port: 0x808
touko 05 09:18:59 taavi kernel: CPU topo: Ignoring hot-pluggable APIC
ID 0 in present package.
touko 05 09:18:59 taavi kernel: ACPI: LAPIC_NMI (acpi_id[0xff] high
edge lint[0x1])
touko 05 09:18:59 taavi kernel: IOAPIC[0]: apic_id 25, version 33,
address 0xfec00000, GSI 0-23
touko 05 09:18:59 taavi kernel: IOAPIC[1]: apic_id 26, version 33,
address 0xfec01000, GSI 24-55
touko 05 09:18:59 taavi kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0
global_irq 2 dfl dfl)
touko 05 09:18:59 taavi kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9
global_irq 9 low level)
touko 05 09:18:59 taavi kernel: ACPI: Using ACPI (MADT) for SMP
configuration information
touko 05 09:18:59 taavi kernel: ACPI: HPET id: 0x10228201 base: 0xfed00000
touko 05 09:18:59 taavi kernel: e820: update [mem
0xc53b1000-0xc54a4fff] usable =3D=3D> reserved
touko 05 09:18:59 taavi kernel: CPU topo: Max. logical packages:   1
touko 05 09:18:59 taavi kernel: CPU topo: Max. logical dies:       1
touko 05 09:18:59 taavi kernel: CPU topo: Max. dies per package:   1
touko 05 09:18:59 taavi kernel: CPU topo: Max. threads per core:   2
touko 05 09:18:59 taavi kernel: CPU topo: Num. cores per package:    12
touko 05 09:18:59 taavi kernel: CPU topo: Num. threads per package:  24
touko 05 09:18:59 taavi kernel: CPU topo: Allowing 24 present CPUs
plus 0 hotplug CPUs
touko 05 09:18:59 taavi kernel: CPU topo: Rejected CPUs 8
touko 05 09:18:59 taavi kernel: PM: hibernation: Registered nosave
memory: [mem 0x00000000-0x00000fff]
touko 05 09:18:59 taavi kernel: PM: hibernation: Registered nosave
memory: [mem 0x000a0000-0x000fffff]
touko 05 09:18:59 taavi kernel: PM: hibernation: Registered nosave
memory: [mem 0x09d1f000-0x09ffffff]
touko 05 09:18:59 taavi kernel: PM: hibernation: Registered nosave
memory: [mem 0x0a200000-0x0a210fff]
touko 05 09:18:59 taavi kernel: PM: hibernation: Registered nosave
memory: [mem 0x0b000000-0x0b01ffff]
touko 05 09:18:59 taavi kernel: PM: hibernation: Registered nosave
memory: [mem 0xc53b1000-0xc54a4fff]
touko 05 09:18:59 taavi kernel: PM: hibernation: Registered nosave
memory: [mem 0xc64d4000-0xc64d4fff]
touko 05 09:18:59 taavi kernel: PM: hibernation: Registered nosave
memory: [mem 0xc9e27000-0xcb9fefff]
touko 05 09:18:59 taavi kernel: PM: hibernation: Registered nosave
memory: [mem 0xcd000000-0xffffffff]
touko 05 09:18:59 taavi kernel: [mem 0xd0000000-0xfe9fffff] available
for PCI devices
touko 05 09:18:59 taavi kernel: Booting paravirtualized kernel on bare hard=
ware
touko 05 09:18:59 taavi kernel: clocksource: refined-jiffies: mask:
0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
touko 05 09:18:59 taavi kernel: setup_percpu: NR_CPUS:8192
nr_cpumask_bits:24 nr_cpu_ids:24 nr_node_ids:1
touko 05 09:18:59 taavi kernel: percpu: Embedded 66 pages/cpu s233472
r8192 d28672 u524288
touko 05 09:18:59 taavi kernel: pcpu-alloc: s233472 r8192 d28672
u524288 alloc=3D1*2097152
touko 05 09:18:59 taavi kernel: pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07
touko 05 09:18:59 taavi kernel: pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15
touko 05 09:18:59 taavi kernel: pcpu-alloc: [0] 16 17 18 19 [0] 20 21 22 23
touko 05 09:18:59 taavi kernel: Kernel command line:
BOOT_IMAGE=3D/boot/vmlinuz-6.14.5
root=3DUUID=3Dc056bf20-f617-4c4a-8d3c-28ac04ff6a3a ro lockdown=3Dintegrity
splash
touko 05 09:18:59 taavi kernel: Unknown kernel command line parameters
"splash BOOT_IMAGE=3D/boot/vmlinuz-6.14.5", will be passed to user
space.
touko 05 09:18:59 taavi kernel: printk: log_buf_len individual max cpu
contribution: 4096 bytes
touko 05 09:18:59 taavi kernel: printk: log_buf_len total cpu_extra
contributions: 94208 bytes
touko 05 09:18:59 taavi kernel: printk: log_buf_len min size: 131072 bytes
touko 05 09:18:59 taavi kernel: printk: log buffer data + meta data:
262144 + 917504 =3D 1179648 bytes
touko 05 09:18:59 taavi kernel: printk: early log buf free: 114040(87%)
touko 05 09:18:59 taavi kernel: Dentry cache hash table entries:
4194304 (order: 13, 33554432 bytes, linear)
touko 05 09:18:59 taavi kernel: Inode-cache hash table entries:
2097152 (order: 12, 16777216 bytes, linear)
touko 05 09:18:59 taavi kernel: Fallback order for Node 0: 0
touko 05 09:18:59 taavi kernel: Built 1 zonelists, mobility grouping
on.  Total pages: 8364981
touko 05 09:18:59 taavi kernel: Policy zone: Normal
touko 05 09:18:59 taavi kernel: mem auto-init: stack:all(zero), heap
alloc:on, heap free:off
touko 05 09:18:59 taavi kernel: software IO TLB: area num 32.
touko 05 09:18:59 taavi kernel: SLUB: HWalign=3D64, Order=3D0-3,
MinObjects=3D0, CPUs=3D24, Nodes=3D1
touko 05 09:18:59 taavi kernel: ftrace: allocating 46051 entries in 180 pag=
es
touko 05 09:18:59 taavi kernel: ftrace: allocated 180 pages with 4 groups
touko 05 09:18:59 taavi kernel: Dynamic Preempt: voluntary
touko 05 09:18:59 taavi kernel: rcu: Preemptible hierarchical RCU
implementation.
touko 05 09:18:59 taavi kernel: rcu:         RCU restricting CPUs from
NR_CPUS=3D8192 to nr_cpu_ids=3D24.
touko 05 09:18:59 taavi kernel:         Trampoline variant of Tasks RCU ena=
bled.
touko 05 09:18:59 taavi kernel:         Rude variant of Tasks RCU enabled.
touko 05 09:18:59 taavi kernel:         Tracing variant of Tasks RCU enable=
d.
touko 05 09:18:59 taavi kernel: rcu: RCU calculated value of
scheduler-enlistment delay is 25 jiffies.
touko 05 09:18:59 taavi kernel: rcu: Adjusting geometry for
rcu_fanout_leaf=3D16, nr_cpu_ids=3D24
touko 05 09:18:59 taavi kernel: RCU Tasks: Setting shift to 5 and lim
to 1 rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D24.
touko 05 09:18:59 taavi kernel: RCU Tasks Rude: Setting shift to 5 and
lim to 1 rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D24.
touko 05 09:18:59 taavi kernel: RCU Tasks Trace: Setting shift to 5
and lim to 1 rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D24.
touko 05 09:18:59 taavi kernel: NR_IRQS: 524544, nr_irqs: 1160,
preallocated irqs: 16
touko 05 09:18:59 taavi kernel: rcu: srcu_init: Setting srcu_struct
sizes based on contention.
touko 05 09:18:59 taavi kernel: Console: colour dummy device 80x25
touko 05 09:18:59 taavi kernel: printk: legacy console [tty0] enabled
touko 05 09:18:59 taavi kernel: ACPI: Core revision 20240827
touko 05 09:18:59 taavi kernel: clocksource: hpet: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
touko 05 09:18:59 taavi kernel: APIC: Switch to symmetric I/O mode setup
touko 05 09:18:59 taavi kernel: AMD-Vi: Using global IVHD EFR:0x0, EFR2:0x0
touko 05 09:18:59 taavi kernel: x2apic: IRQ remapping doesn't support
X2APIC mode
touko 05 09:18:59 taavi kernel: ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2
apic2=3D-1 pin2=3D-1
touko 05 09:18:59 taavi kernel: clocksource: tsc-early: mask:
0xffffffffffffffff max_cycles: 0x6d58dc3ae67, max_idle_ns:
881591017573 ns
touko 05 09:18:59 taavi kernel: Calibrating delay loop (skipped),
value calculated using timer frequency.. 7585.95 BogoMIPS
(lpj=3D15171904)
touko 05 09:18:59 taavi kernel: x86/cpu: User Mode Instruction
Prevention (UMIP) activated
touko 05 09:18:59 taavi kernel: LVT offset 1 assigned for vector 0xf9
touko 05 09:18:59 taavi kernel: LVT offset 2 assigned for vector 0xf4
touko 05 09:18:59 taavi kernel: Last level iTLB entries: 4KB 1024, 2MB
1024, 4MB 512
touko 05 09:18:59 taavi kernel: Last level dTLB entries: 4KB 2048, 2MB
2048, 4MB 1024, 1GB 0
touko 05 09:18:59 taavi kernel: process: using mwait in idle threads
touko 05 09:18:59 taavi kernel: Spectre V1 : Mitigation:
usercopy/swapgs barriers and __user pointer sanitization
touko 05 09:18:59 taavi kernel: Spectre V2 : Mitigation: Retpolines
touko 05 09:18:59 taavi kernel: Spectre V2 : Spectre v2 / SpectreRSB:
Filling RSB on context switch and VMEXIT
touko 05 09:18:59 taavi kernel: Spectre V2 : Enabling Speculation
Barrier for firmware calls
touko 05 09:18:59 taavi kernel: RETBleed: Mitigation: untrained return thun=
k
touko 05 09:18:59 taavi kernel: Spectre V2 : mitigation: Enabling
conditional Indirect Branch Prediction Barrier
touko 05 09:18:59 taavi kernel: Spectre V2 : Selecting STIBP always-on
mode to complement retbleed mitigation
touko 05 09:18:59 taavi kernel: Spectre V2 : User space: Mitigation:
STIBP always-on protection
touko 05 09:18:59 taavi kernel: Speculative Store Bypass: Mitigation:
Speculative Store Bypass disabled via prctl
touko 05 09:18:59 taavi kernel: Speculative Return Stack Overflow:
Mitigation: Safe RET
touko 05 09:18:59 taavi kernel: x86/fpu: Supporting XSAVE feature
0x001: 'x87 floating point registers'
touko 05 09:18:59 taavi kernel: x86/fpu: Supporting XSAVE feature
0x002: 'SSE registers'
touko 05 09:18:59 taavi kernel: x86/fpu: Supporting XSAVE feature
0x004: 'AVX registers'
touko 05 09:18:59 taavi kernel: x86/fpu: xstate_offset[2]:  576,
xstate_sizes[2]:  256
touko 05 09:18:59 taavi kernel: x86/fpu: Enabled xstate features 0x7,
context size is 832 bytes, using 'compacted' format.
touko 05 09:18:59 taavi kernel: Freeing SMP alternatives memory: 40K
touko 05 09:18:59 taavi kernel: pid_max: default: 32768 minimum: 301
touko 05 09:18:59 taavi kernel: LSM: initializing
lsm=3Dlockdown,capability,landlock,yama,apparmor,tomoyo,bpf,ipe,ima,evm
touko 05 09:18:59 taavi kernel: landlock: Up and running.
touko 05 09:18:59 taavi kernel: Yama: becoming mindful.
touko 05 09:18:59 taavi kernel: AppArmor: AppArmor initialized
touko 05 09:18:59 taavi kernel: TOMOYO Linux initialized
touko 05 09:18:59 taavi kernel: LSM support for eBPF active
touko 05 09:18:59 taavi kernel: Mount-cache hash table entries: 65536
(order: 7, 524288 bytes, linear)
touko 05 09:18:59 taavi kernel: Mountpoint-cache hash table entries:
65536 (order: 7, 524288 bytes, linear)
touko 05 09:18:59 taavi kernel: smpboot: CPU0: AMD Ryzen 9 3900X
12-Core Processor (family: 0x17, model: 0x71, stepping: 0x0)
touko 05 09:18:59 taavi kernel: Performance Events: Fam17h+ core
perfctr, AMD PMU driver.
touko 05 09:18:59 taavi kernel: ... version:                0
touko 05 09:18:59 taavi kernel: ... bit width:              48
touko 05 09:18:59 taavi kernel: ... generic registers:      6
touko 05 09:18:59 taavi kernel: ... value mask:             0000fffffffffff=
f
touko 05 09:18:59 taavi kernel: ... max period:             00007ffffffffff=
f
touko 05 09:18:59 taavi kernel: ... fixed-purpose events:   0
touko 05 09:18:59 taavi kernel: ... event mask:             000000000000003=
f
touko 05 09:18:59 taavi kernel: signal: max sigframe size: 1776
touko 05 09:18:59 taavi kernel: rcu: Hierarchical SRCU implementation.
touko 05 09:18:59 taavi kernel: rcu:         Max phase no-delay
instances is 1000.
touko 05 09:18:59 taavi kernel: Timer migration: 2 hierarchy levels; 8
children per group; 2 crossnode level
touko 05 09:18:59 taavi kernel: NMI watchdog: Enabled. Permanently
consumes one hw-PMU counter.
touko 05 09:18:59 taavi kernel: smp: Bringing up secondary CPUs ...
touko 05 09:18:59 taavi kernel: smpboot: x86: Booting SMP configuration:
touko 05 09:18:59 taavi kernel: .... node  #0, CPUs:        #1  #2  #3
 #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20
#21 #22 #23
touko 05 09:18:59 taavi kernel: Spectre V2 : Update user space SMT
mitigation: STIBP always-on
touko 05 09:18:59 taavi kernel: smp: Brought up 1 node, 24 CPUs
touko 05 09:18:59 taavi kernel: smpboot: Total of 24 processors
activated (182062.84 BogoMIPS)
touko 05 09:18:59 taavi kernel: node 0 deferred pages initialised in 32ms
touko 05 09:18:59 taavi kernel: Memory: 32620060K/33459924K available
(15505K kernel code, 2501K rwdata, 11928K rodata, 4200K init, 4856K
bss, 822220K reserved, 0K cma-reserved)
touko 05 09:18:59 taavi kernel: devtmpfs: initialized
touko 05 09:18:59 taavi kernel: x86/mm: Memory block size: 128MB
touko 05 09:18:59 taavi kernel: ACPI: PM: Registering ACPI NVS region
[mem 0x0a200000-0x0a210fff] (69632 bytes)
touko 05 09:18:59 taavi kernel: ACPI: PM: Registering ACPI NVS region
[mem 0xca3a0000-0xcab3efff] (7991296 bytes)
touko 05 09:18:59 taavi kernel: clocksource: jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
touko 05 09:18:59 taavi kernel: futex hash table entries: 8192 (order:
7, 524288 bytes, linear)
touko 05 09:18:59 taavi kernel: pinctrl core: initialized pinctrl subsystem
touko 05 09:18:59 taavi kernel: NET: Registered PF_NETLINK/PF_ROUTE
protocol family
touko 05 09:18:59 taavi kernel: DMA: preallocated 4096 KiB GFP_KERNEL
pool for atomic allocations
touko 05 09:18:59 taavi kernel: DMA: preallocated 4096 KiB
GFP_KERNEL|GFP_DMA pool for atomic allocations
touko 05 09:18:59 taavi kernel: DMA: preallocated 4096 KiB
GFP_KERNEL|GFP_DMA32 pool for atomic allocations
touko 05 09:18:59 taavi kernel: audit: initializing netlink subsys (disable=
d)
touko 05 09:18:59 taavi kernel: audit: type=3D2000
audit(1746425825.260:1): state=3Dinitialized audit_enabled=3D0 res=3D1
touko 05 09:18:59 taavi kernel: thermal_sys: Registered thermal
governor 'fair_share'
touko 05 09:18:59 taavi kernel: thermal_sys: Registered thermal
governor 'bang_bang'
touko 05 09:18:59 taavi kernel: thermal_sys: Registered thermal
governor 'step_wise'
touko 05 09:18:59 taavi kernel: thermal_sys: Registered thermal
governor 'user_space'
touko 05 09:18:59 taavi kernel: thermal_sys: Registered thermal
governor 'power_allocator'
touko 05 09:18:59 taavi kernel: cpuidle: using governor ladder
touko 05 09:18:59 taavi kernel: cpuidle: using governor menu
touko 05 09:18:59 taavi kernel: Detected 1 PCC Subspaces
touko 05 09:18:59 taavi kernel: Registering PCC driver as Mailbox controlle=
r
touko 05 09:18:59 taavi kernel: acpiphp: ACPI Hot Plug PCI Controller
Driver version: 0.5
touko 05 09:18:59 taavi kernel: PCI: ECAM [mem 0xf0000000-0xf7ffffff]
(base 0xf0000000) for domain 0000 [bus 00-7f]
touko 05 09:18:59 taavi kernel: PCI: Using configuration type 1 for base ac=
cess
touko 05 09:18:59 taavi kernel: kprobes: kprobe jump-optimization is
enabled. All kprobes are optimized if possible.
touko 05 09:18:59 taavi kernel: HugeTLB: registered 1.00 GiB page
size, pre-allocated 0 pages
touko 05 09:18:59 taavi kernel: HugeTLB: 16380 KiB vmemmap can be
freed for a 1.00 GiB page
touko 05 09:18:59 taavi kernel: HugeTLB: registered 2.00 MiB page
size, pre-allocated 0 pages
touko 05 09:18:59 taavi kernel: HugeTLB: 28 KiB vmemmap can be freed
for a 2.00 MiB page
touko 05 09:18:59 taavi kernel: ACPI: Added _OSI(Module Device)
touko 05 09:18:59 taavi kernel: ACPI: Added _OSI(Processor Device)
touko 05 09:18:59 taavi kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
touko 05 09:18:59 taavi kernel: ACPI: Added _OSI(Processor Aggregator Devic=
e)
touko 05 09:18:59 taavi kernel: ACPI: 9 ACPI AML tables successfully
acquired and loaded
touko 05 09:18:59 taavi kernel: ACPI: [Firmware Bug]: BIOS _OSI(Linux)
query ignored
touko 05 09:18:59 taavi kernel: ACPI: Interpreter enabled
touko 05 09:18:59 taavi kernel: ACPI: PM: (supports S0 S3 S4 S5)
touko 05 09:18:59 taavi kernel: ACPI: Using IOAPIC for interrupt routing
touko 05 09:18:59 taavi kernel: PCI: Using host bridge windows from
ACPI; if necessary, use "pci=3Dnocrs" and report a bug
touko 05 09:18:59 taavi kernel: PCI: Ignoring E820 reservations for
host bridge windows
touko 05 09:18:59 taavi kernel: ACPI: Enabled 5 GPEs in block 00 to 1F
touko 05 09:18:59 taavi kernel: ACPI: PCI Root Bridge [PCI0] (domain
0000 [bus 00-ff])
touko 05 09:18:59 taavi kernel: acpi PNP0A08:00: _OSC: OS supports
[ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
touko 05 09:18:59 taavi kernel: acpi PNP0A08:00: _OSC: platform does
not support [PCIeHotplug SHPCHotplug PME LTR]
touko 05 09:18:59 taavi kernel: acpi PNP0A08:00: _OSC: OS now controls
[AER PCIeCapability]
touko 05 09:18:59 taavi kernel: acpi PNP0A08:00: [Firmware Info]: ECAM
[mem 0xf0000000-0xf7ffffff] for domain 0000 [bus 00-7f] only partially
covers this bridge
touko 05 09:18:59 taavi kernel: PCI host bridge to bus 0000:00
touko 05 09:18:59 taavi kernel: pci_bus 0000:00: root bus resource [io
 0x0000-0x03af window]
touko 05 09:18:59 taavi kernel: pci_bus 0000:00: root bus resource [io
 0x03e0-0x0cf7 window]
touko 05 09:18:59 taavi kernel: pci_bus 0000:00: root bus resource [io
 0x03b0-0x03df window]
touko 05 09:18:59 taavi kernel: pci_bus 0000:00: root bus resource [io
 0x0d00-0xffff window]
touko 05 09:18:59 taavi kernel: pci_bus 0000:00: root bus resource
[mem 0x000a0000-0x000dffff window]
touko 05 09:18:59 taavi kernel: pci_bus 0000:00: root bus resource
[mem 0xd0000000-0xfec2ffff window]
touko 05 09:18:59 taavi kernel: pci_bus 0000:00: root bus resource
[mem 0xfee00000-0xffffffff window]
touko 05 09:18:59 taavi kernel: pci_bus 0000:00: root bus resource [bus 00-=
ff]
touko 05 09:18:59 taavi kernel: pci 0000:00:00.0: [1022:1480] type 00
class 0x060000 conventional PCI endpoint
touko 05 09:18:59 taavi kernel: pci 0000:00:00.2: [1022:1481] type 00
class 0x080600 conventional PCI endpoint
touko 05 09:18:59 taavi kernel: pci 0000:00:01.0: [1022:1482] type 00
class 0x060000 conventional PCI endpoint
touko 05 09:18:59 taavi kernel: pci 0000:00:01.2: [1022:1483] type 01
class 0x060400 PCIe Root Port
touko 05 09:18:59 taavi kernel: pci 0000:00:01.2: PCI bridge to [bus 01-05]
touko 05 09:18:59 taavi kernel: pci 0000:00:01.2:   bridge window [mem
0xfc200000-0xfc5fffff]
touko 05 09:18:59 taavi kernel: pci 0000:00:01.2: enabling Extended Tags
touko 05 09:18:59 taavi kernel: pci 0000:00:01.2: PME# supported from
D0 D3hot D3cold
touko 05 09:18:59 taavi kernel: pci 0000:00:02.0: [1022:1482] type 00
class 0x060000 conventional PCI endpoint
touko 05 09:18:59 taavi kernel: pci 0000:00:03.0: [1022:1482] type 00
class 0x060000 conventional PCI endpoint
touko 05 09:18:59 taavi kernel: pci 0000:00:03.1: [1022:1483] type 01
class 0x060400 PCIe Root Port
touko 05 09:18:59 taavi kernel: pci 0000:00:03.1: PCI bridge to [bus 06]
touko 05 09:18:59 taavi kernel: pci 0000:00:03.1:   bridge window [io
0xf000-0xffff]
touko 05 09:18:59 taavi kernel: pci 0000:00:03.1:   bridge window [mem
0xfb000000-0xfc0fffff]
touko 05 09:18:59 taavi kernel: pci 0000:00:03.1:   bridge window [mem
0xd0000000-0xe20fffff 64bit pref]
touko 05 09:18:59 taavi kernel: pci 0000:00:03.1: PME# supported from
D0 D3hot D3cold
touko 05 09:18:59 taavi kernel: pci 0000:00:04.0: [1022:1482] type 00
class 0x060000 conventional PCI endpoint
touko 05 09:18:59 taavi kernel: pci 0000:00:05.0: [1022:1482] type 00
class 0x060000 conventional PCI endpoint
touko 05 09:18:59 taavi kernel: pci 0000:00:07.0: [1022:1482] type 00
class 0x060000 conventional PCI endpoint
touko 05 09:18:59 taavi kernel: pci 0000:00:07.1: [1022:1484] type 01
class 0x060400 PCIe Root Port
touko 05 09:18:59 taavi kernel: pci 0000:00:07.1: PCI bridge to [bus 07]
touko 05 09:18:59 taavi kernel: pci 0000:00:07.1: enabling Extended Tags
touko 05 09:18:59 taavi kernel: pci 0000:00:07.1: PME# supported from
D0 D3hot D3cold
touko 05 09:18:59 taavi kernel: pci 0000:00:08.0: [1022:1482] type 00
class 0x060000 conventional PCI endpoint
touko 05 09:18:59 taavi kernel: pci 0000:00:08.1: [1022:1484] type 01
class 0x060400 PCIe Root Port
touko 05 09:18:59 taavi kernel: pci 0000:00:08.1: PCI bridge to [bus 08]
touko 05 09:18:59 taavi kernel: pci 0000:00:08.1:   bridge window [mem
0xfc600000-0xfc8fffff]
touko 05 09:18:59 taavi kernel: pci 0000:00:08.1: enabling Extended Tags
touko 05 09:18:59 taavi kernel: pci 0000:00:08.1: PME# supported from
D0 D3hot D3cold
touko 05 09:18:59 taavi kernel: pci 0000:00:14.0: [1022:790b] type 00
class 0x0c0500 conventional PCI endpoint
touko 05 09:18:59 taavi kernel: pci 0000:00:14.3: [1022:790e] type 00
class 0x060100 conventional PCI endpoint
touko 05 09:18:59 taavi kernel: pci 0000:00:18.0: [1022:1440] type 00
class 0x060000 conventional PCI endpoint
touko 05 09:18:59 taavi kernel: pci 0000:00:18.1: [1022:1441] type 00
class 0x060000 conventional PCI endpoint
touko 05 09:18:59 taavi kernel: pci 0000:00:18.2: [1022:1442] type 00
class 0x060000 conventional PCI endpoint
touko 05 09:18:59 taavi kernel: pci 0000:00:18.3: [1022:1443] type 00
class 0x060000 conventional PCI endpoint
touko 05 09:18:59 taavi kernel: pci 0000:00:18.4: [1022:1444] type 00
class 0x060000 conventional PCI endpoint
touko 05 09:18:59 taavi kernel: pci 0000:00:18.5: [1022:1445] type 00
class 0x060000 conventional PCI endpoint
touko 05 09:18:59 taavi kernel: pci 0000:00:18.6: [1022:1446] type 00
class 0x060000 conventional PCI endpoint
touko 05 09:18:59 taavi kernel: pci 0000:00:18.7: [1022:1447] type 00
class 0x060000 conventional PCI endpoint
touko 05 09:18:59 taavi kernel: pci 0000:01:00.0: [1022:43ee] type 00
class 0x0c0330 PCIe Legacy Endpoint
touko 05 09:18:59 taavi kernel: pci 0000:01:00.0: BAR 0 [mem
0xfc5a0000-0xfc5a7fff 64bit]
touko 05 09:18:59 taavi kernel: pci 0000:01:00.0: enabling Extended Tags
touko 05 09:18:59 taavi kernel: pci 0000:01:00.0: PME# supported from
D3hot D3cold
touko 05 09:18:59 taavi kernel: pci 0000:01:00.1: [1022:43eb] type 00
class 0x010601 PCIe Legacy Endpoint
touko 05 09:18:59 taavi kernel: pci 0000:01:00.1: BAR 5 [mem
0xfc580000-0xfc59ffff]
touko 05 09:18:59 taavi kernel: pci 0000:01:00.1: ROM [mem
0xfc500000-0xfc57ffff pref]
touko 05 09:18:59 taavi kernel: pci 0000:01:00.1: enabling Extended Tags
touko 05 09:18:59 taavi kernel: pci 0000:01:00.1: PME# supported from
D3hot D3cold
touko 05 09:18:59 taavi kernel: pci 0000:01:00.2: [1022:43e9] type 01
class 0x060400 PCIe Switch Upstream Port
touko 05 09:18:59 taavi kernel: pci 0000:01:00.2: PCI bridge to [bus 02-05]
touko 05 09:18:59 taavi kernel: pci 0000:01:00.2:   bridge window [mem
0xfc200000-0xfc4fffff]
touko 05 09:18:59 taavi kernel: pci 0000:01:00.2: enabling Extended Tags
touko 05 09:18:59 taavi kernel: pci 0000:01:00.2: PME# supported from
D3hot D3cold
touko 05 09:18:59 taavi kernel: pci 0000:00:01.2: PCI bridge to [bus 01-05]
touko 05 09:18:59 taavi kernel: pci 0000:02:00.0: [1022:43ea] type 01
class 0x060400 PCIe Switch Downstream Port
touko 05 09:18:59 taavi kernel: pci 0000:02:00.0: PCI bridge to [bus 03]
touko 05 09:18:59 taavi kernel: pci 0000:02:00.0: enabling Extended Tags
touko 05 09:18:59 taavi kernel: pci 0000:02:00.0: PME# supported from
D3hot D3cold
touko 05 09:18:59 taavi kernel: pci 0000:02:08.0: [1022:43ea] type 01
class 0x060400 PCIe Switch Downstream Port
touko 05 09:18:59 taavi kernel: pci 0000:02:08.0: PCI bridge to [bus 04]
touko 05 09:18:59 taavi kernel: pci 0000:02:08.0:   bridge window [mem
0xfc400000-0xfc4fffff]
touko 05 09:18:59 taavi kernel: pci 0000:02:08.0: enabling Extended Tags
touko 05 09:18:59 taavi kernel: pci 0000:02:08.0: PME# supported from
D3hot D3cold
touko 05 09:18:59 taavi kernel: pci 0000:02:09.0: [1022:43ea] type 01
class 0x060400 PCIe Switch Downstream Port
touko 05 09:18:59 taavi kernel: pci 0000:02:09.0: PCI bridge to [bus 05]
touko 05 09:18:59 taavi kernel: pci 0000:02:09.0:   bridge window [mem
0xfc200000-0xfc3fffff]
touko 05 09:18:59 taavi kernel: pci 0000:02:09.0: enabling Extended Tags
touko 05 09:18:59 taavi kernel: pci 0000:02:09.0: PME# supported from
D3hot D3cold
touko 05 09:18:59 taavi kernel: pci 0000:01:00.2: PCI bridge to [bus 02-05]
touko 05 09:18:59 taavi kernel: pci 0000:02:00.0: PCI bridge to [bus 03]
touko 05 09:18:59 taavi kernel: pci 0000:04:00.0: [8086:2723] type 00
class 0x028000 PCIe Endpoint
touko 05 09:18:59 taavi kernel: pci 0000:04:00.0: BAR 0 [mem
0xfc400000-0xfc403fff 64bit]
touko 05 09:18:59 taavi kernel: pci 0000:04:00.0: PME# supported from
D0 D3hot D3cold
touko 05 09:18:59 taavi kernel: pci 0000:02:08.0: PCI bridge to [bus 04]
touko 05 09:18:59 taavi kernel: pci 0000:05:00.0: [8086:15f3] type 00
class 0x020000 PCIe Endpoint
touko 05 09:18:59 taavi kernel: pci 0000:05:00.0: BAR 0 [mem
0xfc200000-0xfc2fffff]
touko 05 09:18:59 taavi kernel: pci 0000:05:00.0: BAR 3 [mem
0xfc300000-0xfc303fff]
touko 05 09:18:59 taavi kernel: pci 0000:05:00.0: PME# supported from
D0 D3hot D3cold
touko 05 09:18:59 taavi kernel: pci 0000:02:09.0: PCI bridge to [bus 05]
touko 05 09:18:59 taavi kernel: pci 0000:06:00.0: [10de:1f08] type 00
class 0x030000 PCIe Legacy Endpoint
touko 05 09:18:59 taavi kernel: pci 0000:06:00.0: BAR 0 [mem
0xfb000000-0xfbffffff]
touko 05 09:18:59 taavi kernel: pci 0000:06:00.0: BAR 1 [mem
0xd0000000-0xdfffffff 64bit pref]
touko 05 09:18:59 taavi kernel: pci 0000:06:00.0: BAR 3 [mem
0xe0000000-0xe1ffffff 64bit pref]
touko 05 09:18:59 taavi kernel: pci 0000:06:00.0: BAR 5 [io  0xf000-0xf07f]
touko 05 09:18:59 taavi kernel: pci 0000:06:00.0: ROM [mem
0xfc000000-0xfc07ffff pref]
touko 05 09:18:59 taavi kernel: pci 0000:06:00.0: Video device with
shadowed ROM at [mem 0x000c0000-0x000dffff]
touko 05 09:18:59 taavi kernel: pci 0000:06:00.0: PME# supported from D0 D3=
hot
touko 05 09:18:59 taavi kernel: pci 0000:06:00.0: 32.000 Gb/s
available PCIe bandwidth, limited by 2.5 GT/s PCIe x16 link at
0000:00:03.1 (capable of 126.016 Gb/s with 8.0 GT/s PCIe x16 link)
touko 05 09:18:59 taavi kernel: pci 0000:06:00.1: [10de:10f9] type 00
class 0x040300 PCIe Endpoint
touko 05 09:18:59 taavi kernel: pci 0000:06:00.1: BAR 0 [mem
0xfc080000-0xfc083fff]
touko 05 09:18:59 taavi kernel: pci 0000:06:00.2: [10de:1ada] type 00
class 0x0c0330 PCIe Endpoint
touko 05 09:18:59 taavi kernel: pci 0000:06:00.2: BAR 0 [mem
0xe2000000-0xe203ffff 64bit pref]
touko 05 09:18:59 taavi kernel: pci 0000:06:00.2: BAR 3 [mem
0xe2040000-0xe204ffff 64bit pref]
touko 05 09:18:59 taavi kernel: pci 0000:06:00.2: PME# supported from D0 D3=
hot
touko 05 09:18:59 taavi kernel: pci 0000:06:00.3: [10de:1adb] type 00
class 0x0c8000 PCIe Endpoint
touko 05 09:18:59 taavi kernel: pci 0000:06:00.3: BAR 0 [mem
0xfc084000-0xfc084fff]
touko 05 09:18:59 taavi kernel: pci 0000:06:00.3: PME# supported from D0 D3=
hot
touko 05 09:18:59 taavi kernel: pci 0000:00:03.1: PCI bridge to [bus 06]
touko 05 09:18:59 taavi kernel: pci 0000:07:00.0: [1022:148a] type 00
class 0x130000 PCIe Endpoint
touko 05 09:18:59 taavi kernel: pci 0000:07:00.0: enabling Extended Tags
touko 05 09:18:59 taavi kernel: pci 0000:00:07.1: PCI bridge to [bus 07]
touko 05 09:18:59 taavi kernel: pci 0000:08:00.0: [1022:1485] type 00
class 0x130000 PCIe Endpoint
touko 05 09:18:59 taavi kernel: pci 0000:08:00.0: enabling Extended Tags
touko 05 09:18:59 taavi kernel: pci 0000:08:00.1: [1022:1486] type 00
class 0x108000 PCIe Endpoint
touko 05 09:18:59 taavi kernel: pci 0000:08:00.1: BAR 2 [mem
0xfc700000-0xfc7fffff]
touko 05 09:18:59 taavi kernel: pci 0000:08:00.1: BAR 5 [mem
0xfc808000-0xfc809fff]
touko 05 09:18:59 taavi kernel: pci 0000:08:00.1: enabling Extended Tags
touko 05 09:18:59 taavi kernel: pci 0000:08:00.3: [1022:149c] type 00
class 0x0c0330 PCIe Endpoint
touko 05 09:18:59 taavi kernel: pci 0000:08:00.3: BAR 0 [mem
0xfc600000-0xfc6fffff 64bit]
touko 05 09:18:59 taavi kernel: pci 0000:08:00.3: enabling Extended Tags
touko 05 09:18:59 taavi kernel: pci 0000:08:00.3: PME# supported from
D0 D3hot D3cold
touko 05 09:18:59 taavi kernel: pci 0000:08:00.4: [1022:1487] type 00
class 0x040300 PCIe Endpoint
touko 05 09:18:59 taavi kernel: pci 0000:08:00.4: BAR 0 [mem
0xfc800000-0xfc807fff]
touko 05 09:18:59 taavi kernel: pci 0000:08:00.4: enabling Extended Tags
touko 05 09:18:59 taavi kernel: pci 0000:08:00.4: PME# supported from
D0 D3hot D3cold
touko 05 09:18:59 taavi kernel: pci 0000:00:08.1: PCI bridge to [bus 08]
touko 05 09:18:59 taavi kernel: ACPI: PCI: Interrupt link LNKA
configured for IRQ 0
touko 05 09:18:59 taavi kernel: ACPI: PCI: Interrupt link LNKB
configured for IRQ 0
touko 05 09:18:59 taavi kernel: ACPI: PCI: Interrupt link LNKC
configured for IRQ 0
touko 05 09:18:59 taavi kernel: ACPI: PCI: Interrupt link LNKD
configured for IRQ 0
touko 05 09:18:59 taavi kernel: ACPI: PCI: Interrupt link LNKE
configured for IRQ 0
touko 05 09:18:59 taavi kernel: ACPI: PCI: Interrupt link LNKF
configured for IRQ 0
touko 05 09:18:59 taavi kernel: ACPI: PCI: Interrupt link LNKG
configured for IRQ 0
touko 05 09:18:59 taavi kernel: ACPI: PCI: Interrupt link LNKH
configured for IRQ 0
touko 05 09:18:59 taavi kernel: iommu: Default domain type: Translated
touko 05 09:18:59 taavi kernel: iommu: DMA domain TLB invalidation
policy: lazy mode
touko 05 09:18:59 taavi kernel: pps_core: LinuxPPS API ver. 1 registered
touko 05 09:18:59 taavi kernel: pps_core: Software ver. 5.3.6 -
Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
touko 05 09:18:59 taavi kernel: PTP clock support registered
touko 05 09:18:59 taavi kernel: EDAC MC: Ver: 3.0.0
touko 05 09:18:59 taavi kernel: efivars: Registered efivars operations
touko 05 09:18:59 taavi kernel: NetLabel: Initializing
touko 05 09:18:59 taavi kernel: NetLabel:  domain hash size =3D 128
touko 05 09:18:59 taavi kernel: NetLabel:  protocols =3D UNLABELED CIPSOv4 =
CALIPSO
touko 05 09:18:59 taavi kernel: NetLabel:  unlabeled traffic allowed by def=
ault
touko 05 09:18:59 taavi kernel: PCI: Using ACPI for IRQ routing
touko 05 09:18:59 taavi kernel: PCI: pci_cache_line_size set to 64 bytes
touko 05 09:18:59 taavi kernel: e820: reserve RAM buffer [mem
0x09d1f000-0x0bffffff]
touko 05 09:18:59 taavi kernel: e820: reserve RAM buffer [mem
0x0a200000-0x0bffffff]
touko 05 09:18:59 taavi kernel: e820: reserve RAM buffer [mem
0x0b000000-0x0bffffff]
touko 05 09:18:59 taavi kernel: e820: reserve RAM buffer [mem
0xab0c5018-0xabffffff]
touko 05 09:18:59 taavi kernel: e820: reserve RAM buffer [mem
0xab0e5018-0xabffffff]
touko 05 09:18:59 taavi kernel: e820: reserve RAM buffer [mem
0xc53b1000-0xc7ffffff]
touko 05 09:18:59 taavi kernel: e820: reserve RAM buffer [mem
0xc64d4000-0xc7ffffff]
touko 05 09:18:59 taavi kernel: e820: reserve RAM buffer [mem
0xc9e27000-0xcbffffff]
touko 05 09:18:59 taavi kernel: e820: reserve RAM buffer [mem
0xcd000000-0xcfffffff]
touko 05 09:18:59 taavi kernel: e820: reserve RAM buffer [mem
0x82f300000-0x82fffffff]
touko 05 09:18:59 taavi kernel: pci 0000:06:00.0: vgaarb: setting as
boot VGA device
touko 05 09:18:59 taavi kernel: pci 0000:06:00.0: vgaarb: bridge
control possible
touko 05 09:18:59 taavi kernel: pci 0000:06:00.0: vgaarb: VGA device
added: decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
touko 05 09:18:59 taavi kernel: vgaarb: loaded
touko 05 09:18:59 taavi kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
touko 05 09:18:59 taavi kernel: hpet0: 3 comparators, 32-bit 14.318180
MHz counter
touko 05 09:18:59 taavi kernel: clocksource: Switched to clocksource tsc-ea=
rly
touko 05 09:18:59 taavi kernel: VFS: Disk quotas dquot_6.6.0
touko 05 09:18:59 taavi kernel: VFS: Dquot-cache hash table entries:
512 (order 0, 4096 bytes)
touko 05 09:18:59 taavi kernel: AppArmor: AppArmor Filesystem Enabled
touko 05 09:18:59 taavi kernel: pnp: PnP ACPI init
touko 05 09:18:59 taavi kernel: system 00:00: [mem
0xf0000000-0xf7ffffff] has been reserved
touko 05 09:18:59 taavi kernel: system 00:01: [mem
0xfd200000-0xfd2fffff] has been reserved
touko 05 09:18:59 taavi kernel: system 00:03: [io  0x0290-0x029f] has
been reserved
touko 05 09:18:59 taavi kernel: system 00:03: [io  0x0200-0x021f] has
been reserved
touko 05 09:18:59 taavi kernel: system 00:04: [io  0x04d0-0x04d1] has
been reserved
touko 05 09:18:59 taavi kernel: system 00:04: [io  0x040b] has been reserve=
d
touko 05 09:18:59 taavi kernel: system 00:04: [io  0x04d6] has been reserve=
d
touko 05 09:18:59 taavi kernel: system 00:04: [io  0x0c00-0x0c01] has
been reserved
touko 05 09:18:59 taavi kernel: system 00:04: [io  0x0c14] has been reserve=
d
touko 05 09:18:59 taavi kernel: system 00:04: [io  0x0c50-0x0c51] has
been reserved
touko 05 09:18:59 taavi kernel: system 00:04: [io  0x0c52] has been reserve=
d
touko 05 09:18:59 taavi kernel: system 00:04: [io  0x0c6c] has been reserve=
d
touko 05 09:18:59 taavi kernel: system 00:04: [io  0x0c6f] has been reserve=
d
touko 05 09:18:59 taavi kernel: system 00:04: [io  0x0cd8-0x0cdf] has
been reserved
touko 05 09:18:59 taavi kernel: system 00:04: [io  0x0800-0x089f] has
been reserved
touko 05 09:18:59 taavi kernel: system 00:04: [io  0x0b00-0x0b0f] has
been reserved
touko 05 09:18:59 taavi kernel: system 00:04: [io  0x0b20-0x0b3f] has
been reserved
touko 05 09:18:59 taavi kernel: system 00:04: [io  0x0900-0x090f] has
been reserved
touko 05 09:18:59 taavi kernel: system 00:04: [io  0x0910-0x091f] has
been reserved
touko 05 09:18:59 taavi kernel: system 00:04: [mem
0xfec00000-0xfec00fff] could not be reserved
touko 05 09:18:59 taavi kernel: system 00:04: [mem
0xfec01000-0xfec01fff] could not be reserved
touko 05 09:18:59 taavi kernel: system 00:04: [mem
0xfedc0000-0xfedc0fff] has been reserved
touko 05 09:18:59 taavi kernel: system 00:04: [mem
0xfee00000-0xfee00fff] has been reserved
touko 05 09:18:59 taavi kernel: system 00:04: [mem
0xfed80000-0xfed8ffff] could not be reserved
touko 05 09:18:59 taavi kernel: system 00:04: [mem
0xfec10000-0xfec10fff] has been reserved
touko 05 09:18:59 taavi kernel: system 00:04: [mem
0xff000000-0xffffffff] has been reserved
touko 05 09:18:59 taavi kernel: pnp: PnP ACPI: found 5 devices
touko 05 09:18:59 taavi kernel: clocksource: acpi_pm: mask: 0xffffff
max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
touko 05 09:18:59 taavi kernel: NET: Registered PF_INET protocol family
touko 05 09:18:59 taavi kernel: IP idents hash table entries: 262144
(order: 9, 2097152 bytes, linear)
touko 05 09:18:59 taavi kernel: tcp_listen_portaddr_hash hash table
entries: 16384 (order: 6, 262144 bytes, linear)
touko 05 09:18:59 taavi kernel: Table-perturb hash table entries:
65536 (order: 6, 262144 bytes, linear)
touko 05 09:18:59 taavi kernel: TCP established hash table entries:
262144 (order: 9, 2097152 bytes, linear)
touko 05 09:18:59 taavi kernel: TCP bind hash table entries: 65536
(order: 9, 2097152 bytes, linear)
touko 05 09:18:59 taavi kernel: TCP: Hash tables configured
(established 262144 bind 65536)
touko 05 09:18:59 taavi kernel: MPTCP token hash table entries: 32768
(order: 7, 786432 bytes, linear)
touko 05 09:18:59 taavi kernel: UDP hash table entries: 16384 (order:
8, 1048576 bytes, linear)
touko 05 09:18:59 taavi kernel: UDP-Lite hash table entries: 16384
(order: 8, 1048576 bytes, linear)
touko 05 09:18:59 taavi kernel: NET: Registered PF_UNIX/PF_LOCAL protocol f=
amily
touko 05 09:18:59 taavi kernel: NET: Registered PF_XDP protocol family
touko 05 09:18:59 taavi kernel: pci 0000:02:00.0: PCI bridge to [bus 03]
touko 05 09:18:59 taavi kernel: pci 0000:02:08.0: PCI bridge to [bus 04]
touko 05 09:18:59 taavi kernel: pci 0000:02:08.0:   bridge window [mem
0xfc400000-0xfc4fffff]
touko 05 09:18:59 taavi kernel: pci 0000:02:09.0: PCI bridge to [bus 05]
touko 05 09:18:59 taavi kernel: pci 0000:02:09.0:   bridge window [mem
0xfc200000-0xfc3fffff]
touko 05 09:18:59 taavi kernel: pci 0000:01:00.2: PCI bridge to [bus 02-05]
touko 05 09:18:59 taavi kernel: pci 0000:01:00.2:   bridge window [mem
0xfc200000-0xfc4fffff]
touko 05 09:18:59 taavi kernel: pci 0000:00:01.2: PCI bridge to [bus 01-05]
touko 05 09:18:59 taavi kernel: pci 0000:00:01.2:   bridge window [mem
0xfc200000-0xfc5fffff]
touko 05 09:18:59 taavi kernel: pci 0000:00:03.1: PCI bridge to [bus 06]
touko 05 09:18:59 taavi kernel: pci 0000:00:03.1:   bridge window [io
0xf000-0xffff]
touko 05 09:18:59 taavi kernel: pci 0000:00:03.1:   bridge window [mem
0xfb000000-0xfc0fffff]
touko 05 09:18:59 taavi kernel: pci 0000:00:03.1:   bridge window [mem
0xd0000000-0xe20fffff 64bit pref]
touko 05 09:18:59 taavi kernel: pci 0000:00:07.1: PCI bridge to [bus 07]
touko 05 09:18:59 taavi kernel: pci 0000:00:08.1: PCI bridge to [bus 08]
touko 05 09:18:59 taavi kernel: pci 0000:00:08.1:   bridge window [mem
0xfc600000-0xfc8fffff]
touko 05 09:18:59 taavi kernel: pci_bus 0000:00: resource 4 [io
0x0000-0x03af window]
touko 05 09:18:59 taavi kernel: pci_bus 0000:00: resource 5 [io
0x03e0-0x0cf7 window]
touko 05 09:18:59 taavi kernel: pci_bus 0000:00: resource 6 [io
0x03b0-0x03df window]
touko 05 09:18:59 taavi kernel: pci_bus 0000:00: resource 7 [io
0x0d00-0xffff window]
touko 05 09:18:59 taavi kernel: pci_bus 0000:00: resource 8 [mem
0x000a0000-0x000dffff window]
touko 05 09:18:59 taavi kernel: pci_bus 0000:00: resource 9 [mem
0xd0000000-0xfec2ffff window]
touko 05 09:18:59 taavi kernel: pci_bus 0000:00: resource 10 [mem
0xfee00000-0xffffffff window]
touko 05 09:18:59 taavi kernel: pci_bus 0000:01: resource 1 [mem
0xfc200000-0xfc5fffff]
touko 05 09:18:59 taavi kernel: pci_bus 0000:02: resource 1 [mem
0xfc200000-0xfc4fffff]
touko 05 09:18:59 taavi kernel: pci_bus 0000:04: resource 1 [mem
0xfc400000-0xfc4fffff]
touko 05 09:18:59 taavi kernel: pci_bus 0000:05: resource 1 [mem
0xfc200000-0xfc3fffff]
touko 05 09:18:59 taavi kernel: pci_bus 0000:06: resource 0 [io  0xf000-0xf=
fff]
touko 05 09:18:59 taavi kernel: pci_bus 0000:06: resource 1 [mem
0xfb000000-0xfc0fffff]
touko 05 09:18:59 taavi kernel: pci_bus 0000:06: resource 2 [mem
0xd0000000-0xe20fffff 64bit pref]
touko 05 09:18:59 taavi kernel: pci_bus 0000:08: resource 1 [mem
0xfc600000-0xfc8fffff]
touko 05 09:18:59 taavi kernel: pci 0000:06:00.1: extending delay
after power-on from D3hot to 20 msec
touko 05 09:18:59 taavi kernel: pci 0000:06:00.1: D0 power state
depends on 0000:06:00.0
touko 05 09:18:59 taavi kernel: pci 0000:06:00.2: D0 power state
depends on 0000:06:00.0
touko 05 09:18:59 taavi kernel: pci 0000:06:00.3: D0 power state
depends on 0000:06:00.0
touko 05 09:18:59 taavi kernel: PCI: CLS 64 bytes, default 64
touko 05 09:18:59 taavi kernel: pci 0000:00:00.2: AMD-Vi: IOMMU
performance counters supported
touko 05 09:18:59 taavi kernel: Trying to unpack rootfs image as initramfs.=
..
touko 05 09:18:59 taavi kernel: pci 0000:00:00.0: Adding to iommu group 0
touko 05 09:18:59 taavi kernel: pci 0000:00:01.0: Adding to iommu group 1
touko 05 09:18:59 taavi kernel: pci 0000:00:01.2: Adding to iommu group 2
touko 05 09:18:59 taavi kernel: pci 0000:00:02.0: Adding to iommu group 3
touko 05 09:18:59 taavi kernel: pci 0000:00:03.0: Adding to iommu group 4
touko 05 09:18:59 taavi kernel: pci 0000:00:03.1: Adding to iommu group 5
touko 05 09:18:59 taavi kernel: pci 0000:00:04.0: Adding to iommu group 6
touko 05 09:18:59 taavi kernel: pci 0000:00:05.0: Adding to iommu group 7
touko 05 09:18:59 taavi kernel: pci 0000:00:07.0: Adding to iommu group 8
touko 05 09:18:59 taavi kernel: pci 0000:00:07.1: Adding to iommu group 9
touko 05 09:18:59 taavi kernel: pci 0000:00:08.0: Adding to iommu group 10
touko 05 09:18:59 taavi kernel: pci 0000:00:08.1: Adding to iommu group 11
touko 05 09:18:59 taavi kernel: pci 0000:00:14.0: Adding to iommu group 12
touko 05 09:18:59 taavi kernel: pci 0000:00:14.3: Adding to iommu group 12
touko 05 09:18:59 taavi kernel: pci 0000:00:18.0: Adding to iommu group 13
touko 05 09:18:59 taavi kernel: pci 0000:00:18.1: Adding to iommu group 13
touko 05 09:18:59 taavi kernel: pci 0000:00:18.2: Adding to iommu group 13
touko 05 09:18:59 taavi kernel: pci 0000:00:18.3: Adding to iommu group 13
touko 05 09:18:59 taavi kernel: pci 0000:00:18.4: Adding to iommu group 13
touko 05 09:18:59 taavi kernel: pci 0000:00:18.5: Adding to iommu group 13
touko 05 09:18:59 taavi kernel: pci 0000:00:18.6: Adding to iommu group 13
touko 05 09:18:59 taavi kernel: pci 0000:00:18.7: Adding to iommu group 13
touko 05 09:18:59 taavi kernel: pci 0000:01:00.0: Adding to iommu group 14
touko 05 09:18:59 taavi kernel: pci 0000:01:00.1: Adding to iommu group 14
touko 05 09:18:59 taavi kernel: pci 0000:01:00.2: Adding to iommu group 14
touko 05 09:18:59 taavi kernel: pci 0000:02:00.0: Adding to iommu group 14
touko 05 09:18:59 taavi kernel: pci 0000:02:08.0: Adding to iommu group 14
touko 05 09:18:59 taavi kernel: pci 0000:02:09.0: Adding to iommu group 14
touko 05 09:18:59 taavi kernel: pci 0000:04:00.0: Adding to iommu group 14
touko 05 09:18:59 taavi kernel: pci 0000:05:00.0: Adding to iommu group 14
touko 05 09:18:59 taavi kernel: pci 0000:06:00.0: Adding to iommu group 15
touko 05 09:18:59 taavi kernel: pci 0000:06:00.1: Adding to iommu group 15
touko 05 09:18:59 taavi kernel: pci 0000:06:00.2: Adding to iommu group 15
touko 05 09:18:59 taavi kernel: pci 0000:06:00.3: Adding to iommu group 15
touko 05 09:18:59 taavi kernel: pci 0000:07:00.0: Adding to iommu group 16
touko 05 09:18:59 taavi kernel: pci 0000:08:00.0: Adding to iommu group 17
touko 05 09:18:59 taavi kernel: pci 0000:08:00.1: Adding to iommu group 18
touko 05 09:18:59 taavi kernel: pci 0000:08:00.3: Adding to iommu group 19
touko 05 09:18:59 taavi kernel: pci 0000:08:00.4: Adding to iommu group 20
touko 05 09:18:59 taavi kernel: AMD-Vi: Extended features
(0x58f77ef22294a5a, 0x0): PPR NX GT IA PC GA_vAPIC
touko 05 09:18:59 taavi kernel: AMD-Vi: Interrupt remapping enabled
touko 05 09:18:59 taavi kernel: PCI-DMA: Using software bounce
buffering for IO (SWIOTLB)
touko 05 09:18:59 taavi kernel: software IO TLB: mapped [mem
0x00000000bbe6d000-0x00000000bfe6d000] (64MB)
touko 05 09:18:59 taavi kernel: LVT offset 0 assigned for vector 0x400
touko 05 09:18:59 taavi kernel: perf: AMD IBS detected (0x000003ff)
touko 05 09:18:59 taavi kernel: amd_uncore: 4 amd_df counters detected
touko 05 09:18:59 taavi kernel: amd_uncore: 6 amd_l3 counters detected
touko 05 09:18:59 taavi kernel: perf/amd_iommu: Detected AMD IOMMU #0
(2 banks, 4 counters/bank).
touko 05 09:18:59 taavi kernel: Initialise system trusted keyrings
touko 05 09:18:59 taavi kernel: Key type blacklist registered
touko 05 09:18:59 taavi kernel: workingset: timestamp_bits=3D36
max_order=3D23 bucket_order=3D0
touko 05 09:18:59 taavi kernel: zbud: loaded
touko 05 09:18:59 taavi kernel: fuse: init (API version 7.42)
touko 05 09:18:59 taavi kernel: integrity: Platform Keyring initialized
touko 05 09:18:59 taavi kernel: integrity: Machine keyring initialized
touko 05 09:18:59 taavi kernel: Key type asymmetric registered
touko 05 09:18:59 taavi kernel: Asymmetric key parser 'x509' registered
touko 05 09:18:59 taavi kernel: Freeing initrd memory: 127612K
touko 05 09:18:59 taavi kernel: Block layer SCSI generic (bsg) driver
version 0.4 loaded (major 246)
touko 05 09:18:59 taavi kernel: io scheduler mq-deadline registered
touko 05 09:18:59 taavi kernel: ledtrig-cpu: registered to indicate
activity on CPUs
touko 05 09:18:59 taavi kernel: pcieport 0000:00:07.1: AER: enabled with IR=
Q 29
touko 05 09:18:59 taavi kernel: pcieport 0000:00:08.1: AER: enabled with IR=
Q 30
touko 05 09:18:59 taavi kernel: shpchp: Standard Hot Plug PCI
Controller Driver version: 0.4
touko 05 09:18:59 taavi kernel: Monitor-Mwait will be used to enter C-1 sta=
te
touko 05 09:18:59 taavi kernel: Estimated ratio of average max
frequency by base frequency (times 1024): 1141
touko 05 09:18:59 taavi kernel: Serial: 8250/16550 driver, 4 ports,
IRQ sharing enabled
touko 05 09:18:59 taavi kernel: serial8250: ttyS0 at I/O 0x3f8 (irq =3D
4, base_baud =3D 115200) is a 16550A
touko 05 09:18:59 taavi kernel: Linux agpgart interface v0.103
touko 05 09:18:59 taavi kernel: tpm_crb MSFT0101:00: Disabling hwrng
touko 05 09:18:59 taavi kernel: i8042: PNP: No PS/2 controller found.
touko 05 09:18:59 taavi kernel: mousedev: PS/2 mouse device common for all =
mice
touko 05 09:18:59 taavi kernel: rtc_cmos 00:02: RTC can wake from S4
touko 05 09:18:59 taavi kernel: rtc_cmos 00:02: registered as rtc0
touko 05 09:18:59 taavi kernel: rtc_cmos 00:02: setting system clock
to 2025-05-05T06:17:06 UTC (1746425826)
touko 05 09:18:59 taavi kernel: rtc_cmos 00:02: alarms up to one
month, y3k, 114 bytes nvram
touko 05 09:18:59 taavi kernel: Relocating firmware framebuffer to
offset 0x0000000001000000[d] within [mem 0xe0000000-0xe1ffffff flags
0x14220c]
touko 05 09:18:59 taavi kernel: efifb: probing for efifb
touko 05 09:18:59 taavi kernel: efifb: framebuffer at 0xe1000000,
using 8100k, total 8100k
touko 05 09:18:59 taavi kernel: efifb: mode is 1920x1080x32,
linelength=3D7680, pages=3D1
touko 05 09:18:59 taavi kernel: efifb: scrolling: redraw
touko 05 09:18:59 taavi kernel: efifb: Truecolor: size=3D8:8:8:8, shift=3D2=
4:16:8:0
touko 05 09:18:59 taavi kernel: Console: switching to colour frame
buffer device 240x67
touko 05 09:18:59 taavi kernel: fb0: EFI VGA frame buffer device
touko 05 09:18:59 taavi kernel: NET: Registered PF_INET6 protocol family
touko 05 09:18:59 taavi kernel: Segment Routing with IPv6
touko 05 09:18:59 taavi kernel: In-situ OAM (IOAM) with IPv6
touko 05 09:18:59 taavi kernel: mip6: Mobile IPv6
touko 05 09:18:59 taavi kernel: NET: Registered PF_PACKET protocol family
touko 05 09:18:59 taavi kernel: mpls_gso: MPLS GSO support
touko 05 09:18:59 taavi kernel: microcode: Current revision: 0x08701034
touko 05 09:18:59 taavi kernel: microcode: Updated early from: 0x08701034
touko 05 09:18:59 taavi kernel: resctrl: L3 allocation detected
touko 05 09:18:59 taavi kernel: resctrl: MB allocation detected
touko 05 09:18:59 taavi kernel: resctrl: L3 monitoring detected
touko 05 09:18:59 taavi kernel: IPI shorthand broadcast: enabled
touko 05 09:18:59 taavi kernel: sched_clock: Marking stable
(1160003545, 316474640)->(1722689555, -246211370)
touko 05 09:18:59 taavi kernel: registered taskstats version 1
touko 05 09:18:59 taavi kernel: Loading compiled-in X.509 certificates
touko 05 09:18:59 taavi kernel: Loaded X.509 cert 'Build time
autogenerated kernel key: XXXXXXXXXXXXXX'
touko 05 09:18:59 taavi kernel: Demotion targets for Node 0: null
touko 05 09:18:59 taavi kernel: Key type .fscrypt registered
touko 05 09:18:59 taavi kernel: Key type fscrypt-provisioning registered
touko 05 09:18:59 taavi kernel: Key type encrypted registered
touko 05 09:18:59 taavi kernel: AppArmor: AppArmor sha256 policy hashing en=
abled
touko 05 09:18:59 taavi kernel: integrity: Loading X.509 certificate: UEFI:=
db
touko 05 09:18:59 taavi kernel: integrity: Loaded X.509 cert 'ASUSTeK
MotherBoard SW Key Certificate: da83b990422ebc8c441f8d8b039a65a2'
touko 05 09:18:59 taavi kernel: integrity: Loading X.509 certificate: UEFI:=
db
touko 05 09:18:59 taavi kernel: integrity: Loaded X.509 cert 'ASUSTeK
Notebook SW Key Certificate: b8e581e4df77a5bb4282d5ccfc00c071'
touko 05 09:18:59 taavi kernel: integrity: Loading X.509 certificate: UEFI:=
db
touko 05 09:18:59 taavi kernel: integrity: Loaded X.509 cert
'Microsoft Corporation UEFI CA 2011:
13adbf4309bd82709c8cd54f316ed522988a1bd4'
touko 05 09:18:59 taavi kernel: integrity: Loading X.509 certificate: UEFI:=
db
touko 05 09:18:59 taavi kernel: integrity: Loaded X.509 cert
'Microsoft Windows Production PCA 2011:
a92902398e16c49778cd90f99e4f9ae17c55af53'
touko 05 09:18:59 taavi kernel: integrity: Loading X.509 certificate: UEFI:=
db
touko 05 09:18:59 taavi kernel: integrity: Loaded X.509 cert
'Canonical Ltd. Master Certificate Authority:
ad91990bc22ab1f517048c23b6655a268e345a63'
touko 05 09:18:59 taavi kernel: ima: Allocated hash algorithm: sha256
touko 05 09:18:59 taavi kernel: ima: No architecture policies found
touko 05 09:18:59 taavi kernel: evm: Initialising EVM extended attributes:
touko 05 09:18:59 taavi kernel: evm: security.selinux
touko 05 09:18:59 taavi kernel: evm: security.SMACK64 (disabled)
touko 05 09:18:59 taavi kernel: evm: security.SMACK64EXEC (disabled)
touko 05 09:18:59 taavi kernel: evm: security.SMACK64TRANSMUTE (disabled)
touko 05 09:18:59 taavi kernel: evm: security.SMACK64MMAP (disabled)
touko 05 09:18:59 taavi kernel: evm: security.apparmor
touko 05 09:18:59 taavi kernel: evm: security.ima
touko 05 09:18:59 taavi kernel: evm: security.capability
touko 05 09:18:59 taavi kernel: evm: HMAC attrs: 0x1
touko 05 09:18:59 taavi kernel: RAS: Correctable Errors collector initializ=
ed.
touko 05 09:18:59 taavi kernel: Lockdown: swapper/0: hibernation is
restricted; see man kernel_lockdown.7
touko 05 09:18:59 taavi kernel: clk: Disabling unused clocks
touko 05 09:18:59 taavi kernel: PM: genpd: Disabling unused power domains
touko 05 09:18:59 taavi kernel: Freeing unused decrypted memory: 2028K
touko 05 09:18:59 taavi kernel: Freeing unused kernel image (initmem)
memory: 4200K
touko 05 09:18:59 taavi kernel: Write protecting the kernel read-only
data: 28672k
touko 05 09:18:59 taavi kernel: Freeing unused kernel image
(text/rodata gap) memory: 876K
touko 05 09:18:59 taavi kernel: Freeing unused kernel image
(rodata/data gap) memory: 360K
touko 05 09:18:59 taavi kernel: x86/mm: Checked W+X mappings: passed,
no W+X pages found.
touko 05 09:18:59 taavi kernel: Run /init as init process
touko 05 09:18:59 taavi kernel:   with arguments:
touko 05 09:18:59 taavi kernel:     /init
touko 05 09:18:59 taavi kernel:     splash
touko 05 09:18:59 taavi kernel:   with environment:
touko 05 09:18:59 taavi kernel:     HOME=3D/
touko 05 09:18:59 taavi kernel:     TERM=3Dlinux
touko 05 09:18:59 taavi kernel:     BOOT_IMAGE=3D/boot/vmlinuz-6.14.5
touko 05 09:18:59 taavi kernel: tsc: Refined TSC clocksource
calibration: 3792.873 MHz
touko 05 09:18:59 taavi kernel: clocksource: tsc: mask:
0xffffffffffffffff max_cycles: 0x6d5818a734c, max_idle_ns:
881590694765 ns
touko 05 09:18:59 taavi kernel: clocksource: Switched to clocksource tsc
touko 05 09:18:59 taavi kernel: input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
touko 05 09:18:59 taavi kernel: ACPI: button: Power Button [PWRB]
touko 05 09:18:59 taavi kernel: input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
touko 05 09:18:59 taavi kernel: ACPI: button: Power Button [PWRF]
touko 05 09:18:59 taavi kernel: piix4_smbus 0000:00:14.0: SMBus Host
Controller at 0xb00, revision 0
touko 05 09:18:59 taavi kernel: piix4_smbus 0000:00:14.0: Using
register 0x02 for SMBus port selection
touko 05 09:18:59 taavi kernel: i2c i2c-1: Successfully instantiated SPD at=
 0x52
touko 05 09:18:59 taavi kernel: i2c i2c-1: Successfully instantiated SPD at=
 0x53
touko 05 09:18:59 taavi kernel: piix4_smbus 0000:00:14.0: Auxiliary
SMBus Host Controller at 0xb20
touko 05 09:18:59 taavi kernel: Intel(R) 2.5G Ethernet Linux Driver
touko 05 09:18:59 taavi kernel: Copyright(c) 2018 Intel Corporation.
touko 05 09:18:59 taavi kernel: igc 0000:05:00.0: PCIe PTM not
supported by PCIe bus/controller
touko 05 09:18:59 taavi kernel: SCSI subsystem initialized
touko 05 09:18:59 taavi kernel: sp5100_tco: SP5100/SB800 TCO WatchDog
Timer Driver
touko 05 09:18:59 taavi kernel: sp5100-tco sp5100-tco: Using
0xfeb00000 for watchdog MMIO address
touko 05 09:18:59 taavi kernel: sp5100-tco sp5100-tco: initialized.
heartbeat=3D60 sec (nowayout=3D0)
touko 05 09:18:59 taavi kernel: ACPI: bus type USB registered
touko 05 09:18:59 taavi kernel: usbcore: registered new interface driver us=
bfs
touko 05 09:18:59 taavi kernel: usbcore: registered new interface driver hu=
b
touko 05 09:18:59 taavi kernel: usbcore: registered new device driver usb
touko 05 09:18:59 taavi kernel: libata version 3.00 loaded.
touko 05 09:18:59 taavi kernel: xhci_hcd 0000:01:00.0: xHCI Host Controller
touko 05 09:18:59 taavi kernel: xhci_hcd 0000:01:00.0: new USB bus
registered, assigned bus number 1
touko 05 09:18:59 taavi kernel: ahci 0000:01:00.1: version 3.0
touko 05 09:18:59 taavi kernel: ahci 0000:01:00.1: SSS flag set,
parallel bus scan disabled
touko 05 09:18:59 taavi kernel: ahci 0000:01:00.1: AHCI vers
0001.0301, 32 command slots, 6 Gbps, SATA mode
touko 05 09:18:59 taavi kernel: ahci 0000:01:00.1: 6/6 ports
implemented (port mask 0x3f)
touko 05 09:18:59 taavi kernel: ahci 0000:01:00.1: flags: 64bit ncq
sntf stag pm led clo only pmp pio slum part sxs deso sadm sds apst
touko 05 09:18:59 taavi kernel: scsi host0: ahci
touko 05 09:18:59 taavi kernel: scsi host1: ahci
touko 05 09:18:59 taavi kernel: scsi host2: ahci
touko 05 09:18:59 taavi kernel: scsi host3: ahci
touko 05 09:18:59 taavi kernel: scsi host4: ahci
touko 05 09:18:59 taavi kernel: scsi host5: ahci
touko 05 09:18:59 taavi kernel: ata1: SATA max UDMA/133 abar
m131072@0xfc580000 port 0xfc580100 irq 42 lpm-pol 3
touko 05 09:18:59 taavi kernel: ata2: SATA max UDMA/133 abar
m131072@0xfc580000 port 0xfc580180 irq 42 lpm-pol 3
touko 05 09:18:59 taavi kernel: ata3: SATA max UDMA/133 abar
m131072@0xfc580000 port 0xfc580200 irq 42 lpm-pol 3
touko 05 09:18:59 taavi kernel: ata4: SATA max UDMA/133 abar
m131072@0xfc580000 port 0xfc580280 irq 42 lpm-pol 3
touko 05 09:18:59 taavi kernel: ata5: SATA max UDMA/133 abar
m131072@0xfc580000 port 0xfc580300 irq 42 lpm-pol 3
touko 05 09:18:59 taavi kernel: ata6: SATA max UDMA/133 abar
m131072@0xfc580000 port 0xfc580380 irq 42 lpm-pol 3
touko 05 09:18:59 taavi kernel: igc 0000:05:00.0 (unnamed net_device)
(uninitialized): PHC added
touko 05 09:18:59 taavi kernel: igc 0000:05:00.0: 4.000 Gb/s available
PCIe bandwidth (5.0 GT/s PCIe x1 link)
touko 05 09:18:59 taavi kernel: igc 0000:05:00.0 eth0: MAC: d4:5d:64:d7:c3:=
fe
touko 05 09:18:59 taavi kernel: xhci_hcd 0000:01:00.0: hcc params
0x0200ef81 hci version 0x110 quirks 0x0000000000000010
touko 05 09:18:59 taavi kernel: xhci_hcd 0000:01:00.0: xHCI Host Controller
touko 05 09:18:59 taavi kernel: xhci_hcd 0000:01:00.0: new USB bus
registered, assigned bus number 2
touko 05 09:18:59 taavi kernel: xhci_hcd 0000:01:00.0: Host supports
USB 3.1 Enhanced SuperSpeed
touko 05 09:18:59 taavi kernel: usb usb1: New USB device found,
idVendor=3D1d6b, idProduct=3D0002, bcdDevice=3D 6.14
touko 05 09:18:59 taavi kernel: usb usb1: New USB device strings:
Mfr=3D3, Product=3D2, SerialNumber=3D1
touko 05 09:18:59 taavi kernel: usb usb1: Product: xHCI Host Controller
touko 05 09:18:59 taavi kernel: usb usb1: Manufacturer: Linux 6.14.5 xhci-h=
cd
touko 05 09:18:59 taavi kernel: usb usb1: SerialNumber: 0000:01:00.0
touko 05 09:18:59 taavi kernel: hub 1-0:1.0: USB hub found
touko 05 09:18:59 taavi kernel: hub 1-0:1.0: 10 ports detected
touko 05 09:18:59 taavi kernel: usb usb2: We don't know the algorithms
for LPM for this host, disabling LPM.
touko 05 09:18:59 taavi kernel: usb usb2: New USB device found,
idVendor=3D1d6b, idProduct=3D0003, bcdDevice=3D 6.14
touko 05 09:18:59 taavi kernel: usb usb2: New USB device strings:
Mfr=3D3, Product=3D2, SerialNumber=3D1
touko 05 09:18:59 taavi kernel: usb usb2: Product: xHCI Host Controller
touko 05 09:18:59 taavi kernel: usb usb2: Manufacturer: Linux 6.14.5 xhci-h=
cd
touko 05 09:18:59 taavi kernel: usb usb2: SerialNumber: 0000:01:00.0
touko 05 09:18:59 taavi kernel: hub 2-0:1.0: USB hub found
touko 05 09:18:59 taavi kernel: hub 2-0:1.0: 4 ports detected
touko 05 09:18:59 taavi kernel: xhci_hcd 0000:06:00.2: xHCI Host Controller
touko 05 09:18:59 taavi kernel: xhci_hcd 0000:06:00.2: new USB bus
registered, assigned bus number 3
touko 05 09:18:59 taavi kernel: xhci_hcd 0000:06:00.2: hcc params
0x0180ff05 hci version 0x110 quirks 0x0000000000000010
touko 05 09:18:59 taavi kernel: xhci_hcd 0000:06:00.2: xHCI Host Controller
touko 05 09:18:59 taavi kernel: xhci_hcd 0000:06:00.2: new USB bus
registered, assigned bus number 4
touko 05 09:18:59 taavi kernel: xhci_hcd 0000:06:00.2: Host supports
USB 3.1 Enhanced SuperSpeed
touko 05 09:18:59 taavi kernel: usb usb3: New USB device found,
idVendor=3D1d6b, idProduct=3D0002, bcdDevice=3D 6.14
touko 05 09:18:59 taavi kernel: usb usb3: New USB device strings:
Mfr=3D3, Product=3D2, SerialNumber=3D1
touko 05 09:18:59 taavi kernel: usb usb3: Product: xHCI Host Controller
touko 05 09:18:59 taavi kernel: usb usb3: Manufacturer: Linux 6.14.5 xhci-h=
cd
touko 05 09:18:59 taavi kernel: usb usb3: SerialNumber: 0000:06:00.2
touko 05 09:18:59 taavi kernel: hub 3-0:1.0: USB hub found
touko 05 09:18:59 taavi kernel: hub 3-0:1.0: 2 ports detected
touko 05 09:18:59 taavi kernel: usb usb4: We don't know the algorithms
for LPM for this host, disabling LPM.
touko 05 09:19:00 taavi kernel: usb usb4: New USB device found,
idVendor=3D1d6b, idProduct=3D0003, bcdDevice=3D 6.14
touko 05 09:19:00 taavi kernel: usb usb4: New USB device strings:
Mfr=3D3, Product=3D2, SerialNumber=3D1
touko 05 09:19:00 taavi kernel: usb usb4: Product: xHCI Host Controller
touko 05 09:19:00 taavi kernel: usb usb4: Manufacturer: Linux 6.14.5 xhci-h=
cd
touko 05 09:19:00 taavi kernel: usb usb4: SerialNumber: 0000:06:00.2
touko 05 09:19:00 taavi kernel: hub 4-0:1.0: USB hub found
touko 05 09:19:00 taavi kernel: hub 4-0:1.0: 4 ports detected
touko 05 09:19:00 taavi kernel: xhci_hcd 0000:08:00.3: xHCI Host Controller
touko 05 09:19:00 taavi kernel: xhci_hcd 0000:08:00.3: new USB bus
registered, assigned bus number 5
touko 05 09:19:00 taavi kernel: xhci_hcd 0000:08:00.3: hcc params
0x0278ffe5 hci version 0x110 quirks 0x0000000000000010
touko 05 09:19:00 taavi kernel: xhci_hcd 0000:08:00.3: xHCI Host Controller
touko 05 09:19:00 taavi kernel: xhci_hcd 0000:08:00.3: new USB bus
registered, assigned bus number 6
touko 05 09:19:00 taavi kernel: xhci_hcd 0000:08:00.3: Host supports
USB 3.1 Enhanced SuperSpeed
touko 05 09:19:00 taavi kernel: usb usb5: New USB device found,
idVendor=3D1d6b, idProduct=3D0002, bcdDevice=3D 6.14
touko 05 09:19:00 taavi kernel: usb usb5: New USB device strings:
Mfr=3D3, Product=3D2, SerialNumber=3D1
touko 05 09:19:00 taavi kernel: usb usb5: Product: xHCI Host Controller
touko 05 09:19:00 taavi kernel: usb usb5: Manufacturer: Linux 6.14.5 xhci-h=
cd
touko 05 09:19:00 taavi kernel: usb usb5: SerialNumber: 0000:08:00.3
touko 05 09:19:00 taavi kernel: hub 5-0:1.0: USB hub found
touko 05 09:19:00 taavi kernel: hub 5-0:1.0: 4 ports detected
touko 05 09:19:00 taavi kernel: usb usb6: We don't know the algorithms
for LPM for this host, disabling LPM.
touko 05 09:19:00 taavi kernel: usb usb6: New USB device found,
idVendor=3D1d6b, idProduct=3D0003, bcdDevice=3D 6.14
touko 05 09:19:00 taavi kernel: usb usb6: New USB device strings:
Mfr=3D3, Product=3D2, SerialNumber=3D1
touko 05 09:19:00 taavi kernel: usb usb6: Product: xHCI Host Controller
touko 05 09:19:00 taavi kernel: usb usb6: Manufacturer: Linux 6.14.5 xhci-h=
cd
touko 05 09:19:00 taavi kernel: usb usb6: SerialNumber: 0000:08:00.3
touko 05 09:19:00 taavi kernel: hub 6-0:1.0: USB hub found
touko 05 09:19:00 taavi kernel: hub 6-0:1.0: 4 ports detected
touko 05 09:19:00 taavi kernel: ata1: SATA link down (SStatus 0 SControl 33=
0)
touko 05 09:19:00 taavi kernel: usb 5-4: new high-speed USB device
number 2 using xhci_hcd
touko 05 09:19:00 taavi kernel: usb 1-5: new full-speed USB device
number 2 using xhci_hcd
touko 05 09:19:00 taavi kernel: usb 5-4: New USB device found,
idVendor=3D05e3, idProduct=3D0608, bcdDevice=3D77.63
touko 05 09:19:00 taavi kernel: usb 5-4: New USB device strings:
Mfr=3D0, Product=3D1, SerialNumber=3D0
touko 05 09:19:00 taavi kernel: usb 5-4: Product: USB2.0 Hub
touko 05 09:19:00 taavi kernel: hub 5-4:1.0: USB hub found
touko 05 09:19:00 taavi kernel: hub 5-4:1.0: 4 ports detected
touko 05 09:19:00 taavi kernel: ata2: SATA link down (SStatus 0 SControl 33=
0)
touko 05 09:19:00 taavi kernel: usb 1-5: New USB device found,
idVendor=3D8087, idProduct=3D0029, bcdDevice=3D 0.01
touko 05 09:19:00 taavi kernel: usb 1-5: New USB device strings:
Mfr=3D0, Product=3D0, SerialNumber=3D0
touko 05 09:19:00 taavi kernel: usb 5-4.4: new full-speed USB device
number 3 using xhci_hcd
touko 05 09:19:00 taavi kernel: usb 5-4.4: New USB device found,
idVendor=3D046d, idProduct=3Dc52b, bcdDevice=3D12.10
touko 05 09:19:00 taavi kernel: usb 5-4.4: New USB device strings:
Mfr=3D1, Product=3D2, SerialNumber=3D0
touko 05 09:19:00 taavi kernel: usb 5-4.4: Product: USB Receiver
touko 05 09:19:00 taavi kernel: usb 5-4.4: Manufacturer: Logitech
touko 05 09:19:00 taavi kernel: usb 1-6: new full-speed USB device
number 3 using xhci_hcd
touko 05 09:19:00 taavi kernel: ata3: SATA link up 6.0 Gbps (SStatus
133 SControl 300)
touko 05 09:19:00 taavi kernel: ata3.00: ATA-8: WDC WD5000AAKX-001CA0,
15.01H15, max UDMA/133
touko 05 09:19:00 taavi kernel: ata3.00: 976773168 sectors, multi 16:
LBA48 NCQ (depth 32), AA
touko 05 09:19:00 taavi kernel: ata3.00: configured for UDMA/133
touko 05 09:19:00 taavi kernel: scsi 2:0:0:0: Direct-Access     ATA
  WDC WD5000AAKX-0 1H15 PQ: 0 ANSI: 5
touko 05 09:19:00 taavi kernel: usb 1-6: config 1 has an invalid
interface number: 2 but max is 1
touko 05 09:19:00 taavi kernel: usb 1-6: config 1 has no interface number 1
touko 05 09:19:00 taavi kernel: usb 1-6: New USB device found,
idVendor=3D0b05, idProduct=3D1939, bcdDevice=3D 1.00
touko 05 09:19:00 taavi kernel: usb 1-6: New USB device strings:
Mfr=3D1, Product=3D2, SerialNumber=3D3
touko 05 09:19:00 taavi kernel: usb 1-6: Product: AURA LED Controller
touko 05 09:19:00 taavi kernel: usb 1-6: Manufacturer: AsusTek Computer Inc=
.
touko 05 09:19:00 taavi kernel: usb 1-6: SerialNumber: XXXXXXXXX
touko 05 09:19:00 taavi kernel: usb 1-7: new high-speed USB device
number 4 using xhci_hcd
touko 05 09:19:00 taavi kernel: ata4: SATA link up 1.5 Gbps (SStatus
113 SControl 300)
touko 05 09:19:00 taavi kernel: ata4.00: ATAPI: TSSTcorp CDDVDW
SH-S223F, SB03, max UDMA/100
touko 05 09:19:00 taavi kernel: ata4.00: configured for UDMA/100
touko 05 09:19:00 taavi kernel: scsi 3:0:0:0: CD-ROM
TSSTcorp CDDVDW SH-S223F  SB03 PQ: 0 ANSI: 5
touko 05 09:19:00 taavi kernel: usb 1-7: New USB device found,
idVendor=3D05e3, idProduct=3D0610, bcdDevice=3D60.60
touko 05 09:19:00 taavi kernel: usb 1-7: New USB device strings:
Mfr=3D0, Product=3D1, SerialNumber=3D0
touko 05 09:19:00 taavi kernel: usb 1-7: Product: USB2.0 Hub
touko 05 09:19:00 taavi kernel: hub 1-7:1.0: USB hub found
touko 05 09:19:00 taavi kernel: hub 1-7:1.0: 4 ports detected
touko 05 09:19:00 taavi kernel: ata5: SATA link up 6.0 Gbps (SStatus
133 SControl 300)
touko 05 09:19:00 taavi kernel: ata5.00: ATA-10: WDC WD20EFAX-68FB5N0,
82.00A82, max UDMA/133
touko 05 09:19:00 taavi kernel: ata5.00: 3907029168 sectors, multi 16:
LBA48 NCQ (depth 32), AA
touko 05 09:19:00 taavi kernel: ata5.00: Features: NCQ-prio
touko 05 09:19:00 taavi kernel: ata5.00: configured for UDMA/133
touko 05 09:19:00 taavi kernel: scsi 4:0:0:0: Direct-Access     ATA
  WDC WD20EFAX-68F 0A82 PQ: 0 ANSI: 5
touko 05 09:19:00 taavi kernel: ata6: SATA link up 6.0 Gbps (SStatus
133 SControl 300)
touko 05 09:19:00 taavi kernel: ata6.00: ATA-10: WDC WD20EFAX-68FB5N0,
82.00A82, max UDMA/133
touko 05 09:19:00 taavi kernel: ata6.00: 3907029168 sectors, multi 16:
LBA48 NCQ (depth 32), AA
touko 05 09:19:00 taavi kernel: ata6.00: Features: NCQ-prio
touko 05 09:19:00 taavi kernel: ata6.00: configured for UDMA/133
touko 05 09:19:00 taavi kernel: scsi 5:0:0:0: Direct-Access     ATA
  WDC WD20EFAX-68F 0A82 PQ: 0 ANSI: 5
touko 05 09:19:00 taavi kernel: igc 0000:05:00.0 enp5s0: renamed from eth0
touko 05 09:19:00 taavi kernel: sd 2:0:0:0: [sda] 976773168 512-byte
logical blocks: (500 GB/466 GiB)
touko 05 09:19:00 taavi kernel: sd 4:0:0:0: [sdb] 3907029168 512-byte
logical blocks: (2.00 TB/1.82 TiB)
touko 05 09:19:00 taavi kernel: sd 5:0:0:0: [sdc] 3907029168 512-byte
logical blocks: (2.00 TB/1.82 TiB)
touko 05 09:19:00 taavi kernel: sd 4:0:0:0: [sdb] 4096-byte physical blocks
touko 05 09:19:00 taavi kernel: sd 5:0:0:0: [sdc] 4096-byte physical blocks
touko 05 09:19:00 taavi kernel: sd 5:0:0:0: [sdc] Write Protect is off
touko 05 09:19:00 taavi kernel: sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
touko 05 09:19:00 taavi kernel: sd 5:0:0:0: [sdc] Write cache:
enabled, read cache: enabled, doesn't support DPO or FUA
touko 05 09:19:00 taavi kernel: sd 5:0:0:0: [sdc] Preferred minimum
I/O size 4096 bytes
touko 05 09:19:00 taavi kernel: sd 2:0:0:0: [sda] Write Protect is off
touko 05 09:19:00 taavi kernel: sd 4:0:0:0: [sdb] Write Protect is off
touko 05 09:19:00 taavi kernel: sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
touko 05 09:19:00 taavi kernel: sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
touko 05 09:19:00 taavi kernel: sd 2:0:0:0: [sda] Write cache:
enabled, read cache: enabled, doesn't support DPO or FUA
touko 05 09:19:00 taavi kernel: sd 4:0:0:0: [sdb] Write cache:
enabled, read cache: enabled, doesn't support DPO or FUA
touko 05 09:19:00 taavi kernel: sd 2:0:0:0: [sda] Preferred minimum
I/O size 512 bytes
touko 05 09:19:00 taavi kernel: sd 4:0:0:0: [sdb] Preferred minimum
I/O size 4096 bytes
touko 05 09:19:00 taavi kernel: hid: raw HID events driver (C) Jiri Kosina
touko 05 09:19:00 taavi kernel:  sda: sda1 sda2 sda3 sda4
touko 05 09:19:00 taavi kernel: sd 2:0:0:0: [sda] Attached SCSI disk
touko 05 09:19:00 taavi kernel: sr 3:0:0:0: [sr0] scsi3-mmc drive:
48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
touko 05 09:19:00 taavi kernel: cdrom: Uniform CD-ROM driver Revision: 3.20
touko 05 09:19:00 taavi kernel: sr 3:0:0:0: Attached scsi CD-ROM sr0
touko 05 09:19:00 taavi kernel:  sdc: sdc1 sdc2 sdc3 sdc4
touko 05 09:19:00 taavi kernel: sd 5:0:0:0: [sdc] Attached SCSI disk
touko 05 09:19:00 taavi kernel:  sdb: sdb1 sdb2 sdb3 sdb4
touko 05 09:19:00 taavi kernel: sd 4:0:0:0: [sdb] Attached SCSI disk
touko 05 09:19:00 taavi kernel: usbcore: registered new interface driver us=
bhid
touko 05 09:19:00 taavi kernel: usbhid: USB HID core driver
touko 05 09:19:00 taavi kernel: input: Logitech USB Receiver as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.0/0003=
:046D:C52B.0001/input/input2
touko 05 09:19:00 taavi kernel: hid-generic 0003:046D:C52B.0001:
input,hidraw0: USB HID v1.11 Keyboard [Logitech USB Receiver] on
usb-0000:08:00.3-4.4/input0
touko 05 09:19:00 taavi kernel: input: Logitech USB Receiver Mouse as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.1/0003=
:046D:C52B.0002/input/input3
touko 05 09:19:00 taavi kernel: input: Logitech USB Receiver Consumer
Control as /devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4=
.4:1.1/0003:046D:C52B.0002/input/input4
touko 05 09:19:00 taavi kernel: input: Logitech USB Receiver System
Control as /devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4=
.4:1.1/0003:046D:C52B.0002/input/input5
touko 05 09:19:00 taavi kernel: hid-generic 0003:046D:C52B.0002:
input,hiddev0,hidraw1: USB HID v1.11 Mouse [Logitech USB Receiver] on
usb-0000:08:00.3-4.4/input1
touko 05 09:19:00 taavi kernel: hid-generic 0003:046D:C52B.0003:
hiddev1,hidraw2: USB HID v1.11 Device [Logitech USB Receiver] on
usb-0000:08:00.3-4.4/input2
touko 05 09:19:00 taavi kernel: hid-generic 0003:0B05:1939.0004:
hiddev2,hidraw3: USB HID v1.11 Device [AsusTek Computer Inc. AURA LED
Controller] on usb-0000:01:00.0-6/input2
touko 05 09:19:00 taavi kernel: logitech-djreceiver
0003:046D:C52B.0003: hiddev0,hidraw0: USB HID v1.11 Device [Logitech
USB Receiver] on usb-0000:08:00.3-4.4/input2
touko 05 09:19:00 taavi kernel: md/raid1:md0: active with 2 out of 2 mirror=
s
touko 05 09:19:00 taavi kernel: md0: detected capacity change from 0 to 390=
26688
touko 05 09:19:00 taavi kernel: input: Logitech Wireless Device
PID:4050 Keyboard as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.2/0003=
:046D:C52B.0003/0003:046D:4050.0005/input/input7
touko 05 09:19:00 taavi kernel: input: Logitech Wireless Device
PID:4050 Mouse as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.2/0003=
:046D:C52B.0003/0003:046D:4050.0005/input/input8
touko 05 09:19:00 taavi kernel: hid-generic 0003:046D:4050.0005:
input,hidraw1: USB HID v1.11 Keyboard [Logitech Wireless Device
PID:4050] on usb-0000:08:00.3-4.4/input2:1
touko 05 09:19:00 taavi kernel: md/raid1:md1: active with 2 out of 2 mirror=
s
touko 05 09:19:00 taavi kernel: md1: detected capacity change from 0
to 195178496
touko 05 09:19:00 taavi kernel: input: Logitech K270 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.2/0003=
:046D:C52B.0003/0003:046D:4003.0006/input/input12
touko 05 09:19:00 taavi kernel: md/raid1:md2: active with 2 out of 2 mirror=
s
touko 05 09:19:00 taavi kernel: md2: detected capacity change from 0
to 3671392256
touko 05 09:19:00 taavi kernel: input: Logitech M335 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.2/0003=
:046D:C52B.0003/0003:046D:4050.0005/input/input13
touko 05 09:19:00 taavi kernel: logitech-hidpp-device
0003:046D:4003.0006: input,hidraw1: USB HID v1.11 Keyboard [Logitech
K270] on usb-0000:08:00.3-4.4/input2:2
touko 05 09:19:00 taavi kernel: logitech-hidpp-device
0003:046D:4050.0005: input,hidraw2: USB HID v1.11 Keyboard [Logitech
M335] on usb-0000:08:00.3-4.4/input2:1
touko 05 09:19:00 taavi kernel: raid6: avx2x4   gen() 33666 MB/s
touko 05 09:19:00 taavi kernel: raid6: avx2x2   gen() 34696 MB/s
touko 05 09:19:00 taavi kernel: raid6: avx2x1   gen() 29224 MB/s
touko 05 09:19:00 taavi kernel: raid6: using algorithm avx2x2 gen() 34696 M=
B/s
touko 05 09:19:00 taavi kernel: raid6: .... xor() 24771 MB/s, rmw enabled
touko 05 09:19:00 taavi kernel: raid6: using avx2x2 recovery algorithm
touko 05 09:19:00 taavi kernel: xor: automatically using best
checksumming function   avx
touko 05 09:19:00 taavi kernel: async_tx: api initialized (async)
touko 05 09:19:00 taavi kernel: logitech-hidpp-device
0003:046D:4003.0006: HID++ 2.0 device connected.
touko 05 09:19:00 taavi kernel: ata6: SATA link up 6.0 Gbps (SStatus
133 SControl 300)
touko 05 09:19:00 taavi kernel: ata5: SATA link up 6.0 Gbps (SStatus
133 SControl 300)
touko 05 09:19:00 taavi kernel: ata5.00: configured for UDMA/133
touko 05 09:19:00 taavi kernel: ata6.00: configured for UDMA/133
touko 05 09:19:00 taavi kernel: logitech-hidpp-device
0003:046D:4050.0005: HID++ 4.5 device connected.
touko 05 09:19:00 taavi kernel: EXT4-fs (md1): mounted filesystem
c056bf20-f617-4c4a-8d3c-28ac04ff6a3a ro with ordered data mode. Quota
mode: none.
touko 05 09:19:00 taavi kernel: ata6.00: exception Emask 0x0 SAct
0x2000 SErr 0x50000 action 0x6 frozen
touko 05 09:19:00 taavi kernel: ata6: SError: { PHYRdyChg CommWake }
touko 05 09:19:00 taavi kernel: ata6.00: failed command: READ FPDMA QUEUED
touko 05 09:19:00 taavi kernel: ata6.00: cmd
60/08:68:00:51:65/00:00:09:00:00/40 tag 13 ncq dma 4096 in
                                         res
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
touko 05 09:19:00 taavi kernel: ata6.00: status: { DRDY }
touko 05 09:19:00 taavi kernel: ata6: hard resetting link
touko 05 09:19:00 taavi kernel: ata5.00: exception Emask 0x0 SAct
0x800 SErr 0x50000 action 0x6 frozen
touko 05 09:19:00 taavi kernel: ata5: SError: { PHYRdyChg CommWake }
touko 05 09:19:00 taavi kernel: ata5.00: failed command: READ FPDMA QUEUED
touko 05 09:19:00 taavi kernel: ata5.00: cmd
60/00:58:08:51:65/01:00:09:00:00/40 tag 11 ncq dma 131072 in
                                         res
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
touko 05 09:19:00 taavi kernel: ata5.00: status: { DRDY }
touko 05 09:19:00 taavi kernel: ata5: hard resetting link
touko 05 09:19:00 taavi kernel: ata6: SATA link up 6.0 Gbps (SStatus
133 SControl 300)
touko 05 09:19:00 taavi kernel: ata5: SATA link up 6.0 Gbps (SStatus
133 SControl 300)
touko 05 09:19:00 taavi kernel: ata5.00: configured for UDMA/133
touko 05 09:19:00 taavi kernel: sd 4:0:0:0: [sdb] tag#11 FAILED
Result: hostbyte=3DDID_TIME_OUT driverbyte=3DDRIVER_OK cmd_age=3D30s
touko 05 09:19:00 taavi kernel: sd 4:0:0:0: [sdb] tag#11 CDB: Read(10)
28 00 09 65 51 08 00 01 00 00
touko 05 09:19:00 taavi kernel: I/O error, dev sdb, sector 157634824
op 0x0:(READ) flags 0x80700 phys_seg 32 prio class 0
touko 05 09:19:00 taavi kernel: md/raid1:md1: sdb3: rescheduling
sector 117440776
touko 05 09:19:00 taavi kernel: md/raid1:md1: sdb3: rescheduling
sector 117440784
touko 05 09:19:00 taavi kernel: md/raid1:md1: sdb3: rescheduling
sector 117440792
touko 05 09:19:00 taavi kernel: md/raid1:md1: sdb3: rescheduling
sector 117440800
touko 05 09:19:00 taavi kernel: md/raid1:md1: sdb3: rescheduling
sector 117440808
touko 05 09:19:00 taavi kernel: md/raid1:md1: sdb3: rescheduling
sector 117440816
touko 05 09:19:00 taavi kernel: md/raid1:md1: sdb3: rescheduling
sector 117440824
touko 05 09:19:00 taavi kernel: md/raid1:md1: sdb3: rescheduling
sector 117440832
touko 05 09:19:00 taavi kernel: md/raid1:md1: sdb3: rescheduling
sector 117440840
touko 05 09:19:00 taavi kernel: md/raid1:md1: sdb3: rescheduling
sector 117440848
touko 05 09:19:00 taavi kernel: ata5: EH complete
touko 05 09:19:00 taavi kernel: ata6.00: configured for UDMA/133
touko 05 09:19:00 taavi kernel: ata6: EH complete
touko 05 09:19:00 taavi kernel: md/raid1:md1: redirecting sector
117440776 to other mirror: sdc3
touko 05 09:19:00 taavi kernel: md/raid1:md1: redirecting sector
117440784 to other mirror: sdc3
touko 05 09:19:00 taavi kernel: md/raid1:md1: redirecting sector
117440792 to other mirror: sdc3
touko 05 09:19:00 taavi kernel: md/raid1:md1: redirecting sector
117440800 to other mirror: sdc3
touko 05 09:19:00 taavi kernel: md/raid1:md1: redirecting sector
117440808 to other mirror: sdc3
touko 05 09:19:00 taavi kernel: md/raid1:md1: redirecting sector
117440816 to other mirror: sdc3
touko 05 09:19:00 taavi kernel: md/raid1:md1: redirecting sector
117440824 to other mirror: sdc3
touko 05 09:19:00 taavi kernel: md/raid1:md1: redirecting sector
117440832 to other mirror: sdc3
touko 05 09:19:00 taavi kernel: md/raid1:md1: redirecting sector
117440840 to other mirror: sdc3
touko 05 09:19:00 taavi kernel: md/raid1:md1: redirecting sector
117440848 to other mirror: sdc3
touko 05 09:19:00 taavi kernel: md/raid1:md1: sdb3: Raid device
exceeded read_error threshold [cur 21:max 20]
touko 05 09:19:00 taavi kernel: md/raid1:md1: sdb3: Failing raid device
touko 05 09:19:00 taavi kernel: md/raid1:md1: Disk failure on sdb3,
disabling device.
                                md/raid1:md1: Operation continuing on 1 dev=
ices.
touko 05 09:19:00 taavi kernel: md/raid1:md1: sdb3: Raid device
exceeded read_error threshold [cur 22:max 20]
touko 05 09:19:00 taavi kernel: md/raid1:md1: sdb3: Failing raid device
touko 05 09:19:00 taavi kernel: md/raid1:md1: sdb3: Raid device
exceeded read_error threshold [cur 23:max 20]
....
touko 05 09:19:50 taavi kernel: ata5.00: exception Emask 0x0 SAct
0x800001 SErr 0x50000 action 0x6 frozen
touko 05 09:20:50 taavi kernel: ata5: SError: { PHYRdyChg CommWake }
touko 05 09:20:50 taavi kernel: ata5.00: failed command: READ FPDMA QUEUED
touko 05 09:20:50 taavi kernel: ata5.00: cmd
60/08:00:08:80:07/00:00:0e:00:00/40 tag 0 ncq dma 4096 in
                                         res
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
touko 05 09:20:50 taavi kernel: ata5.00: status: { DRDY }
touko 05 09:20:50 taavi kernel: ata5.00: failed command: READ FPDMA QUEUED
touko 05 09:20:50 taavi kernel: ata5.00: cmd
60/08:b8:08:40:0f/00:00:00:00:00/40 tag 23 ncq dma 4096 in
                                         res
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
touko 05 09:20:50 taavi kernel: ata5.00: status: { DRDY }
touko 05 09:20:50 taavi kernel: ata5: hard resetting link
touko 05 09:20:50 taavi kernel: ata5: SATA link up 6.0 Gbps (SStatus
133 SControl 300)
touko 05 09:20:50 taavi kernel: ata5.00: configured for UDMA/133
touko 05 09:20:50 taavi kernel: ata5: EH complete
touko 05 09:20:50 taavi kernel: ata6.00: exception Emask 0x0 SAct 0x0
SErr 0x50000 action 0x6 frozen
touko 05 09:20:50 taavi kernel: ata6: SError: { PHYRdyChg CommWake }
touko 05 09:20:50 taavi kernel: ata6.00: failed command: FLUSH CACHE EXT
touko 05 09:20:50 taavi kernel: ata6.00: cmd
ea/00:00:00:00:00/00:00:00:00:00/a0 tag 27
                                         res
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
touko 05 09:20:50 taavi kernel: ata6.00: status: { DRDY }
touko 05 09:20:50 taavi kernel: ata6: hard resetting link
touko 05 09:20:50 taavi kernel: ata6: SATA link up 6.0 Gbps (SStatus
133 SControl 300)
touko 05 09:20:50 taavi kernel: ata6.00: configured for UDMA/133
touko 05 09:20:50 taavi kernel: ata6.00: retrying FLUSH 0xea Emask 0x4
touko 05 09:20:50 taavi kernel: ata6: EH complete
touko 05 09:21:22 taavi kernel: ata5.00: NCQ disabled due to excessive erro=
rs
touko 05 09:21:58 taavi kernel: ata5.00: exception Emask 0x0 SAct
0x10000180 SErr 0x50000 action 0x6 frozen
touko 05 09:21:58 taavi kernel: ata5: SError: { PHYRdyChg CommWake }
touko 05 09:21:58 taavi kernel: ata5.00: failed command: READ FPDMA QUEUED
touko 05 09:21:58 taavi kernel: ata5.00: cmd
60/08:38:00:08:00/00:00:00:00:00/40 tag 7 ncq dma 4096 in
                                         res
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
touko 05 09:21:58 taavi kernel: ata5.00: status: { DRDY }
touko 05 09:21:58 taavi kernel: ata5.00: failed command: READ FPDMA QUEUED
touko 05 09:21:58 taavi kernel: ata5.00: cmd
60/01:40:00:88:0b/00:00:0e:00:00/40 tag 8 ncq dma 512 in
                                         res
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
touko 05 09:21:58 taavi kernel: ata5.00: status: { DRDY }
touko 05 09:21:58 taavi kernel: ata5.00: failed command: READ FPDMA QUEUED
touko 05 09:21:58 taavi kernel: ata5.00: cmd
60/01:e0:00:c8:0f/00:00:00:00:00/40 tag 28 ncq dma 512 in
                                         res
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
touko 05 09:21:58 taavi kernel: ata5.00: status: { DRDY }
touko 05 09:21:58 taavi kernel: ata5: hard resetting link
touko 05 09:21:58 taavi kernel: ata5: SATA link up 6.0 Gbps (SStatus
133 SControl 300)
touko 05 09:21:58 taavi kernel: ata5.00: configured for UDMA/133
touko 05 09:21:58 taavi kernel: sd 4:0:0:0: [sdb] tag#7 FAILED Result:
hostbyte=3DDID_TIME_OUT driverbyte=3DDRIVER_OK cmd_age=3D32s
touko 05 09:21:58 taavi kernel: sd 4:0:0:0: [sdb] tag#7 CDB: Read(10)
28 00 00 00 08 00 00 00 08 00
touko 05 09:21:58 taavi kernel: I/O error, dev sdb, sector 2048 op
0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
touko 05 09:21:58 taavi kernel: ata5: EH complete
touko 05 09:21:58 taavi kernel: ata6.00: NCQ disabled due to excessive erro=
rs
touko 05 09:21:58 taavi kernel: ata6.00: exception Emask 0x0 SAct 0x0
SErr 0x50000 action 0x6 frozen
touko 05 09:21:58 taavi kernel: ata6: SError: { PHYRdyChg CommWake }
touko 05 09:21:58 taavi kernel: ata6.00: failed command: FLUSH CACHE EXT
touko 05 09:21:58 taavi kernel: ata6.00: cmd
ea/00:00:00:00:00/00:00:00:00:00/a0 tag 14
                                         res
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
touko 05 09:21:58 taavi kernel: ata6.00: status: { DRDY }
touko 05 09:21:58 taavi kernel: ata6: hard resetting link
touko 05 09:21:58 taavi kernel: ata6: SATA link up 6.0 Gbps (SStatus
133 SControl 300)
touko 05 09:21:58 taavi kernel: ata6.00: configured for UDMA/133
touko 05 09:21:58 taavi kernel: ata6.00: retrying FLUSH 0xea Emask 0x4
touko 05 09:21:58 taavi kernel: ata6: EH complete
touko 05 09:21:58 taavi kernel: device-mapper: core:
CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will
not be recorded in the IMA log.
touko 05 09:21:58 taavi kernel: device-mapper: uevent: version 1.0.3
touko 05 09:21:58 taavi kernel: device-mapper: ioctl: 4.49.0-ioctl
(2025-01-17) initialised: dm-devel@lists.linux.dev

----------------------------------------
mjkorhon@taavi:~$ sudo hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
       Model Number:       WDC WD20EFAX-68FB5N0
       Serial Number:      XXXXXXXXXXXXX
       Firmware Revision:  82.00A82
       Transport:          Serial, SATA 1.0a, SATA II Extensions, SATA
Rev 2.5, SATA Rev 2.6, SATA Rev 3.0
Standards:
       Used: unknown (minor revision code 0x006d)
       Supported: 10 9 8 7 6 5
       Likely used: 10
Configuration:
       Logical         max     current
       cylinders       16383   0
       heads           16      0
       sectors/track   63      0
       --
       LBA    user addressable sectors:   268435455
       LBA48  user addressable sectors:  3907029168
       Logical  Sector size:                   512 bytes
       Physical Sector size:                  4096 bytes
       Logical Sector-0 offset:                  0 bytes
       device size with M =3D 1024*1024:     1907729 MBytes
       device size with M =3D 1000*1000:     2000398 MBytes (2000 GB)
       cache/buffer size  =3D unknown
       Form Factor: 3.5 inch
       Nominal Media Rotation Rate: 5400
Capabilities:
       LBA, IORDY(can be disabled)
       Queue depth: 32
       Standby timer values: spec'd by Standard, with device specific minim=
um
       R/W multiple sector transfer: Max =3D 16  Current =3D 16
       DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
            Cycle time: min=3D120ns recommended=3D120ns
       PIO: pio0 pio1 pio2 pio3 pio4
            Cycle time: no flow control=3D120ns  IORDY flow control=3D120ns
Commands/features:
       Enabled Supported:
          *    SMART feature set
               Security Mode feature set
          *    Power Management feature set
          *    Write cache
          *    Look-ahead
          *    Host Protected Area feature set
          *    WRITE_BUFFER command
          *    READ_BUFFER command
          *    NOP cmd
          *    DOWNLOAD_MICROCODE
               SET_MAX security extension
          *    48-bit Address feature set
          *    Mandatory FLUSH_CACHE
          *    FLUSH_CACHE_EXT
          *    SMART error logging
          *    SMART self-test
          *    General Purpose Logging feature set
          *    64-bit World wide name
          *    IDLE_IMMEDIATE with UNLOAD
          *    WRITE_UNCORRECTABLE_EXT command
          *    {READ,WRITE}_DMA_EXT_GPL commands
          *    Segmented DOWNLOAD_MICROCODE
          *    Gen1 signaling speed (1.5Gb/s)
          *    Gen2 signaling speed (3.0Gb/s)
          *    Gen3 signaling speed (6.0Gb/s)
          *    Native Command Queueing (NCQ)
          *    Host-initiated interface power management
          *    Phy event counters
          *    Idle-Unload when NCQ is active
          *    NCQ priority information
          *    READ_LOG_DMA_EXT equivalent to READ_LOG_EXT
          *    DMA Setup Auto-Activate optimization
               Device-initiated interface power management
          *    Software settings preservation
          *    SMART Command Transport (SCT) feature set
          *    SCT Write Same (AC2)
          *    SCT Error Recovery Control (AC3)
          *    SCT Features Control (AC4)
          *    SCT Data Tables (AC5)
               unknown 206[12] (vendor specific)
               unknown 206[13] (vendor specific)
          *    Extended number of user addressable sectors
          *    DOWNLOAD MICROCODE DMA command
          *    WRITE BUFFER DMA command
          *    READ BUFFER DMA command
          *    Data Set Management TRIM supported (limit 10 blocks)
Security:
       Master password revision code =3D 65534
               supported
       not     enabled
       not     locked
               frozen
       not     expired: security count
               supported: enhanced erase
       248min for SECURITY ERASE UNIT. 248min for ENHANCED SECURITY ERASE U=
NIT.
Logical Unit WWN Device Identifier: 50014ee267192206
       NAA             : 5
       IEEE OUI        : 0014ee
       Unique ID       : 267192206
Checksum: correct
----------------------------------------
mjkorhon@taavi:~$ sudo hdparm -I /dev/sdc

/dev/sdc:

ATA device, with non-removable media
       Model Number:       WDC WD20EFAX-68FB5N0
       Serial Number:      YYYYYYYYYYYYY
       Firmware Revision:  82.00A82
       Transport:          Serial, SATA 1.0a, SATA II Extensions, SATA
Rev 2.5, SATA Rev 2.6, SATA Rev 3.0
Standards:
       Used: unknown (minor revision code 0x006d)
       Supported: 10 9 8 7 6 5
       Likely used: 10
Configuration:
       Logical         max     current
       cylinders       16383   0
       heads           16      0
       sectors/track   63      0
       --
       LBA    user addressable sectors:   268435455
       LBA48  user addressable sectors:  3907029168
       Logical  Sector size:                   512 bytes
       Physical Sector size:                  4096 bytes
       Logical Sector-0 offset:                  0 bytes
       device size with M =3D 1024*1024:     1907729 MBytes
       device size with M =3D 1000*1000:     2000398 MBytes (2000 GB)
       cache/buffer size  =3D unknown
       Form Factor: 3.5 inch
       Nominal Media Rotation Rate: 5400
Capabilities:
       LBA, IORDY(can be disabled)
       Queue depth: 32
       Standby timer values: spec'd by Standard, with device specific minim=
um
       R/W multiple sector transfer: Max =3D 16  Current =3D 16
       DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
            Cycle time: min=3D120ns recommended=3D120ns
       PIO: pio0 pio1 pio2 pio3 pio4
            Cycle time: no flow control=3D120ns  IORDY flow control=3D120ns
Commands/features:
       Enabled Supported:
          *    SMART feature set
               Security Mode feature set
          *    Power Management feature set
          *    Write cache
          *    Look-ahead
          *    Host Protected Area feature set
          *    WRITE_BUFFER command
          *    READ_BUFFER command
          *    NOP cmd
          *    DOWNLOAD_MICROCODE
               SET_MAX security extension
          *    48-bit Address feature set
          *    Mandatory FLUSH_CACHE
          *    FLUSH_CACHE_EXT
          *    SMART error logging
          *    SMART self-test
          *    General Purpose Logging feature set
          *    64-bit World wide name
          *    IDLE_IMMEDIATE with UNLOAD
          *    WRITE_UNCORRECTABLE_EXT command
          *    {READ,WRITE}_DMA_EXT_GPL commands
          *    Segmented DOWNLOAD_MICROCODE
          *    Gen1 signaling speed (1.5Gb/s)
          *    Gen2 signaling speed (3.0Gb/s)
          *    Gen3 signaling speed (6.0Gb/s)
          *    Native Command Queueing (NCQ)
          *    Host-initiated interface power management
          *    Phy event counters
          *    Idle-Unload when NCQ is active
          *    NCQ priority information
          *    READ_LOG_DMA_EXT equivalent to READ_LOG_EXT
          *    DMA Setup Auto-Activate optimization
               Device-initiated interface power management
          *    Software settings preservation
          *    SMART Command Transport (SCT) feature set
          *    SCT Write Same (AC2)
          *    SCT Error Recovery Control (AC3)
          *    SCT Features Control (AC4)
          *    SCT Data Tables (AC5)
               unknown 206[12] (vendor specific)
               unknown 206[13] (vendor specific)
          *    Extended number of user addressable sectors
          *    DOWNLOAD MICROCODE DMA command
          *    WRITE BUFFER DMA command
          *    READ BUFFER DMA command
          *    Data Set Management TRIM supported (limit 10 blocks)
Security:
       Master password revision code =3D 65534
               supported
       not     enabled
       not     locked
               frozen
       not     expired: security count
               supported: enhanced erase
       256min for SECURITY ERASE UNIT. 256min for ENHANCED SECURITY ERASE U=
NIT.
Logical Unit WWN Device Identifier: 50014ee2bc6eea22
       NAA             : 5
       IEEE OUI        : 0014ee
       Unique ID       : 2bc6eea22
Checksum: correct
----------------------------------------
mjkorhon@taavi:~$ sudo smartctl -a /dev/sda
smartctl 7.4 2023-08-01 r5530 [x86_64-linux-6.14.3mk] (local build)
Copyright (C) 2002-23, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Family:     Western Digital Red (SMR)
Device Model:     WDC WD20EFAX-68FB5N0
Serial Number:    XXXXXXXXXXXXXXX
LU WWN Device Id: 5 0014ee 267192206
Firmware Version: 82.00A82
User Capacity:    2=E2=80=AF000=E2=80=AF398=E2=80=AF934=E2=80=AF016 bytes [=
2,00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    5400 rpm
Form Factor:      3.5 inches
TRIM Command:     Available
Device is:        In smartctl database 7.3/5528
ATA Version is:   ACS-3 T13/2161-D revision 5
SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Sun May  4 21:14:32 2025 EEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00) Offline data collection activity
                                       was never started.
                                       Auto Offline Data Collection: Disabl=
ed.
Self-test execution status:      (   0) The previous self-test routine comp=
leted
                                       without error or no self-test has ev=
er
                                       been run.
Total time to complete Offline
data collection:                (  284) seconds.
Offline data collection
capabilities:                    (0x7b) SMART execute Offline immediate.
                                       Auto Offline data collection
on/off support.
                                       Suspend Offline collection upon new
                                       command.
                                       Offline surface scan supported.
                                       Self-test supported.
                                       Conveyance Self-test supported.
                                       Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                       power-saving mode.
                                       Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                       General Purpose Logging supported.
Short self-test routine
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        ( 243) minutes.
Conveyance self-test routine
recommended polling time:        (   2) minutes.
SCT capabilities:              (0x303d) SCT Status supported.
                                       SCT Error Recovery Control supported=
.
                                       SCT Feature Control supported.
                                       SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
 1 Raw_Read_Error_Rate     0x002f   200   200   051    Pre-fail
Always       -       0
 3 Spin_Up_Time            0x0027   173   168   021    Pre-fail
Always       -       2341
 4 Start_Stop_Count        0x0032   095   095   000    Old_age
Always       -       5049
 5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail
Always       -       0
 7 Seek_Error_Rate         0x002e   200   200   000    Old_age
Always       -       0
 9 Power_On_Hours          0x0032   082   082   000    Old_age
Always       -       13350
10 Spin_Retry_Count        0x0032   100   100   000    Old_age
Always       -       0
11 Calibration_Retry_Count 0x0032   100   100   000    Old_age
Always       -       0
12 Power_Cycle_Count       0x0032   096   096   000    Old_age
Always       -       4552
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age
Always       -       254
193 Load_Cycle_Count        0x0032   199   199   000    Old_age
Always       -       4797
194 Temperature_Celsius     0x0022   110   101   000    Old_age
Always       -       33
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age
Always       -       0
197 Current_Pending_Sector  0x0032   200   200   000    Old_age
Always       -       0
198 Offline_Uncorrectable   0x0030   100   253   000    Old_age
Offline      -       0
199 UDMA_CRC_Error_Count    0x0032   200   200   000    Old_age
Always       -       123
200 Multi_Zone_Error_Rate   0x0008   100   253   000    Old_age
Offline      -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
No self-tests have been logged.  [To run self-tests, use: smartctl -t]

SMART Selective self-test log data structure revision number 1
SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
   1        0        0  Not_testing
   2        0        0  Not_testing
   3        0        0  Not_testing
   4        0        0  Not_testing
   5        0        0  Not_testing
Selective self-test flags (0x0):
 After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.

The above only provides legacy SMART information - try 'smartctl -x' for mo=
re
----------------------------------------
mjkorhon@taavi:~$ sudo smartctl -a /dev/sdc
smartctl 7.4 2023-08-01 r5530 [x86_64-linux-6.14.3mk] (local build)
Copyright (C) 2002-23, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Family:     Western Digital Red (SMR)
Device Model:     WDC WD20EFAX-68FB5N0
Serial Number:    YYYYYYYYYYYYYYYYYYY
LU WWN Device Id: 5 0014ee 2bc6eea22
Firmware Version: 82.00A82
User Capacity:    2=E2=80=AF000=E2=80=AF398=E2=80=AF934=E2=80=AF016 bytes [=
2,00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    5400 rpm
Form Factor:      3.5 inches
TRIM Command:     Available
Device is:        In smartctl database 7.3/5528
ATA Version is:   ACS-3 T13/2161-D revision 5
SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Sun May  4 21:14:34 2025 EEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00) Offline data collection activity
                                       was never started.
                                       Auto Offline Data Collection: Disabl=
ed.
Self-test execution status:      (   0) The previous self-test routine comp=
leted
                                       without error or no self-test has ev=
er
                                       been run.
Total time to complete Offline
data collection:                (63840) seconds.
Offline data collection
capabilities:                    (0x7b) SMART execute Offline immediate.
                                       Auto Offline data collection
on/off support.
                                       Suspend Offline collection upon new
                                       command.
                                       Offline surface scan supported.
                                       Self-test supported.
                                       Conveyance Self-test supported.
                                       Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                       power-saving mode.
                                       Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                       General Purpose Logging supported.
Short self-test routine
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        ( 248) minutes.
Conveyance self-test routine
recommended polling time:        (   2) minutes.
SCT capabilities:              (0x303d) SCT Status supported.
                                       SCT Error Recovery Control supported=
.
                                       SCT Feature Control supported.
                                       SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
 1 Raw_Read_Error_Rate     0x002f   200   200   051    Pre-fail
Always       -       0
 3 Spin_Up_Time            0x0027   172   168   021    Pre-fail
Always       -       2391
 4 Start_Stop_Count        0x0032   095   095   000    Old_age
Always       -       5049
 5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail
Always       -       0
 7 Seek_Error_Rate         0x002e   200   200   000    Old_age
Always       -       0
 9 Power_On_Hours          0x0032   082   082   000    Old_age
Always       -       13349
10 Spin_Retry_Count        0x0032   100   100   000    Old_age
Always       -       0
11 Calibration_Retry_Count 0x0032   100   100   000    Old_age
Always       -       0
12 Power_Cycle_Count       0x0032   096   096   000    Old_age
Always       -       4551
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age
Always       -       254
193 Load_Cycle_Count        0x0032   199   199   000    Old_age
Always       -       4798
194 Temperature_Celsius     0x0022   111   103   000    Old_age
Always       -       32
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age
Always       -       0
197 Current_Pending_Sector  0x0032   200   200   000    Old_age
Always       -       0
198 Offline_Uncorrectable   0x0030   100   253   000    Old_age
Offline      -       0
199 UDMA_CRC_Error_Count    0x0032   200   200   000    Old_age
Always       -       0
200 Multi_Zone_Error_Rate   0x0008   100   253   000    Old_age
Offline      -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
No self-tests have been logged.  [To run self-tests, use: smartctl -t]

SMART Selective self-test log data structure revision number 1
SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
   1        0        0  Not_testing
   2        0        0  Not_testing
   3        0        0  Not_testing
   4        0        0  Not_testing
   5        0        0  Not_testing
Selective self-test flags (0x0):
 After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.

The above only provides legacy SMART information - try 'smartctl -x' for mo=
re

---------------------
