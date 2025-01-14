Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943E61CDFB9;
	Tue, 14 Jan 2025 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877094; cv=none; b=CUOet0QbPSEctHs4qUM4NqNo5RYSep8Sytp3gEI51z2i8c68cX0AvpKNzieNMN60f+vS3OGp0TeTGeJKqtSVFP7Ogw72g/cIcDLxHHSeNs17EBgBBjMmZaqGZi1Q+z1N6aZm7CtcpWremYEDZF/Sbt2gYU4kBkxJKuob5hucZpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877094; c=relaxed/simple;
	bh=oymEBkHDWxbCHtHQfBNh5merdn5lVDnB47OzX2xYqJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eym9orHvm1IxN9BIPE8/z2xSEWN4pVfURquaFCnClCUrFKY4QmLYKBwKjOOVfYgE4owoiMRZOvOEc3PU3sqoRyrQJIjjGOaGlct7DGdI3wbIi485vwOLTbZP41Cjlyw/tn+b5lwA0WZxaCM883P4H1tdQ/xhb/mlcMIZqiUWTT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=2QvU/tyS; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="2QvU/tyS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1736877081; x=1737481881; i=christian@heusel.eu;
	bh=x7NuAWgsEeZzgAIY87PGTUvwN2L86wPxtotoarnj4Ng=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=2QvU/tySFHafp+VeAwd8ltsEVELVqP1YESs5bAA7c3oFT8/pwnjrhV5QFmoOjgpu
	 Onf8UIPs/t/My//A1mvipRS7lYH63N2e+LWL2isWABHMgMZ9A5kIK1ub/YTbSPTbc
	 2kbdjOGSh0q4I0lk/aOGXL8gdtEXuuShPKzsalBX/uC2VOl/Xu/t4mVM75bU6+/5L
	 AtFQQpcwB0HnzMz+flwE5f5Vl8ggxDZ6FZrQfmyljiVniGXN/0D1FnRpyRRwLqAvA
	 9A8szG0brAYqiYUSZKhWpDaskvtXP43EHFdKEk5pnjlnWPSWUJRpMyUByxRc5bnUN
	 b5kv4kFfHLyKJXaKNw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mi2aH-1t37HN3GQT-00jRfR; Tue, 14
 Jan 2025 18:51:20 +0100
Date: Tue, 14 Jan 2025 18:51:19 +0100
From: Christian Heusel <christian@heusel.eu>
To: Niklas Cassel <cassel@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION][BISECTED] BU40N Blu-Ray drive broken since
 7627a0edef54
Message-ID: <f7583d39-890f-4a7f-a5fb-63379e0c9304@heusel.eu>
References: <e2be6f70-dff6-4b79-bd49-70ec7e27fc1c@heusel.eu>
 <Z4EDf4ecHyfTq3Hp@x1-carbon>
 <69589dad-c0c8-4a72-9f3d-c1b0c29c96c1@heusel.eu>
 <e167b28c-94a2-45bf-8330-2487baf7199b@heusel.eu>
 <Z4U-rc3VUeegHGAg@ryzen>
 <Z4aLWmt1Y2jL1-pD@ryzen>
 <5232263d-5836-402d-9c5e-e3c601181080@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ky3dumliyn4zlzno"
Content-Disposition: inline
In-Reply-To: <5232263d-5836-402d-9c5e-e3c601181080@heusel.eu>
X-Provags-ID: V03:K1:a1wbkac0Vv/LXTq9svX6ca7D+RXUz08kkTz1dS9HT3KjdgrSUPh
 r5ChFkpVC8Pa+i6nV8TG4ew6/G/R8AiQdY8tfMq7fftj2zWPGSolCkW5DFvVSG9oHX/ue2J
 mdJqFGIYuZ/u0JQiXW6oViceNqUQYffzY3Va3Y2PM+taNwtuS8YDkYjm6I7GLVC+xn50dXW
 xbG4lwY6f6fdZ3JGCXuOw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lFA7GuNL8c0=;Tt0jT6w5641tm8bNTiJXKgHwzjq
 cT4N4+tANAMVkgugZyz/kdh/c70awUJuISY5BDJjkAnQyHBTAffj++PSuxVUFkzwBTJcxztMp
 05PopEsCCBkxPuNxQh41Af2yyjUixo+LSKpNFfIdgBlbQxMeQldNddBakegHdBn7oYFdxeepU
 l/1JVpgO2Kygsapn5+2d6NXSVt5Kh5U99UlFcMLBAH0j485A0SFSGOcJzhydYqFo1UnAcYFLF
 i8xF9qy9si0PsS5ACqEwoSpT1zo09J6nderSVePOdUiGQ+vbEPQ55PGTSaZb4nFPbALUxIQuh
 PMG5vzQzVX25pFgDqsVMPyKyF6lLwL1kc5eAcJHv8FgE4mRFJE452glWK6u2XTWwH4/mkBHhk
 D+kqmSMgnjA8R+QfTf/sTsjSWSwKkIrxsxGEmRJ1c21l3mPkbGUPNRkdEBDNEWvM9mszIvq0U
 rXG4ZKjq7TBpYt0oBln0ktfdWkm0+gQPlpAOeUnGbFzE5eQMjVC3/eQTcsfOymOcAOJJ0r6j7
 Of+S6dCIPV5fL4dOAZepmR0pPzvBj/qQmL/rm2PZz8XNKG4anXiDNQpj5cvUC73T5eZVfgN6A
 +ABShtHEC6jcHD0PHm8HeMLUZ5/sEhHjPPNj0sD8EUGBdHvNZV/8Yki2hC9BoP7AE+BcBTJ+3
 hSuWgTg4egYOX1yTZW2MXbRLWQ/tg02HKq7aib+4/Q9Q6/K2nP0X16M4jp5+/gGLINEhEdH/s
 v9jWGvpKFV2/xog1p/bSfMefZppmC7ri/iD4GVtfDiNl787I0nwUiAGfxYJe21cAnpn9vrBCv
 Et+yo5KASnbme9ioU5mK6dQKcCOQ1yfKZMILKxFFcdXUIZgSf8EWmUeHGA29FKMM1t+8Yk6CO
 Ca9xewLlWiiGKxSsy4fmBPzVZPP5HzYhgtfLPzOw9jKWXxbMNy7TMrZ8t9CrZhbfpXL+2SLo4
 ZzYhSEX6m+eyF7OhOZlxULQ8Uu1mCeKpsBVFvN9hqX5OU+YEjY+VMkLSeQi9VgEG2idHhgytz
 L3d+vyuaBJ0w3j3rWoYa+Z3A2l1ADx8F+kxrIRr


--ky3dumliyn4zlzno
Content-Type: multipart/mixed; protected-headers=v1;
	boundary="moyzeq6yvypjnw4h"
Content-Disposition: inline
Subject: Re: [REGRESSION][BISECTED] BU40N Blu-Ray drive broken since
 7627a0edef54
MIME-Version: 1.0


--moyzeq6yvypjnw4h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25/01/14 05:40PM, Christian Heusel wrote:
> On 25/01/14 05:05PM, Niklas Cassel wrote:
> > Hello Christian,
>=20
> Hello Niklas,

Hello Niklas,

>=20
> > Looking at the Arch Linux thread, it seems that the person reporting the
> > problem says that even on a working kernel, you only see the device the
> > user presses the open button on the Blu-Ray player.
> >=20
> > This suggests to me that it sends a hotplug/PhyRdy event when the user
> > presses the open button.
> >=20
> > In Linux, if we don't detect anything connected to the port during init=
ial
> > boot, and if the port is not marked (by firmware) as either Hotplug Cap=
able,
> > or External, then we mask the PhyRdy interrupt.
> >=20
> > We could reconsider this, and leave the PhyRdy interrupt enabled even f=
or a
> > port that is not Hotplug Capable or External, if there is no devices de=
tected
> > on the port.
> >=20
> >=20
> > However, a device should really show up after a COMRESET... A device th=
at
> > does not do so seems to be non-spec compliant.
> > It would be nice if we could understand why this device does not show up
> > after a COMRESET. (If it did, we most likely would not need the workaro=
und
> > suggested above.)
> >=20
> > Could you please run with this debug prints, which might tell us what is
> > going on:
>=20
> Thanks for investigating this further, I was typing my previous mail and
> sent it just after yours because I didn't see it x)
>=20
> > diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> > <snip-patch>
>=20
> Building a kernel with the patch applied just now! I will get back to
> you once I have heard back from the user.

I have attached the dmesg from the boot with the debug patches.

> On a sidenote it seems like your mail client or something converts the
> tabs to spaces on these inline patches, which makes them quite hard to
> apply for me (I had to manually apply and format-patch).
> Could add them as attachment in the future or reply via git send-mail?
>=20
> > Kind regards,
> > Niklas
>=20
> Cheers,
> Chris

Cheers,
Chris

--moyzeq6yvypjnw4h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="linux-mainline-6.13-rc7-1.2-dmesg.log"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Linux version 6.13.0-rc7-1.2-mainline-dirty (linux-mainline@=
archlinux) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU Binutils) 2.43.1) #1 SMP=
 PREEMPT_DYNAMIC Tue, 14 Jan 2025 16:39:37 +0000
