Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AABA1E1021
	for <linux-ide@vger.kernel.org>; Sat, 10 May 2025 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746872135; cv=none; b=YLaaTf/SMMnQvs94Df3y8x6k9a87uxP/N9vTXA7sxuGdi6qYUHhgtmQ9n1nqvVkDMEkgmGOvFTOKIDQEs0U7NznlZU7Tnf133cT6uNkBWlx/E/MLdT9HdwIPOJgmYf7SbYwBf+6e6EJNQYY6ftYttzaifjbXVnZzHhgKdW1QpSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746872135; c=relaxed/simple;
	bh=aNxHC9aNYejttjsTvGfp6VlaGFqUSxAj+bi/h1jNnXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7c42XL5I7xZiWIwaPH/yyJaDpwoEIYh/vUA5i4zw11Ktk0syogHqCMZeCjg2AqsYtjQSXKjbRO4qGvIXFLQ/ymNTQeIjjSzkiORpMjDXPOpQ6jFTdmnAd8MBVEbCkbbCNASY7gNhXZ8O0OyFjquW3Hl/CkTGb00PXIlIo4RngU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6WBn7zz; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6WBn7zz"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70a35432c21so23258517b3.0
        for <linux-ide@vger.kernel.org>; Sat, 10 May 2025 03:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746872129; x=1747476929; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UEXIjW+FmlHCaiyhpGlOpUEBpffPmkXDaFCh/UGB+as=;
        b=f6WBn7zzYONjlZ6wy4yKHdIQBlQeaY5RhBA2pPJ6eJ5oNanu2Qm8Sg/AF1pGz6a1Ix
         5hoWYDbJExfPA4YuyYB5a4DwEBXmyHZC/yjslINMBA5uMcf8NV06c/Iz9IAkp0nm+URv
         t5OLo8abSWVE8/igg5ez7Uhbf4MJ/f46LSpQh/WeL2t8c4eGTIcqLOCZzO8g6Qqi2Oek
         1oeHliL6lxHtH5UJspL7DJMeMVs6jRNI80XrTpBGBHpL0QifN2WV1ij5CAknjBTt8m/I
         FfImd9q1zl8kTKrhq0FP4eqDRUMv7Kyc2PWEbUmc5pZoPdEZLNCICzYE2q9oLppx8Tc+
         T/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746872129; x=1747476929;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEXIjW+FmlHCaiyhpGlOpUEBpffPmkXDaFCh/UGB+as=;
        b=X3M4gmfwixdb3V9tRcJahi6PxbQXr2RDFkCoPLigd98puX/sMW88pGfUjhQkaKoU8O
         5cWsePS5dDtY3N6BYakGQZ3EYdKUahYP1/ENAoOrzDdGUvi7GPRNcwG3zCVL56SsX3aV
         z3TwvAJTiOELSUuP0G1colIfiqF5VZcd78woo8v7bGfsJSMiXu0ap5GmXsAUW40v93PL
         L99zRGwXgHo6UzLNuLhxbk5H96bsttjMtWS2LKQPoA2qy/LuVsWRHLKKl0jrK03qs7zC
         5IZuGfiv3BJ4oPUQaTqcSBnRFjKjRwdd29Z5lbupoUPgMXQdAX0V+iMtV+eh2bNDeKY/
         sLBw==
X-Forwarded-Encrypted: i=1; AJvYcCUCxs8kEw8GGYZajKGMVDQOJHxrKObig/ZA9SFzD7IenVXVqWCcrN6DbCUn2VxkyTa2Nm9YXhincI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRk8+RBhXEU491EMlpf1nxPgTj2K5tnMmwrMeJOulHWT7fsGNV
	QQ7hWiTLEFe0IhcxzBYTlkJZvVSv2iWZb56SHXyni3Qma8rxZzshpwpVEOAWmdYGLQ5cO1nLtUz
	NPwRDLN5XOtXahAquM8y7Kb/Rv3c=
X-Gm-Gg: ASbGnctOGXTtf86JJnXRL00owuxvlt+dXkezPiLz03yNCmmgme5FWw4JxbhIZLYoCxz
	uTCDDTfPfdfhhbbhxmBhEsXT6P70A1ly5jx0I2mJqTl7QrZdpcaVNbLnkN2S/tXQ08AAjjP+hnu
	hH2jjKomWJuwvQ0kiG2wmJwSZG3BW9rOqBZRMgzOn4U1Mf
X-Google-Smtp-Source: AGHT+IGmNxc/MP2ZSp0YeMDYT+lobUGdbVutEvPTdY7VvsqsYpFk418YQVLZ2CN9QkM9zTL8IV2Qi+Kta2sXy6EmBhU=
X-Received: by 2002:a05:690c:2b0e:b0:70a:192d:103 with SMTP id
 00721157ae682-70a3fb36816mr66942397b3.28.1746872128637; Sat, 10 May 2025
 03:15:28 -0700 (PDT)
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
 <f572f7d2-7b14-476e-aab2-bf674811dee5@kernel.org>
In-Reply-To: <f572f7d2-7b14-476e-aab2-bf674811dee5@kernel.org>
From: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Date: Sat, 10 May 2025 13:14:52 +0300
X-Gm-Features: ATxdqUEh4pTYXTDhZan_p_JyW114ND0gOiDxhGzfKa92Nq1aqMwH9c2dF5GyyK8
Message-ID: <CAAZ0mTf3T5RTDKtd148GyGOiVz98isFFbMDXfku8yAk9FfLVeQ@mail.gmail.com>
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>, linux-ide@vger.kernel.org, 
	Niklas Cassel <Niklas.Cassel@wdc.com>
Content-Type: text/plain; charset="UTF-8"

ke 7.5.2025 klo 11.56 Damien Le Moal (dlemoal@kernel.org) kirjoitti:
> >>>>> On 5/1/25 05:36, Ioannis Barkas wrote:
> >>> I have two WD20EFAX-68FB5N0 and both behave consistently, unusable
> >>> from 6.9.0 on as they just keep resetting the SATA link , but they
> >>> have worked flawlessly with 6.8.x for a year and also now with the
> Can you share a dmesg output for the good case with 6.8.x kernel ?
> We would like to see differences with the non-working case.

Hello Damien,
here is the dmesg from good 6.8.12. Thanks!

