Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B6C56B81;
	Sat, 11 Jan 2025 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736613717; cv=none; b=X/RvFqZxNvbwDgnQAaaW8hxr3f0KAEX0F2SCORzWfZEhJYYMKmVbEHPFYpS8Fz5QmjSweIjwxS8+AtgLx8+dW62yhOdOJlR1DckD6VMSonX2wToucfRFexMjLyGgq4Zho3egu517CtT60mOWNFqR7h1ScA3bRk2q5sypC+sHLWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736613717; c=relaxed/simple;
	bh=i88aKEgI8z4ci82zdPnzdtxRCw/bfhg6L5pbTcwuPKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Os3bJScPsC9e7o2O83HPHGXog9/6KCWXVeN4AkSio8octc0S8T0srj29I3H9NZDrXK+3fLlcCh/KqCmPXE9OUG6zFEATdB7IkXP7UoXNDK8877lyaf2xVFe3YmCEAvSuXKYUxUVEVBUjyQFlZtDdO+2oNb0qSTto12NiHmu1tGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=H7XzIr42; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="H7XzIr42"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1736613672; x=1737218472; i=christian@heusel.eu;
	bh=Ycl6LeaXbEtzUW2+mPJlE0it+0ww3M/jBrkUN33uv/8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=H7XzIr428FKlXZ+KgU10v1lkvCDPc618/ZQNCwwr9R3hoWPo3+KahhOji+l2+HyB
	 3Lqhl6EV9ySEPEcYfVEWkYlUYFnGC/wfvdO6wIXoe6lewt0CHZVTN8oKa3Ko4+Apm
	 u1cbJw9f9Da+RtyO00PaegZ3Bdh8AoD2Xdv3HMzUA21j5MmDGzkgZpNkzznAImFCF
	 huP5xJLwk2zH/iogTofZpLl3Ne0NglTYBgBdE7XNMBAgOdOjmMtHS8T7O8rMqIqDg
	 Zg01N5vloWslM4QjxYiBXmTO7lMBNirK2Rz4zO73KY/Zdm7a+iKTT0hwE0VhMt8hf
	 1hvoA7mLvwllJt+PRQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([94.31.75.239]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MLzSD-1toawD2V3R-00WKbm; Sat, 11 Jan 2025 17:41:12 +0100
Date: Sat, 11 Jan 2025 17:41:10 +0100
From: Christian Heusel <christian@heusel.eu>
To: Niklas Cassel <cassel@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION][BISECTED] BU40N Blu-Ray drive broken since
 7627a0edef54
Message-ID: <e167b28c-94a2-45bf-8330-2487baf7199b@heusel.eu>
References: <e2be6f70-dff6-4b79-bd49-70ec7e27fc1c@heusel.eu>
 <Z4EDf4ecHyfTq3Hp@x1-carbon>
 <69589dad-c0c8-4a72-9f3d-c1b0c29c96c1@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oa3nb6u4iqk2fxoy"
Content-Disposition: inline
In-Reply-To: <69589dad-c0c8-4a72-9f3d-c1b0c29c96c1@heusel.eu>
X-Provags-ID: V03:K1:KeAEMTrrXCop4oxLfcI01Ycok9nWmjWsvCgK3oSBQppYLAnQnis
 rnQJ9a162I8uksk1bglfAQvaReM1bhIoFhLArU0V/7PDDkubLlTJUUnDuyn4SXGkBjKx8+V
 wabg0fKz4dN7amJfj6v8wJHJ46gGWoz7gfmx+zNc5BDuUIetKVu1lgg/QXutt+SWb54+VrV
 ir+tcPGYykXP+iuKxXBtw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jpBwgWuoDVE=;ZO8eVLjgbou8HHtT4AtMZx7h6xJ
 Rp9aMpHRZJZMXux2DTI7rUoSv0mMNtBhpnyv5mda07w8WcPf0PG31gw03MyeEGDQwba3LvrQn
 vWGwjUtFAOxCu/NDIW0Jw7x1RtT8BBF2qs7y+IcFWQeMl+4H02DDQnZ66glx/sfJCc4ertokZ
 Nx8G1tXSNU+c03bgvOxq9fT2eVZWDZzKybdIqzD7Wudw1xPfkvAeN9qmrKgsEyhqyj0b3Equd
 ou40PXm70G8/6bzfV93yWPKbXWsOdmbDkgKeLSvQx5uXQNffHZ1JSDc6TWDPBBv0v/JMgCKxK
 6orOluPtX7idKJEKnAbshyt4mymNFLjkfdpYSOKuS+L/z7jHq8ffLIwna1BjDz83+0fAqB9ou
 2gcXPdPNUtSqJgj50wZcZQXwhsYNnZCVgXOSZk8QKo/oW6RQPFPEZFRX/uwLzAF/Fvxc8/tlL
 FRbz7tdQ4IWjU7fbeGfarLsjsnz8g/hKxx9WWHgiT8T8nezvqs7AbAJw4sfrtpBav/oKlArAF
 PbkKO369hMwHJxAEE/XRAsl/nw5LRh51oJL7W8VjX9NzE2iQrmrNN1mDpCmeonmrwITDQTLT4
 CJ7cr/UFtP7vciwadum4IKGX33xcxrPyy/3/AiwAI8qYREWA1D6/9WyC7nih3/ZSrhpTboaPw
 upkxkUurN7SOoaJ2zyge/ehf5v2wDfyu+t7Gzqq+vH2QRg6GF5hN0s3QgnJtBqMo+kt+5Ozzl
 0h+hZ+X3vs3As/irykiuA+wD4cEYopzWatj8F77PkwbAFNyeu3CCUoA5brT2oOOePvIMNjrUy
 w2yZ5ewzfWOCbaavdDlU3Ea9RHjhFDdtIvB8MFROVbbFyHGGzPwQ7Nz074SHUwMgALbVeObsi
 AzF2DyBMN86W1oTVMpx5a/S9KR1oK0z8e2SsRje1xVFtOTYXqSHQUtXeXutMSvOEHT+mK9J9C
 LDI8VtX4ng4xZ4owhnA38lECYKFAYlpT5pWl7YHn4jb14nKGVng7OcTi3nSp7z02FIppCA3AJ
 qRLB83RuQ6pUwiOit7PiBsQ7ENF39g89N3bEAio


--oa3nb6u4iqk2fxoy
Content-Type: multipart/mixed; protected-headers=v1;
	boundary="a3gqruvbfv63yvcv"
Content-Disposition: inline
Subject: Re: [REGRESSION][BISECTED] BU40N Blu-Ray drive broken since
 7627a0edef54
MIME-Version: 1.0


--a3gqruvbfv63yvcv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25/01/10 05:21PM, Christian Heusel wrote:
> On 25/01/10 12:24PM, Niklas Cassel wrote:
> > On Fri, Jan 10, 2025 at 10:04:46AM +0100, Christian Heusel wrote:
> >
> > > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > > index c085dd8..ef01ccd 100644
> > > --- a/drivers/ata/libata-core.c
> > > +++ b/drivers/ata/libata-core.c
> > > @@ -4118,6 +4118,9 @@ static const struct ata_dev_quirks_entry __ata_=
dev_quirks[] =3D {
> > >  	{ "SAMSUNG MZ7TD256HAFV-000L9", NULL,       ATA_QUIRK_NOLPM },
> > >  	{ "SAMSUNG MZ7TE512HMHP-000L1", "EXT06L0Q", ATA_QUIRK_NOLPM },
> > > =20
> > > +	/* Hitachi-LG Data Storage models with LPM issues */
> > > +	{ "HL-DT-ST BD-RE BU40N", NULL, ATA_QUIRK_NOLPM },
> > > +
> > >  	/* devices that don't properly handle queued TRIM commands */
> > >  	{ "Micron_M500IT_*",		"MU01",	ATA_QUIRK_NO_NCQ_TRIM |
> > >  						ATA_QUIRK_ZERO_AFTER_TRIM },
> > >=20
> > > So if anyone has feedback on why the patch does not work or any
> > > alternative ideas for a solution that would be highly appreciated!

So weirdly the quirk from the patch for the same kernel _does work_ when
the user passes the kernel parameter "ahci.mobile_lpm_policy=3D1":

[   24.035361] ata4.00: Model 'HL-DT-ST BD-RE BU40N', rev '1.03', applying =
quirks: nolpm

Any idea why that could be? Is it maybe not the device itself but the
controller that it connects to that is borked and in need of the quirk?

I have attached the full dmesg output.

Cheers,
Chris

--a3gqruvbfv63yvcv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="dmesg-linux-mainline-v6.13-rc6-with-commandline.log"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Linux version 6.13.0-rc6-1.1-mainline-dirty (linux-mainline@=
archlinux) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU Binutils) 2.43.1) #1 SMP=
 PREEMPT_DYNAMIC Fri, 10 Jan 2025 10:00:38 +0000