[    0.000000] Command line: initrd=3D\intel-ucode.img initrd=3D\initramfs-=
linux-mainline.img root=3D/dev/nvme0n1p1 rw intel_iommu=3Don
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000008a26ffff] usable
[    0.000000] BIOS-e820: [mem 0x000000008a270000-0x000000008a6a4fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000008a6a5000-0x000000008a721fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000008a722000-0x000000008ab95fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000008ab96000-0x000000008dc0dfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000008dc0e000-0x000000008dc0efff] usable
[    0.000000] BIOS-e820: [mem 0x000000008dc0f000-0x000000008fffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000046dffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] e820: update [mem 0x7bf1e018-0x7bf3c457] usable =3D=3D> usab=
le
[    0.000000] e820: update [mem 0x7bf0f018-0x7bf1d057] usable =3D=3D> usab=
le
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ef=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000000009f000-0x00000000000fff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000007bf0f0=
17] usable
[    0.000000] reserve setup_data: [mem 0x000000007bf0f018-0x000000007bf1d0=
57] usable
[    0.000000] reserve setup_data: [mem 0x000000007bf1d058-0x000000007bf1e0=
17] usable
[    0.000000] reserve setup_data: [mem 0x000000007bf1e018-0x000000007bf3c4=
57] usable
[    0.000000] reserve setup_data: [mem 0x000000007bf3c458-0x000000008a26ff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000008a270000-0x000000008a6a4f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x000000008a6a5000-0x000000008a721f=
ff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000008a722000-0x000000008ab95f=
ff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000008ab96000-0x000000008dc0df=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x000000008dc0e000-0x000000008dc0ef=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000008dc0f000-0x000000008fffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000e0000000-0x00000000efffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fe000000-0x00000000fe010f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed00000-0x00000000fed03f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000046dffff=
ff] usable
[    0.000000] efi: EFI v2.7 by American Megatrends
[    0.000000] efi: ACPI 2.0=3D0x8a6be000 ACPI=3D0x8a6be000 TPMFinalLog=3D0=
x8ab1e000 SMBIOS=3D0x8d9a5000 SMBIOS 3.0=3D0x8d9a4000 MEMATTR=3D0x86e08098 =
ESRT=3D0x88b80398 RNG=3D0x8a6bdf18 INITRD=3D0x80e3f298 TPMEventLog=3D0x8a6b=
4018=20
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem46: MMIO range=3D[0xe0000000-0xefffffff] (256=
MB) from e820 map
[    0.000000] e820: remove [mem 0xe0000000-0xefffffff] reserved
[    0.000000] efi: Not removing mem47: MMIO range=3D[0xfe000000-0xfe010fff=
] (68KB) from e820 map
[    0.000000] efi: Not removing mem48: MMIO range=3D[0xfec00000-0xfec00fff=
] (4KB) from e820 map
[    0.000000] efi: Not removing mem49: MMIO range=3D[0xfed00000-0xfed03fff=
] (16KB) from e820 map
[    0.000000] efi: Not removing mem50: MMIO range=3D[0xfee00000-0xfee00fff=
] (4KB) from e820 map
[    0.000000] efi: Remove mem51: MMIO range=3D[0xff000000-0xffffffff] (16M=
B) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.2.0 present.
[    0.000000] DMI: HP HP Pavilion Desktop TP01-0xxx/8653, BIOS F.37 10/26/=
2023
[    0.000000] DMI: Memory slots populated: 2/2
[    0.000000] tsc: Detected 3000.000 MHz processor
[    0.000902] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000905] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000913] last_pfn =3D 0x46e000 max_arch_pfn =3D 0x400000000
[    0.000918] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built fr=
om 10 variable MTRRs
[    0.000920] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.001193] last_pfn =3D 0x8dc0f max_arch_pfn =3D 0x400000000
[    0.008646] esrt: Reserving ESRT space from 0x0000000088b80398 to 0x0000=
000088b80420.
[    0.008651] e820: update [mem 0x88b80000-0x88b80fff] usable =3D=3D> rese=
rved
[    0.008667] Using GB pages for direct mapping
[    0.008990] Secure boot disabled
[    0.008991] RAMDISK: [mem 0x7bf3d000-0x7d400fff]
[    0.009011] ACPI: Early table checksum verification disabled
[    0.009014] ACPI: RSDP 0x000000008A6BE000 000024 (v02 HPQOEM)
[    0.009017] ACPI: XSDT 0x000000008A6BE0C0 0000FC (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009023] ACPI: FACP 0x000000008A704DC8 000114 (v06 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009027] ACPI: DSDT 0x000000008A6BE248 046B7A (v02 HPQOEM SLIC-CPC 01=
072009 INTL 20160527)
[    0.009030] ACPI: FACS 0x000000008AB93080 000040
[    0.009032] ACPI: APIC 0x000000008A704EE0 0000BC (v04 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009035] ACPI: FPDT 0x000000008A704FA0 000044 (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009038] ACPI: FIDT 0x000000008A704FE8 00009C (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009041] ACPI: MCFG 0x000000008A705088 00003C (v01 HPQOEM SLIC-CPC 01=
072009 MSFT 00000097)
[    0.009043] ACPI: SSDT 0x000000008A7050C8 001B5F (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.009046] ACPI: MSDM 0x000000008A706C28 000055 (v03 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009049] ACPI: SSDT 0x000000008A706C80 000060 (v01 HPQOEM SLIC-CPC 00=
000001 INTL 20160527)
[    0.009051] ACPI: SSDT 0x000000008A706CE0 000060 (v01 HPQOEM SLIC-CPC 00=
000001 INTL 20160527)
[    0.009054] ACPI: SSDT 0x000000008A706D40 0031C6 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.009056] ACPI: SSDT 0x000000008A709F08 00241B (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009059] ACPI: HPET 0x000000008A70C328 000038 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009062] ACPI: SSDT 0x000000008A70C360 001D39 (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009064] ACPI: SSDT 0x000000008A70E0A0 000FAE (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009067] ACPI: SSDT 0x000000008A70F050 000BDF (v02 HPQOEM SLIC-CPC 00=
000000 INTL 20160527)
[    0.009069] ACPI: UEFI 0x000000008A70FC30 000042 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009072] ACPI: LPIT 0x000000008A70FC78 000094 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009074] ACPI: SSDT 0x000000008A70FD10 0027DE (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009077] ACPI: SSDT 0x000000008A7124F0 0014E2 (v02 HPQOEM SLIC-CPC 00=
000000 INTL 20160527)
[    0.009080] ACPI: DBGP 0x000000008A7139D8 000034 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009082] ACPI: DBG2 0x000000008A713A10 000054 (v00 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009085] ACPI: SSDT 0x000000008A713A68 001B67 (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009087] ACPI: DMAR 0x000000008A7155D0 000070 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009090] ACPI: VFCT 0x000000008A715640 00B284 (v01 HPQOEM SLIC-CPC 00=
000001 AMD  31504F47)
[    0.009093] ACPI: BGRT 0x000000008A7208C8 000038 (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009095] ACPI: TPM2 0x000000008A720900 000034 (v04 HPQOEM SLIC-CPC 00=
000001 AMI  00000000)
[    0.009098] ACPI: WSMT 0x000000008A720938 000028 (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009100] ACPI: Reserving FACP table memory at [mem 0x8a704dc8-0x8a704=
edb]
[    0.009101] ACPI: Reserving DSDT table memory at [mem 0x8a6be248-0x8a704=
dc1]
[    0.009102] ACPI: Reserving FACS table memory at [mem 0x8ab93080-0x8ab93=
0bf]
[    0.009103] ACPI: Reserving APIC table memory at [mem 0x8a704ee0-0x8a704=
f9b]
[    0.009104] ACPI: Reserving FPDT table memory at [mem 0x8a704fa0-0x8a704=
fe3]
[    0.009105] ACPI: Reserving FIDT table memory at [mem 0x8a704fe8-0x8a705=
083]
[    0.009105] ACPI: Reserving MCFG table memory at [mem 0x8a705088-0x8a705=
0c3]
[    0.009106] ACPI: Reserving SSDT table memory at [mem 0x8a7050c8-0x8a706=
c26]
[    0.009107] ACPI: Reserving MSDM table memory at [mem 0x8a706c28-0x8a706=
c7c]
[    0.009108] ACPI: Reserving SSDT table memory at [mem 0x8a706c80-0x8a706=
cdf]
[    0.009108] ACPI: Reserving SSDT table memory at [mem 0x8a706ce0-0x8a706=
d3f]
[    0.009109] ACPI: Reserving SSDT table memory at [mem 0x8a706d40-0x8a709=
f05]
[    0.009110] ACPI: Reserving SSDT table memory at [mem 0x8a709f08-0x8a70c=
322]
[    0.009111] ACPI: Reserving HPET table memory at [mem 0x8a70c328-0x8a70c=
35f]
[    0.009111] ACPI: Reserving SSDT table memory at [mem 0x8a70c360-0x8a70e=
098]
[    0.009112] ACPI: Reserving SSDT table memory at [mem 0x8a70e0a0-0x8a70f=
04d]
[    0.009113] ACPI: Reserving SSDT table memory at [mem 0x8a70f050-0x8a70f=
c2e]
[    0.009114] ACPI: Reserving UEFI table memory at [mem 0x8a70fc30-0x8a70f=
c71]
[    0.009115] ACPI: Reserving LPIT table memory at [mem 0x8a70fc78-0x8a70f=
d0b]
[    0.009115] ACPI: Reserving SSDT table memory at [mem 0x8a70fd10-0x8a712=
4ed]
[    0.009116] ACPI: Reserving SSDT table memory at [mem 0x8a7124f0-0x8a713=
9d1]
[    0.009117] ACPI: Reserving DBGP table memory at [mem 0x8a7139d8-0x8a713=
a0b]
[    0.009118] ACPI: Reserving DBG2 table memory at [mem 0x8a713a10-0x8a713=
a63]
[    0.009118] ACPI: Reserving SSDT table memory at [mem 0x8a713a68-0x8a715=
5ce]
[    0.009119] ACPI: Reserving DMAR table memory at [mem 0x8a7155d0-0x8a715=
63f]
[    0.009120] ACPI: Reserving VFCT table memory at [mem 0x8a715640-0x8a720=
8c3]
[    0.009121] ACPI: Reserving BGRT table memory at [mem 0x8a7208c8-0x8a720=
8ff]
[    0.009122] ACPI: Reserving TPM2 table memory at [mem 0x8a720900-0x8a720=
933]
[    0.009122] ACPI: Reserving WSMT table memory at [mem 0x8a720938-0x8a720=
95f]
[    0.009445] No NUMA configuration found
[    0.009446] Faking a node at [mem 0x0000000000000000-0x000000046dffffff]
[    0.009455] NODE_DATA(0) allocated [mem 0x46dfd52c0-0x46dffffff]
[    0.009710] Zone ranges:
[    0.009711]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.009713]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.009714]   Normal   [mem 0x0000000100000000-0x000000046dffffff]
[    0.009716]   Device   empty
[    0.009717] Movable zone start for each node
[    0.009719] Early memory node ranges
[    0.009719]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.009721]   node   0: [mem 0x0000000000100000-0x000000008a26ffff]
[    0.009722]   node   0: [mem 0x000000008dc0e000-0x000000008dc0efff]
[    0.009723]   node   0: [mem 0x0000000100000000-0x000000046dffffff]
[    0.009726] Initmem setup node 0 [mem 0x0000000000001000-0x000000046dfff=
fff]
[    0.009730] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.009751] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.012592] On node 0, zone DMA32: 14750 pages in unavailable ranges
[    0.029871] On node 0, zone Normal: 9201 pages in unavailable ranges
[    0.029963] On node 0, zone Normal: 8192 pages in unavailable ranges
[    0.031169] ACPI: PM-Timer IO Port: 0x1808
[    0.031176] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.031177] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.031178] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.031179] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.031179] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.031180] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.031181] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.031182] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.031242] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.031244] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.031246] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.031250] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.031251] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.031257] e820: update [mem 0x86b6d000-0x86bdffff] usable =3D=3D> rese=
rved
[    0.031269] TSC deadline timer available
[    0.031274] CPU topo: Max. logical packages:   1
[    0.031275] CPU topo: Max. logical dies:       1
[    0.031275] CPU topo: Max. dies per package:   1
[    0.031280] CPU topo: Max. threads per core:   1
[    0.031280] CPU topo: Num. cores per package:     8
[    0.031281] CPU topo: Num. threads per package:   8
[    0.031282] CPU topo: Allowing 8 present CPUs plus 0 hotplug CPUs
[    0.031295] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.031297] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0=
x000fffff]
[    0.031299] PM: hibernation: Registered nosave memory: [mem 0x7bf0f000-0=
x7bf0ffff]
[    0.031300] PM: hibernation: Registered nosave memory: [mem 0x7bf1d000-0=
x7bf1dfff]
[    0.031301] PM: hibernation: Registered nosave memory: [mem 0x7bf1e000-0=
x7bf1efff]
[    0.031302] PM: hibernation: Registered nosave memory: [mem 0x7bf3c000-0=
x7bf3cfff]
[    0.031304] PM: hibernation: Registered nosave memory: [mem 0x86b6d000-0=
x86bdffff]
[    0.031305] PM: hibernation: Registered nosave memory: [mem 0x88b80000-0=
x88b80fff]
[    0.031307] PM: hibernation: Registered nosave memory: [mem 0x8a270000-0=
x8a6a4fff]
[    0.031307] PM: hibernation: Registered nosave memory: [mem 0x8a6a5000-0=
x8a721fff]
[    0.031308] PM: hibernation: Registered nosave memory: [mem 0x8a722000-0=
x8ab95fff]
[    0.031309] PM: hibernation: Registered nosave memory: [mem 0x8ab96000-0=
x8dc0dfff]
[    0.031310] PM: hibernation: Registered nosave memory: [mem 0x8dc0f000-0=
x8fffffff]
[    0.031311] PM: hibernation: Registered nosave memory: [mem 0x90000000-0=
xfdffffff]
[    0.031312] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0=
xfe010fff]
[    0.031312] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0=
xfebfffff]
[    0.031313] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0=
xfec00fff]
[    0.031314] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0=
xfecfffff]
[    0.031314] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0=
xfed03fff]
[    0.031315] PM: hibernation: Registered nosave memory: [mem 0xfed04000-0=
xfedfffff]
[    0.031316] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0=
xfee00fff]
[    0.031316] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0=
xffffffff]
[    0.031318] [mem 0x90000000-0xfdffffff] available for PCI devices
[    0.031319] Booting paravirtualized kernel on bare hardware
[    0.031321] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 6370452778343963 ns
[    0.037735] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr=
_node_ids:1
[    0.038145] percpu: Embedded 67 pages/cpu s237568 r8192 d28672 u524288
[    0.038152] pcpu-alloc: s237568 r8192 d28672 u524288 alloc=3D1*2097152
[    0.038154] pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7=20
[    0.038174] Kernel command line: initrd=3D\intel-ucode.img initrd=3D\ini=
tramfs-linux-mainline.img root=3D/dev/nvme0n1p1 rw intel_iommu=3Don
[    0.038235] DMAR: IOMMU enabled
[    0.038259] printk: log buffer data + meta data: 131072 + 458752 =3D 589=
824 bytes
[    0.039460] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes, linear)
[    0.040057] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes, linear)
[    0.040155] Fallback order for Node 0: 0=20
[    0.040158] Built 1 zonelists, mobility grouping on.  Total pages: 41620=
63
[    0.040159] Policy zone: Normal
[    0.040330] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.040337] software IO TLB: area num 8.
[    0.082459] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D8, N=
odes=3D1
[    0.082496] ftrace: allocating 51627 entries in 202 pages
[    0.103613] ftrace: allocated 202 pages with 4 groups
[    0.103688] Dynamic Preempt: full
[    0.103733] rcu: Preemptible hierarchical RCU implementation.
[    0.103734] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D8.
[    0.103735] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.103736] 	Trampoline variant of Tasks RCU enabled.
[    0.103736] 	Rude variant of Tasks RCU enabled.
[    0.103737] 	Tracing variant of Tasks RCU enabled.
[    0.103737] rcu: RCU calculated value of scheduler-enlistment delay is 3=
0 jiffies.
[    0.103738] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D8
[    0.103744] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjus=
t=3D1 rcu_task_cpu_ids=3D8.
[    0.103746] RCU Tasks Rude: Setting shift to 3 and lim to 1 rcu_task_cb_=
adjust=3D1 rcu_task_cpu_ids=3D8.
[    0.103748] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb=
_adjust=3D1 rcu_task_cpu_ids=3D8.
[    0.109492] NR_IRQS: 524544, nr_irqs: 2048, preallocated irqs: 16
[    0.109780] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.110177] kfence: initialized - using 2097152 bytes for 255 objects at=
 0x(____ptrval____)-0x(____ptrval____)