[    0.000000] Linux version 6.8.12 (mjkorhon@taavi) (gcc (Debian
14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #1 SMP
PREEMPT_DYNAMIC Fri May  9 20:37:29 EEST 2025
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.8.12
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
[    0.000000] BIOS-e820: [mem 0x00000000c3278000-0x00000000c9e67fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000c9e68000-0x00000000ca21efff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ca21f000-0x00000000ca3e0fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000ca3e1000-0x00000000cab7ffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cab80000-0x00000000cb9fefff] reserved
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
[    0.000000] e820: update [mem 0xacc43018-0xacc52067] usable ==> usable
[    0.000000] e820: update [mem 0xacc43018-0xacc52067] usable ==> usable
[    0.000000] e820: update [mem 0xacc23018-0xacc42a57] usable ==> usable
[    0.000000] e820: update [mem 0xacc23018-0xacc42a57] usable ==> usable
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
0x000000000b020000-0x00000000acc23017] usable
[    0.000000] reserve setup_data: [mem
0x00000000acc23018-0x00000000acc42a57] usable
[    0.000000] reserve setup_data: [mem
0x00000000acc42a58-0x00000000acc43017] usable
[    0.000000] reserve setup_data: [mem
0x00000000acc43018-0x00000000acc52067] usable
[    0.000000] reserve setup_data: [mem
0x00000000acc52068-0x00000000c3276fff] usable
[    0.000000] reserve setup_data: [mem
0x00000000c3277000-0x00000000c3277fff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000c3278000-0x00000000c9e67fff] usable
[    0.000000] reserve setup_data: [mem
0x00000000c9e68000-0x00000000ca21efff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000ca21f000-0x00000000ca3e0fff] ACPI data
[    0.000000] reserve setup_data: [mem
0x00000000ca3e1000-0x00000000cab7ffff] ACPI NVS
[    0.000000] reserve setup_data: [mem
0x00000000cab80000-0x00000000cb9fefff] reserved
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
[    0.000000] efi: ACPI=0xca3e0000 ACPI 2.0=0xca3e0014
TPMFinalLog=0xcab35000 SMBIOS=0xcb7f0000 SMBIOS 3.0=0xcb7ef000
MEMATTR=0xc4259018 ESRT=0xc64f5b98 MOKvar=0xcb84c000 INITRD=0xc0b1a198
RNG=0xca3c7c18 TPMEventLog=0xacc53018
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem76: MMIO range=[0xf0000000-0xf7ffffff]
(128MB) from e820 map
[    0.000000] e820: remove [mem 0xf0000000-0xf7ffffff] reserved
[    0.000000] efi: Remove mem77: MMIO range=[0xfd200000-0xfd2fffff]
(1MB) from e820 map
[    0.000000] e820: remove [mem 0xfd200000-0xfd2fffff] reserved
[    0.000000] efi: Remove mem78: MMIO range=[0xfd600000-0xfd7fffff]
(2MB) from e820 map
[    0.000000] e820: remove [mem 0xfd600000-0xfd7fffff] reserved
[    0.000000] efi: Not removing mem79: MMIO
range=[0xfea00000-0xfea0ffff] (64KB) from e820 map
[    0.000000] efi: Remove mem80: MMIO range=[0xfeb80000-0xfec01fff]
(0MB) from e820 map
[    0.000000] e820: remove [mem 0xfeb80000-0xfec01fff] reserved
[    0.000000] efi: Not removing mem81: MMIO
range=[0xfec10000-0xfec10fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem82: MMIO
range=[0xfec30000-0xfec30fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem83: MMIO
range=[0xfed00000-0xfed00fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem84: MMIO
range=[0xfed40000-0xfed44fff] (20KB) from e820 map
[    0.000000] efi: Not removing mem85: MMIO
range=[0xfed80000-0xfed8ffff] (64KB) from e820 map
[    0.000000] efi: Not removing mem86: MMIO
range=[0xfedc2000-0xfedcffff] (56KB) from e820 map
[    0.000000] efi: Not removing mem87: MMIO
range=[0xfedd4000-0xfedd5fff] (8KB) from e820 map
[    0.000000] efi: Remove mem88: MMIO range=[0xff000000-0xffffffff]
(16MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.3.0 present.
[    0.000000] DMI: ASUS System Product Name/ROG STRIX B550-F GAMING
(WI-FI), BIOS 3621 01/13/2025
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3792.709 MHz processor
[    0.000469] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000471] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000479] last_pfn = 0x82f300 max_arch_pfn = 0x400000000
[    0.000483] MTRR map: 7 entries (3 fixed + 4 variable; max 20),
built from 9 variable MTRRs
[    0.000485] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.000938] e820: update [mem 0xca570000-0xca57ffff] usable ==> reserved
[    0.000943] e820: update [mem 0xd0000000-0xffffffff] usable ==> reserved
[    0.000947] last_pfn = 0xcd000 max_arch_pfn = 0x400000000
[    0.004172] esrt: Reserving ESRT space from 0x00000000c64f5b98 to
0x00000000c64f5bd0.
[    0.004178] e820: update [mem 0xc64f5000-0xc64f5fff] usable ==> reserved
[    0.004195] Using GB pages for direct mapping
[    0.004965] Secure boot enabled
[    0.004965] RAMDISK: [mem 0xacc63000-0xb43e9fff]
[    0.005278] ACPI: Early table checksum verification disabled
[    0.005281] ACPI: RSDP 0x00000000CA3E0014 000024 (v02 ALASKA)
[    0.005285] ACPI: XSDT 0x00000000CA3DF728 0000D4 (v01 ALASKA A M I
  01072009 AMI  01000013)
[    0.005289] ACPI: FACP 0x00000000CA3D8000 000114 (v06 ALASKA A M I
  01072009 AMI  00010013)
[    0.005292] ACPI: DSDT 0x00000000CA3CC000 00B15E (v02 ALASKA A M I
  01072009 INTL 20120913)
[    0.005295] ACPI: FACS 0x00000000CAB65000 000040
[    0.005296] ACPI: SSDT 0x00000000CA3DE000 00092A (v02 AMD
AmdTable 00000002 MSFT 04000000)
[    0.005299] ACPI: SSDT 0x00000000CA3DA000 003B8E (v02 AMD    AMD
AOD  00000001 INTL 20120913)
[    0.005300] ACPI: SSDT 0x00000000CA3D9000 000309 (v02 ALASKA
CPUSSDT  01072009 AMI  01072009)
[    0.005302] ACPI: FIDT 0x00000000CA3CB000 00009C (v01 ALASKA A M I
  01072009 AMI  00010013)
[    0.005304] ACPI: MCFG 0x00000000CA3C9000 00003C (v01 ALASKA A M I
  01072009 MSFT 00010013)
[    0.005306] ACPI: HPET 0x00000000CA3C8000 000038 (v01 ALASKA A M I
  01072009 AMI  00000005)
[    0.005308] ACPI: IVRS 0x00000000CA3C6000 0000D0 (v02 AMD
AmdTable 00000001 AMD  00000001)
[    0.005310] ACPI: BGRT 0x00000000CA3C5000 000038 (v01 ALASKA A M I
  01072009 AMI  00010013)
[    0.005312] ACPI: WPBT 0x00000000CA28F000 00003C (v01 ALASKA A M I
  00000001 ASUS 00000001)
[    0.005314] ACPI: TPM2 0x00000000CA28E000 00004C (v04 ALASKA A M I
  00000001 AMI  00000000)
[    0.005315] ACPI: PCCT 0x00000000CA28D000 00006E (v02 AMD
AmdTable 00000001 AMD  00000001)
[    0.005317] ACPI: SSDT 0x00000000CA286000 0061A3 (v02 AMD
AmdTable 00000001 AMD  00000001)
[    0.005319] ACPI: CRAT 0x00000000CA284000 0016D0 (v01 AMD
AmdTable 00000001 AMD  00000001)
[    0.005321] ACPI: CDIT 0x00000000CA283000 000029 (v01 AMD
AmdTable 00000001 AMD  00000001)
[    0.005323] ACPI: SSDT 0x00000000CA282000 000259 (v02 AMD
ArticDGP 00000001 INTL 20120913)
[    0.005325] ACPI: SSDT 0x00000000CA27E000 003E6E (v02 AMD    ArticN
  00000001 INTL 20120913)
[    0.005327] ACPI: WSMT 0x00000000CA27D000 000028 (v01 ALASKA A M I
  01072009 AMI  00010013)
[    0.005328] ACPI: APIC 0x00000000CA27C000 00015E (v04 ALASKA A M I
  01072009 AMI  00010013)
[    0.005330] ACPI: SSDT 0x00000000CA27B000 00007D (v02 AMD
ArticDIS 00000001 INTL 20120913)
[    0.005332] ACPI: SSDT 0x00000000CA27A000 0000BF (v01 AMD
AmdTable 00001000 INTL 20120913)
[    0.005334] ACPI: FPDT 0x00000000CA279000 000044 (v01 ALASKA A M I
  01072009 AMI  01000013)
[    0.005336] ACPI: Reserving FACP table memory at [mem 0xca3d8000-0xca3d8113]
[    0.005336] ACPI: Reserving DSDT table memory at [mem 0xca3cc000-0xca3d715d]
[    0.005337] ACPI: Reserving FACS table memory at [mem 0xcab65000-0xcab6503f]
[    0.005338] ACPI: Reserving SSDT table memory at [mem 0xca3de000-0xca3de929]
[    0.005338] ACPI: Reserving SSDT table memory at [mem 0xca3da000-0xca3ddb8d]
[    0.005339] ACPI: Reserving SSDT table memory at [mem 0xca3d9000-0xca3d9308]
[    0.005339] ACPI: Reserving FIDT table memory at [mem 0xca3cb000-0xca3cb09b]
[    0.005340] ACPI: Reserving MCFG table memory at [mem 0xca3c9000-0xca3c903b]
[    0.005341] ACPI: Reserving HPET table memory at [mem 0xca3c8000-0xca3c8037]
[    0.005341] ACPI: Reserving IVRS table memory at [mem 0xca3c6000-0xca3c60cf]
[    0.005342] ACPI: Reserving BGRT table memory at [mem 0xca3c5000-0xca3c5037]
[    0.005342] ACPI: Reserving WPBT table memory at [mem 0xca28f000-0xca28f03b]
[    0.005343] ACPI: Reserving TPM2 table memory at [mem 0xca28e000-0xca28e04b]
[    0.005343] ACPI: Reserving PCCT table memory at [mem 0xca28d000-0xca28d06d]
[    0.005344] ACPI: Reserving SSDT table memory at [mem 0xca286000-0xca28c1a2]
[    0.005344] ACPI: Reserving CRAT table memory at [mem 0xca284000-0xca2856cf]
[    0.005345] ACPI: Reserving CDIT table memory at [mem 0xca283000-0xca283028]
[    0.005346] ACPI: Reserving SSDT table memory at [mem 0xca282000-0xca282258]
[    0.005346] ACPI: Reserving SSDT table memory at [mem 0xca27e000-0xca281e6d]
[    0.005347] ACPI: Reserving WSMT table memory at [mem 0xca27d000-0xca27d027]
[    0.005347] ACPI: Reserving APIC table memory at [mem 0xca27c000-0xca27c15d]
[    0.005348] ACPI: Reserving SSDT table memory at [mem 0xca27b000-0xca27b07c]
[    0.005348] ACPI: Reserving SSDT table memory at [mem 0xca27a000-0xca27a0be]
[    0.005349] ACPI: Reserving FPDT table memory at [mem 0xca279000-0xca279043]
[    0.005403] No NUMA configuration found
[    0.005404] Faking a node at [mem 0x0000000000000000-0x000000082f2fffff]
[    0.005410] NODE_DATA(0) allocated [mem 0x82f2d5000-0x82f2fffff]
[    0.005562] Zone ranges:
[    0.005562]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.005564]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.005565]   Normal   [mem 0x0000000100000000-0x000000082f2fffff]
[    0.005566]   Device   empty
[    0.005567] Movable zone start for each node
[    0.005569] Early memory node ranges
[    0.005569]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.005570]   node   0: [mem 0x0000000000100000-0x0000000009d1efff]
[    0.005571]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
[    0.005572]   node   0: [mem 0x000000000a211000-0x000000000affffff]
[    0.005572]   node   0: [mem 0x000000000b020000-0x00000000c3276fff]
[    0.005573]   node   0: [mem 0x00000000c3278000-0x00000000c9e67fff]
[    0.005574]   node   0: [mem 0x00000000cb9ff000-0x00000000ccffffff]
[    0.005574]   node   0: [mem 0x0000000100000000-0x000000082f2fffff]
[    0.005577] Initmem setup node 0 [mem 0x0000000000001000-0x000000082f2fffff]
[    0.005581] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.005596] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.005723] On node 0, zone DMA32: 737 pages in unavailable ranges
[    0.005736] On node 0, zone DMA32: 17 pages in unavailable ranges
[    0.009341] On node 0, zone DMA32: 32 pages in unavailable ranges
[    0.009491] On node 0, zone DMA32: 1 pages in unavailable ranges
[    0.009570] On node 0, zone DMA32: 7063 pages in unavailable ranges
[    0.009837] On node 0, zone Normal: 12288 pages in unavailable ranges
[    0.009859] On node 0, zone Normal: 3328 pages in unavailable ranges
[    0.010052] ACPI: PM-Timer IO Port: 0x808
[    0.010060] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.010071] IOAPIC[0]: apic_id 25, version 33, address 0xfec00000, GSI 0-23
[    0.010076] IOAPIC[1]: apic_id 26, version 33, address 0xfec01000, GSI 24-55
[    0.010078] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.010080] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.010082] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.010083] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.010091] e820: update [mem 0xc53d2000-0xc54c5fff] usable ==> reserved
[    0.010103] smpboot: Allowing 32 CPUs, 8 hotplug CPUs
[    0.010127] PM: hibernation: Registered nosave memory: [mem
0x00000000-0x00000fff]
[    0.010128] PM: hibernation: Registered nosave memory: [mem
0x000a0000-0x000fffff]
[    0.010130] PM: hibernation: Registered nosave memory: [mem
0x09d1f000-0x09ffffff]
[    0.010131] PM: hibernation: Registered nosave memory: [mem
0x0a200000-0x0a210fff]
[    0.010132] PM: hibernation: Registered nosave memory: [mem
0x0b000000-0x0b01ffff]
[    0.010134] PM: hibernation: Registered nosave memory: [mem
0xacc23000-0xacc23fff]
[    0.010135] PM: hibernation: Registered nosave memory: [mem
0xacc42000-0xacc42fff]
[    0.010136] PM: hibernation: Registered nosave memory: [mem
0xacc43000-0xacc43fff]
[    0.010137] PM: hibernation: Registered nosave memory: [mem
0xacc52000-0xacc52fff]
[    0.010138] PM: hibernation: Registered nosave memory: [mem
0xc3277000-0xc3277fff]
[    0.010140] PM: hibernation: Registered nosave memory: [mem
0xc53d2000-0xc54c5fff]
[    0.010141] PM: hibernation: Registered nosave memory: [mem
0xc64f5000-0xc64f5fff]
[    0.010142] PM: hibernation: Registered nosave memory: [mem
0xc9e68000-0xca21efff]
[    0.010143] PM: hibernation: Registered nosave memory: [mem
0xca21f000-0xca3e0fff]
[    0.010143] PM: hibernation: Registered nosave memory: [mem
0xca3e1000-0xcab7ffff]
[    0.010144] PM: hibernation: Registered nosave memory: [mem
0xcab80000-0xcb9fefff]
[    0.010145] PM: hibernation: Registered nosave memory: [mem
0xcd000000-0xcfffffff]
[    0.010146] PM: hibernation: Registered nosave memory: [mem
0xd0000000-0xfe9fffff]
[    0.010146] PM: hibernation: Registered nosave memory: [mem
0xfea00000-0xfea0ffff]
[    0.010147] PM: hibernation: Registered nosave memory: [mem
0xfea10000-0xfec0ffff]
[    0.010147] PM: hibernation: Registered nosave memory: [mem
0xfec10000-0xfec10fff]
[    0.010148] PM: hibernation: Registered nosave memory: [mem
0xfec11000-0xfec2ffff]
[    0.010148] PM: hibernation: Registered nosave memory: [mem
0xfec30000-0xfec30fff]
[    0.010149] PM: hibernation: Registered nosave memory: [mem
0xfec31000-0xfecfffff]
[    0.010149] PM: hibernation: Registered nosave memory: [mem
0xfed00000-0xfed00fff]
[    0.010150] PM: hibernation: Registered nosave memory: [mem
0xfed01000-0xfed3ffff]
[    0.010150] PM: hibernation: Registered nosave memory: [mem
0xfed40000-0xfed44fff]
[    0.010151] PM: hibernation: Registered nosave memory: [mem
0xfed45000-0xfed7ffff]
[    0.010151] PM: hibernation: Registered nosave memory: [mem
0xfed80000-0xfed8ffff]
[    0.010152] PM: hibernation: Registered nosave memory: [mem
0xfed90000-0xfedc1fff]
[    0.010152] PM: hibernation: Registered nosave memory: [mem
0xfedc2000-0xfedcffff]
[    0.010153] PM: hibernation: Registered nosave memory: [mem
0xfedd0000-0xfedd3fff]
[    0.010153] PM: hibernation: Registered nosave memory: [mem
0xfedd4000-0xfedd5fff]
[    0.010153] PM: hibernation: Registered nosave memory: [mem
0xfedd6000-0xffffffff]
[    0.010155] [mem 0xd0000000-0xfe9fffff] available for PCI devices
[    0.010156] Booting paravirtualized kernel on bare hardware
[    0.010158] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.013855] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:32
nr_cpu_ids:32 nr_node_ids:1
[    0.014775] percpu: Embedded 64 pages/cpu s225280 r8192 d28672 u262144
[    0.014780] pcpu-alloc: s225280 r8192 d28672 u262144 alloc=1*2097152
[    0.014782] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11
12 13 14 15
[    0.014788] pcpu-alloc: [0] 16 17 18 19 20 21 22 23 [0] 24 25 26 27
28 29 30 31
[    0.014811] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-6.8.12
root=UUID=c056bf20-f617-4c4a-8d3c-28ac04ff6a3a ro lockdown=integrity
splash
[    0.014855] Unknown kernel command line parameters "splash
BOOT_IMAGE=/boot/vmlinuz-6.8.12", will be passed to user space.
[    0.014871] printk: log_buf_len individual max cpu contribution: 4096 bytes
[    0.014872] printk: log_buf_len total cpu_extra contributions: 126976 bytes
[    0.014873] printk: log_buf_len min size: 131072 bytes
[    0.015032] printk: log_buf_len: 262144 bytes
[    0.015032] printk: early log buf free: 111920(85%)
[    0.017704] Dentry cache hash table entries: 4194304 (order: 13,
33554432 bytes, linear)
[    0.019050] Inode-cache hash table entries: 2097152 (order: 12,
16777216 bytes, linear)
[    0.019236] Fallback order for Node 0: 0
[    0.019245] Built 1 zonelists, mobility grouping on.  Total pages: 8234180
[    0.019246] Policy zone: Normal
[    0.019251] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.019286] software IO TLB: area num 32.
[    0.038865] Memory: 3139132K/33460180K available (16384K kernel
code, 2379K rwdata, 10836K rodata, 4056K init, 5400K bss, 947800K
reserved, 0K cma-reserved)
[    0.039055] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32, Nodes=1
[    0.039080] ftrace: allocating 44060 entries in 173 pages
[    0.045059] ftrace: allocated 173 pages with 5 groups
[    0.045584] Dynamic Preempt: voluntary
[    0.045653] rcu: Preemptible hierarchical RCU implementation.
[    0.045653] rcu:     RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=32.
[    0.045654]     Trampoline variant of Tasks RCU enabled.
[    0.045654]     Rude variant of Tasks RCU enabled.
[    0.045655]     Tracing variant of Tasks RCU enabled.
[    0.045655] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.045656] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=32
[    0.047417] NR_IRQS: 524544, nr_irqs: 1224, preallocated irqs: 16
[    0.047600] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.047674] Console: colour dummy device 80x25
[    0.047675] printk: legacy console [tty0] enabled
[    0.048029] ACPI: Core revision 20230628
[    0.048120] clocksource: hpet: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 133484873504 ns
[    0.048137] APIC: Switch to symmetric I/O mode setup
[    0.048887] AMD-Vi: Using global IVHD EFR:0x0, EFR2:0x0
[    0.367960] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.367979] APIC: Switched APIC routing to: physical flat
[    0.368608] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.388150] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x6d56e341366, max_idle_ns: 881591146641 ns
[    0.388155] Calibrating delay loop (skipped), value calculated
using timer frequency.. 7585.41 BogoMIPS (lpj=15170836)
[    0.388169] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.388211] LVT offset 1 assigned for vector 0xf9
[    0.388330] LVT offset 2 assigned for vector 0xf4
[    0.388362] process: using mwait in idle threads
[    0.388364] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.388366] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
[    0.388369] Spectre V1 : Mitigation: usercopy/swapgs barriers and
__user pointer sanitization
[    0.388373] Spectre V2 : Mitigation: Retpolines
[    0.388374] Spectre V2 : Spectre v2 / SpectreRSB mitigation:
Filling RSB on context switch
[    0.388376] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.388378] Spectre V2 : Enabling Speculation Barrier for firmware calls
[    0.388379] RETBleed: Mitigation: untrained return thunk
[    0.388381] Spectre V2 : mitigation: Enabling conditional Indirect
Branch Prediction Barrier
[    0.388383] Spectre V2 : Selecting STIBP always-on mode to
complement retbleed mitigation
[    0.388385] Spectre V2 : User space: Mitigation: STIBP always-on protection
[    0.388387] Speculative Store Bypass: Mitigation: Speculative Store
Bypass disabled via prctl
[    0.388390] Speculative Return Stack Overflow: Mitigation: Safe RET
[    0.388394] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
point registers'
[    0.388397] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.388398] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.388400] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.388402] x86/fpu: Enabled xstate features 0x7, context size is
832 bytes, using 'compacted' format.
[    0.405770] Freeing SMP alternatives memory: 36K
[    0.405775] pid_max: default: 32768 minimum: 301
[    0.411390] LSM: initializing
lsm=lockdown,capability,landlock,yama,apparmor,tomoyo,bpf,integrity
[    0.411412] landlock: Up and running.
[    0.411415] Yama: becoming mindful.
[    0.411435] AppArmor: AppArmor initialized
[    0.411440] TOMOYO Linux initialized
[    0.411447] LSM support for eBPF active
[    0.411513] Mount-cache hash table entries: 65536 (order: 7, 524288
bytes, linear)
[    0.411553] Mountpoint-cache hash table entries: 65536 (order: 7,
524288 bytes, linear)
[    0.520641] smpboot: CPU0: AMD Ryzen 9 3900X 12-Core Processor
(family: 0x17, model: 0x71, stepping: 0x0)
[    0.520798] RCU Tasks: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1.
[    0.520816] RCU Tasks Rude: Setting shift to 5 and lim to 1
rcu_task_cb_adjust=1.
[    0.520836] RCU Tasks Trace: Setting shift to 5 and lim to 1
rcu_task_cb_adjust=1.
[    0.520853] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    0.520879] ... version:                0
[    0.520882] ... bit width:              48
[    0.520886] ... generic registers:      6
[    0.520889] ... value mask:             0000ffffffffffff
[    0.520893] ... max period:             00007fffffffffff
[    0.520896] ... fixed-purpose events:   0
[    0.520900] ... event mask:             000000000000003f
[    0.520992] signal: max sigframe size: 1776
[    0.521039] rcu: Hierarchical SRCU implementation.
[    0.521043] rcu:     Max phase no-delay instances is 1000.
[    0.523481] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.523709] smp: Bringing up secondary CPUs ...
[    0.523806] smpboot: x86: Booting SMP configuration:
[    0.523810] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
#8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23
[    0.552274] Spectre V2 : Update user space SMT mitigation: STIBP always-on
[    0.576196] smp: Brought up 1 node, 24 CPUs
[    0.576196] smpboot: Max logical packages: 2
[    0.576196] smpboot: Total of 24 processors activated (182050.03 BogoMIPS)
[    0.610738] node 0 deferred pages initialised in 32ms
[    0.612844] devtmpfs: initialized
[    0.612844] x86/mm: Memory block size: 128MB
[    0.617360] ACPI: PM: Registering ACPI NVS region [mem
0x0a200000-0x0a210fff] (69632 bytes)
[    0.617360] ACPI: PM: Registering ACPI NVS region [mem
0xca3e1000-0xcab7ffff] (7991296 bytes)
[    0.617360] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.617360] futex hash table entries: 8192 (order: 7, 524288 bytes, linear)
[    0.617360] pinctrl core: initialized pinctrl subsystem
[    0.617360] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.617612] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.617945] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for
atomic allocations
[    0.618261] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool
for atomic allocations
[    0.618278] audit: initializing netlink subsys (disabled)
[    0.618291] audit: type=2000 audit(1746868892.256:1):
state=initialized audit_enabled=0 res=1
[    0.618291] thermal_sys: Registered thermal governor 'fair_share'
[    0.618291] thermal_sys: Registered thermal governor 'bang_bang'
[    0.618291] thermal_sys: Registered thermal governor 'step_wise'
[    0.618291] thermal_sys: Registered thermal governor 'user_space'
[    0.618291] thermal_sys: Registered thermal governor 'power_allocator'
[    0.618291] cpuidle: using governor ladder
[    0.618291] cpuidle: using governor menu
[    0.618291] Detected 1 PCC Subspaces
[    0.618291] Registering PCC driver as Mailbox controller
[    0.618291] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.618291] PCI: ECAM [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
for domain 0000 [bus 00-7f]
[    0.618291] PCI: not using ECAM ([mem 0xf0000000-0xf7ffffff] not reserved)
[    0.618291] PCI: Using configuration type 1 for base access
[    0.618291] PCI: Using configuration type 1 for extended access
[    0.618291] kprobes: kprobe jump-optimization is enabled. All
kprobes are optimized if possible.
[    0.620208] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.620208] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.620208] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.620208] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.620288] ACPI: Added _OSI(Module Device)
[    0.620293] ACPI: Added _OSI(Processor Device)
[    0.620298] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.620304] ACPI: Added _OSI(Processor Aggregator Device)
[    0.628362] ACPI: 9 ACPI AML tables successfully acquired and loaded
[    0.632818] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.637383] ACPI: _OSC evaluation for CPUs failed, trying _PDC
[    0.637383] ACPI: Interpreter enabled
[    0.637383] ACPI: PM: (supports S0 S3 S4 S5)
[    0.637383] ACPI: Using IOAPIC for interrupt routing
[    0.637487] PCI: ECAM [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
for domain 0000 [bus 00-7f]
[    0.637529] PCI: ECAM [mem 0xf0000000-0xf7ffffff] reserved as ACPI
motherboard resource
[    0.637544] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    0.637550] PCI: Ignoring E820 reservations for host bridge windows
[    0.637893] ACPI: Enabled 5 GPEs in block 00 to 1F
[    0.662237] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.662247] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI HPX-Type3]
[    0.662360] acpi PNP0A08:00: _OSC: platform does not support
[PCIeHotplug SHPCHotplug PME LTR]
[    0.662563] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability]
[    0.662575] acpi PNP0A08:00: [Firmware Info]: ECAM [mem
0xf0000000-0xf7ffffff] for domain 0000 [bus 00-7f] only partially
covers this bridge
[    0.663100] PCI host bridge to bus 0000:00
[    0.663104] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.663110] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.663115] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.663120] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.663125] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000dffff window]
[    0.663131] pci_bus 0000:00: root bus resource [mem
0xd0000000-0xfec2ffff window]
[    0.663136] pci_bus 0000:00: root bus resource [mem
0xfee00000-0xffffffff window]
[    0.663142] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.663163] pci 0000:00:00.0: [1022:1480] type 00 class 0x060000
conventional PCI endpoint
[    0.663278] pci 0000:00:00.2: [1022:1481] type 00 class 0x080600
conventional PCI endpoint
[    0.663389] pci 0000:00:01.0: [1022:1482] type 00 class 0x060000
conventional PCI endpoint
[    0.663466] pci 0000:00:01.2: [1022:1483] type 01 class 0x060400
PCIe Root Port
[    0.663491] pci 0000:00:01.2: PCI bridge to [bus 01-05]
[    0.663500] pci 0000:00:01.2:   bridge window [mem 0xfc200000-0xfc5fffff]
[    0.663519] pci 0000:00:01.2: enabling Extended Tags
[    0.663579] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.663787] pci 0000:00:02.0: [1022:1482] type 00 class 0x060000
conventional PCI endpoint
[    0.663872] pci 0000:00:03.0: [1022:1482] type 00 class 0x060000
conventional PCI endpoint
[    0.663950] pci 0000:00:03.1: [1022:1483] type 01 class 0x060400
PCIe Root Port
[    0.663975] pci 0000:00:03.1: PCI bridge to [bus 06]
[    0.663983] pci 0000:00:03.1:   bridge window [io  0xf000-0xffff]
[    0.663989] pci 0000:00:03.1:   bridge window [mem 0xfb000000-0xfc0fffff]
[    0.664000] pci 0000:00:03.1:   bridge window [mem
0xd0000000-0xe20fffff 64bit pref]
[    0.664068] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
[    0.664449] pci 0000:00:04.0: [1022:1482] type 00 class 0x060000
conventional PCI endpoint
[    0.664531] pci 0000:00:05.0: [1022:1482] type 00 class 0x060000
conventional PCI endpoint
[    0.664609] pci 0000:00:07.0: [1022:1482] type 00 class 0x060000
conventional PCI endpoint
[    0.664684] pci 0000:00:07.1: [1022:1484] type 01 class 0x060400
PCIe Root Port
[    0.664706] pci 0000:00:07.1: PCI bridge to [bus 07]
[    0.664725] pci 0000:00:07.1: enabling Extended Tags
[    0.664772] pci 0000:00:07.1: PME# supported from D0 D3hot D3cold
[    0.664918] pci 0000:00:08.0: [1022:1482] type 00 class 0x060000
conventional PCI endpoint
[    0.664993] pci 0000:00:08.1: [1022:1484] type 01 class 0x060400
PCIe Root Port
[    0.665016] pci 0000:00:08.1: PCI bridge to [bus 08]
[    0.665024] pci 0000:00:08.1:   bridge window [mem 0xfc600000-0xfc8fffff]
[    0.665041] pci 0000:00:08.1: enabling Extended Tags
[    0.665092] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.665264] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
conventional PCI endpoint
[    0.665398] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
conventional PCI endpoint
[    0.665552] pci 0000:00:18.0: [1022:1440] type 00 class 0x060000
conventional PCI endpoint
[    0.665602] pci 0000:00:18.1: [1022:1441] type 00 class 0x060000
conventional PCI endpoint
[    0.665650] pci 0000:00:18.2: [1022:1442] type 00 class 0x060000
conventional PCI endpoint
[    0.665697] pci 0000:00:18.3: [1022:1443] type 00 class 0x060000
conventional PCI endpoint
[    0.665745] pci 0000:00:18.4: [1022:1444] type 00 class 0x060000
conventional PCI endpoint
[    0.665792] pci 0000:00:18.5: [1022:1445] type 00 class 0x060000
conventional PCI endpoint
[    0.665839] pci 0000:00:18.6: [1022:1446] type 00 class 0x060000
conventional PCI endpoint
[    0.665886] pci 0000:00:18.7: [1022:1447] type 00 class 0x060000
conventional PCI endpoint
[    0.666009] pci 0000:01:00.0: [1022:43ee] type 00 class 0x0c0330
PCIe Legacy Endpoint
[    0.666034] pci 0000:01:00.0: BAR 0 [mem 0xfc5a0000-0xfc5a7fff 64bit]
[    0.666084] pci 0000:01:00.0: enabling Extended Tags
[    0.666145] pci 0000:01:00.0: PME# supported from D3hot D3cold
[    0.666329] pci 0000:01:00.1: [1022:43eb] type 00 class 0x010601
PCIe Legacy Endpoint
[    0.666388] pci 0000:01:00.1: BAR 5 [mem 0xfc580000-0xfc59ffff]
[    0.666401] pci 0000:01:00.1: ROM [mem 0xfc500000-0xfc57ffff pref]
[    0.666412] pci 0000:01:00.1: enabling Extended Tags
[    0.666463] pci 0000:01:00.1: PME# supported from D3hot D3cold
[    0.666570] pci 0000:01:00.2: [1022:43e9] type 01 class 0x060400
PCIe Switch Upstream Port
[    0.666607] pci 0000:01:00.2: PCI bridge to [bus 02-05]
[    0.666619] pci 0000:01:00.2:   bridge window [mem 0xfc200000-0xfc4fffff]
[    0.666647] pci 0000:01:00.2: enabling Extended Tags
[    0.666703] pci 0000:01:00.2: PME# supported from D3hot D3cold
[    0.666841] pci 0000:00:01.2: PCI bridge to [bus 01-05]
[    0.666983] pci 0000:02:00.0: [1022:43ea] type 01 class 0x060400
PCIe Switch Downstream Port
[    0.667021] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.667058] pci 0000:02:00.0: enabling Extended Tags
[    0.667125] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.667264] pci 0000:02:08.0: [1022:43ea] type 01 class 0x060400
PCIe Switch Downstream Port
[    0.667303] pci 0000:02:08.0: PCI bridge to [bus 04]
[    0.667315] pci 0000:02:08.0:   bridge window [mem 0xfc400000-0xfc4fffff]
[    0.667345] pci 0000:02:08.0: enabling Extended Tags
[    0.667412] pci 0000:02:08.0: PME# supported from D3hot D3cold
[    0.667541] pci 0000:02:09.0: [1022:43ea] type 01 class 0x060400
PCIe Switch Downstream Port
[    0.667579] pci 0000:02:09.0: PCI bridge to [bus 05]
[    0.667591] pci 0000:02:09.0:   bridge window [mem 0xfc200000-0xfc3fffff]
[    0.667621] pci 0000:02:09.0: enabling Extended Tags
[    0.667688] pci 0000:02:09.0: PME# supported from D3hot D3cold
[    0.667826] pci 0000:01:00.2: PCI bridge to [bus 02-05]
[    0.667894] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.667997] pci 0000:04:00.0: [8086:2723] type 00 class 0x028000
PCIe Endpoint
[    0.668034] pci 0000:04:00.0: BAR 0 [mem 0xfc400000-0xfc403fff 64bit]
[    0.668214] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    0.668441] pci 0000:02:08.0: PCI bridge to [bus 04]
[    0.668545] pci 0000:05:00.0: [8086:15f3] type 00 class 0x020000
PCIe Endpoint
[    0.668575] pci 0000:05:00.0: BAR 0 [mem 0xfc200000-0xfc2fffff]
[    0.668619] pci 0000:05:00.0: BAR 3 [mem 0xfc300000-0xfc303fff]
[    0.668786] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[    0.669065] pci 0000:02:09.0: PCI bridge to [bus 05]
[    0.669172] pci 0000:06:00.0: [10de:1f08] type 00 class 0x030000
PCIe Legacy Endpoint
[    0.669193] pci 0000:06:00.0: BAR 0 [mem 0xfb000000-0xfbffffff]
[    0.669209] pci 0000:06:00.0: BAR 1 [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.669226] pci 0000:06:00.0: BAR 3 [mem 0xe0000000-0xe1ffffff 64bit pref]
[    0.669239] pci 0000:06:00.0: BAR 5 [io  0xf000-0xf07f]
[    0.669251] pci 0000:06:00.0: ROM [mem 0xfc000000-0xfc07ffff pref]
[    0.669275] pci 0000:06:00.0: BAR 3: assigned to efifb
[    0.669284] pci 0000:06:00.0: Video device with shadowed ROM at
[mem 0x000c0000-0x000dffff]
[    0.669343] pci 0000:06:00.0: PME# supported from D0 D3hot
[    0.669436] pci 0000:06:00.0: 32.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s PCIe x16 link at 0000:00:03.1 (capable of 126.016
Gb/s with 8.0 GT/s PCIe x16 link)
[    0.669595] pci 0000:06:00.1: [10de:10f9] type 00 class 0x040300
PCIe Endpoint
[    0.669615] pci 0000:06:00.1: BAR 0 [mem 0xfc080000-0xfc083fff]
[    0.669812] pci 0000:06:00.2: [10de:1ada] type 00 class 0x0c0330
PCIe Endpoint
[    0.669836] pci 0000:06:00.2: BAR 0 [mem 0xe2000000-0xe203ffff 64bit pref]
[    0.669862] pci 0000:06:00.2: BAR 3 [mem 0xe2040000-0xe204ffff 64bit pref]
[    0.669934] pci 0000:06:00.2: PME# supported from D0 D3hot
[    0.670020] pci 0000:06:00.3: [10de:1adb] type 00 class 0x0c8000
PCIe Endpoint
[    0.670039] pci 0000:06:00.3: BAR 0 [mem 0xfc084000-0xfc084fff]
[    0.670139] pci 0000:06:00.3: PME# supported from D0 D3hot
[    0.670260] pci 0000:00:03.1: PCI bridge to [bus 06]
[    0.670323] pci 0000:07:00.0: [1022:148a] type 00 class 0x130000
PCIe Endpoint
[    0.670358] pci 0000:07:00.0: enabling Extended Tags
[    0.670528] pci 0000:00:07.1: PCI bridge to [bus 07]
[    0.670598] pci 0000:08:00.0: [1022:1485] type 00 class 0x130000
PCIe Endpoint
[    0.670639] pci 0000:08:00.0: enabling Extended Tags
[    0.670812] pci 0000:08:00.1: [1022:1486] type 00 class 0x108000
PCIe Endpoint
[    0.670834] pci 0000:08:00.1: BAR 2 [mem 0xfc700000-0xfc7fffff]
[    0.670850] pci 0000:08:00.1: BAR 5 [mem 0xfc808000-0xfc809fff]
[    0.670863] pci 0000:08:00.1: enabling Extended Tags
[    0.671008] pci 0000:08:00.3: [1022:149c] type 00 class 0x0c0330
PCIe Endpoint
[    0.671026] pci 0000:08:00.3: BAR 0 [mem 0xfc600000-0xfc6fffff 64bit]
[    0.671062] pci 0000:08:00.3: enabling Extended Tags
[    0.671114] pci 0000:08:00.3: PME# supported from D0 D3hot D3cold
[    0.671243] pci 0000:08:00.4: [1022:1487] type 00 class 0x040300
PCIe Endpoint
[    0.671257] pci 0000:08:00.4: BAR 0 [mem 0xfc800000-0xfc807fff]
[    0.671289] pci 0000:08:00.4: enabling Extended Tags
[    0.671338] pci 0000:08:00.4: PME# supported from D0 D3hot D3cold
[    0.671474] pci 0000:00:08.1: PCI bridge to [bus 08]
[    0.671872] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.671928] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.671973] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.672027] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.672077] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.672119] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.672163] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.672205] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.673263] iommu: Default domain type: Translated
[    0.673263] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.674126] pps_core: LinuxPPS API ver. 1 registered
[    0.674131] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.674138] PTP clock support registered
[    0.674150] EDAC MC: Ver: 3.0.0
[    0.676181] efivars: Registered efivars operations
[    0.676378] NetLabel: Initializing
[    0.676381] NetLabel:  domain hash size = 128
[    0.676385] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.676407] NetLabel:  unlabeled traffic allowed by default
[    0.676411] PCI: Using ACPI for IRQ routing
[    0.679789] PCI: pci_cache_line_size set to 64 bytes
[    0.679861] e820: reserve RAM buffer [mem 0x09d1f000-0x0bffffff]
[    0.679863] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
[    0.679865] e820: reserve RAM buffer [mem 0x0b000000-0x0bffffff]
[    0.679867] e820: reserve RAM buffer [mem 0xacc23018-0xafffffff]
[    0.679868] e820: reserve RAM buffer [mem 0xacc43018-0xafffffff]
[    0.679870] e820: reserve RAM buffer [mem 0xc3277000-0xc3ffffff]
[    0.679872] e820: reserve RAM buffer [mem 0xc53d2000-0xc7ffffff]
[    0.679873] e820: reserve RAM buffer [mem 0xc64f5000-0xc7ffffff]
[    0.679874] e820: reserve RAM buffer [mem 0xc9e68000-0xcbffffff]
[    0.679876] e820: reserve RAM buffer [mem 0xcd000000-0xcfffffff]
[    0.679877] e820: reserve RAM buffer [mem 0x82f300000-0x82fffffff]
[    0.680181] pci 0000:06:00.0: vgaarb: setting as boot VGA device
[    0.680181] pci 0000:06:00.0: vgaarb: bridge control possible
[    0.680181] pci 0000:06:00.0: vgaarb: VGA device added:
decodes=io+mem,owns=io+mem,locks=none
[    0.680183] vgaarb: loaded
[    0.680223] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.680231] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.681223] clocksource: Switched to clocksource tsc-early
[    0.681385] VFS: Disk quotas dquot_6.6.0
[    0.681404] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.681565] AppArmor: AppArmor Filesystem Enabled
[    0.681581] pnp: PnP ACPI init
[    0.681662] system 00:00: [mem 0xf0000000-0xf7ffffff] has been reserved
[    0.681741] system 00:01: [mem 0xfd200000-0xfd2fffff] has been reserved
[    0.681914] system 00:03: [io  0x0290-0x029f] has been reserved
[    0.681920] system 00:03: [io  0x0200-0x021f] has been reserved
[    0.682163] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.682169] system 00:04: [io  0x040b] has been reserved
[    0.682174] system 00:04: [io  0x04d6] has been reserved
[    0.682178] system 00:04: [io  0x0c00-0x0c01] has been reserved
[    0.682183] system 00:04: [io  0x0c14] has been reserved
[    0.682188] system 00:04: [io  0x0c50-0x0c51] has been reserved
[    0.682193] system 00:04: [io  0x0c52] has been reserved
[    0.682198] system 00:04: [io  0x0c6c] has been reserved
[    0.682203] system 00:04: [io  0x0c6f] has been reserved
[    0.682208] system 00:04: [io  0x0cd8-0x0cdf] has been reserved
[    0.682213] system 00:04: [io  0x0800-0x089f] has been reserved
[    0.682218] system 00:04: [io  0x0b00-0x0b0f] has been reserved
[    0.682223] system 00:04: [io  0x0b20-0x0b3f] has been reserved
[    0.682228] system 00:04: [io  0x0900-0x090f] has been reserved
[    0.682233] system 00:04: [io  0x0910-0x091f] has been reserved
[    0.682238] system 00:04: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.682244] system 00:04: [mem 0xfec01000-0xfec01fff] could not be reserved
[    0.682250] system 00:04: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    0.682255] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.682261] system 00:04: [mem 0xfed80000-0xfed8ffff] could not be reserved
[    0.682267] system 00:04: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.682272] system 00:04: [mem 0xff000000-0xffffffff] has been reserved
[    0.682823] pnp: PnP ACPI: found 5 devices
[    0.687864] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
[    0.687964] NET: Registered PF_INET protocol family
[    0.688145] IP idents hash table entries: 262144 (order: 9, 2097152
bytes, linear)
[    0.700729] tcp_listen_portaddr_hash hash table entries: 16384
(order: 6, 262144 bytes, linear)
[    0.700755] Table-perturb hash table entries: 65536 (order: 6,
262144 bytes, linear)
[    0.700891] TCP established hash table entries: 262144 (order: 9,
2097152 bytes, linear)
[    0.701159] TCP bind hash table entries: 65536 (order: 9, 2097152
bytes, linear)
[    0.701255] TCP: Hash tables configured (established 262144 bind 65536)
[    0.701366] MPTCP token hash table entries: 32768 (order: 7, 786432
bytes, linear)
[    0.701435] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.701502] UDP-Lite hash table entries: 16384 (order: 7, 524288
bytes, linear)
[    0.701593] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.701603] NET: Registered PF_XDP protocol family
[    0.701627] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.701644] pci 0000:02:08.0: PCI bridge to [bus 04]
[    0.701651] pci 0000:02:08.0:   bridge window [mem 0xfc400000-0xfc4fffff]
[    0.701664] pci 0000:02:09.0: PCI bridge to [bus 05]
[    0.701671] pci 0000:02:09.0:   bridge window [mem 0xfc200000-0xfc3fffff]
[    0.701683] pci 0000:01:00.2: PCI bridge to [bus 02-05]
[    0.701691] pci 0000:01:00.2:   bridge window [mem 0xfc200000-0xfc4fffff]
[    0.701703] pci 0000:00:01.2: PCI bridge to [bus 01-05]
[    0.701709] pci 0000:00:01.2:   bridge window [mem 0xfc200000-0xfc5fffff]
[    0.701720] pci 0000:00:03.1: PCI bridge to [bus 06]
[    0.701725] pci 0000:00:03.1:   bridge window [io  0xf000-0xffff]
[    0.701732] pci 0000:00:03.1:   bridge window [mem 0xfb000000-0xfc0fffff]
[    0.701738] pci 0000:00:03.1:   bridge window [mem
0xd0000000-0xe20fffff 64bit pref]
[    0.701747] pci 0000:00:07.1: PCI bridge to [bus 07]
[    0.701757] pci 0000:00:08.1: PCI bridge to [bus 08]
[    0.701763] pci 0000:00:08.1:   bridge window [mem 0xfc600000-0xfc8fffff]
[    0.701772] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.701777] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.701782] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.701787] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.701791] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff window]
[    0.701797] pci_bus 0000:00: resource 9 [mem 0xd0000000-0xfec2ffff window]
[    0.701802] pci_bus 0000:00: resource 10 [mem 0xfee00000-0xffffffff window]
[    0.701807] pci_bus 0000:01: resource 1 [mem 0xfc200000-0xfc5fffff]
[    0.701812] pci_bus 0000:02: resource 1 [mem 0xfc200000-0xfc4fffff]
[    0.701817] pci_bus 0000:04: resource 1 [mem 0xfc400000-0xfc4fffff]
[    0.701822] pci_bus 0000:05: resource 1 [mem 0xfc200000-0xfc3fffff]
[    0.701827] pci_bus 0000:06: resource 0 [io  0xf000-0xffff]
[    0.701831] pci_bus 0000:06: resource 1 [mem 0xfb000000-0xfc0fffff]
[    0.701836] pci_bus 0000:06: resource 2 [mem 0xd0000000-0xe20fffff
64bit pref]
[    0.701842] pci_bus 0000:08: resource 1 [mem 0xfc600000-0xfc8fffff]
[    0.702106] pci 0000:06:00.1: extending delay after power-on from
D3hot to 20 msec
[    0.702143] pci 0000:06:00.1: D0 power state depends on 0000:06:00.0
[    0.702236] pci 0000:06:00.2: D0 power state depends on 0000:06:00.0
[    0.702378] pci 0000:06:00.3: D0 power state depends on 0000:06:00.0
[    0.702508] PCI: CLS 64 bytes, default 64
[    0.702521] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
[    0.702565] Trying to unpack rootfs image as initramfs...
[    0.702576] pci 0000:00:01.0: Adding to iommu group 0
[    0.702595] pci 0000:00:01.2: Adding to iommu group 1
[    0.702621] pci 0000:00:02.0: Adding to iommu group 2
[    0.702647] pci 0000:00:03.0: Adding to iommu group 3
[    0.702666] pci 0000:00:03.1: Adding to iommu group 4
[    0.702691] pci 0000:00:04.0: Adding to iommu group 5
[    0.702716] pci 0000:00:05.0: Adding to iommu group 6
[    0.702742] pci 0000:00:07.0: Adding to iommu group 7
[    0.702760] pci 0000:00:07.1: Adding to iommu group 8
[    0.702787] pci 0000:00:08.0: Adding to iommu group 9
[    0.702806] pci 0000:00:08.1: Adding to iommu group 10
[    0.702839] pci 0000:00:14.0: Adding to iommu group 11
[    0.702857] pci 0000:00:14.3: Adding to iommu group 11
[    0.702936] pci 0000:00:18.0: Adding to iommu group 12
[    0.702955] pci 0000:00:18.1: Adding to iommu group 12
[    0.702973] pci 0000:00:18.2: Adding to iommu group 12
[    0.702992] pci 0000:00:18.3: Adding to iommu group 12
[    0.703011] pci 0000:00:18.4: Adding to iommu group 12
[    0.703031] pci 0000:00:18.5: Adding to iommu group 12
[    0.703050] pci 0000:00:18.6: Adding to iommu group 12
[    0.703068] pci 0000:00:18.7: Adding to iommu group 12
[    0.703109] pci 0000:01:00.0: Adding to iommu group 13
[    0.703130] pci 0000:01:00.1: Adding to iommu group 13
[    0.703151] pci 0000:01:00.2: Adding to iommu group 13
[    0.703159] pci 0000:02:00.0: Adding to iommu group 13
[    0.703168] pci 0000:02:08.0: Adding to iommu group 13
[    0.703176] pci 0000:02:09.0: Adding to iommu group 13
[    0.703185] pci 0000:04:00.0: Adding to iommu group 13
[    0.703193] pci 0000:05:00.0: Adding to iommu group 13
[    0.703240] pci 0000:06:00.0: Adding to iommu group 14
[    0.703262] pci 0000:06:00.1: Adding to iommu group 14
[    0.703284] pci 0000:06:00.2: Adding to iommu group 14
[    0.703305] pci 0000:06:00.3: Adding to iommu group 14
[    0.703324] pci 0000:07:00.0: Adding to iommu group 15
[    0.703344] pci 0000:08:00.0: Adding to iommu group 16
[    0.703365] pci 0000:08:00.1: Adding to iommu group 17
[    0.703385] pci 0000:08:00.3: Adding to iommu group 18
[    0.703405] pci 0000:08:00.4: Adding to iommu group 19
[    0.706864] AMD-Vi: Extended features (0x58f77ef22294a5a, 0x0): PPR
NX GT IA PC GA_vAPIC
[    0.706882] AMD-Vi: Interrupt remapping enabled
[    0.707022] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.707027] software IO TLB: mapped [mem
0x00000000bce8f000-0x00000000c0e8f000] (64MB)
[    0.707078] LVT offset 0 assigned for vector 0x400
[    0.707243] perf: AMD IBS detected (0x000003ff)
[    0.713572] amd_uncore: 4 amd_df counters detected
[    0.713587] amd_uncore: 6 amd_l3 counters detected
[    0.713750] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[    0.714549] Initialise system trusted keyrings
[    0.714562] Key type blacklist registered
[    0.714630] workingset: timestamp_bits=36 max_order=23 bucket_order=0
[    0.714641] zbud: loaded
[    0.714736] fuse: init (API version 7.39)
[    0.714886] integrity: Platform Keyring initialized
[    0.714894] integrity: Machine keyring initialized
[    0.729904] Key type asymmetric registered
[    0.729910] Asymmetric key parser 'x509' registered
[    0.999672] Freeing initrd memory: 122396K
[    1.004099] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 246)
[    1.004150] io scheduler mq-deadline registered
[    1.006703] pcieport 0000:00:07.1: AER: enabled with IRQ 29
[    1.006856] pcieport 0000:00:08.1: AER: enabled with IRQ 30
[    1.007479] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.009830] Estimated ratio of average max frequency by base
frequency (times 1024): 1141
[    1.009847] Monitor-Mwait will be used to enter C-1 state
[    1.009854] ACPI: \_SB_.PLTF.C000: Found 2 idle states
[    1.009960] ACPI: \_SB_.PLTF.C002: Found 2 idle states
[    1.010055] ACPI: \_SB_.PLTF.C004: Found 2 idle states
[    1.010149] ACPI: \_SB_.PLTF.C006: Found 2 idle states
[    1.010287] ACPI: \_SB_.PLTF.C008: Found 2 idle states
[    1.010417] ACPI: \_SB_.PLTF.C00A: Found 2 idle states
[    1.010547] ACPI: \_SB_.PLTF.C00C: Found 2 idle states
[    1.010667] ACPI: \_SB_.PLTF.C00E: Found 2 idle states
[    1.010795] ACPI: \_SB_.PLTF.C010: Found 2 idle states
[    1.010915] ACPI: \_SB_.PLTF.C012: Found 2 idle states
[    1.011037] ACPI: \_SB_.PLTF.C014: Found 2 idle states
[    1.011157] ACPI: \_SB_.PLTF.C016: Found 2 idle states
[    1.011250] ACPI: \_SB_.PLTF.C001: Found 2 idle states
[    1.011341] ACPI: \_SB_.PLTF.C003: Found 2 idle states
[    1.011431] ACPI: \_SB_.PLTF.C005: Found 2 idle states
[    1.011561] ACPI: \_SB_.PLTF.C007: Found 2 idle states
[    1.011687] ACPI: \_SB_.PLTF.C009: Found 2 idle states
[    1.011820] ACPI: \_SB_.PLTF.C00B: Found 2 idle states
[    1.011947] ACPI: \_SB_.PLTF.C00D: Found 2 idle states
[    1.012074] ACPI: \_SB_.PLTF.C00F: Found 2 idle states
[    1.012193] ACPI: \_SB_.PLTF.C011: Found 2 idle states
[    1.012308] ACPI: \_SB_.PLTF.C013: Found 2 idle states
[    1.012429] ACPI: \_SB_.PLTF.C015: Found 2 idle states
[    1.012527] ACPI: \_SB_.PLTF.C017: Found 2 idle states
[    1.012790] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.012991] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud =
115200) is a 16550A
[    1.013417] Linux agpgart interface v0.103
[    1.073839] tpm_crb MSFT0101:00: Disabling hwrng
[    1.075936] i8042: PNP: No PS/2 controller found.
[    1.075990] mousedev: PS/2 mouse device common for all mice
[    1.076011] rtc_cmos 00:02: RTC can wake from S4
[    1.076252] rtc_cmos 00:02: registered as rtc0
[    1.076283] rtc_cmos 00:02: setting system clock to
2025-05-10T09:21:34 UTC (1746868894)
[    1.076315] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram
[    1.076328] amd_pstate: driver load is disabled, boot with specific
mode to enable this
[    1.076492] ledtrig-cpu: registered to indicate activity on CPUs
[    1.076789] efifb: probing for efifb
[    1.076801] efifb: framebuffer at 0xe1000000, using 8100k, total 8100k
[    1.076806] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    1.076811] efifb: scrolling: redraw
[    1.076814] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.079676] Console: switching to colour frame buffer device 240x67
[    1.082442] fb0: EFI VGA frame buffer device
[    1.082646] NET: Registered PF_INET6 protocol family
[    1.086166] Segment Routing with IPv6
[    1.086199] In-situ OAM (IOAM) with IPv6
[    1.086244] mip6: Mobile IPv6
[    1.086258] NET: Registered PF_PACKET protocol family
[    1.086308] mpls_gso: MPLS GSO support
[    1.087991] microcode: Current revision: 0x08701035
[    1.088431] resctrl: L3 allocation detected
[    1.088443] resctrl: MB allocation detected
[    1.088455] resctrl: L3 monitoring detected
[    1.088511] IPI shorthand broadcast: enabled
[    1.090605] sched_clock: Marking stable (776419874,
312525611)->(1332483004, -243537519)
[    1.090746] registered taskstats version 1
[    1.090949] Loading compiled-in X.509 certificates
[    1.104295] Loaded X.509 cert 'Build time autogenerated kernel key:
c6d27a1d1e3ec2bd5fdd1e1aef67999cb676a8de'
[    1.106564] Key type .fscrypt registered
[    1.106576] Key type fscrypt-provisioning registered
[    1.121229] Key type encrypted registered
[    1.121243] AppArmor: AppArmor sha256 policy hashing enabled
[    1.121337] integrity: Loading X.509 certificate: UEFI:db
[    1.121483] integrity: Loaded X.509 cert 'ASUSTeK MotherBoard SW
Key Certificate: da83b990422ebc8c441f8d8b039a65a2'
[    1.121510] integrity: Loading X.509 certificate: UEFI:db
[    1.121649] integrity: Loaded X.509 cert 'ASUSTeK Notebook SW Key
Certificate: b8e581e4df77a5bb4282d5ccfc00c071'
[    1.121675] integrity: Loading X.509 certificate: UEFI:db
[    1.121704] integrity: Loaded X.509 cert 'Microsoft Corporation
UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    1.121732] integrity: Loading X.509 certificate: UEFI:db
[    1.121760] integrity: Loaded X.509 cert 'Microsoft Windows
Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    1.121788] integrity: Loading X.509 certificate: UEFI:db
[    1.121930] integrity: Loaded X.509 cert 'Canonical Ltd. Master
Certificate Authority: ad91990bc22ab1f517048c23b6655a268e345a63'
[    1.123537] integrity: Loading X.509 certificate: UEFI:MokListRT
(MOKvar table)
[    1.123687] integrity: Loaded X.509 cert 'Debian Secure Boot CA:
6ccece7e4c6c0d1f6149f3dd27dfcc5cbb419ea1'
[    1.123712] integrity: Loading X.509 certificate: UEFI:MokListRT
(MOKvar table)
[    1.123856] integrity: Loaded X.509 cert 'DKMS module signing key:
XXXXXXXXXXXXX'
[    1.123882] integrity: Loading X.509 certificate: UEFI:MokListRT
(MOKvar table)
[    1.124284] integrity: Loaded X.509 cert 'Mikon kernel-avain: XXXXXXXXXXXXXX'
[    1.124312] ima: Allocated hash algorithm: sha256
[    1.254823] audit: type=1807 audit(1746868894.676:2):
action=measure func=KEXEC_KERNEL_CHECK res=1
[    1.254834] evm: Initialising EVM extended attributes:
[    1.254854] audit: type=1807 audit(1746868894.676:3):
action=measure func=MODULE_CHECK res=1
[    1.254868] evm: security.selinux
[    1.254902] evm: security.SMACK64 (disabled)
[    1.255629] evm: security.SMACK64EXEC (disabled)
[    1.256355] evm: security.SMACK64TRANSMUTE (disabled)
[    1.257073] evm: security.SMACK64MMAP (disabled)
[    1.257792] evm: security.apparmor
[    1.258502] evm: security.ima
[    1.259207] evm: security.capability
[    1.259900] evm: HMAC attrs: 0x1
[    1.365686] RAS: Correctable Errors collector initialized.
[    1.366447] Lockdown: swapper/0: hibernation is restricted; see man
kernel_lockdown.7
[    1.367219] clk: Disabling unused clocks
[    1.369290] Freeing unused decrypted memory: 2028K
[    1.370561] Freeing unused kernel image (initmem) memory: 4056K
[    1.371273] Write protecting the kernel read-only data: 28672k
[    1.372467] Freeing unused kernel image (rodata/data gap) memory: 1452K
[    1.429212] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.429924] Run /init as init process
[    1.430624]   with arguments:
[    1.430626]     /init
[    1.430627]     splash
[    1.430628]   with environment:
[    1.430629]     HOME=/
[    1.430630]     TERM=linux
[    1.430631]     BOOT_IMAGE=/boot/vmlinuz-6.8.12
[    1.578421] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.579212] ACPI: button: Power Button [PWRB]
[    1.580049] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    1.580838] ACPI: button: Power Button [PWRF]
[    1.670597] piix4_smbus 0000:00:14.0: SMBus Host Controller at
0xb00, revision 0
[    1.671333] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus
port selection
[    1.672119] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host
Controller at 0xb20
[    1.695136] Intel(R) 2.5G Ethernet Linux Driver
[    1.695858] Copyright(c) 2018 Intel Corporation.
[    1.696645] igc 0000:05:00.0: PCIe PTM not supported by PCIe bus/controller
[    1.732535] tsc: Refined TSC clocksource calibration: 3792.874 MHz
[    1.733299] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x6d5818a734c, max_idle_ns: 881590694765 ns
[    1.735773] clocksource: Switched to clocksource tsc
[    1.750032] SCSI subsystem initialized
[    1.750962] pps pps0: new PPS source ptp0
[    1.751762] igc 0000:05:00.0 (unnamed net_device) (uninitialized): PHC added
[    1.759362] ACPI: bus type USB registered
[    1.760162] usbcore: registered new interface driver usbfs
[    1.760944] usbcore: registered new interface driver hub
[    1.761720] usbcore: registered new device driver usb
[    1.779847] igc 0000:05:00.0: 4.000 Gb/s available PCIe bandwidth
(5.0 GT/s PCIe x1 link)
[    1.780627] igc 0000:05:00.0 eth0: MAC: d4:5d:64:d7:c3:fe
[    1.782904] igc 0000:05:00.0 enp5s0: renamed from eth0
[    1.789810] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    1.790620] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO address
[    1.791446] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec (nowayout=0)
[    1.799945] libata version 3.00 loaded.
[    1.831573] ahci 0000:01:00.1: version 3.0
[    1.831704] ahci 0000:01:00.1: SSS flag set, parallel bus scan disabled
[    1.832509] ahci 0000:01:00.1: AHCI 0001.0301 32 slots 6 ports 6
Gbps 0x3f impl SATA mode
[    1.833267] ahci 0000:01:00.1: flags: 64bit ncq sntf stag pm led
clo only pmp pio slum part sxs deso sadm sds apst
[    1.834630] scsi host0: ahci
[    1.835514] scsi host1: ahci
[    1.836350] scsi host2: ahci
[    1.837180] scsi host3: ahci
[    1.837989] scsi host4: ahci
[    1.838784] scsi host5: ahci
[    1.839502] ata1: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580100 irq 42 lpm-pol 0
[    1.840186] ata2: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580180 irq 42 lpm-pol 0
[    1.840859] ata3: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580200 irq 42 lpm-pol 0
[    1.841516] ata4: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580280 irq 42 lpm-pol 0
[    1.842166] ata5: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580300 irq 42 lpm-pol 0
[    1.842804] ata6: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580380 irq 42 lpm-pol 0
[    2.155551] ata1: SATA link down (SStatus 0 SControl 330)
[    2.470804] ata2: SATA link down (SStatus 0 SControl 330)
[    2.948978] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.952213] ata3.00: ATA-8: WDC WD5000AAKX-001CA0, 15.01H15, max UDMA/133
[    2.953361] ata3.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    2.956001] ata3.00: configured for UDMA/133
[    2.956791] scsi 2:0:0:0: Direct-Access     ATA      WDC
WD5000AAKX-0 1H15 PQ: 0 ANSI: 5
[    3.432979] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.434764] ata4.00: ATAPI: TSSTcorp CDDVDW SH-S223F, SB03, max UDMA/100
[    3.436324] ata4.00: configured for UDMA/100
[    3.437926] scsi 3:0:0:0: CD-ROM            TSSTcorp CDDVDW
SH-S223F  SB03 PQ: 0 ANSI: 5
[    3.948978] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.950806] ata5.00: ATA-10: WDC WD20EFAX-68FB5N0, 82.00A82, max UDMA/133
[    3.963489] ata5.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    3.964157] ata5.00: Features: NCQ-prio
[    3.978635] ata5.00: configured for UDMA/133
[    3.979616] scsi 4:0:0:0: Direct-Access     ATA      WDC
WD20EFAX-68F 0A82 PQ: 0 ANSI: 5
[    4.456980] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    4.458896] ata6.00: ATA-10: WDC WD20EFAX-68FB5N0, 82.00A82, max UDMA/133
[    4.471776] ata6.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    4.472575] ata6.00: Features: NCQ-prio
[    4.486840] ata6.00: configured for UDMA/133
[    4.487813] scsi 5:0:0:0: Direct-Access     ATA      WDC
WD20EFAX-68F 0A82 PQ: 0 ANSI: 5
[    4.516070] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    4.516731] xhci_hcd 0000:01:00.0: new USB bus registered, assigned
bus number 1
[    4.558051] sd 2:0:0:0: [sdb] 976773168 512-byte logical blocks:
(500 GB/466 GiB)
[    4.558064] sd 4:0:0:0: [sda] 3907029168 512-byte logical blocks:
(2.00 TB/1.82 TiB)
[    4.558116] sd 5:0:0:0: [sdc] 3907029168 512-byte logical blocks:
(2.00 TB/1.82 TiB)
[    4.558120] sd 5:0:0:0: [sdc] 4096-byte physical blocks
[    4.558137] sd 5:0:0:0: [sdc] Write Protect is off
[    4.558139] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    4.558159] sd 5:0:0:0: [sdc] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    4.558184] sd 5:0:0:0: [sdc] Preferred minimum I/O size 4096 bytes
[    4.558732] sd 2:0:0:0: [sdb] Write Protect is off
[    4.559408] sd 4:0:0:0: [sda] 4096-byte physical blocks
[    4.560037] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    4.560675] sd 4:0:0:0: [sda] Write Protect is off
[    4.561292] sd 2:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    4.561900] sd 4:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.562539] sd 2:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
[    4.563143] sd 4:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    4.566177] sd 4:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
[    4.572836] xhci_hcd 0000:01:00.0: hcc params 0x0200ef81 hci
version 0x110 quirks 0x0000000000000410
[    4.573782] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    4.574398] xhci_hcd 0000:01:00.0: new USB bus registered, assigned
bus number 2
[    4.575016] xhci_hcd 0000:01:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[    4.575692] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 6.08
[    4.576320] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    4.576956] usb usb1: Product: xHCI Host Controller
[    4.577580] usb usb1: Manufacturer: Linux 6.8.12 xhci-hcd
[    4.578200] usb usb1: SerialNumber: 0000:01:00.0
[    4.578991] hub 1-0:1.0: USB hub found
[    4.579619] hub 1-0:1.0: 10 ports detected
[    4.588926]  sdc: sdc1 sdc2 sdc3 sdc4
[    4.589725] sd 5:0:0:0: [sdc] Attached SCSI disk
[    4.591703] usb usb2: We don't know the algorithms for LPM for this
host, disabling LPM.
[    4.592337] usb usb2: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 6.08
[    4.592968] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    4.593574] usb usb2: Product: xHCI Host Controller
[    4.594181] usb usb2: Manufacturer: Linux 6.8.12 xhci-hcd
[    4.594792] usb usb2: SerialNumber: 0000:01:00.0
[    4.595912] hub 2-0:1.0: USB hub found
[    4.596538] hub 2-0:1.0: 4 ports detected
[    4.602276] xhci_hcd 0000:06:00.2: xHCI Host Controller
[    4.602894] xhci_hcd 0000:06:00.2: new USB bus registered, assigned
bus number 3
[    4.604123] xhci_hcd 0000:06:00.2: hcc params 0x0180ff05 hci
version 0x110 quirks 0x0000000000000010
[    4.604908] xhci_hcd 0000:06:00.2: xHCI Host Controller
[    4.605546] xhci_hcd 0000:06:00.2: new USB bus registered, assigned
bus number 4
[    4.606193] xhci_hcd 0000:06:00.2: Host supports USB 3.1 Enhanced SuperSpeed
[    4.606885] usb usb3: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 6.08
[    4.607541] usb usb3: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    4.608201] usb usb3: Product: xHCI Host Controller
[    4.608861] usb usb3: Manufacturer: Linux 6.8.12 xhci-hcd
[    4.609515] usb usb3: SerialNumber: 0000:06:00.2
[    4.610958] hub 3-0:1.0: USB hub found
[    4.611609] hub 3-0:1.0: 2 ports detected
[    4.612344] usb usb4: We don't know the algorithms for LPM for this
host, disabling LPM.
[    4.613077] usb usb4: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 6.08
[    4.613727] usb usb4: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    4.614373] usb usb4: Product: xHCI Host Controller
[    4.615011] usb usb4: Manufacturer: Linux 6.8.12 xhci-hcd
[    4.615644] usb usb4: SerialNumber: 0000:06:00.2
[    4.616835] hub 4-0:1.0: USB hub found
[    4.617465] hub 4-0:1.0: 4 ports detected
[    4.618278] xhci_hcd 0000:08:00.3: xHCI Host Controller
[    4.618902] xhci_hcd 0000:08:00.3: new USB bus registered, assigned
bus number 5
[    4.619623] xhci_hcd 0000:08:00.3: hcc params 0x0278ffe5 hci
version 0x110 quirks 0x0000000000000410
[    4.620497] xhci_hcd 0000:08:00.3: xHCI Host Controller
[    4.621120] xhci_hcd 0000:08:00.3: new USB bus registered, assigned
bus number 6
[    4.621611]  sdb: sdb1 sdb2 sdb3 sdb4
[    4.621741] xhci_hcd 0000:08:00.3: Host supports USB 3.1 Enhanced SuperSpeed
[    4.622547] sd 2:0:0:0: [sdb] Attached SCSI disk
[    4.623008] usb usb5: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 6.08
[    4.624231] usb usb5: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    4.624865] usb usb5: Product: xHCI Host Controller
[    4.625486] usb usb5: Manufacturer: Linux 6.8.12 xhci-hcd
[    4.626107] usb usb5: SerialNumber: 0000:08:00.3
[    4.627313] hub 5-0:1.0: USB hub found
[    4.627937] hub 5-0:1.0: 4 ports detected
[    4.628753] usb usb6: We don't know the algorithms for LPM for this
host, disabling LPM.
[    4.629402] usb usb6: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 6.08
[    4.630033] usb usb6: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    4.630664] usb usb6: Product: xHCI Host Controller
[    4.631293] usb usb6: Manufacturer: Linux 6.8.12 xhci-hcd
[    4.631926] usb usb6: SerialNumber: 0000:08:00.3
[    4.633018] hub 6-0:1.0: USB hub found
[    4.633644] hub 6-0:1.0: 4 ports detected
[    4.666787] sr 3:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer
dvd-ram cd/rw xa/form2 cdda tray
[    4.667427] cdrom: Uniform CD-ROM driver Revision: 3.20
[    4.709348] sr 3:0:0:0: Attached scsi CD-ROM sr0
[    4.792493]  sda: sda1 sda2 sda3 sda4
[    4.793329] sd 4:0:0:0: [sda] Attached SCSI disk
[    4.884536] usb 5-4: new high-speed USB device number 2 using xhci_hcd
[    4.916535] usb 1-5: new full-speed USB device number 2 using xhci_hcd
[    5.039519] usb 5-4: New USB device found, idVendor=05e3,
idProduct=0608, bcdDevice=77.63
[    5.040135] usb 5-4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    5.040750] usb 5-4: Product: USB2.0 Hub
[    5.103443] hub 5-4:1.0: USB hub found
[    5.104510] hub 5-4:1.0: 4 ports detected
[    5.261201] usb 1-5: New USB device found, idVendor=8087,
idProduct=0029, bcdDevice= 0.01
[    5.261825] usb 1-5: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    5.296883] md/raid1:md1: active with 2 out of 2 mirrors
[    5.297542] md1: detected capacity change from 0 to 195178496
[    5.333612] md/raid1:md0: active with 2 out of 2 mirrors
[    5.334264] md0: detected capacity change from 0 to 39026688
[    5.384543] md/raid1:md2: active with 2 out of 2 mirrors
[    5.392534] usb 5-4.4: new full-speed USB device number 3 using xhci_hcd
[    5.472537] usb 1-6: new full-speed USB device number 3 using xhci_hcd
[    5.487720] md2: detected capacity change from 0 to 3671392256
[    5.512029] usb 5-4.4: New USB device found, idVendor=046d,
idProduct=c52b, bcdDevice=12.10
[    5.512689] usb 5-4.4: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[    5.513339] usb 5-4.4: Product: USB Receiver
[    5.513975] usb 5-4.4: Manufacturer: Logitech
[    5.644443] hid: raw HID events driver (C) Jiri Kosina
[    5.674158] usbcore: registered new interface driver usbhid
[    5.674811] usbhid: USB HID core driver
[    5.690048] input: Logitech USB Receiver as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.0/0003:046D:C52B.0001/input/input2
[    5.748704] hid-generic 0003:046D:C52B.0001: input,hidraw0: USB HID
v1.11 Keyboard [Logitech USB Receiver] on usb-0000:08:00.3-4.4/input0
[    5.749595] input: Logitech USB Receiver Mouse as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.1/0003:046D:C52B.0002/input/input3
[    5.750372] input: Logitech USB Receiver Consumer Control as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.1/0003:046D:C52B.0002/input/input4
[    5.808752] input: Logitech USB Receiver System Control as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.1/0003:046D:C52B.0002/input/input5
[    5.809575] hid-generic 0003:046D:C52B.0002: input,hiddev0,hidraw1:
USB HID v1.11 Mouse [Logitech USB Receiver] on
usb-0000:08:00.3-4.4/input1
[    5.810452] hid-generic 0003:046D:C52B.0003: hiddev1,hidraw2: USB
HID v1.11 Device [Logitech USB Receiver] on
usb-0000:08:00.3-4.4/input2
[    5.857392] usb 1-6: config 1 has an invalid interface number: 2 but max is 1
[    5.858155] usb 1-6: config 1 has no interface number 1
[    5.869957] usb 1-6: New USB device found, idVendor=0b05,
idProduct=1939, bcdDevice= 1.00
[    5.870697] usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    5.871433] usb 1-6: Product: AURA LED Controller
[    5.872166] usb 1-6: Manufacturer: AsusTek Computer Inc.
[    5.872905] usb 1-6: SerialNumber: 9876543210
[    5.889151] hid-generic 0003:0B05:1939.0004: hiddev2,hidraw3: USB
HID v1.11 Device [AsusTek Computer Inc. AURA LED Controller] on
usb-0000:01:00.0-6/input2
[    6.021139] logitech-djreceiver 0003:046D:C52B.0003:
hiddev0,hidraw0: USB HID v1.11 Device [Logitech USB Receiver] on
usb-0000:08:00.3-4.4/input2
[    6.084975] usb 1-7: new high-speed USB device number 4 using xhci_hcd
[    6.143610] input: Logitech Wireless Device PID:4050 Keyboard as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.2/0003:046D:C52B.0003/0003:046D:4050.0005/input/input7
[    6.144776] input: Logitech Wireless Device PID:4050 Mouse as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.2/0003:046D:C52B.0003/0003:046D:4050.0005/input/input8
[    6.145777] hid-generic 0003:046D:4050.0005: input,hidraw1: USB HID
v1.11 Keyboard [Logitech Wireless Device PID:4050] on
usb-0000:08:00.3-4.4/input2:1
[    6.146993] input: Logitech Wireless Device PID:4003 Keyboard as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.2/0003:046D:C52B.0003/0003:046D:4003.0006/input/input12
[    6.148017] hid-generic 0003:046D:4003.0006: input,hidraw2: USB HID
v1.11 Keyboard [Logitech Wireless Device PID:4003] on
usb-0000:08:00.3-4.4/input2:2
[    6.260496] usb 1-7: New USB device found, idVendor=05e3,
idProduct=0610, bcdDevice=60.60
[    6.261426] usb 1-7: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    6.262321] usb 1-7: Product: USB2.0 Hub
[    6.272953] hub 1-7:1.0: USB hub found
[    6.277886] hub 1-7:1.0: 4 ports detected
[    6.379346] input: Logitech M335 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.2/0003:046D:C52B.0003/0003:046D:4050.0005/input/input16
[    6.380427] logitech-hidpp-device 0003:046D:4050.0005:
input,hidraw1: USB HID v1.11 Keyboard [Logitech M335] on
usb-0000:08:00.3-4.4/input2:1
[    6.527986] input: Logitech K270 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.2/0003:046D:C52B.0003/0003:046D:4003.0006/input/input17
[    6.529158] logitech-hidpp-device 0003:046D:4003.0006:
input,hidraw2: USB HID v1.11 Keyboard [Logitech K270] on
usb-0000:08:00.3-4.4/input2:2
[   11.692528] raid6: avx2x4   gen() 38004 MB/s
[   11.760528] raid6: avx2x2   gen() 35417 MB/s
[   11.828528] raid6: avx2x1   gen() 32014 MB/s
[   11.829490] raid6: using algorithm avx2x4 gen() 38004 MB/s
[   11.896528] raid6: .... xor() 9538 MB/s, rmw enabled
[   11.897494] raid6: using avx2x2 recovery algorithm
[   11.909933] xor: automatically using best checksumming function   avx
[   11.925601] async_tx: api initialized (async)
[   44.537140] EXT4-fs (md1): mounted filesystem
c056bf20-f617-4c4a-8d3c-28ac04ff6a3a ro with ordered data mode. Quota
mode: none.
[   45.387033] Not activating Mandatory Access Control as
/sbin/tomoyo-init does not exist.
[   49.296662] systemd[1]: Inserted module 'autofs4'
[   49.673268] systemd[1]: systemd 257.5-2 running in system mode
(+PAM +AUDIT +SELINUX +APPARMOR +IMA +IPE +SMACK +SECCOMP +GCRYPT
-GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC
+KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2
+PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD
+BPF_FRAMEWORK +BTF -XKBCOMMON -UTMP +SYSVINIT +LIBARCHIVE)
[   49.673275] systemd[1]: Detected architecture x86-64.
[   49.827332] systemd[1]: Hostname set to <taavi>.
[   49.828727] Lockdown: systemd: /dev/mem,kmem,port is restricted;
see man kernel_lockdown.7
[   50.416628] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[   55.575212] systemd[1]: Queued start job for default target graphical.target.
[   55.678609] systemd[1]: Created slice system-getty.slice - Slice
/system/getty.
[   55.679120] systemd[1]: Created slice system-modprobe.slice - Slice
/system/modprobe.
[   55.679578] systemd[1]: Created slice system-postgresql.slice -
Slice /system/postgresql.
[   55.680042] systemd[1]: Created slice
system-systemd\x2dcryptsetup.slice - Encrypted Volume Units Service
Slice.
[   55.680506] systemd[1]: Created slice system-systemd\x2dfsck.slice
- Slice /system/systemd-fsck.
[   55.680974] systemd[1]: Created slice system-wg\x2dquick.slice -
Slice /system/wg-quick.
[   55.681328] systemd[1]: Created slice user.slice - User and Session Slice.
[   55.681398] systemd[1]: Started systemd-ask-password-wall.path -
Forward Password Requests to Wall Directory Watch.
[   55.681545] systemd[1]: Set up automount
proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats
File System Automount Point.
[   55.681574] systemd[1]: Expecting device
dev-disk-by\x2duuid-9F4E\x2d5291.device -
/dev/disk/by-uuid/9F4E-5291...
[   55.681589] systemd[1]: Expecting device
dev-disk-by\x2duuid-d60e5f36\x2d66b8\x2d4bd5\x2dae74\x2d0e1e32fde8bb.device
- /dev/disk/by-uuid/d60e5f36-66b8-4bd5-ae74-0e1e32fde8bb...
[   55.681604] systemd[1]: Expecting device
dev-mapper-crypthome.device - /dev/mapper/crypthome...
[   55.681617] systemd[1]: Expecting device
dev-mapper-cryptswap.device - /dev/mapper/cryptswap...
[   55.681630] systemd[1]: Expecting device dev-md0.device - /dev/md0...
[   55.681652] systemd[1]: Reached target integritysetup.target -
Local Integrity Protected Volumes.
[   55.681681] systemd[1]: Reached target nss-lookup.target - Host and
Network Name Lookups.
[   55.681699] systemd[1]: Reached target nss-user-lookup.target -
User and Group Name Lookups.
[   55.681717] systemd[1]: Reached target remote-fs.target - Remote
File Systems.
[   55.681733] systemd[1]: Reached target slices.target - Slice Units.
[   55.681750] systemd[1]: Reached target snapd.mounts-pre.target -
Mounting snaps.
[   55.681779] systemd[1]: Reached target veritysetup.target - Local
Verity Protected Volumes.
[   55.681873] systemd[1]: Listening on syslog.socket - Syslog Socket.
[   55.718514] systemd[1]: Listening on systemd-coredump.socket -
Process Core Dump Socket.
[   55.719100] systemd[1]: Listening on systemd-creds.socket -
Credential Encryption/Decryption.
[   55.719171] systemd[1]: Listening on systemd-initctl.socket -
initctl Compatibility Named Pipe.
[   55.719235] systemd[1]: Listening on
systemd-journald-dev-log.socket - Journal Socket (/dev/log).
[   55.719312] systemd[1]: Listening on systemd-journald.socket -
Journal Sockets.
[   55.719355] systemd[1]: systemd-pcrextend.socket - TPM PCR
Measurements was skipped because of an unmet condition check
(ConditionSecurity=measured-uki).
[   55.719367] systemd[1]: systemd-pcrlock.socket - Make TPM PCR
Policy was skipped because of an unmet condition check
(ConditionSecurity=measured-uki).
[   55.719425] systemd[1]: Listening on systemd-udevd-control.socket -
udev Control Socket.
[   55.719483] systemd[1]: Listening on systemd-udevd-kernel.socket -
udev Kernel Socket.
[   55.735882] systemd[1]: Mounting dev-hugepages.mount - Huge Pages
File System...
[   55.736772] systemd[1]: Mounting dev-mqueue.mount - POSIX Message
Queue File System...
[   55.737551] systemd[1]: Mounting run-lock.mount - Legacy Locks
Directory /run/lock...
[   55.738349] systemd[1]: Mounting sys-kernel-debug.mount - Kernel
Debug File System...
[   55.739056] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel
Trace File System...
[   55.756244] systemd[1]: Starting keyboard-setup.service - Set the
console keyboard layout...
[   55.757084] systemd[1]: Starting kmod-static-nodes.service - Create
List of Static Device Nodes...
[   55.757807] systemd[1]: Starting modprobe@configfs.service - Load
Kernel Module configfs...
[   55.758540] systemd[1]: Starting modprobe@drm.service - Load Kernel
Module drm...
[   55.759231] systemd[1]: Starting modprobe@efi_pstore.service - Load
Kernel Module efi_pstore...
[   55.759966] systemd[1]: Starting modprobe@fuse.service - Load
Kernel Module fuse...
[   55.760747] systemd[1]: Starting nftables.service - nftables...
[   55.760892] systemd[1]: systemd-fsck-root.service - File System
Check on Root Device was skipped because of an unmet condition check
(ConditionPathExists=!/run/initramfs/fsck-root).
[   55.760928] systemd[1]: systemd-hibernate-clear.service - Clear
Stale Hibernate Storage Info was skipped because of an unmet condition
check (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[   55.789521] systemd[1]: Starting systemd-journald.service - Journal
Service...
[   55.798648] systemd[1]: Starting systemd-modules-load.service -
Load Kernel Modules...
[   55.798678] systemd[1]: systemd-pcrmachine.service - TPM PCR
Machine ID Measurement was skipped because of an unmet condition check
(ConditionSecurity=measured-uki).
[   55.799475] systemd[1]: Starting systemd-remount-fs.service -
Remount Root and Kernel File Systems...
[   55.799519] systemd[1]: systemd-tpm2-setup-early.service - Early
TPM SRK Setup was skipped because of an unmet condition check
(ConditionSecurity=measured-uki).
[   55.800290] systemd[1]: Starting
systemd-udev-load-credentials.service - Load udev Rules from
Credentials...
[   55.801051] systemd[1]: Starting systemd-udev-trigger.service -
Coldplug All udev Devices...
[   55.964845] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[   55.965049] systemd[1]: Finished modprobe@fuse.service - Load
Kernel Module fuse.
[   55.965945] systemd[1]: Mounting sys-fs-fuse-connections.mount -
FUSE Control File System...
[   56.114924] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
[   56.115325] systemd[1]: Mounted dev-mqueue.mount - POSIX Message
Queue File System.
[   56.115425] systemd[1]: Mounted run-lock.mount - Legacy Locks
Directory /run/lock.
[   56.115512] systemd[1]: Mounted sys-kernel-debug.mount - Kernel
Debug File System.
[   56.115599] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel
Trace File System.
[   56.115683] systemd[1]: Mounted sys-fs-fuse-connections.mount -
FUSE Control File System.
[   56.133462] systemd[1]: modprobe@configfs.service: Deactivated successfully.
[   56.133631] systemd[1]: Finished modprobe@configfs.service - Load
Kernel Module configfs.
[   56.178892] systemd[1]: Finished kmod-static-nodes.service - Create
List of Static Device Nodes.
[   56.179915] systemd[1]: Starting
systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes
in /dev gracefully...
[   56.475100] EXT4-fs (md1): re-mounted
c056bf20-f617-4c4a-8d3c-28ac04ff6a3a r/w. Quota mode: none.
[   56.476273] systemd[1]: Finished systemd-remount-fs.service -
Remount Root and Kernel File Systems.
[   56.487690] systemd-journald[990]: Collecting audit messages is disabled.
[   56.494735] systemd[1]: systemd-hwdb-update.service - Rebuild
Hardware Database was skipped because of an unmet condition check
(ConditionNeedsUpdate=/etc).
[   56.495620] systemd[1]: Starting systemd-random-seed.service -
Load/Save OS Random Seed...
[   56.495644] systemd[1]: systemd-tpm2-setup.service - TPM SRK Setup
was skipped because of an unmet condition check
(ConditionSecurity=measured-uki).
[   56.520205] ACPI: bus type drm_connector registered
[   56.521234] systemd[1]: modprobe@drm.service: Deactivated successfully.
[   56.544748] systemd[1]: Finished modprobe@drm.service - Load Kernel
Module drm.
[   56.545699] systemd[1]: Finished
systemd-udev-load-credentials.service - Load udev Rules from
Credentials.
[   56.558865] systemd[1]: Started systemd-journald.service - Journal Service.
[   56.573658] systemd-journald[990]: Received client request to flush
runtime journal.
[   56.601744] pstore: Using crash dump compression: deflate
[   56.602956] pstore: Registered efi_pstore as persistent store backend
[   56.831685] lp: driver loaded but no devices found
[   56.955955] ppdev: user-space parallel port driver
[   57.519638] nct6775: Found NCT6798D or compatible chip at 0x2e:0x290
[   58.106083] loop: module loaded
[   58.106584] loop0: detected capacity change from 0 to 433128
[   58.106650] loop1: detected capacity change from 0 to 135624
[   58.106804] loop2: detected capacity change from 0 to 113384
[   58.106859] loop3: detected capacity change from 0 to 1034424
[   58.106931] loop4: detected capacity change from 0 to 1056784
[   58.107011] loop5: detected capacity change from 0 to 494688
[   58.107105] loop6: detected capacity change from 0 to 337560
[   58.107236] loop7: detected capacity change from 0 to 827600
[   58.109118] loop9: detected capacity change from 0 to 113384
[   58.109849] loop18: detected capacity change from 0 to 828160
[   58.110062] loop20: detected capacity change from 0 to 137568
[   58.110064] loop13: detected capacity change from 0 to 716168
[   58.110262] loop15: detected capacity change from 0 to 151320
[   58.110265] loop12: detected capacity change from 0 to 75960
[   58.110311] loop10: detected capacity change from 0 to 337560
[   58.110367] loop11: detected capacity change from 0 to 424736
[   58.110479] loop16: detected capacity change from 0 to 136728
[   58.110544] loop23: detected capacity change from 0 to 367448
[   58.110631] loop14: detected capacity change from 0 to 151328
[   58.110742] loop24: detected capacity change from 0 to 130568
[   58.110802] loop22: detected capacity change from 0 to 8
[   58.110802] loop21: detected capacity change from 0 to 367608
[   58.110870] loop25: detected capacity change from 0 to 495608
[   58.110930] loop19: detected capacity change from 0 to 104232
[   58.110930] loop17: detected capacity change from 0 to 187776
[   58.111035] loop26: detected capacity change from 0 to 140080
[   58.111137] loop8: detected capacity change from 0 to 716176
[   58.112411] loop27: detected capacity change from 0 to 130600
[   58.148443] loop28: detected capacity change from 0 to 166424
[   58.165308] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   58.692810] loop29: detected capacity change from 0 to 91024
[   60.737749] input: PC Speaker as /devices/platform/pcspkr/input/input18
[   60.798940] acpi_cpufreq: overriding BIOS provided _PSD data
[   60.823256] nvidia: loading out-of-tree module taints kernel.
[   60.823268] nvidia: module license 'NVIDIA' taints kernel.
[   60.823270] Disabling lock debugging due to kernel taint
[   60.823274] nvidia: module license taints kernel.
[   61.318454] ccp 0000:08:00.1: enabling device (0000 -> 0002)
[   61.318623] ccp 0000:08:00.1: ccp: unable to access the device: you
might be running a broken BIOS.
[   61.318650] ccp 0000:08:00.1: psp enabled
[   61.319625] sd 2:0:0:0: Attached scsi generic sg0 type 0
[   61.319666] sr 3:0:0:0: Attached scsi generic sg1 type 5
[   61.319703] sd 4:0:0:0: Attached scsi generic sg2 type 0
[   61.319747] sd 5:0:0:0: Attached scsi generic sg3 type 0
[   61.319814] nvidia-nvlink: Nvlink Core is being initialized, major
device number 242

