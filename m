Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37C3209F49;
	Fri, 10 Jan 2025 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502197; cv=none; b=t05Me1NqL0diU09jEcn2N+ql+FPYe2oBSkYyuhsHDConAy221dUsG/xbFzPDW33w1xTQcxWMYqigDcBdrkZq6Nk7iuUZlXDODRGxBCreoqb/Y7abUF9n5GlioPQfYiffUCcAr7L3AudrwVzYpfNW8ZkUtoNE3pApPTVHEP/6RrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502197; c=relaxed/simple;
	bh=7Mc0+oS2L375fGSP7I3Mw9+8FzegBXQHSezu5VJ5RGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UotDkz0binhojgj2X9pzsBzyZ1v3Ry5jZ1F8xz800IlraquzSWa+6OPlrBgnQoj5O0/LtXk7/+azJIWvJfFWEltFvoWbtSicTGwc9AcVndUxvdv3peNTdmKWGIPcmZ51wbQJTndLf5GZZgjHl0BDUnV9vnmHGB8ckaMRnFUjfYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=FsEao9HT; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="FsEao9HT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1736502145; x=1737106945; i=christian@heusel.eu;
	bh=wYnWYvxVIRBij6K6OgdcOmNtwFgaYoBniouG6+2t0II=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FsEao9HT5VNw1QCP7CEeg1hqF9UnCF7mcp0U5s9X8M2hI1ze7FFDdd/SjlTmldA9
	 bsBbCAzNeWnA2b0kOJp+Sg9JVacwcXJXSi8co+04RE7Mn3hIJuRNo/rTHMe/q1yd1
	 qRLbgqG4m21o9J3I5qlqIHlgRWIFsaXgW4HVFCll2YX3V73tdvVaUTG518iDSbssO
	 nFFNSYSBVhmcu41DECpHu6yIHbHOBLZ1O45iKHvCXsgCRffSAcI8gnFQeUARXXvYe
	 Q2nMkN0yiidqlOTlN0c43OIr2e6PhdoNWuOR1sGu1UASziZb5g/1vk6NWTGa+T1HE
	 uh1qkPxd3tkIxsxiFA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([80.187.64.46]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MMnru-1tooqR3RnI-00RC6i; Fri, 10 Jan 2025 10:42:25 +0100
Date: Fri, 10 Jan 2025 10:42:19 +0100
From: Christian Heusel <christian@heusel.eu>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
	Niklas Cassel <cassel@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION][BISECTED] BU40N Blu-Ray drive broken since
 7627a0edef54
Message-ID: <928aa39d-9c8d-474a-b077-d08e984ad5e9@heusel.eu>
References: <e2be6f70-dff6-4b79-bd49-70ec7e27fc1c@heusel.eu>
 <d1b79f57-9e77-4b2a-9dfb-f86cdcffcb0d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cgyalpdfkmtkcufc"
Content-Disposition: inline
In-Reply-To: <d1b79f57-9e77-4b2a-9dfb-f86cdcffcb0d@kernel.org>
X-Provags-ID: V03:K1:gclMm6QJVMTRvfamATxK76Xjnf/fxkpBB0fcMf7P0NxXvnQ8dcm
 esgfv++LmTFR3GQeGDYXv3rIJFT/QIcmpmlhmpLRe/9e3GajUNvgfuIjdkdRX+a1iUvfWi7
 K7O0EP9PiJ5hhMuL0uRO6An2+kVWE1fTNNMT6+UTGwEZRVPz6uwrVbqA86nzEHh8tizwyNv
 mijsRdUEQNPBxg2CoDaUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9ZySNnqtwvs=;vr3vTRK+lpG+djwIIj7RyGzthrt
 dI/5Z28rBMlhkGFXZn178w1plopuFpUV9wyuqvX2S8rCa4CDYMITHSu4trQIpw8ZL7n3f7C5c
 G3C2b0RCNBLgsKupJQLNov8r+LIxuVdu/UxFZjU+ejLUqhbT9lbg2A4WLqWuwJutA575jr4N8
 FSNjByhR1nvLVw4One7h4z9poJ1BlGvONBx+9F3IbzCZ0PSf+4IxEIa2A4J+uxAsOgbpygLxS
 0tQBQ6F5kcRs3EvhucPLJtScUTBFsNIjgGTK/Ou+5W/behfuu+7EYhUNL4K8Rh4M9gidIEdgg
 jbs4g/NzTxLxorCdF6nw3xfLDVYpQwRj1WUciHx7lDJBC0JzG2ttnyUsIfwpPtXuHWyaX5ZC0
 LbuYE9CBRis8dvtqdSs/vOlfsQKUgWd7wHHqaLPQwXR9ZyJnL9QWEXaTURfGqW4WaZSWUcaC1
 2R/f3T8iTVrEDb6LEqfZcB4fYUexBBTrLajpvcekrn/ICFldcM9g9maAFP2ZqKoaMCk1DPOF4
 odLxhlkjGBRor8DaaCYAT9UKuuUIlKjlDwbyi4jkVlnv6t6qBBQSTSMi+vVr0oyaJSqwwgxGP
 XJxkJt8iXKq76XPVkf2qz5Uk6tRE0bnAYiwRXnBRvAJc55npfQ/CLKoeB3/nCC4hAYunkTsBC
 3rmGGZAdkGtVnP1FnbsLrdnA8LVY+H0v10VVgrHM4VXmxEVUQObdKq4NzFw3oraACYUOND1d0
 ZI9v5rigdIJZ0n8Z3DVrXG7ejl0Ijfo3pEeDMHiolpX7jL1UbfbW0ExVF8+ZCcjVCLUygp4w6
 uBxHAMmqKY/KUAAz1b50LRyn8uCwepFT81qH8OCDkDYFEMSeAaAPWgg+HAQRju9QJ18CjzU9V
 4rvVUJYcLGX3g0bGu1mhO3ImsSqBpmxjEHP68/hF/Ul7uKQhERtS1cR05T2Gj4hlOfDWyGpzk
 3lzxJBamhBPQhrWc3wKE/keoHjwCPrUvEj9P11+tR0bpd0LEe4xG9EYbfBxhKQTsgvFfs0vCs
 NOwY4qQPNCY9JMlLsnhDZYcJ623f1+j0c4Yg44T


--cgyalpdfkmtkcufc
Content-Type: multipart/mixed; protected-headers=v1;
	boundary="gttcyfelaltvdnuh"
Content-Disposition: inline
Subject: Re: [REGRESSION][BISECTED] BU40N Blu-Ray drive broken since
 7627a0edef54
MIME-Version: 1.0


--gttcyfelaltvdnuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25/01/10 06:24PM, Damien Le Moal wrote:
> On 2025/01/10 18:04, Christian Heusel wrote:
> > Hello everyone,
> >=20
> > we have recently received a report by a user in the Arch Linux Forums
> > user that their Blue Ray player, a HL-DT-ST BD-RE BU40N stopped working
> > somewhere since kernel version v6.8.0. We have then bisected the issue
> > together with them within the mainline kernel sources to the following
> > commit that changes the default power policy:
> >=20
> >     7627a0edef54 ("ata: ahci: Drop low power policy board type")
> >=20
> > The user reports that adding "ahci.mobile_lpm_policy=3D1" as a kernel
> > parameter fixes the issue for them.
> >=20
> > Additionally fellow forum user @loqs came up with a quirk patch, that
> > sadly was reported to not work:
> >=20
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index c085dd8..ef01ccd 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -4118,6 +4118,9 @@ static const struct ata_dev_quirks_entry __ata_de=
v_quirks[] =3D {
> >  	{ "SAMSUNG MZ7TD256HAFV-000L9", NULL,       ATA_QUIRK_NOLPM },
> >  	{ "SAMSUNG MZ7TE512HMHP-000L1", "EXT06L0Q", ATA_QUIRK_NOLPM },
> > =20
> > +	/* Hitachi-LG Data Storage models with LPM issues */
> > +	{ "HL-DT-ST BD-RE BU40N", NULL, ATA_QUIRK_NOLPM },
>=20
> Looks like "BU40N" may be the FW rev ? If we can get a dmesg ourput of the
> failing case, we should be able to sort out this. Likely it is a bad stri=
ng
> reference here.

I have attached the dmesg outputs, here is the relevant output:

[   81.230713] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   81.235708] ata4.00: ATAPI: HL-DT-ST BD-RE BU40N, 1.03, max UDMA/133
[   81.240789] ata4.00: configured for UDMA/133
[   81.248585] scsi 3:0:0:0: CD-ROM            HL-DT-ST BD-RE BU40N      1.=
03 PQ: 0 ANSI: 5
[   81.302830] scsi 3:0:0:0: Attached scsi generic sg2 type 5
[   81.382131] sr 3:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd=
/rw xa/form2 cdda tray

Aswell as the output for "hdparm -i /dev/sr0":

/dev/sr0:

 Model=3DHL-DT-ST BD-RE BU40N, FwRev=3D1.03, SerialNo=3D
 Config=3D{ Fixed Removable DTR<=3D5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=3D0/0/0, TrkSize=3D0, SectSize=3D0, ECCbytes=3D0
 BuffType=3Dunknown, BuffSize=3Dunknown, MaxMultSect=3D0
 CurCHS=3D0/0/0, CurSects=3D0, LBA=3Dyes, LBAsects=3D0
 IORDY=3Don/off, tPIO=3D{min:120,w/IORDY:120}, tDMA=3D{min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4=20
 DMA modes:  mdma0 mdma1 mdma2=20
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 udma6=20
 AdvancedPM=3Dno
 Drive conforms to: unknown:  ATA/ATAPI-3,4,5,6,7

 * signifies the current active mode

Cheers,
Chris

--gttcyfelaltvdnuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-broken.log"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Linux version 6.12.8-arch1-1 (linux@archlinux) (gcc (GCC) 14=
=2E2.1 20240910, GNU ld (GNU Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Thu, =
02 Jan 2025 22:52:26 +0000
[    0.000000] Command line: initrd=3D\intel-ucode.img initrd=3D\initramfs-=
linux.img root=3D/dev/nvme0n1p1 rw intel_iommu=3Don
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
[    0.000000] e820: update [mem 0x7bf47018-0x7bf65457] usable =3D=3D> usab=
le
[    0.000000] e820: update [mem 0x7bf38018-0x7bf46057] usable =3D=3D> usab=
le
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ef=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000000009f000-0x00000000000fff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000007bf380=
17] usable
[    0.000000] reserve setup_data: [mem 0x000000007bf38018-0x000000007bf460=
57] usable
[    0.000000] reserve setup_data: [mem 0x000000007bf46058-0x000000007bf470=
17] usable
[    0.000000] reserve setup_data: [mem 0x000000007bf47018-0x000000007bf654=
57] usable
[    0.000000] reserve setup_data: [mem 0x000000007bf65458-0x000000008a26ff=
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
[    0.000849] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000851] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000860] last_pfn =3D 0x46e000 max_arch_pfn =3D 0x400000000
[    0.000864] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built fr=
om 10 variable MTRRs
[    0.000866] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.001136] last_pfn =3D 0x8dc0f max_arch_pfn =3D 0x400000000
[    0.008608] esrt: Reserving ESRT space from 0x0000000088b80398 to 0x0000=
000088b80420.
[    0.008613] e820: update [mem 0x88b80000-0x88b80fff] usable =3D=3D> rese=
rved
[    0.008629] Using GB pages for direct mapping
[    0.009251] Secure boot disabled
[    0.009251] RAMDISK: [mem 0x7bf66000-0x7d41ffff]
[    0.009271] ACPI: Early table checksum verification disabled
[    0.009273] ACPI: RSDP 0x000000008A6BE000 000024 (v02 HPQOEM)
[    0.009277] ACPI: XSDT 0x000000008A6BE0C0 0000FC (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009281] ACPI: FACP 0x000000008A704DC8 000114 (v06 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009287] ACPI: DSDT 0x000000008A6BE248 046B7A (v02 HPQOEM SLIC-CPC 01=
072009 INTL 20160527)
[    0.009289] ACPI: FACS 0x000000008AB93080 000040
[    0.009292] ACPI: APIC 0x000000008A704EE0 0000BC (v04 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009294] ACPI: FPDT 0x000000008A704FA0 000044 (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009297] ACPI: FIDT 0x000000008A704FE8 00009C (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009300] ACPI: MCFG 0x000000008A705088 00003C (v01 HPQOEM SLIC-CPC 01=
072009 MSFT 00000097)
[    0.009302] ACPI: SSDT 0x000000008A7050C8 001B5F (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.009305] ACPI: MSDM 0x000000008A706C28 000055 (v03 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009308] ACPI: SSDT 0x000000008A706C80 000060 (v01 HPQOEM SLIC-CPC 00=
000001 INTL 20160527)
[    0.009310] ACPI: SSDT 0x000000008A706CE0 000060 (v01 HPQOEM SLIC-CPC 00=
000001 INTL 20160527)
[    0.009313] ACPI: SSDT 0x000000008A706D40 0031C6 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.009315] ACPI: SSDT 0x000000008A709F08 00241B (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009318] ACPI: HPET 0x000000008A70C328 000038 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009320] ACPI: SSDT 0x000000008A70C360 001D39 (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009323] ACPI: SSDT 0x000000008A70E0A0 000FAE (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009326] ACPI: SSDT 0x000000008A70F050 000BDF (v02 HPQOEM SLIC-CPC 00=
000000 INTL 20160527)
[    0.009328] ACPI: UEFI 0x000000008A70FC30 000042 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009331] ACPI: LPIT 0x000000008A70FC78 000094 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009333] ACPI: SSDT 0x000000008A70FD10 0027DE (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009336] ACPI: SSDT 0x000000008A7124F0 0014E2 (v02 HPQOEM SLIC-CPC 00=
000000 INTL 20160527)
[    0.009338] ACPI: DBGP 0x000000008A7139D8 000034 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009341] ACPI: DBG2 0x000000008A713A10 000054 (v00 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009343] ACPI: SSDT 0x000000008A713A68 001B67 (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009346] ACPI: DMAR 0x000000008A7155D0 000070 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009348] ACPI: VFCT 0x000000008A715640 00B284 (v01 HPQOEM SLIC-CPC 00=
000001 AMD  31504F47)
[    0.009351] ACPI: BGRT 0x000000008A7208C8 000038 (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009354] ACPI: TPM2 0x000000008A720900 000034 (v04 HPQOEM SLIC-CPC 00=
000001 AMI  00000000)
[    0.009356] ACPI: WSMT 0x000000008A720938 000028 (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009358] ACPI: Reserving FACP table memory at [mem 0x8a704dc8-0x8a704=
edb]
[    0.009360] ACPI: Reserving DSDT table memory at [mem 0x8a6be248-0x8a704=
dc1]
[    0.009361] ACPI: Reserving FACS table memory at [mem 0x8ab93080-0x8ab93=
0bf]
[    0.009361] ACPI: Reserving APIC table memory at [mem 0x8a704ee0-0x8a704=
f9b]
[    0.009362] ACPI: Reserving FPDT table memory at [mem 0x8a704fa0-0x8a704=
fe3]
[    0.009363] ACPI: Reserving FIDT table memory at [mem 0x8a704fe8-0x8a705=
083]
[    0.009364] ACPI: Reserving MCFG table memory at [mem 0x8a705088-0x8a705=
0c3]
[    0.009364] ACPI: Reserving SSDT table memory at [mem 0x8a7050c8-0x8a706=
c26]
[    0.009365] ACPI: Reserving MSDM table memory at [mem 0x8a706c28-0x8a706=
c7c]
[    0.009366] ACPI: Reserving SSDT table memory at [mem 0x8a706c80-0x8a706=
cdf]
[    0.009367] ACPI: Reserving SSDT table memory at [mem 0x8a706ce0-0x8a706=
d3f]
[    0.009368] ACPI: Reserving SSDT table memory at [mem 0x8a706d40-0x8a709=
f05]
[    0.009368] ACPI: Reserving SSDT table memory at [mem 0x8a709f08-0x8a70c=
322]
[    0.009369] ACPI: Reserving HPET table memory at [mem 0x8a70c328-0x8a70c=
35f]
[    0.009370] ACPI: Reserving SSDT table memory at [mem 0x8a70c360-0x8a70e=
098]
[    0.009371] ACPI: Reserving SSDT table memory at [mem 0x8a70e0a0-0x8a70f=
04d]
[    0.009371] ACPI: Reserving SSDT table memory at [mem 0x8a70f050-0x8a70f=
c2e]
[    0.009372] ACPI: Reserving UEFI table memory at [mem 0x8a70fc30-0x8a70f=
c71]
[    0.009373] ACPI: Reserving LPIT table memory at [mem 0x8a70fc78-0x8a70f=
d0b]
[    0.009374] ACPI: Reserving SSDT table memory at [mem 0x8a70fd10-0x8a712=
4ed]
[    0.009374] ACPI: Reserving SSDT table memory at [mem 0x8a7124f0-0x8a713=
9d1]
[    0.009375] ACPI: Reserving DBGP table memory at [mem 0x8a7139d8-0x8a713=
a0b]
[    0.009376] ACPI: Reserving DBG2 table memory at [mem 0x8a713a10-0x8a713=
a63]
[    0.009377] ACPI: Reserving SSDT table memory at [mem 0x8a713a68-0x8a715=
5ce]
[    0.009377] ACPI: Reserving DMAR table memory at [mem 0x8a7155d0-0x8a715=
63f]
[    0.009378] ACPI: Reserving VFCT table memory at [mem 0x8a715640-0x8a720=
8c3]
[    0.009379] ACPI: Reserving BGRT table memory at [mem 0x8a7208c8-0x8a720=
8ff]
[    0.009380] ACPI: Reserving TPM2 table memory at [mem 0x8a720900-0x8a720=
933]
[    0.009381] ACPI: Reserving WSMT table memory at [mem 0x8a720938-0x8a720=
95f]
[    0.009705] No NUMA configuration found
[    0.009705] Faking a node at [mem 0x0000000000000000-0x000000046dffffff]
[    0.009715] NODE_DATA(0) allocated [mem 0x46dfd32c0-0x46dffdfff]
[    0.009971] Zone ranges:
[    0.009971]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.009973]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.009975]   Normal   [mem 0x0000000100000000-0x000000046dffffff]
[    0.009976]   Device   empty
[    0.009977] Movable zone start for each node
[    0.009979] Early memory node ranges
[    0.009979]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.009981]   node   0: [mem 0x0000000000100000-0x000000008a26ffff]
[    0.009982]   node   0: [mem 0x000000008dc0e000-0x000000008dc0efff]
[    0.009983]   node   0: [mem 0x0000000100000000-0x000000046dffffff]
[    0.009986] Initmem setup node 0 [mem 0x0000000000001000-0x000000046dfff=
fff]
[    0.009990] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.010010] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.012816] On node 0, zone DMA32: 14750 pages in unavailable ranges
[    0.029999] On node 0, zone Normal: 9201 pages in unavailable ranges
[    0.030091] On node 0, zone Normal: 8192 pages in unavailable ranges
[    0.031295] ACPI: PM-Timer IO Port: 0x1808
[    0.031302] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.031304] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.031304] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.031305] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.031306] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.031307] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.031307] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.031308] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.031364] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.031366] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.031368] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.031372] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.031373] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.031379] e820: update [mem 0x86b6d000-0x86bdffff] usable =3D=3D> rese=
rved
[    0.031391] TSC deadline timer available
[    0.031396] CPU topo: Max. logical packages:   1
[    0.031397] CPU topo: Max. logical dies:       1
[    0.031398] CPU topo: Max. dies per package:   1
[    0.031402] CPU topo: Max. threads per core:   1
[    0.031403] CPU topo: Num. cores per package:     8
[    0.031403] CPU topo: Num. threads per package:   8
[    0.031404] CPU topo: Allowing 8 present CPUs plus 0 hotplug CPUs
[    0.031417] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.031420] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0=
x000fffff]
[    0.031421] PM: hibernation: Registered nosave memory: [mem 0x7bf38000-0=
x7bf38fff]
[    0.031423] PM: hibernation: Registered nosave memory: [mem 0x7bf46000-0=
x7bf46fff]
[    0.031424] PM: hibernation: Registered nosave memory: [mem 0x7bf47000-0=
x7bf47fff]
[    0.031425] PM: hibernation: Registered nosave memory: [mem 0x7bf65000-0=
x7bf65fff]
[    0.031427] PM: hibernation: Registered nosave memory: [mem 0x86b6d000-0=
x86bdffff]
[    0.031428] PM: hibernation: Registered nosave memory: [mem 0x88b80000-0=
x88b80fff]
[    0.031430] PM: hibernation: Registered nosave memory: [mem 0x8a270000-0=
x8a6a4fff]
[    0.031430] PM: hibernation: Registered nosave memory: [mem 0x8a6a5000-0=
x8a721fff]
[    0.031431] PM: hibernation: Registered nosave memory: [mem 0x8a722000-0=
x8ab95fff]
[    0.031432] PM: hibernation: Registered nosave memory: [mem 0x8ab96000-0=
x8dc0dfff]
[    0.031433] PM: hibernation: Registered nosave memory: [mem 0x8dc0f000-0=
x8fffffff]
[    0.031434] PM: hibernation: Registered nosave memory: [mem 0x90000000-0=
xfdffffff]
[    0.031435] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0=
xfe010fff]
[    0.031435] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0=
xfebfffff]
[    0.031436] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0=
xfec00fff]
[    0.031437] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0=
xfecfffff]
[    0.031437] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0=
xfed03fff]
[    0.031438] PM: hibernation: Registered nosave memory: [mem 0xfed04000-0=
xfedfffff]
[    0.031439] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0=
xfee00fff]
[    0.031439] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0=
xffffffff]
[    0.031441] [mem 0x90000000-0xfdffffff] available for PCI devices
[    0.031442] Booting paravirtualized kernel on bare hardware
[    0.031444] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 6370452778343963 ns
[    0.037851] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr=
_node_ids:1
[    0.038259] percpu: Embedded 67 pages/cpu s237568 r8192 d28672 u524288
[    0.038265] pcpu-alloc: s237568 r8192 d28672 u524288 alloc=3D1*2097152
[    0.038268] pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7=20
[    0.038288] Kernel command line: initrd=3D\intel-ucode.img initrd=3D\ini=
tramfs-linux.img root=3D/dev/nvme0n1p1 rw intel_iommu=3Don
[    0.038347] DMAR: IOMMU enabled
[    0.039560] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes, linear)
[    0.040156] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes, linear)
[    0.040255] Fallback order for Node 0: 0=20
[    0.040258] Built 1 zonelists, mobility grouping on.  Total pages: 41620=
63
[    0.040259] Policy zone: Normal
[    0.040428] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.040434] software IO TLB: area num 8.
[    0.082323] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D8, N=
odes=3D1
[    0.082359] ftrace: allocating 51351 entries in 201 pages
[    0.090582] ftrace: allocated 201 pages with 4 groups
[    0.090657] Dynamic Preempt: full
[    0.090703] rcu: Preemptible hierarchical RCU implementation.
[    0.090703] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D8.
[    0.090704] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.090705] 	Trampoline variant of Tasks RCU enabled.
[    0.090706] 	Rude variant of Tasks RCU enabled.
[    0.090706] 	Tracing variant of Tasks RCU enabled.
[    0.090707] rcu: RCU calculated value of scheduler-enlistment delay is 3=
0 jiffies.
[    0.090708] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D8
[    0.090713] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjus=
t=3D1 rcu_task_cpu_ids=3D8.
[    0.090715] RCU Tasks Rude: Setting shift to 3 and lim to 1 rcu_task_cb_=
adjust=3D1 rcu_task_cpu_ids=3D8.
[    0.090717] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb=
_adjust=3D1 rcu_task_cpu_ids=3D8.
[    0.096248] NR_IRQS: 524544, nr_irqs: 2048, preallocated irqs: 16
[    0.096534] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.096941] kfence: initialized - using 2097152 bytes for 255 objects at=
 0x(____ptrval____)-0x(____ptrval____)