[    0.110209] Console: colour dummy device 80x25
[    0.110212] printk: legacy console [tty0] enabled
[    0.110261] ACPI: Core revision 20240827
[    0.110507] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.110573] APIC: Switch to symmetric I/O mode setup
[    0.110575] DMAR: Host address width 39
[    0.110576] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.110581] DMAR: dmar0: reg_base_addr fed91000 ver 1:0 cap d2008c406604=
62 ecap f050da
[    0.110584] DMAR: RMRR base: 0x0000008b72e000 end: 0x0000008b977fff
[    0.110587] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 0
[    0.110588] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.110589] DMAR-IR: Queued invalidation will be enabled to support x2ap=
ic and Intr-remapping.
[    0.113625] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.113627] x2apic enabled
[    0.113697] APIC: Switched APIC routing to: cluster x2apic
[    0.122912] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x2b3e459bf4c, max_idle_ns: 440795289890 ns
[    0.122918] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 6002.00 BogoMIPS (lpj=3D10000000)
[    0.122939] x86/cpu: SGX disabled or unsupported by BIOS.
[    0.122946] CPU0: Thermal monitoring enabled (TM1)
[    0.123000] Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
[    0.123001] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.123005] process: using mwait in idle threads
[    0.123007] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.123009] Spectre V2 : Spectre BHI mitigation: SW BHB clearing on sysc=
all and VM exit
[    0.123010] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.123011] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.123011] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL =
on VMEXIT
[    0.123012] RETBleed: Mitigation: Enhanced IBRS
[    0.123014] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.123015] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl
[    0.123020] TAA: Mitigation: TSX disabled
[    0.123021] MMIO Stale Data: Mitigation: Clear CPU buffers
[    0.123024] SRBDS: Mitigation: Microcode
[    0.123029] GDS: Mitigation: Microcode
[    0.123033] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.123034] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.123035] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.123036] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registe=
rs'
[    0.123037] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.123038] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.123040] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.123041] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.123042] x86/fpu: Enabled xstate features 0x1f, context size is 960 b=
ytes, using 'compacted' format.
[    0.126249] Freeing SMP alternatives memory: 40K
[    0.126249] pid_max: default: 32768 minimum: 301
[    0.126249] LSM: initializing lsm=3Dcapability,landlock,lockdown,yama,bpf
[    0.126249] landlock: Up and running.
[    0.126249] Yama: becoming mindful.
[    0.126249] LSM support for eBPF active
[    0.126249] Mount-cache hash table entries: 32768 (order: 6, 262144 byte=
s, linear)
[    0.126249] Mountpoint-cache hash table entries: 32768 (order: 6, 262144=
 bytes, linear)
[    0.126249] smpboot: CPU0: Intel(R) Core(TM) i7-9700F CPU @ 3.00GHz (fam=
ily: 0x6, model: 0x9e, stepping: 0xd)
[    0.126249] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR,=
 full-width counters, Intel PMU driver.
[    0.126249] ... version:                4
[    0.126249] ... bit width:              48
[    0.126249] ... generic registers:      8
[    0.126249] ... value mask:             0000ffffffffffff
[    0.126249] ... max period:             00007fffffffffff
[    0.126249] ... fixed-purpose events:   3
[    0.126249] ... event mask:             00000007000000ff
[    0.126249] signal: max sigframe size: 2032
[    0.126249] Estimated ratio of average max frequency by base frequency (=
times 1024): 1570
[    0.126249] rcu: Hierarchical SRCU implementation.
[    0.126249] rcu: 	Max phase no-delay instances is 1000.
[    0.126249] Timer migration: 1 hierarchy levels; 8 children per group; 1=
 crossnode level