[    0.000000] Command line: initrd=3D\intel-ucode.img initrd=3D\initramfs-=
linux-mainline.img root=3D/dev/nvme0n1p1 rw intel_iommu=3Don ahci.mobile_lp=
m_policy=3D1
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
[    0.000000] e820: update [mem 0x7bf1d018-0x7bf3b457] usable =3D=3D> usab=
le
[    0.000000] e820: update [mem 0x7bf0e018-0x7bf1c057] usable =3D=3D> usab=
le
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ef=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000000009f000-0x00000000000fff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000007bf0e0=
17] usable
[    0.000000] reserve setup_data: [mem 0x000000007bf0e018-0x000000007bf1c0=
57] usable
[    0.000000] reserve setup_data: [mem 0x000000007bf1c058-0x000000007bf1d0=
17] usable
[    0.000000] reserve setup_data: [mem 0x000000007bf1d018-0x000000007bf3b4=
57] usable
[    0.000000] reserve setup_data: [mem 0x000000007bf3b458-0x000000008a26ff=
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
ESRT=3D0x88b80398 RNG=3D0x8a6bdf18 INITRD=3D0x80e3fa18 TPMEventLog=3D0x8a6b=
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
[    0.000848] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000851] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000859] last_pfn =3D 0x46e000 max_arch_pfn =3D 0x400000000
[    0.000864] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built fr=
om 10 variable MTRRs
[    0.000865] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.001141] last_pfn =3D 0x8dc0f max_arch_pfn =3D 0x400000000
[    0.008581] esrt: Reserving ESRT space from 0x0000000088b80398 to 0x0000=
000088b80420.
[    0.008586] e820: update [mem 0x88b80000-0x88b80fff] usable =3D=3D> rese=
rved
[    0.008602] Using GB pages for direct mapping
[    0.009072] Secure boot disabled
[    0.009072] RAMDISK: [mem 0x7bf3c000-0x7d3fffff]
[    0.009093] ACPI: Early table checksum verification disabled
[    0.009095] ACPI: RSDP 0x000000008A6BE000 000024 (v02 HPQOEM)
[    0.009099] ACPI: XSDT 0x000000008A6BE0C0 0000FC (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009104] ACPI: FACP 0x000000008A704DC8 000114 (v06 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009109] ACPI: DSDT 0x000000008A6BE248 046B7A (v02 HPQOEM SLIC-CPC 01=
072009 INTL 20160527)
[    0.009112] ACPI: FACS 0x000000008AB93080 000040
[    0.009114] ACPI: APIC 0x000000008A704EE0 0000BC (v04 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009117] ACPI: FPDT 0x000000008A704FA0 000044 (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009120] ACPI: FIDT 0x000000008A704FE8 00009C (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009123] ACPI: MCFG 0x000000008A705088 00003C (v01 HPQOEM SLIC-CPC 01=
072009 MSFT 00000097)
[    0.009125] ACPI: SSDT 0x000000008A7050C8 001B5F (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.009128] ACPI: MSDM 0x000000008A706C28 000055 (v03 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009131] ACPI: SSDT 0x000000008A706C80 000060 (v01 HPQOEM SLIC-CPC 00=
000001 INTL 20160527)
[    0.009133] ACPI: SSDT 0x000000008A706CE0 000060 (v01 HPQOEM SLIC-CPC 00=
000001 INTL 20160527)
[    0.009136] ACPI: SSDT 0x000000008A706D40 0031C6 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.009138] ACPI: SSDT 0x000000008A709F08 00241B (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009141] ACPI: HPET 0x000000008A70C328 000038 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009143] ACPI: SSDT 0x000000008A70C360 001D39 (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009146] ACPI: SSDT 0x000000008A70E0A0 000FAE (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009149] ACPI: SSDT 0x000000008A70F050 000BDF (v02 HPQOEM SLIC-CPC 00=
000000 INTL 20160527)
[    0.009151] ACPI: UEFI 0x000000008A70FC30 000042 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009154] ACPI: LPIT 0x000000008A70FC78 000094 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009156] ACPI: SSDT 0x000000008A70FD10 0027DE (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009159] ACPI: SSDT 0x000000008A7124F0 0014E2 (v02 HPQOEM SLIC-CPC 00=
000000 INTL 20160527)
[    0.009162] ACPI: DBGP 0x000000008A7139D8 000034 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009164] ACPI: DBG2 0x000000008A713A10 000054 (v00 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009167] ACPI: SSDT 0x000000008A713A68 001B67 (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009169] ACPI: DMAR 0x000000008A7155D0 000070 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009172] ACPI: VFCT 0x000000008A715640 00B284 (v01 HPQOEM SLIC-CPC 00=
000001 AMD  31504F47)
[    0.009175] ACPI: BGRT 0x000000008A7208C8 000038 (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009177] ACPI: TPM2 0x000000008A720900 000034 (v04 HPQOEM SLIC-CPC 00=
000001 AMI  00000000)
[    0.009180] ACPI: WSMT 0x000000008A720938 000028 (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009182] ACPI: Reserving FACP table memory at [mem 0x8a704dc8-0x8a704=
edb]
[    0.009183] ACPI: Reserving DSDT table memory at [mem 0x8a6be248-0x8a704=
dc1]
[    0.009184] ACPI: Reserving FACS table memory at [mem 0x8ab93080-0x8ab93=
0bf]
[    0.009185] ACPI: Reserving APIC table memory at [mem 0x8a704ee0-0x8a704=
f9b]
[    0.009186] ACPI: Reserving FPDT table memory at [mem 0x8a704fa0-0x8a704=
fe3]
[    0.009186] ACPI: Reserving FIDT table memory at [mem 0x8a704fe8-0x8a705=
083]
[    0.009187] ACPI: Reserving MCFG table memory at [mem 0x8a705088-0x8a705=
0c3]
[    0.009188] ACPI: Reserving SSDT table memory at [mem 0x8a7050c8-0x8a706=
c26]
[    0.009189] ACPI: Reserving MSDM table memory at [mem 0x8a706c28-0x8a706=
c7c]
[    0.009189] ACPI: Reserving SSDT table memory at [mem 0x8a706c80-0x8a706=
cdf]
[    0.009190] ACPI: Reserving SSDT table memory at [mem 0x8a706ce0-0x8a706=
d3f]
[    0.009191] ACPI: Reserving SSDT table memory at [mem 0x8a706d40-0x8a709=
f05]
[    0.009192] ACPI: Reserving SSDT table memory at [mem 0x8a709f08-0x8a70c=
322]
[    0.009193] ACPI: Reserving HPET table memory at [mem 0x8a70c328-0x8a70c=
35f]
[    0.009193] ACPI: Reserving SSDT table memory at [mem 0x8a70c360-0x8a70e=
098]
[    0.009194] ACPI: Reserving SSDT table memory at [mem 0x8a70e0a0-0x8a70f=
04d]
[    0.009195] ACPI: Reserving SSDT table memory at [mem 0x8a70f050-0x8a70f=
c2e]
[    0.009196] ACPI: Reserving UEFI table memory at [mem 0x8a70fc30-0x8a70f=
c71]
[    0.009196] ACPI: Reserving LPIT table memory at [mem 0x8a70fc78-0x8a70f=
d0b]
[    0.009197] ACPI: Reserving SSDT table memory at [mem 0x8a70fd10-0x8a712=
4ed]
[    0.009198] ACPI: Reserving SSDT table memory at [mem 0x8a7124f0-0x8a713=
9d1]
[    0.009199] ACPI: Reserving DBGP table memory at [mem 0x8a7139d8-0x8a713=
a0b]
[    0.009199] ACPI: Reserving DBG2 table memory at [mem 0x8a713a10-0x8a713=
a63]
[    0.009200] ACPI: Reserving SSDT table memory at [mem 0x8a713a68-0x8a715=
5ce]
[    0.009201] ACPI: Reserving DMAR table memory at [mem 0x8a7155d0-0x8a715=
63f]
[    0.009202] ACPI: Reserving VFCT table memory at [mem 0x8a715640-0x8a720=
8c3]
[    0.009203] ACPI: Reserving BGRT table memory at [mem 0x8a7208c8-0x8a720=
8ff]
[    0.009203] ACPI: Reserving TPM2 table memory at [mem 0x8a720900-0x8a720=
933]
[    0.009204] ACPI: Reserving WSMT table memory at [mem 0x8a720938-0x8a720=
95f]
[    0.009527] No NUMA configuration found
[    0.009528] Faking a node at [mem 0x0000000000000000-0x000000046dffffff]
[    0.009537] NODE_DATA(0) allocated [mem 0x46dfd52c0-0x46dffffff]
[    0.009793] Zone ranges:
[    0.009793]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.009795]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.009796]   Normal   [mem 0x0000000100000000-0x000000046dffffff]
[    0.009798]   Device   empty
[    0.009799] Movable zone start for each node
[    0.009801] Early memory node ranges
[    0.009801]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.009803]   node   0: [mem 0x0000000000100000-0x000000008a26ffff]
[    0.009804]   node   0: [mem 0x000000008dc0e000-0x000000008dc0efff]
[    0.009805]   node   0: [mem 0x0000000100000000-0x000000046dffffff]
[    0.009807] Initmem setup node 0 [mem 0x0000000000001000-0x000000046dfff=
fff]
[    0.009812] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.009833] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.012675] On node 0, zone DMA32: 14750 pages in unavailable ranges
[    0.029943] On node 0, zone Normal: 9201 pages in unavailable ranges
[    0.030035] On node 0, zone Normal: 8192 pages in unavailable ranges
[    0.031243] ACPI: PM-Timer IO Port: 0x1808
[    0.031249] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.031251] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.031252] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.031253] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.031253] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.031254] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.031255] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.031255] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.031318] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.031321] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.031322] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.031326] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.031327] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.031334] e820: update [mem 0x86b6d000-0x86bdffff] usable =3D=3D> rese=
rved
[    0.031346] TSC deadline timer available
[    0.031351] CPU topo: Max. logical packages:   1
[    0.031352] CPU topo: Max. logical dies:       1
[    0.031352] CPU topo: Max. dies per package:   1
[    0.031356] CPU topo: Max. threads per core:   1
[    0.031357] CPU topo: Num. cores per package:     8
[    0.031358] CPU topo: Num. threads per package:   8
[    0.031359] CPU topo: Allowing 8 present CPUs plus 0 hotplug CPUs
[    0.031372] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.031374] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0=
x000fffff]
[    0.031375] PM: hibernation: Registered nosave memory: [mem 0x7bf0e000-0=
x7bf0efff]
[    0.031377] PM: hibernation: Registered nosave memory: [mem 0x7bf1c000-0=
x7bf1cfff]
[    0.031378] PM: hibernation: Registered nosave memory: [mem 0x7bf1d000-0=
x7bf1dfff]
[    0.031379] PM: hibernation: Registered nosave memory: [mem 0x7bf3b000-0=
x7bf3bfff]
[    0.031381] PM: hibernation: Registered nosave memory: [mem 0x86b6d000-0=
x86bdffff]
[    0.031382] PM: hibernation: Registered nosave memory: [mem 0x88b80000-0=
x88b80fff]
[    0.031384] PM: hibernation: Registered nosave memory: [mem 0x8a270000-0=
x8a6a4fff]
[    0.031384] PM: hibernation: Registered nosave memory: [mem 0x8a6a5000-0=
x8a721fff]
[    0.031385] PM: hibernation: Registered nosave memory: [mem 0x8a722000-0=
x8ab95fff]
[    0.031386] PM: hibernation: Registered nosave memory: [mem 0x8ab96000-0=
x8dc0dfff]
[    0.031387] PM: hibernation: Registered nosave memory: [mem 0x8dc0f000-0=
x8fffffff]
[    0.031388] PM: hibernation: Registered nosave memory: [mem 0x90000000-0=
xfdffffff]
[    0.031389] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0=
xfe010fff]
[    0.031389] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0=
xfebfffff]
[    0.031390] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0=
xfec00fff]
[    0.031391] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0=
xfecfffff]
[    0.031391] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0=
xfed03fff]
[    0.031392] PM: hibernation: Registered nosave memory: [mem 0xfed04000-0=
xfedfffff]
[    0.031393] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0=
xfee00fff]
[    0.031393] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0=
xffffffff]
[    0.031395] [mem 0x90000000-0xfdffffff] available for PCI devices
[    0.031396] Booting paravirtualized kernel on bare hardware
[    0.031398] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 6370452778343963 ns
[    0.037806] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr=
_node_ids:1
[    0.038219] percpu: Embedded 67 pages/cpu s237568 r8192 d28672 u524288
[    0.038226] pcpu-alloc: s237568 r8192 d28672 u524288 alloc=3D1*2097152
[    0.038228] pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7=20
[    0.038248] Kernel command line: initrd=3D\intel-ucode.img initrd=3D\ini=
tramfs-linux-mainline.img root=3D/dev/nvme0n1p1 rw intel_iommu=3Don ahci.mo=
bile_lpm_policy=3D1
[    0.038309] DMAR: IOMMU enabled
[    0.038339] printk: log buffer data + meta data: 131072 + 458752 =3D 589=
824 bytes
[    0.039546] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes, linear)
[    0.040142] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes, linear)
[    0.040240] Fallback order for Node 0: 0=20
[    0.040243] Built 1 zonelists, mobility grouping on.  Total pages: 41620=
63
[    0.040244] Policy zone: Normal
[    0.040413] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.040420] software IO TLB: area num 8.
[    0.082552] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D8, N=
odes=3D1
[    0.082588] ftrace: allocating 51623 entries in 202 pages
[    0.103881] ftrace: allocated 202 pages with 4 groups
[    0.103957] Dynamic Preempt: full
[    0.104003] rcu: Preemptible hierarchical RCU implementation.
[    0.104004] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D8.
[    0.104005] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.104006] 	Trampoline variant of Tasks RCU enabled.
[    0.104006] 	Rude variant of Tasks RCU enabled.
[    0.104007] 	Tracing variant of Tasks RCU enabled.
[    0.104007] rcu: RCU calculated value of scheduler-enlistment delay is 3=
0 jiffies.
[    0.104008] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D8
[    0.104014] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjus=
t=3D1 rcu_task_cpu_ids=3D8.
[    0.104016] RCU Tasks Rude: Setting shift to 3 and lim to 1 rcu_task_cb_=
adjust=3D1 rcu_task_cpu_ids=3D8.
[    0.104018] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb=
_adjust=3D1 rcu_task_cpu_ids=3D8.
[    0.109765] NR_IRQS: 524544, nr_irqs: 2048, preallocated irqs: 16
[    0.110054] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.110451] kfence: initialized - using 2097152 bytes for 255 objects at=
 0x(____ptrval____)-0x(____ptrval____)
[    0.110483] Console: colour dummy device 80x25
[    0.110486] printk: legacy console [tty0] enabled
[    0.110535] ACPI: Core revision 20240827
[    0.110781] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.110847] APIC: Switch to symmetric I/O mode setup
[    0.110849] DMAR: Host address width 39
[    0.110850] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.110856] DMAR: dmar0: reg_base_addr fed91000 ver 1:0 cap d2008c406604=
62 ecap f050da
[    0.110858] DMAR: RMRR base: 0x0000008b72e000 end: 0x0000008b977fff
[    0.110861] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 0
[    0.110863] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.110864] DMAR-IR: Queued invalidation will be enabled to support x2ap=
ic and Intr-remapping.
[    0.113911] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.113912] x2apic enabled
[    0.113982] APIC: Switched APIC routing to: cluster x2apic
[    0.123139] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x2b3e459bf4c, max_idle_ns: 440795289890 ns
[    0.123144] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 6002.00 BogoMIPS (lpj=3D10000000)
[    0.123165] x86/cpu: SGX disabled or unsupported by BIOS.
[    0.123172] CPU0: Thermal monitoring enabled (TM1)
[    0.123226] Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
[    0.123228] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.123232] process: using mwait in idle threads
[    0.123234] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.123236] Spectre V2 : Spectre BHI mitigation: SW BHB clearing on sysc=
all and VM exit
[    0.123237] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.123237] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.123238] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL =
on VMEXIT
[    0.123239] RETBleed: Mitigation: Enhanced IBRS
[    0.123240] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.123242] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl
[    0.123247] TAA: Mitigation: TSX disabled
[    0.123248] MMIO Stale Data: Mitigation: Clear CPU buffers
[    0.123251] SRBDS: Mitigation: Microcode
[    0.123256] GDS: Mitigation: Microcode
[    0.123260] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.123261] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.123262] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.123263] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registe=
rs'
[    0.123264] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.123265] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.123267] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.123268] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.123269] x86/fpu: Enabled xstate features 0x1f, context size is 960 b=
ytes, using 'compacted' format.
[    0.126475] Freeing SMP alternatives memory: 40K
[    0.126475] pid_max: default: 32768 minimum: 301
[    0.126475] LSM: initializing lsm=3Dcapability,landlock,lockdown,yama,bpf
[    0.126475] landlock: Up and running.
[    0.126475] Yama: becoming mindful.
[    0.126475] LSM support for eBPF active
[    0.126475] Mount-cache hash table entries: 32768 (order: 6, 262144 byte=
s, linear)
[    0.126475] Mountpoint-cache hash table entries: 32768 (order: 6, 262144=
 bytes, linear)