[    0.096973] Console: colour dummy device 80x25
[    0.096975] printk: legacy console [tty0] enabled
[    0.097026] ACPI: Core revision 20240827
[    0.097272] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.097339] APIC: Switch to symmetric I/O mode setup
[    0.097340] DMAR: Host address width 39
[    0.097342] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.097348] DMAR: dmar0: reg_base_addr fed91000 ver 1:0 cap d2008c406604=
62 ecap f050da
[    0.097350] DMAR: RMRR base: 0x0000008b72e000 end: 0x0000008b977fff
[    0.097353] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 0
[    0.097354] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.097355] DMAR-IR: Queued invalidation will be enabled to support x2ap=
ic and Intr-remapping.
[    0.100389] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.100391] x2apic enabled
[    0.100459] APIC: Switched APIC routing to: cluster x2apic
[    0.109584] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x2b3e459bf4c, max_idle_ns: 440795289890 ns
[    0.109590] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 6002.00 BogoMIPS (lpj=3D10000000)
[    0.109611] x86/cpu: SGX disabled or unsupported by BIOS.
[    0.109619] CPU0: Thermal monitoring enabled (TM1)
[    0.109672] Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
[    0.109674] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.109677] process: using mwait in idle threads
[    0.109680] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.109682] Spectre V2 : Spectre BHI mitigation: SW BHB clearing on sysc=
all and VM exit
[    0.109683] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.109683] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.109684] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL =
on VMEXIT
[    0.109685] RETBleed: Mitigation: Enhanced IBRS
[    0.109686] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.109688] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl
[    0.109692] TAA: Mitigation: TSX disabled
[    0.109693] MMIO Stale Data: Mitigation: Clear CPU buffers
[    0.109696] SRBDS: Mitigation: Microcode
[    0.109701] GDS: Mitigation: Microcode
[    0.109706] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.109707] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.109708] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.109709] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registe=
rs'
[    0.109710] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.109711] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.109712] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.109714] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.109715] x86/fpu: Enabled xstate features 0x1f, context size is 960 b=
ytes, using 'compacted' format.
[    0.112921] Freeing SMP alternatives memory: 40K
[    0.112921] pid_max: default: 32768 minimum: 301
[    0.112921] LSM: initializing lsm=3Dcapability,landlock,lockdown,yama,bpf
[    0.112921] landlock: Up and running.
[    0.112921] Yama: becoming mindful.
[    0.112921] LSM support for eBPF active
[    0.112921] Mount-cache hash table entries: 32768 (order: 6, 262144 byte=
s, linear)
[    0.112921] Mountpoint-cache hash table entries: 32768 (order: 6, 262144=
 bytes, linear)
[    0.112921] smpboot: CPU0: Intel(R) Core(TM) i7-9700F CPU @ 3.00GHz (fam=
ily: 0x6, model: 0x9e, stepping: 0xd)
[    0.112921] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR,=
 full-width counters, Intel PMU driver.
[    0.112921] ... version:                4
[    0.112921] ... bit width:              48
[    0.112921] ... generic registers:      8
[    0.112921] ... value mask:             0000ffffffffffff
[    0.112921] ... max period:             00007fffffffffff
[    0.112921] ... fixed-purpose events:   3
[    0.112921] ... event mask:             00000007000000ff
[    0.112921] signal: max sigframe size: 2032
[    0.112921] Estimated ratio of average max frequency by base frequency (=
times 1024): 1570
[    0.112921] rcu: Hierarchical SRCU implementation.
[    0.112921] rcu: 	Max phase no-delay instances is 1000.
[    0.112921] Timer migration: 1 hierarchy levels; 8 children per group; 1=
 crossnode level
[    0.112921] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.112921] smp: Bringing up secondary CPUs ...
[    0.112921] smpboot: x86: Booting SMP configuration:
[    0.112921] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.113518] smp: Brought up 1 node, 8 CPUs
[    0.113518] smpboot: Total of 8 processors activated (48019.00 BogoMIPS)
[    0.116321] Memory: 16201864K/16648252K available (18432K kernel code, 2=
672K rwdata, 14304K rodata, 4260K init, 4032K bss, 429496K reserved, 0K cma=
-reserved)
[    0.116715] devtmpfs: initialized
[    0.116715] x86/mm: Memory block size: 128MB
[    0.117403] ACPI: PM: Registering ACPI NVS region [mem 0x8a722000-0x8ab9=
5fff] (4669440 bytes)
[    0.117403] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 6370867519511994 ns
[    0.117403] futex hash table entries: 2048 (order: 5, 131072 bytes, line=
ar)
[    0.117403] pinctrl core: initialized pinctrl subsystem
[    0.117403] PM: RTC time: 18:23:37, date: 2025-01-05
[    0.117403] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.117410] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.117522] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.117635] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.117641] audit: initializing netlink subsys (disabled)
[    0.117697] audit: type=3D2000 audit(1736101417.000:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.117697] thermal_sys: Registered thermal governor 'fair_share'
[    0.117697] thermal_sys: Registered thermal governor 'bang_bang'
[    0.117697] thermal_sys: Registered thermal governor 'step_wise'
[    0.117697] thermal_sys: Registered thermal governor 'user_space'
[    0.117697] thermal_sys: Registered thermal governor 'power_allocator'
[    0.117697] cpuidle: using governor ladder
[    0.117697] cpuidle: using governor menu
[    0.117697] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    0.117697] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.119611] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for =
domain 0000 [bus 00-ff]
[    0.119623] PCI: Using configuration type 1 for base access
[    0.119728] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.126306] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.126309] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.126310] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.126311] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.126437] fbcon: Taking over console
[    0.126437] ACPI: Added _OSI(Module Device)
[    0.126437] ACPI: Added _OSI(Processor Device)
[    0.126437] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.126437] ACPI: Added _OSI(Processor Aggregator Device)
[    0.178797] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    0.186739] ACPI: Dynamic OEM Table Load:
[    0.186746] ACPI: SSDT 0xFFFF921A81197C00 000400 (v02 HPQOEM SLIC-CPC 00=
003001 INTL 20160527)
[    0.187096] ACPI: Dynamic OEM Table Load:
[    0.187101] ACPI: SSDT 0xFFFF921A8118E000 000605 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.188120] ACPI: Dynamic OEM Table Load:
[    0.188125] ACPI: SSDT 0xFFFF921A811A6800 0000F4 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.189046] ACPI: Dynamic OEM Table Load:
[    0.189050] ACPI: SSDT 0xFFFF921A81C03E00 000149 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.189937] ACPI: Dynamic OEM Table Load:
[    0.189942] ACPI: SSDT 0xFFFF921A8118A800 000724 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.191045] ACPI: Dynamic OEM Table Load:
[    0.191051] ACPI: SSDT 0xFFFF921A8118C000 0005FC (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.192108] ACPI: Dynamic OEM Table Load:
[    0.192113] ACPI: SSDT 0xFFFF921A81191C00 000317 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.193146] ACPI: Dynamic OEM Table Load:
[    0.193151] ACPI: SSDT 0xFFFF921A81C40000 000AB0 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.194687] ACPI: Dynamic OEM Table Load:
[    0.194691] ACPI: SSDT 0xFFFF921A81194C00 00030A (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.198804] ACPI: EC: EC started
[    0.198806] ACPI: EC: interrupt blocked
[    0.199392] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.199394] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle tran=
sactions
[    0.199396] ACPI: Interpreter enabled
[    0.199432] ACPI: PM: (supports S0 S3 S4 S5)
[    0.199433] ACPI: Using IOAPIC for interrupt routing
[    0.200630] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.200632] PCI: Ignoring E820 reservations for host bridge windows
[    0.201794] ACPI: Enabled 10 GPEs in block 00 to 7F
[    0.218183] ACPI: \_SB_.PCI0.XDCI.USBC: New power resource
[    0.218331] ACPI: \_SB_.PCI0.PAUD: New power resource
[    0.220699] ACPI: \SPR2: New power resource
[    0.220866] ACPI: \SPR3: New power resource
[    0.221157] ACPI: \ZPDR: New power resource
[    0.221395] ACPI: \_SB_.PCI0.SAT0.VOL0.V0PR: New power resource
[    0.221594] ACPI: \_SB_.PCI0.SAT0.VOL1.V1PR: New power resource
[    0.221787] ACPI: \_SB_.PCI0.SAT0.VOL2.V2PR: New power resource
[    0.227233] ACPI: \_SB_.PCI0.I2C1.PXTC: New power resource
[    0.233520] ACPI: \_SB_.PCI0.CNVW.WRST: New power resource
[    0.238502] ACPI: \_TZ_.FN00: New power resource
[    0.238567] ACPI: \_TZ_.FN01: New power resource
[    0.238632] ACPI: \_TZ_.FN02: New power resource
[    0.238694] ACPI: \_TZ_.FN03: New power resource
[    0.238755] ACPI: \_TZ_.FN04: New power resource
[    0.239207] ACPI: \PIN_: New power resource
[    0.239357] ACPI: \SPR0: New power resource
[    0.239411] ACPI: \SPR1: New power resource
[    0.239466] ACPI: \SPR5: New power resource
[    0.240006] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.240013] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI EDR HPX-Type3]
[    0.243258] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME AER PCIeCapability LTR DPC]
[    0.243260] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    0.244436] PCI host bridge to bus 0000:00
[    0.244440] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.244442] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.244444] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.244446] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000efff=
f window]
[    0.244447] pci_bus 0000:00: root bus resource [mem 0x90000000-0xdffffff=
f window]
[    0.244448] pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7ffff=
f window]
[    0.244450] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.244540] pci 0000:00:00.0: [8086:3e30] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.244609] pci 0000:00:01.0: [8086:1901] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.244621] pci 0000:00:01.0: PCI bridge to [bus 01-03]
[    0.244624] pci 0000:00:01.0:   bridge window [io  0x5000-0x5fff]
[    0.244626] pci 0000:00:01.0:   bridge window [mem 0xa0300000-0xa05fffff]
[    0.244631] pci 0000:00:01.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.244657] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.245252] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000 convent=
ional PCI endpoint
[    0.245260] pci 0000:00:08.0: BAR 0 [mem 0xa0922000-0xa0922fff 64bit]
[    0.245433] pci 0000:00:12.0: [8086:a379] type 00 class 0x118000 convent=
ional PCI endpoint
[    0.245465] pci 0000:00:12.0: BAR 0 [mem 0xa0921000-0xa0921fff 64bit]
[    0.245726] pci 0000:00:14.0: [8086:a36d] type 00 class 0x0c0330 convent=
ional PCI endpoint
[    0.245761] pci 0000:00:14.0: BAR 0 [mem 0xa0900000-0xa090ffff 64bit]
[    0.245901] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.246586] pci 0000:00:14.2: [8086:a36f] type 00 class 0x050000 convent=
ional PCI endpoint
[    0.246617] pci 0000:00:14.2: BAR 0 [mem 0xa0916000-0xa0917fff 64bit]
[    0.246636] pci 0000:00:14.2: BAR 2 [mem 0xa0920000-0xa0920fff 64bit]
[    0.246786] pci 0000:00:14.5: [8086:a375] type 00 class 0x080501 convent=
ional PCI endpoint
[    0.246817] pci 0000:00:14.5: BAR 0 [mem 0xa091f000-0xa091ffff 64bit]
[    0.247641] pci 0000:00:15.0: [8086:a368] type 00 class 0x0c8000 convent=
ional PCI endpoint
[    0.248215] pci 0000:00:15.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.251191] pci 0000:00:15.1: [8086:a369] type 00 class 0x0c8000 convent=
ional PCI endpoint
[    0.251766] pci 0000:00:15.1: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.254368] pci 0000:00:16.0: [8086:a360] type 00 class 0x078000 convent=
ional PCI endpoint
[    0.254400] pci 0000:00:16.0: BAR 0 [mem 0xa091c000-0xa091cfff 64bit]
[    0.254518] pci 0000:00:16.0: PME# supported from D3hot
[    0.255135] pci 0000:00:17.0: [8086:a352] type 00 class 0x010601 convent=
ional PCI endpoint
[    0.255162] pci 0000:00:17.0: BAR 0 [mem 0xa0914000-0xa0915fff]
[    0.255177] pci 0000:00:17.0: BAR 1 [mem 0xa091b000-0xa091b0ff]
[    0.255192] pci 0000:00:17.0: BAR 2 [io  0x6050-0x6057]
[    0.255207] pci 0000:00:17.0: BAR 3 [io  0x6040-0x6043]
[    0.255222] pci 0000:00:17.0: BAR 4 [io  0x6020-0x603f]
[    0.255237] pci 0000:00:17.0: BAR 5 [mem 0xa091a000-0xa091a7ff]
[    0.255319] pci 0000:00:17.0: PME# supported from D3hot
[    0.255778] pci 0000:00:1c.0: [8086:a33d] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.255835] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    0.255842] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[    0.255848] pci 0000:00:1c.0:   bridge window [mem 0xa0800000-0xa08fffff]
[    0.255998] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.256043] pci 0000:00:1c.0: PTM enabled (root), 4ns granularity
[    0.256897] pci 0000:00:1c.7: [8086:a33f] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.256955] pci 0000:00:1c.7: PCI bridge to [bus 05]
[    0.256963] pci 0000:00:1c.7:   bridge window [io  0x3000-0x3fff]
[    0.256968] pci 0000:00:1c.7:   bridge window [mem 0xa0700000-0xa07fffff]
[    0.257110] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
[    0.257156] pci 0000:00:1c.7: PTM enabled (root), 4ns granularity
[    0.257940] pci 0000:00:1d.0: [8086:a330] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.257998] pci 0000:00:1d.0: PCI bridge to [bus 06]
[    0.258009] pci 0000:00:1d.0:   bridge window [mem 0xa0600000-0xa06fffff]
[    0.258166] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.258222] pci 0000:00:1d.0: PTM enabled (root), 4ns granularity
[    0.259447] pci 0000:00:1e.0: [8086:a328] type 00 class 0x078000 convent=
ional PCI endpoint
[    0.260009] pci 0000:00:1e.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.262639] pci 0000:00:1f.0: [8086:a304] type 00 class 0x060100 convent=
ional PCI endpoint
[    0.263203] pci 0000:00:1f.3: [8086:a348] type 00 class 0x040300 convent=
ional PCI endpoint
[    0.263263] pci 0000:00:1f.3: BAR 0 [mem 0xa0910000-0xa0913fff 64bit]
[    0.263337] pci 0000:00:1f.3: BAR 4 [mem 0xa0200000-0xa02fffff 64bit]
[    0.263486] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.264842] pci 0000:00:1f.4: [8086:a323] type 00 class 0x0c0500 convent=
ional PCI endpoint
[    0.265022] pci 0000:00:1f.4: BAR 0 [mem 0xa0918000-0xa09180ff 64bit]
[    0.265237] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.265730] pci 0000:00:1f.5: [8086:a324] type 00 class 0x0c8000 convent=
ional PCI endpoint
[    0.265756] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.265941] pci 0000:01:00.0: [1002:1478] type 01 class 0x060400 PCIe Sw=
itch Upstream Port
[    0.265952] pci 0000:01:00.0: BAR 0 [mem 0xa0500000-0xa0503fff]
[    0.265964] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.265969] pci 0000:01:00.0:   bridge window [io  0x5000-0x5fff]
[    0.265972] pci 0000:01:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.265980] pci 0000:01:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.266046] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.266095] pci 0000:01:00.0: 63.008 Gb/s available PCIe bandwidth, limi=
ted by 8.0 GT/s PCIe x8 link at 0000:00:01.0 (capable of 126.024 Gb/s with =
16.0 GT/s PCIe x8 link)
[    0.266189] pci 0000:00:01.0: PCI bridge to [bus 01-03]
[    0.266229] pci 0000:02:00.0: [1002:1479] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.266250] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.266255] pci 0000:02:00.0:   bridge window [io  0x5000-0x5fff]
[    0.266258] pci 0000:02:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.266266] pci 0000:02:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.266332] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.266453] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.266497] pci 0000:03:00.0: [1002:73ff] type 00 class 0x030000 PCIe Le=
gacy Endpoint
[    0.266511] pci 0000:03:00.0: BAR 0 [mem 0x90000000-0x9fffffff 64bit pre=
f]
[    0.266520] pci 0000:03:00.0: BAR 2 [mem 0xa0000000-0xa01fffff 64bit pre=
f]
[    0.266526] pci 0000:03:00.0: BAR 4 [io  0x5000-0x50ff]
[    0.266532] pci 0000:03:00.0: BAR 5 [mem 0xa0300000-0xa03fffff]
[    0.266538] pci 0000:03:00.0: ROM [mem 0xa0400000-0xa041ffff pref]
[    0.266610] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.266668] pci 0000:03:00.0: 63.008 Gb/s available PCIe bandwidth, limi=
ted by 8.0 GT/s PCIe x8 link at 0000:00:01.0 (capable of 252.048 Gb/s with =
16.0 GT/s PCIe x16 link)
[    0.266739] pci 0000:03:00.1: [1002:ab28] type 00 class 0x040300 PCIe Le=
gacy Endpoint
[    0.266748] pci 0000:03:00.1: BAR 0 [mem 0xa0420000-0xa0423fff]
[    0.266819] pci 0000:03:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.266911] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.267071] pci 0000:04:00.0: [10ec:8168] type 00 class 0x020000 PCIe En=
dpoint
[    0.267099] pci 0000:04:00.0: BAR 0 [io  0x4000-0x40ff]
[    0.267136] pci 0000:04:00.0: BAR 2 [mem 0xa0804000-0xa0804fff 64bit]
[    0.267160] pci 0000:04:00.0: BAR 4 [mem 0xa0800000-0xa0803fff 64bit]
[    0.267323] pci 0000:04:00.0: supports D1 D2
[    0.267324] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.267621] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    0.267769] pci 0000:05:00.0: [10ec:c821] type 00 class 0x028000 PCIe En=
dpoint
[    0.267797] pci 0000:05:00.0: BAR 0 [io  0x3000-0x30ff]
[    0.267829] pci 0000:05:00.0: BAR 2 [mem 0xa0700000-0xa070ffff 64bit]
[    0.268017] pci 0000:05:00.0: supports D1 D2
[    0.268018] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.268393] pci 0000:00:1c.7: PCI bridge to [bus 05]
[    0.268761] pci 0000:06:00.0: [8086:f1a8] type 00 class 0x010802 PCIe En=
dpoint
[    0.268796] pci 0000:06:00.0: BAR 0 [mem 0xa0600000-0xa0603fff 64bit]
[    0.269340] pci 0000:00:1d.0: PCI bridge to [bus 06]
[    0.271571] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.271653] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
[    0.271732] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.271811] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.271889] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.271968] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.272046] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.272124] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.277350] ACPI: EC: interrupt unblocked
[    0.277352] ACPI: EC: event unblocked
[    0.277364] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.277365] ACPI: EC: GPE=3D0xb
[    0.277367] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC initialization comp=
lete
[    0.277368] ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions =
and events
[    0.277420] iommu: Default domain type: Translated
[    0.277420] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.277420] SCSI subsystem initialized
[    0.277420] libata version 3.00 loaded.
[    0.277420] ACPI: bus type USB registered
[    0.277420] usbcore: registered new interface driver usbfs
[    0.277420] usbcore: registered new interface driver hub
[    0.277420] usbcore: registered new device driver usb
[    0.277420] EDAC MC: Ver: 3.0.0
[    0.277420] efivars: Registered efivars operations
[    0.277420] NetLabel: Initializing
[    0.277420] NetLabel:  domain hash size =3D 128
[    0.277420] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.277420] NetLabel:  unlabeled traffic allowed by default
[    0.277420] mctp: management component transport protocol core
[    0.277420] NET: Registered PF_MCTP protocol family
[    0.277420] PCI: Using ACPI for IRQ routing
[    0.363454] PCI: pci_cache_line_size set to 64 bytes
[    0.364054] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.364064] e820: reserve RAM buffer [mem 0x7bf38018-0x7bffffff]
[    0.364065] e820: reserve RAM buffer [mem 0x7bf47018-0x7bffffff]
[    0.364066] e820: reserve RAM buffer [mem 0x86b6d000-0x87ffffff]
[    0.364067] e820: reserve RAM buffer [mem 0x88b80000-0x8bffffff]
[    0.364069] e820: reserve RAM buffer [mem 0x8a270000-0x8bffffff]
[    0.364070] e820: reserve RAM buffer [mem 0x8dc0f000-0x8fffffff]
[    0.364071] e820: reserve RAM buffer [mem 0x46e000000-0x46fffffff]
[    0.364101] pci 0000:03:00.0: vgaarb: setting as boot VGA device
[    0.364101] pci 0000:03:00.0: vgaarb: bridge control possible
[    0.364101] pci 0000:03:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[    0.364101] vgaarb: loaded
[    0.364101] clocksource: Switched to clocksource tsc-early
[    0.364101] VFS: Disk quotas dquot_6.6.0
[    0.364101] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.364101] pnp: PnP ACPI init
[    0.364101] system 00:00: [mem 0x40000000-0x403fffff] could not be reser=
ved
[    0.364355] system 00:01: [io  0x0a00-0x0a0f] has been reserved
[    0.364357] system 00:01: [io  0x0a10-0x0a1f] has been reserved
[    0.364359] system 00:01: [io  0x0a20-0x0a2f] has been reserved
[    0.364360] system 00:01: [io  0x0a30-0x0a3f] has been reserved
[    0.364362] system 00:01: [io  0x0a40-0x0a4f] has been reserved
[    0.364363] system 00:01: [io  0x0a50-0x0a5f] has been reserved
[    0.364364] system 00:01: [io  0x0a60-0x0a6f] has been reserved
[    0.364365] system 00:01: [io  0x0a70-0x0a7f] has been reserved
[    0.364367] system 00:01: [io  0x0a80-0x0a8f] has been reserved
[    0.364368] system 00:01: [io  0x0a90-0x0b8e] has been reserved
[    0.364369] system 00:01: [io  0x0aa0-0x0aaf] has been reserved
[    0.364371] system 00:01: [io  0x0ab0-0x0abf] has been reserved
[    0.364372] system 00:01: [io  0x0ac0-0x0acf] has been reserved
[    0.364373] system 00:01: [io  0x0ad0-0x0adf] has been reserved
[    0.364757] system 00:02: [io  0x0680-0x069f] has been reserved
[    0.364759] system 00:02: [io  0x164e-0x164f] has been reserved
[    0.364873] system 00:03: [io  0x1854-0x1857] has been reserved
[    0.365027] system 00:04: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.365027] system 00:04: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.365027] system 00:04: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.365027] system 00:04: [mem 0xe0000000-0xefffffff] has been reserved
[    0.365027] system 00:04: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.365027] system 00:04: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.365027] system 00:04: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.365027] system 00:04: [mem 0xfee00000-0xfeefffff] could not be reser=
ved
[    0.365237] system 00:05: [io  0x1800-0x18fe] could not be reserved
[    0.365240] system 00:05: [mem 0xfd000000-0xfd69ffff] has been reserved
[    0.365242] system 00:05: [mem 0xfd6c0000-0xfd6cffff] has been reserved
[    0.365244] system 00:05: [mem 0xfd6f0000-0xfdffffff] has been reserved
[    0.365245] system 00:05: [mem 0xfe000000-0xfe01ffff] could not be reser=
ved
[    0.365247] system 00:05: [mem 0xfe200000-0xfe7fffff] has been reserved
[    0.365249] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.365548] system 00:06: [io  0x2000-0x20fe] has been reserved
[    0.367595] pnp: PnP ACPI: found 8 devices
[    0.373032] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.373083] NET: Registered PF_INET protocol family
[    0.373209] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)
[    0.387877] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5,=
 131072 bytes, linear)