[    0.126249] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.126249] smp: Bringing up secondary CPUs ...
[    0.126249] smpboot: x86: Booting SMP configuration:
[    0.126249] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.129633] smp: Brought up 1 node, 8 CPUs
[    0.129633] smpboot: Total of 8 processors activated (48019.00 BogoMIPS)
[    0.131620] Memory: 16201520K/16648252K available (18432K kernel code, 2=
692K rwdata, 14432K rodata, 4292K init, 3948K bss, 431576K reserved, 0K cma=
-reserved)
[    0.132986] devtmpfs: initialized
[    0.132986] x86/mm: Memory block size: 128MB
[    0.134082] ACPI: PM: Registering ACPI NVS region [mem 0x8a722000-0x8ab9=
5fff] (4669440 bytes)
[    0.134082] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 6370867519511994 ns
[    0.134082] futex hash table entries: 2048 (order: 5, 131072 bytes, line=
ar)
[    0.134082] pinctrl core: initialized pinctrl subsystem
[    0.134082] PM: RTC time: 17:21:09, date: 2025-01-14
[    0.134082] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.134087] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.134200] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.134313] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.134319] audit: initializing netlink subsys (disabled)
[    0.134374] audit: type=3D2000 audit(1736875269.000:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.134374] thermal_sys: Registered thermal governor 'fair_share'
[    0.134374] thermal_sys: Registered thermal governor 'bang_bang'
[    0.134374] thermal_sys: Registered thermal governor 'step_wise'
[    0.134374] thermal_sys: Registered thermal governor 'user_space'
[    0.134374] thermal_sys: Registered thermal governor 'power_allocator'
[    0.134374] cpuidle: using governor ladder
[    0.134374] cpuidle: using governor menu
[    0.134374] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    0.134374] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.134374] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for =
domain 0000 [bus 00-ff]
[    0.134374] PCI: Using configuration type 1 for base access
[    0.134374] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.137183] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.137183] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.137183] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.137183] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.137183] fbcon: Taking over console
[    0.137183] ACPI: Added _OSI(Module Device)
[    0.137183] ACPI: Added _OSI(Processor Device)
[    0.137183] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.137183] ACPI: Added _OSI(Processor Aggregator Device)
[    0.191686] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    0.198623] ACPI: Dynamic OEM Table Load:
[    0.198623] ACPI: SSDT 0xFFFF99F04100E800 000400 (v02 HPQOEM SLIC-CPC 00=
003001 INTL 20160527)
[    0.200123] ACPI: Dynamic OEM Table Load:
[    0.200128] ACPI: SSDT 0xFFFF99F041004000 000605 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.201155] ACPI: Dynamic OEM Table Load:
[    0.201159] ACPI: SSDT 0xFFFF99F041034F00 0000F4 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.202089] ACPI: Dynamic OEM Table Load:
[    0.202093] ACPI: SSDT 0xFFFF99F04184E200 000149 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.202979] ACPI: Dynamic OEM Table Load:
[    0.202983] ACPI: SSDT 0xFFFF99F041007800 000724 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.204107] ACPI: Dynamic OEM Table Load:
[    0.204112] ACPI: SSDT 0xFFFF99F041004800 0005FC (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.205155] ACPI: Dynamic OEM Table Load:
[    0.205160] ACPI: SSDT 0xFFFF99F041008800 000317 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.206198] ACPI: Dynamic OEM Table Load:
[    0.206203] ACPI: SSDT 0xFFFF99F0418C1000 000AB0 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.207761] ACPI: Dynamic OEM Table Load:
[    0.207765] ACPI: SSDT 0xFFFF99F04100DC00 00030A (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.211958] ACPI: EC: EC started
[    0.211959] ACPI: EC: interrupt blocked
[    0.212547] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.212549] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle tran=
sactions
[    0.212551] ACPI: Interpreter enabled
[    0.212588] ACPI: PM: (supports S0 S3 S4 S5)
[    0.212589] ACPI: Using IOAPIC for interrupt routing
[    0.213793] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.213795] PCI: Ignoring E820 reservations for host bridge windows
[    0.214975] ACPI: Enabled 10 GPEs in block 00 to 7F
[    0.231624] ACPI: \_SB_.PCI0.XDCI.USBC: New power resource
[    0.231774] ACPI: \_SB_.PCI0.PAUD: New power resource
[    0.234191] ACPI: \SPR2: New power resource
[    0.234363] ACPI: \SPR3: New power resource
[    0.234659] ACPI: \ZPDR: New power resource
[    0.234901] ACPI: \_SB_.PCI0.SAT0.VOL0.V0PR: New power resource
[    0.235102] ACPI: \_SB_.PCI0.SAT0.VOL1.V1PR: New power resource
[    0.235297] ACPI: \_SB_.PCI0.SAT0.VOL2.V2PR: New power resource
[    0.240873] ACPI: \_SB_.PCI0.I2C1.PXTC: New power resource
[    0.247298] ACPI: \_SB_.PCI0.CNVW.WRST: New power resource
[    0.252381] ACPI: \_TZ_.FN00: New power resource
[    0.252447] ACPI: \_TZ_.FN01: New power resource
[    0.252512] ACPI: \_TZ_.FN02: New power resource
[    0.252574] ACPI: \_TZ_.FN03: New power resource
[    0.252636] ACPI: \_TZ_.FN04: New power resource
[    0.253092] ACPI: \PIN_: New power resource
[    0.253245] ACPI: \SPR0: New power resource
[    0.253300] ACPI: \SPR1: New power resource
[    0.253355] ACPI: \SPR5: New power resource
[    0.253898] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.253906] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI EDR HPX-Type3]
[    0.257168] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME AER PCIeCapability LTR DPC]
[    0.257170] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    0.258352] PCI host bridge to bus 0000:00
[    0.258356] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.258359] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.258360] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.258362] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000efff=
f window]
[    0.258363] pci_bus 0000:00: root bus resource [mem 0x90000000-0xdffffff=
f window]
[    0.258365] pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7ffff=
f window]
[    0.258366] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.258458] pci 0000:00:00.0: [8086:3e30] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.258528] pci 0000:00:01.0: [8086:1901] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.258540] pci 0000:00:01.0: PCI bridge to [bus 01-03]
[    0.258543] pci 0000:00:01.0:   bridge window [io  0x5000-0x5fff]
[    0.258545] pci 0000:00:01.0:   bridge window [mem 0xa0300000-0xa05fffff]
[    0.258550] pci 0000:00:01.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.258575] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.259176] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000 convent=
ional PCI endpoint
[    0.259185] pci 0000:00:08.0: BAR 0 [mem 0xa0922000-0xa0922fff 64bit]
[    0.259358] pci 0000:00:12.0: [8086:a379] type 00 class 0x118000 convent=
ional PCI endpoint
[    0.259390] pci 0000:00:12.0: BAR 0 [mem 0xa0921000-0xa0921fff 64bit]
[    0.259644] pci 0000:00:14.0: [8086:a36d] type 00 class 0x0c0330 convent=
ional PCI endpoint
[    0.259680] pci 0000:00:14.0: BAR 0 [mem 0xa0900000-0xa090ffff 64bit]
[    0.259820] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.260524] pci 0000:00:14.2: [8086:a36f] type 00 class 0x050000 convent=
ional PCI endpoint
[    0.260554] pci 0000:00:14.2: BAR 0 [mem 0xa0916000-0xa0917fff 64bit]
[    0.260573] pci 0000:00:14.2: BAR 2 [mem 0xa0920000-0xa0920fff 64bit]
[    0.260724] pci 0000:00:14.5: [8086:a375] type 00 class 0x080501 convent=
ional PCI endpoint
[    0.260756] pci 0000:00:14.5: BAR 0 [mem 0xa091f000-0xa091ffff 64bit]
[    0.261585] pci 0000:00:15.0: [8086:a368] type 00 class 0x0c8000 convent=
ional PCI endpoint
[    0.262159] pci 0000:00:15.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.265140] pci 0000:00:15.1: [8086:a369] type 00 class 0x0c8000 convent=
ional PCI endpoint
[    0.265714] pci 0000:00:15.1: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.268319] pci 0000:00:16.0: [8086:a360] type 00 class 0x078000 convent=
ional PCI endpoint
[    0.268352] pci 0000:00:16.0: BAR 0 [mem 0xa091c000-0xa091cfff 64bit]
[    0.268469] pci 0000:00:16.0: PME# supported from D3hot
[    0.269102] pci 0000:00:17.0: [8086:a352] type 00 class 0x010601 convent=
ional PCI endpoint
[    0.269130] pci 0000:00:17.0: BAR 0 [mem 0xa0914000-0xa0915fff]
[    0.269146] pci 0000:00:17.0: BAR 1 [mem 0xa091b000-0xa091b0ff]
[    0.269161] pci 0000:00:17.0: BAR 2 [io  0x6050-0x6057]
[    0.269175] pci 0000:00:17.0: BAR 3 [io  0x6040-0x6043]
[    0.269190] pci 0000:00:17.0: BAR 4 [io  0x6020-0x603f]
[    0.269205] pci 0000:00:17.0: BAR 5 [mem 0xa091a000-0xa091a7ff]
[    0.269288] pci 0000:00:17.0: PME# supported from D3hot
[    0.269754] pci 0000:00:1c.0: [8086:a33d] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.269812] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    0.269819] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[    0.269825] pci 0000:00:1c.0:   bridge window [mem 0xa0800000-0xa08fffff]
[    0.269970] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.270020] pci 0000:00:1c.0: PTM enabled (root), 4ns granularity
[    0.270883] pci 0000:00:1c.7: [8086:a33f] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.270941] pci 0000:00:1c.7: PCI bridge to [bus 05]
[    0.270948] pci 0000:00:1c.7:   bridge window [io  0x3000-0x3fff]
[    0.270954] pci 0000:00:1c.7:   bridge window [mem 0xa0700000-0xa07fffff]
[    0.271096] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
[    0.271140] pci 0000:00:1c.7: PTM enabled (root), 4ns granularity
[    0.271936] pci 0000:00:1d.0: [8086:a330] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.271994] pci 0000:00:1d.0: PCI bridge to [bus 06]
[    0.272006] pci 0000:00:1d.0:   bridge window [mem 0xa0600000-0xa06fffff]
[    0.272164] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.272215] pci 0000:00:1d.0: PTM enabled (root), 4ns granularity
[    0.273451] pci 0000:00:1e.0: [8086:a328] type 00 class 0x078000 convent=
ional PCI endpoint
[    0.274026] pci 0000:00:1e.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.276690] pci 0000:00:1f.0: [8086:a304] type 00 class 0x060100 convent=
ional PCI endpoint
[    0.277255] pci 0000:00:1f.3: [8086:a348] type 00 class 0x040300 convent=
ional PCI endpoint
[    0.277316] pci 0000:00:1f.3: BAR 0 [mem 0xa0910000-0xa0913fff 64bit]
[    0.277391] pci 0000:00:1f.3: BAR 4 [mem 0xa0200000-0xa02fffff 64bit]
[    0.277540] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.278936] pci 0000:00:1f.4: [8086:a323] type 00 class 0x0c0500 convent=
ional PCI endpoint
[    0.279107] pci 0000:00:1f.4: BAR 0 [mem 0xa0918000-0xa09180ff 64bit]
[    0.279321] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.279806] pci 0000:00:1f.5: [8086:a324] type 00 class 0x0c8000 convent=
ional PCI endpoint
[    0.279832] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.280020] pci 0000:01:00.0: [1002:1478] type 01 class 0x060400 PCIe Sw=
itch Upstream Port
[    0.280031] pci 0000:01:00.0: BAR 0 [mem 0xa0500000-0xa0503fff]
[    0.280043] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.280048] pci 0000:01:00.0:   bridge window [io  0x5000-0x5fff]
[    0.280051] pci 0000:01:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.280059] pci 0000:01:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.280126] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.280174] pci 0000:01:00.0: 63.008 Gb/s available PCIe bandwidth, limi=
ted by 8.0 GT/s PCIe x8 link at 0000:00:01.0 (capable of 126.024 Gb/s with =
16.0 GT/s PCIe x8 link)
[    0.280268] pci 0000:00:01.0: PCI bridge to [bus 01-03]
[    0.280310] pci 0000:02:00.0: [1002:1479] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.280331] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.280336] pci 0000:02:00.0:   bridge window [io  0x5000-0x5fff]
[    0.280339] pci 0000:02:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.280346] pci 0000:02:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.280413] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.280533] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.280579] pci 0000:03:00.0: [1002:73ff] type 00 class 0x030000 PCIe Le=
gacy Endpoint
[    0.280593] pci 0000:03:00.0: BAR 0 [mem 0x90000000-0x9fffffff 64bit pre=
f]
[    0.280602] pci 0000:03:00.0: BAR 2 [mem 0xa0000000-0xa01fffff 64bit pre=
f]
[    0.280608] pci 0000:03:00.0: BAR 4 [io  0x5000-0x50ff]
[    0.280615] pci 0000:03:00.0: BAR 5 [mem 0xa0300000-0xa03fffff]
[    0.280621] pci 0000:03:00.0: ROM [mem 0xa0400000-0xa041ffff pref]
[    0.280693] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.280750] pci 0000:03:00.0: 63.008 Gb/s available PCIe bandwidth, limi=
ted by 8.0 GT/s PCIe x8 link at 0000:00:01.0 (capable of 252.048 Gb/s with =
16.0 GT/s PCIe x16 link)
[    0.280824] pci 0000:03:00.1: [1002:ab28] type 00 class 0x040300 PCIe Le=
gacy Endpoint
[    0.280834] pci 0000:03:00.1: BAR 0 [mem 0xa0420000-0xa0423fff]
[    0.280906] pci 0000:03:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.280996] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.281158] pci 0000:04:00.0: [10ec:8168] type 00 class 0x020000 PCIe En=
dpoint
[    0.281186] pci 0000:04:00.0: BAR 0 [io  0x4000-0x40ff]
[    0.281223] pci 0000:04:00.0: BAR 2 [mem 0xa0804000-0xa0804fff 64bit]
[    0.281246] pci 0000:04:00.0: BAR 4 [mem 0xa0800000-0xa0803fff 64bit]
[    0.281407] pci 0000:04:00.0: supports D1 D2
[    0.281409] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.281720] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    0.281873] pci 0000:05:00.0: [10ec:c821] type 00 class 0x028000 PCIe En=
dpoint
[    0.281900] pci 0000:05:00.0: BAR 0 [io  0x3000-0x30ff]
[    0.281933] pci 0000:05:00.0: BAR 2 [mem 0xa0700000-0xa070ffff 64bit]
[    0.282120] pci 0000:05:00.0: supports D1 D2
[    0.282121] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.282501] pci 0000:00:1c.7: PCI bridge to [bus 05]
[    0.282872] pci 0000:06:00.0: [8086:f1a8] type 00 class 0x010802 PCIe En=
dpoint
[    0.282907] pci 0000:06:00.0: BAR 0 [mem 0xa0600000-0xa0603fff 64bit]
[    0.283456] pci 0000:00:1d.0: PCI bridge to [bus 06]
[    0.285723] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.285808] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
[    0.285891] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.285972] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.286054] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.286136] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.286218] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.286302] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.291639] ACPI: EC: interrupt unblocked
[    0.291640] ACPI: EC: event unblocked
[    0.291651] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.291653] ACPI: EC: GPE=3D0xb
[    0.291654] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC initialization comp=
lete
[    0.291656] ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions =
and events
[    0.291709] iommu: Default domain type: Translated
[    0.291709] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.291709] SCSI subsystem initialized
[    0.291709] libata version 3.00 loaded.
[    0.291709] ACPI: bus type USB registered
[    0.291709] usbcore: registered new interface driver usbfs
[    0.291709] usbcore: registered new interface driver hub
[    0.291709] usbcore: registered new device driver usb
[    0.291709] EDAC MC: Ver: 3.0.0
[    0.293215] efivars: Registered efivars operations
[    0.293215] NetLabel: Initializing
[    0.293215] NetLabel:  domain hash size =3D 128
[    0.293215] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.293215] NetLabel:  unlabeled traffic allowed by default
[    0.293215] mctp: management component transport protocol core
[    0.293215] NET: Registered PF_MCTP protocol family
[    0.293215] PCI: Using ACPI for IRQ routing
[    0.377763] PCI: pci_cache_line_size set to 64 bytes
[    0.378365] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.378376] e820: reserve RAM buffer [mem 0x7bf0f018-0x7bffffff]
[    0.378377] e820: reserve RAM buffer [mem 0x7bf1e018-0x7bffffff]
[    0.378378] e820: reserve RAM buffer [mem 0x86b6d000-0x87ffffff]
[    0.378379] e820: reserve RAM buffer [mem 0x88b80000-0x8bffffff]
[    0.378380] e820: reserve RAM buffer [mem 0x8a270000-0x8bffffff]
[    0.378382] e820: reserve RAM buffer [mem 0x8dc0f000-0x8fffffff]
[    0.378382] e820: reserve RAM buffer [mem 0x46e000000-0x46fffffff]
[    0.378413] pci 0000:03:00.0: vgaarb: setting as boot VGA device
[    0.378413] pci 0000:03:00.0: vgaarb: bridge control possible
[    0.378413] pci 0000:03:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[    0.378413] vgaarb: loaded
[    0.378413] clocksource: Switched to clocksource tsc-early
[    0.378413] VFS: Disk quotas dquot_6.6.0
[    0.378413] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.378413] pnp: PnP ACPI init
[    0.378413] system 00:00: [mem 0x40000000-0x403fffff] could not be reser=
ved
[    0.378413] system 00:01: [io  0x0a00-0x0a0f] has been reserved
[    0.378413] system 00:01: [io  0x0a10-0x0a1f] has been reserved
[    0.378413] system 00:01: [io  0x0a20-0x0a2f] has been reserved
[    0.378413] system 00:01: [io  0x0a30-0x0a3f] has been reserved
[    0.378413] system 00:01: [io  0x0a40-0x0a4f] has been reserved
[    0.378413] system 00:01: [io  0x0a50-0x0a5f] has been reserved
[    0.378413] system 00:01: [io  0x0a60-0x0a6f] has been reserved
[    0.378413] system 00:01: [io  0x0a70-0x0a7f] has been reserved
[    0.378413] system 00:01: [io  0x0a80-0x0a8f] has been reserved
[    0.378413] system 00:01: [io  0x0a90-0x0b8e] has been reserved
[    0.378413] system 00:01: [io  0x0aa0-0x0aaf] has been reserved
[    0.378413] system 00:01: [io  0x0ab0-0x0abf] has been reserved
[    0.378413] system 00:01: [io  0x0ac0-0x0acf] has been reserved
[    0.378413] system 00:01: [io  0x0ad0-0x0adf] has been reserved
[    0.378413] system 00:02: [io  0x0680-0x069f] has been reserved
[    0.378413] system 00:02: [io  0x164e-0x164f] has been reserved
[    0.378413] system 00:03: [io  0x1854-0x1857] has been reserved
[    0.378413] system 00:04: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.378413] system 00:04: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.378413] system 00:04: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.378413] system 00:04: [mem 0xe0000000-0xefffffff] has been reserved
[    0.378413] system 00:04: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.378413] system 00:04: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.378413] system 00:04: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.378413] system 00:04: [mem 0xfee00000-0xfeefffff] could not be reser=
ved
[    0.378601] system 00:05: [io  0x1800-0x18fe] could not be reserved
[    0.378604] system 00:05: [mem 0xfd000000-0xfd69ffff] has been reserved
[    0.378606] system 00:05: [mem 0xfd6c0000-0xfd6cffff] has been reserved
[    0.378608] system 00:05: [mem 0xfd6f0000-0xfdffffff] has been reserved
[    0.378609] system 00:05: [mem 0xfe000000-0xfe01ffff] could not be reser=
ved
[    0.378611] system 00:05: [mem 0xfe200000-0xfe7fffff] has been reserved
[    0.378613] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.378923] system 00:06: [io  0x2000-0x20fe] has been reserved
[    0.380642] pnp: PnP ACPI: found 8 devices
[    0.386475] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.386539] NET: Registered PF_INET protocol family
[    0.386669] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)
[    0.401331] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5,=
 131072 bytes, linear)
[    0.401448] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.401486] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes, linear)
[    0.401700] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,=
 linear)