[    0.126475] smpboot: CPU0: Intel(R) Core(TM) i7-9700F CPU @ 3.00GHz (fam=
ily: 0x6, model: 0x9e, stepping: 0xd)
[    0.126475] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR,=
 full-width counters, Intel PMU driver.
[    0.126475] ... version:                4
[    0.126475] ... bit width:              48
[    0.126475] ... generic registers:      8
[    0.126475] ... value mask:             0000ffffffffffff
[    0.126475] ... max period:             00007fffffffffff
[    0.126475] ... fixed-purpose events:   3
[    0.126475] ... event mask:             00000007000000ff
[    0.126475] signal: max sigframe size: 2032
[    0.126475] Estimated ratio of average max frequency by base frequency (=
times 1024): 1570
[    0.126475] rcu: Hierarchical SRCU implementation.
[    0.126475] rcu: 	Max phase no-delay instances is 1000.
[    0.126475] Timer migration: 1 hierarchy levels; 8 children per group; 1=
 crossnode level
[    0.126475] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.126475] smp: Bringing up secondary CPUs ...
[    0.126475] smpboot: x86: Booting SMP configuration:
[    0.126475] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.129858] ------------[ cut here ]------------
[    0.129862] workqueue: work disable count underflowed
[    0.129864] WARNING: CPU: 1 PID: 25 at kernel/workqueue.c:4317 enable_wo=
rk+0xdc/0x100
[    0.129870] Modules linked in:
[    0.129873] CPU: 1 UID: 0 PID: 25 Comm: cpuhp/1 Not tainted 6.13.0-rc6-1=
=2E1-mainline-dirty #1 c275e5d56fcc663358af28dad0103f8555743e5b
[    0.129876] Hardware name: HP HP Pavilion Desktop TP01-0xxx/8653, BIOS F=
=2E37 10/26/2023
[    0.129878] RIP: 0010:enable_work+0xdc/0x100
[    0.129881] Code: de 2e 02 00 74 04 31 ed eb b3 48 c7 c7 58 a7 28 9d 48 =
89 54 24 10 89 44 24 0c 48 89 34 24 c6 05 85 de 2e 02 01 e8 64 5e fd ff <0f=
> 0b 31 ed 48 8b 34 24 8b 44 24 0c 48 8b 54 24 10 eb 80 e8 0c db
[    0.129883] RSP: 0000:ffffb11580193e10 EFLAGS: 00010086
[    0.129885] RAX: 0000000000000000 RBX: ffff8d48ddab1a40 RCX: 00000000000=
00003
[    0.129887] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 00000000000=
00001
[    0.129888] RBP: ffffb11580193e28 R08: 0000000000000000 R09: ffffb115801=
93c90
[    0.129889] R10: ffffffff9dcb53c8 R11: 0000000000000003 R12: 00000000000=
000c4
[    0.129890] R13: ffffffff9bde3c70 R14: 0000000000000000 R15: ffff8d48dda=
a1408
[    0.129891] FS:  0000000000000000(0000) GS:ffff8d48dda80000(0000) knlGS:=
0000000000000000
[    0.129893] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.129894] CR2: 0000000000000000 CR3: 0000000351622001 CR4: 00000000003=
706f0
[    0.129896] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[    0.129897] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[    0.129898] Call Trace:
[    0.129900]  <TASK>
[    0.129901]  ? enable_work+0xdc/0x100
[    0.129904]  ? __warn.cold+0x93/0xf6
[    0.129906]  ? enable_work+0xdc/0x100
[    0.129909]  ? report_bug+0xff/0x140
[    0.129911]  ? handle_bug+0x58/0x90
[    0.129913]  ? exc_invalid_op+0x17/0x70
[    0.129914]  ? asm_exc_invalid_op+0x1a/0x20
[    0.129918]  ? __pfx_vmstat_cpu_online+0x10/0x10
[    0.129921]  ? enable_work+0xdc/0x100
[    0.129924]  vmstat_cpu_online+0x61/0x70
[    0.129927]  cpuhp_invoke_callback+0x11f/0x420
[    0.129929]  ? __pfx_smpboot_thread_fn+0x10/0x10
[    0.129931]  cpuhp_thread_fun+0xa2/0x170
[    0.129933]  smpboot_thread_fn+0xda/0x1d0
[    0.129935]  kthread+0xcf/0x100
[    0.129937]  ? __pfx_kthread+0x10/0x10
[    0.129939]  ret_from_fork+0x31/0x50
[    0.129941]  ? __pfx_kthread+0x10/0x10
[    0.129943]  ret_from_fork_asm+0x1a/0x30
[    0.129946]  </TASK>
[    0.129947] ---[ end trace 0000000000000000 ]---
[    0.129950] smp: Brought up 1 node, 8 CPUs
[    0.129950] smpboot: Total of 8 processors activated (48019.00 BogoMIPS)
[    0.131852] Memory: 16201520K/16648252K available (18432K kernel code, 2=
692K rwdata, 14428K rodata, 4292K init, 3948K bss, 431576K reserved, 0K cma=
-reserved)
[    0.133306] devtmpfs: initialized
[    0.133306] x86/mm: Memory block size: 128MB
[    0.134318] ACPI: PM: Registering ACPI NVS region [mem 0x8a722000-0x8ab9=
5fff] (4669440 bytes)
[    0.134318] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 6370867519511994 ns
[    0.134318] futex hash table entries: 2048 (order: 5, 131072 bytes, line=
ar)
[    0.134318] pinctrl core: initialized pinctrl subsystem
[    0.134318] PM: RTC time: 13:18:07, date: 2025-01-11
[    0.134318] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.134319] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.134432] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.134546] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.134552] audit: initializing netlink subsys (disabled)
[    0.134608] audit: type=3D2000 audit(1736601487.000:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.134608] thermal_sys: Registered thermal governor 'fair_share'
[    0.134608] thermal_sys: Registered thermal governor 'bang_bang'
[    0.134608] thermal_sys: Registered thermal governor 'step_wise'
[    0.134608] thermal_sys: Registered thermal governor 'user_space'
[    0.134608] thermal_sys: Registered thermal governor 'power_allocator'
[    0.134608] cpuidle: using governor ladder
[    0.134608] cpuidle: using governor menu
[    0.134608] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    0.134608] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.134608] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for =
domain 0000 [bus 00-ff]
[    0.134608] PCI: Using configuration type 1 for base access
[    0.134608] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.137502] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.137502] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.137502] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.137502] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.137502] fbcon: Taking over console
[    0.137502] ACPI: Added _OSI(Module Device)
[    0.137502] ACPI: Added _OSI(Processor Device)
[    0.137502] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.137502] ACPI: Added _OSI(Processor Aggregator Device)
[    0.191164] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    0.198073] ACPI: Dynamic OEM Table Load:
[    0.198073] ACPI: SSDT 0xFFFF8D45810C0800 000400 (v02 HPQOEM SLIC-CPC 00=
003001 INTL 20160527)
[    0.198073] ACPI: Dynamic OEM Table Load:
[    0.198073] ACPI: SSDT 0xFFFF8D45810BD000 000605 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.200618] ACPI: Dynamic OEM Table Load:
[    0.200622] ACPI: SSDT 0xFFFF8D45810E9100 0000F4 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.201561] ACPI: Dynamic OEM Table Load:
[    0.201566] ACPI: SSDT 0xFFFF8D458184F600 000149 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.202461] ACPI: Dynamic OEM Table Load:
[    0.202466] ACPI: SSDT 0xFFFF8D45810BE800 000724 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.203587] ACPI: Dynamic OEM Table Load:
[    0.203593] ACPI: SSDT 0xFFFF8D45810B9800 0005FC (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.204646] ACPI: Dynamic OEM Table Load:
[    0.204650] ACPI: SSDT 0xFFFF8D45810C1C00 000317 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.205703] ACPI: Dynamic OEM Table Load:
[    0.205708] ACPI: SSDT 0xFFFF8D45818C4000 000AB0 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.207269] ACPI: Dynamic OEM Table Load:
[    0.207274] ACPI: SSDT 0xFFFF8D45810C1800 00030A (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.211436] ACPI: EC: EC started
[    0.211437] ACPI: EC: interrupt blocked
[    0.212026] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.212028] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle tran=
sactions
[    0.212030] ACPI: Interpreter enabled
[    0.212066] ACPI: PM: (supports S0 S3 S4 S5)
[    0.212067] ACPI: Using IOAPIC for interrupt routing
[    0.213271] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.213273] PCI: Ignoring E820 reservations for host bridge windows
[    0.214451] ACPI: Enabled 10 GPEs in block 00 to 7F
[    0.231173] ACPI: \_SB_.PCI0.XDCI.USBC: New power resource
[    0.231324] ACPI: \_SB_.PCI0.PAUD: New power resource
[    0.233792] ACPI: \SPR2: New power resource
[    0.233966] ACPI: \SPR3: New power resource
[    0.234261] ACPI: \ZPDR: New power resource
[    0.234506] ACPI: \_SB_.PCI0.SAT0.VOL0.V0PR: New power resource
[    0.234707] ACPI: \_SB_.PCI0.SAT0.VOL1.V1PR: New power resource
[    0.234902] ACPI: \_SB_.PCI0.SAT0.VOL2.V2PR: New power resource
[    0.240462] ACPI: \_SB_.PCI0.I2C1.PXTC: New power resource
[    0.246899] ACPI: \_SB_.PCI0.CNVW.WRST: New power resource
[    0.251993] ACPI: \_TZ_.FN00: New power resource
[    0.252061] ACPI: \_TZ_.FN01: New power resource
[    0.252128] ACPI: \_TZ_.FN02: New power resource
[    0.252192] ACPI: \_TZ_.FN03: New power resource
[    0.252254] ACPI: \_TZ_.FN04: New power resource
[    0.252712] ACPI: \PIN_: New power resource
[    0.252866] ACPI: \SPR0: New power resource
[    0.252922] ACPI: \SPR1: New power resource
[    0.252976] ACPI: \SPR5: New power resource
[    0.253522] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.253529] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI EDR HPX-Type3]
[    0.256790] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME AER PCIeCapability LTR DPC]
[    0.256792] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    0.257974] PCI host bridge to bus 0000:00
[    0.257978] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.257981] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.257982] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.257984] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000efff=
f window]
[    0.257986] pci_bus 0000:00: root bus resource [mem 0x90000000-0xdffffff=
f window]
[    0.257987] pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7ffff=
f window]
[    0.257988] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.258081] pci 0000:00:00.0: [8086:3e30] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.258152] pci 0000:00:01.0: [8086:1901] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.258164] pci 0000:00:01.0: PCI bridge to [bus 01-03]
[    0.258167] pci 0000:00:01.0:   bridge window [io  0x5000-0x5fff]
[    0.258169] pci 0000:00:01.0:   bridge window [mem 0xa0300000-0xa05fffff]
[    0.258174] pci 0000:00:01.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.258200] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.258802] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000 convent=
ional PCI endpoint
[    0.258810] pci 0000:00:08.0: BAR 0 [mem 0xa0922000-0xa0922fff 64bit]
[    0.258984] pci 0000:00:12.0: [8086:a379] type 00 class 0x118000 convent=
ional PCI endpoint
[    0.259016] pci 0000:00:12.0: BAR 0 [mem 0xa0921000-0xa0921fff 64bit]
[    0.259277] pci 0000:00:14.0: [8086:a36d] type 00 class 0x0c0330 convent=
ional PCI endpoint
[    0.259313] pci 0000:00:14.0: BAR 0 [mem 0xa0900000-0xa090ffff 64bit]
[    0.259453] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.260153] pci 0000:00:14.2: [8086:a36f] type 00 class 0x050000 convent=
ional PCI endpoint
[    0.260184] pci 0000:00:14.2: BAR 0 [mem 0xa0916000-0xa0917fff 64bit]
[    0.260203] pci 0000:00:14.2: BAR 2 [mem 0xa0920000-0xa0920fff 64bit]
[    0.260356] pci 0000:00:14.5: [8086:a375] type 00 class 0x080501 convent=
ional PCI endpoint
[    0.260388] pci 0000:00:14.5: BAR 0 [mem 0xa091f000-0xa091ffff 64bit]
[    0.261221] pci 0000:00:15.0: [8086:a368] type 00 class 0x0c8000 convent=
ional PCI endpoint
[    0.261795] pci 0000:00:15.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.264713] pci 0000:00:15.1: [8086:a369] type 00 class 0x0c8000 convent=
ional PCI endpoint
[    0.265288] pci 0000:00:15.1: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.267892] pci 0000:00:16.0: [8086:a360] type 00 class 0x078000 convent=
ional PCI endpoint
[    0.267924] pci 0000:00:16.0: BAR 0 [mem 0xa091c000-0xa091cfff 64bit]
[    0.268042] pci 0000:00:16.0: PME# supported from D3hot
[    0.268672] pci 0000:00:17.0: [8086:a352] type 00 class 0x010601 convent=
ional PCI endpoint
[    0.268699] pci 0000:00:17.0: BAR 0 [mem 0xa0914000-0xa0915fff]
[    0.268715] pci 0000:00:17.0: BAR 1 [mem 0xa091b000-0xa091b0ff]
[    0.268729] pci 0000:00:17.0: BAR 2 [io  0x6050-0x6057]
[    0.268745] pci 0000:00:17.0: BAR 3 [io  0x6040-0x6043]
[    0.268759] pci 0000:00:17.0: BAR 4 [io  0x6020-0x603f]
[    0.268774] pci 0000:00:17.0: BAR 5 [mem 0xa091a000-0xa091a7ff]
[    0.268857] pci 0000:00:17.0: PME# supported from D3hot
[    0.269323] pci 0000:00:1c.0: [8086:a33d] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.269381] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    0.269388] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[    0.269393] pci 0000:00:1c.0:   bridge window [mem 0xa0800000-0xa08fffff]
[    0.269537] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.269586] pci 0000:00:1c.0: PTM enabled (root), 4ns granularity
[    0.270454] pci 0000:00:1c.7: [8086:a33f] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.270511] pci 0000:00:1c.7: PCI bridge to [bus 05]
[    0.270519] pci 0000:00:1c.7:   bridge window [io  0x3000-0x3fff]
[    0.270524] pci 0000:00:1c.7:   bridge window [mem 0xa0700000-0xa07fffff]
[    0.270666] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
[    0.270713] pci 0000:00:1c.7: PTM enabled (root), 4ns granularity
[    0.271505] pci 0000:00:1d.0: [8086:a330] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.271563] pci 0000:00:1d.0: PCI bridge to [bus 06]
[    0.271574] pci 0000:00:1d.0:   bridge window [mem 0xa0600000-0xa06fffff]
[    0.271733] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.271785] pci 0000:00:1d.0: PTM enabled (root), 4ns granularity
[    0.273021] pci 0000:00:1e.0: [8086:a328] type 00 class 0x078000 convent=
ional PCI endpoint
[    0.273563] pci 0000:00:1e.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.276164] pci 0000:00:1f.0: [8086:a304] type 00 class 0x060100 convent=
ional PCI endpoint
[    0.276731] pci 0000:00:1f.3: [8086:a348] type 00 class 0x040300 convent=
ional PCI endpoint
[    0.276790] pci 0000:00:1f.3: BAR 0 [mem 0xa0910000-0xa0913fff 64bit]
[    0.276864] pci 0000:00:1f.3: BAR 4 [mem 0xa0200000-0xa02fffff 64bit]
[    0.277014] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.278397] pci 0000:00:1f.4: [8086:a323] type 00 class 0x0c0500 convent=
ional PCI endpoint
[    0.278578] pci 0000:00:1f.4: BAR 0 [mem 0xa0918000-0xa09180ff 64bit]
[    0.278785] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.279296] pci 0000:00:1f.5: [8086:a324] type 00 class 0x0c8000 convent=
ional PCI endpoint
[    0.279322] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.279511] pci 0000:01:00.0: [1002:1478] type 01 class 0x060400 PCIe Sw=
itch Upstream Port
[    0.279522] pci 0000:01:00.0: BAR 0 [mem 0xa0500000-0xa0503fff]
[    0.279534] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.279539] pci 0000:01:00.0:   bridge window [io  0x5000-0x5fff]
[    0.279542] pci 0000:01:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.279550] pci 0000:01:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.279617] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.279666] pci 0000:01:00.0: 63.008 Gb/s available PCIe bandwidth, limi=
ted by 8.0 GT/s PCIe x8 link at 0000:00:01.0 (capable of 126.024 Gb/s with =
16.0 GT/s PCIe x8 link)
[    0.279761] pci 0000:00:01.0: PCI bridge to [bus 01-03]
[    0.279803] pci 0000:02:00.0: [1002:1479] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.279825] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.279830] pci 0000:02:00.0:   bridge window [io  0x5000-0x5fff]
[    0.279832] pci 0000:02:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.279840] pci 0000:02:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.279907] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.280029] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.280075] pci 0000:03:00.0: [1002:73ff] type 00 class 0x030000 PCIe Le=
gacy Endpoint
[    0.280089] pci 0000:03:00.0: BAR 0 [mem 0x90000000-0x9fffffff 64bit pre=
f]
[    0.280098] pci 0000:03:00.0: BAR 2 [mem 0xa0000000-0xa01fffff 64bit pre=
f]
[    0.280104] pci 0000:03:00.0: BAR 4 [io  0x5000-0x50ff]
[    0.280111] pci 0000:03:00.0: BAR 5 [mem 0xa0300000-0xa03fffff]
[    0.280117] pci 0000:03:00.0: ROM [mem 0xa0400000-0xa041ffff pref]
[    0.280188] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.280246] pci 0000:03:00.0: 63.008 Gb/s available PCIe bandwidth, limi=
ted by 8.0 GT/s PCIe x8 link at 0000:00:01.0 (capable of 252.048 Gb/s with =
16.0 GT/s PCIe x16 link)
[    0.280321] pci 0000:03:00.1: [1002:ab28] type 00 class 0x040300 PCIe Le=
gacy Endpoint
[    0.280330] pci 0000:03:00.1: BAR 0 [mem 0xa0420000-0xa0423fff]
[    0.280402] pci 0000:03:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.280493] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.280657] pci 0000:04:00.0: [10ec:8168] type 00 class 0x020000 PCIe En=
dpoint
[    0.280685] pci 0000:04:00.0: BAR 0 [io  0x4000-0x40ff]
[    0.280722] pci 0000:04:00.0: BAR 2 [mem 0xa0804000-0xa0804fff 64bit]
[    0.280745] pci 0000:04:00.0: BAR 4 [mem 0xa0800000-0xa0803fff 64bit]
[    0.280909] pci 0000:04:00.0: supports D1 D2
[    0.280911] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.281221] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    0.281375] pci 0000:05:00.0: [10ec:c821] type 00 class 0x028000 PCIe En=
dpoint
[    0.281402] pci 0000:05:00.0: BAR 0 [io  0x3000-0x30ff]
[    0.281434] pci 0000:05:00.0: BAR 2 [mem 0xa0700000-0xa070ffff 64bit]
[    0.281619] pci 0000:05:00.0: supports D1 D2
[    0.281620] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.282001] pci 0000:00:1c.7: PCI bridge to [bus 05]
[    0.282373] pci 0000:06:00.0: [8086:f1a8] type 00 class 0x010802 PCIe En=
dpoint
[    0.282408] pci 0000:06:00.0: BAR 0 [mem 0xa0600000-0xa0603fff 64bit]
[    0.282959] pci 0000:00:1d.0: PCI bridge to [bus 06]
[    0.285242] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.285325] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
[    0.285406] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.285486] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.285566] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.285646] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.285727] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.285806] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.291128] ACPI: EC: interrupt unblocked
[    0.291130] ACPI: EC: event unblocked
[    0.291142] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.291143] ACPI: EC: GPE=3D0xb
[    0.291144] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC initialization comp=
lete
[    0.291146] ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions =
and events
[    0.291200] iommu: Default domain type: Translated
[    0.291200] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.291200] SCSI subsystem initialized
[    0.291200] libata version 3.00 loaded.
[    0.291200] ACPI: bus type USB registered
[    0.291200] usbcore: registered new interface driver usbfs
[    0.291200] usbcore: registered new interface driver hub
[    0.291200] usbcore: registered new device driver usb
[    0.291200] EDAC MC: Ver: 3.0.0
[    0.291200] efivars: Registered efivars operations
[    0.293329] NetLabel: Initializing
[    0.293330] NetLabel:  domain hash size =3D 128
[    0.293331] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.293344] NetLabel:  unlabeled traffic allowed by default
[    0.293348] mctp: management component transport protocol core
[    0.293349] NET: Registered PF_MCTP protocol family
[    0.293356] PCI: Using ACPI for IRQ routing
[    0.377254] PCI: pci_cache_line_size set to 64 bytes
[    0.377854] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.377865] e820: reserve RAM buffer [mem 0x7bf0e018-0x7bffffff]
[    0.377866] e820: reserve RAM buffer [mem 0x7bf1d018-0x7bffffff]
[    0.377867] e820: reserve RAM buffer [mem 0x86b6d000-0x87ffffff]
[    0.377868] e820: reserve RAM buffer [mem 0x88b80000-0x8bffffff]
[    0.377869] e820: reserve RAM buffer [mem 0x8a270000-0x8bffffff]
[    0.377870] e820: reserve RAM buffer [mem 0x8dc0f000-0x8fffffff]
[    0.377871] e820: reserve RAM buffer [mem 0x46e000000-0x46fffffff]
[    0.377902] pci 0000:03:00.0: vgaarb: setting as boot VGA device
[    0.377902] pci 0000:03:00.0: vgaarb: bridge control possible
[    0.377902] pci 0000:03:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[    0.377902] vgaarb: loaded
[    0.377902] clocksource: Switched to clocksource tsc-early
[    0.377902] VFS: Disk quotas dquot_6.6.0
[    0.377902] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.377902] pnp: PnP ACPI init
[    0.377902] system 00:00: [mem 0x40000000-0x403fffff] could not be reser=
ved
[    0.377938] system 00:01: [io  0x0a00-0x0a0f] has been reserved
[    0.377941] system 00:01: [io  0x0a10-0x0a1f] has been reserved
[    0.377942] system 00:01: [io  0x0a20-0x0a2f] has been reserved
[    0.377944] system 00:01: [io  0x0a30-0x0a3f] has been reserved
[    0.377945] system 00:01: [io  0x0a40-0x0a4f] has been reserved
[    0.377946] system 00:01: [io  0x0a50-0x0a5f] has been reserved
[    0.377948] system 00:01: [io  0x0a60-0x0a6f] has been reserved
[    0.377949] system 00:01: [io  0x0a70-0x0a7f] has been reserved
[    0.377950] system 00:01: [io  0x0a80-0x0a8f] has been reserved
[    0.377952] system 00:01: [io  0x0a90-0x0b8e] has been reserved
[    0.377953] system 00:01: [io  0x0aa0-0x0aaf] has been reserved
[    0.377954] system 00:01: [io  0x0ab0-0x0abf] has been reserved
[    0.377956] system 00:01: [io  0x0ac0-0x0acf] has been reserved
[    0.377957] system 00:01: [io  0x0ad0-0x0adf] has been reserved
[    0.378333] system 00:02: [io  0x0680-0x069f] has been reserved
[    0.378333] system 00:02: [io  0x164e-0x164f] has been reserved
[    0.378418] system 00:03: [io  0x1854-0x1857] has been reserved
[    0.378590] system 00:04: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.378592] system 00:04: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.378594] system 00:04: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.378595] system 00:04: [mem 0xe0000000-0xefffffff] has been reserved
[    0.378597] system 00:04: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.378598] system 00:04: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.378600] system 00:04: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.378602] system 00:04: [mem 0xfee00000-0xfeefffff] could not be reser=
ved
[    0.378834] system 00:05: [io  0x1800-0x18fe] could not be reserved
[    0.378837] system 00:05: [mem 0xfd000000-0xfd69ffff] has been reserved
[    0.378839] system 00:05: [mem 0xfd6c0000-0xfd6cffff] has been reserved
[    0.378841] system 00:05: [mem 0xfd6f0000-0xfdffffff] has been reserved
[    0.378842] system 00:05: [mem 0xfe000000-0xfe01ffff] could not be reser=
ved
[    0.378844] system 00:05: [mem 0xfe200000-0xfe7fffff] has been reserved
[    0.378845] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.379153] system 00:06: [io  0x2000-0x20fe] has been reserved
[    0.381234] pnp: PnP ACPI: found 8 devices
[    0.386722] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.386783] NET: Registered PF_INET protocol family
[    0.386913] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)
[    0.401413] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5,=
 131072 bytes, linear)