[    0.387899] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.387937] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes, linear)
[    0.388150] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,=
 linear)
[    0.388371] TCP: Hash tables configured (established 131072 bind 65536)
[    0.388423] MPTCP token hash table entries: 16384 (order: 6, 393216 byte=
s, linear)
[    0.388472] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.388509] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, l=
inear)
[    0.388557] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.388563] NET: Registered PF_XDP protocol family
[    0.388577] pci 0000:00:15.0: BAR 0 [mem 0xa0919000-0xa0919fff 64bit]: a=
ssigned
[    0.388849] pci 0000:00:15.1: BAR 0 [mem 0xa091d000-0xa091dfff 64bit]: a=
ssigned
[    0.389117] pci 0000:00:1e.0: BAR 0 [mem 0xa091e000-0xa091efff 64bit]: a=
ssigned
[    0.389386] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.389392] pci 0000:02:00.0:   bridge window [io  0x5000-0x5fff]
[    0.389396] pci 0000:02:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.389399] pci 0000:02:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.389403] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.389405] pci 0000:01:00.0:   bridge window [io  0x5000-0x5fff]
[    0.389409] pci 0000:01:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.389416] pci 0000:01:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.389420] pci 0000:00:01.0: PCI bridge to [bus 01-03]
[    0.389422] pci 0000:00:01.0:   bridge window [io  0x5000-0x5fff]
[    0.389424] pci 0000:00:01.0:   bridge window [mem 0xa0300000-0xa05fffff]
[    0.389426] pci 0000:00:01.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.389429] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    0.389437] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[    0.389443] pci 0000:00:1c.0:   bridge window [mem 0xa0800000-0xa08fffff]
[    0.389457] pci 0000:00:1c.7: PCI bridge to [bus 05]
[    0.389460] pci 0000:00:1c.7:   bridge window [io  0x3000-0x3fff]
[    0.389466] pci 0000:00:1c.7:   bridge window [mem 0xa0700000-0xa07fffff]
[    0.389480] pci 0000:00:1d.0: PCI bridge to [bus 06]
[    0.389487] pci 0000:00:1d.0:   bridge window [mem 0xa0600000-0xa06fffff]
[    0.389500] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.389502] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.389504] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.389505] pci_bus 0000:00: resource 7 [mem 0x000e0000-0x000effff windo=
w]
[    0.389506] pci_bus 0000:00: resource 8 [mem 0x90000000-0xdfffffff windo=
w]
[    0.389508] pci_bus 0000:00: resource 9 [mem 0xfc800000-0xfe7fffff windo=
w]
[    0.389509] pci_bus 0000:01: resource 0 [io  0x5000-0x5fff]
[    0.389510] pci_bus 0000:01: resource 1 [mem 0xa0300000-0xa05fffff]
[    0.389511] pci_bus 0000:01: resource 2 [mem 0x90000000-0xa01fffff 64bit=
 pref]
[    0.389513] pci_bus 0000:02: resource 0 [io  0x5000-0x5fff]
[    0.389514] pci_bus 0000:02: resource 1 [mem 0xa0300000-0xa04fffff]
[    0.389515] pci_bus 0000:02: resource 2 [mem 0x90000000-0xa01fffff 64bit=
 pref]
[    0.389517] pci_bus 0000:03: resource 0 [io  0x5000-0x5fff]
[    0.389518] pci_bus 0000:03: resource 1 [mem 0xa0300000-0xa04fffff]
[    0.389519] pci_bus 0000:03: resource 2 [mem 0x90000000-0xa01fffff 64bit=
 pref]
[    0.389521] pci_bus 0000:04: resource 0 [io  0x4000-0x4fff]
[    0.389522] pci_bus 0000:04: resource 1 [mem 0xa0800000-0xa08fffff]
[    0.389523] pci_bus 0000:05: resource 0 [io  0x3000-0x3fff]
[    0.389524] pci_bus 0000:05: resource 1 [mem 0xa0700000-0xa07fffff]
[    0.389526] pci_bus 0000:06: resource 1 [mem 0xa0600000-0xa06fffff]
[    0.390132] pci 0000:03:00.1: D0 power state depends on 0000:03:00.0
[    0.390229] PCI: CLS 64 bytes, default 64
[    0.390293] DMAR: No ATSR found
[    0.390294] DMAR: No SATC found
[    0.390295] DMAR: dmar0: Using Queued invalidation
[    0.390320] Trying to unpack rootfs image as initramfs...
[    0.390346] pci 0000:00:00.0: Adding to iommu group 0
[    0.390360] pci 0000:00:01.0: Adding to iommu group 1
[    0.390368] pci 0000:00:08.0: Adding to iommu group 2
[    0.390379] pci 0000:00:12.0: Adding to iommu group 3
[    0.390398] pci 0000:00:14.0: Adding to iommu group 4
[    0.390406] pci 0000:00:14.2: Adding to iommu group 4
[    0.390413] pci 0000:00:14.5: Adding to iommu group 4
[    0.390428] pci 0000:00:15.0: Adding to iommu group 5
[    0.390436] pci 0000:00:15.1: Adding to iommu group 5
[    0.390447] pci 0000:00:16.0: Adding to iommu group 6
[    0.390456] pci 0000:00:17.0: Adding to iommu group 7
[    0.390471] pci 0000:00:1c.0: Adding to iommu group 8
[    0.390481] pci 0000:00:1c.7: Adding to iommu group 9
[    0.390492] pci 0000:00:1d.0: Adding to iommu group 10
[    0.390503] pci 0000:00:1e.0: Adding to iommu group 11
[    0.390525] pci 0000:00:1f.0: Adding to iommu group 12
[    0.390535] pci 0000:00:1f.3: Adding to iommu group 12
[    0.390544] pci 0000:00:1f.4: Adding to iommu group 12
[    0.390553] pci 0000:00:1f.5: Adding to iommu group 12
[    0.390556] pci 0000:01:00.0: Adding to iommu group 1
[    0.390561] pci 0000:02:00.0: Adding to iommu group 1
[    0.390566] pci 0000:03:00.0: Adding to iommu group 1
[    0.390570] pci 0000:03:00.1: Adding to iommu group 1
[    0.390585] pci 0000:04:00.0: Adding to iommu group 13
[    0.390595] pci 0000:05:00.0: Adding to iommu group 14
[    0.390606] pci 0000:06:00.0: Adding to iommu group 15
[    0.391437] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.391438] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.391439] software IO TLB: mapped [mem 0x0000000082b6d000-0x0000000086=
b6d000] (64MB)
[    0.391493] platform rtc_cmos: registered platform RTC device (no PNP de=
vice found)
[    0.416630] Initialise system trusted keyrings
[    0.416639] Key type blacklist registered
[    0.416676] workingset: timestamp_bits=3D36 max_order=3D22 bucket_order=
=3D0
[    0.416759] fuse: init (API version 7.41)
[    0.416822] integrity: Platform Keyring initialized
[    0.416824] integrity: Machine keyring initialized
[    0.427770] Key type asymmetric registered
[    0.427771] Asymmetric key parser 'x509' registered
[    0.427786] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 246)
[    0.427820] io scheduler mq-deadline registered
[    0.427821] io scheduler kyber registered
[    0.427829] io scheduler bfq registered
[    0.427970] ledtrig-cpu: registered to indicate activity on CPUs
[    0.428169] pcieport 0000:00:01.0: PME: Signaling with IRQ 121
[    0.428393] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
[    0.428461] pcieport 0000:00:1c.0: AER: enabled with IRQ 122
[    0.428503] pcieport 0000:00:1c.0: DPC: enabled with IRQ 122
[    0.428504] pcieport 0000:00:1c.0: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.428792] pcieport 0000:00:1c.7: PME: Signaling with IRQ 123
[    0.428847] pcieport 0000:00:1c.7: AER: enabled with IRQ 123
[    0.428885] pcieport 0000:00:1c.7: DPC: enabled with IRQ 123
[    0.428887] pcieport 0000:00:1c.7: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.429161] pcieport 0000:00:1d.0: PME: Signaling with IRQ 124
[    0.429219] pcieport 0000:00:1d.0: AER: enabled with IRQ 124
[    0.429261] pcieport 0000:00:1d.0: DPC: enabled with IRQ 124
[    0.429263] pcieport 0000:00:1d.0: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.429623] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.430145] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input0
[    0.430166] ACPI: button: Sleep Button [SLPB]
[    0.430188] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input1
[    0.430200] ACPI: button: Power Button [PWRB]
[    0.430224] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input2
[    0.432815] ACPI: button: Power Button [PWRF]
[    0.434847] thermal LNXTHERM:00: registered as thermal_zone0
[    0.434849] ACPI: thermal: Thermal Zone [HPTZ] (30 C)
[    0.435138] thermal LNXTHERM:01: registered as thermal_zone1
[    0.435139] ACPI: thermal: Thermal Zone [TZ00] (28 C)
[    0.435342] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.437164] hpet_acpi_add: no address or irqs in _CRS
[    0.437201] Non-volatile memory driver v1.3
[    0.437202] Linux agpgart interface v0.103
[    0.453924] Freeing initrd memory: 21224K
[    0.572197] ACPI: bus type drm_connector registered
[    0.573080] ahci 0000:00:17.0: version 3.0
[    0.583436] ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 =
Gbps, SATA mode
[    0.583440] ahci 0000:00:17.0: 4/4 ports implemented (port mask 0x3c)
[    0.583442] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio slu=
m part ems deso sadm sds apst=20
[    0.603415] scsi host0: ahci
[    0.603732] scsi host1: ahci
[    0.603993] scsi host2: ahci
[    0.604181] scsi host3: ahci
[    0.604283] scsi host4: ahci
[    0.604343] scsi host5: ahci
[    0.604366] ata1: DUMMY
[    0.604367] ata2: DUMMY
[    0.604373] ata3: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a20=
0 irq 126 lpm-pol 3
[    0.604376] ata4: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a28=
0 irq 126 lpm-pol 3
[    0.604379] ata5: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a30=
0 irq 126 lpm-pol 3
[    0.604382] ata6: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a38=
0 irq 126 lpm-pol 3
[    0.604622] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.604627] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[    0.605760] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
10 quirks 0x0000000000009810
[    0.606040] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.606043] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[    0.606046] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperS=
peed
[    0.606085] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.12
[    0.606088] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.606089] usb usb1: Product: xHCI Host Controller
[    0.606091] usb usb1: Manufacturer: Linux 6.12.8-arch1-1 xhci-hcd
[    0.606092] usb usb1: SerialNumber: 0000:00:14.0
[    0.606214] hub 1-0:1.0: USB hub found
[    0.606236] hub 1-0:1.0: 16 ports detected
[    0.607951] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.12
[    0.607954] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.607955] usb usb2: Product: xHCI Host Controller
[    0.607956] usb usb2: Manufacturer: Linux 6.12.8-arch1-1 xhci-hcd
[    0.607958] usb usb2: SerialNumber: 0000:00:14.0
[    0.608056] hub 2-0:1.0: USB hub found
[    0.608071] hub 2-0:1.0: 8 ports detected
[    0.608838] usb: port power management may be unreliable
[    0.609157] usbcore: registered new interface driver usbserial_generic
[    0.609161] usbserial: USB Serial support registered for generic
[    0.609301] rtc_cmos rtc_cmos: RTC can wake from S4
[    0.610837] rtc_cmos rtc_cmos: registered as rtc0
[    0.611150] rtc_cmos rtc_cmos: setting system clock to 2025-01-05T18:23:=
38 UTC (1736101418)
[    0.611182] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nv=
ram
[    0.611508] intel_pstate: Intel P-state driver initializing
[    0.612134] intel_pstate: Disabling energy efficiency optimization
[    0.612135] intel_pstate: HWP enabled
[    0.612374] simple-framebuffer simple-framebuffer.0: [drm] Registered 1 =
planes with drm panic
[    0.612375] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 o=
n minor 0
[    0.622226] Console: switching to colour frame buffer device 240x67
[    0.634059] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledr=
mdrmfb frame buffer device
[    0.634190] hid: raw HID events driver (C) Jiri Kosina
[    0.634266] drop_monitor: Initializing network drop monitor service
[    0.634348] NET: Registered PF_INET6 protocol family
[    0.639069] Segment Routing with IPv6
[    0.639071] RPL Segment Routing with IPv6
[    0.639078] In-situ OAM (IOAM) with IPv6
[    0.639094] NET: Registered PF_PACKET protocol family
[    0.639792] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.640026] microcode: Current revision: 0x00000100
[    0.640027] microcode: Updated early from: 0x000000fa
[    0.640336] IPI shorthand broadcast: enabled
[    0.641443] sched_clock: Marking stable (627579733, 12743584)->(67072215=
7, -30398840)
[    0.641725] registered taskstats version 1
[    0.642281] Loading compiled-in X.509 certificates
[    0.644248] Loaded X.509 cert 'Build time autogenerated kernel key: 6587=
eb3a34e425dab5507b3af5d21e7082a7b55e'
[    0.645345] Demotion targets for Node 0: null
[    0.645509] Key type .fscrypt registered
[    0.645509] Key type fscrypt-provisioning registered
[    0.646617] integrity: Loading X.509 certificate: UEFI:db
[    0.646632] integrity: Loaded X.509 cert 'HP Inc.: HP UEFI Secure Boot D=
B 2017: d9c01b50cfcae89d3b05345c163aa76e5dd589e7'
[    0.646633] integrity: Loading X.509 certificate: UEFI:db
[    0.646646] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA =
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.646647] integrity: Loading X.509 certificate: UEFI:db
[    0.646655] integrity: Loaded X.509 cert 'Microsoft Windows Production P=
CA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.648307] PM:   Magic number: 9:77:392
[    0.648325] thermal cooling_device7: hash matches
[    0.648345] acpi PNP0C0D:00: hash matches
[    0.648351] acpi XXXX0000:02: hash matches
[    0.650485] RAS: Correctable Errors collector initialized.
[    0.657010] clk: Disabling unused clocks
[    0.657011] PM: genpd: Disabling unused power domains
[    0.852983] usb 1-8: new high-speed USB device number 2 using xhci_hcd
[    0.910050] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.912808] ata5.00: Model 'SAMSUNG MZ7TD256HAFV-000L9', rev 'DXT04L6Q',=
 applying quirks: nolpm
[    0.912819] ata5.00: LPM support broken, forcing max_power
[    0.912976] ata5.00: supports DRM functions and may not be fully accessi=
ble
[    0.912983] ata5.00: ATA-9: SAMSUNG MZ7TD256HAFV-000L9, DXT04L6Q, max UD=
MA/133
[    0.913286] ata5.00: NCQ Send/Recv Log not supported
[    0.913294] ata5.00: 500118192 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    0.913643] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.913714] ata4: SATA link down (SStatus 0 SControl 300)
[    0.913775] ata6: SATA link down (SStatus 4 SControl 300)
[    0.915395] ata5.00: Features: Trust Dev-Sleep
[    0.915843] ata5.00: LPM support broken, forcing max_power
[    0.916000] ata5.00: supports DRM functions and may not be fully accessi=
ble
[    0.916329] ata5.00: NCQ Send/Recv Log not supported
[    0.918655] ata5.00: configured for UDMA/133
[    0.920646] ata3.00: ATA-8: WDC WD20EARX-00PASB0, 51.0AB51, max UDMA/133
[    0.921347] ata3.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 32),=
 AA