[    0.401922] TCP: Hash tables configured (established 131072 bind 65536)
[    0.401978] MPTCP token hash table entries: 16384 (order: 6, 393216 byte=
s, linear)
[    0.402043] UDP hash table entries: 8192 (order: 7, 524288 bytes, linear)
[    0.402121] UDP-Lite hash table entries: 8192 (order: 7, 524288 bytes, l=
inear)
[    0.402197] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.402204] NET: Registered PF_XDP protocol family
[    0.402217] pci 0000:00:15.0: BAR 0 [mem 0xa0919000-0xa0919fff 64bit]: a=
ssigned
[    0.402489] pci 0000:00:15.1: BAR 0 [mem 0xa091d000-0xa091dfff 64bit]: a=
ssigned
[    0.402758] pci 0000:00:1e.0: BAR 0 [mem 0xa091e000-0xa091efff 64bit]: a=
ssigned
[    0.403041] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.403048] pci 0000:02:00.0:   bridge window [io  0x5000-0x5fff]
[    0.403052] pci 0000:02:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.403055] pci 0000:02:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.403059] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.403061] pci 0000:01:00.0:   bridge window [io  0x5000-0x5fff]
[    0.403065] pci 0000:01:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.403067] pci 0000:01:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.403071] pci 0000:00:01.0: PCI bridge to [bus 01-03]
[    0.403073] pci 0000:00:01.0:   bridge window [io  0x5000-0x5fff]
[    0.403075] pci 0000:00:01.0:   bridge window [mem 0xa0300000-0xa05fffff]
[    0.403077] pci 0000:00:01.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.403081] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    0.403089] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[    0.403096] pci 0000:00:1c.0:   bridge window [mem 0xa0800000-0xa08fffff]
[    0.403109] pci 0000:00:1c.7: PCI bridge to [bus 05]
[    0.403112] pci 0000:00:1c.7:   bridge window [io  0x3000-0x3fff]
[    0.403119] pci 0000:00:1c.7:   bridge window [mem 0xa0700000-0xa07fffff]
[    0.403133] pci 0000:00:1d.0: PCI bridge to [bus 06]
[    0.403140] pci 0000:00:1d.0:   bridge window [mem 0xa0600000-0xa06fffff]
[    0.403154] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.403155] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.403157] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.403158] pci_bus 0000:00: resource 7 [mem 0x000e0000-0x000effff windo=
w]
[    0.403159] pci_bus 0000:00: resource 8 [mem 0x90000000-0xdfffffff windo=
w]
[    0.403161] pci_bus 0000:00: resource 9 [mem 0xfc800000-0xfe7fffff windo=
w]
[    0.403162] pci_bus 0000:01: resource 0 [io  0x5000-0x5fff]
[    0.403163] pci_bus 0000:01: resource 1 [mem 0xa0300000-0xa05fffff]
[    0.403165] pci_bus 0000:01: resource 2 [mem 0x90000000-0xa01fffff 64bit=
 pref]
[    0.403166] pci_bus 0000:02: resource 0 [io  0x5000-0x5fff]
[    0.403167] pci_bus 0000:02: resource 1 [mem 0xa0300000-0xa04fffff]
[    0.403168] pci_bus 0000:02: resource 2 [mem 0x90000000-0xa01fffff 64bit=
 pref]
[    0.403170] pci_bus 0000:03: resource 0 [io  0x5000-0x5fff]
[    0.403171] pci_bus 0000:03: resource 1 [mem 0xa0300000-0xa04fffff]
[    0.403172] pci_bus 0000:03: resource 2 [mem 0x90000000-0xa01fffff 64bit=
 pref]
[    0.403174] pci_bus 0000:04: resource 0 [io  0x4000-0x4fff]
[    0.403175] pci_bus 0000:04: resource 1 [mem 0xa0800000-0xa08fffff]
[    0.403176] pci_bus 0000:05: resource 0 [io  0x3000-0x3fff]
[    0.403177] pci_bus 0000:05: resource 1 [mem 0xa0700000-0xa07fffff]
[    0.403179] pci_bus 0000:06: resource 1 [mem 0xa0600000-0xa06fffff]
[    0.403780] pci 0000:03:00.1: D0 power state depends on 0000:03:00.0
[    0.403877] PCI: CLS 64 bytes, default 64
[    0.403940] DMAR: No ATSR found
[    0.403941] DMAR: No SATC found
[    0.403942] DMAR: dmar0: Using Queued invalidation
[    0.403970] Trying to unpack rootfs image as initramfs...
[    0.403994] pci 0000:00:00.0: Adding to iommu group 0
[    0.404008] pci 0000:00:01.0: Adding to iommu group 1
[    0.404016] pci 0000:00:08.0: Adding to iommu group 2
[    0.404027] pci 0000:00:12.0: Adding to iommu group 3
[    0.404046] pci 0000:00:14.0: Adding to iommu group 4
[    0.404054] pci 0000:00:14.2: Adding to iommu group 4
[    0.404062] pci 0000:00:14.5: Adding to iommu group 4
[    0.404077] pci 0000:00:15.0: Adding to iommu group 5
[    0.404085] pci 0000:00:15.1: Adding to iommu group 5
[    0.404096] pci 0000:00:16.0: Adding to iommu group 6
[    0.404104] pci 0000:00:17.0: Adding to iommu group 7
[    0.404119] pci 0000:00:1c.0: Adding to iommu group 8
[    0.404130] pci 0000:00:1c.7: Adding to iommu group 9
[    0.404140] pci 0000:00:1d.0: Adding to iommu group 10
[    0.404154] pci 0000:00:1e.0: Adding to iommu group 11
[    0.404176] pci 0000:00:1f.0: Adding to iommu group 12
[    0.404184] pci 0000:00:1f.3: Adding to iommu group 12
[    0.404194] pci 0000:00:1f.4: Adding to iommu group 12
[    0.404203] pci 0000:00:1f.5: Adding to iommu group 12
[    0.404207] pci 0000:01:00.0: Adding to iommu group 1
[    0.404210] pci 0000:02:00.0: Adding to iommu group 1
[    0.404216] pci 0000:03:00.0: Adding to iommu group 1
[    0.404220] pci 0000:03:00.1: Adding to iommu group 1
[    0.404235] pci 0000:04:00.0: Adding to iommu group 13
[    0.404245] pci 0000:05:00.0: Adding to iommu group 14
[    0.404260] pci 0000:06:00.0: Adding to iommu group 15
[    0.405077] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.405079] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.405080] software IO TLB: mapped [mem 0x0000000082b6d000-0x0000000086=
b6d000] (64MB)
[    0.405134] platform rtc_cmos: registered platform RTC device (no PNP de=
vice found)
[    0.420413] Initialise system trusted keyrings
[    0.420421] Key type blacklist registered
[    0.420456] workingset: timestamp_bits=3D36 max_order=3D22 bucket_order=
=3D0
[    0.420541] fuse: init (API version 7.41)
[    0.420608] integrity: Platform Keyring initialized
[    0.420610] integrity: Machine keyring initialized
[    0.431546] Key type asymmetric registered
[    0.431548] Asymmetric key parser 'x509' registered
[    0.431564] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 246)
[    0.431598] io scheduler mq-deadline registered
[    0.431599] io scheduler kyber registered
[    0.431607] io scheduler bfq registered
[    0.431761] ledtrig-cpu: registered to indicate activity on CPUs
[    0.431967] pcieport 0000:00:01.0: PME: Signaling with IRQ 121
[    0.432201] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
[    0.432267] pcieport 0000:00:1c.0: AER: enabled with IRQ 122
[    0.432307] pcieport 0000:00:1c.0: DPC: enabled with IRQ 122
[    0.432309] pcieport 0000:00:1c.0: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.432604] pcieport 0000:00:1c.7: PME: Signaling with IRQ 123
[    0.432657] pcieport 0000:00:1c.7: AER: enabled with IRQ 123
[    0.432697] pcieport 0000:00:1c.7: DPC: enabled with IRQ 123
[    0.432698] pcieport 0000:00:1c.7: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.432997] pcieport 0000:00:1d.0: PME: Signaling with IRQ 124
[    0.433057] pcieport 0000:00:1d.0: AER: enabled with IRQ 124
[    0.433100] pcieport 0000:00:1d.0: DPC: enabled with IRQ 124
[    0.433101] pcieport 0000:00:1d.0: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.433494] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.434015] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input0
[    0.434035] ACPI: button: Sleep Button [SLPB]
[    0.434058] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input1
[    0.434070] ACPI: button: Power Button [PWRB]
[    0.434093] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input2
[    0.434170] ACPI: button: Power Button [PWRF]
[    0.436152] thermal LNXTHERM:00: registered as thermal_zone0
[    0.436155] ACPI: thermal: Thermal Zone [HPTZ] (30 C)
[    0.436460] thermal LNXTHERM:01: registered as thermal_zone1
[    0.436462] ACPI: thermal: Thermal Zone [TZ00] (28 C)
[    0.436665] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.438533] hpet_acpi_add: no address or irqs in _CRS
[    0.438570] Non-volatile memory driver v1.3
[    0.438571] Linux agpgart interface v0.103
[    0.467654] Freeing initrd memory: 21264K
[    0.572151] ACPI: bus type drm_connector registered
[    0.573044] ahci 0000:00:17.0: version 3.0
[    0.573299] ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 =
Gbps, SATA mode
[    0.573302] ahci 0000:00:17.0: 4/4 ports implemented (port mask 0x3c)
[    0.573304] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio slu=
m part ems deso sadm sds apst=20
[    0.593427] scsi host0: ahci
[    0.593734] scsi host1: ahci
[    0.594032] scsi host2: ahci
[    0.594189] scsi host3: ahci
[    0.594296] scsi host4: ahci
[    0.594451] scsi host5: ahci
[    0.594481] ata1: DUMMY
[    0.594482] ata2: DUMMY
[    0.594488] ata3: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a20=
0 irq 126 lpm-pol 3
[    0.594491] ata4: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a28=
0 irq 126 lpm-pol 3
[    0.594494] ata5: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a30=
0 irq 126 lpm-pol 3
[    0.594497] ata6: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a38=
0 irq 126 lpm-pol 3
[    0.594618] ata3: before wakeup PxSSTS 0x133 PxSCTL 0x0 PxCMD 0x4016 PxD=
EVSLP 0x0
[    0.594675] ata5: before wakeup PxSSTS 0x133 PxSCTL 0x0 PxCMD 0x4016 PxD=
EVSLP 0x0
[    0.594717] ata6: before wakeup PxSSTS 0x4 PxSCTL 0x0 PxCMD 0x4016 PxDEV=
SLP 0x0
[    0.594744] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.594749] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[    0.595698] ata4: before wakeup PxSSTS 0x0 PxSCTL 0x0 PxCMD 0x4016 PxDEV=
SLP 0x0
[    0.595890] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
10 quirks 0x0000000000009810
[    0.596177] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.596181] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[    0.596183] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperS=
peed
[    0.596222] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.13
[    0.596224] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.596226] usb usb1: Product: xHCI Host Controller
[    0.596227] usb usb1: Manufacturer: Linux 6.13.0-rc7-1.2-mainline-dirty =
xhci-hcd
[    0.596228] usb usb1: SerialNumber: 0000:00:14.0
[    0.596377] hub 1-0:1.0: USB hub found
[    0.596398] hub 1-0:1.0: 16 ports detected
[    0.598108] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.13
[    0.598111] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.598112] usb usb2: Product: xHCI Host Controller
[    0.598113] usb usb2: Manufacturer: Linux 6.13.0-rc7-1.2-mainline-dirty =
xhci-hcd
[    0.598115] usb usb2: SerialNumber: 0000:00:14.0
[    0.598214] hub 2-0:1.0: USB hub found
[    0.598229] hub 2-0:1.0: 8 ports detected
[    0.598997] usb: port power management may be unreliable
[    0.599319] usbcore: registered new interface driver usbserial_generic
[    0.599323] usbserial: USB Serial support registered for generic
[    0.599430] rtc_cmos rtc_cmos: RTC can wake from S4
[    0.600983] rtc_cmos rtc_cmos: registered as rtc0
[    0.601295] rtc_cmos rtc_cmos: setting system clock to 2025-01-14T17:21:=
09 UTC (1736875269)
[    0.601327] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nv=
ram
[    0.601652] intel_pstate: Intel P-state driver initializing
[    0.602305] intel_pstate: Disabling energy efficiency optimization
[    0.602306] intel_pstate: HWP enabled
[    0.602533] simple-framebuffer simple-framebuffer.0: [drm] Registered 1 =
planes with drm panic
[    0.602535] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 o=
n minor 0
[    0.612376] Console: switching to colour frame buffer device 240x67
[    0.624123] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledr=
mdrmfb frame buffer device
[    0.624257] hid: raw HID events driver (C) Jiri Kosina
[    0.624331] drop_monitor: Initializing network drop monitor service
[    0.624413] NET: Registered PF_INET6 protocol family
[    0.629012] Segment Routing with IPv6
[    0.629015] RPL Segment Routing with IPv6
[    0.629026] In-situ OAM (IOAM) with IPv6
[    0.629045] NET: Registered PF_PACKET protocol family
[    0.629646] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.629861] microcode: Current revision: 0x00000100
[    0.629862] microcode: Updated early from: 0x000000fa
[    0.630165] IPI shorthand broadcast: enabled
[    0.631267] sched_clock: Marking stable (617316392, 12833377)->(66122224=
1, -31072472)
[    0.631510] registered taskstats version 1
[    0.632063] Loading compiled-in X.509 certificates
[    0.635875] Loaded X.509 cert 'Build time autogenerated kernel key: cc5f=
0cca11d2a24a334d5dd1f879c6165f996bc4'
[    0.636909] Demotion targets for Node 0: null
[    0.637130] Key type .fscrypt registered
[    0.637131] Key type fscrypt-provisioning registered
[    0.638449] integrity: Loading X.509 certificate: UEFI:db
[    0.638464] integrity: Loaded X.509 cert 'HP Inc.: HP UEFI Secure Boot D=
B 2017: d9c01b50cfcae89d3b05345c163aa76e5dd589e7'
[    0.638464] integrity: Loading X.509 certificate: UEFI:db
[    0.638474] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA =
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.638475] integrity: Loading X.509 certificate: UEFI:db
[    0.638483] integrity: Loaded X.509 cert 'Microsoft Windows Production P=
CA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.640017] PM:   Magic number: 9:646:390
[    0.640035] thermal cooling_device5: hash matches
[    0.640062] acpi XXXX0000:00: hash matches
[    0.642154] RAS: Correctable Errors collector initialized.
[    0.648546] clk: Disabling unused clocks
[    0.648547] PM: genpd: Disabling unused power domains
[    0.839751] usb 1-3: new low-speed USB device number 2 using xhci_hcd
[    0.980981] usb 1-3: New USB device found, idVendor=3D0461, idProduct=3D=
0010, bcdDevice=3D 1.10
[    0.980996] usb 1-3: New USB device strings: Mfr=3D0, Product=3D2, Seria=
lNumber=3D0
[    0.981001] usb 1-3: Product: USB Keyboard
[    1.099894] usb 1-14: new full-speed USB device number 3 using xhci_hcd
[    1.113233] ata4: before reset PxSSTS 0x0 PxSCTL 0x0 PxCMD 0x4016 PxDEVS=
LP 0x0
[    1.113363] ata6: before reset PxSSTS 0x4 PxSCTL 0x0 PxCMD 0x4016 PxDEVS=
LP 0x0
[    1.113481] ata5: before reset PxSSTS 0x133 PxSCTL 0x0 PxCMD 0x4016 PxDE=
VSLP 0x0
[    1.113603] ata3: before reset PxSSTS 0x133 PxSCTL 0x0 PxCMD 0x4016 PxDE=
VSLP 0x0
[    1.231469] usb 1-14: New USB device found, idVendor=3D0bda, idProduct=
=3Db00a, bcdDevice=3D 1.10
[    1.231484] usb 1-14: New USB device strings: Mfr=3D1, Product=3D2, Seri=
alNumber=3D3
[    1.231489] usb 1-14: Product: Bluetooth Radio=20
[    1.231494] usb 1-14: Manufacturer: Realtek=20
[    1.231498] usb 1-14: SerialNumber: 00e04c000001
[    1.406531] tsc: Refined TSC clocksource calibration: 3000.006 MHz
[    1.406549] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2b3=
e4b16716, max_idle_ns: 440795256380 ns
[    1.406650] clocksource: Switched to clocksource tsc
[    1.926581] ata3: sata_link_hardreset returned: 0 online: 1
[    1.926827] ata3: after reset PxSSTS 0x133 PxSCTL 0x300 PxCMD 0x4016 PxD=
EVSLP 0x0
[    1.926958] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.927051] ata6: phys link offline, no reason to wait
[    1.927138] ata6: sata_link_hardreset returned: 0 online: 0
[    1.927224] ata6: after reset PxSSTS 0x4 PxSCTL 0x300 PxCMD 0x4016 PxDEV=
SLP 0x0
[    1.927344] ata6: SATA link down (SStatus 4 SControl 300)
[    1.927365] ata6: before offline PxSSTS 0x4 PxSCTL 0x300 PxCMD 0xc017 Px=
DEVSLP 0x0
[    1.927540] ata4: phys link offline, no reason to wait
[    1.927621] ata4: sata_link_hardreset returned: 0 online: 0
[    1.927707] ata4: after reset PxSSTS 0x0 PxSCTL 0x300 PxCMD 0x4016 PxDEV=
SLP 0x0
[    1.927829] ata4: SATA link down (SStatus 0 SControl 300)
[    1.927851] ata4: before offline PxSSTS 0x0 PxSCTL 0x300 PxCMD 0xc017 Px=
DEVSLP 0x0
[    1.928029] ata5: sata_link_hardreset returned: 0 online: 1
[    1.928128] ata5: after reset PxSSTS 0x133 PxSCTL 0x300 PxCMD 0x4016 PxD=
EVSLP 0x0
[    1.928258] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.931212] ata5.00: Model 'SAMSUNG MZ7TD256HAFV-000L9', rev 'DXT04L6Q',=
 applying quirks: nolpm