[    0.401523] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.401583] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes, linear)
[    0.401797] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,=
 linear)
[    0.402018] TCP: Hash tables configured (established 131072 bind 65536)
[    0.402072] MPTCP token hash table entries: 16384 (order: 6, 393216 byte=
s, linear)
[    0.402137] UDP hash table entries: 8192 (order: 7, 524288 bytes, linear)
[    0.402212] UDP-Lite hash table entries: 8192 (order: 7, 524288 bytes, l=
inear)
[    0.402285] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.402291] NET: Registered PF_XDP protocol family
[    0.402305] pci 0000:00:15.0: BAR 0 [mem 0xa0919000-0xa0919fff 64bit]: a=
ssigned
[    0.402578] pci 0000:00:15.1: BAR 0 [mem 0xa091d000-0xa091dfff 64bit]: a=
ssigned
[    0.402850] pci 0000:00:1e.0: BAR 0 [mem 0xa091e000-0xa091efff 64bit]: a=
ssigned
[    0.403119] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.403125] pci 0000:02:00.0:   bridge window [io  0x5000-0x5fff]
[    0.403129] pci 0000:02:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.403132] pci 0000:02:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.403136] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.403138] pci 0000:01:00.0:   bridge window [io  0x5000-0x5fff]
[    0.403142] pci 0000:01:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.403144] pci 0000:01:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.403149] pci 0000:00:01.0: PCI bridge to [bus 01-03]
[    0.403150] pci 0000:00:01.0:   bridge window [io  0x5000-0x5fff]
[    0.403152] pci 0000:00:01.0:   bridge window [mem 0xa0300000-0xa05fffff]
[    0.403154] pci 0000:00:01.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.403158] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    0.403166] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[    0.403173] pci 0000:00:1c.0:   bridge window [mem 0xa0800000-0xa08fffff]
[    0.403186] pci 0000:00:1c.7: PCI bridge to [bus 05]
[    0.403189] pci 0000:00:1c.7:   bridge window [io  0x3000-0x3fff]
[    0.403196] pci 0000:00:1c.7:   bridge window [mem 0xa0700000-0xa07fffff]
[    0.403209] pci 0000:00:1d.0: PCI bridge to [bus 06]
[    0.403216] pci 0000:00:1d.0:   bridge window [mem 0xa0600000-0xa06fffff]
[    0.403230] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.403231] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.403233] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.403234] pci_bus 0000:00: resource 7 [mem 0x000e0000-0x000effff windo=
w]
[    0.403235] pci_bus 0000:00: resource 8 [mem 0x90000000-0xdfffffff windo=
w]
[    0.403237] pci_bus 0000:00: resource 9 [mem 0xfc800000-0xfe7fffff windo=
w]
[    0.403238] pci_bus 0000:01: resource 0 [io  0x5000-0x5fff]
[    0.403239] pci_bus 0000:01: resource 1 [mem 0xa0300000-0xa05fffff]
[    0.403240] pci_bus 0000:01: resource 2 [mem 0x90000000-0xa01fffff 64bit=
 pref]
