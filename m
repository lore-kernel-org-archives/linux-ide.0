Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBE73C38
	for <linux-ide@vger.kernel.org>; Mon, 12 May 2025 05:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747028314; cv=none; b=KHeo2fWIo9ieIPaZ8hBdxydi4ShwDmM+4Z4Y0YhHK8Hd2oGfgaQZNhdmcQckGq+UYPuqEEmSEKZQsoADRVp9CI/ANpWhKBhxKE4mh8m/++bdCEG7nJ2UmVWjy2vhBqeXY6BhAnBbY15tmPsQSA9uG5t9JA3jTAmngMFzgzQ+ueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747028314; c=relaxed/simple;
	bh=DUwmfit47QtTPmFybv0M2b10qFFJTiIJU5nESutlg5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSEdVOKEkNqnekyy6RrPhPl5vU7z2YGQScFWfHx9FoPjysH4OFeRQsvCoJQTyBVsJaZxarsPA4ZgMeM8e6svcwUEJcYNQ/KVgW96lS7MpXjOYbljXOQN4PKOPQ3yDMLwe1bMewYIGnFR2LZXNX7bxlV5+p0VEdozfsv0QGoblYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyZy+vvI; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyZy+vvI"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7082ad1355bso33224777b3.1
        for <linux-ide@vger.kernel.org>; Sun, 11 May 2025 22:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747028309; x=1747633109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DsmlfX3g+KjYjvmgPwHO6qYZkmT6HYBpZEvUk/ZPA2A=;
        b=DyZy+vvI7GcvPC3n1QzVRWWsGk9xzsd5XJAqlK/DFGViX0wv5bRGTlTN/JqWnO2neq
         u74BoI3qTUqdrpjZ7yBdnd6yH+Fu0BAWXqNTaqbH1MESJkpK+t+FtVT8RUeYvWbAOr3Y
         Kqjd5zsB4D6BjBkOwksgca+ZIxdbvBF0cO/znTEF4zwyomrUoo6OnWBqgZvfqfKOmim5
         vS3XBS6peEOnXZhb7ob6fV7FlE88IYBAk1HHdUuoqbrMZGaUAYdgDzGodEPlnxbFZUIu
         CO0wE/SDxYoT7S4k0LLi2JGBd5IfiwX9Qh0ChvdvZugwgPkISB5D+SuKT8yjkkXe/tHQ
         XQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747028309; x=1747633109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsmlfX3g+KjYjvmgPwHO6qYZkmT6HYBpZEvUk/ZPA2A=;
        b=eLU8lgdiN65NA8UjKWw+gnVWMjqSXmiJKF8vA923C6nUdRqpDej8G+XIbBgyi5BHMz
         45nGY0PN8NVSiXrNkXxwFr8knA0dDjLq7yDwrwU/h+kpW+AbGoJF0ygAW+LLEsfiQxp3
         TgMCa7bovwm3Pz8Mlw3ugM7eg0sPnKih6bSnomqH+SeF2P/5XrEpqUz/ROGfvqzrOTLR
         WCOTJTXJpz3HagouELmq82UAMqfpN+UqPf9fQQsjCLqwZ2qvGrBsn52LFJ2WF89ZPL3E
         705kqTiLgn3jLknuavROHGw6fxhf1mVEF+kRUp4ye9xvHv4C02XlFS0hoYp2uSV6o4L5
         vjJg==
X-Forwarded-Encrypted: i=1; AJvYcCV4WHxSCZhVTrDTfTOfgQs+8R/CzFQwmX2bJCZzOIu0Y3DeoS8e5AWUN+sx0WDQO+Wvr/jK16oqIPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL/78wWcVBMqPIf085XiyYrKTkyOqL5VbQn48kQe/GnKOJWPri
	W+M3s+lW2zbsnQmGR2FW9dnbeK68e3vzz2rrhYbVOn0A3jcxyT/SqW6fR1cRg50g9T0pml0iaqH
	U8+7Q9vlQNMti9bXrFKHJrUzAICg=
X-Gm-Gg: ASbGncs/1jgmVtsmDSA+rXn6jNZ5ETmJjqIieAWPIApUUSX7LUAkAtt2lVC8J58cUAE
	Vi/Zg1PRwambgbKWxguQqWtOOxt13eomSeG2SC4iexWWjUZeyYeTc60mx92yjE6maqVnrUx41zy
	h8JIdQ+55zd/WBzWkSv+VyGgSsKFCOfCmZmw==
X-Google-Smtp-Source: AGHT+IFs8JUdeo3zXpC1au+OY2VGUrgVWN4s3ZALZCpwE3cr3+WwO5tlWBAj+kFFDGhQpPEvFkPg42ybnE5Xq9GZa6s=
X-Received: by 2002:a05:6902:1a41:b0:e75:c6bb:3414 with SMTP id
 3f1490d57ef6-e78fdc5b6a4mr13895807276.18.1747028308329; Sun, 11 May 2025
 22:38:28 -0700 (PDT)
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
 <f572f7d2-7b14-476e-aab2-bf674811dee5@kernel.org> <CAAZ0mTf3T5RTDKtd148GyGOiVz98isFFbMDXfku8yAk9FfLVeQ@mail.gmail.com>
 <aB8_rITWsMzkTiyE@ryzen> <CAAZ0mTe7Tpf2F1cKbmr==43pXDUxcPP4Q2AydpyDFJUrFHzNHQ@mail.gmail.com>
 <98E34F63-CCAE-48C4-9584-9053C3D1A7FD@kernel.org> <CAAZ0mTdcAazi=133Dz0+OgSGOERe7WmCTr27ePudEVhkJj6VbA@mail.gmail.com>
 <48F49924-F5FE-4A91-8323-E2C789D1BEFB@kernel.org>
In-Reply-To: <48F49924-F5FE-4A91-8323-E2C789D1BEFB@kernel.org>
From: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Date: Mon, 12 May 2025 08:37:51 +0300
X-Gm-Features: AX0GCFu83mDk7yp6JIzkswgj3h3d1TknaBQzolGabuY8lWEWuI21fJHmef2r2CA
Message-ID: <CAAZ0mTdtOVSidMeC76X9oZyHCtJdgyiu44+UEKqP5tSUaD9ZsQ@mail.gmail.com>
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>, linux-ide@vger.kernel.org, 
	Niklas Cassel <Niklas.Cassel@wdc.com>
Content-Type: text/plain; charset="UTF-8"

su 11.5.2025 klo 22.18 Niklas Cassel (cassel@kernel.org) kirjoitti:
> Ok, I see were things went wrong now.

Hello guys!

To clarify:
I have a aROG STRIX B550-F GAMING (WI-FI) motherboard with 6 SATA
ports from which I can use due to space restrictions 3,4,5,6. New
info: having checked the manual I notice ports 5 and 6 are special,
they can be used only when M.2_2 slot is not populated.
I have WDC WD20EFAX-68FB5N0 and WDC WD5000AAKX-001CA0 drives.

Every combination worked up to 6.8.12 but it were lpm-pol
keep_firmware_settings.

After that works:
sata ports 5,6 -> WDC WD5000AAKX-001CA0
sata ports 3,4 -> WDC WD5000AAKX-001CA0
sata ports 3,4 -> WDC WD20EFAX-68FB5N0
Not working:
sata ports 5,6 -> WDC WD20EFAX-68FB5N0
but setting link_power_management_policy to max_performance gets it going.


> Basically, we wanted to compare the good 6.14.5 output with the bad 6.14.5 output, especially the lpm-pol output.
>
Here is a dmesg with sata ports 3,4 -> WD20EFAX-68FB5N0