[    1.931224] ata5.00: LPM support broken, forcing max_power
[    1.931373] ata5.00: supports DRM functions and may not be fully accessi=
ble
[    1.931381] ata5.00: ATA-9: SAMSUNG MZ7TD256HAFV-000L9, DXT04L6Q, max UD=
MA/133
[    1.931676] ata5.00: NCQ Send/Recv Log not supported
[    1.931684] ata5.00: 500118192 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    1.933838] ata5.00: Features: Trust Dev-Sleep
[    1.934202] ata5.00: LPM support broken, forcing max_power
[    1.934347] ata5.00: supports DRM functions and may not be fully accessi=
ble
[    1.934651] ata5.00: NCQ Send/Recv Log not supported
[    1.934957] ata3.00: ATA-8: WDC WD20EARX-00PASB0, 51.0AB51, max UDMA/133
[    1.935576] ata3.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 32),=
 AA
[    1.936139] ata5.00: configured for UDMA/133
[    1.943280] ata3.00: configured for UDMA/133
[    1.943556] scsi 2:0:0:0: Direct-Access     ATA      WDC WD20EARX-00P AB=
51 PQ: 0 ANSI: 5
[    1.944156] sd 2:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 =
TB/1.82 TiB)
[    1.944165] sd 2:0:0:0: [sda] 4096-byte physical blocks
[    1.944185] sd 2:0:0:0: [sda] Write Protect is off
[    1.944190] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.944214] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    1.944256] sd 2:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
[    1.946338] ahci 0000:00:17.0: port does not support device sleep
[    1.946605] scsi 4:0:0:0: Direct-Access     ATA      SAMSUNG MZ7TD256 4L=
6Q PQ: 0 ANSI: 5
[    1.947150] sd 4:0:0:0: [sdb] 500118192 512-byte logical blocks: (256 GB=
/238 GiB)
[    1.947173] sd 4:0:0:0: [sdb] Write Protect is off
[    1.947179] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.947203] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    1.947261] sd 4:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
[    1.996578]  sdb: sdb1 sdb2 sdb3 sdb4
[    1.997723] sd 4:0:0:0: [sdb] supports TCG Opal
[    1.997735] sd 4:0:0:0: [sdb] Attached SCSI disk
[    2.008260]  sda: sda1
[    2.008531] sd 2:0:0:0: [sda] Attached SCSI disk
[    2.011449] Freeing unused decrypted memory: 2028K
[    2.012552] Freeing unused kernel image (initmem) memory: 4292K
[    2.012599] Write protecting the kernel read-only data: 34816k
[    2.014037] Freeing unused kernel image (rodata/data gap) memory: 1952K
[    2.021717] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.021720] rodata_test: all tests were successful
[    2.021722] Run /init as init process
[    2.021723]   with arguments:
[    2.021724]     /init
[    2.021725]   with environment:
[    2.021725]     HOME=3D/
[    2.021726]     TERM=3Dlinux
[    2.228314] sdhci: Secure Digital Host Controller Interface driver
[    2.228316] sdhci: Copyright(c) Pierre Ossman
[    2.229561] usbcore: registered new interface driver usbhid
[    2.229563] usbhid: USB HID core driver
[    2.231592] nvme nvme0: pci function 0000:06:00.0
[    2.232084] input: USB Keyboard as /devices/pci0000:00/0000:00:14.0/usb1=
/1-3/1-3:1.0/0003:0461:0010.0001/input/input3
[    2.235188] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    2.235201] sdhci-pci 0000:00:14.5: enabling device (0100 -> 0102)
[    2.240713] nvme nvme0: 8/0/0 default/read/poll queues
[    2.243690]  nvme0n1: p1 p2
[    2.243914] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    2.410057] hid-generic 0003:0461:0010.0001: input,hidraw0: USB HID v1.1=
1 Keyboard [USB Keyboard] on usb-0000:00:14.0-3/input0
[    2.410199] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    2.410419] input: USB Keyboard Consumer Control as /devices/pci0000:00/=
0000:00:14.0/usb1/1-3/1-3:1.1/0003:0461:0010.0002/input/input4
[    2.463372] input: USB Keyboard System Control as /devices/pci0000:00/00=
00:00:14.0/usb1/1-3/1-3:1.1/0003:0461:0010.0002/input/input5
[    2.463764] hid-generic 0003:0461:0010.0002: input,hidraw1: USB HID v1.1=
1 Device [USB Keyboard] on usb-0000:00:14.0-3/input1
[    2.463909] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    2.642651] EXT4-fs (nvme0n1p1): mounted filesystem 7f701c1e-4cf2-46b9-8=
8a1-184e3dfef17e r/w with ordered data mode. Quota mode: none.
[    2.807081] systemd[1]: systemd 257.2-1-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPEN=
SSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETU=
P +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM=
2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINI=
T +LIBARCHIVE)
[    2.807091] systemd[1]: Detected architecture x86-64.
[    2.810898] systemd[1]: Hostname set to <Ale-Arch>.
[    3.099214] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    3.370534] systemd-fstab-generator[306]: Mount point  is not a valid pa=
th, ignoring.
[    3.370539] systemd-fstab-generator[306]: Mount point  is not a valid pa=
th, ignoring.
[    3.370615] systemd-fstab-generator[306]: Mount point  is not a valid pa=
th, ignoring.
[    3.371444] systemd-fstab-generator[306]: Mount point  is not a valid pa=
th, ignoring.
[    3.378085] systemd-fstab-generator[306]: Mount point  is not a valid pa=
th, ignoring.
[    3.378090] systemd-fstab-generator[306]: Mount point  is not a valid pa=
th, ignoring.
[    3.378093] systemd-fstab-generator[306]: Mount point  is not a valid pa=
th, ignoring.
[    3.378152] systemd-fstab-generator[306]: Mount point  is not a valid pa=
th, ignoring.
[    3.378189] systemd-fstab-generator[306]: Mount point  is not a valid pa=
th, ignoring.
[    3.380077] systemd-fstab-generator[306]: Mount point  is not a valid pa=
th, ignoring.
[    3.380082] systemd-fstab-generator[306]: Mount point  is not a valid pa=
th, ignoring.
[    3.402768] zram: Added device: zram0
[    3.667948] systemd[1]: Configuration file /run/systemd/system/netplan-o=
vs-cleanup.service is marked world-inaccessible. This has no effect as conf=
iguration data is accessible via APIs without restrictions. Proceeding anyw=
ay.
[    3.753358] systemd[1]: Queued start job for default target Graphical In=
terface.
[    3.795355] systemd[1]: Created slice Virtual Machine and Container Slic=
e.
[    3.796664] systemd[1]: Created slice Slice /system/backrest.
[    3.797261] systemd[1]: Created slice CUPS Slice.
[    3.797874] systemd[1]: Created slice Slice /system/dirmngr.
[    3.798477] systemd[1]: Created slice Slice /system/getty.
[    3.799123] systemd[1]: Created slice Slice /system/gpg-agent.
[    3.799749] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    3.800367] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    3.800970] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    3.801592] systemd[1]: Created slice Slice /system/keyboxd.
[    3.802211] systemd[1]: Created slice Slice /system/modprobe.
[    3.802864] systemd[1]: Created slice Slice /system/nut-driver.
[    3.803478] systemd[1]: Created slice Slice /system/systemd-fsck.
[    3.804084] systemd[1]: Created slice Slice /system/systemd-zram-setup.
[    3.804491] systemd[1]: Created slice User and Session Slice.
[    3.805667] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    3.807255] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[    3.808537] systemd[1]: Expecting device /dev/disk/by-uuid/0f1ef58b-496b=
-48fd-a17b-6cbc03a2c8ee...
[    3.808673] systemd[1]: Expecting device /dev/disk/by-uuid/CAB7-E233...
[    3.810018] systemd[1]: Expecting device /dev/zram0...
[    3.810150] systemd[1]: Reached target Login Prompts.
[    3.810239] systemd[1]: Reached target Local Integrity Protected Volumes.
[    3.811013] systemd[1]: Reached target Remote File Systems.
[    3.811816] systemd[1]: Reached target Slice Units.
[    3.812581] systemd[1]: Reached target System Time Set.
[    3.813326] systemd[1]: Reached target Local Verity Protected Volumes.
[    3.814114] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    3.814838] systemd[1]: Listening on LVM2 poll daemon socket.
[    3.818730] systemd[1]: Listening on RPCbind Server Activation Socket.
[    3.818798] systemd[1]: Reached target RPC Port Mapper.
[    3.825151] systemd[1]: Listening on Process Core Dump Socket.
[    3.825852] systemd[1]: Listening on Credential Encryption/Decryption.
[    3.826055] systemd[1]: Listening on Journal Socket (/dev/log).
[    3.826156] systemd[1]: Listening on Journal Sockets.
[    3.826957] systemd[1]: Listening on Network Service Netlink Socket.
[    3.827708] systemd[1]: Listening on Userspace Out-Of-Memory (OOM) Kille=
r Socket.
[    3.828379] systemd[1]: TPM PCR Measurements was skipped because of an u=
nmet condition check (ConditionSecurity=3Dmeasured-uki).
[    3.828405] systemd[1]: Make TPM PCR Policy was skipped because of an un=
met condition check (ConditionSecurity=3Dmeasured-uki).
[    3.828488] systemd[1]: Listening on udev Control Socket.
[    3.829167] systemd[1]: Listening on udev Kernel Socket.
[    3.830271] systemd[1]: Mounting Huge Pages File System...
[    3.831149] systemd[1]: Mounting POSIX Message Queue File System...
[    3.831825] systemd[1]: Mounting NFSD configuration filesystem...
[    3.832552] systemd[1]: Mounting Kernel Debug File System...
[    3.833326] systemd[1]: Mounting Kernel Trace File System...
[    3.833693] systemd[1]: Load AppArmor profiles was skipped because of an=
 unmet condition check (ConditionSecurity=3Dapparmor).