[    0.403242] pci_bus 0000:02: resource 0 [io  0x5000-0x5fff]
[    0.403243] pci_bus 0000:02: resource 1 [mem 0xa0300000-0xa04fffff]
[    0.403244] pci_bus 0000:02: resource 2 [mem 0x90000000-0xa01fffff 64bit=
 pref]
[    0.403246] pci_bus 0000:03: resource 0 [io  0x5000-0x5fff]
[    0.403247] pci_bus 0000:03: resource 1 [mem 0xa0300000-0xa04fffff]
[    0.403248] pci_bus 0000:03: resource 2 [mem 0x90000000-0xa01fffff 64bit=
 pref]
[    0.403250] pci_bus 0000:04: resource 0 [io  0x4000-0x4fff]
[    0.403251] pci_bus 0000:04: resource 1 [mem 0xa0800000-0xa08fffff]
[    0.403252] pci_bus 0000:05: resource 0 [io  0x3000-0x3fff]
[    0.403254] pci_bus 0000:05: resource 1 [mem 0xa0700000-0xa07fffff]
[    0.403255] pci_bus 0000:06: resource 1 [mem 0xa0600000-0xa06fffff]
[    0.403864] pci 0000:03:00.1: D0 power state depends on 0000:03:00.0
[    0.403928] PCI: CLS 64 bytes, default 64
[    0.403992] DMAR: No ATSR found
[    0.403992] DMAR: No SATC found
[    0.403994] DMAR: dmar0: Using Queued invalidation
[    0.404021] Trying to unpack rootfs image as initramfs...
[    0.404047] pci 0000:00:00.0: Adding to iommu group 0
[    0.404061] pci 0000:00:01.0: Adding to iommu group 1
[    0.404069] pci 0000:00:08.0: Adding to iommu group 2
[    0.404080] pci 0000:00:12.0: Adding to iommu group 3
[    0.404098] pci 0000:00:14.0: Adding to iommu group 4
[    0.404107] pci 0000:00:14.2: Adding to iommu group 4
[    0.404114] pci 0000:00:14.5: Adding to iommu group 4
[    0.404128] pci 0000:00:15.0: Adding to iommu group 5
[    0.404136] pci 0000:00:15.1: Adding to iommu group 5
[    0.404147] pci 0000:00:16.0: Adding to iommu group 6
[    0.404156] pci 0000:00:17.0: Adding to iommu group 7
[    0.404172] pci 0000:00:1c.0: Adding to iommu group 8
[    0.404191] pci 0000:00:1c.7: Adding to iommu group 9
[    0.404201] pci 0000:00:1d.0: Adding to iommu group 10
[    0.404213] pci 0000:00:1e.0: Adding to iommu group 11
[    0.404235] pci 0000:00:1f.0: Adding to iommu group 12
[    0.404244] pci 0000:00:1f.3: Adding to iommu group 12
[    0.404253] pci 0000:00:1f.4: Adding to iommu group 12
[    0.404262] pci 0000:00:1f.5: Adding to iommu group 12
[    0.404266] pci 0000:01:00.0: Adding to iommu group 1
[    0.404270] pci 0000:02:00.0: Adding to iommu group 1
[    0.404275] pci 0000:03:00.0: Adding to iommu group 1
[    0.404279] pci 0000:03:00.1: Adding to iommu group 1
[    0.404295] pci 0000:04:00.0: Adding to iommu group 13
[    0.404312] pci 0000:05:00.0: Adding to iommu group 14
[    0.404323] pci 0000:06:00.0: Adding to iommu group 15
[    0.405084] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.405086] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.405087] software IO TLB: mapped [mem 0x0000000082b6d000-0x0000000086=
b6d000] (64MB)
[    0.405141] platform rtc_cmos: registered platform RTC device (no PNP de=
vice found)
[    0.419429] Initialise system trusted keyrings
[    0.419436] Key type blacklist registered
[    0.419481] workingset: timestamp_bits=3D36 max_order=3D22 bucket_order=
=3D0
[    0.419566] fuse: init (API version 7.41)
[    0.419635] integrity: Platform Keyring initialized
[    0.419637] integrity: Machine keyring initialized
[    0.430512] Key type asymmetric registered
[    0.430513] Asymmetric key parser 'x509' registered
[    0.430528] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 246)
[    0.430563] io scheduler mq-deadline registered
[    0.430564] io scheduler kyber registered
[    0.430573] io scheduler bfq registered
[    0.430719] ledtrig-cpu: registered to indicate activity on CPUs
[    0.430925] pcieport 0000:00:01.0: PME: Signaling with IRQ 121
[    0.431161] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
[    0.431245] pcieport 0000:00:1c.0: AER: enabled with IRQ 122
[    0.431286] pcieport 0000:00:1c.0: DPC: enabled with IRQ 122
[    0.431288] pcieport 0000:00:1c.0: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.431591] pcieport 0000:00:1c.7: PME: Signaling with IRQ 123
[    0.431645] pcieport 0000:00:1c.7: AER: enabled with IRQ 123
[    0.431684] pcieport 0000:00:1c.7: DPC: enabled with IRQ 123
[    0.431686] pcieport 0000:00:1c.7: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.431979] pcieport 0000:00:1d.0: PME: Signaling with IRQ 124
[    0.432036] pcieport 0000:00:1d.0: AER: enabled with IRQ 124
[    0.432074] pcieport 0000:00:1d.0: DPC: enabled with IRQ 124
[    0.432076] pcieport 0000:00:1d.0: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.432469] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.433004] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input0
[    0.433023] ACPI: button: Sleep Button [SLPB]
[    0.433045] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input1
[    0.433057] ACPI: button: Power Button [PWRB]
[    0.433079] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input2
[    0.433152] ACPI: button: Power Button [PWRF]
[    0.435100] thermal LNXTHERM:00: registered as thermal_zone0
[    0.435102] ACPI: thermal: Thermal Zone [HPTZ] (30 C)
[    0.435396] thermal LNXTHERM:01: registered as thermal_zone1
[    0.435398] ACPI: thermal: Thermal Zone [TZ00] (28 C)
[    0.435636] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.437398] hpet_acpi_add: no address or irqs in _CRS
[    0.437434] Non-volatile memory driver v1.3
[    0.437436] Linux agpgart interface v0.103
[    0.467732] Freeing initrd memory: 21264K
[    0.578936] ACPI: bus type drm_connector registered
[    0.579795] ahci 0000:00:17.0: version 3.0
[    0.590125] ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 =
Gbps, SATA mode
[    0.590129] ahci 0000:00:17.0: 4/4 ports implemented (port mask 0x3c)
[    0.590131] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio slu=
m part ems deso sadm sds apst=20
[    0.613465] scsi host0: ahci
[    0.613775] scsi host1: ahci
[    0.614083] scsi host2: ahci
[    0.614274] scsi host3: ahci
[    0.614417] scsi host4: ahci
[    0.614536] scsi host5: ahci
[    0.614569] ata1: DUMMY
[    0.614570] ata2: DUMMY
[    0.614576] ata3: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a20=
0 irq 126 lpm-pol 1
[    0.614579] ata4: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a28=
0 irq 126 lpm-pol 1
[    0.614582] ata5: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a30=
0 irq 126 lpm-pol 1
[    0.614585] ata6: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a38=
0 irq 126 lpm-pol 1
[    0.614837] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.614842] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[    0.615975] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
10 quirks 0x0000000000009810
[    0.616262] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.616265] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[    0.616267] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperS=
peed
[    0.616304] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.13
[    0.616306] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.616308] usb usb1: Product: xHCI Host Controller
[    0.616309] usb usb1: Manufacturer: Linux 6.13.0-rc6-1.1-mainline-dirty =
xhci-hcd
[    0.616310] usb usb1: SerialNumber: 0000:00:14.0
[    0.616456] hub 1-0:1.0: USB hub found
[    0.616480] hub 1-0:1.0: 16 ports detected
[    0.618207] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.13
[    0.618210] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.618211] usb usb2: Product: xHCI Host Controller
[    0.618213] usb usb2: Manufacturer: Linux 6.13.0-rc6-1.1-mainline-dirty =
xhci-hcd
[    0.618214] usb usb2: SerialNumber: 0000:00:14.0
[    0.618314] hub 2-0:1.0: USB hub found
[    0.618328] hub 2-0:1.0: 8 ports detected
[    0.619094] usb: port power management may be unreliable
[    0.619415] usbcore: registered new interface driver usbserial_generic
[    0.619419] usbserial: USB Serial support registered for generic
[    0.619618] rtc_cmos rtc_cmos: RTC can wake from S4
[    0.621186] rtc_cmos rtc_cmos: registered as rtc0
[    0.621499] rtc_cmos rtc_cmos: setting system clock to 2025-01-11T13:18:=
07 UTC (1736601487)
[    0.621532] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nv=
ram
[    0.621864] intel_pstate: Intel P-state driver initializing
[    0.622499] intel_pstate: Disabling energy efficiency optimization
[    0.622500] intel_pstate: HWP enabled
[    0.622719] simple-framebuffer simple-framebuffer.0: [drm] Registered 1 =
planes with drm panic
[    0.622720] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 o=
n minor 0
[    0.632489] Console: switching to colour frame buffer device 240x67
[    0.644174] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledr=
mdrmfb frame buffer device
[    0.644328] hid: raw HID events driver (C) Jiri Kosina
[    0.644405] drop_monitor: Initializing network drop monitor service
[    0.644486] NET: Registered PF_INET6 protocol family
[    0.649225] Segment Routing with IPv6
[    0.649226] RPL Segment Routing with IPv6
[    0.649237] In-situ OAM (IOAM) with IPv6
[    0.649254] NET: Registered PF_PACKET protocol family
[    0.653199] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.653427] microcode: Current revision: 0x00000100
[    0.653429] microcode: Updated early from: 0x000000fa
[    0.653741] IPI shorthand broadcast: enabled
[    0.654823] sched_clock: Marking stable (640925651, 12784896)->(68446350=
9, -30752962)
[    0.655119] registered taskstats version 1
[    0.655788] Loading compiled-in X.509 certificates
[    0.659661] Loaded X.509 cert 'Build time autogenerated kernel key: f6ed=
cd9617e9783f7928ec27f28d89d95b5650eb'
[    0.660728] Demotion targets for Node 0: null
[    0.660969] Key type .fscrypt registered
[    0.660971] Key type fscrypt-provisioning registered
[    0.662332] integrity: Loading X.509 certificate: UEFI:db
[    0.662346] integrity: Loaded X.509 cert 'HP Inc.: HP UEFI Secure Boot D=
B 2017: d9c01b50cfcae89d3b05345c163aa76e5dd589e7'
[    0.662347] integrity: Loading X.509 certificate: UEFI:db
[    0.662357] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA =
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.662357] integrity: Loading X.509 certificate: UEFI:db
[    0.662365] integrity: Loaded X.509 cert 'Microsoft Windows Production P=
CA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.663921] PM:   Magic number: 9:444:331
[    0.663947] tty tty52: hash matches
[    0.665851] RAS: Correctable Errors collector initialized.
[    0.671827] clk: Disabling unused clocks
[    0.671828] PM: genpd: Disabling unused power domains
[    0.863025] usb 1-3: new high-speed USB device number 2 using xhci_hcd
[    0.919916] ata6: SATA link down (SStatus 4 SControl 300)
[    0.923334] ata4: SATA link down (SStatus 0 SControl 300)
[    0.923399] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.926001] ata5.00: Model 'SAMSUNG MZ7TD256HAFV-000L9', rev 'DXT04L6Q',=
 applying quirks: nolpm