[    0.928850] ata3.00: configured for UDMA/133
[    0.928928] ahci 0000:00:17.0: port does not support device sleep
[    0.929108] scsi 2:0:0:0: Direct-Access     ATA      WDC WD20EARX-00P AB=
51 PQ: 0 ANSI: 5
[    0.929654] sd 2:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 =
TB/1.82 TiB)
[    0.929662] sd 2:0:0:0: [sda] 4096-byte physical blocks
[    0.929680] sd 2:0:0:0: [sda] Write Protect is off
[    0.929684] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.929707] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    0.929745] sd 2:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
[    0.929901] scsi 4:0:0:0: Direct-Access     ATA      SAMSUNG MZ7TD256 4L=
6Q PQ: 0 ANSI: 5
[    0.930409] sd 4:0:0:0: [sdb] 500118192 512-byte logical blocks: (256 GB=
/238 GiB)
[    0.930430] sd 4:0:0:0: [sdb] Write Protect is off
[    0.930435] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    0.930457] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    0.930508] sd 4:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
[    0.983319] usb 1-8: New USB device found, idVendor=3D058f, idProduct=3D=
6254, bcdDevice=3D 1.00
[    0.983332] usb 1-8: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    0.984909] hub 1-8:1.0: USB hub found
[    0.984939]  sdb: sdb1 sdb2 sdb3 sdb4
[    0.985037] hub 1-8:1.0: 4 ports detected
[    0.985927] sd 4:0:0:0: [sdb] supports TCG Opal
[    0.985935] sd 4:0:0:0: [sdb] Attached SCSI disk
[    1.102948] usb 1-14: new full-speed USB device number 3 using xhci_hcd
[    1.234307] usb 1-14: New USB device found, idVendor=3D0bda, idProduct=
=3Db00a, bcdDevice=3D 1.10
[    1.234321] usb 1-14: New USB device strings: Mfr=3D1, Product=3D2, Seri=
alNumber=3D3
[    1.234327] usb 1-14: Product: Bluetooth Radio=20
[    1.234332] usb 1-14: Manufacturer: Realtek=20
[    1.234335] usb 1-14: SerialNumber: 00e04c000001
[    1.313107] usb 1-8.3: new low-speed USB device number 4 using xhci_hcd
[    1.393122] tsc: Refined TSC clocksource calibration: 3000.007 MHz
[    1.393141] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2b3=
e4c0030f, max_idle_ns: 440795221275 ns
[    1.393217] clocksource: Switched to clocksource tsc
[    1.400755]  sda: sda1
[    1.401024] sd 2:0:0:0: [sda] Attached SCSI disk
[    1.403968] Freeing unused decrypted memory: 2028K
[    1.405153] Freeing unused kernel image (initmem) memory: 4260K
[    1.405200] Write protecting the kernel read-only data: 32768k
[    1.405810] Freeing unused kernel image (rodata/data gap) memory: 32K
[    1.410914] usb 1-8.3: New USB device found, idVendor=3D05d5, idProduct=
=3D0615, bcdDevice=3D 1.01
[    1.410916] usb 1-8.3: New USB device strings: Mfr=3D0, Product=3D1, Ser=
ialNumber=3D0
[    1.410917] usb 1-8.3: Product: KEYBOARD
[    1.413949] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.413952] rodata_test: all tests were successful
[    1.413955] Run /init as init process
[    1.413955]   with arguments:
[    1.413956]     /init
[    1.413957]   with environment:
[    1.413957]     HOME=3D/
[    1.413958]     TERM=3Dlinux
[    1.617145] sdhci: Secure Digital Host Controller Interface driver
[    1.617147] sdhci: Copyright(c) Pierre Ossman
[    1.622590] usbcore: registered new interface driver usbhid
[    1.622592] usbhid: USB HID core driver
[    1.623895] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    1.623904] sdhci-pci 0000:00:14.5: enabling device (0100 -> 0102)
[    1.625730] input: KEYBOARD as /devices/pci0000:00/0000:00:14.0/usb1/1-8=
/1-8.3/1-8.3:1.0/0003:05D5:0615.0001/input/input3
[    1.628333] nvme nvme0: pci function 0000:06:00.0
[    1.637343] nvme nvme0: 8/0/0 default/read/poll queues
[    1.640438]  nvme0n1: p1 p2
[    1.640552] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    1.746527] hid-generic 0003:05D5:0615.0001: input,hidraw0: USB HID v1.1=
0 Keyboard [KEYBOARD] on usb-0000:00:14.0-8.3/input0
[    1.746655] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    1.746855] input: KEYBOARD Consumer Control as /devices/pci0000:00/0000=
:00:14.0/usb1/1-8/1-8.3/1-8.3:1.1/0003:05D5:0615.0002/input/input4
[    1.799791] input: KEYBOARD System Control as /devices/pci0000:00/0000:0=
0:14.0/usb1/1-8/1-8.3/1-8.3:1.1/0003:05D5:0615.0002/input/input5
[    1.800212] hid-generic 0003:05D5:0615.0002: input,hidraw1: USB HID v1.1=
0 Device [KEYBOARD] on usb-0000:00:14.0-8.3/input1
[    1.800359] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    2.027703] EXT4-fs (nvme0n1p1): mounted filesystem 7f701c1e-4cf2-46b9-8=
8a1-184e3dfef17e r/w with ordered data mode. Quota mode: none.
[    2.195397] systemd[1]: systemd 257.1-1-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPEN=
SSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETU=
P +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM=
2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINI=
T +LIBARCHIVE)
[    2.195407] systemd[1]: Detected architecture x86-64.
[    2.198503] systemd[1]: Hostname set to <Ale-Arch>.
[    2.515163] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    2.758738] systemd-fstab-generator[303]: Mount point  is not a valid pa=
th, ignoring.
[    2.758744] systemd-fstab-generator[303]: Mount point  is not a valid pa=
th, ignoring.
[    2.758822] systemd-fstab-generator[303]: Mount point  is not a valid pa=
th, ignoring.
[    2.759453] systemd-fstab-generator[303]: Mount point  is not a valid pa=
th, ignoring.
[    2.764293] systemd-fstab-generator[303]: Mount point  is not a valid pa=
th, ignoring.
[    2.764297] systemd-fstab-generator[303]: Mount point  is not a valid pa=
th, ignoring.
[    2.764300] systemd-fstab-generator[303]: Mount point  is not a valid pa=
th, ignoring.
[    2.764344] systemd-fstab-generator[303]: Mount point  is not a valid pa=
th, ignoring.
[    2.764378] systemd-fstab-generator[303]: Mount point  is not a valid pa=
th, ignoring.
[    2.766303] systemd-fstab-generator[303]: Mount point  is not a valid pa=
th, ignoring.
[    2.766306] systemd-fstab-generator[303]: Mount point  is not a valid pa=
th, ignoring.
[    2.786840] zram: Added device: zram0
[    3.039029] systemd[1]: Configuration file /run/systemd/system/netplan-o=
vs-cleanup.service is marked world-inaccessible. This has no effect as conf=
iguration data is accessible via APIs without restrictions. Proceeding anyw=
ay.
[    3.142526] systemd[1]: Queued start job for default target Graphical In=
terface.
[    3.171568] systemd[1]: Created slice Virtual Machine and Container Slic=
e.
[    3.172264] systemd[1]: Created slice Slice /system/backrest.
[    3.172536] systemd[1]: Created slice CUPS Slice.
[    3.172816] systemd[1]: Created slice Slice /system/dirmngr.
[    3.173091] systemd[1]: Created slice Slice /system/getty.
[    3.173363] systemd[1]: Created slice Slice /system/gpg-agent.
[    3.173636] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    3.173909] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    3.174181] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    3.174452] systemd[1]: Created slice Slice /system/keyboxd.
[    3.174732] systemd[1]: Created slice Slice /system/modprobe.
[    3.175003] systemd[1]: Created slice Slice /system/nut-driver.
[    3.175268] systemd[1]: Created slice Slice /system/systemd-fsck.
[    3.175542] systemd[1]: Created slice Slice /system/systemd-zram-setup.
[    3.175716] systemd[1]: Created slice User and Session Slice.
[    3.175763] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    3.175869] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[    3.175891] systemd[1]: Expecting device /dev/disk/by-uuid/0f1ef58b-496b=
-48fd-a17b-6cbc03a2c8ee...
[    3.175901] systemd[1]: Expecting device /dev/disk/by-uuid/CAB7-E233...
[    3.175910] systemd[1]: Expecting device /dev/zram0...
[    3.175926] systemd[1]: Reached target Login Prompts.
[    3.175939] systemd[1]: Reached target Local Integrity Protected Volumes.
[    3.175965] systemd[1]: Reached target Remote File Systems.
[    3.176023] systemd[1]: Reached target Slice Units.
[    3.176118] systemd[1]: Reached target System Time Set.
[    3.176178] systemd[1]: Reached target Local Verity Protected Volumes.
[    3.176257] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    3.176343] systemd[1]: Listening on LVM2 poll daemon socket.
[    3.178600] systemd[1]: Listening on RPCbind Server Activation Socket.
[    3.178635] systemd[1]: Reached target RPC Port Mapper.
[    3.181956] systemd[1]: Listening on Process Core Dump Socket.
[    3.182509] systemd[1]: Listening on Credential Encryption/Decryption.
[    3.182577] systemd[1]: Listening on Journal Socket (/dev/log).
[    3.182649] systemd[1]: Listening on Journal Sockets.
[    3.182748] systemd[1]: Listening on Network Service Netlink Socket.
[    3.183438] systemd[1]: Listening on Userspace Out-Of-Memory (OOM) Kille=
r Socket.
[    3.183470] systemd[1]: TPM PCR Measurements was skipped because of an u=
nmet condition check (ConditionSecurity=3Dmeasured-uki).
[    3.183484] systemd[1]: Make TPM PCR Policy was skipped because of an un=
met condition check (ConditionSecurity=3Dmeasured-uki).
[    3.183535] systemd[1]: Listening on udev Control Socket.
[    3.184343] systemd[1]: Listening on udev Kernel Socket.
[    3.185897] systemd[1]: Mounting Huge Pages File System...
[    3.187128] systemd[1]: Mounting POSIX Message Queue File System...
[    3.187885] systemd[1]: Mounting NFSD configuration filesystem...
[    3.188800] systemd[1]: Mounting Kernel Debug File System...
[    3.189690] systemd[1]: Mounting Kernel Trace File System...
[    3.190105] systemd[1]: Load AppArmor profiles was skipped because of an=
 unmet condition check (ConditionSecurity=3Dapparmor).
[    3.190145] systemd[1]: Kernel Module supporting RPCSEC_GSS was skipped =
because of an unmet condition check (ConditionPathExists=3D/etc/krb5.keytab=
).
[    3.191057] systemd[1]: Starting Create List of Static Device Nodes...
[    3.192208] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling...
[    3.193409] systemd[1]: Starting Load Kernel Module configfs...
[    3.194290] systemd[1]: Starting Load Kernel Module dm_mod...
[    3.195177] systemd[1]: Starting Load Kernel Module drm...
[    3.196088] systemd[1]: Starting Load Kernel Module fuse...
[    3.197086] systemd[1]: Starting Load Kernel Module loop...
[    3.197973] systemd[1]: File System Check on Root Device was skipped bec=
ause of an unmet condition check (ConditionPathIsReadWrite=3D!/).
[    3.198014] systemd[1]: Clear Stale Hibernate Storage Info was skipped b=
ecause of an unmet condition check (ConditionPathExists=3D/sys/firmware/efi=
/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[    3.199471] systemd[1]: Starting Journal Service...
[    3.200694] systemd[1]: Starting Load Kernel Modules...
[    3.201846] systemd[1]: Starting Userspace Out-Of-Memory (OOM) Killer...
[    3.201871] systemd[1]: TPM PCR Machine ID Measurement was skipped becau=
se of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    3.202484] systemd[1]: Starting Remount Root and Kernel File Systems...
[    3.202536] systemd[1]: Early TPM SRK Setup was skipped because of an un=
met condition check (ConditionSecurity=3Dmeasured-uki).
[    3.206271] systemd[1]: Starting Load udev Rules from Credentials...
[    3.207167] systemd[1]: Starting Coldplug All udev Devices...
[    3.207194] loop: module loaded
[    3.207217] device-mapper: uevent: version 1.0.3
[    3.207267] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised:=
 dm-devel@lists.linux.dev
[    3.208096] systemd[1]: Starting Virtual Console Setup...
[    3.210216] systemd[1]: Mounted Huge Pages File System.
[    3.210614] systemd[1]: Mounted POSIX Message Queue File System.
[    3.211708] systemd[1]: Mounted Kernel Debug File System.
[    3.212550] systemd[1]: Mounted Kernel Trace File System.
[    3.213194] systemd[1]: Finished Create List of Static Device Nodes.
[    3.214005] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[    3.214146] systemd[1]: Finished Load Kernel Module configfs.
[    3.214759] systemd[1]: modprobe@dm_mod.service: Deactivated successfull=
y.
[    3.214869] systemd[1]: Finished Load Kernel Module dm_mod.
[    3.215502] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    3.215604] systemd[1]: Finished Load Kernel Module drm.
[    3.216336] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    3.216440] systemd[1]: Finished Load Kernel Module fuse.
[    3.216612] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    3.216716] systemd[1]: Finished Load Kernel Module loop.
[    3.217067] systemd[1]: Finished Load udev Rules from Credentials.
[    3.219297] systemd[1]: Mounting FUSE Control File System...
[    3.220780] systemd[1]: Mounting Kernel Configuration File System...
[    3.220825] systemd[1]: Repartition Root Disk was skipped because no tri=
gger condition checks were met.
[    3.221488] systemd[1]: Starting Create Static Device Nodes in /dev grac=
efully...
[    3.225136] systemd[1]: Mounted FUSE Control File System.
[    3.225476] systemd[1]: Mounted Kernel Configuration File System.
[    3.230095] EXT4-fs (nvme0n1p1): re-mounted 7f701c1e-4cf2-46b9-88a1-184e=
3dfef17e r/w. Quota mode: none.
[    3.230706] systemd[1]: Finished Remount Root and Kernel File Systems.
[    3.233067] systemd[1]: Rebuild Hardware Database was skipped because of=
 an unmet condition check (ConditionNeedsUpdate=3D/etc).
[    3.233969] systemd[1]: Starting Load/Save OS Random Seed...
[    3.233995] systemd[1]: TPM SRK Setup was skipped because of an unmet co=
ndition check (ConditionSecurity=3Dmeasured-uki).
[    3.236258] systemd-journald[341]: Collecting audit messages is disabled.
[    3.236663] vhba: loading out-of-tree module taints kernel.
[    3.236666] vhba: module verification failed: signature and/or required =
key missing - tainting kernel
[    3.241098] systemd[1]: Finished Virtual Console Setup.
[    3.243097] scsi host6: vhba
[    3.243110] RPC: Registered named UNIX socket transport module.
[    3.243112] RPC: Registered udp transport module.
[    3.243112] RPC: Registered tcp transport module.
[    3.243113] RPC: Registered tcp-with-tls transport module.
[    3.243114] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    3.243246] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    3.244838] systemd[1]: Finished Load/Save OS Random Seed.
[    3.248243] systemd[1]: Started Userspace Out-Of-Memory (OOM) Killer.
[    3.252648] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    3.252672] sd 4:0:0:0: Attached scsi generic sg1 type 0
[    3.258537] i2c_dev: i2c /dev entries driver
[    3.260227] systemd[1]: Finished Load Kernel Modules.
[    3.260906] systemd[1]: Starting Apply Kernel Variables...
[    3.271683] systemd[1]: Started Journal Service.
[    3.287906] systemd-journald[341]: Received client request to flush runt=
ime journal.
[    3.488518] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    3.494257] zram0: detected capacity change from 0 to 32491520
[    3.513011] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    3.519109] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: 8F1F6436-9F42-4=
2C8-BADC-0E9424F20C9A has zero instances
[    3.519112] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: 8F1F6435-9F42-4=
2C8-BADC-0E9424F20C9A has zero instances
[    3.519113] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: 7391A661-223A-4=
7DB-A77A-7BE84C60822D has zero instances
[    3.519113] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: DF4E63B6-3BBC-4=
858-9737-C74F82F821F3 has zero instances
[    3.523262] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    3.530085] mmc0: SDHCI controller on PCI [0000:00:14.5] using ADMA 64-b=
it
[    3.579804] raid6: skipped pq benchmark and selected avx2x4
[    3.579808] raid6: using avx2x2 recovery algorithm
[    3.579848] EDAC ie31200: No ECC support
[    3.579879] EDAC ie31200: No ECC support
[    3.580232] intel_pch_thermal 0000:00:12.0: enabling device (0100 -> 010=
2)
[    3.581038] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[    3.583218] xor: automatically using best checksumming function   avx   =
   =20
[    3.587905] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    3.588015] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db1=
8c600'
[    3.589075] intel_pmc_core INT33A1:00:  initialized
[    3.593003] platform regulatory.0: Direct firmware load for regulatory.d=
b failed with error -2
[    3.593007] cfg80211: failed to load regulatory.db
[    3.596573] intel-lpss 0000:00:15.0: enabling device (0100 -> 0102)
[    3.598518] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    3.603284] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    3.610126] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    3.610171] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    3.612561] input: PC Speaker as /devices/platform/pcspkr/input/input6
[    3.613354] i2c i2c-1: Successfully instantiated SPD at 0x50
[    3.624309] intel-lpss 0000:00:15.1: enabling device (0100 -> 0102)
[    3.624533] idma64 idma64.1: Found Intel integrated DMA 64-bit
[    3.632571] Adding 16245756k swap on /dev/zram0.  Priority:100 extents:1=
 across:16245756k SSDsc
[    3.633961] intel-lpss 0000:00:1e.0: enabling device (0100 -> 0102)
[    3.634777] idma64 idma64.2: Found Intel integrated DMA 64-bit
[    3.763011] Creating 1 MTD partitions on "0000:00:1f.5":
[    3.763015] 0x000000000000-0x000001000000 : "BIOS"
[    3.766225] Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
[    3.815026] iTCO_vendor_support: vendor-support=3D0
[    3.815233] r8169 0000:04:00.0: can't disable ASPM; OS doesn't have ASPM=
 control
[    3.815982] Bluetooth: Core ver 2.22
[    3.815999] NET: Registered PF_BLUETOOTH protocol family
[    3.816000] Bluetooth: HCI device and connection manager initialized
[    3.816002] Bluetooth: HCI socket layer initialized
[    3.816004] Bluetooth: L2CAP socket layer initialized
[    3.816007] Bluetooth: SCO socket layer initialized
[    3.819180] ee1004 1-0050: 512 byte EE1004-compliant SPD EEPROM, read-on=
ly
[    3.821161] dw-apb-uart.2: ttyS4 at MMIO 0xa091e000 (irq =3D 20, base_ba=
ud =3D 7500000) is a 16550A
[    3.826222] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=3D6=
, TCOBASE=3D0x0400)
[    3.826349] iTCO_wdt iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=
=3D0)
[    3.827275] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360=
 ms ovfl timer
[    3.827277] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    3.827278] RAPL PMU: hw unit of domain package 2^-14 Joules
[    3.827279] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    3.830604] input: HP WMI hotkeys as /devices/virtual/input/input7
[    3.831224] cryptd: max_cpu_qlen set to 1000
[    3.838121] r8169 0000:04:00.0 eth0: RTL8168h/8111h, 9c:7b:ef:30:a7:6b, =
XID 541, IRQ 146
[    3.838125] r8169 0000:04:00.0 eth0: jumbo features [frames: 9194 bytes,=
 tx checksumming: ko]
[    3.839882] rtw_8821ce 0000:05:00.0: enabling device (0100 -> 0103)
[    3.842453] rtw_8821ce 0000:05:00.0: Firmware version 24.11.0, H2C versi=
on 12
[    3.842923] r8169 0000:04:00.0 enp4s0: renamed from eth0
[    3.844951] snd_hda_intel 0000:00:1f.3: enabling device (0100 -> 0102)
[    3.845384] snd_hda_intel 0000:03:00.1: enabling device (0100 -> 0102)
[    3.845483] snd_hda_intel 0000:03:00.1: Force to non-snoop mode
[    3.845712] AES CTR mode by8 optimization enabled
[    3.847259] usbcore: registered new interface driver btusb
[    3.853028] Bluetooth: hci0: RTL: examining hci_ver=3D08 hci_rev=3D000c =
lmp_ver=3D08 lmp_subver=3D8821
[    3.854020] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
[    3.854023] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_fw.bin
[    3.854917] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_config.bin
[    3.855071] Bluetooth: hci0: RTL: cfg_sz 10, total sz 34926
[    3.865620] input: HDA ATI HDMI HDMI/DP,pcm=3D3 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input8
[    3.865767] input: HDA ATI HDMI HDMI/DP,pcm=3D7 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input9
[    3.866048] input: HDA ATI HDMI HDMI/DP,pcm=3D8 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input10
[    3.866108] input: HDA ATI HDMI HDMI/DP,pcm=3D9 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input11
[    3.866572] input: HDA ATI HDMI HDMI/DP,pcm=3D10 as /devices/pci0000:00/=
0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input12
[    3.875165] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC671: li=
ne_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:line
[    3.875169] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[    3.875171] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0x21/0x0/=
0x0/0x0/0x0)
[    3.875172] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0
[    3.875173] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    3.875174] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=3D0x18
[    3.875175] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=3D0x19
[    3.875176] snd_hda_codec_realtek hdaudioC0D0:      Line=3D0x1b
[    3.889243] input: HDA Intel PCH Rear Mic as /devices/pci0000:00/0000:00=
:1f.3/sound/card0/input13
[    3.889276] input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:0=
0:1f.3/sound/card0/input14
[    3.889301] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1f.=
3/sound/card0/input15
[    3.889327] input: HDA Intel PCH Line Out as /devices/pci0000:00/0000:00=
:1f.3/sound/card0/input16
[    3.889362] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input17
[    3.898411] rtw_8821ce 0000:05:00.0 wlp5s0: renamed from wlan0
[    4.326132] Bluetooth: hci0: RTL: fw version 0x75b8f098
[    4.365470] BTRFS: device label DATA devid 1 transid 20282 /dev/sda1 (8:=
1) scanned by mount (599)
[    4.366564] BTRFS info (device sda1): first mount of filesystem 0f1ef58b=
-496b-48fd-a17b-6cbc03a2c8ee
[    4.366590] BTRFS info (device sda1): using crc32c (crc32c-intel) checks=
um algorithm
[    4.366593] BTRFS info (device sda1): using free-space-tree
[    6.333674] intel_tcc_cooling: Programmable TCC Offset detected
[    6.339394] [drm] amdgpu kernel modesetting enabled.
[    6.339557] amdgpu: Virtual CRAT table created for CPU
[    6.339565] amdgpu: Topology: Add CPU node
[    6.339646] amdgpu 0000:03:00.0: enabling device (0106 -> 0107)
[    6.339722] [drm] initializing kernel modesetting (DIMGREY_CAVEFISH 0x10=
02:0x73FF 0x1043:0x05D5 0xC7).
[    6.339731] [drm] register mmio base: 0xA0300000
[    6.339732] [drm] register mmio size: 1048576
[    6.342893] [drm] add ip block number 0 <nv_common>
[    6.342895] [drm] add ip block number 1 <gmc_v10_0>
[    6.342896] [drm] add ip block number 2 <navi10_ih>
[    6.342896] [drm] add ip block number 3 <psp>
[    6.342897] [drm] add ip block number 4 <smu>
[    6.342898] [drm] add ip block number 5 <dm>
[    6.342899] [drm] add ip block number 6 <gfx_v10_0>
[    6.342900] [drm] add ip block number 7 <sdma_v5_2>
[    6.342900] [drm] add ip block number 8 <vcn_v3_0>
[    6.342901] [drm] add ip block number 9 <jpeg_v3_0>
[    6.342913] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from VFCT
[    6.342915] amdgpu: ATOM BIOS: 115-D534P00-100
[    6.406437] Console: switching to colour dummy device 80x25
[    6.420070] intel_rapl_common: Found RAPL domain package
[    6.420072] intel_rapl_common: Found RAPL domain core
[    6.420073] intel_rapl_common: Found RAPL domain dram
[    6.423630] amdgpu 0000:03:00.0: vgaarb: deactivate vga console
[    6.423634] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (TMZ) featu=
re disabled as experimental (default)
[    6.423667] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, f=
ragment size is 9-bit
[    6.423674] amdgpu 0000:03:00.0: amdgpu: VRAM: 8176M 0x0000008000000000 =
- 0x00000081FEFFFFFF (8176M used)
[    6.423676] amdgpu 0000:03:00.0: amdgpu: GART: 512M 0x0000000000000000 -=
 0x000000001FFFFFFF
[    6.423688] [drm] Detected VRAM RAM=3D8176M, BAR=3D256M
[    6.423689] [drm] RAM width 128bits GDDR6
[    6.423816] [drm] amdgpu: 8176M of VRAM memory ready
[    6.423818] [drm] amdgpu: 7932M of GTT memory ready.
[    6.423831] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    6.423912] [drm] PCIE GART of 512M enabled (table at 0x0000008002000000=
).
[    7.986162] amdgpu 0000:03:00.0: amdgpu: STB initialized to 2048 entries
[    7.986339] [drm] Loading DMUB firmware via PSP: version=3D0x02020020
[    7.986699] [drm] use_doorbell being set to: [true]
[    7.986710] [drm] use_doorbell being set to: [true]
[    7.986719] [drm] Found VCN firmware Version ENC: 1.33 DEC: 4 VEP: 0 Rev=
ision: 3
[    8.053385] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000=
000 for PSP TMR
[    8.157081] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is n=
ot available
[    8.174313] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta=
 ucode is not available