[    3.833730] systemd[1]: Kernel Module supporting RPCSEC_GSS was skipped =
because of an unmet condition check (ConditionPathExists=3D/etc/krb5.keytab=
).
[    3.834710] systemd[1]: Starting Create List of Static Device Nodes...
[    3.836651] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling...
[    3.838601] systemd[1]: Starting Load Kernel Module configfs...
[    3.839401] systemd[1]: Starting Load Kernel Module dm_mod...
[    3.840605] systemd[1]: Starting Load Kernel Module drm...
[    3.841357] systemd[1]: Starting Load Kernel Module fuse...
[    3.841985] systemd[1]: Starting Load Kernel Module loop...
[    3.842145] systemd[1]: File System Check on Root Device was skipped bec=
ause of an unmet condition check (ConditionPathIsReadWrite=3D!/).
[    3.842176] systemd[1]: Clear Stale Hibernate Storage Info was skipped b=
ecause of an unmet condition check (ConditionPathExists=3D/sys/firmware/efi=
/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[    3.845459] systemd[1]: Starting Journal Service...
[    3.847472] systemd[1]: Starting Load Kernel Modules...
[    3.849082] systemd[1]: Starting Userspace Out-Of-Memory (OOM) Killer...
[    3.849286] loop: module loaded
[    3.849414] systemd[1]: TPM PCR Machine ID Measurement was skipped becau=
se of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    3.850173] systemd[1]: Starting Remount Root and Kernel File Systems...
[    3.850241] systemd[1]: Early TPM SRK Setup was skipped because of an un=
met condition check (ConditionSecurity=3Dmeasured-uki).
[    3.851048] systemd[1]: Starting Load udev Rules from Credentials...
[    3.852526] device-mapper: uevent: version 1.0.3
[    3.852599] systemd[1]: Starting Coldplug All udev Devices...
[    3.852662] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised:=
 dm-devel@lists.linux.dev
[    3.855239] systemd[1]: Starting Virtual Console Setup...
[    3.857260] systemd[1]: Mounted Huge Pages File System.
[    3.857361] systemd[1]: Mounted POSIX Message Queue File System.
[    3.857425] systemd[1]: Mounted Kernel Debug File System.
[    3.857493] systemd[1]: Mounted Kernel Trace File System.
[    3.857768] systemd[1]: Finished Create List of Static Device Nodes.
[    3.858000] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[    3.858110] systemd[1]: Finished Load Kernel Module configfs.
[    3.858308] systemd[1]: modprobe@dm_mod.service: Deactivated successfull=
y.
[    3.858418] systemd[1]: Finished Load Kernel Module dm_mod.
[    3.858795] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    3.858885] systemd[1]: Finished Load Kernel Module drm.
[    3.859031] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    3.859115] systemd[1]: Finished Load Kernel Module fuse.
[    3.859278] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    3.859369] systemd[1]: Finished Load Kernel Module loop.
[    3.865394] systemd[1]: Finished Load udev Rules from Credentials.
[    3.868961] systemd[1]: Mounting FUSE Control File System...
[    3.869765] systemd[1]: Mounting Kernel Configuration File System...
[    3.869812] systemd[1]: Repartition Root Disk was skipped because no tri=
gger condition checks were met.
[    3.871254] systemd[1]: Starting Create Static Device Nodes in /dev grac=
efully...
[    3.873624] systemd[1]: Mounted Kernel Configuration File System.
[    3.875017] systemd[1]: Mounted FUSE Control File System.
[    3.879048] systemd-journald[346]: Collecting audit messages is disabled.
[    3.883228] EXT4-fs (nvme0n1p1): re-mounted 7f701c1e-4cf2-46b9-88a1-184e=
3dfef17e r/w. Quota mode: none.
[    3.884988] systemd[1]: Finished Remount Root and Kernel File Systems.
[    3.885174] RPC: Registered named UNIX socket transport module.
[    3.885176] RPC: Registered udp transport module.
[    3.885176] RPC: Registered tcp transport module.
[    3.885177] RPC: Registered tcp-with-tls transport module.
[    3.885177] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    3.885443] systemd[1]: Finished Virtual Console Setup.
[    3.886286] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    3.886318] sd 4:0:0:0: Attached scsi generic sg1 type 0
[    3.886456] systemd[1]: Rebuild Hardware Database was skipped because of=
 an unmet condition check (ConditionNeedsUpdate=3D/etc).
[    3.887732] systemd[1]: Starting Load/Save OS Random Seed...
[    3.887756] systemd[1]: TPM SRK Setup was skipped because of an unmet co=
ndition check (ConditionSecurity=3Dmeasured-uki).
[    3.893893] i2c_dev: i2c /dev entries driver
[    3.896517] systemd[1]: Finished Load Kernel Modules.
[    3.897406] systemd[1]: Starting Apply Kernel Variables...
[    3.899374] systemd[1]: Finished Load/Save OS Random Seed.
[    3.901664] systemd[1]: Started Userspace Out-Of-Memory (OOM) Killer.
[    3.910944] systemd[1]: Finished Apply Kernel Variables.
[    3.913736] systemd[1]: Starting CLI Netfilter Manager...
[    3.914275] systemd[1]: Started Journal Service.
[    3.927621] systemd-journald[346]: Received client request to flush runt=
ime journal.
[    4.179974] zram0: detected capacity change from 0 to 32491520
[    4.210880] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    4.214924] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: 8F1F6436-9F42-4=
2C8-BADC-0E9424F20C9A has zero instances
[    4.214927] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: 8F1F6435-9F42-4=
2C8-BADC-0E9424F20C9A has zero instances
[    4.214928] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: 7391A661-223A-4=
7DB-A77A-7BE84C60822D has zero instances
[    4.214929] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: DF4E63B6-3BBC-4=
858-9737-C74F82F821F3 has zero instances
[    4.218087] mmc0: SDHCI controller on PCI [0000:00:14.5] using ADMA 64-b=
it
[    4.245264] raid6: skipped pq benchmark and selected avx2x4
[    4.245267] raid6: using avx2x2 recovery algorithm
[    4.247439] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[    4.248905] xor: automatically using best checksumming function   avx   =
   =20
[    4.250639] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    4.250798] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db1=
8c600'
[    4.253589] platform regulatory.0: Direct firmware load for regulatory.d=
b failed with error -2
[    4.253593] cfg80211: failed to load regulatory.db
[    4.268335] Adding 16245756k swap on /dev/zram0.  Priority:100 extents:1=
 across:16245756k SSDsc
[    4.273731] intel_pmc_core INT33A1:00:  initialized
[    4.277895] intel_pch_thermal 0000:00:12.0: enabling device (0100 -> 010=
2)
[    4.407573] EDAC ie31200: No ECC support
[    4.407954] EDAC ie31200: No ECC support
[    4.408031] intel-lpss 0000:00:15.0: enabling device (0100 -> 0102)
[    4.409218] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    4.411289] Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
[    4.437668] intel-lpss 0000:00:15.1: enabling device (0100 -> 0102)
[    4.438336] idma64 idma64.1: Found Intel integrated DMA 64-bit
[    4.464744] Bluetooth: Core ver 2.22
[    4.464775] NET: Registered PF_BLUETOOTH protocol family
[    4.464779] Bluetooth: HCI device and connection manager initialized
[    4.464785] Bluetooth: HCI socket layer initialized
[    4.464789] Bluetooth: L2CAP socket layer initialized
[    4.464795] Bluetooth: SCO socket layer initialized
[    4.465428] intel-lpss 0000:00:1e.0: enabling device (0100 -> 0102)
[    4.466028] idma64 idma64.2: Found Intel integrated DMA 64-bit
[    4.475552] input: PC Speaker as /devices/platform/pcspkr/input/input6
[    4.491478] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    4.496412] Creating 1 MTD partitions on "0000:00:1f.5":
[    4.496417] 0x000000000000-0x000001000000 : "BIOS"
[    4.557398] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    4.557456] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    4.558375] dw-apb-uart.2: ttyS4 at MMIO 0xa091e000 (irq =3D 20, base_ba=
ud =3D 7500000) is a 16550A
[    4.581141] i2c i2c-2: Successfully instantiated SPD at 0x50
[    4.581810] r8169 0000:04:00.0: can't disable ASPM; OS doesn't have ASPM=
 control
[    4.598889] r8169 0000:04:00.0 eth0: RTL8168h/8111h, 9c:7b:ef:30:a7:6b, =
XID 541, IRQ 146
[    4.598906] r8169 0000:04:00.0 eth0: jumbo features [frames: 9194 bytes,=
 tx checksumming: ko]
[    4.685041] iTCO_vendor_support: vendor-support=3D0
[    4.685346] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360=
 ms ovfl timer