[    0.926011] ata5.00: LPM support broken, forcing max_power
[    0.926078] ata5.00: supports DRM functions and may not be fully accessi=
ble
[    0.926081] ata5.00: ATA-9: SAMSUNG MZ7TD256HAFV-000L9, DXT04L6Q, max UD=
MA/133
[    0.926363] ata5.00: NCQ Send/Recv Log not supported
[    0.926370] ata5.00: 500118192 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    0.928376] ata5.00: Features: Trust Dev-Sleep
[    0.928755] ata5.00: LPM support broken, forcing max_power
[    0.928917] ata5.00: supports DRM functions and may not be fully accessi=
ble
[    0.929230] ata5.00: NCQ Send/Recv Log not supported
[    0.930347] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.930855] ata5.00: configured for UDMA/133
[    0.937791] ata3.00: ATA-8: WDC WD20EARX-00PASB0, 51.0AB51, max UDMA/133
[    0.938533] ata3.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 32),=
 AA
[    0.941120] ahci 0000:00:17.0: port does not support device sleep
[    0.946868] ata3.00: configured for UDMA/133
[    0.957229] scsi 2:0:0:0: Direct-Access     ATA      WDC WD20EARX-00P AB=
51 PQ: 0 ANSI: 5
[    0.957746] sd 2:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 =
TB/1.82 TiB)
[    0.957755] sd 2:0:0:0: [sda] 4096-byte physical blocks
[    0.957771] sd 2:0:0:0: [sda] Write Protect is off
[    0.957776] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.957796] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    0.957831] sd 2:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
[    0.957932] scsi 4:0:0:0: Direct-Access     ATA      SAMSUNG MZ7TD256 4L=
6Q PQ: 0 ANSI: 5
[    0.958396] sd 4:0:0:0: [sdb] 500118192 512-byte logical blocks: (256 GB=
/238 GiB)
[    0.958416] sd 4:0:0:0: [sdb] Write Protect is off
[    0.958420] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    0.958442] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    0.958491] sd 4:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
[    0.989972]  sdb: sdb1 sdb2 sdb3 sdb4
[    0.990876] sd 4:0:0:0: [sdb] supports TCG Opal
[    0.990887] sd 4:0:0:0: [sdb] Attached SCSI disk
[    0.993522] usb 1-3: New USB device found, idVendor=3D058f, idProduct=3D=
6254, bcdDevice=3D 1.00
[    0.993535] usb 1-3: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    0.995285] hub 1-3:1.0: USB hub found
[    0.995410] hub 1-3:1.0: 4 ports detected
[    0.999009]  sda: sda1
[    0.999262] sd 2:0:0:0: [sda] Attached SCSI disk
[    1.001976] Freeing unused decrypted memory: 2028K
[    1.003013] Freeing unused kernel image (initmem) memory: 4292K
[    1.003055] Write protecting the kernel read-only data: 34816k
[    1.004542] Freeing unused kernel image (rodata/data gap) memory: 1956K
[    1.036110] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.036116] rodata_test: all tests were successful
[    1.036125] Run /init as init process
[    1.036127]   with arguments:
[    1.036129]     /init
[    1.036131]   with environment:
[    1.036133]     HOME=3D/
[    1.036134]     TERM=3Dlinux
[    1.112792] usb 1-14: new full-speed USB device number 3 using xhci_hcd
[    1.246927] usb 1-14: New USB device found, idVendor=3D0bda, idProduct=
=3Db00a, bcdDevice=3D 1.10
[    1.246930] usb 1-14: New USB device strings: Mfr=3D1, Product=3D2, Seri=
alNumber=3D3
[    1.246932] usb 1-14: Product: Bluetooth Radio=20
[    1.246933] usb 1-14: Manufacturer: Realtek=20
[    1.246934] usb 1-14: SerialNumber: 00e04c000001
[    1.250560] sdhci: Secure Digital Host Controller Interface driver
[    1.250562] sdhci: Copyright(c) Pierre Ossman
[    1.254271] nvme nvme0: pci function 0000:06:00.0
[    1.258262] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    1.258277] sdhci-pci 0000:00:14.5: enabling device (0100 -> 0102)
[    1.264462] nvme nvme0: 8/0/0 default/read/poll queues
[    1.268650]  nvme0n1: p1 p2
[    1.268816] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    1.326248] usb 1-3.3: new low-speed USB device number 4 using xhci_hcd
[    1.406194] tsc: Refined TSC clocksource calibration: 3000.007 MHz
[    1.406213] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2b3=
e4c0030f, max_idle_ns: 440795221275 ns
[    1.406292] clocksource: Switched to clocksource tsc
[    1.428301] usb 1-3.3: New USB device found, idVendor=3D05d5, idProduct=
=3D0615, bcdDevice=3D 1.01
[    1.428316] usb 1-3.3: New USB device strings: Mfr=3D0, Product=3D1, Ser=
ialNumber=3D0
[    1.428322] usb 1-3.3: Product: KEYBOARD
[    1.435071] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    1.458351] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    1.464358] usbcore: registered new interface driver usbhid
[    1.464367] usbhid: USB HID core driver
[    1.464453] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    1.478231] input: KEYBOARD as /devices/pci0000:00/0000:00:14.0/usb1/1-3=
/1-3.3/1-3.3:1.0/0003:05D5:0615.0001/input/input3
[    1.603466] hid-generic 0003:05D5:0615.0001: input,hidraw0: USB HID v1.1=
0 Keyboard [KEYBOARD] on usb-0000:00:14.0-3.3/input0
[    1.603617] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    1.603801] input: KEYBOARD Consumer Control as /devices/pci0000:00/0000=
:00:14.0/usb1/1-3/1-3.3/1-3.3:1.1/0003:05D5:0615.0002/input/input4
[    1.656799] input: KEYBOARD System Control as /devices/pci0000:00/0000:0=
0:14.0/usb1/1-3/1-3.3/1-3.3:1.1/0003:05D5:0615.0002/input/input5
[    1.657220] hid-generic 0003:05D5:0615.0002: input,hidraw1: USB HID v1.1=
0 Device [KEYBOARD] on usb-0000:00:14.0-3.3/input1
[    1.657378] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    1.805535] EXT4-fs (nvme0n1p1): mounted filesystem 7f701c1e-4cf2-46b9-8=
8a1-184e3dfef17e r/w with ordered data mode. Quota mode: none.
[    2.139047] systemd[1]: systemd 257.2-1-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPEN=
SSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETU=
P +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM=
2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINI=
T +LIBARCHIVE)
[    2.139056] systemd[1]: Detected architecture x86-64.
[    2.141922] systemd[1]: Hostname set to <Ale-Arch>.
[    2.440758] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    2.689655] systemd-fstab-generator[308]: Mount point  is not a valid pa=
th, ignoring.
[    2.689660] systemd-fstab-generator[308]: Mount point  is not a valid pa=
th, ignoring.
[    2.689735] systemd-fstab-generator[308]: Mount point  is not a valid pa=
th, ignoring.
[    2.690696] systemd-fstab-generator[308]: Mount point  is not a valid pa=
th, ignoring.
[    2.695105] systemd-fstab-generator[308]: Mount point  is not a valid pa=
th, ignoring.
[    2.695110] systemd-fstab-generator[308]: Mount point  is not a valid pa=
th, ignoring.
[    2.695112] systemd-fstab-generator[308]: Mount point  is not a valid pa=
th, ignoring.
[    2.695160] systemd-fstab-generator[308]: Mount point  is not a valid pa=
th, ignoring.
[    2.695194] systemd-fstab-generator[308]: Mount point  is not a valid pa=
th, ignoring.
[    2.697289] systemd-fstab-generator[308]: Mount point  is not a valid pa=
th, ignoring.
[    2.697293] systemd-fstab-generator[308]: Mount point  is not a valid pa=
th, ignoring.
[    2.719107] zram: Added device: zram0
[    2.970878] systemd[1]: Configuration file /run/systemd/system/netplan-o=
vs-cleanup.service is marked world-inaccessible. This has no effect as conf=
iguration data is accessible via APIs without restrictions. Proceeding anyw=
ay.
[    3.046918] systemd[1]: Queued start job for default target Graphical In=
terface.
[    3.073838] systemd[1]: Created slice Virtual Machine and Container Slic=
e.
[    3.077082] systemd[1]: Created slice Slice /system/backrest.
[    3.078425] systemd[1]: Created slice CUPS Slice.
[    3.081627] systemd[1]: Created slice Slice /system/dirmngr.
[    3.083296] systemd[1]: Created slice Slice /system/getty.
[    3.084074] systemd[1]: Created slice Slice /system/gpg-agent.
[    3.084828] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    3.085605] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    3.086339] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    3.087053] systemd[1]: Created slice Slice /system/keyboxd.
[    3.087726] systemd[1]: Created slice Slice /system/modprobe.
[    3.088399] systemd[1]: Created slice Slice /system/nut-driver.
[    3.088979] systemd[1]: Created slice Slice /system/systemd-fsck.
[    3.089648] systemd[1]: Created slice Slice /system/systemd-zram-setup.
[    3.090282] systemd[1]: Created slice User and Session Slice.
[    3.090807] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    3.091528] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[    3.092044] systemd[1]: Expecting device /dev/disk/by-uuid/0f1ef58b-496b=
-48fd-a17b-6cbc03a2c8ee...
[    3.092057] systemd[1]: Expecting device /dev/disk/by-uuid/CAB7-E233...
[    3.092067] systemd[1]: Expecting device /dev/zram0...
[    3.092130] systemd[1]: Reached target Login Prompts.
[    3.092745] systemd[1]: Reached target Local Integrity Protected Volumes.
[    3.092790] systemd[1]: Reached target Remote File Systems.
[    3.093416] systemd[1]: Reached target Slice Units.
[    3.094064] systemd[1]: Reached target System Time Set.
[    3.094731] systemd[1]: Reached target Local Verity Protected Volumes.
[    3.095455] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    3.096154] systemd[1]: Listening on LVM2 poll daemon socket.
[    3.099815] systemd[1]: Listening on RPCbind Server Activation Socket.
[    3.100193] systemd[1]: Reached target RPC Port Mapper.
[    3.103885] systemd[1]: Listening on Process Core Dump Socket.
[    3.104377] systemd[1]: Listening on Credential Encryption/Decryption.
[    3.104704] systemd[1]: Listening on Journal Socket (/dev/log).
[    3.105473] systemd[1]: Listening on Journal Sockets.
[    3.106274] systemd[1]: Listening on Network Service Netlink Socket.
[    3.106995] systemd[1]: Listening on Userspace Out-Of-Memory (OOM) Kille=
r Socket.
[    3.107704] systemd[1]: TPM PCR Measurements was skipped because of an u=
nmet condition check (ConditionSecurity=3Dmeasured-uki).
[    3.107721] systemd[1]: Make TPM PCR Policy was skipped because of an un=
met condition check (ConditionSecurity=3Dmeasured-uki).
[    3.107785] systemd[1]: Listening on udev Control Socket.
[    3.108431] systemd[1]: Listening on udev Kernel Socket.
[    3.109278] systemd[1]: Mounting Huge Pages File System...
[    3.110425] systemd[1]: Mounting POSIX Message Queue File System...
[    3.111076] systemd[1]: Mounting NFSD configuration filesystem...
[    3.111947] systemd[1]: Mounting Kernel Debug File System...
[    3.112634] systemd[1]: Mounting Kernel Trace File System...
[    3.113132] systemd[1]: Load AppArmor profiles was skipped because of an=
 unmet condition check (ConditionSecurity=3Dapparmor).