[   61.321046] nvidia 0000:06:00.0: vgaarb: VGA decodes changed:
olddecodes=io+mem,decodes=none:owns=io+mem
[   61.366307] NVRM: loading NVIDIA UNIX x86_64 Kernel Module
545.29.06  Thu Nov 16 01:59:08 UTC 2023
[   61.366497] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters,
163840 ms ovfl timer
[   61.366502] RAPL PMU: hw unit of domain package 2^-16 Joules
[   62.687046] nvidia-modeset: Loading NVIDIA Kernel Mode Setting
Driver for UNIX platforms  545.29.06  Thu Nov 16 01:47:29 UTC 2023
[   62.710887] cryptd: max_cpu_qlen set to 1000
[   62.981929] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[   62.982068] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   62.982193] Loaded X.509 cert 'wens:
61c038651aabdcf94bd0ac7ff06c7248db18c600'
[   63.006904] Bluetooth: Core ver 2.22
[   63.006927] NET: Registered PF_BLUETOOTH protocol family
[   63.006929] Bluetooth: HCI device and connection manager initialized
[   63.006933] Bluetooth: HCI socket layer initialized
[   63.006936] Bluetooth: L2CAP socket layer initialized
[   63.006940] Bluetooth: SCO socket layer initialized
[   63.152286] asus_wmi: ASUS WMI generic driver loaded
[   63.214314] asus_wmi: Initialization: 0x0
[   63.214350] asus_wmi: BIOS WMI version: 0.9
[   63.214546] asus_wmi: SFUN value: 0x0
[   63.214550] eeepc-wmi eeepc-wmi: Detected ASUSWMI, use DCTS
[   63.216510] input: Eee PC WMI hotkeys as
/devices/platform/eeepc-wmi/input/input19
[   63.340222] Error: Driver 'pcspkr' is already registered, aborting...
[   63.398028] AVX2 version of gcm_enc/dec engaged.
[   63.403583] AES CTR mode by8 optimization enabled
[   63.432624] Intel(R) Wireless WiFi driver for Linux
[   63.432713] iwlwifi 0000:04:00.0: enabling device (0000 -> 0002)
[   63.434913] usbcore: registered new interface driver btusb
[   63.436508] iwlwifi 0000:04:00.0: Detected crf-id 0x3617, cnv-id
0x100530 wfpm id 0x80000000
[   63.436516] iwlwifi 0000:04:00.0: PCI dev 2723/0084, rev=0x340, rfid=0x10a100
[   63.760599] snd_hda_intel 0000:06:00.1: Disabling MSI
[   63.760612] snd_hda_intel 0000:06:00.1: Handle vga_switcheroo audio client
[   63.760653] snd_hda_intel 0000:08:00.4: enabling device (0000 -> 0002)
[   63.767211] cfg80211: loaded regulatory.db is malformed or
signature is missing/invalid
[   63.902362] input: HDA NVidia HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:03.1/0000:06:00.1/sound/card0/input20
[   63.902501] input: HDA NVidia HDMI/DP,pcm=7 as
/devices/pci0000:00/0000:00:03.1/0000:06:00.1/sound/card0/input21
[   63.902620] input: HDA NVidia HDMI/DP,pcm=8 as
/devices/pci0000:00/0000:00:03.1/0000:06:00.1/sound/card0/input22
[   63.902737] input: HDA NVidia HDMI/DP,pcm=9 as
/devices/pci0000:00/0000:00:03.1/0000:06:00.1/sound/card0/input23
[   63.917344] snd_hda_codec_realtek hdaudioC1D0: autoconfig for
ALC1220: line_outs=3 (0x14/0x15/0x16/0x0/0x0) type:line
[   63.917350] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
[   63.917352] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1
(0x1b/0x0/0x0/0x0/0x0)
[   63.917355] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
[   63.917357] snd_hda_codec_realtek hdaudioC1D0:    dig-out=0x1e/0x0
[   63.917359] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[   63.917361] snd_hda_codec_realtek hdaudioC1D0:      Front Mic=0x19
[   63.917364] snd_hda_codec_realtek hdaudioC1D0:      Rear Mic=0x18
[   63.917366] snd_hda_codec_realtek hdaudioC1D0:      Line=0x1a
[   63.930770] input: HD-Audio Generic Front Mic as
/devices/pci0000:00/0000:00:08.1/0000:08:00.4/sound/card1/input24
[   63.930900] input: HD-Audio Generic Rear Mic as
/devices/pci0000:00/0000:00:08.1/0000:08:00.4/sound/card1/input25
[   63.931025] input: HD-Audio Generic Line as
/devices/pci0000:00/0000:00:08.1/0000:08:00.4/sound/card1/input26
[   63.931140] input: HD-Audio Generic Line Out Front as
/devices/pci0000:00/0000:00:08.1/0000:08:00.4/sound/card1/input27
[   63.931316] input: HD-Audio Generic Line Out Surround as
/devices/pci0000:00/0000:00:08.1/0000:08:00.4/sound/card1/input28
[   63.931488] input: HD-Audio Generic Line Out CLFE as
/devices/pci0000:00/0000:00:08.1/0000:08:00.4/sound/card1/input29
[   63.931669] input: HD-Audio Generic Front Headphone as
/devices/pci0000:00/0000:00:08.1/0000:08:00.4/sound/card1/input30
[   63.960111] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.sfi
[   63.960127] Bluetooth: hci0: Boot Address: 0x24800
[   63.960130] Bluetooth: hci0: Firmware Version: 132-3.24
[   63.960133] Bluetooth: hci0: Firmware already loaded
[   63.970416] Bluetooth: hci0: HCI LE Coded PHY feature bit is set,
but its usage is not supported.
[   64.074452] iwlwifi 0000:04:00.0: TLV_FW_FSEQ_VERSION: FSEQ
Version: 89.3.35.37
[   64.109163] iwlwifi 0000:04:00.0: loaded firmware version
77.2753b721.0 cc-a0-77.ucode op_mode iwlmvm
[   64.158610] [drm] [nvidia-drm] [GPU ID 0x00000600] Loading driver
[   64.447772] kvm_amd: TSC scaling supported
[   64.447779] kvm_amd: Nested Virtualization enabled
[   64.447782] kvm_amd: Nested Paging enabled
[   64.447786] kvm_amd: SEV enabled (ASIDs 1 - 509)
[   64.447790] kvm_amd: SEV-ES disabled (ASIDs 0 - 0)
[   64.447827] kvm_amd: Virtual VMLOAD VMSAVE supported
[   64.447830] kvm_amd: Virtual GIF supported
[   64.447832] kvm_amd: LBR virtualization supported
[   64.718427] MCE: In-kernel MCE decoding enabled.
[   65.028949] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is
disabled. Duplicate IMA measurements will not be recorded in the IMA
log.
[   65.029016] device-mapper: uevent: version 1.0.3
[   65.029200] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01)
initialised: dm-devel@redhat.com
[   65.165930] intel_rapl_common: Found RAPL domain package
[   65.165938] intel_rapl_common: Found RAPL domain core
[   65.254002] [drm] Initialized nvidia-drm 0.0.0 20160202 for
0000:06:00.0 on minor 0
[   65.380215] iwlwifi 0000:04:00.0: Detected Intel(R) Wi-Fi 6 AX200
160MHz, REV=0x340
[   65.380287] thermal thermal_zone0: failed to read out thermal zone (-61)
[   65.503758] iwlwifi 0000:04:00.0: Detected RF HR B3, rfid=0x10a100
[   65.568992] iwlwifi 0000:04:00.0: base HW address: 5c:80:b6:0f:b9:aa
[   65.648297] iwlwifi 0000:04:00.0 wlp4s0: renamed from wlan0
[   94.411313] logitech-hidpp-device 0003:046D:4050.0005: HID++ 4.5
device connected.
[  120.529320] logitech-hidpp-device 0003:046D:4003.0006: HID++ 2.0
device connected.
[  131.837133] Adding 19496956k swap on /dev/mapper/cryptswap.
Priority:-2 extents:1 across:19496956k
[  133.745897] EXT4-fs (dm-1): mounted filesystem
51f7641b-40e8-42b0-b875-856556acda60 r/w with ordered data mode. Quota
mode: none.
[  137.688921] audit: type=1400 audit(1746869031.111:4):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="flatpak" pid=2002 comm="apparmor_parser"
[  137.690168] audit: type=1400 audit(1746869031.111:5):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="cam" pid=1990 comm="apparmor_parser"
[  137.691390] audit: type=1400 audit(1746869031.111:6):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="devhelp" pid=1997 comm="apparmor_parser"
[  137.692509] audit: type=1400 audit(1746869031.111:7):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="element-desktop" pid=1998 comm="apparmor_parser"
[  137.693651] audit: type=1400 audit(1746869031.111:8):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="evolution" pid=2000 comm="apparmor_parser"
[  137.694777] audit: type=1400 audit(1746869031.111:9):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="vscode" pid=1995 comm="apparmor_parser"
[  137.694780] audit: type=1400 audit(1746869031.111:10):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="epiphany" pid=1999 comm="apparmor_parser"
[  137.694783] audit: type=1400 audit(1746869031.111:11):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="buildah" pid=1988 comm="apparmor_parser"
[  137.694786] audit: type=1400 audit(1746869031.111:12):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="Discord" pid=1982 comm="apparmor_parser"
[  137.694789] audit: type=1400 audit(1746869031.111:13):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="foliate" pid=2003 comm="apparmor_parser"
[  143.580753] kauditd_printk_skb: 117 callbacks suppressed
[  143.580760] audit: type=1400 audit(1746869037.003:131):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="/snap/snapd/23771/usr/lib/snapd/snap-confine" pid=2112
comm="apparmor_parser"
[  143.582987] audit: type=1400 audit(1746869037.003:132):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="/snap/snapd/23771/usr/lib/snapd/snap-confine//mount-namespace-capture-helper"
pid=2112 comm="apparmor_parser"
[  143.584131] audit: type=1400 audit(1746869037.003:133):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="snap.cups.cupsaccept" pid=2125 comm="apparmor_parser"
[  143.587796] audit: type=1400 audit(1746869037.007:134):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="snap.cups.gs" pid=2134 comm="apparmor_parser"
[  143.595464] audit: type=1400 audit(1746869037.015:135):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="snap.cups.cupstestppd" pid=2132 comm="apparmor_parser"
[  143.596723] audit: type=1400 audit(1746869037.015:136):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="snap.cups.driverless" pid=2133 comm="apparmor_parser"
[  143.603380] audit: type=1400 audit(1746869037.023:137):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="snap.cups.cupsdisable" pid=2128 comm="apparmor_parser"
[  143.604669] audit: type=1400 audit(1746869037.023:138):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="snap.cups.ippeveprinter" pid=2135 comm="apparmor_parser"
[  143.605944] audit: type=1400 audit(1746869037.027:139):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="snap-update-ns.mesa-2404" pid=2117 comm="apparmor_parser"
[  143.607211] audit: type=1400 audit(1746869037.027:140):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="snap.cups.cupsctl" pid=2126 comm="apparmor_parser"
[  156.577321] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[  156.578260] Bluetooth: BNEP filters: protocol multicast
[  156.579184] Bluetooth: BNEP socket layer initialized
[  156.582677] Bluetooth: MGMT ver 1.22
[  156.760321] NET: Registered PF_ALG protocol family
[  156.910095] Bluetooth: RFCOMM TTY layer initialized
[  156.910815] Bluetooth: RFCOMM socket layer initialized
[  156.911531] Bluetooth: RFCOMM ver 1.11
[  158.209409] NET: Registered PF_QIPCRTR protocol family
[  158.273640] loop30: detected capacity change from 0 to 8
[  173.066421] iwlwifi 0000:04:00.0: Registered PHC clock:
iwlwifi-PTP, with index: 1
[  174.230515] kauditd_printk_skb: 39 callbacks suppressed
[  174.230519] audit: type=1400 audit(1746869067.651:180):
apparmor="DENIED" operation="open" class="file"
profile="/usr/sbin/cupsd" name="/etc/paperspecs" pid=3627 comm="cupsd"
requested_mask="r" denied_mask="r" fsuid=0 ouid=0
[  174.796707] audit: type=1400 audit(1746869068.215:181):
apparmor="DENIED" operation="capable" class="cap"
profile="/snap/snapd/24505/usr/lib/snapd/snap-confine" pid=3631
comm="snap-confine" capability=12  capname="net_admin"
[  174.797738] audit: type=1400 audit(1746869068.215:182):
apparmor="DENIED" operation="capable" class="cap"
profile="/snap/snapd/24505/usr/lib/snapd/snap-confine" pid=3631
comm="snap-confine" capability=38  capname="perfmon"
[  175.476987] igc 0000:05:00.0 enp5s0: NIC Link is Up 1000 Mbps Full
Duplex, Flow Control: RX/TX