Best regards,
Mikko
--------------------------------
[    0.000000] Linux version 6.14.5 (mjkorhon@taavi) (gcc (Debian
14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #3 SMP
PREEMPT_DYNAMIC Sat May 10 19:04:02 EEST 2025
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.14.5
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
[    0.000000] e820: update [mem 0xb7111018-0xb7120067] usable ==> usable
[    0.000000] e820: update [mem 0xb70cb018-0xb70eaa57] usable ==> usable
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
0x000000000b020000-0x00000000b70cb017] usable
[    0.000000] reserve setup_data: [mem
0x00000000b70cb018-0x00000000b70eaa57] usable
[    0.000000] reserve setup_data: [mem
0x00000000b70eaa58-0x00000000b7111017] usable
[    0.000000] reserve setup_data: [mem
0x00000000b7111018-0x00000000b7120067] usable
[    0.000000] reserve setup_data: [mem
0x00000000b7120068-0x00000000c3276fff] usable
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
MEMATTR=0xc382b018 ESRT=0xc422fb98 MOKvar=0xcb84c000 INITRD=0xb9306c18
RNG=0xca3a3c18 TPMEventLog=0xca244018
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem231: MMIO range=[0xf0000000-0xf7ffffff]
(128MB) from e820 map
[    0.000000] e820: remove [mem 0xf0000000-0xf7ffffff] reserved
[    0.000000] efi: Remove mem232: MMIO range=[0xfd200000-0xfd2fffff]
(1MB) from e820 map
[    0.000000] e820: remove [mem 0xfd200000-0xfd2fffff] reserved
[    0.000000] efi: Remove mem233: MMIO range=[0xfd600000-0xfd7fffff]
(2MB) from e820 map
[    0.000000] e820: remove [mem 0xfd600000-0xfd7fffff] reserved
[    0.000000] efi: Not removing mem234: MMIO
range=[0xfea00000-0xfea0ffff] (64KB) from e820 map
[    0.000000] efi: Remove mem235: MMIO range=[0xfeb80000-0xfec01fff]
(0MB) from e820 map
[    0.000000] e820: remove [mem 0xfeb80000-0xfec01fff] reserved
[    0.000000] efi: Not removing mem236: MMIO
range=[0xfec10000-0xfec10fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem237: MMIO
range=[0xfec30000-0xfec30fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem238: MMIO
range=[0xfed00000-0xfed00fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem239: MMIO
range=[0xfed40000-0xfed44fff] (20KB) from e820 map
[    0.000000] efi: Not removing mem240: MMIO
range=[0xfed80000-0xfed8ffff] (64KB) from e820 map
[    0.000000] efi: Not removing mem241: MMIO
range=[0xfedc2000-0xfedcffff] (56KB) from e820 map
[    0.000000] efi: Not removing mem242: MMIO
range=[0xfedd4000-0xfedd5fff] (8KB) from e820 map
[    0.000000] efi: Remove mem243: MMIO range=[0xff000000-0xffffffff]
(16MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.3.0 present.
[    0.000000] DMI: ASUS System Product Name/ROG STRIX B550-F GAMING
(WI-FI), BIOS 3621 01/13/2025
[    0.000000] DMI: Memory slots populated: 2/4
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3792.904 MHz processor
[    0.000482] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000484] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000493] last_pfn = 0x82f300 max_arch_pfn = 0x400000000
[    0.000498] MTRR map: 7 entries (3 fixed + 4 variable; max 20),
built from 9 variable MTRRs
[    0.000499] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.000931] e820: update [mem 0xca550000-0xca55ffff] usable ==> reserved
[    0.000936] e820: update [mem 0xd0000000-0xffffffff] usable ==> reserved
[    0.000940] last_pfn = 0xcd000 max_arch_pfn = 0x400000000
[    0.004595] esrt: Reserving ESRT space from 0x00000000c422fb98 to
0x00000000c422fbd0.
[    0.004606] e820: update [mem 0xc422f000-0xc422ffff] usable ==> reserved
[    0.004626] Using GB pages for direct mapping
[    0.005482] Secure boot enabled
[    0.005483] RAMDISK: [mem 0x9fca2000-0xa7a42fff]
[    0.005774] ACPI: Early table checksum verification disabled
[    0.005778] ACPI: RSDP 0x00000000CA3BC014 000024 (v02 ALASKA)
[    0.005781] ACPI: XSDT 0x00000000CA3BB728 0000D4 (v01 ALASKA A M I
  01072009 AMI  01000013)
[    0.005785] ACPI: FACP 0x00000000CA3B4000 000114 (v06 ALASKA A M I
  01072009 AMI  00010013)
[    0.005788] ACPI: DSDT 0x00000000CA3A8000 00B15E (v02 ALASKA A M I
  01072009 INTL 20120913)
[    0.005790] ACPI: FACS 0x00000000CAB41000 000040
[    0.005792] ACPI: SSDT 0x00000000CA3BA000 00092A (v02 AMD
AmdTable 00000002 MSFT 04000000)
[    0.005794] ACPI: SSDT 0x00000000CA3B6000 003B8E (v02 AMD    AMD
AOD  00000001 INTL 20120913)
[    0.005795] ACPI: SSDT 0x00000000CA3B5000 000309 (v02 ALASKA
CPUSSDT  01072009 AMI  01072009)
[    0.005797] ACPI: FIDT 0x00000000CA3A7000 00009C (v01 ALASKA A M I
  01072009 AMI  00010013)
[    0.005799] ACPI: MCFG 0x00000000CA3A5000 00003C (v01 ALASKA A M I
  01072009 MSFT 00010013)
[    0.005801] ACPI: HPET 0x00000000CA3A4000 000038 (v01 ALASKA A M I
  01072009 AMI  00000005)
[    0.005802] ACPI: IVRS 0x00000000CA3A2000 0000D0 (v02 AMD
AmdTable 00000001 AMD  00000001)
[    0.005804] ACPI: WPBT 0x00000000CA26B000 00003C (v01 ALASKA A M I
  00000001 ASUS 00000001)
[    0.005806] ACPI: TPM2 0x00000000CA26A000 00004C (v04 ALASKA A M I
  00000001 AMI  00000000)
[    0.005808] ACPI: PCCT 0x00000000CA269000 00006E (v02 AMD
AmdTable 00000001 AMD  00000001)
[    0.005810] ACPI: SSDT 0x00000000CA262000 0061A3 (v02 AMD
AmdTable 00000001 AMD  00000001)
[    0.005811] ACPI: CRAT 0x00000000CA260000 0016D0 (v01 AMD
AmdTable 00000001 AMD  00000001)
[    0.005813] ACPI: CDIT 0x00000000CA25F000 000029 (v01 AMD
AmdTable 00000001 AMD  00000001)
[    0.005815] ACPI: BGRT 0x00000000CA3A1000 000038 (v01 ALASKA A M I
  01072009 AMI  00010013)
[    0.005817] ACPI: SSDT 0x00000000CA25E000 000259 (v02 AMD
ArticDGP 00000001 INTL 20120913)
[    0.005818] ACPI: SSDT 0x00000000CA25A000 003E6E (v02 AMD    ArticN
  00000001 INTL 20120913)
[    0.005820] ACPI: WSMT 0x00000000CA259000 000028 (v01 ALASKA A M I
  01072009 AMI  00010013)
[    0.005822] ACPI: APIC 0x00000000CA258000 00015E (v04 ALASKA A M I
  01072009 AMI  00010013)
[    0.005824] ACPI: SSDT 0x00000000CA257000 00007D (v02 AMD
ArticDIS 00000001 INTL 20120913)
[    0.005825] ACPI: SSDT 0x00000000CA256000 0000BF (v01 AMD
AmdTable 00001000 INTL 20120913)
[    0.005827] ACPI: FPDT 0x00000000CA255000 000044 (v01 ALASKA A M I
  01072009 AMI  01000013)
[    0.005828] ACPI: Reserving FACP table memory at [mem 0xca3b4000-0xca3b4113]
[    0.005829] ACPI: Reserving DSDT table memory at [mem 0xca3a8000-0xca3b315d]
[    0.005830] ACPI: Reserving FACS table memory at [mem 0xcab41000-0xcab4103f]
[    0.005830] ACPI: Reserving SSDT table memory at [mem 0xca3ba000-0xca3ba929]
[    0.005831] ACPI: Reserving SSDT table memory at [mem 0xca3b6000-0xca3b9b8d]
[    0.005831] ACPI: Reserving SSDT table memory at [mem 0xca3b5000-0xca3b5308]
[    0.005832] ACPI: Reserving FIDT table memory at [mem 0xca3a7000-0xca3a709b]
[    0.005833] ACPI: Reserving MCFG table memory at [mem 0xca3a5000-0xca3a503b]
[    0.005833] ACPI: Reserving HPET table memory at [mem 0xca3a4000-0xca3a4037]
[    0.005834] ACPI: Reserving IVRS table memory at [mem 0xca3a2000-0xca3a20cf]
[    0.005834] ACPI: Reserving WPBT table memory at [mem 0xca26b000-0xca26b03b]
[    0.005835] ACPI: Reserving TPM2 table memory at [mem 0xca26a000-0xca26a04b]
[    0.005835] ACPI: Reserving PCCT table memory at [mem 0xca269000-0xca26906d]
[    0.005836] ACPI: Reserving SSDT table memory at [mem 0xca262000-0xca2681a2]
[    0.005836] ACPI: Reserving CRAT table memory at [mem 0xca260000-0xca2616cf]
[    0.005837] ACPI: Reserving CDIT table memory at [mem 0xca25f000-0xca25f028]
[    0.005837] ACPI: Reserving BGRT table memory at [mem 0xca3a1000-0xca3a1037]
[    0.005838] ACPI: Reserving SSDT table memory at [mem 0xca25e000-0xca25e258]
[    0.005838] ACPI: Reserving SSDT table memory at [mem 0xca25a000-0xca25de6d]
[    0.005839] ACPI: Reserving WSMT table memory at [mem 0xca259000-0xca259027]
[    0.005839] ACPI: Reserving APIC table memory at [mem 0xca258000-0xca25815d]
[    0.005840] ACPI: Reserving SSDT table memory at [mem 0xca257000-0xca25707c]
[    0.005840] ACPI: Reserving SSDT table memory at [mem 0xca256000-0xca2560be]
[    0.005841] ACPI: Reserving FPDT table memory at [mem 0xca255000-0xca255043]
[    0.005890] No NUMA configuration found
[    0.005891] Faking a node at [mem 0x0000000000000000-0x000000082f2fffff]
[    0.005898] NODE_DATA(0) allocated [mem 0x82f2d5680-0x82f2fffff]
[    0.006098] Zone ranges:
[    0.006098]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.006099]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.006100]   Normal   [mem 0x0000000100000000-0x000000082f2fffff]
[    0.006101]   Device   empty
[    0.006102] Movable zone start for each node
[    0.006103] Early memory node ranges
[    0.006104]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.006105]   node   0: [mem 0x0000000000100000-0x0000000009d1efff]
[    0.006105]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
[    0.006106]   node   0: [mem 0x000000000a211000-0x000000000affffff]
[    0.006106]   node   0: [mem 0x000000000b020000-0x00000000c3276fff]
[    0.006107]   node   0: [mem 0x00000000c3278000-0x00000000c9e43fff]
[    0.006108]   node   0: [mem 0x00000000cb9ff000-0x00000000ccffffff]
[    0.006108]   node   0: [mem 0x0000000100000000-0x000000082f2fffff]
[    0.006111] Initmem setup node 0 [mem 0x0000000000001000-0x000000082f2fffff]
[    0.006117] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.006130] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.006240] On node 0, zone DMA32: 737 pages in unavailable ranges
[    0.006252] On node 0, zone DMA32: 17 pages in unavailable ranges
[    0.009689] On node 0, zone DMA32: 32 pages in unavailable ranges
[    0.009838] On node 0, zone DMA32: 1 pages in unavailable ranges
[    0.009920] On node 0, zone DMA32: 7099 pages in unavailable ranges
[    0.010196] On node 0, zone Normal: 12288 pages in unavailable ranges
[    0.010220] On node 0, zone Normal: 3328 pages in unavailable ranges
[    0.010414] ACPI: PM-Timer IO Port: 0x808
[    0.010422] CPU topo: Ignoring hot-pluggable APIC ID 0 in present package.
[    0.010424] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.010436] IOAPIC[0]: apic_id 25, version 33, address 0xfec00000, GSI 0-23
[    0.010442] IOAPIC[1]: apic_id 26, version 33, address 0xfec01000, GSI 24-55
[    0.010443] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.010445] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.010448] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.010449] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.010462] e820: update [mem 0xc53ae000-0xc54a1fff] usable ==> reserved
[    0.010479] CPU topo: Max. logical packages:   1
[    0.010480] CPU topo: Max. logical dies:       1
[    0.010480] CPU topo: Max. dies per package:   1
[    0.010484] CPU topo: Max. threads per core:   2
[    0.010484] CPU topo: Num. cores per package:    12
[    0.010485] CPU topo: Num. threads per package:  24
[    0.010485] CPU topo: Allowing 24 present CPUs plus 0 hotplug CPUs
[    0.010486] CPU topo: Rejected CPUs 8
[    0.010511] PM: hibernation: Registered nosave memory: [mem
0x00000000-0x00000fff]
[    0.010512] PM: hibernation: Registered nosave memory: [mem
0x000a0000-0x000fffff]
[    0.010513] PM: hibernation: Registered nosave memory: [mem
0x09d1f000-0x09ffffff]
[    0.010515] PM: hibernation: Registered nosave memory: [mem
0x0a200000-0x0a210fff]
[    0.010516] PM: hibernation: Registered nosave memory: [mem
0x0b000000-0x0b01ffff]
[    0.010517] PM: hibernation: Registered nosave memory: [mem
0xc3277000-0xc3277fff]
[    0.010519] PM: hibernation: Registered nosave memory: [mem
0xc422f000-0xc422ffff]
[    0.010520] PM: hibernation: Registered nosave memory: [mem
0xc53ae000-0xc54a1fff]
[    0.010521] PM: hibernation: Registered nosave memory: [mem
0xc9e44000-0xcb9fefff]
[    0.010523] PM: hibernation: Registered nosave memory: [mem
0xcd000000-0xffffffff]
[    0.010524] [mem 0xd0000000-0xfe9fffff] available for PCI devices
[    0.010525] Booting paravirtualized kernel on bare hardware
[    0.010527] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.014267] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:24
nr_cpu_ids:24 nr_node_ids:1
[    0.015584] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 u524288
[    0.015590] pcpu-alloc: s233472 r8192 d28672 u524288 alloc=1*2097152
[    0.015592] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07
[    0.015595] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15
[    0.015598] pcpu-alloc: [0] 16 17 18 19 [0] 20 21 22 23
[    0.015616] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-6.14.5
root=UUID=c056bf20-f617-4c4a-8d3c-28ac04ff6a3a ro lockdown=integrity
splash
[    0.015664] Unknown kernel command line parameters "splash
BOOT_IMAGE=/boot/vmlinuz-6.14.5", will be passed to user space.
[    0.015681] printk: log_buf_len individual max cpu contribution: 4096 bytes
[    0.015682] printk: log_buf_len total cpu_extra contributions: 94208 bytes
[    0.015683] printk: log_buf_len min size: 131072 bytes
[    0.015836] printk: log buffer data + meta data: 262144 + 917504 =
1179648 bytes
[    0.015837] printk: early log buf free: 113496(86%)
[    0.018505] Dentry cache hash table entries: 4194304 (order: 13,
33554432 bytes, linear)
[    0.019831] Inode-cache hash table entries: 2097152 (order: 12,
16777216 bytes, linear)
[    0.019980] Fallback order for Node 0: 0
[    0.019987] Built 1 zonelists, mobility grouping on.  Total pages: 8365009
[    0.019988] Policy zone: Normal
[    0.019995] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.020029] software IO TLB: area num 32.
[    0.039899] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=24, Nodes=1
[    0.039957] ftrace: allocating 46051 entries in 180 pages
[    0.052447] ftrace: allocated 180 pages with 4 groups
[    0.052971] Dynamic Preempt: voluntary
[    0.053039] rcu: Preemptible hierarchical RCU implementation.
[    0.053040] rcu:     RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=24.
[    0.053041]     Trampoline variant of Tasks RCU enabled.
[    0.053041]     Rude variant of Tasks RCU enabled.
[    0.053042]     Tracing variant of Tasks RCU enabled.
[    0.053042] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.053043] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=24
[    0.053055] RCU Tasks: Setting shift to 5 and lim to 1
rcu_task_cb_adjust=1 rcu_task_cpu_ids=24.
[    0.053058] RCU Tasks Rude: Setting shift to 5 and lim to 1
rcu_task_cb_adjust=1 rcu_task_cpu_ids=24.
[    0.053060] RCU Tasks Trace: Setting shift to 5 and lim to 1
rcu_task_cb_adjust=1 rcu_task_cpu_ids=24.
[    0.056821] NR_IRQS: 524544, nr_irqs: 1160, preallocated irqs: 16
[    0.057010] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.057080] Console: colour dummy device 80x25
[    0.057082] printk: legacy console [tty0] enabled
[    0.057418] ACPI: Core revision 20240827
[    0.057514] clocksource: hpet: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 133484873504 ns
[    0.057531] APIC: Switch to symmetric I/O mode setup
[    0.057960] AMD-Vi: Using global IVHD EFR:0x0, EFR2:0x0
[    0.376935] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.377575] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.397526] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x6d585308801, max_idle_ns: 881590710907 ns
[    0.397530] Calibrating delay loop (skipped), value calculated
using timer frequency.. 7585.80 BogoMIPS (lpj=15171616)
[    0.397545] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.397593] LVT offset 1 assigned for vector 0xf9
[    0.397731] LVT offset 2 assigned for vector 0xf4
[    0.397763] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.397765] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
[    0.397768] process: using mwait in idle threads
[    0.397770] Spectre V1 : Mitigation: usercopy/swapgs barriers and
__user pointer sanitization
[    0.397773] Spectre V2 : Mitigation: Retpolines
[    0.397774] Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB on
context switch and VMEXIT
[    0.397777] Spectre V2 : Enabling Speculation Barrier for firmware calls
[    0.397778] RETBleed: Mitigation: untrained return thunk
[    0.397780] Spectre V2 : mitigation: Enabling conditional Indirect
Branch Prediction Barrier
[    0.397783] Spectre V2 : Selecting STIBP always-on mode to
complement retbleed mitigation
[    0.397785] Spectre V2 : User space: Mitigation: STIBP always-on protection
[    0.397787] Speculative Store Bypass: Mitigation: Speculative Store
Bypass disabled via prctl
[    0.397789] Speculative Return Stack Overflow: Mitigation: Safe RET
[    0.397793] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
point registers'
[    0.397796] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.397797] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.397800] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.397802] x86/fpu: Enabled xstate features 0x7, context size is
832 bytes, using 'compacted' format.
[    0.418792] Freeing SMP alternatives memory: 40K
[    0.418798] pid_max: default: 32768 minimum: 301
[    0.425053] LSM: initializing
lsm=lockdown,capability,landlock,yama,apparmor,tomoyo,bpf,ipe,ima,evm
[    0.425137] landlock: Up and running.
[    0.425140] Yama: becoming mindful.
[    0.425232] AppArmor: AppArmor initialized
[    0.425262] TOMOYO Linux initialized
[    0.425482] LSM support for eBPF active
[    0.425587] Mount-cache hash table entries: 65536 (order: 7, 524288
bytes, linear)
[    0.425628] Mountpoint-cache hash table entries: 65536 (order: 7,
524288 bytes, linear)
[    0.537652] smpboot: CPU0: AMD Ryzen 9 3900X 12-Core Processor
(family: 0x17, model: 0x71, stepping: 0x0)
[    0.537897] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    0.537924] ... version:                0
[    0.537928] ... bit width:              48
[    0.537931] ... generic registers:      6
[    0.537935] ... value mask:             0000ffffffffffff
[    0.537939] ... max period:             00007fffffffffff
[    0.537942] ... fixed-purpose events:   0
[    0.537946] ... event mask:             000000000000003f
[    0.538055] signal: max sigframe size: 1776
[    0.538094] rcu: Hierarchical SRCU implementation.
[    0.538098] rcu:     Max phase no-delay instances is 1000.
[    0.538141] Timer migration: 2 hierarchy levels; 8 children per
group; 2 crossnode level
[    0.542402] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.542579] smp: Bringing up secondary CPUs ...
[    0.542683] smpboot: x86: Booting SMP configuration:
[    0.542687] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
#8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23
[    0.571530] Spectre V2 : Update user space SMT mitigation: STIBP always-on
[    0.595531] smp: Brought up 1 node, 24 CPUs
[    0.595531] smpboot: Total of 24 processors activated (182059.39 BogoMIPS)
[    0.629546] node 0 deferred pages initialised in 32ms
[    0.630034] Memory: 32617480K/33460036K available (15505K kernel
code, 2501K rwdata, 11928K rodata, 4200K init, 4856K bss, 823232K
reserved, 0K cma-reserved)
[    0.630581] devtmpfs: initialized
[    0.630581] x86/mm: Memory block size: 128MB
[    0.636587] ACPI: PM: Registering ACPI NVS region [mem
0x0a200000-0x0a210fff] (69632 bytes)
[    0.636587] ACPI: PM: Registering ACPI NVS region [mem
0xca3bd000-0xcab5bfff] (7991296 bytes)
[    0.636587] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.636587] futex hash table entries: 8192 (order: 7, 524288 bytes, linear)
[    0.636587] pinctrl core: initialized pinctrl subsystem
[    0.637622] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.638117] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.638455] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for
atomic allocations
[    0.638769] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool
for atomic allocations
[    0.638785] audit: initializing netlink subsys (disabled)
[    0.638798] audit: type=2000 audit(1747025276.264:1):
state=initialized audit_enabled=0 res=1
[    0.638798] thermal_sys: Registered thermal governor 'fair_share'
[    0.638798] thermal_sys: Registered thermal governor 'bang_bang'
[    0.638798] thermal_sys: Registered thermal governor 'step_wise'
[    0.638798] thermal_sys: Registered thermal governor 'user_space'
[    0.638798] thermal_sys: Registered thermal governor 'power_allocator'
[    0.638798] cpuidle: using governor ladder
[    0.638798] cpuidle: using governor menu
[    0.638798] Detected 1 PCC Subspaces
[    0.638798] Registering PCC driver as Mailbox controller
[    0.638798] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.638798] PCI: ECAM [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
for domain 0000 [bus 00-7f]
[    0.638798] PCI: Using configuration type 1 for base access
[    0.638798] kprobes: kprobe jump-optimization is enabled. All
kprobes are optimized if possible.
[    0.638798] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.638798] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.638798] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.638798] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.638798] ACPI: Added _OSI(Module Device)
[    0.638798] ACPI: Added _OSI(Processor Device)
[    0.638798] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.638798] ACPI: Added _OSI(Processor Aggregator Device)
[    0.652170] ACPI: 9 ACPI AML tables successfully acquired and loaded
[    0.654350] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.661575] ACPI: Interpreter enabled
[    0.661593] ACPI: PM: (supports S0 S3 S4 S5)
[    0.661597] ACPI: Using IOAPIC for interrupt routing
[    0.662037] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    0.662043] PCI: Ignoring E820 reservations for host bridge windows
[    0.662392] ACPI: Enabled 5 GPEs in block 00 to 1F
[    0.686354] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.686364] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI HPX-Type3]
[    0.686475] acpi PNP0A08:00: _OSC: platform does not support
[PCIeHotplug SHPCHotplug PME LTR]
[    0.686673] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability]
[    0.686686] acpi PNP0A08:00: [Firmware Info]: ECAM [mem
0xf0000000-0xf7ffffff] for domain 0000 [bus 00-7f] only partially
covers this bridge
[    0.687220] PCI host bridge to bus 0000:00
[    0.687226] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.687232] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.687238] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.687243] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.687249] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000dffff window]
[    0.687255] pci_bus 0000:00: root bus resource [mem
0xd0000000-0xfec2ffff window]
[    0.687261] pci_bus 0000:00: root bus resource [mem
0xfee00000-0xffffffff window]
[    0.687267] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.687286] pci 0000:00:00.0: [1022:1480] type 00 class 0x060000
conventional PCI endpoint
[    0.687407] pci 0000:00:00.2: [1022:1481] type 00 class 0x080600
conventional PCI endpoint
[    0.687520] pci 0000:00:01.0: [1022:1482] type 00 class 0x060000
conventional PCI endpoint
[    0.687607] pci 0000:00:01.2: [1022:1483] type 01 class 0x060400
PCIe Root Port
[    0.687630] pci 0000:00:01.2: PCI bridge to [bus 01-05]
[    0.687640] pci 0000:00:01.2:   bridge window [mem 0xfc200000-0xfc5fffff]
[    0.687659] pci 0000:00:01.2: enabling Extended Tags
[    0.687722] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.687939] pci 0000:00:02.0: [1022:1482] type 00 class 0x060000
conventional PCI endpoint
[    0.688021] pci 0000:00:03.0: [1022:1482] type 00 class 0x060000
conventional PCI endpoint
[    0.688104] pci 0000:00:03.1: [1022:1483] type 01 class 0x060400
PCIe Root Port
[    0.688126] pci 0000:00:03.1: PCI bridge to [bus 06]
[    0.688134] pci 0000:00:03.1:   bridge window [io  0xf000-0xffff]
[    0.688140] pci 0000:00:03.1:   bridge window [mem 0xfb000000-0xfc0fffff]
[    0.688152] pci 0000:00:03.1:   bridge window [mem
0xd0000000-0xe20fffff 64bit pref]
[    0.688222] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
[    0.688593] pci 0000:00:04.0: [1022:1482] type 00 class 0x060000
conventional PCI endpoint
[    0.688675] pci 0000:00:05.0: [1022:1482] type 00 class 0x060000
conventional PCI endpoint
[    0.688756] pci 0000:00:07.0: [1022:1482] type 00 class 0x060000
conventional PCI endpoint
[    0.688844] pci 0000:00:07.1: [1022:1484] type 01 class 0x060400
PCIe Root Port
[    0.688864] pci 0000:00:07.1: PCI bridge to [bus 07]
[    0.688884] pci 0000:00:07.1: enabling Extended Tags
[    0.688934] pci 0000:00:07.1: PME# supported from D0 D3hot D3cold
[    0.689078] pci 0000:00:08.0: [1022:1482] type 00 class 0x060000
conventional PCI endpoint
[    0.689162] pci 0000:00:08.1: [1022:1484] type 01 class 0x060400
PCIe Root Port
[    0.689183] pci 0000:00:08.1: PCI bridge to [bus 08]
[    0.689192] pci 0000:00:08.1:   bridge window [mem 0xfc600000-0xfc8fffff]
[    0.689209] pci 0000:00:08.1: enabling Extended Tags
[    0.689264] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.689439] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
conventional PCI endpoint
[    0.689563] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
conventional PCI endpoint
[    0.689705] pci 0000:00:18.0: [1022:1440] type 00 class 0x060000
conventional PCI endpoint
[    0.689755] pci 0000:00:18.1: [1022:1441] type 00 class 0x060000
conventional PCI endpoint
[    0.689804] pci 0000:00:18.2: [1022:1442] type 00 class 0x060000
conventional PCI endpoint
[    0.689853] pci 0000:00:18.3: [1022:1443] type 00 class 0x060000
conventional PCI endpoint
[    0.689905] pci 0000:00:18.4: [1022:1444] type 00 class 0x060000
conventional PCI endpoint
[    0.689954] pci 0000:00:18.5: [1022:1445] type 00 class 0x060000
conventional PCI endpoint
[    0.690003] pci 0000:00:18.6: [1022:1446] type 00 class 0x060000
conventional PCI endpoint
[    0.690050] pci 0000:00:18.7: [1022:1447] type 00 class 0x060000
conventional PCI endpoint
[    0.690172] pci 0000:01:00.0: [1022:43ee] type 00 class 0x0c0330
PCIe Legacy Endpoint
[    0.690221] pci 0000:01:00.0: BAR 0 [mem 0xfc5a0000-0xfc5a7fff 64bit]
[    0.690238] pci 0000:01:00.0: enabling Extended Tags
[    0.690303] pci 0000:01:00.0: PME# supported from D3hot D3cold
[    0.690504] pci 0000:01:00.1: [1022:43eb] type 00 class 0x010601
PCIe Legacy Endpoint
[    0.690557] pci 0000:01:00.1: BAR 5 [mem 0xfc580000-0xfc59ffff]
[    0.690563] pci 0000:01:00.1: ROM [mem 0xfc500000-0xfc57ffff pref]
[    0.690575] pci 0000:01:00.1: enabling Extended Tags
[    0.690627] pci 0000:01:00.1: PME# supported from D3hot D3cold
[    0.690750] pci 0000:01:00.2: [1022:43e9] type 01 class 0x060400
PCIe Switch Upstream Port
[    0.690784] pci 0000:01:00.2: PCI bridge to [bus 02-05]
[    0.690797] pci 0000:01:00.2:   bridge window [mem 0xfc200000-0xfc4fffff]
[    0.690827] pci 0000:01:00.2: enabling Extended Tags
[    0.690888] pci 0000:01:00.2: PME# supported from D3hot D3cold
[    0.691043] pci 0000:00:01.2: PCI bridge to [bus 01-05]
[    0.691185] pci 0000:02:00.0: [1022:43ea] type 01 class 0x060400
PCIe Switch Downstream Port
[    0.691220] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.691258] pci 0000:02:00.0: enabling Extended Tags
[    0.691328] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.691474] pci 0000:02:08.0: [1022:43ea] type 01 class 0x060400
PCIe Switch Downstream Port
[    0.691510] pci 0000:02:08.0: PCI bridge to [bus 04]
[    0.691523] pci 0000:02:08.0:   bridge window [mem 0xfc400000-0xfc4fffff]
[    0.691553] pci 0000:02:08.0: enabling Extended Tags
[    0.691624] pci 0000:02:08.0: PME# supported from D3hot D3cold
[    0.691764] pci 0000:02:09.0: [1022:43ea] type 01 class 0x060400
PCIe Switch Downstream Port
[    0.691800] pci 0000:02:09.0: PCI bridge to [bus 05]
[    0.691812] pci 0000:02:09.0:   bridge window [mem 0xfc200000-0xfc3fffff]
[    0.691843] pci 0000:02:09.0: enabling Extended Tags
[    0.691914] pci 0000:02:09.0: PME# supported from D3hot D3cold
[    0.692054] pci 0000:01:00.2: PCI bridge to [bus 02-05]
[    0.692118] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.692224] pci 0000:04:00.0: [8086:2723] type 00 class 0x028000
PCIe Endpoint
[    0.692308] pci 0000:04:00.0: BAR 0 [mem 0xfc400000-0xfc403fff 64bit]
[    0.692450] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    0.692679] pci 0000:02:08.0: PCI bridge to [bus 04]
[    0.692787] pci 0000:05:00.0: [8086:15f3] type 00 class 0x020000
PCIe Endpoint
[    0.692865] pci 0000:05:00.0: BAR 0 [mem 0xfc200000-0xfc2fffff]
[    0.692876] pci 0000:05:00.0: BAR 3 [mem 0xfc300000-0xfc303fff]
[    0.693019] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[    0.693287] pci 0000:02:09.0: PCI bridge to [bus 05]
[    0.693405] pci 0000:06:00.0: [10de:1f08] type 00 class 0x030000
PCIe Legacy Endpoint
[    0.693452] pci 0000:06:00.0: BAR 0 [mem 0xfb000000-0xfbffffff]
[    0.693460] pci 0000:06:00.0: BAR 1 [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.693467] pci 0000:06:00.0: BAR 3 [mem 0xe0000000-0xe1ffffff 64bit pref]
[    0.693474] pci 0000:06:00.0: BAR 5 [io  0xf000-0xf07f]
[    0.693480] pci 0000:06:00.0: ROM [mem 0xfc000000-0xfc07ffff pref]
[    0.693511] pci 0000:06:00.0: Video device with shadowed ROM at
[mem 0x000c0000-0x000dffff]
[    0.693572] pci 0000:06:00.0: PME# supported from D0 D3hot
[    0.693665] pci 0000:06:00.0: 32.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s PCIe x16 link at 0000:00:03.1 (capable of 126.016
Gb/s with 8.0 GT/s PCIe x16 link)
[    0.693837] pci 0000:06:00.1: [10de:10f9] type 00 class 0x040300
PCIe Endpoint
[    0.693884] pci 0000:06:00.1: BAR 0 [mem 0xfc080000-0xfc083fff]
[    0.694054] pci 0000:06:00.2: [10de:1ada] type 00 class 0x0c0330
PCIe Endpoint
[    0.694102] pci 0000:06:00.2: BAR 0 [mem 0xe2000000-0xe203ffff 64bit pref]
[    0.694110] pci 0000:06:00.2: BAR 3 [mem 0xe2040000-0xe204ffff 64bit pref]
[    0.694168] pci 0000:06:00.2: PME# supported from D0 D3hot
[    0.694268] pci 0000:06:00.3: [10de:1adb] type 00 class 0x0c8000
PCIe Endpoint
[    0.694314] pci 0000:06:00.3: BAR 0 [mem 0xfc084000-0xfc084fff]
[    0.694375] pci 0000:06:00.3: PME# supported from D0 D3hot
[    0.694507] pci 0000:00:03.1: PCI bridge to [bus 06]
[    0.694567] pci 0000:07:00.0: [1022:148a] type 00 class 0x130000
PCIe Endpoint
[    0.694602] pci 0000:07:00.0: enabling Extended Tags
[    0.694782] pci 0000:00:07.1: PCI bridge to [bus 07]
[    0.694858] pci 0000:08:00.0: [1022:1485] type 00 class 0x130000
PCIe Endpoint
[    0.694899] pci 0000:08:00.0: enabling Extended Tags
[    0.695084] pci 0000:08:00.1: [1022:1486] type 00 class 0x108000
PCIe Endpoint
[    0.695118] pci 0000:08:00.1: BAR 2 [mem 0xfc700000-0xfc7fffff]
[    0.695126] pci 0000:08:00.1: BAR 5 [mem 0xfc808000-0xfc809fff]
[    0.695136] pci 0000:08:00.1: enabling Extended Tags
[    0.695293] pci 0000:08:00.3: [1022:149c] type 00 class 0x0c0330
PCIe Endpoint
[    0.695328] pci 0000:08:00.3: BAR 0 [mem 0xfc600000-0xfc6fffff 64bit]
[    0.695342] pci 0000:08:00.3: enabling Extended Tags
[    0.695397] pci 0000:08:00.3: PME# supported from D0 D3hot D3cold
[    0.695550] pci 0000:08:00.4: [1022:1487] type 00 class 0x040300
PCIe Endpoint
[    0.695583] pci 0000:08:00.4: BAR 0 [mem 0xfc800000-0xfc807fff]
[    0.695597] pci 0000:08:00.4: enabling Extended Tags
[    0.695650] pci 0000:08:00.4: PME# supported from D0 D3hot D3cold
[    0.695792] pci 0000:00:08.1: PCI bridge to [bus 08]
[    0.696197] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.696248] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.696293] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.696346] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.696394] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.696436] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.696477] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.696517] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.697562] iommu: Default domain type: Translated
[    0.697562] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.699498] pps_core: LinuxPPS API ver. 1 registered
[    0.699503] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.699512] PTP clock support registered
[    0.699525] EDAC MC: Ver: 3.0.0
[    0.699634] efivars: Registered efivars operations
[    0.699634] NetLabel: Initializing
[    0.699634] NetLabel:  domain hash size = 128
[    0.699634] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.699634] NetLabel:  unlabeled traffic allowed by default
[    0.699634] PCI: Using ACPI for IRQ routing
[    0.704140] PCI: pci_cache_line_size set to 64 bytes
[    0.704210] e820: reserve RAM buffer [mem 0x09d1f000-0x0bffffff]
[    0.704212] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
[    0.704214] e820: reserve RAM buffer [mem 0x0b000000-0x0bffffff]
[    0.704215] e820: reserve RAM buffer [mem 0xb70cb018-0xb7ffffff]
[    0.704217] e820: reserve RAM buffer [mem 0xb7111018-0xb7ffffff]
[    0.704218] e820: reserve RAM buffer [mem 0xc3277000-0xc3ffffff]
[    0.704220] e820: reserve RAM buffer [mem 0xc422f000-0xc7ffffff]
[    0.704221] e820: reserve RAM buffer [mem 0xc53ae000-0xc7ffffff]
[    0.704223] e820: reserve RAM buffer [mem 0xc9e44000-0xcbffffff]
[    0.704224] e820: reserve RAM buffer [mem 0xcd000000-0xcfffffff]
[    0.704226] e820: reserve RAM buffer [mem 0x82f300000-0x82fffffff]
[    0.704303] pci 0000:06:00.0: vgaarb: setting as boot VGA device
[    0.704303] pci 0000:06:00.0: vgaarb: bridge control possible
[    0.704303] pci 0000:06:00.0: vgaarb: VGA device added:
decodes=io+mem,owns=io+mem,locks=none
[    0.704303] vgaarb: loaded
[    0.704303] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.704303] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.705593] clocksource: Switched to clocksource tsc-early
[    0.705770] VFS: Disk quotas dquot_6.6.0
[    0.705784] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.705930] AppArmor: AppArmor Filesystem Enabled
[    0.705959] pnp: PnP ACPI init
[    0.706054] system 00:00: [mem 0xf0000000-0xf7ffffff] has been reserved
[    0.706148] system 00:01: [mem 0xfd200000-0xfd2fffff] has been reserved
[    0.706347] system 00:03: [io  0x0290-0x029f] has been reserved
[    0.706354] system 00:03: [io  0x0200-0x021f] has been reserved
[    0.706641] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.706649] system 00:04: [io  0x040b] has been reserved
[    0.706655] system 00:04: [io  0x04d6] has been reserved
[    0.706661] system 00:04: [io  0x0c00-0x0c01] has been reserved
[    0.706667] system 00:04: [io  0x0c14] has been reserved
[    0.706673] system 00:04: [io  0x0c50-0x0c51] has been reserved
[    0.706679] system 00:04: [io  0x0c52] has been reserved
[    0.706685] system 00:04: [io  0x0c6c] has been reserved
[    0.706691] system 00:04: [io  0x0c6f] has been reserved
[    0.706697] system 00:04: [io  0x0cd8-0x0cdf] has been reserved
[    0.706704] system 00:04: [io  0x0800-0x089f] has been reserved
[    0.706710] system 00:04: [io  0x0b00-0x0b0f] has been reserved
[    0.706716] system 00:04: [io  0x0b20-0x0b3f] has been reserved
[    0.706723] system 00:04: [io  0x0900-0x090f] has been reserved
[    0.706729] system 00:04: [io  0x0910-0x091f] has been reserved
[    0.706736] system 00:04: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.706743] system 00:04: [mem 0xfec01000-0xfec01fff] could not be reserved
[    0.706750] system 00:04: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    0.706757] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.706764] system 00:04: [mem 0xfed80000-0xfed8ffff] could not be reserved
[    0.706772] system 00:04: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.706779] system 00:04: [mem 0xff000000-0xffffffff] has been reserved
[    0.707359] pnp: PnP ACPI: found 5 devices
[    0.713538] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
[    0.713609] NET: Registered PF_INET protocol family
[    0.713784] IP idents hash table entries: 262144 (order: 9, 2097152
bytes, linear)
[    0.726442] tcp_listen_portaddr_hash hash table entries: 16384
(order: 6, 262144 bytes, linear)
[    0.726479] Table-perturb hash table entries: 65536 (order: 6,
262144 bytes, linear)
[    0.726623] TCP established hash table entries: 262144 (order: 9,
2097152 bytes, linear)
[    0.726946] TCP bind hash table entries: 65536 (order: 9, 2097152
bytes, linear)
[    0.727033] TCP: Hash tables configured (established 262144 bind 65536)
[    0.727183] MPTCP token hash table entries: 32768 (order: 7, 786432
bytes, linear)
[    0.727285] UDP hash table entries: 16384 (order: 8, 1048576 bytes, linear)
[    0.727404] UDP-Lite hash table entries: 16384 (order: 8, 1048576
bytes, linear)
[    0.727518] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.727529] NET: Registered PF_XDP protocol family
[    0.727556] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.727574] pci 0000:02:08.0: PCI bridge to [bus 04]
[    0.727582] pci 0000:02:08.0:   bridge window [mem 0xfc400000-0xfc4fffff]
[    0.727595] pci 0000:02:09.0: PCI bridge to [bus 05]
[    0.727603] pci 0000:02:09.0:   bridge window [mem 0xfc200000-0xfc3fffff]
[    0.727615] pci 0000:01:00.2: PCI bridge to [bus 02-05]
[    0.727623] pci 0000:01:00.2:   bridge window [mem 0xfc200000-0xfc4fffff]
[    0.727635] pci 0000:00:01.2: PCI bridge to [bus 01-05]
[    0.727642] pci 0000:00:01.2:   bridge window [mem 0xfc200000-0xfc5fffff]
[    0.727653] pci 0000:00:03.1: PCI bridge to [bus 06]
[    0.727659] pci 0000:00:03.1:   bridge window [io  0xf000-0xffff]
[    0.727666] pci 0000:00:03.1:   bridge window [mem 0xfb000000-0xfc0fffff]
[    0.727673] pci 0000:00:03.1:   bridge window [mem
0xd0000000-0xe20fffff 64bit pref]
[    0.727682] pci 0000:00:07.1: PCI bridge to [bus 07]
[    0.727693] pci 0000:00:08.1: PCI bridge to [bus 08]
[    0.727699] pci 0000:00:08.1:   bridge window [mem 0xfc600000-0xfc8fffff]
[    0.727709] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.727715] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.727720] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.727725] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.727730] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff window]
[    0.727735] pci_bus 0000:00: resource 9 [mem 0xd0000000-0xfec2ffff window]
[    0.727740] pci_bus 0000:00: resource 10 [mem 0xfee00000-0xffffffff window]
[    0.727746] pci_bus 0000:01: resource 1 [mem 0xfc200000-0xfc5fffff]
[    0.727751] pci_bus 0000:02: resource 1 [mem 0xfc200000-0xfc4fffff]
[    0.727757] pci_bus 0000:04: resource 1 [mem 0xfc400000-0xfc4fffff]
[    0.727762] pci_bus 0000:05: resource 1 [mem 0xfc200000-0xfc3fffff]
[    0.727767] pci_bus 0000:06: resource 0 [io  0xf000-0xffff]
[    0.727772] pci_bus 0000:06: resource 1 [mem 0xfb000000-0xfc0fffff]
[    0.727777] pci_bus 0000:06: resource 2 [mem 0xd0000000-0xe20fffff
64bit pref]
[    0.727783] pci_bus 0000:08: resource 1 [mem 0xfc600000-0xfc8fffff]
[    0.728053] pci 0000:06:00.1: extending delay after power-on from
D3hot to 20 msec
[    0.728092] pci 0000:06:00.1: D0 power state depends on 0000:06:00.0
[    0.728165] pci 0000:06:00.2: D0 power state depends on 0000:06:00.0
[    0.728312] pci 0000:06:00.3: D0 power state depends on 0000:06:00.0
[    0.728483] PCI: CLS 64 bytes, default 64
[    0.728507] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
[    0.728566] Trying to unpack rootfs image as initramfs...
[    0.728614] pci 0000:00:00.0: Adding to iommu group 0
[    0.728661] pci 0000:00:01.0: Adding to iommu group 1
[    0.728685] pci 0000:00:01.2: Adding to iommu group 2
[    0.728717] pci 0000:00:02.0: Adding to iommu group 3
[    0.728749] pci 0000:00:03.0: Adding to iommu group 4
[    0.728772] pci 0000:00:03.1: Adding to iommu group 5
[    0.728802] pci 0000:00:04.0: Adding to iommu group 6
[    0.728833] pci 0000:00:05.0: Adding to iommu group 7
[    0.728864] pci 0000:00:07.0: Adding to iommu group 8
[    0.728886] pci 0000:00:07.1: Adding to iommu group 9
[    0.728919] pci 0000:00:08.0: Adding to iommu group 10
[    0.728943] pci 0000:00:08.1: Adding to iommu group 11
[    0.728982] pci 0000:00:14.0: Adding to iommu group 12
[    0.729005] pci 0000:00:14.3: Adding to iommu group 12
[    0.729101] pci 0000:00:18.0: Adding to iommu group 13
[    0.729125] pci 0000:00:18.1: Adding to iommu group 13
[    0.729148] pci 0000:00:18.2: Adding to iommu group 13
[    0.729171] pci 0000:00:18.3: Adding to iommu group 13
[    0.729194] pci 0000:00:18.4: Adding to iommu group 13
[    0.729218] pci 0000:00:18.5: Adding to iommu group 13
[    0.729240] pci 0000:00:18.6: Adding to iommu group 13
[    0.729263] pci 0000:00:18.7: Adding to iommu group 13
[    0.729313] pci 0000:01:00.0: Adding to iommu group 14
[    0.729338] pci 0000:01:00.1: Adding to iommu group 14
[    0.729364] pci 0000:01:00.2: Adding to iommu group 14
[    0.729374] pci 0000:02:00.0: Adding to iommu group 14
[    0.729385] pci 0000:02:08.0: Adding to iommu group 14
[    0.729399] pci 0000:02:09.0: Adding to iommu group 14
[    0.729409] pci 0000:04:00.0: Adding to iommu group 14
[    0.729421] pci 0000:05:00.0: Adding to iommu group 14
[    0.729478] pci 0000:06:00.0: Adding to iommu group 15
[    0.729504] pci 0000:06:00.1: Adding to iommu group 15
[    0.729531] pci 0000:06:00.2: Adding to iommu group 15
[    0.729557] pci 0000:06:00.3: Adding to iommu group 15
[    0.729581] pci 0000:07:00.0: Adding to iommu group 16
[    0.729605] pci 0000:08:00.0: Adding to iommu group 17
[    0.729629] pci 0000:08:00.1: Adding to iommu group 18
[    0.729653] pci 0000:08:00.3: Adding to iommu group 19
[    0.729678] pci 0000:08:00.4: Adding to iommu group 20
[    0.733005] AMD-Vi: Extended features (0x58f77ef22294a5a, 0x0): PPR
NX GT IA PC GA_vAPIC
[    0.733026] AMD-Vi: Interrupt remapping enabled
[    0.733146] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.733152] software IO TLB: mapped [mem
0x00000000bcc22000-0x00000000c0c22000] (64MB)
[    0.733219] LVT offset 0 assigned for vector 0x400
[    0.733411] perf: AMD IBS detected (0x000003ff)
[    0.733580] amd_uncore: 4 amd_df counters detected
[    0.733593] amd_uncore: 6 amd_l3 counters detected
[    0.733770] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[    0.734669] Initialise system trusted keyrings
[    0.734683] Key type blacklist registered
[    0.734727] workingset: timestamp_bits=36 max_order=23 bucket_order=0
[    0.734741] zbud: loaded
[    0.734854] fuse: init (API version 7.42)
[    0.735019] integrity: Platform Keyring initialized
[    0.735029] integrity: Machine keyring initialized
[    0.754000] Key type asymmetric registered
[    0.754013] Asymmetric key parser 'x509' registered
[    1.047090] Freeing initrd memory: 128644K
[    1.051680] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 246)
[    1.051732] io scheduler mq-deadline registered
[    1.054013] ledtrig-cpu: registered to indicate activity on CPUs
[    1.054486] pcieport 0000:00:07.1: AER: enabled with IRQ 29
[    1.054648] pcieport 0000:00:08.1: AER: enabled with IRQ 30
[    1.055345] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.055986] Monitor-Mwait will be used to enter C-1 state
[    1.068609] Estimated ratio of average max frequency by base
frequency (times 1024): 1141
[    1.068871] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.069094] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud =
115200) is a 16550A
[    1.069601] Linux agpgart interface v0.103
[    1.144606] tpm_crb MSFT0101:00: Disabling hwrng
[    1.146233] i8042: PNP: No PS/2 controller found.
[    1.146286] mousedev: PS/2 mouse device common for all mice
[    1.146308] rtc_cmos 00:02: RTC can wake from S4
[    1.146532] rtc_cmos 00:02: registered as rtc0
[    1.146563] rtc_cmos 00:02: setting system clock to
2025-05-12T04:47:57 UTC (1747025277)
[    1.146595] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram
[    1.461573] Relocating firmware framebuffer to offset
0x0000000001000000[d] within [mem 0xe0000000-0xe1ffffff flags
0x14220c]
[    1.461608] efifb: probing for efifb
[    1.461623] efifb: framebuffer at 0xe1000000, using 8100k, total 8100k
[    1.461628] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    1.461634] efifb: scrolling: redraw
[    1.461637] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.464502] Console: switching to colour frame buffer device 240x67
[    1.467263] fb0: EFI VGA frame buffer device
[    1.467424] NET: Registered PF_INET6 protocol family
[    1.471487] Segment Routing with IPv6
[    1.471513] In-situ OAM (IOAM) with IPv6
[    1.471550] mip6: Mobile IPv6
[    1.471563] NET: Registered PF_PACKET protocol family
[    1.471615] mpls_gso: MPLS GSO support
[    1.473358] microcode: Current revision: 0x08701035
[    1.473860] resctrl: L3 allocation detected
[    1.473873] resctrl: MB allocation detected
[    1.473885] resctrl: L3 monitoring detected
[    1.473932] IPI shorthand broadcast: enabled
[    1.476147] sched_clock: Marking stable (1157361404,
316492394)->(1682926725, -209072927)
[    1.476371] registered taskstats version 1
[    1.476600] Loading compiled-in X.509 certificates
[    1.490794] Loaded X.509 cert 'Build time autogenerated kernel key:
4ab1e0607c945082e6d3ef06ade793e414b8b509'
[    1.493432] Demotion targets for Node 0: null
[    1.493594] Key type .fscrypt registered
[    1.493607] Key type fscrypt-provisioning registered
[    1.508679] Key type encrypted registered
[    1.508698] AppArmor: AppArmor sha256 policy hashing enabled
[    1.508817] integrity: Loading X.509 certificate: UEFI:db
[    1.509009] integrity: Loaded X.509 cert 'ASUSTeK MotherBoard SW
Key Certificate: da83b990422ebc8c441f8d8b039a65a2'
[    1.509039] integrity: Loading X.509 certificate: UEFI:db
[    1.509217] integrity: Loaded X.509 cert 'ASUSTeK Notebook SW Key
Certificate: b8e581e4df77a5bb4282d5ccfc00c071'
[    1.509246] integrity: Loading X.509 certificate: UEFI:db
[    1.509279] integrity: Loaded X.509 cert 'Microsoft Corporation
UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    1.509307] integrity: Loading X.509 certificate: UEFI:db
[    1.509336] integrity: Loaded X.509 cert 'Microsoft Windows
Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    1.509365] integrity: Loading X.509 certificate: UEFI:db
[    1.509512] integrity: Loaded X.509 cert 'Canonical Ltd. Master
Certificate Authority: ad91990bc22ab1f517048c23b6655a268e345a63'
[    1.511239] integrity: Loading X.509 certificate: UEFI:MokListRT
(MOKvar table)
[    1.511402] integrity: Loaded X.509 cert 'Debian Secure Boot CA:
6ccece7e4c6c0d1f6149f3dd27dfcc5cbb419ea1'
[    1.511428] integrity: Loading X.509 certificate: UEFI:MokListRT
(MOKvar table)
[    1.511577] integrity: Loaded X.509 cert 'DKMS module signing key:
9fe07c759f722866ced56b692b45f7c5a70d36bc'
[    1.511603] integrity: Loading X.509 certificate: UEFI:MokListRT
(MOKvar table)
[    1.512021] integrity: Loaded X.509 cert 'Mikon kernel-avain:
XXXXXXXXXXXXXXXXXXXXXXXX'
[    1.512049] ima: Allocated hash algorithm: sha256
[    1.602101] audit: type=1807 audit(1747025277.952:2):
action=measure func=KEXEC_KERNEL_CHECK res=1
[    1.602120] evm: Initialising EVM extended attributes:
[    1.602133] audit: type=1807 audit(1747025277.952:3):
action=measure func=MODULE_CHECK res=1
[    1.602148] evm: security.selinux
[    1.602919] evm: security.SMACK64 (disabled)
[    1.603660] evm: security.SMACK64EXEC (disabled)
[    1.604394] evm: security.SMACK64TRANSMUTE (disabled)
[    1.605130] evm: security.SMACK64MMAP (disabled)
[    1.605849] evm: security.apparmor
[    1.606558] evm: security.ima
[    1.607258] evm: security.capability
[    1.607950] evm: HMAC attrs: 0x1
[    1.609879] RAS: Correctable Errors collector initialized.
[    1.623154] Lockdown: swapper/0: hibernation is restricted; see man
kernel_lockdown.7
[    1.623913] clk: Disabling unused clocks
[    1.624629] PM: genpd: Disabling unused power domains
[    1.626928] Freeing unused decrypted memory: 2028K
[    1.628351] Freeing unused kernel image (initmem) memory: 4200K
[    1.629084] Write protecting the kernel read-only data: 28672k
[    1.630279] Freeing unused kernel image (text/rodata gap) memory: 876K
[    1.631100] Freeing unused kernel image (rodata/data gap) memory: 360K
[    1.690741] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.691448] Run /init as init process
[    1.692143]   with arguments:
[    1.692144]     /init
[    1.692146]     splash
[    1.692147]   with environment:
[    1.692149]     HOME=/
[    1.692150]     TERM=linux
[    1.692152]     BOOT_IMAGE=/boot/vmlinuz-6.14.5
[    1.707448] tpm tpm0: auth session is active
[    1.748507] tsc: Refined TSC clocksource calibration: 3792.873 MHz
[    1.749262] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x6d5818a734c, max_idle_ns: 881590694765 ns
[    1.750037] clocksource: Switched to clocksource tsc
[    1.850220] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.851041] ACPI: button: Power Button [PWRB]
[    1.851879] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    1.852774] ACPI: button: Power Button [PWRF]
[    1.903389] Intel(R) 2.5G Ethernet Linux Driver
[    1.904130] Copyright(c) 2018 Intel Corporation.
[    1.904935] igc 0000:05:00.0: PCIe PTM not supported by PCIe bus/controller
[    1.910278] piix4_smbus 0000:00:14.0: SMBus Host Controller at
0xb00, revision 0
[    1.911035] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus
port selection
[    1.913537] i2c i2c-1: Successfully instantiated SPD at 0x52
[    1.914877] i2c i2c-1: Successfully instantiated SPD at 0x53
[    1.915654] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host
Controller at 0xb20
[    1.921002] ACPI: bus type USB registered
[    1.921784] usbcore: registered new interface driver usbfs
[    1.922569] usbcore: registered new interface driver hub
[    1.923325] usbcore: registered new device driver usb
[    1.925563] SCSI subsystem initialized
[    1.943162] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    1.944048] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO address
[    1.948519] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec (nowayout=0)
[    1.958907] igc 0000:05:00.0 (unnamed net_device) (uninitialized): PHC added
[    1.962448] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    1.962747] libata version 3.00 loaded.
[    1.963200] xhci_hcd 0000:01:00.0: new USB bus registered, assigned
bus number 1
[    1.983870] igc 0000:05:00.0: 4.000 Gb/s available PCIe bandwidth
(5.0 GT/s PCIe x1 link)
[    1.984623] igc 0000:05:00.0 eth0: MAC: d4:5d:64:d7:c3:fe
[    2.019392] xhci_hcd 0000:01:00.0: hcc params 0x0200ef81 hci
version 0x110 quirks 0x0000000000000010
[    2.020434] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    2.021163] xhci_hcd 0000:01:00.0: new USB bus registered, assigned
bus number 2
[    2.021878] xhci_hcd 0000:01:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[    2.022645] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 6.14
[    2.023352] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.024046] usb usb1: Product: xHCI Host Controller
[    2.024740] usb usb1: Manufacturer: Linux 6.14.5 xhci-hcd
[    2.025426] usb usb1: SerialNumber: 0000:01:00.0
[    2.026331] hub 1-0:1.0: USB hub found
[    2.027049] hub 1-0:1.0: 10 ports detected
[    2.027824] igc 0000:05:00.0 enp5s0: renamed from eth0
[    2.036777] ahci 0000:01:00.1: version 3.0
[    2.037163] ahci 0000:01:00.1: SSS flag set, parallel bus scan disabled
[    2.037863] ahci 0000:01:00.1: AHCI vers 0001.0301, 32 command
slots, 6 Gbps, SATA mode
[    2.038504] ahci 0000:01:00.1: 6/6 ports implemented (port mask 0x3f)
[    2.039137] ahci 0000:01:00.1: flags: 64bit ncq sntf stag pm led
clo only pmp pio slum part sxs deso sadm sds apst
[    2.040416] scsi host0: ahci
[    2.041019] usb usb2: We don't know the algorithms for LPM for this
host, disabling LPM.
[    2.041367] scsi host1: ahci
[    2.041732] usb usb2: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 6.14
[    2.042603] scsi host2: ahci
[    2.043026] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.043945] scsi host3: ahci
[    2.044376] usb usb2: Product: xHCI Host Controller
[    2.045361] scsi host4: ahci
[    2.045758] usb usb2: Manufacturer: Linux 6.14.5 xhci-hcd
[    2.046731] scsi host5: ahci
[    2.047131] usb usb2: SerialNumber: 0000:01:00.0
[    2.047881] ata1: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580100 irq 50 lpm-pol 3
[    2.048725] hub 2-0:1.0: USB hub found
[    2.049187] ata2: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580180 irq 50 lpm-pol 3
[    2.049884] hub 2-0:1.0: 4 ports detected
[    2.050569] ata3: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580200 irq 50 lpm-pol 3
[    2.051985] ata4: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580280 irq 50 lpm-pol 3
[    2.052704] ata5: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580300 irq 50 lpm-pol 3
[    2.053412] ata6: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580380 irq 50 lpm-pol 3
[    2.057060] xhci_hcd 0000:06:00.2: xHCI Host Controller
[    2.057765] xhci_hcd 0000:06:00.2: new USB bus registered, assigned
bus number 3
[    2.059067] xhci_hcd 0000:06:00.2: hcc params 0x0180ff05 hci
version 0x110 quirks 0x0000000000000010
[    2.059933] xhci_hcd 0000:06:00.2: xHCI Host Controller
[    2.060638] xhci_hcd 0000:06:00.2: new USB bus registered, assigned
bus number 4
[    2.061333] xhci_hcd 0000:06:00.2: Host supports USB 3.1 Enhanced SuperSpeed
[    2.062067] usb usb3: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 6.14
[    2.062761] usb usb3: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.063447] usb usb3: Product: xHCI Host Controller
[    2.064124] usb usb3: Manufacturer: Linux 6.14.5 xhci-hcd
[    2.064809] usb usb3: SerialNumber: 0000:06:00.2
[    2.065684] hub 3-0:1.0: USB hub found
[    2.066387] hub 3-0:1.0: 2 ports detected
[    2.067163] usb usb4: We don't know the algorithms for LPM for this
host, disabling LPM.
[    2.067865] usb usb4: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 6.14
[    2.068550] usb usb4: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.069234] usb usb4: Product: xHCI Host Controller
[    2.069909] usb usb4: Manufacturer: Linux 6.14.5 xhci-hcd
[    2.070581] usb usb4: SerialNumber: 0000:06:00.2
[    2.071337] hub 4-0:1.0: USB hub found
[    2.072013] hub 4-0:1.0: 4 ports detected
[    2.072911] xhci_hcd 0000:08:00.3: xHCI Host Controller
[    2.073585] xhci_hcd 0000:08:00.3: new USB bus registered, assigned
bus number 5
[    2.074362] xhci_hcd 0000:08:00.3: hcc params 0x0278ffe5 hci
version 0x110 quirks 0x0000000000000010
[    2.075298] xhci_hcd 0000:08:00.3: xHCI Host Controller
[    2.075976] xhci_hcd 0000:08:00.3: new USB bus registered, assigned
bus number 6
[    2.076661] xhci_hcd 0000:08:00.3: Host supports USB 3.1 Enhanced SuperSpeed
[    2.077371] usb usb5: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 6.14
[    2.078055] usb usb5: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.078732] usb usb5: Product: xHCI Host Controller
[    2.079401] usb usb5: Manufacturer: Linux 6.14.5 xhci-hcd
[    2.080065] usb usb5: SerialNumber: 0000:08:00.3
[    2.080840] hub 5-0:1.0: USB hub found
[    2.081501] hub 5-0:1.0: 4 ports detected
[    2.082358] usb usb6: We don't know the algorithms for LPM for this
host, disabling LPM.
[    2.083042] usb usb6: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 6.14
[    2.083703] usb usb6: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.084359] usb usb6: Product: xHCI Host Controller
[    2.085022] usb usb6: Manufacturer: Linux 6.14.5 xhci-hcd
[    2.085683] usb usb6: SerialNumber: 0000:08:00.3
[    2.086441] hub 6-0:1.0: USB hub found
[    2.087102] hub 6-0:1.0: 4 ports detected
[    2.332502] usb 5-4: new high-speed USB device number 2 using xhci_hcd
[    2.352516] usb 1-5: new full-speed USB device number 2 using xhci_hcd
[    2.363410] ata1: SATA link down (SStatus 0 SControl 330)
[    2.471883] usb 5-4: New USB device found, idVendor=05e3,
idProduct=0608, bcdDevice=77.63
[    2.472584] usb 5-4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    2.473250] usb 5-4: Product: USB2.0 Hub
[    2.527009] hub 5-4:1.0: USB hub found
[    2.528129] hub 5-4:1.0: 4 ports detected
[    2.674796] ata2: SATA link down (SStatus 0 SControl 330)
[    2.741159] usb 1-5: New USB device found, idVendor=8087,
idProduct=0029, bcdDevice= 0.01
[    2.741814] usb 1-5: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.812520] usb 5-4.4: new full-speed USB device number 3 using xhci_hcd
[    2.920398] usb 5-4.4: New USB device found, idVendor=046d,
idProduct=c52b, bcdDevice=12.10
[    2.921065] usb 5-4.4: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[    2.921721] usb 5-4.4: Product: USB Receiver
[    2.922370] usb 5-4.4: Manufacturer: Logitech
[    2.940525] usb 1-6: new full-speed USB device number 3 using xhci_hcd
[    3.144533] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.145727] ata3.00: ATA-10: WDC WD20EFAX-68FB5N0, 82.00A82, max UDMA/133
[    3.157255] ata3.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    3.157898] ata3.00: Features: NCQ-prio
[    3.170298] ata3.00: configured for UDMA/133
[    3.171204] scsi 2:0:0:0: Direct-Access     ATA      WDC
WD20EFAX-68F 0A82 PQ: 0 ANSI: 5
[    3.311749] usb 1-6: config 1 has an invalid interface number: 2 but max is 1
[    3.312410] usb 1-6: config 1 has no interface number 1
[    3.324750] usb 1-6: New USB device found, idVendor=0b05,
idProduct=1939, bcdDevice= 1.00
[    3.325411] usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.326064] usb 1-6: Product: AURA LED Controller
[    3.326711] usb 1-6: Manufacturer: AsusTek Computer Inc.
[    3.327354] usb 1-6: SerialNumber: 9876543210
[    3.520525] usb 1-7: new high-speed USB device number 4 using xhci_hcd
[    3.640525] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.641685] ata4.00: ATA-10: WDC WD20EFAX-68FB5N0, 82.00A82, max UDMA/133
[    3.653202] ata4.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    3.653851] ata4.00: Features: NCQ-prio
[    3.666256] ata4.00: configured for UDMA/133
[    3.667073] scsi 3:0:0:0: Direct-Access     ATA      WDC
WD20EFAX-68F 0A82 PQ: 0 ANSI: 5
[    3.744241] usb 1-7: New USB device found, idVendor=05e3,
idProduct=0610, bcdDevice=60.60
[    3.744908] usb 1-7: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    3.745564] usb 1-7: Product: USB2.0 Hub
[    3.754276] hub 1-7:1.0: USB hub found
[    3.758230] hub 1-7:1.0: 4 ports detected
[    4.136525] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    4.139469] ata5.00: ATA-8: WDC WD5000AAKX-001CA0, 15.01H15, max UDMA/133
[    4.140520] ata5.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    4.143578] ata5.00: configured for UDMA/133
[    4.144380] scsi 4:0:0:0: Direct-Access     ATA      WDC
WD5000AAKX-0 1H15 PQ: 0 ANSI: 5
[    4.612528] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    4.613676] ata6.00: ATAPI: TSSTcorp CDDVDW SH-S223F, SB03, max UDMA/100
[    4.615058] ata6.00: configured for UDMA/100
[    4.616809] scsi 5:0:0:0: CD-ROM            TSSTcorp CDDVDW
SH-S223F  SB03 PQ: 0 ANSI: 5
[    4.714721] sd 2:0:0:0: [sda] 3907029168 512-byte logical blocks:
(2.00 TB/1.82 TiB)
[    4.714725] sd 4:0:0:0: [sdc] 976773168 512-byte logical blocks:
(500 GB/466 GiB)
[    4.714727] sd 3:0:0:0: [sdb] 3907029168 512-byte logical blocks:
(2.00 TB/1.82 TiB)
[    4.714730] sd 3:0:0:0: [sdb] 4096-byte physical blocks
[    4.714756] sd 3:0:0:0: [sdb] Write Protect is off
[    4.714761] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    4.714777] sd 3:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    4.714801] sd 3:0:0:0: [sdb] Preferred minimum I/O size 4096 bytes
[    4.715416] sd 2:0:0:0: [sda] 4096-byte physical blocks
[    4.715426] sd 2:0:0:0: [sda] Write Protect is off
[    4.716186] sd 4:0:0:0: [sdc] Write Protect is off
[    4.716811] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.716867] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    4.717485] sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    4.717503] sd 4:0:0:0: [sdc] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    4.718228] sd 2:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
[    4.718861] sd 4:0:0:0: [sdc] Preferred minimum I/O size 512 bytes
[    4.731337] hid: raw HID events driver (C) Jiri Kosina
[    4.813103]  sdc: sdc1 sdc2 sdc3 sdc4
[    4.813953] sd 4:0:0:0: [sdc] Attached SCSI disk
[    4.945091]  sdb: sdb1 sdb2 sdb3 sdb4
[    4.945923] sd 3:0:0:0: [sdb] Attached SCSI disk
[    5.067898]  sda: sda1 sda2 sda3 sda4
[    5.068736] sd 2:0:0:0: [sda] Attached SCSI disk
[    5.100598] usbcore: registered new interface driver usbhid
[    5.101258] usbhid: USB HID core driver
[    5.112608] input: Logitech USB Receiver as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.0/0003:046D:C52B.0001/input/input2
[    5.122439] sr 5:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer
dvd-ram cd/rw xa/form2 cdda tray
[    5.123130] cdrom: Uniform CD-ROM driver Revision: 3.20
[    5.177223] sr 5:0:0:0: Attached scsi CD-ROM sr0
[    5.296577] hid-generic 0003:046D:C52B.0001: input,hidraw0: USB HID
v1.11 Keyboard [Logitech USB Receiver] on usb-0000:08:00.3-4.4/input0
[    5.297531] input: Logitech USB Receiver Mouse as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.1/0003:046D:C52B.0002/input/input3
[    5.298365] input: Logitech USB Receiver Consumer Control as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.1/0003:046D:C52B.0002/input/input4
[    5.352569] input: Logitech USB Receiver System Control as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.1/0003:046D:C52B.0002/input/input5
[    5.353414] hid-generic 0003:046D:C52B.0002: input,hiddev0,hidraw1:
USB HID v1.11 Mouse [Logitech USB Receiver] on
usb-0000:08:00.3-4.4/input1
[    5.354356] hid-generic 0003:046D:C52B.0003: hiddev1,hidraw2: USB
HID v1.11 Device [Logitech USB Receiver] on
usb-0000:08:00.3-4.4/input2
[    5.355255] hid-generic 0003:0B05:1939.0004: hiddev2,hidraw3: USB
HID v1.11 Device [AsusTek Computer Inc. AURA LED Controller] on
usb-0000:01:00.0-6/input2
[    5.645119] logitech-djreceiver 0003:046D:C52B.0003:
hiddev0,hidraw0: USB HID v1.11 Device [Logitech USB Receiver] on
usb-0000:08:00.3-4.4/input2
[    5.766007] input: Logitech Wireless Device PID:4050 Keyboard as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.2/0003:046D:C52B.0003/0003:046D:4050.0005/input/input7
[    5.782604] md/raid1:md1: active with 2 out of 2 mirrors
[    5.783437] md1: detected capacity change from 0 to 195178496
[    5.838938] md/raid1:md2: active with 2 out of 2 mirrors
[    5.864566] input: Logitech Wireless Device PID:4050 Mouse as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.2/0003:046D:C52B.0003/0003:046D:4050.0005/input/input8
[    5.865526] hid-generic 0003:046D:4050.0005: input,hidraw1: USB HID
v1.11 Keyboard [Logitech Wireless Device PID:4050] on
usb-0000:08:00.3-4.4/input2:1
[    5.871800] input: Logitech K270 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.2/0003:046D:C52B.0003/0003:046D:4003.0006/input/input12
[    5.970362] md2: detected capacity change from 0 to 3671392256
[    5.972763] md/raid1:md0: active with 2 out of 2 mirrors
[    5.973675] md0: detected capacity change from 0 to 39026688
[    6.164592] logitech-hidpp-device 0003:046D:4003.0006:
input,hidraw2: USB HID v1.11 Keyboard [Logitech K270] on
usb-0000:08:00.3-4.4/input2:2
[    6.189729] input: Logitech M335 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb5/5-4/5-4.4/5-4.4:1.2/0003:046D:C52B.0003/0003:046D:4050.0005/input/input13
[    6.304609] logitech-hidpp-device 0003:046D:4050.0005:
input,hidraw1: USB HID v1.11 Keyboard [Logitech M335] on
usb-0000:08:00.3-4.4/input2:1
[   11.744506] raid6: avx2x4   gen() 29608 MB/s
[   11.812506] raid6: avx2x2   gen() 29520 MB/s
[   11.880506] raid6: avx2x1   gen() 26945 MB/s
[   11.881453] raid6: using algorithm avx2x4 gen() 29608 MB/s
[   11.948506] raid6: .... xor() 7749 MB/s, rmw enabled
[   11.949446] raid6: using avx2x2 recovery algorithm
[   11.957678] xor: automatically using best checksumming function   avx
[   11.965473] async_tx: api initialized (async)
[   21.765647] logitech-hidpp-device 0003:046D:4003.0006: HID++ 2.0
device connected.
[   44.582077] EXT4-fs (md1): mounted filesystem
c056bf20-f617-4c4a-8d3c-28ac04ff6a3a ro with ordered data mode. Quota
mode: none.
[   45.067652] Not activating Mandatory Access Control as
/sbin/tomoyo-init does not exist.