[    3.113172] systemd[1]: Kernel Module supporting RPCSEC_GSS was skipped =
because of an unmet condition check (ConditionPathExists=3D/etc/krb5.keytab=
).
[    3.114158] systemd[1]: Starting Create List of Static Device Nodes...
[    3.115575] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling...
[    3.116475] systemd[1]: Starting Load Kernel Module configfs...
[    3.117282] systemd[1]: Starting Load Kernel Module dm_mod...
[    3.118907] systemd[1]: Starting Load Kernel Module drm...
[    3.119773] systemd[1]: Starting Load Kernel Module fuse...
[    3.120865] systemd[1]: Starting Load Kernel Module loop...
[    3.121153] systemd[1]: File System Check on Root Device was skipped bec=
ause of an unmet condition check (ConditionPathIsReadWrite=3D!/).
[    3.121188] systemd[1]: Clear Stale Hibernate Storage Info was skipped b=
ecause of an unmet condition check (ConditionPathExists=3D/sys/firmware/efi=
/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[    3.122566] systemd[1]: Starting Journal Service...
[    3.125214] systemd[1]: Starting Load Kernel Modules...
[    3.126249] systemd[1]: Starting Userspace Out-Of-Memory (OOM) Killer...
[    3.127417] systemd[1]: TPM PCR Machine ID Measurement was skipped becau=
se of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    3.128485] systemd[1]: Starting Remount Root and Kernel File Systems...
[    3.128540] systemd[1]: Early TPM SRK Setup was skipped because of an un=
met condition check (ConditionSecurity=3Dmeasured-uki).
[    3.129896] systemd[1]: Starting Load udev Rules from Credentials...
[    3.130229] loop: module loaded
[    3.130277] device-mapper: uevent: version 1.0.3
[    3.130495] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised:=
 dm-devel@lists.linux.dev
[    3.130605] systemd[1]: Starting Coldplug All udev Devices...
[    3.131217] systemd[1]: Starting Virtual Console Setup...
[    3.133939] systemd[1]: Mounted Huge Pages File System.
[    3.134023] systemd[1]: Mounted POSIX Message Queue File System.
[    3.134892] systemd[1]: Mounted Kernel Debug File System.
[    3.135808] systemd[1]: Mounted Kernel Trace File System.
[    3.136822] systemd[1]: Finished Create List of Static Device Nodes.
[    3.137564] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[    3.137671] systemd[1]: Finished Load Kernel Module configfs.
[    3.138394] systemd[1]: modprobe@dm_mod.service: Deactivated successfull=
y.
[    3.138490] systemd[1]: Finished Load Kernel Module dm_mod.
[    3.139484] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    3.139599] systemd[1]: Finished Load Kernel Module drm.
[    3.139748] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    3.139858] systemd[1]: Finished Load Kernel Module fuse.
[    3.140022] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    3.140120] systemd[1]: Finished Load Kernel Module loop.
[    3.143875] systemd[1]: Mounting FUSE Control File System...
[    3.144366] systemd[1]: Mounting Kernel Configuration File System...
[    3.144777] systemd[1]: Repartition Root Disk was skipped because no tri=
gger condition checks were met.
[    3.145547] systemd[1]: Starting Create Static Device Nodes in /dev grac=
efully...
[    3.146216] systemd[1]: Finished Load udev Rules from Credentials.
[    3.148168] systemd[1]: Mounted FUSE Control File System.
[    3.148853] systemd[1]: Mounted Kernel Configuration File System.
[    3.160174] RPC: Registered named UNIX socket transport module.
[    3.160177] RPC: Registered udp transport module.
[    3.160177] RPC: Registered tcp transport module.
[    3.160178] RPC: Registered tcp-with-tls transport module.
[    3.160178] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    3.163150] systemd-journald[346]: Collecting audit messages is disabled.
[    3.163255] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    3.163283] sd 4:0:0:0: Attached scsi generic sg1 type 0
[    3.163972] systemd[1]: Finished Virtual Console Setup.
[    3.170150] i2c_dev: i2c /dev entries driver
[    3.172980] systemd[1]: Finished Load Kernel Modules.
[    3.173913] systemd[1]: Starting Apply Kernel Variables...
[    3.176196] EXT4-fs (nvme0n1p1): re-mounted 7f701c1e-4cf2-46b9-88a1-184e=
3dfef17e r/w. Quota mode: none.
[    3.176818] systemd[1]: Finished Remount Root and Kernel File Systems.
[    3.178738] systemd[1]: Rebuild Hardware Database was skipped because of=
 an unmet condition check (ConditionNeedsUpdate=3D/etc).
[    3.223450] systemd[1]: Starting Load/Save OS Random Seed...
[    3.223499] systemd[1]: TPM SRK Setup was skipped because of an unmet co=
ndition check (ConditionSecurity=3Dmeasured-uki).
[    3.223699] systemd[1]: Started Userspace Out-Of-Memory (OOM) Killer.
[    3.224408] systemd[1]: Started Journal Service.
[    3.239945] systemd-journald[346]: Received client request to flush runt=
ime journal.
[    3.473280] zram0: detected capacity change from 0 to 32491520
[    3.475146] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    3.477960] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    3.492172] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    3.508621] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: 8F1F6436-9F42-4=
2C8-BADC-0E9424F20C9A has zero instances
[    3.508626] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: 8F1F6435-9F42-4=
2C8-BADC-0E9424F20C9A has zero instances
[    3.508627] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: 7391A661-223A-4=
7DB-A77A-7BE84C60822D has zero instances
[    3.508628] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: DF4E63B6-3BBC-4=
858-9737-C74F82F821F3 has zero instances
[    3.509750] mmc0: SDHCI controller on PCI [0000:00:14.5] using ADMA 64-b=
it
[    3.511501] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[    3.514535] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    3.514647] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db1=
8c600'
[    3.519140] platform regulatory.0: Direct firmware load for regulatory.d=
b failed with error -2
[    3.519144] cfg80211: failed to load regulatory.db
[    3.522288] raid6: skipped pq benchmark and selected avx2x4
[    3.522291] raid6: using avx2x2 recovery algorithm
[    3.525025] xor: automatically using best checksumming function   avx   =
   =20
[    3.530513] EDAC ie31200: No ECC support
[    3.530557] EDAC ie31200: No ECC support
[    3.531299] intel_pch_thermal 0000:00:12.0: enabling device (0100 -> 010=
2)
[    3.535656] intel-lpss 0000:00:15.0: enabling device (0100 -> 0102)
[    3.535991] intel_pmc_core INT33A1:00:  initialized
[    3.539052] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    3.564161] intel-lpss 0000:00:15.1: enabling device (0100 -> 0102)
[    3.564381] idma64 idma64.1: Found Intel integrated DMA 64-bit
[    3.572266] Adding 16245756k swap on /dev/zram0.  Priority:100 extents:1=
 across:16245756k SSDsc
[    3.574895] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    3.575121] intel-lpss 0000:00:1e.0: enabling device (0100 -> 0102)
[    3.576256] idma64 idma64.2: Found Intel integrated DMA 64-bit
[    3.579393] input: PC Speaker as /devices/platform/pcspkr/input/input6
[    3.666564] Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
[    3.733273] Bluetooth: Core ver 2.22
[    3.733287] NET: Registered PF_BLUETOOTH protocol family
[    3.733288] Bluetooth: HCI device and connection manager initialized
[    3.733291] Bluetooth: HCI socket layer initialized
[    3.733292] Bluetooth: L2CAP socket layer initialized
[    3.733294] Bluetooth: SCO socket layer initialized
[    3.734165] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    3.734198] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    3.738242] Creating 1 MTD partitions on "0000:00:1f.5":
[    3.738244] 0x000000000000-0x000001000000 : "BIOS"
[    3.738306] i2c i2c-2: Successfully instantiated SPD at 0x50
[    3.738436] dw-apb-uart.2: ttyS4 at MMIO 0xa091e000 (irq =3D 20, base_ba=
ud =3D 7500000) is a 16550A
[    3.743236] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360=
 ms ovfl timer
[    3.743239] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    3.743240] RAPL PMU: hw unit of domain package 2^-14 Joules
[    3.743240] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    3.746313] r8169 0000:04:00.0: can't disable ASPM; OS doesn't have ASPM=
 control
[    3.750103] cryptd: max_cpu_qlen set to 1000
[    3.750680] iTCO_vendor_support: vendor-support=3D0
[    3.751902] input: HP WMI hotkeys as /devices/virtual/input/input7
[    3.757615] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=3D6=
, TCOBASE=3D0x0400)
[    3.758495] iTCO_wdt iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=
=3D0)
[    3.762658] AES CTR mode by8 optimization enabled
[    3.764548] rtw_8821ce 0000:05:00.0: enabling device (0100 -> 0103)
[    3.764587] ee1004 2-0050: 512 byte EE1004-compliant SPD EEPROM, read-on=
ly
[    3.766382] rtw_8821ce 0000:05:00.0: Firmware version 24.11.0, H2C versi=
on 12
[    3.766920] usbcore: registered new interface driver btusb
[    3.767076] Bluetooth: hci0: RTL: examining hci_ver=3D08 hci_rev=3D000c =
lmp_ver=3D08 lmp_subver=3D8821
[    3.767410] r8169 0000:04:00.0 eth0: RTL8168h/8111h, 9c:7b:ef:30:a7:6b, =
XID 541, IRQ 146
[    3.767413] r8169 0000:04:00.0 eth0: jumbo features [frames: 9194 bytes,=
 tx checksumming: ko]