[    8.174338] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x000=
0000f, smu fw if version =3D 0x00000013, smu fw program =3D 0, version =3D =
0x003b3100 (59.49.0)
[    8.174347] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not match=
ed
[    8.174381] amdgpu 0000:03:00.0: amdgpu: use vbios provided pptable
[    8.220827] amdgpu 0000:03:00.0: amdgpu: SMU is initialized successfully!
[    8.221141] [drm] Display Core v3.2.301 initialized on DCN 3.0.2
[    8.221142] [drm] DP-HDMI FRL PCON supported
[    8.222283] [drm] DMUB hardware initialized: version=3D0x02020020
[    8.225346] snd_hda_intel 0000:03:00.1: bound 0000:03:00.0 (ops amdgpu_d=
m_audio_component_bind_ops [amdgpu])
[    8.673158] [drm] kiq ring mec 2 pipe 1 q 0
[    8.736016] amdgpu: HMM registered 8176MB device memory
[    8.737632] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    8.737644] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    8.737850] amdgpu: Virtual CRAT table created for GPU
[    8.737973] amdgpu: Topology: Add dGPU node [0x73ff:0x1002]
[    8.737975] kfd kfd: amdgpu: added device 1002:73ff
[    8.737993] amdgpu 0000:03:00.0: amdgpu: SE 2, SH per SE 2, CU per SH 8,=
 active_cu_number 28
[    8.737996] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng =
0 on hub 0
[    8.737998] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng =
1 on hub 0
[    8.737999] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 4 on hub 0
[    8.738000] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 5 on hub 0
[    8.738001] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 6 on hub 0
[    8.738002] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 7 on hub 0
[    8.738003] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 8 on hub 0
[    8.738004] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 9 on hub 0
[    8.738005] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 10 on hub 0
[    8.738006] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 11 on hub 0
[    8.738007] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv en=
g 12 on hub 0
[    8.738008] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 o=
n hub 0
[    8.738009] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 o=
n hub 0
[    8.738010] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng =
0 on hub 8
[    8.738011] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv en=
g 1 on hub 8
[    8.738012] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv en=
g 4 on hub 8
[    8.738013] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5=
 on hub 8