[    4.685348] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    4.685349] RAPL PMU: hw unit of domain package 2^-14 Joules
[    4.685350] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    4.685596] r8169 0000:04:00.0 enp4s0: renamed from eth0
[    4.689067] input: HP WMI hotkeys as /devices/virtual/input/input7
[    4.692270] cryptd: max_cpu_qlen set to 1000
[    4.692530] ee1004 2-0050: 512 byte EE1004-compliant SPD EEPROM, read-on=
ly
[    4.695980] usbcore: registered new interface driver btusb
[    4.701143] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=3D6=
, TCOBASE=3D0x0400)
[    4.701248] iTCO_wdt iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=
=3D0)
[    4.701821] Bluetooth: hci0: RTL: examining hci_ver=3D08 hci_rev=3D000c =
lmp_ver=3D08 lmp_subver=3D8821
[    4.702817] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
[    4.702820] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_fw.bin
[    4.704665] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_config.bin
[    4.704744] Bluetooth: hci0: RTL: cfg_sz 10, total sz 34926
[    4.704808] AES CTR mode by8 optimization enabled
[    4.713544] rtw_8821ce 0000:05:00.0: enabling device (0100 -> 0103)
[    4.714842] rtw_8821ce 0000:05:00.0: Firmware version 24.11.0, H2C versi=
on 12
[    4.719984] snd_hda_intel 0000:00:1f.3: enabling device (0100 -> 0102)
[    4.720394] snd_hda_intel 0000:03:00.1: enabling device (0100 -> 0102)
[    4.720475] snd_hda_intel 0000:03:00.1: Force to non-snoop mode
[    4.735203] input: HDA ATI HDMI HDMI/DP,pcm=3D3 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input8
[    4.735461] input: HDA ATI HDMI HDMI/DP,pcm=3D7 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input9
[    4.735505] input: HDA ATI HDMI HDMI/DP,pcm=3D8 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input10
[    4.735533] input: HDA ATI HDMI HDMI/DP,pcm=3D9 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input11
[    4.735556] input: HDA ATI HDMI HDMI/DP,pcm=3D10 as /devices/pci0000:00/=
0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input12
[    4.786026] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC671: li=
ne_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:line
[    4.786029] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[    4.786031] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0x21/0x0/=
0x0/0x0/0x0)
[    4.786032] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0
[    4.786032] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    4.786033] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=3D0x18
[    4.786034] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=3D0x19
[    4.786035] snd_hda_codec_realtek hdaudioC0D0:      Line=3D0x1b
[    4.799462] input: HDA Intel PCH Rear Mic as /devices/pci0000:00/0000:00=
:1f.3/sound/card0/input13
[    4.799510] input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:0=
0:1f.3/sound/card0/input14
[    4.799532] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1f.=
3/sound/card0/input15
[    4.799562] input: HDA Intel PCH Line Out as /devices/pci0000:00/0000:00=
:1f.3/sound/card0/input16
[    4.799586] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input17
[    4.804692] rtw_8821ce 0000:05:00.0 wlp5s0: renamed from wlan0
[    4.815214] intel_tcc_cooling: Programmable TCC Offset detected
[    5.169907] Bluetooth: hci0: RTL: fw version 0x75b8f098
[    5.212765] BTRFS: device label DATA devid 1 transid 20682 /dev/sda1 (8:=
1) scanned by mount (592)
[    5.216416] BTRFS info (device sda1): first mount of filesystem 0f1ef58b=
-496b-48fd-a17b-6cbc03a2c8ee
[    5.216426] BTRFS info (device sda1): using crc32c (crc32c-intel) checks=
um algorithm
[    5.216430] BTRFS info (device sda1): using free-space-tree
[    7.143593] [drm] amdgpu kernel modesetting enabled.
[    7.143731] amdgpu: Virtual CRAT table created for CPU
[    7.143754] amdgpu: Topology: Add CPU node
[    7.143850] amdgpu: Overdrive is enabled, please disable it before repor=
ting any bugs unrelated to overdrive.
[    7.144853] amdgpu 0000:03:00.0: enabling device (0106 -> 0107)
[    7.144948] [drm] initializing kernel modesetting (DIMGREY_CAVEFISH 0x10=
02:0x73FF 0x1043:0x05D5 0xC7).
[    7.144959] [drm] register mmio base: 0xA0300000
[    7.144960] [drm] register mmio size: 1048576
[    7.150351] [drm] add ip block number 0 <nv_common>
[    7.150354] [drm] add ip block number 1 <gmc_v10_0>
[    7.150356] [drm] add ip block number 2 <navi10_ih>
[    7.150356] [drm] add ip block number 3 <psp>
[    7.150357] [drm] add ip block number 4 <smu>
[    7.150359] [drm] add ip block number 5 <dm>
[    7.150360] [drm] add ip block number 6 <gfx_v10_0>
[    7.150361] [drm] add ip block number 7 <sdma_v5_2>
[    7.150362] [drm] add ip block number 8 <vcn_v3_0>
[    7.150363] [drm] add ip block number 9 <jpeg_v3_0>
[    7.150384] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from VFCT
[    7.150386] amdgpu: ATOM BIOS: 115-D534P00-100
[    7.166025] intel_rapl_common: Found RAPL domain package
[    7.166027] intel_rapl_common: Found RAPL domain core
[    7.166028] intel_rapl_common: Found RAPL domain dram
[    7.206477] Console: switching to colour dummy device 80x25
[    7.243989] amdgpu 0000:03:00.0: vgaarb: deactivate vga console
[    7.243993] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (TMZ) featu=
re disabled as experimental (default)
[    7.244063] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, f=
ragment size is 9-bit
[    7.244070] amdgpu 0000:03:00.0: amdgpu: VRAM: 8176M 0x0000008000000000 =
- 0x00000081FEFFFFFF (8176M used)
[    7.244072] amdgpu 0000:03:00.0: amdgpu: GART: 512M 0x0000000000000000 -=
 0x000000001FFFFFFF
[    7.244083] [drm] Detected VRAM RAM=3D8176M, BAR=3D256M
[    7.244084] [drm] RAM width 128bits GDDR6
[    7.244251] [drm] amdgpu: 8176M of VRAM memory ready
[    7.244253] [drm] amdgpu: 7932M of GTT memory ready.
[    7.244267] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    7.244343] [drm] PCIE GART of 512M enabled (table at 0x0000008002000000=
).
[    8.731512] amdgpu 0000:03:00.0: amdgpu: STB initialized to 2048 entries
[    8.731747] [drm] Loading DMUB firmware via PSP: version=3D0x02020020
[    8.732066] [drm] use_doorbell being set to: [true]
[    8.732077] [drm] use_doorbell being set to: [true]
[    8.732086] [drm] Found VCN firmware Version ENC: 1.33 DEC: 4 VEP: 0 Rev=
ision: 3
[    8.798877] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000=
000 for PSP TMR
[    8.901360] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is n=
ot available
[    8.918483] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta=
 ucode is not available
[    8.918507] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x000=
0000f, smu fw if version =3D 0x00000013, smu fw program =3D 0, version =3D =
0x003b3100 (59.49.0)
[    8.918515] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not match=
ed
[    8.918549] amdgpu 0000:03:00.0: amdgpu: use vbios provided pptable
[    8.965034] amdgpu 0000:03:00.0: amdgpu: SMU is initialized successfully!
[    8.965468] [drm] Display Core v3.2.310 initialized on DCN 3.0.2
[    8.965470] [drm] DP-HDMI FRL PCON supported
[    8.966714] [drm] DMUB hardware initialized: version=3D0x02020020
[    8.969937] snd_hda_intel 0000:03:00.1: bound 0000:03:00.0 (ops amdgpu_d=
m_audio_component_bind_ops [amdgpu])
[    9.408645] [drm] kiq ring mec 2 pipe 1 q 0
[    9.481641] amdgpu: HMM registered 8176MB device memory
[    9.483301] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    9.483314] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    9.483546] amdgpu: Virtual CRAT table created for GPU
[    9.483882] amdgpu: Topology: Add dGPU node [0x73ff:0x1002]
[    9.483884] kfd kfd: amdgpu: added device 1002:73ff
[    9.483902] amdgpu 0000:03:00.0: amdgpu: SE 2, SH per SE 2, CU per SH 8,=
 active_cu_number 28
[    9.483905] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng =
0 on hub 0
[    9.483907] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng =
1 on hub 0
[    9.483908] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 4 on hub 0
[    9.483909] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 5 on hub 0
[    9.483911] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 6 on hub 0
[    9.483912] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 7 on hub 0
[    9.483913] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 8 on hub 0
[    9.483914] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 9 on hub 0
[    9.483915] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 10 on hub 0
[    9.483916] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 11 on hub 0
[    9.483917] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv en=
g 12 on hub 0
[    9.483918] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 o=
n hub 0
[    9.483920] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 o=
n hub 0
[    9.483921] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng =
0 on hub 8
[    9.483922] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv en=
g 1 on hub 8
[    9.483923] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv en=
g 4 on hub 8
[    9.483924] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5=
 on hub 8
[    9.484909] amdgpu 0000:03:00.0: amdgpu: Using BACO for runtime pm
[    9.485749] [drm] Initialized amdgpu 3.59.0 for 0000:03:00.0 on minor 1
[    9.491826] fbcon: amdgpudrmfb (fb0) is primary device
[    9.492078] [drm] pre_validate_dsc:1593 MST_DSC dsc precompute is not ne=
eded
[    9.798319] Console: switching to colour frame buffer device 240x67
[    9.833696] amdgpu 0000:03:00.0: [drm] fb0: amdgpudrmfb frame buffer dev=
ice
[   10.006821] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   10.006824] Bluetooth: BNEP filters: protocol multicast
[   10.006826] Bluetooth: BNEP socket layer initialized
[   10.009483] Bluetooth: MGMT ver 1.23
[   10.013447] NET: Registered PF_ALG protocol family
[   10.209328] nvme nvme0: using unchecked data buffer
[   10.280310] block nvme0n1: No UUID available providing old NGUID
[   10.282945] Generic FE-GE Realtek PHY r8169-0-400:00: attached PHY drive=
r (mii_bus:phy_addr=3Dr8169-0-400:00, irq=3DMAC)
[   10.469739] r8169 0000:04:00.0 enp4s0: Link is Down
[   11.047828] bridge: filtering via arp/ip/ip6tables is no longer availabl=
e by default. Update your scripts to load br_netfilter if you need this.
[   11.184023] u32 classifier
[   11.184026]     Performance counters on
[   11.184026]     input device check on
[   11.184026]     Actions configured
[   13.331240] kvm: Running KVM with ignore_msrs=3D1 and report_ignored_msr=
s=3D0 is not a
               a supported configuration.  Lying to the guest about the exi=
stence of MSRs
               may cause the guest operating system to hang or produce erro=
rs.  If a guest
               does not run without ignore_msrs=3D1, please report it to kv=
m@vger.kernel.org.
[   13.988515] r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[   13.990171] r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[   16.349009] RPC: Registered rdma transport module.
[   16.349011] RPC: Registered rdma backchannel transport module.
[   16.460858] NFSD: Using nfsdcld client tracking operations.
[   16.460867] NFSD: no clients to reclaim, skipping NFSv4 grace period (ne=
t f0000000)
[   17.016943] Initializing XFRM netlink socket
[   17.098407] warning: `pmdalinux' uses wireless extensions which will sto=
p working for Wi-Fi 7 hardware; use nl80211

--moyzeq6yvypjnw4h--

--ky3dumliyn4zlzno
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmeGpBYACgkQwEfU8yi1
JYW4xxAA5WPOnkG2DkdbQHqWNOnrxVtZsGxlcblgTHrEk4ta1lQNdU5t1VQ9D25V
rxgCsZyOkYvzR+kKXKP8cT5OtuWWu14DuuhkEWkc4BLu/KztrQclh+KHhTPy6NGX
hj7bNyXxp04EH/xaE21FLs+j2ywrFdJzcklXOfx8qi1wXLXy8YBqTmwllEt7FHV5
0c4AZWDSlY66FTwvu/Fysh49cMieeWcYHYm8B5elxBlUhfgcYBkH+8KobUve81To
szwkQ9QJKIeAmUD6aOybY8xl4K1v+JwG4pTMnUqxC9YXPHsshBFGyJg9AJ3pJGw+
87Kw4AqkDZ8sqHQO5VpnFOftmHhzXYF1EzeZpOqMp9VBmUo/hPJI4a0S50Nh97mV
5YFGsMMfFaRAV+0hagzm6EQE7tVR07YAgCnFrPYIXFFoShi2lay+SVj28k7gAXk9
S15FbU8RQONNtUs5JuHkuL+hs68wTk1UnctJsUA3Toe6LfMN8oXYCsHN2qLxl7m6
cx//oj3JrTdp4b5xdCoQNONfJWLEJy8v0LVqBougSEY3lYeu99/2eOnhLkSXIWrZ
WsWIZYr298vQSgoDzAJOCCi4F+xTQ1vAQ/YTCCGSbZPV/OVkBziaY7bo2gpimtkE
lzTmd68YBKA/n24bhhHLcfmSp/h3i+zqSEKEv4pvu1f/q2pNoJU=
=a0HQ
-----END PGP SIGNATURE-----

--ky3dumliyn4zlzno--