[    3.768072] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
[    3.768075] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_fw.bin
[    3.768816] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_config.bin
[    3.769206] Bluetooth: hci0: RTL: cfg_sz 10, total sz 34926
[    3.777661] r8169 0000:04:00.0 enp4s0: renamed from eth0
[    3.781418] snd_hda_intel 0000:00:1f.3: enabling device (0100 -> 0102)
[    3.781719] snd_hda_intel 0000:03:00.1: enabling device (0100 -> 0102)
[    3.781801] snd_hda_intel 0000:03:00.1: Force to non-snoop mode
[    3.791707] input: HDA ATI HDMI HDMI/DP,pcm=3D3 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input8
[    3.791736] input: HDA ATI HDMI HDMI/DP,pcm=3D7 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input9
[    3.791761] input: HDA ATI HDMI HDMI/DP,pcm=3D8 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input10
[    3.791835] input: HDA ATI HDMI HDMI/DP,pcm=3D9 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input11
[    3.791871] input: HDA ATI HDMI HDMI/DP,pcm=3D10 as /devices/pci0000:00/=
0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input12
[    3.811336] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC671: li=
ne_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:line
[    3.811341] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[    3.811342] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0x21/0x0/=
0x0/0x0/0x0)
[    3.811343] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0
[    3.811344] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    3.811345] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=3D0x18
[    3.811346] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=3D0x19
[    3.811347] snd_hda_codec_realtek hdaudioC0D0:      Line=3D0x1b
[    3.822558] rtw_8821ce 0000:05:00.0 wlp5s0: renamed from wlan0
[    3.846419] input: HDA Intel PCH Rear Mic as /devices/pci0000:00/0000:00=
:1f.3/sound/card0/input13
[    3.846488] input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:0=
0:1f.3/sound/card0/input14
[    3.846538] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1f.=
3/sound/card0/input15
[    3.846568] input: HDA Intel PCH Line Out as /devices/pci0000:00/0000:00=
:1f.3/sound/card0/input16
[    3.846601] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input17
[    3.885798] intel_tcc_cooling: Programmable TCC Offset detected
[    4.239152] Bluetooth: hci0: RTL: fw version 0x75b8f098
[    4.462094] BTRFS: device label DATA devid 1 transid 20412 /dev/sda1 (8:=
1) scanned by mount (598)
[    4.463419] BTRFS info (device sda1): first mount of filesystem 0f1ef58b=
-496b-48fd-a17b-6cbc03a2c8ee
[    4.463426] BTRFS info (device sda1): using crc32c (crc32c-intel) checks=
um algorithm
[    4.463429] BTRFS info (device sda1): using free-space-tree
[    6.247192] [drm] amdgpu kernel modesetting enabled.
[    6.247333] amdgpu: Virtual CRAT table created for CPU
[    6.247382] amdgpu: Topology: Add CPU node
[    6.247429] amdgpu: Overdrive is enabled, please disable it before repor=
ting any bugs unrelated to overdrive.
[    6.248270] amdgpu 0000:03:00.0: enabling device (0106 -> 0107)
[    6.248345] [drm] initializing kernel modesetting (DIMGREY_CAVEFISH 0x10=
02:0x73FF 0x1043:0x05D5 0xC7).
[    6.248355] [drm] register mmio base: 0xA0300000
[    6.248356] [drm] register mmio size: 1048576
[    6.253620] [drm] add ip block number 0 <nv_common>
[    6.253623] [drm] add ip block number 1 <gmc_v10_0>
[    6.253624] [drm] add ip block number 2 <navi10_ih>
[    6.253625] [drm] add ip block number 3 <psp>
[    6.253626] [drm] add ip block number 4 <smu>
[    6.253627] [drm] add ip block number 5 <dm>
[    6.253628] [drm] add ip block number 6 <gfx_v10_0>
[    6.253629] [drm] add ip block number 7 <sdma_v5_2>
[    6.253631] [drm] add ip block number 8 <vcn_v3_0>
[    6.253632] [drm] add ip block number 9 <jpeg_v3_0>
[    6.253651] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from VFCT
[    6.253654] amdgpu: ATOM BIOS: 115-D534P00-100
[    6.267843] intel_rapl_common: Found RAPL domain package
[    6.267845] intel_rapl_common: Found RAPL domain core
[    6.267846] intel_rapl_common: Found RAPL domain dram
[    6.303106] Console: switching to colour dummy device 80x25
[    6.327423] amdgpu 0000:03:00.0: vgaarb: deactivate vga console
[    6.327428] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (TMZ) featu=
re disabled as experimental (default)
[    6.327461] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, f=
ragment size is 9-bit
[    6.327468] amdgpu 0000:03:00.0: amdgpu: VRAM: 8176M 0x0000008000000000 =
- 0x00000081FEFFFFFF (8176M used)
[    6.327471] amdgpu 0000:03:00.0: amdgpu: GART: 512M 0x0000000000000000 -=
 0x000000001FFFFFFF
[    6.327482] [drm] Detected VRAM RAM=3D8176M, BAR=3D256M
[    6.327484] [drm] RAM width 128bits GDDR6
[    6.327664] [drm] amdgpu: 8176M of VRAM memory ready
[    6.327667] [drm] amdgpu: 7932M of GTT memory ready.
[    6.327685] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    6.327772] [drm] PCIE GART of 512M enabled (table at 0x0000008002000000=
).
[    7.869019] amdgpu 0000:03:00.0: amdgpu: STB initialized to 2048 entries
[    7.869192] [drm] Loading DMUB firmware via PSP: version=3D0x02020020
[    7.869524] [drm] use_doorbell being set to: [true]
[    7.869535] [drm] use_doorbell being set to: [true]
[    7.869545] [drm] Found VCN firmware Version ENC: 1.33 DEC: 4 VEP: 0 Rev=
ision: 3
[    7.936242] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000=
000 for PSP TMR
[    8.038954] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is n=
ot available
[    8.055969] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta=
 ucode is not available
[    8.055994] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x000=
0000f, smu fw if version =3D 0x00000013, smu fw program =3D 0, version =3D =
0x003b3100 (59.49.0)
[    8.056002] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not match=
ed
[    8.056036] amdgpu 0000:03:00.0: amdgpu: use vbios provided pptable
[    8.102458] amdgpu 0000:03:00.0: amdgpu: SMU is initialized successfully!
[    8.102910] [drm] Display Core v3.2.310 initialized on DCN 3.0.2
[    8.102912] [drm] DP-HDMI FRL PCON supported
[    8.104156] [drm] DMUB hardware initialized: version=3D0x02020020
[    8.107382] snd_hda_intel 0000:03:00.1: bound 0000:03:00.0 (ops amdgpu_d=
m_audio_component_bind_ops [amdgpu])
[    8.544411] [drm] kiq ring mec 2 pipe 1 q 0
[    8.607534] amdgpu: HMM registered 8176MB device memory
[    8.609243] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    8.609256] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    8.609514] amdgpu: Virtual CRAT table created for GPU
[    8.609720] amdgpu: Topology: Add dGPU node [0x73ff:0x1002]
[    8.609722] kfd kfd: amdgpu: added device 1002:73ff
[    8.609740] amdgpu 0000:03:00.0: amdgpu: SE 2, SH per SE 2, CU per SH 8,=
 active_cu_number 28
[    8.609743] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng =
0 on hub 0
[    8.609745] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng =
1 on hub 0
[    8.609746] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 4 on hub 0
[    8.609747] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 5 on hub 0
[    8.609748] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 6 on hub 0
[    8.609749] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 7 on hub 0
[    8.609750] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 8 on hub 0
[    8.609751] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 9 on hub 0
[    8.609752] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 10 on hub 0
[    8.609753] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 11 on hub 0
[    8.609754] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv en=
g 12 on hub 0
[    8.609755] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 o=
n hub 0
[    8.609756] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 o=
n hub 0
[    8.609757] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng =
0 on hub 8
[    8.609758] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv en=
g 1 on hub 8
[    8.609759] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv en=
g 4 on hub 8
[    8.609760] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5=
 on hub 8
[    8.611421] amdgpu 0000:03:00.0: amdgpu: Using BACO for runtime pm
[    8.612084] [drm] Initialized amdgpu 3.59.0 for 0000:03:00.0 on minor 1
[    8.618070] fbcon: amdgpudrmfb (fb0) is primary device
[    8.618396] [drm] pre_validate_dsc:1593 MST_DSC dsc precompute is not ne=
eded
[    8.924934] Console: switching to colour frame buffer device 240x67
[    8.960304] amdgpu 0000:03:00.0: [drm] fb0: amdgpudrmfb frame buffer dev=
ice
[    9.152022] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    9.152025] Bluetooth: BNEP filters: protocol multicast
[    9.152027] Bluetooth: BNEP socket layer initialized
[    9.154552] Bluetooth: MGMT ver 1.23
[    9.159884] NET: Registered PF_ALG protocol family
[    9.337976] nvme nvme0: using unchecked data buffer
[    9.397086] block nvme0n1: No UUID available providing old NGUID
[    9.446200] Generic FE-GE Realtek PHY r8169-0-400:00: attached PHY drive=
r (mii_bus:phy_addr=3Dr8169-0-400:00, irq=3DMAC)
[    9.629905] r8169 0000:04:00.0 enp4s0: Link is Down
[   10.185050] bridge: filtering via arp/ip/ip6tables is no longer availabl=
e by default. Update your scripts to load br_netfilter if you need this.
[   10.329818] u32 classifier
[   10.329820]     Performance counters on
[   10.329821]     input device check on
[   10.329821]     Actions configured
[   12.256562] kvm: Running KVM with ignore_msrs=3D1 and report_ignored_msr=
s=3D0 is not a
               a supported configuration.  Lying to the guest about the exi=
stence of MSRs
               may cause the guest operating system to hang or produce erro=
rs.  If a guest
               does not run without ignore_msrs=3D1, please report it to kv=
m@vger.kernel.org.
[   13.132657] r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[   13.134416] r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[   15.521587] RPC: Registered rdma transport module.
[   15.521590] RPC: Registered rdma backchannel transport module.
[   15.630094] NFSD: Using nfsdcld client tracking operations.
[   15.630098] NFSD: no clients to reclaim, skipping NFSv4 grace period (ne=
t f0000000)
[   16.087484] Initializing XFRM netlink socket
[   16.173000] warning: `pmdalinux' uses wireless extensions which will sto=
p working for Wi-Fi 7 hardware; use nl80211
[   24.033233] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   24.035361] ata4.00: Model 'HL-DT-ST BD-RE BU40N', rev '1.03', applying =
quirks: nolpm
[   24.035365] ata4.00: LPM support broken, forcing max_power
[   24.037909] ata4.00: ATAPI: HL-DT-ST BD-RE BU40N, 1.03, max UDMA/133
[   24.043119] ata4.00: LPM support broken, forcing max_power
[   24.043131] ata4.00: configured for UDMA/133
[   24.062748] scsi 3:0:0:0: CD-ROM            HL-DT-ST BD-RE BU40N      1.=
03 PQ: 0 ANSI: 5
[   24.132010] scsi 3:0:0:0: Attached scsi generic sg2 type 5
[   24.218600] sr 3:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd=
/rw xa/form2 cdda tray
[   24.218602] cdrom: Uniform CD-ROM driver Revision: 3.20
[   24.289158] sr 3:0:0:0: Attached scsi CD-ROM sr0

--a3gqruvbfv63yvcv--

--oa3nb6u4iqk2fxoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmeCnyYACgkQwEfU8yi1
JYXwBg//R+fmtE5d+gSiI3NOpl1AnQBtbBTziijBYHGe9Rnhbd+gLWU22JhzJD4I
wC4yMPKE8zE3sbE6D0LEKFmSGuu8sGfqGX2ZKQA83Dk8CSlBCXaslMYA+xyxM59i
943btQUZRxTbhxg05mmkBbdPQubKJA55ve2iIc90jhV3eUYsecS7ZJ1ar/ykbb9R
ODRyH3mfkjZN9RKEYHdTEJFXKUoWd0rj1jqSPkcUM8QSBGQngAaiN4KX04Lc5841
bdeH1m5EOTZFmNgvMotJ+0cfnoO2AsNdnwiatfkkiBy2QkcJpaRaJfuDgXlc1HOw
lhWKBgSNcUV9SxO5tK/GAR+ofyOCmCcuD74mscRiQ4ib6Pfxh9Lk02o/zDkvaT+D
RsokrYmHOLqH/nzyfqfYuMV5OYHBC6zrqeIUcfQM2U5NhrCrF3BZ9kHLSOpSrm71
8CRv76cwaopojoeqLg5aA8yhbup3HD1FqNoBrvq1wwxe9nsKA8CWBBfcZhOp1WwD
UwUKZSrs1UJlnllVfokZsdSoMMOBPxs84asi8xLeHIopSKwoOKQj/pO4GDVlIpYx
APFrw3v/dMLMu6Bb7KtQ0st7U5R3xs2Z7hGvA9jwmq3OOlFdWGwR9zY43oY0nldF
GLK67tB/2qEuglHHJQcv6TUSTyrX2GmGgjgBdLwiINKU8yRvWC4=
=Te/R
-----END PGP SIGNATURE-----

--oa3nb6u4iqk2fxoy--