[    8.739600] amdgpu 0000:03:00.0: amdgpu: Using BACO for runtime pm
[    8.740472] [drm] Initialized amdgpu 3.59.0 for 0000:03:00.0 on minor 1
[    8.746473] fbcon: amdgpudrmfb (fb0) is primary device
[    8.746758] [drm] pre_validate_dsc:1589 MST_DSC dsc precompute is not ne=
eded
[    9.038219] Console: switching to colour frame buffer device 240x67
[    9.056967] amdgpu 0000:03:00.0: [drm] fb0: amdgpudrmfb frame buffer dev=
ice
[    9.263381] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    9.263384] Bluetooth: BNEP filters: protocol multicast
[    9.263386] Bluetooth: BNEP socket layer initialized
[    9.264547] Bluetooth: MGMT ver 1.23
[    9.269594] NET: Registered PF_ALG protocol family
[    9.499589] Generic FE-GE Realtek PHY r8169-0-400:00: attached PHY drive=
r (mii_bus:phy_addr=3Dr8169-0-400:00, irq=3DMAC)
[    9.564572] block nvme0n1: No UUID available providing old NGUID
[    9.679667] r8169 0000:04:00.0 enp4s0: Link is Down
[   10.355410] bridge: filtering via arp/ip/ip6tables is no longer availabl=
e by default. Update your scripts to load br_netfilter if you need this.
[   10.487113] u32 classifier
[   10.487115]     Performance counters on
[   10.487115]     input device check on
[   10.487116]     Actions configured
[   12.726863] r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[   12.729556] r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[   15.152222] RPC: Registered rdma transport module.
[   15.152225] RPC: Registered rdma backchannel transport module.
[   15.264146] NFSD: Using nfsdcld client tracking operations.
[   15.264149] NFSD: no clients to reclaim, skipping NFSv4 grace period (ne=
t f0000000)
[   15.637004] Initializing XFRM netlink socket
[   15.737421] warning: `pmdalinux' uses wireless extensions which will sto=
p working for Wi-Fi 7 hardware; use nl80211

--gttcyfelaltvdnuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-working.log"
Content-Transfer-Encoding: quoted-printable

[    0.000000] microcode: updated early: 0xfa -> 0x100, date =3D 2024-02-05
[    0.000000] Linux version 6.6.69-1-lts (linux-lts@archlinux) (gcc (GCC) =
14.2.1 20240910, GNU ld (GNU Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Thu, =
02 Jan 2025 22:00:49 +0000
[    0.000000] Command line: initrd=3D\intel-ucode.img initrd=3D\initramfs-=
linux-lts.img root=3D/dev/nvme0n1p1 rw intel_iommu=3Don
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
[    0.000000] e820: update [mem 0x7c005018-0x7c023457] usable =3D=3D> usab=
le
[    0.000000] e820: update [mem 0x7c005018-0x7c023457] usable =3D=3D> usab=
le
[    0.000000] e820: update [mem 0x7bff6018-0x7c004057] usable =3D=3D> usab=
le
[    0.000000] e820: update [mem 0x7bff6018-0x7c004057] usable =3D=3D> usab=
le
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ef=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000000009f000-0x00000000000fff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000007bff60=
17] usable
[    0.000000] reserve setup_data: [mem 0x000000007bff6018-0x000000007c0040=
57] usable
[    0.000000] reserve setup_data: [mem 0x000000007c004058-0x000000007c0050=
17] usable
[    0.000000] reserve setup_data: [mem 0x000000007c005018-0x000000007c0234=
57] usable
[    0.000000] reserve setup_data: [mem 0x000000007c023458-0x000000008a26ff=
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
[    0.000000] tsc: Detected 3000.000 MHz processor
[    0.000922] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000925] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000933] last_pfn =3D 0x46e000 max_arch_pfn =3D 0x400000000
[    0.000937] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built fr=
om 10 variable MTRRs
[    0.000939] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.001217] last_pfn =3D 0x8dc0f max_arch_pfn =3D 0x400000000
[    0.008531] esrt: Reserving ESRT space from 0x0000000088b80398 to 0x0000=
000088b80420.
[    0.008536] e820: update [mem 0x88b80000-0x88b80fff] usable =3D=3D> rese=
rved
[    0.008552] Using GB pages for direct mapping
[    0.009083] Secure boot disabled
[    0.009083] RAMDISK: [mem 0x7c024000-0x7d4dcfff]
[    0.009106] ACPI: Early table checksum verification disabled
[    0.009108] ACPI: RSDP 0x000000008A6BE000 000024 (v02 HPQOEM)
[    0.009112] ACPI: XSDT 0x000000008A6BE0C0 0000FC (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009117] ACPI: FACP 0x000000008A704DC8 000114 (v06 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009122] ACPI: DSDT 0x000000008A6BE248 046B7A (v02 HPQOEM SLIC-CPC 01=
072009 INTL 20160527)
[    0.009125] ACPI: FACS 0x000000008AB93080 000040
[    0.009128] ACPI: APIC 0x000000008A704EE0 0000BC (v04 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009130] ACPI: FPDT 0x000000008A704FA0 000044 (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009133] ACPI: FIDT 0x000000008A704FE8 00009C (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009136] ACPI: MCFG 0x000000008A705088 00003C (v01 HPQOEM SLIC-CPC 01=
072009 MSFT 00000097)
[    0.009139] ACPI: SSDT 0x000000008A7050C8 001B5F (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.009142] ACPI: MSDM 0x000000008A706C28 000055 (v03 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009145] ACPI: SSDT 0x000000008A706C80 000060 (v01 HPQOEM SLIC-CPC 00=
000001 INTL 20160527)
[    0.009148] ACPI: SSDT 0x000000008A706CE0 000060 (v01 HPQOEM SLIC-CPC 00=
000001 INTL 20160527)
[    0.009150] ACPI: SSDT 0x000000008A706D40 0031C6 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.009153] ACPI: SSDT 0x000000008A709F08 00241B (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009156] ACPI: HPET 0x000000008A70C328 000038 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009159] ACPI: SSDT 0x000000008A70C360 001D39 (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009161] ACPI: SSDT 0x000000008A70E0A0 000FAE (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009164] ACPI: SSDT 0x000000008A70F050 000BDF (v02 HPQOEM SLIC-CPC 00=
000000 INTL 20160527)
[    0.009167] ACPI: UEFI 0x000000008A70FC30 000042 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009170] ACPI: LPIT 0x000000008A70FC78 000094 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009172] ACPI: SSDT 0x000000008A70FD10 0027DE (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009175] ACPI: SSDT 0x000000008A7124F0 0014E2 (v02 HPQOEM SLIC-CPC 00=
000000 INTL 20160527)
[    0.009178] ACPI: DBGP 0x000000008A7139D8 000034 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009181] ACPI: DBG2 0x000000008A713A10 000054 (v00 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009183] ACPI: SSDT 0x000000008A713A68 001B67 (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009186] ACPI: DMAR 0x000000008A7155D0 000070 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009189] ACPI: VFCT 0x000000008A715640 00B284 (v01 HPQOEM SLIC-CPC 00=
000001 AMD  31504F47)
[    0.009192] ACPI: BGRT 0x000000008A7208C8 000038 (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009194] ACPI: TPM2 0x000000008A720900 000034 (v04 HPQOEM SLIC-CPC 00=
000001 AMI  00000000)
[    0.009197] ACPI: WSMT 0x000000008A720938 000028 (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009199] ACPI: Reserving FACP table memory at [mem 0x8a704dc8-0x8a704=
edb]
[    0.009201] ACPI: Reserving DSDT table memory at [mem 0x8a6be248-0x8a704=
dc1]
[    0.009202] ACPI: Reserving FACS table memory at [mem 0x8ab93080-0x8ab93=
0bf]
[    0.009203] ACPI: Reserving APIC table memory at [mem 0x8a704ee0-0x8a704=
f9b]
[    0.009203] ACPI: Reserving FPDT table memory at [mem 0x8a704fa0-0x8a704=
fe3]
[    0.009204] ACPI: Reserving FIDT table memory at [mem 0x8a704fe8-0x8a705=
083]
[    0.009205] ACPI: Reserving MCFG table memory at [mem 0x8a705088-0x8a705=
0c3]
[    0.009206] ACPI: Reserving SSDT table memory at [mem 0x8a7050c8-0x8a706=
c26]
[    0.009206] ACPI: Reserving MSDM table memory at [mem 0x8a706c28-0x8a706=
c7c]
[    0.009207] ACPI: Reserving SSDT table memory at [mem 0x8a706c80-0x8a706=
cdf]
[    0.009208] ACPI: Reserving SSDT table memory at [mem 0x8a706ce0-0x8a706=
d3f]
[    0.009209] ACPI: Reserving SSDT table memory at [mem 0x8a706d40-0x8a709=
f05]
[    0.009209] ACPI: Reserving SSDT table memory at [mem 0x8a709f08-0x8a70c=
322]
[    0.009210] ACPI: Reserving HPET table memory at [mem 0x8a70c328-0x8a70c=
35f]
[    0.009211] ACPI: Reserving SSDT table memory at [mem 0x8a70c360-0x8a70e=
098]
[    0.009212] ACPI: Reserving SSDT table memory at [mem 0x8a70e0a0-0x8a70f=
04d]
[    0.009213] ACPI: Reserving SSDT table memory at [mem 0x8a70f050-0x8a70f=
c2e]
[    0.009213] ACPI: Reserving UEFI table memory at [mem 0x8a70fc30-0x8a70f=
c71]
[    0.009214] ACPI: Reserving LPIT table memory at [mem 0x8a70fc78-0x8a70f=
d0b]
[    0.009215] ACPI: Reserving SSDT table memory at [mem 0x8a70fd10-0x8a712=
4ed]
[    0.009216] ACPI: Reserving SSDT table memory at [mem 0x8a7124f0-0x8a713=
9d1]
[    0.009216] ACPI: Reserving DBGP table memory at [mem 0x8a7139d8-0x8a713=
a0b]
[    0.009217] ACPI: Reserving DBG2 table memory at [mem 0x8a713a10-0x8a713=
a63]
[    0.009218] ACPI: Reserving SSDT table memory at [mem 0x8a713a68-0x8a715=
5ce]
[    0.009219] ACPI: Reserving DMAR table memory at [mem 0x8a7155d0-0x8a715=
63f]
[    0.009219] ACPI: Reserving VFCT table memory at [mem 0x8a715640-0x8a720=
8c3]
[    0.009220] ACPI: Reserving BGRT table memory at [mem 0x8a7208c8-0x8a720=
8ff]
[    0.009221] ACPI: Reserving TPM2 table memory at [mem 0x8a720900-0x8a720=
933]
[    0.009222] ACPI: Reserving WSMT table memory at [mem 0x8a720938-0x8a720=
95f]
[    0.009541] No NUMA configuration found
[    0.009542] Faking a node at [mem 0x0000000000000000-0x000000046dffffff]
[    0.009545] NODE_DATA(0) allocated [mem 0x46dffb000-0x46dffffff]
[    0.009575] Zone ranges:
[    0.009575]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.009577]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.009579]   Normal   [mem 0x0000000100000000-0x000000046dffffff]
[    0.009580]   Device   empty
[    0.009581] Movable zone start for each node
[    0.009582] Early memory node ranges
[    0.009582]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.009584]   node   0: [mem 0x0000000000100000-0x000000008a26ffff]
[    0.009585]   node   0: [mem 0x000000008dc0e000-0x000000008dc0efff]
[    0.009586]   node   0: [mem 0x0000000100000000-0x000000046dffffff]
[    0.009588] Initmem setup node 0 [mem 0x0000000000001000-0x000000046dfff=
fff]
[    0.009592] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.009611] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.012335] On node 0, zone DMA32: 14750 pages in unavailable ranges
[    0.029193] On node 0, zone Normal: 9201 pages in unavailable ranges
[    0.029273] On node 0, zone Normal: 8192 pages in unavailable ranges
[    0.030265] ACPI: PM-Timer IO Port: 0x1808
[    0.030270] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.030272] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.030273] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.030273] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.030274] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.030275] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.030275] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.030276] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.030339] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.030341] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.030343] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.030347] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.030348] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.030354] e820: update [mem 0x86b6d000-0x86bdffff] usable =3D=3D> rese=
rved
[    0.030366] TSC deadline timer available
[    0.030367] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.030379] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.030381] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0=
x000fffff]
[    0.030383] PM: hibernation: Registered nosave memory: [mem 0x7bff6000-0=
x7bff6fff]
[    0.030385] PM: hibernation: Registered nosave memory: [mem 0x7c004000-0=
x7c004fff]
[    0.030385] PM: hibernation: Registered nosave memory: [mem 0x7c005000-0=
x7c005fff]
[    0.030387] PM: hibernation: Registered nosave memory: [mem 0x7c023000-0=
x7c023fff]
[    0.030388] PM: hibernation: Registered nosave memory: [mem 0x86b6d000-0=
x86bdffff]
[    0.030390] PM: hibernation: Registered nosave memory: [mem 0x88b80000-0=
x88b80fff]
[    0.030391] PM: hibernation: Registered nosave memory: [mem 0x8a270000-0=
x8a6a4fff]
[    0.030392] PM: hibernation: Registered nosave memory: [mem 0x8a6a5000-0=
x8a721fff]
[    0.030393] PM: hibernation: Registered nosave memory: [mem 0x8a722000-0=
x8ab95fff]
[    0.030393] PM: hibernation: Registered nosave memory: [mem 0x8ab96000-0=
x8dc0dfff]
[    0.030395] PM: hibernation: Registered nosave memory: [mem 0x8dc0f000-0=
x8fffffff]
[    0.030395] PM: hibernation: Registered nosave memory: [mem 0x90000000-0=
xfdffffff]
[    0.030396] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0=
xfe010fff]
[    0.030397] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0=
xfebfffff]
[    0.030397] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0=
xfec00fff]
[    0.030398] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0=
xfecfffff]
[    0.030399] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0=
xfed03fff]
[    0.030399] PM: hibernation: Registered nosave memory: [mem 0xfed04000-0=
xfedfffff]
[    0.030400] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0=
xfee00fff]
[    0.030401] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0=
xffffffff]
[    0.030402] [mem 0x90000000-0xfdffffff] available for PCI devices
[    0.030403] Booting paravirtualized kernel on bare hardware
[    0.030405] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 6370452778343963 ns
[    0.036620] setup_percpu: NR_CPUS:320 nr_cpumask_bits:8 nr_cpu_ids:8 nr_=
node_ids:1
[    0.036913] percpu: Embedded 64 pages/cpu s225280 r8192 d28672 u262144
[    0.036919] pcpu-alloc: s225280 r8192 d28672 u262144 alloc=3D1*2097152
[    0.036922] pcpu-alloc: [0] 0 1 2 3 4 5 6 7=20
[    0.036939] Kernel command line: initrd=3D\intel-ucode.img initrd=3D\ini=
tramfs-linux-lts.img root=3D/dev/nvme0n1p1 rw intel_iommu=3Don
[    0.036994] DMAR: IOMMU enabled
[    0.038206] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes, linear)
[    0.038827] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes, linear)
[    0.038899] Fallback order for Node 0: 0=20
[    0.038902] Built 1 zonelists, mobility grouping on.  Total pages: 40968=
71
[    0.038903] Policy zone: Normal
[    0.039070] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.039076] software IO TLB: area num 8.
[    0.078900] Memory: 16176052K/16648252K available (18432K kernel code, 2=
150K rwdata, 13100K rodata, 3444K init, 3628K bss, 471944K reserved, 0K cma=
-reserved)
[    0.079135] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D8, N=
odes=3D1
[    0.079158] ftrace: allocating 49264 entries in 193 pages
[    0.087057] ftrace: allocated 193 pages with 3 groups
[    0.087649] Dynamic Preempt: voluntary
[    0.087691] rcu: Preemptible hierarchical RCU implementation.
[    0.087692] rcu: 	RCU restricting CPUs from NR_CPUS=3D320 to nr_cpu_ids=
=3D8.
[    0.087693] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.087694] 	Trampoline variant of Tasks RCU enabled.
[    0.087694] 	Rude variant of Tasks RCU enabled.
[    0.087695] 	Tracing variant of Tasks RCU enabled.
[    0.087695] rcu: RCU calculated value of scheduler-enlistment delay is 3=
0 jiffies.
[    0.087696] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D8
[    0.091015] NR_IRQS: 20736, nr_irqs: 2048, preallocated irqs: 16
[    0.091297] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.091698] kfence: initialized - using 2097152 bytes for 255 objects at=
 0x(____ptrval____)-0x(____ptrval____)
[    0.091727] Console: colour dummy device 80x25
[    0.091730] printk: console [tty0] enabled
[    0.091777] ACPI: Core revision 20230628
[    0.092022] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.092023] APIC: Switch to symmetric I/O mode setup
[    0.092025] DMAR: Host address width 39
[    0.092026] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.092032] DMAR: dmar0: reg_base_addr fed91000 ver 1:0 cap d2008c406604=
62 ecap f050da
[    0.092034] DMAR: RMRR base: 0x0000008b72e000 end: 0x0000008b977fff
[    0.092037] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 0
[    0.092038] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.092039] DMAR-IR: Queued invalidation will be enabled to support x2ap=
ic and Intr-remapping.
[    0.095083] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.095085] x2apic enabled
[    0.095154] APIC: Switched APIC routing to: cluster x2apic
[    0.104302] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x2b3e459bf4c, max_idle_ns: 440795289890 ns
[    0.104307] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 6002.00 BogoMIPS (lpj=3D10000000)
[    0.104327] x86/cpu: SGX disabled by BIOS.
[    0.104334] CPU0: Thermal monitoring enabled (TM1)
[    0.104385] process: using mwait in idle threads
[    0.104387] Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
[    0.104388] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.104392] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.104394] Spectre V2 : Spectre BHI mitigation: SW BHB clearing on vm e=
xit
[    0.104394] Spectre V2 : Spectre BHI mitigation: SW BHB clearing on sysc=
all
[    0.104395] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.104396] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.104396] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL =
on VMEXIT
[    0.104397] RETBleed: Mitigation: Enhanced IBRS
[    0.104398] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.104400] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl
[    0.104405] TAA: Mitigation: TSX disabled
[    0.104405] MMIO Stale Data: Mitigation: Clear CPU buffers
[    0.104408] SRBDS: Mitigation: Microcode
[    0.104413] GDS: Mitigation: Microcode
[    0.104418] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.104419] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.104420] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.104420] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registe=
rs'
[    0.104421] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.104422] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.104424] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.104425] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.104426] x86/fpu: Enabled xstate features 0x1f, context size is 960 b=
ytes, using 'compacted' format.
[    0.107638] Freeing SMP alternatives memory: 40K
[    0.107638] pid_max: default: 32768 minimum: 301
[    0.107638] LSM: initializing lsm=3Dcapability,landlock,lockdown,yama,bp=
f,integrity
[    0.107638] landlock: Up and running.
[    0.107638] Yama: becoming mindful.
[    0.107638] LSM support for eBPF active
[    0.107638] Mount-cache hash table entries: 32768 (order: 6, 262144 byte=
s, linear)
[    0.107638] Mountpoint-cache hash table entries: 32768 (order: 6, 262144=
 bytes, linear)
[    0.107638] smpboot: CPU0: Intel(R) Core(TM) i7-9700F CPU @ 3.00GHz (fam=
ily: 0x6, model: 0x9e, stepping: 0xd)
[    0.107638] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjus=
t=3D1 rcu_task_cpu_ids=3D8.
[    0.107638] RCU Tasks Rude: Setting shift to 3 and lim to 1 rcu_task_cb_=
adjust=3D1 rcu_task_cpu_ids=3D8.
[    0.107638] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb=
_adjust=3D1 rcu_task_cpu_ids=3D8.
[    0.107638] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR,=
 full-width counters, Intel PMU driver.
[    0.107638] ... version:                4
[    0.107638] ... bit width:              48
[    0.107638] ... generic registers:      8
[    0.107638] ... value mask:             0000ffffffffffff
[    0.107638] ... max period:             00007fffffffffff
[    0.107638] ... fixed-purpose events:   3
[    0.107638] ... event mask:             00000007000000ff
[    0.107638] signal: max sigframe size: 2032
[    0.107638] Estimated ratio of average max frequency by base frequency (=
times 1024): 1570
[    0.107638] rcu: Hierarchical SRCU implementation.
[    0.107638] rcu: 	Max phase no-delay instances is 1000.
[    0.107638] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.107638] smp: Bringing up secondary CPUs ...
[    0.107638] smpboot: x86: Booting SMP configuration:
[    0.107638] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.111015] smp: Brought up 1 node, 8 CPUs
[    0.111015] smpboot: Max logical packages: 1
[    0.111015] smpboot: Total of 8 processors activated (48019.00 BogoMIPS)
[    0.114341] devtmpfs: initialized
[    0.114348] x86/mm: Memory block size: 128MB
[    0.115343] ACPI: PM: Registering ACPI NVS region [mem 0x8a722000-0x8ab9=
5fff] (4669440 bytes)
[    0.115343] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 6370867519511994 ns
[    0.115343] futex hash table entries: 2048 (order: 5, 131072 bytes, line=
ar)
[    0.115343] pinctrl core: initialized pinctrl subsystem
[    0.115343] PM: RTC time: 18:19:42, date: 2025-01-05
[    0.115343] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.115426] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.115538] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.115651] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.115664] audit: initializing netlink subsys (disabled)
[    0.115713] audit: type=3D2000 audit(1736101182.009:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.115713] thermal_sys: Registered thermal governor 'fair_share'
[    0.115713] thermal_sys: Registered thermal governor 'bang_bang'
[    0.115713] thermal_sys: Registered thermal governor 'step_wise'
[    0.115713] thermal_sys: Registered thermal governor 'user_space'
[    0.115713] thermal_sys: Registered thermal governor 'power_allocator'
[    0.115713] cpuidle: using governor ladder
[    0.115713] cpuidle: using governor menu
[    0.115713] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    0.115713] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.115713] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    0.115713] PCI: Using configuration type 1 for base access
[    0.115713] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.115713] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.121007] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.121007] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.121007] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.121007] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.121052] fbcon: Taking over console
[    0.121066] ACPI: Added _OSI(Module Device)
[    0.121067] ACPI: Added _OSI(Processor Device)
[    0.121067] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.121068] ACPI: Added _OSI(Processor Aggregator Device)
[    0.176642] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    0.184324] ACPI: Dynamic OEM Table Load:
[    0.184331] ACPI: SSDT 0xFFFF888100CB3000 000400 (v02 HPQOEM SLIC-CPC 00=
003001 INTL 20160527)
[    0.185346] ACPI: Dynamic OEM Table Load:
[    0.185351] ACPI: SSDT 0xFFFF888100CC7800 000605 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.186401] ACPI: Dynamic OEM Table Load:
[    0.186405] ACPI: SSDT 0xFFFF888100CDD700 0000F4 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.187359] ACPI: Dynamic OEM Table Load:
[    0.187363] ACPI: SSDT 0xFFFF88810189BA00 000149 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.188272] ACPI: Dynamic OEM Table Load:
[    0.188276] ACPI: SSDT 0xFFFF888100CC4800 000724 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.189421] ACPI: Dynamic OEM Table Load:
[    0.189426] ACPI: SSDT 0xFFFF888100CC1000 0005FC (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.190494] ACPI: Dynamic OEM Table Load:
[    0.190498] ACPI: SSDT 0xFFFF888100CB0400 000317 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.191571] ACPI: Dynamic OEM Table Load:
[    0.191576] ACPI: SSDT 0xFFFF888100CBC000 000AB0 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.193172] ACPI: Dynamic OEM Table Load:
[    0.193176] ACPI: SSDT 0xFFFF888100CB4400 00030A (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.197274] ACPI: _OSC evaluated successfully for all CPUs
[    0.197535] ACPI: EC: EC started
[    0.197536] ACPI: EC: interrupt blocked
[    0.198135] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.198138] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle tran=
sactions
[    0.198139] ACPI: Interpreter enabled
[    0.198176] ACPI: PM: (supports S0 S3 S4 S5)
[    0.198177] ACPI: Using IOAPIC for interrupt routing
[    0.199396] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.199397] PCI: Ignoring E820 reservations for host bridge windows
[    0.200623] ACPI: Enabled 10 GPEs in block 00 to 7F
[    0.215943] ACPI: \_SB_.PCI0.XDCI.USBC: New power resource
[    0.216100] ACPI: \_SB_.PCI0.PAUD: New power resource
[    0.218735] ACPI: \SPR2: New power resource
[    0.218914] ACPI: \SPR3: New power resource
[    0.219236] ACPI: \ZPDR: New power resource
[    0.219483] ACPI: \_SB_.PCI0.SAT0.VOL0.V0PR: New power resource
[    0.219691] ACPI: \_SB_.PCI0.SAT0.VOL1.V1PR: New power resource
[    0.219892] ACPI: \_SB_.PCI0.SAT0.VOL2.V2PR: New power resource
[    0.222474] ACPI: \_SB_.PCI0.I2C1.PXTC: New power resource
[    0.225814] ACPI: \_SB_.PCI0.CNVW.WRST: New power resource
[    0.228937] ACPI: \_TZ_.FN00: New power resource
[    0.229005] ACPI: \_TZ_.FN01: New power resource
[    0.229071] ACPI: \_TZ_.FN02: New power resource
[    0.229141] ACPI: \_TZ_.FN03: New power resource
[    0.229205] ACPI: \_TZ_.FN04: New power resource
[    0.229669] ACPI: \PIN_: New power resource
[    0.229827] ACPI: \SPR0: New power resource
[    0.229884] ACPI: \SPR1: New power resource
[    0.229942] ACPI: \SPR5: New power resource
[    0.230497] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.230504] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI EDR HPX-Type3]
[    0.233762] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME AER PCIeCapability LTR DPC]
[    0.233763] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    0.234960] PCI host bridge to bus 0000:00
[    0.234962] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.234964] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.234966] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.234968] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000efff=
f window]
[    0.234969] pci_bus 0000:00: root bus resource [mem 0x90000000-0xdffffff=
f window]
[    0.234970] pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7ffff=
f window]
[    0.234972] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.235065] pci 0000:00:00.0: [8086:3e30] type 00 class 0x060000
[    0.235132] pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
[    0.235169] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.235773] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000
[    0.235781] pci 0000:00:08.0: reg 0x10: [mem 0xa0922000-0xa0922fff 64bit]
[    0.235951] pci 0000:00:12.0: [8086:a379] type 00 class 0x118000
[    0.235982] pci 0000:00:12.0: reg 0x10: [mem 0xa0921000-0xa0921fff 64bit]
[    0.236243] pci 0000:00:14.0: [8086:a36d] type 00 class 0x0c0330
[    0.236278] pci 0000:00:14.0: reg 0x10: [mem 0xa0900000-0xa090ffff 64bit]
[    0.236418] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.237054] pci 0000:00:14.2: [8086:a36f] type 00 class 0x050000
[    0.237083] pci 0000:00:14.2: reg 0x10: [mem 0xa0916000-0xa0917fff 64bit]
[    0.237102] pci 0000:00:14.2: reg 0x18: [mem 0xa0920000-0xa0920fff 64bit]
[    0.237252] pci 0000:00:14.5: [8086:a375] type 00 class 0x080501
[    0.237283] pci 0000:00:14.5: reg 0x10: [mem 0xa091f000-0xa091ffff 64bit]
[    0.238091] pci 0000:00:15.0: [8086:a368] type 00 class 0x0c8000
[    0.238665] pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[    0.241617] pci 0000:00:15.1: [8086:a369] type 00 class 0x0c8000
[    0.242192] pci 0000:00:15.1: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[    0.244800] pci 0000:00:16.0: [8086:a360] type 00 class 0x078000
[    0.244831] pci 0000:00:16.0: reg 0x10: [mem 0xa091c000-0xa091cfff 64bit]
[    0.244949] pci 0000:00:16.0: PME# supported from D3hot
[    0.245539] pci 0000:00:17.0: [8086:a352] type 00 class 0x010601
[    0.245566] pci 0000:00:17.0: reg 0x10: [mem 0xa0914000-0xa0915fff]
[    0.245581] pci 0000:00:17.0: reg 0x14: [mem 0xa091b000-0xa091b0ff]
[    0.245596] pci 0000:00:17.0: reg 0x18: [io  0x6050-0x6057]
[    0.245611] pci 0000:00:17.0: reg 0x1c: [io  0x6040-0x6043]
[    0.245626] pci 0000:00:17.0: reg 0x20: [io  0x6020-0x603f]
[    0.245641] pci 0000:00:17.0: reg 0x24: [mem 0xa091a000-0xa091a7ff]
[    0.245722] pci 0000:00:17.0: PME# supported from D3hot
[    0.246155] pci 0000:00:1c.0: [8086:a33d] type 01 class 0x060400
[    0.246351] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.246401] pci 0000:00:1c.0: PTM enabled (root), 4ns granularity
[    0.247291] pci 0000:00:1c.7: [8086:a33f] type 01 class 0x060400
[    0.247476] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
[    0.247518] pci 0000:00:1c.7: PTM enabled (root), 4ns granularity
[    0.248328] pci 0000:00:1d.0: [8086:a330] type 01 class 0x060400
[    0.248536] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.248590] pci 0000:00:1d.0: PTM enabled (root), 4ns granularity
[    0.249847] pci 0000:00:1e.0: [8086:a328] type 00 class 0x078000
[    0.250387] pci 0000:00:1e.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[    0.252976] pci 0000:00:1f.0: [8086:a304] type 00 class 0x060100
[    0.253522] pci 0000:00:1f.3: [8086:a348] type 00 class 0x040300
[    0.253581] pci 0000:00:1f.3: reg 0x10: [mem 0xa0910000-0xa0913fff 64bit]
[    0.253656] pci 0000:00:1f.3: reg 0x20: [mem 0xa0200000-0xa02fffff 64bit]
[    0.253805] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.255066] pci 0000:00:1f.4: [8086:a323] type 00 class 0x0c0500
[    0.255241] pci 0000:00:1f.4: reg 0x10: [mem 0xa0918000-0xa09180ff 64bit]
[    0.255455] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    0.255925] pci 0000:00:1f.5: [8086:a324] type 00 class 0x0c8000
[    0.255950] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
[    0.256132] pci 0000:01:00.0: [1002:1478] type 01 class 0x060400
[    0.256143] pci 0000:01:00.0: reg 0x10: [mem 0xa0500000-0xa0503fff]
[    0.256221] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.256270] pci 0000:01:00.0: 63.008 Gb/s available PCIe bandwidth, limi=
ted by 8.0 GT/s PCIe x8 link at 0000:00:01.0 (capable of 126.024 Gb/s with =
16.0 GT/s PCIe x8 link)
[    0.256358] pci 0000:00:01.0: PCI bridge to [bus 01-03]
[    0.256361] pci 0000:00:01.0:   bridge window [io  0x5000-0x5fff]
[    0.256363] pci 0000:00:01.0:   bridge window [mem 0xa0300000-0xa05fffff]
[    0.256366] pci 0000:00:01.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.256402] pci 0000:02:00.0: [1002:1479] type 01 class 0x060400
[    0.256488] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.256600] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.256604] pci 0000:01:00.0:   bridge window [io  0x5000-0x5fff]
[    0.256607] pci 0000:01:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.256611] pci 0000:01:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.256645] pci 0000:03:00.0: [1002:73ff] type 00 class 0x030000
[    0.256658] pci 0000:03:00.0: reg 0x10: [mem 0x90000000-0x9fffffff 64bit=
 pref]
[    0.256667] pci 0000:03:00.0: reg 0x18: [mem 0xa0000000-0xa01fffff 64bit=
 pref]
[    0.256673] pci 0000:03:00.0: reg 0x20: [io  0x5000-0x50ff]
[    0.256679] pci 0000:03:00.0: reg 0x24: [mem 0xa0300000-0xa03fffff]
[    0.256685] pci 0000:03:00.0: reg 0x30: [mem 0xa0400000-0xa041ffff pref]
[    0.256707] pci 0000:03:00.0: BAR 0: assigned to efifb
[    0.256753] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.256811] pci 0000:03:00.0: 63.008 Gb/s available PCIe bandwidth, limi=
ted by 8.0 GT/s PCIe x8 link at 0000:00:01.0 (capable of 252.048 Gb/s with =
16.0 GT/s PCIe x16 link)
[    0.256869] pci 0000:03:00.1: [1002:ab28] type 00 class 0x040300
[    0.256878] pci 0000:03:00.1: reg 0x10: [mem 0xa0420000-0xa0423fff]
[    0.256948] pci 0000:03:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.257029] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.257033] pci 0000:02:00.0:   bridge window [io  0x5000-0x5fff]
[    0.257035] pci 0000:02:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.257039] pci 0000:02:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.257190] pci 0000:04:00.0: [10ec:8168] type 00 class 0x020000
[    0.257217] pci 0000:04:00.0: reg 0x10: [io  0x4000-0x40ff]
[    0.257254] pci 0000:04:00.0: reg 0x18: [mem 0xa0804000-0xa0804fff 64bit]
[    0.257277] pci 0000:04:00.0: reg 0x20: [mem 0xa0800000-0xa0803fff 64bit]
[    0.257425] pci 0000:04:00.0: supports D1 D2
[    0.257426] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.257699] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    0.257704] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[    0.257709] pci 0000:00:1c.0:   bridge window [mem 0xa0800000-0xa08fffff]
[    0.257850] pci 0000:05:00.0: [10ec:c821] type 00 class 0x028000
[    0.257877] pci 0000:05:00.0: reg 0x10: [io  0x3000-0x30ff]
[    0.257909] pci 0000:05:00.0: reg 0x18: [mem 0xa0700000-0xa070ffff 64bit]
[    0.258084] pci 0000:05:00.0: supports D1 D2
[    0.258085] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.258427] pci 0000:00:1c.7: PCI bridge to [bus 05]
[    0.258433] pci 0000:00:1c.7:   bridge window [io  0x3000-0x3fff]
[    0.258438] pci 0000:00:1c.7:   bridge window [mem 0xa0700000-0xa07fffff]
[    0.258796] pci 0000:06:00.0: [8086:f1a8] type 00 class 0x010802
[    0.258832] pci 0000:06:00.0: reg 0x10: [mem 0xa0600000-0xa0603fff 64bit]
[    0.259353] pci 0000:00:1d.0: PCI bridge to [bus 06]
[    0.259363] pci 0000:00:1d.0:   bridge window [mem 0xa0600000-0xa06fffff]
[    0.261713] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.261799] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
[    0.261883] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.261966] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.262050] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.262133] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.262216] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.262299] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.267889] ACPI: EC: interrupt unblocked
[    0.267890] ACPI: EC: event unblocked
[    0.267901] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.267902] ACPI: EC: GPE=3D0xb
[    0.267904] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC initialization comp=
lete
[    0.267905] ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions =
and events
[    0.267959] iommu: Default domain type: Translated
[    0.267959] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.267959] SCSI subsystem initialized
[    0.267959] libata version 3.00 loaded.
[    0.267959] ACPI: bus type USB registered
[    0.267959] usbcore: registered new interface driver usbfs
[    0.267959] usbcore: registered new interface driver hub
[    0.267959] usbcore: registered new device driver usb
[    0.267959] pps_core: LinuxPPS API ver. 1 registered
[    0.267959] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    0.267959] PTP clock support registered
[    0.267959] EDAC MC: Ver: 3.0.0
[    0.268110] efivars: Registered efivars operations
[    0.268110] NetLabel: Initializing
[    0.268110] NetLabel:  domain hash size =3D 128
[    0.268110] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.268110] NetLabel:  unlabeled traffic allowed by default
[    0.268110] mctp: management component transport protocol core
[    0.268110] NET: Registered PF_MCTP protocol family
[    0.268110] PCI: Using ACPI for IRQ routing
[    0.354022] PCI: pci_cache_line_size set to 64 bytes
[    0.354569] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.354580] e820: reserve RAM buffer [mem 0x7bff6018-0x7bffffff]
[    0.354581] e820: reserve RAM buffer [mem 0x7c005018-0x7fffffff]
[    0.354582] e820: reserve RAM buffer [mem 0x86b6d000-0x87ffffff]
[    0.354583] e820: reserve RAM buffer [mem 0x88b80000-0x8bffffff]
[    0.354584] e820: reserve RAM buffer [mem 0x8a270000-0x8bffffff]
[    0.354585] e820: reserve RAM buffer [mem 0x8dc0f000-0x8fffffff]
[    0.354586] e820: reserve RAM buffer [mem 0x46e000000-0x46fffffff]
[    0.354615] pci 0000:03:00.0: vgaarb: setting as boot VGA device
[    0.354615] pci 0000:03:00.0: vgaarb: bridge control possible
[    0.354615] pci 0000:03:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[    0.354615] vgaarb: loaded
[    0.355617] clocksource: Switched to clocksource tsc-early
[    0.356063] VFS: Disk quotas dquot_6.6.0
[    0.356073] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.356127] pnp: PnP ACPI init
[    0.356201] system 00:00: [mem 0x40000000-0x403fffff] could not be reser=
ved
[    0.356990] system 00:01: [io  0x0a00-0x0a0f] has been reserved
[    0.356992] system 00:01: [io  0x0a10-0x0a1f] has been reserved
[    0.356994] system 00:01: [io  0x0a20-0x0a2f] has been reserved
[    0.356995] system 00:01: [io  0x0a30-0x0a3f] has been reserved
[    0.356996] system 00:01: [io  0x0a40-0x0a4f] has been reserved
[    0.356997] system 00:01: [io  0x0a50-0x0a5f] has been reserved
[    0.356999] system 00:01: [io  0x0a60-0x0a6f] has been reserved
[    0.357000] system 00:01: [io  0x0a70-0x0a7f] has been reserved
[    0.357001] system 00:01: [io  0x0a80-0x0a8f] has been reserved
[    0.357002] system 00:01: [io  0x0a90-0x0b8e] has been reserved
[    0.357004] system 00:01: [io  0x0aa0-0x0aaf] has been reserved
[    0.357005] system 00:01: [io  0x0ab0-0x0abf] has been reserved
[    0.357006] system 00:01: [io  0x0ac0-0x0acf] has been reserved
[    0.357007] system 00:01: [io  0x0ad0-0x0adf] has been reserved
[    0.357285] system 00:02: [io  0x0680-0x069f] has been reserved
[    0.357285] system 00:02: [io  0x164e-0x164f] has been reserved
[    0.357285] system 00:03: [io  0x1854-0x1857] has been reserved
[    0.357285] system 00:04: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.357285] system 00:04: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.357285] system 00:04: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.357285] system 00:04: [mem 0xe0000000-0xefffffff] has been reserved
[    0.357285] system 00:04: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.357285] system 00:04: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.357285] system 00:04: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.357285] system 00:04: [mem 0xfee00000-0xfeefffff] could not be reser=
ved
[    0.357285] system 00:05: [io  0x1800-0x18fe] could not be reserved
[    0.357285] system 00:05: [mem 0xfd000000-0xfd69ffff] has been reserved
[    0.357285] system 00:05: [mem 0xfd6c0000-0xfd6cffff] has been reserved
[    0.357285] system 00:05: [mem 0xfd6f0000-0xfdffffff] has been reserved
[    0.357285] system 00:05: [mem 0xfe000000-0xfe01ffff] could not be reser=
ved
[    0.357285] system 00:05: [mem 0xfe200000-0xfe7fffff] has been reserved
[    0.357285] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.357285] system 00:06: [io  0x2000-0x20fe] has been reserved
[    0.359202] pnp: PnP ACPI: found 8 devices
[    0.364626] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.364680] NET: Registered PF_INET protocol family
[    0.364810] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)
[    0.367435] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5,=
 131072 bytes, linear)
[    0.367459] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.367517] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes, linear)
[    0.367716] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,=
 linear)
[    0.367950] TCP: Hash tables configured (established 131072 bind 65536)
[    0.368015] MPTCP token hash table entries: 16384 (order: 6, 393216 byte=
s, linear)
[    0.368056] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.368093] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, l=
inear)
[    0.368139] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.368144] NET: Registered PF_XDP protocol family
[    0.368155] pci 0000:00:15.0: BAR 0: assigned [mem 0xa0919000-0xa0919fff=
 64bit]
[    0.368427] pci 0000:00:15.1: BAR 0: assigned [mem 0xa091d000-0xa091dfff=
 64bit]
[    0.368695] pci 0000:00:1e.0: BAR 0: assigned [mem 0xa091e000-0xa091efff=
 64bit]
[    0.368963] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.368969] pci 0000:02:00.0:   bridge window [io  0x5000-0x5fff]
[    0.368973] pci 0000:02:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.368976] pci 0000:02:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.368980] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.368981] pci 0000:01:00.0:   bridge window [io  0x5000-0x5fff]
[    0.368985] pci 0000:01:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.368987] pci 0000:01:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.368991] pci 0000:00:01.0: PCI bridge to [bus 01-03]
[    0.368992] pci 0000:00:01.0:   bridge window [io  0x5000-0x5fff]
[    0.368994] pci 0000:00:01.0:   bridge window [mem 0xa0300000-0xa05fffff]
[    0.368996] pci 0000:00:01.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.368999] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    0.369007] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[    0.369014] pci 0000:00:1c.0:   bridge window [mem 0xa0800000-0xa08fffff]
[    0.369027] pci 0000:00:1c.7: PCI bridge to [bus 05]
[    0.369029] pci 0000:00:1c.7:   bridge window [io  0x3000-0x3fff]
[    0.369036] pci 0000:00:1c.7:   bridge window [mem 0xa0700000-0xa07fffff]
[    0.369049] pci 0000:00:1d.0: PCI bridge to [bus 06]
[    0.369056] pci 0000:00:1d.0:   bridge window [mem 0xa0600000-0xa06fffff]
[    0.369070] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.369071] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.369073] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.369074] pci_bus 0000:00: resource 7 [mem 0x000e0000-0x000effff windo=
w]
[    0.369075] pci_bus 0000:00: resource 8 [mem 0x90000000-0xdfffffff windo=
w]
[    0.369076] pci_bus 0000:00: resource 9 [mem 0xfc800000-0xfe7fffff windo=
w]
[    0.369077] pci_bus 0000:01: resource 0 [io  0x5000-0x5fff]
[    0.369079] pci_bus 0000:01: resource 1 [mem 0xa0300000-0xa05fffff]
[    0.369080] pci_bus 0000:01: resource 2 [mem 0x90000000-0xa01fffff 64bit=
 pref]
[    0.369081] pci_bus 0000:02: resource 0 [io  0x5000-0x5fff]
[    0.369082] pci_bus 0000:02: resource 1 [mem 0xa0300000-0xa04fffff]
[    0.369083] pci_bus 0000:02: resource 2 [mem 0x90000000-0xa01fffff 64bit=
 pref]
[    0.369084] pci_bus 0000:03: resource 0 [io  0x5000-0x5fff]
[    0.369085] pci_bus 0000:03: resource 1 [mem 0xa0300000-0xa04fffff]
[    0.369087] pci_bus 0000:03: resource 2 [mem 0x90000000-0xa01fffff 64bit=
 pref]
[    0.369088] pci_bus 0000:04: resource 0 [io  0x4000-0x4fff]
[    0.369089] pci_bus 0000:04: resource 1 [mem 0xa0800000-0xa08fffff]
[    0.369090] pci_bus 0000:05: resource 0 [io  0x3000-0x3fff]
[    0.369091] pci_bus 0000:05: resource 1 [mem 0xa0700000-0xa07fffff]
[    0.369092] pci_bus 0000:06: resource 1 [mem 0xa0600000-0xa06fffff]
[    0.369687] pci 0000:03:00.1: D0 power state depends on 0000:03:00.0
[    0.369751] PCI: CLS 64 bytes, default 64
[    0.369813] DMAR: No ATSR found
[    0.369814] DMAR: No SATC found
[    0.369815] DMAR: dmar0: Using Queued invalidation
[    0.369835] Trying to unpack rootfs image as initramfs...
[    0.369848] pci 0000:00:00.0: Adding to iommu group 0
[    0.369862] pci 0000:00:01.0: Adding to iommu group 1
[    0.369870] pci 0000:00:08.0: Adding to iommu group 2
[    0.369881] pci 0000:00:12.0: Adding to iommu group 3
[    0.369899] pci 0000:00:14.0: Adding to iommu group 4
[    0.369906] pci 0000:00:14.2: Adding to iommu group 4
[    0.369913] pci 0000:00:14.5: Adding to iommu group 4
[    0.369928] pci 0000:00:15.0: Adding to iommu group 5
[    0.369935] pci 0000:00:15.1: Adding to iommu group 5
[    0.369946] pci 0000:00:16.0: Adding to iommu group 6
[    0.369954] pci 0000:00:17.0: Adding to iommu group 7
[    0.369970] pci 0000:00:1c.0: Adding to iommu group 8
[    0.369989] pci 0000:00:1c.7: Adding to iommu group 9
[    0.370000] pci 0000:00:1d.0: Adding to iommu group 10
[    0.370011] pci 0000:00:1e.0: Adding to iommu group 11
[    0.370033] pci 0000:00:1f.0: Adding to iommu group 12
[    0.370042] pci 0000:00:1f.3: Adding to iommu group 12
[    0.370051] pci 0000:00:1f.4: Adding to iommu group 12
[    0.370060] pci 0000:00:1f.5: Adding to iommu group 12
[    0.370063] pci 0000:01:00.0: Adding to iommu group 1
[    0.370067] pci 0000:02:00.0: Adding to iommu group 1
[    0.370072] pci 0000:03:00.0: Adding to iommu group 1
[    0.370076] pci 0000:03:00.1: Adding to iommu group 1
[    0.370090] pci 0000:04:00.0: Adding to iommu group 13
[    0.370110] pci 0000:05:00.0: Adding to iommu group 14
[    0.370120] pci 0000:06:00.0: Adding to iommu group 15
[    0.370970] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.370972] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.370973] software IO TLB: mapped [mem 0x0000000082b6d000-0x0000000086=
b6d000] (64MB)
[    0.371022] platform rtc_cmos: registered platform RTC device (no PNP de=
vice found)
[    0.380002] Initialise system trusted keyrings
[    0.380011] Key type blacklist registered
[    0.380043] workingset: timestamp_bits=3D41 max_order=3D22 bucket_order=
=3D0
[    0.380052] zbud: loaded
[    0.380169] integrity: Platform Keyring initialized
[    0.380171] integrity: Machine keyring initialized
[    0.386939] Key type asymmetric registered
[    0.386941] Asymmetric key parser 'x509' registered
[    0.386952] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 242)
[    0.386981] io scheduler mq-deadline registered
[    0.386982] io scheduler kyber registered
[    0.386989] io scheduler bfq registered
[    0.391303] pcieport 0000:00:01.0: PME: Signaling with IRQ 121
[    0.391546] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
[    0.391614] pcieport 0000:00:1c.0: AER: enabled with IRQ 122
[    0.391650] pcieport 0000:00:1c.0: DPC: enabled with IRQ 122
[    0.391651] pcieport 0000:00:1c.0: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.391936] pcieport 0000:00:1c.7: PME: Signaling with IRQ 123
[    0.391985] pcieport 0000:00:1c.7: AER: enabled with IRQ 123
[    0.392018] pcieport 0000:00:1c.7: DPC: enabled with IRQ 123
[    0.392019] pcieport 0000:00:1c.7: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.392307] pcieport 0000:00:1d.0: PME: Signaling with IRQ 124
[    0.392358] pcieport 0000:00:1d.0: AER: enabled with IRQ 124
[    0.392394] pcieport 0000:00:1d.0: DPC: enabled with IRQ 124
[    0.392395] pcieport 0000:00:1d.0: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.392763] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.393460] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input0
[    0.393479] ACPI: button: Sleep Button [SLPB]
[    0.393502] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input1
[    0.393515] ACPI: button: Power Button [PWRB]
[    0.393538] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input2
[    0.393608] ACPI: button: Power Button [PWRF]
[    0.395031] thermal LNXTHERM:00: registered as thermal_zone0
[    0.395033] ACPI: thermal: Thermal Zone [HPTZ] (30 C)
[    0.395344] thermal LNXTHERM:01: registered as thermal_zone1
[    0.395346] ACPI: thermal: Thermal Zone [TZ00] (28 C)
[    0.395497] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.397016] hpet_acpi_add: no address or irqs in _CRS
[    0.397052] Non-volatile memory driver v1.3
[    0.397053] Linux agpgart interface v0.103
[    0.405273] AMD-Vi: AMD IOMMUv2 functionality not available on this syst=
em - This is not a bug.
[    0.405417] ACPI: bus type drm_connector registered
[    0.406247] ahci 0000:00:17.0: version 3.0
[    0.416577] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 4 ports 6 Gbps 0x=
3c impl SATA mode
[    0.416581] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio slu=
m part ems deso sadm sds apst=20
[    0.433343] Freeing initrd memory: 21220K
[    0.446782] scsi host0: ahci
[    0.447073] scsi host1: ahci
[    0.447364] scsi host2: ahci
[    0.447607] scsi host3: ahci
[    0.447777] scsi host4: ahci
[    0.447908] scsi host5: ahci
[    0.447935] ata1: DUMMY
[    0.447936] ata2: DUMMY
[    0.447942] ata3: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a20=
0 irq 126
[    0.447945] ata4: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a28=
0 irq 126
[    0.447948] ata5: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a30=
0 irq 126
[    0.447950] ata6: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a38=
0 irq 126
[    0.448032] usbcore: registered new interface driver usbserial_generic
[    0.448036] usbserial: USB Serial support registered for generic
[    0.448170] rtc_cmos rtc_cmos: RTC can wake from S4
[    0.449688] rtc_cmos rtc_cmos: registered as rtc0
[    0.449999] rtc_cmos rtc_cmos: setting system clock to 2025-01-05T18:19:=
42 UTC (1736101182)
[    0.450029] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nv=
ram
[    0.450311] intel_pstate: Intel P-state driver initializing
[    0.450929] intel_pstate: Disabling energy efficiency optimization
[    0.450930] intel_pstate: HWP enabled
[    0.450967] ledtrig-cpu: registered to indicate activity on CPUs
[    0.451278] [drm] Initialized simpledrm 1.0.0 20200625 for simple-frameb=
uffer.0 on minor 0
[    0.464123] Console: switching to colour frame buffer device 240x67
[    0.476107] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledr=
mdrmfb frame buffer device
[    0.476168] hid: raw HID events driver (C) Jiri Kosina
[    0.476236] intel_pmc_core INT33A1:00:  initialized
[    0.476339] drop_monitor: Initializing network drop monitor service
[    0.484640] Initializing XFRM netlink socket
[    0.484659] NET: Registered PF_INET6 protocol family
[    0.488751] Segment Routing with IPv6
[    0.488753] RPL Segment Routing with IPv6
[    0.488758] In-situ OAM (IOAM) with IPv6
[    0.488771] NET: Registered PF_PACKET protocol family
[    0.489629] microcode: Microcode Update Driver: v2.2.
[    0.489633] IPI shorthand broadcast: enabled
[    0.490634] sched_clock: Marking stable (476930366, 12697790)->(51677161=
3, -27143457)
[    0.490839] registered taskstats version 1
[    0.491363] Loading compiled-in X.509 certificates
[    0.493288] Loaded X.509 cert 'Build time autogenerated kernel key: 09b0=
1e69463dc50f5cc1620405d3dd01b91cbd74'
[    0.494583] zswap: loaded using pool zstd/zsmalloc
[    0.495690] Key type .fscrypt registered
[    0.495691] Key type fscrypt-provisioning registered
[    0.496901] integrity: Loading X.509 certificate: UEFI:db
[    0.496919] integrity: Loaded X.509 cert 'HP Inc.: HP UEFI Secure Boot D=
B 2017: d9c01b50cfcae89d3b05345c163aa76e5dd589e7'
[    0.496919] integrity: Loading X.509 certificate: UEFI:db
[    0.496930] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA =
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.496930] integrity: Loading X.509 certificate: UEFI:db
[    0.496939] integrity: Loaded X.509 cert 'Microsoft Windows Production P=
CA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.498593] PM:   Magic number: 9:524:341
[    0.501149] RAS: Correctable Errors collector initialized.
[    0.501180] clk: Disabling unused clocks
[    0.756553] ata6: SATA link down (SStatus 4 SControl 300)
[    0.759958] ata4: SATA link down (SStatus 0 SControl 300)
[    0.760021] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.760084] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.762876] ata5.00: LPM support broken, forcing max_power
[    0.763000] ata5.00: supports DRM functions and may not be fully accessi=
ble
[    0.763007] ata5.00: ATA-9: SAMSUNG MZ7TD256HAFV-000L9, DXT04L6Q, max UD=
MA/133
[    0.763242] ata5.00: NCQ Send/Recv Log not supported
[    0.763248] ata5.00: 500118192 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    0.765038] ata5.00: Features: Trust Dev-Sleep
[    0.765349] ata5.00: LPM support broken, forcing max_power
[    0.765471] ata5.00: supports DRM functions and may not be fully accessi=
ble
[    0.765714] ata5.00: NCQ Send/Recv Log not supported
[    0.766391] ata3.00: ATA-8: WDC WD20EARX-00PASB0, 51.0AB51, max UDMA/133
[    0.766999] ata3.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 32),=
 AA
[    0.767029] ata5.00: configured for UDMA/133
[    0.773655] ata3.00: configured for UDMA/133
[    0.773936] scsi 2:0:0:0: Direct-Access     ATA      WDC WD20EARX-00P AB=
51 PQ: 0 ANSI: 5
[    0.774562] sd 2:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 =
TB/1.82 TiB)
[    0.774570] sd 2:0:0:0: [sda] 4096-byte physical blocks
[    0.774649] sd 2:0:0:0: [sda] Write Protect is off
[    0.774656] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.774807] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    0.775006] sd 2:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
[    0.777257] ahci 0000:00:17.0: port does not support device sleep
[    0.777576] scsi 4:0:0:0: Direct-Access     ATA      SAMSUNG MZ7TD256 4L=
6Q PQ: 0 ANSI: 5
[    0.778949] sd 4:0:0:0: [sdb] 500118192 512-byte logical blocks: (256 GB=
/238 GiB)
[    0.779015] sd 4:0:0:0: [sdb] Write Protect is off
[    0.779023] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    0.779121] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    0.779241] sd 4:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
[    0.784057]  sdb: sdb1 sdb2 sdb3 sdb4
[    0.784922] sd 4:0:0:0: [sdb] supports TCG Opal
[    0.784930] sd 4:0:0:0: [sdb] Attached SCSI disk
[    1.209915]  sda: sda1
[    1.210200] sd 2:0:0:0: [sda] Attached SCSI disk
[    1.213786] Freeing unused decrypted memory: 2028K
[    1.214867] Freeing unused kernel image (initmem) memory: 3444K
[    1.214872] Write protecting the kernel read-only data: 32768k
[    1.215816] Freeing unused kernel image (rodata/data gap) memory: 1236K
[    1.224371] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.224373] rodata_test: all tests were successful
[    1.224376] Run /init as init process
[    1.224377]   with arguments:
[    1.224378]     /init
[    1.224378]   with environment:
[    1.224379]     HOME=3D/
[    1.224379]     TERM=3Dlinux
[    1.386084] tsc: Refined TSC clocksource calibration: 2999.999 MHz
[    1.386088] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2b3=
e44b2357, max_idle_ns: 440795324996 ns
[    1.386162] clocksource: Switched to clocksource tsc
[    1.426213] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.426218] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[    1.427333] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
10 quirks 0x0000000000009810
[    1.427522] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.427524] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[    1.427526] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperS=
peed
[    1.427554] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.06
[    1.427556] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.427557] usb usb1: Product: xHCI Host Controller
[    1.427558] usb usb1: Manufacturer: Linux 6.6.69-1-lts xhci-hcd
[    1.427559] usb usb1: SerialNumber: 0000:00:14.0
[    1.427655] hub 1-0:1.0: USB hub found
[    1.427673] hub 1-0:1.0: 16 ports detected
[    1.429179] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.06
[    1.429181] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.429182] usb usb2: Product: xHCI Host Controller
[    1.429183] usb usb2: Manufacturer: Linux 6.6.69-1-lts xhci-hcd
[    1.429184] usb usb2: SerialNumber: 0000:00:14.0
[    1.429237] hub 2-0:1.0: USB hub found
[    1.429252] hub 2-0:1.0: 8 ports detected
[    1.429842] usb: port power management may be unreliable
[    1.431985] sdhci: Secure Digital Host Controller Interface driver
[    1.431986] sdhci: Copyright(c) Pierre Ossman
[    1.437965] nvme nvme0: pci function 0000:06:00.0
[    1.438740] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    1.438753] sdhci-pci 0000:00:14.5: enabling device (0100 -> 0102)
[    1.439493] mmc0: SDHCI controller on PCI [0000:00:14.5] using ADMA 64-b=
it
[    1.447330] nvme nvme0: 8/0/0 default/read/poll queues
[    1.450729]  nvme0n1: p1 p2
[    1.676150] usb 1-8: new high-speed USB device number 2 using xhci_hcd
[    1.816593] usb 1-8: New USB device found, idVendor=3D058f, idProduct=3D=
6254, bcdDevice=3D 1.00
[    1.816605] usb 1-8: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    1.818199] hub 1-8:1.0: USB hub found
[    1.818451] hub 1-8:1.0: 4 ports detected
[    1.865254] EXT4-fs (nvme0n1p1): mounted filesystem 7f701c1e-4cf2-46b9-8=
8a1-184e3dfef17e r/w with ordered data mode. Quota mode: none.
[    1.942802] usb 1-14: new full-speed USB device number 3 using xhci_hcd
[    2.055208] systemd[1]: systemd 257.1-1-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPEN=
SSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETU=
P +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM=
2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINI=
T +LIBARCHIVE)
[    2.055219] systemd[1]: Detected architecture x86-64.
[    2.058249] systemd[1]: Hostname set to <Ale-Arch>.
[    2.084317] usb 1-14: New USB device found, idVendor=3D0bda, idProduct=
=3Db00a, bcdDevice=3D 1.10
[    2.084330] usb 1-14: New USB device strings: Mfr=3D1, Product=3D2, Seri=
alNumber=3D3
[    2.084336] usb 1-14: Product: Bluetooth Radio=20
[    2.084340] usb 1-14: Manufacturer: Realtek=20
[    2.084343] usb 1-14: SerialNumber: 00e04c000001
[    2.121594] systemd[1]: memfd_create() called without MFD_EXEC or MFD_NO=
EXEC_SEAL set
[    2.172801] usb 1-8.3: new low-speed USB device number 4 using xhci_hcd
[    2.285588] usb 1-8.3: New USB device found, idVendor=3D05d5, idProduct=
=3D0615, bcdDevice=3D 1.01
[    2.285595] usb 1-8.3: New USB device strings: Mfr=3D0, Product=3D1, Ser=
ialNumber=3D0
[    2.285598] usb 1-8.3: Product: KEYBOARD
[    2.619654] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    2.873124] systemd-fstab-generator[303]: Mount point  is not a valid pa=
th, ignoring.
[    2.873129] systemd-fstab-generator[303]: Mount point  is not a valid pa=
th, ignoring.
[    2.873207] systemd-fstab-generator[303]: Mount point  is not a valid pa=
th, ignoring.
[    2.876609] systemd-fstab-generator[303]: Mount point  is not a valid pa=
th, ignoring.
[    2.880727] systemd-fstab-generator[303]: Mount point  is not a valid pa=
th, ignoring.
[    2.880732] systemd-fstab-generator[303]: Mount point  is not a valid pa=
th, ignoring.
[    2.880735] systemd-fstab-generator[303]: Mount point  is not a valid pa=
th, ignoring.
[    2.880786] systemd-fstab-generator[303]: Mount point  is not a valid pa=
th, ignoring.
[    2.880821] systemd-fstab-generator[303]: Mount point  is not a valid pa=
th, ignoring.
[    2.882895] systemd-fstab-generator[303]: Mount point  is not a valid pa=
th, ignoring.
[    2.882899] systemd-fstab-generator[303]: Mount point  is not a valid pa=
th, ignoring.
[    2.892582] zram: Added device: zram0
[    3.143396] systemd[1]: Configuration file /run/systemd/system/netplan-o=
vs-cleanup.service is marked world-inaccessible. This has no effect as conf=
iguration data is accessible via APIs without restrictions. Proceeding anyw=
ay.
[    3.252867] systemd[1]: Queued start job for default target Graphical In=
terface.
[    3.300450] systemd[1]: Created slice Virtual Machine and Container Slic=
e.
[    3.303768] systemd[1]: Created slice Slice /system/backrest.
[    3.305131] systemd[1]: Created slice CUPS Slice.
[    3.306523] systemd[1]: Created slice Slice /system/dirmngr.
[    3.307872] systemd[1]: Created slice Slice /system/getty.
[    3.309292] systemd[1]: Created slice Slice /system/gpg-agent.
[    3.310666] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    3.312013] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    3.313391] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    3.314768] systemd[1]: Created slice Slice /system/keyboxd.
[    3.316164] systemd[1]: Created slice Slice /system/modprobe.
[    3.317567] systemd[1]: Created slice Slice /system/nut-driver.
[    3.318927] systemd[1]: Created slice Slice /system/systemd-fsck.
[    3.320328] systemd[1]: Created slice Slice /system/systemd-zram-setup.
[    3.321203] systemd[1]: Created slice User and Session Slice.
[    3.321412] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    3.321894] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[    3.321993] systemd[1]: Expecting device /dev/disk/by-uuid/0f1ef58b-496b=
-48fd-a17b-6cbc03a2c8ee...
[    3.322046] systemd[1]: Expecting device /dev/disk/by-uuid/CAB7-E233...
[    3.322089] systemd[1]: Expecting device /dev/zram0...
[    3.322328] systemd[1]: Reached target Login Prompts.
[    3.322412] systemd[1]: Reached target Local Integrity Protected Volumes.
[    3.322623] systemd[1]: Reached target Remote File Systems.
[    3.322753] systemd[1]: Reached target Slice Units.
[    3.322853] systemd[1]: Reached target System Time Set.
[    3.323165] systemd[1]: Reached target Local Verity Protected Volumes.
[    3.323501] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    3.323855] systemd[1]: Listening on LVM2 poll daemon socket.
[    3.331746] systemd[1]: Listening on RPCbind Server Activation Socket.
[    3.331832] systemd[1]: Reached target RPC Port Mapper.
[    3.337338] systemd[1]: Listening on Process Core Dump Socket.
[    3.338346] systemd[1]: Listening on Credential Encryption/Decryption.
[    3.338489] systemd[1]: Listening on Journal Socket (/dev/log).
[    3.338636] systemd[1]: Listening on Journal Sockets.
[    3.338820] systemd[1]: Listening on Network Service Netlink Socket.
[    3.340168] systemd[1]: Listening on Userspace Out-Of-Memory (OOM) Kille=
r Socket.
[    3.341239] systemd[1]: TPM PCR Measurements was skipped because of an u=
nmet condition check (ConditionSecurity=3Dmeasured-uki).
[    3.341259] systemd[1]: Make TPM PCR Policy was skipped because of an un=
met condition check (ConditionSecurity=3Dmeasured-uki).
[    3.341353] systemd[1]: Listening on udev Control Socket.
[    3.342384] systemd[1]: Listening on udev Kernel Socket.
[    3.344704] systemd[1]: Mounting Huge Pages File System...
[    3.345267] systemd[1]: Mounting POSIX Message Queue File System...
[    3.346054] systemd[1]: Mounting NFSD configuration filesystem...
[    3.347040] systemd[1]: Mounting Kernel Debug File System...
[    3.347854] systemd[1]: Mounting Kernel Trace File System...
[    3.348272] systemd[1]: Load AppArmor profiles was skipped because of an=
 unmet condition check (ConditionSecurity=3Dapparmor).
[    3.348310] systemd[1]: Kernel Module supporting RPCSEC_GSS was skipped =
because of an unmet condition check (ConditionPathExists=3D/etc/krb5.keytab=
).
[    3.349129] systemd[1]: Starting Create List of Static Device Nodes...
[    3.350248] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling...
[    3.351956] systemd[1]: Starting Load Kernel Module configfs...
[    3.352957] systemd[1]: Starting Load Kernel Module dm_mod...
[    3.353885] systemd[1]: Starting Load Kernel Module drm...
[    3.354998] systemd[1]: Starting Load Kernel Module fuse...
[    3.355992] systemd[1]: Starting Load Kernel Module loop...
[    3.356869] systemd[1]: File System Check on Root Device was skipped bec=
ause of an unmet condition check (ConditionPathIsReadWrite=3D!/).
[    3.356907] systemd[1]: Clear Stale Hibernate Storage Info was skipped b=
ecause of an unmet condition check (ConditionPathExists=3D/sys/firmware/efi=
/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[    3.358262] systemd[1]: Starting Journal Service...
[    3.359589] systemd[1]: Starting Load Kernel Modules...
[    3.360806] systemd[1]: Starting Userspace Out-Of-Memory (OOM) Killer...
[    3.360833] systemd[1]: TPM PCR Machine ID Measurement was skipped becau=
se of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    3.362258] systemd[1]: Starting Remount Root and Kernel File Systems...
[    3.363275] loop: module loaded
[    3.363372] systemd[1]: Early TPM SRK Setup was skipped because of an un=
met condition check (ConditionSecurity=3Dmeasured-uki).
[    3.364185] systemd[1]: Starting Load udev Rules from Credentials...
[    3.365244] systemd[1]: Starting Coldplug All udev Devices...
[    3.366253] systemd[1]: Starting Virtual Console Setup...
[    3.367969] systemd[1]: Mounted Huge Pages File System.
[    3.368071] systemd[1]: Mounted POSIX Message Queue File System.
[    3.368141] systemd[1]: Mounted Kernel Debug File System.
[    3.368206] systemd[1]: Mounted Kernel Trace File System.
[    3.388928] fuse: init (API version 7.39)
[    3.389606] EXT4-fs (nvme0n1p1): re-mounted 7f701c1e-4cf2-46b9-88a1-184e=
3dfef17e r/w. Quota mode: none.
[    3.389651] device-mapper: uevent: version 1.0.3
[    3.389694] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised:=
 dm-devel@redhat.com
[    3.393092] RPC: Registered named UNIX socket transport module.
[    3.393093] RPC: Registered udp transport module.
[    3.393094] RPC: Registered tcp transport module.
[    3.393094] RPC: Registered tcp-with-tls transport module.
[    3.393095] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    3.393344] vhba: loading out-of-tree module taints kernel.
[    3.393346] vhba: module verification failed: signature and/or required =
key missing - tainting kernel
[    3.393927] scsi host6: vhba
[    3.397417] systemd-journald[343]: Collecting audit messages is disabled.
[    3.400230] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    3.400296] sd 4:0:0:0: Attached scsi generic sg1 type 0
[    3.403097] systemd[1]: Finished Create List of Static Device Nodes.
[    3.403778] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[    3.405137] i2c_dev: i2c /dev entries driver
[    3.446256] systemd[1]: Finished Load Kernel Module configfs.
[    3.446422] systemd[1]: Started Journal Service.
[    3.777779] systemd-journald[343]: Received client request to flush runt=
ime journal.
[    4.266953] zram0: detected capacity change from 0 to 32497664
[    4.305579] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: 8F1F6436-9F42-4=
2C8-BADC-0E9424F20C9A has zero instances
[    4.305582] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: 8F1F6435-9F42-4=
2C8-BADC-0E9424F20C9A has zero instances
[    4.305582] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: 7391A661-223A-4=
7DB-A77A-7BE84C60822D has zero instances
[    4.305583] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: DF4E63B6-3BBC-4=
858-9737-C74F82F821F3 has zero instances
[    4.325195] intel_pch_thermal 0000:00:12.0: enabling device (0100 -> 010=
2)
[    4.325377] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[    4.325522] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    4.325628] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db1=
8c600'
[    4.327923] platform regulatory.0: Direct firmware load for regulatory.d=
b failed with error -2
[    4.327925] cfg80211: failed to load regulatory.db
[    4.332677] raid6: skipped pq benchmark and selected avx2x4
[    4.332681] raid6: using avx2x2 recovery algorithm
[    4.333077] intel-lpss 0000:00:15.0: enabling device (0100 -> 0102)
[    4.334912] EDAC ie31200: No ECC support
[    4.335671] xor: automatically using best checksumming function   avx   =
   =20
[    4.335722] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    4.339551] EDAC ie31200: No ECC support
[    4.347236] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    4.354154] intel-lpss 0000:00:15.1: enabling device (0100 -> 0102)
[    4.364808] idma64 idma64.1: Found Intel integrated DMA 64-bit
[    4.375117] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    4.375151] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    4.377850] intel-lpss 0000:00:1e.0: enabling device (0100 -> 0102)
[    4.378122] idma64 idma64.2: Found Intel integrated DMA 64-bit
[    4.378696] i2c i2c-2: 2/2 memory slots populated (from DMI)
[    4.379576] i2c i2c-2: Successfully instantiated SPD at 0x50
[    4.380755] input: PC Speaker as /devices/platform/pcspkr/input/input3
[    4.409868] spi-nor spi0.0: XM25QH128A (16384 Kbytes)
[    4.414100] Creating 1 MTD partitions on "0000:00:1f.5":
[    4.414103] 0x000000000000-0x000001000000 : "BIOS"
[    4.532653] Adding 16248828k swap on /dev/zram0.  Priority:100 extents:1=
 across:16248828k SSDsc
[    4.534087] dw-apb-uart.2: ttyS4 at MMIO 0xa091e000 (irq =3D 20, base_ba=
ud =3D 7500000) is a 16550A
[    4.534747] iTCO_vendor_support: vendor-support=3D0
[    4.535223] ee1004 2-0050: 512 byte EE1004-compliant SPD EEPROM, read-on=
ly
[    4.540462] Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
[    4.541501] BTRFS: device label DATA devid 1 transid 20281 /dev/sda1 sca=
nned by (udev-worker) (417)
[    4.542609] input: KEYBOARD as /devices/pci0000:00/0000:00:14.0/usb1/1-8=
/1-8.3/1-8.3:1.0/0003:05D5:0615.0001/input/input4
[    4.544364] r8169 0000:04:00.0: can't disable ASPM; OS doesn't have ASPM=
 control
[    4.549263] input: HP WMI hotkeys as /devices/virtual/input/input5
[    4.551340] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360=
 ms ovfl timer
[    4.551343] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    4.551343] RAPL PMU: hw unit of domain package 2^-14 Joules
[    4.551344] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    4.558199] r8169 0000:04:00.0 eth0: RTL8168h/8111h, 9c:7b:ef:30:a7:6b, =
XID 541, IRQ 139
[    4.558204] r8169 0000:04:00.0 eth0: jumbo features [frames: 9194 bytes,=
 tx checksumming: ko]
[    4.568623] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=3D6=
, TCOBASE=3D0x0400)
[    4.569153] Bluetooth: Core ver 2.22
[    4.569165] NET: Registered PF_BLUETOOTH protocol family
[    4.569166] Bluetooth: HCI device and connection manager initialized
[    4.569167] Bluetooth: HCI socket layer initialized
[    4.569169] Bluetooth: L2CAP socket layer initialized
[    4.569171] Bluetooth: SCO socket layer initialized
[    4.569340] iTCO_wdt iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=
=3D0)
[    4.570779] r8169 0000:04:00.0 enp4s0: renamed from eth0
[    4.571343] cryptd: max_cpu_qlen set to 1000
[    4.571644] rtw_8821ce 0000:05:00.0: enabling device (0100 -> 0103)
[    4.576054] rtw_8821ce 0000:05:00.0: Firmware version 24.11.0, H2C versi=
on 12
[    4.579343] AVX2 version of gcm_enc/dec engaged.
[    4.579538] AES CTR mode by8 optimization enabled
[    4.591275] usbcore: registered new interface driver btusb
[    4.593401] snd_hda_intel 0000:00:1f.3: enabling device (0100 -> 0102)
[    4.593911] snd_hda_intel 0000:03:00.1: enabling device (0100 -> 0102)
[    4.594019] snd_hda_intel 0000:03:00.1: Force to non-snoop mode
[    4.594501] Bluetooth: hci0: RTL: examining hci_ver=3D08 hci_rev=3D000c =
lmp_ver=3D08 lmp_subver=3D8821
[    4.595441] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
[    4.595444] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_fw.bin
[    4.596316] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_config.bin
[    4.596462] Bluetooth: hci0: RTL: cfg_sz 10, total sz 34926
[    4.602458] input: HDA ATI HDMI HDMI/DP,pcm=3D3 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input6
[    5.064530] Bluetooth: hci0: RTL: fw version 0x75b8f098
[    6.311359] BTRFS info (device sda1): first mount of filesystem 0f1ef58b=
-496b-48fd-a17b-6cbc03a2c8ee
[    6.311365] BTRFS info (device sda1): using crc32c (crc32c-intel) checks=
um algorithm
[    6.311370] BTRFS info (device sda1): enabling auto defrag
[    6.311372] BTRFS info (device sda1): use zstd compression, level 3
[    6.311373] BTRFS info (device sda1): using free space tree
[    6.316189] hid-generic 0003:05D5:0615.0001: input,hidraw0: USB HID v1.1=
0 Keyboard [KEYBOARD] on usb-0000:00:14.0-8.3/input0
[    6.316231] input: HDA ATI HDMI HDMI/DP,pcm=3D7 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input7
[    6.316263] input: HDA ATI HDMI HDMI/DP,pcm=3D8 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input8
[    6.316286] input: HDA ATI HDMI HDMI/DP,pcm=3D9 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input9
[    6.316307] input: HDA ATI HDMI HDMI/DP,pcm=3D10 as /devices/pci0000:00/=
0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input10
[    6.319723] [drm] amdgpu kernel modesetting enabled.
[    6.319829] amdgpu: Virtual CRAT table created for CPU
[    6.319837] amdgpu: Topology: Add CPU node
[    6.319949] amdgpu 0000:03:00.0: enabling device (0106 -> 0107)
[    6.320018] [drm] initializing kernel modesetting (DIMGREY_CAVEFISH 0x10=
02:0x73FF 0x1043:0x05D5 0xC7).
[    6.320028] [drm] register mmio base: 0xA0300000
[    6.320029] [drm] register mmio size: 1048576
[    6.322594] [drm] add ip block number 0 <nv_common>
[    6.322596] [drm] add ip block number 1 <gmc_v10_0>
[    6.322597] [drm] add ip block number 2 <navi10_ih>
[    6.322597] [drm] add ip block number 3 <psp>
[    6.322598] [drm] add ip block number 4 <smu>
[    6.322600] [drm] add ip block number 5 <dm>
[    6.322600] [drm] add ip block number 6 <gfx_v10_0>
[    6.322601] [drm] add ip block number 7 <sdma_v5_2>
[    6.322602] [drm] add ip block number 8 <vcn_v3_0>
[    6.322603] [drm] add ip block number 9 <jpeg_v3_0>
[    6.322628] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from VFCT
[    6.322630] amdgpu: ATOM BIOS: 115-D534P00-100
[    6.324297] input: KEYBOARD Consumer Control as /devices/pci0000:00/0000=
:00:14.0/usb1/1-8/1-8.3/1-8.3:1.1/0003:05D5:0615.0002/input/input11
[    6.325169] rtw_8821ce 0000:05:00.0 wlp5s0: renamed from wlan0
[    6.330966] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC671: li=
ne_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:line
[    6.330970] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[    6.330971] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0x21/0x0/=
0x0/0x0/0x0)
[    6.330972] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0
[    6.330973] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    6.330973] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=3D0x19
[    6.330974] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=3D0x18
[    6.330975] snd_hda_codec_realtek hdaudioC0D0:      Line=3D0x1b
[    6.335504] intel_tcc_cooling: Programmable TCC Offset detected
[    6.339502] [drm] VCN(0) decode is enabled in VM mode
[    6.339504] [drm] VCN(0) encode is enabled in VM mode
[    6.343800] [drm] JPEG decode is enabled in VM mode
[    6.344210] intel_rapl_common: Found RAPL domain package
[    6.344212] intel_rapl_common: Found RAPL domain core
[    6.344213] intel_rapl_common: Found RAPL domain dram
[    6.347685] input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:0=
0:1f.3/sound/card0/input13
[    6.362931] Console: switching to colour dummy device 80x25
[    6.379558] input: KEYBOARD System Control as /devices/pci0000:00/0000:0=
0:14.0/usb1/1-8/1-8.3/1-8.3:1.1/0003:05D5:0615.0002/input/input12
[    6.379806] hid-generic 0003:05D5:0615.0002: input,hidraw1: USB HID v1.1=
0 Device [KEYBOARD] on usb-0000:00:14.0-8.3/input1
[    6.379846] usbcore: registered new interface driver usbhid
[    6.379847] usbhid: USB HID core driver
[    6.379886] input: HDA Intel PCH Rear Mic as /devices/pci0000:00/0000:00=
:1f.3/sound/card0/input14
[    6.379971] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1f.=
3/sound/card0/input15
[    6.380029] input: HDA Intel PCH Line Out as /devices/pci0000:00/0000:00=
:1f.3/sound/card0/input16
[    6.380091] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input17
[    6.387308] amdgpu 0000:03:00.0: vgaarb: deactivate vga console
[    6.387312] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (TMZ) featu=
re disabled as experimental (default)
[    6.387338] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, f=
ragment size is 9-bit
[    6.387344] amdgpu 0000:03:00.0: amdgpu: VRAM: 8176M 0x0000008000000000 =
- 0x00000081FEFFFFFF (8176M used)
[    6.387346] amdgpu 0000:03:00.0: amdgpu: GART: 512M 0x0000000000000000 -=
 0x000000001FFFFFFF
[    6.387347] amdgpu 0000:03:00.0: amdgpu: AGP: 267894784M 0x0000008400000=
000 - 0x0000FFFFFFFFFFFF
[    6.387358] [drm] Detected VRAM RAM=3D8176M, BAR=3D256M
[    6.387359] [drm] RAM width 128bits GDDR6
[    6.387532] [drm] amdgpu: 8176M of VRAM memory ready
[    6.387534] [drm] amdgpu: 7934M of GTT memory ready.
[    6.387579] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    6.387745] [drm] PCIE GART of 512M enabled (table at 0x0000008002000000=
).
[    7.865772] amdgpu 0000:03:00.0: amdgpu: STB initialized to 2048 entries
[    7.865949] [drm] Loading DMUB firmware via PSP: version=3D0x02020020
[    7.871913] [drm] use_doorbell being set to: [true]
[    7.871963] [drm] use_doorbell being set to: [true]
[    7.871986] [drm] Found VCN firmware Version ENC: 1.33 DEC: 4 VEP: 0 Rev=
ision: 3
[    7.872007] amdgpu 0000:03:00.0: amdgpu: Will use PSP to load VCN firmwa=
re
[    7.940211] [drm] reserve 0xa00000 from 0x81fd000000 for PSP TMR
[    8.043792] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is n=
ot available
[    8.060805] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta=
 ucode is not available
[    8.060829] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x000=
0000f, smu fw if version =3D 0x00000013, smu fw program =3D 0, version =3D =
0x003b3100 (59.49.0)
[    8.060836] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not match=
ed
[    8.060891] amdgpu 0000:03:00.0: amdgpu: use vbios provided pptable
[    8.107443] amdgpu 0000:03:00.0: amdgpu: SMU is initialized successfully!
[    8.107663] [drm] Display Core v3.2.247 initialized on DCN 3.0.2
[    8.107665] [drm] DP-HDMI FRL PCON supported
[    8.108908] [drm] DMUB hardware initialized: version=3D0x02020020
[    8.110994] snd_hda_intel 0000:03:00.1: bound 0000:03:00.0 (ops amdgpu_d=
m_audio_component_bind_ops [amdgpu])
[    8.572078] [drm] kiq ring mec 2 pipe 1 q 0
[    8.576637] [drm] VCN decode and encode initialized successfully(under D=
PG Mode).
[    8.577007] [drm] JPEG decode initialized successfully.
[    8.623995] amdgpu: HMM registered 8176MB device memory
[    8.625359] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    8.625368] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    8.625589] amdgpu: Virtual CRAT table created for GPU
[    8.625702] amdgpu: Topology: Add dGPU node [0x73ff:0x1002]
[    8.625704] kfd kfd: amdgpu: added device 1002:73ff
[    8.625719] amdgpu 0000:03:00.0: amdgpu: SE 2, SH per SE 2, CU per SH 8,=
 active_cu_number 28
[    8.625874] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng =
0 on hub 0
[    8.625875] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 1 on hub 0
[    8.625876] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 4 on hub 0
[    8.625877] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 5 on hub 0
[    8.625877] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 6 on hub 0
[    8.625878] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 7 on hub 0
[    8.625879] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 8 on hub 0
[    8.625879] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 9 on hub 0
[    8.625880] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 10 on hub 0
[    8.625881] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv en=
g 11 on hub 0
[    8.625882] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 12 o=
n hub 0
[    8.625883] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 13 o=
n hub 0
[    8.625883] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng =
0 on hub 8
[    8.625884] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv en=
g 1 on hub 8
[    8.625885] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv en=
g 4 on hub 8
[    8.625885] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5=
 on hub 8
[    8.627287] amdgpu 0000:03:00.0: amdgpu: Using BACO for runtime pm
[    8.628010] [drm] Initialized amdgpu 3.54.0 20150101 for 0000:03:00.0 on=
 minor 1
[    8.638026] fbcon: amdgpudrmfb (fb0) is primary device
[    8.638332] [drm] DSC precompute is not needed.
[    8.931126] Console: switching to colour frame buffer device 240x67
[    8.965571] amdgpu 0000:03:00.0: [drm] fb0: amdgpudrmfb frame buffer dev=
ice
[   10.152334] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   10.152337] Bluetooth: BNEP filters: protocol multicast
[   10.152339] Bluetooth: BNEP socket layer initialized
[   10.155693] Bluetooth: MGMT ver 1.22
[   10.161820] NET: Registered PF_ALG protocol family
[   10.379464] Generic FE-GE Realtek PHY r8169-0-400:00: attached PHY drive=
r (mii_bus:phy_addr=3Dr8169-0-400:00, irq=3DMAC)
[   10.440040] block nvme0n1: No UUID available providing old NGUID
[   10.552994] r8169 0000:04:00.0 enp4s0: Link is Down
[   11.354501] bridge: filtering via arp/ip/ip6tables is no longer availabl=
e by default. Update your scripts to load br_netfilter if you need this.
[   11.501975] u32 classifier
[   11.501976]     Performance counters on
[   11.501977]     input device check on
[   11.501977]     Actions configured
[   13.743895] r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[   13.745217] r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[   16.188807] RPC: Registered rdma transport module.
[   16.188809] RPC: Registered rdma backchannel transport module.
[   16.302134] NFSD: Using nfsdcld client tracking operations.
[   16.302136] NFSD: no clients to reclaim, skipping NFSv4 grace period (ne=
t f0000000)
[   16.699769] warning: `pmdalinux' uses wireless extensions which will sto=
p working for Wi-Fi 7 hardware; use nl80211
[   81.230713] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   81.235708] ata4.00: ATAPI: HL-DT-ST BD-RE BU40N, 1.03, max UDMA/133
[   81.240789] ata4.00: configured for UDMA/133
[   81.248585] scsi 3:0:0:0: CD-ROM            HL-DT-ST BD-RE BU40N      1.=
03 PQ: 0 ANSI: 5
[   81.302830] scsi 3:0:0:0: Attached scsi generic sg2 type 5
[   81.382131] sr 3:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd=
/rw xa/form2 cdda tray
[   81.382134] cdrom: Uniform CD-ROM driver Revision: 3.20
[   81.446836] sr 3:0:0:0: Attached scsi CD-ROM sr0

--gttcyfelaltvdnuh--

--cgyalpdfkmtkcufc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmeA63sACgkQwEfU8yi1
JYUBHw/+IYNI6eE5T0lxdqhb1gKurAxfdJ0nKsVSkTX+ciBUhhI6hBdGEV+Xqs1N
vwG+ef86Gch2DGB1CTB7Eg6PLJg1wo8C4HdB94yuNBHkE/7TRpf7q74P40REF62F
94fzCqoUlMcvI/JEnB8zi5iA9LrW2k18ieOyjSbsnY9lQs1AAfVrNGZVg+hO4vR1
cwqahrvM5mt8uVPYkheG9PYEI4Pdnh1MNOmpnsZ6CBt1C1asmKkhBr2UiGG1/7gV
4z6OfkQWwj/Y1GgRhNkduwzxyPGfACupwXWDPekNcS8k+YkPJ6Jij/9DpPKOTs9f
jCHEq1qZ+kwt5SKJlVDBrCQyTPRRpsfryN99PkS7I3jrkMRxOW/upWLtn7WqhK7O
7FPnHHvhWtIYCr92vqaCWwA1U6bo9j9rpE8+RpJXroWjmsPO1oIE/nOiALHI2Ttm
Ant03yuT1iACVjt/T+GHOUOx//pIL92hBI/5dgM41febw7vCKVbgvV35GIQm0Zyg
vZkb41diCi6KUFZWO4ryvWrYXCrUz3snV+c7u6+/68u51GMc5trJgv2J9aNJqhcC
Eg1FlIr5bbdGs5lEaEQyt0YlTz0vUOHJGyFzzZVJqwaZHgUbGRBoHApeduhkmpB4
rQe1BJD7BWFwlbEx6LtBRuoefbk/1YXyawz5Ly82OtARFUc6iac=
=WjZT
-----END PGP SIGNATURE-----

--cgyalpdfkmtkcufc--
