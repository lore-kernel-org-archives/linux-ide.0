Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DA1212D7C;
	Fri, 10 Jan 2025 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736526139; cv=none; b=rJfO5Cn87XBKpzW508Tp1/lYzUNKcik/kYzpNw1qWTKNp99KtCGbTmz71wdnKYXzLPdsxeSvjPFI4wG+zcxv/ZwPz9Uqz7MIrtb7rq33JnGzHs3TOwuVmeGdGZE4dX7HoDBFXq5CKJ2/3+Nu885iHbSDkzbuM53LZO29OeUMcUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736526139; c=relaxed/simple;
	bh=Ukd1IDtEzTE9UfLH+frd92F1glr9SLc86q0lgoFwosM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QP7VDIJjIgIe9wPXxTaODeJ/lXQWC/diJ2LIygG7yCVQdCTtwOanH1XsnXmbeO9QFZLQ3maNXEUjv3X6rVm8wVPIcv1DYEfEhV0PnRg2Yj4/40SsPn0rMNABgYc3K3pecRZRLXn2Vn559oI9pHheTtw921YjC73rAtl6gQNLgR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=aOAhOyIx; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="aOAhOyIx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1736526096; x=1737130896; i=christian@heusel.eu;
	bh=PgbYMTIgdvZEaKwP6i8EeIefN8SDQDOOEwn48jDFSFk=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aOAhOyIxjDWvPWbcdwEiZhpigusjMwlRkX8UeGjj/BIFZ5KDQgCEKmJxJOnfduFl
	 lJVrwQXsR+zZw9j9a6+2zAjoAzuWP3TUA1fTmSS8faDEhixDKfcYDG/RsdCwmIH8L
	 xPe3vJh7Wat3F6+1wJK2QcFbt09RPXZWu35Kkw+7ZQpzLuLUy0ulxuQcibd9tEJtR
	 rBlyVujjF9fuymmzW9WlBTNWQd2AtAPHJ/BRY8fXY7RQOzw1fDGo8Mbqgg1eARWiB
	 BVdbafEbYfZZ6HLhMMgbj2PeugOrAqGMw7F9v5XqH/uXLWZeXCP+SEfF2ov0pgAD6
	 s/8EsNiutH8J/2Qzbw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([94.31.75.239]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MHX3R-1tjGCH13D7-00EXKp; Fri, 10 Jan 2025 17:21:36 +0100
Date: Fri, 10 Jan 2025 17:21:32 +0100
From: Christian Heusel <christian@heusel.eu>
To: Niklas Cassel <cassel@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION][BISECTED] BU40N Blu-Ray drive broken since
 7627a0edef54
Message-ID: <69589dad-c0c8-4a72-9f3d-c1b0c29c96c1@heusel.eu>
References: <e2be6f70-dff6-4b79-bd49-70ec7e27fc1c@heusel.eu>
 <Z4EDf4ecHyfTq3Hp@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rsh5k4coxdzlgj7m"
Content-Disposition: inline
In-Reply-To: <Z4EDf4ecHyfTq3Hp@x1-carbon>
X-Provags-ID: V03:K1:NpzVoZ4106nYeV1FbYQBCtnKg94MoD2ZIQ2j9+Kjl7Knzpkidkd
 lXbMT01mKZXnA4DB0dRz6My+j8k+OIjO2HirM5jPitzsvxUh2DNYZn11gpA6I2gpE/f3N4M
 vmD3mu3nMaHhOLUDWv3d5OlF/FdhWC9/Ihiefgo4RK4lOH0Q0W2nBi7XpVeEm1CRr5uyk5H
 fKYVW7bz5Nvvknuo+2mbw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Sp1WNnrB8Pg=;Tfnubh19nlT6fhsbjwXyotZ0hq7
 u4D3PGJ7uCqayUaZ9eouiuxTbzZ4ji4VCLV/Nll/gfFSh19uGGvSx9x643nLjogPHISf7iUSD
 37le8Bpuh24qb3Oi+6/ILQNIukc/mWgFlHzr95IPjRBOCNqYFmXyCjifhFmaHDgsOGTSO6GQT
 9XpB3kbo+ToimI7xe3SikuqTmP2bpBC9kO80wgPIOYTdNJC0CX8YKzelINXauM5G7oiv3kIaW
 ONnDT+pK43ge+H2L3ML7WJl1Xo/r0GFMhgOEI0j5fmZ5o7k11K3KoncJtrKUWvdcppiLqxi8I
 omnV4rojG79XkImCCrzUglXUuuWD7NUaIC76GrpM9nBV8TsTYFQgGf70OXgfSE2wlG2gs2Ea5
 l3bDuAAmO37PB79Thlq0hXkVELVnxRPjms8XDu2fPa86bg3R0dhL1+1NboB6ULydebLbhLQ58
 W2/ujwphXz+U7TvgloofPunot9EECdYbERboOGMk+OHuiJkNhzoqT02ccrDasFyJ/RVsxZvs8
 02Kzid3LuUWqbV0GBAPH7kmidDl1X3yQhe0B8Xrf+Rij7sfJvwQluJaIAOjGqywH2uyPjb4NA
 rQ2z+L5Lih4m4gYQZJ8uXa2tuKJ8MSFpDO/6QIFUdBfoRpidcVuKiqsSC0TgX0Ll02YxSUTej
 wA6RE3xv5vxW6/TGJ6kqSE6jRspeQ3/FzJBNNSNeNMCmjRfM96WECIKVcPYGF8983Ni62E7Zm
 2IgZTYXc90Vv2zAjrcQn8oocjN5Czu/OkHTGyXQE7S+Z3aLuqMGVTC3NJCpMT8WKCs6tYiDaS
 b37Q6GzugqhyNXNgWdKcngGbMDjrxkv7pjcXYGYnUWkn8l+zSqFWc87GgfBI7JuZ++rFTmOCN
 boO+XTy9AGadxBj1D4EhSe1bi+ZIuZlBVntRPCFju8lIpGiiXrQ6uALoM9dwISa/f0W7/eZzG
 3julDuqYwwiFSfzgb2MlvF0q1fg9Vm+s9o4dTUvYYm+7PWRXnLTzgko0cuuDoWjuXK5ZtLvjG
 rg0nbiGlq8ANMOJtkOqDKkqG6iOGbEEIWQN4Jll


--rsh5k4coxdzlgj7m
Content-Type: multipart/mixed; protected-headers=v1;
	boundary="43kaatzv772p76hd"
Content-Disposition: inline
Subject: Re: [REGRESSION][BISECTED] BU40N Blu-Ray drive broken since
 7627a0edef54
MIME-Version: 1.0


--43kaatzv772p76hd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25/01/10 12:24PM, Niklas Cassel wrote:
> On Fri, Jan 10, 2025 at 10:04:46AM +0100, Christian Heusel wrote:
>
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
> > +
> >  	/* devices that don't properly handle queued TRIM commands */
> >  	{ "Micron_M500IT_*",		"MU01",	ATA_QUIRK_NO_NCQ_TRIM |
> >  						ATA_QUIRK_ZERO_AFTER_TRIM },
> >=20
> > So if anyone has feedback on why the patch does not work or any
> > alternative ideas for a solution that would be highly appreciated!
>=20
> It would be nice if you could share a dmesg.

See the attached dmesg, this is from the v6.13-rc6 kernel with the above
patch applied.

> If you have applied the quirk properly, I would expect to see something
> similar to:
>=20
> [    2.989363] ata2.00: Model 'QEMU DVD-ROM', rev '2.5+', applying quirks=
: nolpm

Somehow the quirk does not apply to the model, i.e. the above line is
not to be found in the dmesg output. This is now the third time that a
kernel with this patch applied was built by two different people,
therefore I'd rule out build issues. Also I can find the following
output in my build log, which should give us a lot of confidence that
the patch was actually applied to the source:

    > Applying patch add-quirk-for-blueray.patch...
    > patching file drivers/ata/libata-core.c

Now the question is why the quirk does not work in the final result and
I don't know why that could be.

> Kind regards,
> Niklas

Thanks for all your inputs and quick responses!
Cheers,
Christian

--43kaatzv772p76hd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-6.13-rc6-mainline.log"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Linux version 6.13.0-rc6-1.1-mainline-dirty (linux-mainline@=
archlinux) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU Binutils) 2.43.1) #1 SMP=
 PREEMPT_DYNAMIC Fri, 10 Jan 2025 10:00:38 +0000
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
[    0.000848] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000851] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000860] last_pfn =3D 0x46e000 max_arch_pfn =3D 0x400000000
[    0.000864] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built fr=
om 10 variable MTRRs
[    0.000866] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.001141] last_pfn =3D 0x8dc0f max_arch_pfn =3D 0x400000000
[    0.008574] esrt: Reserving ESRT space from 0x0000000088b80398 to 0x0000=
000088b80420.
[    0.008579] e820: update [mem 0x88b80000-0x88b80fff] usable =3D=3D> rese=
rved
[    0.008595] Using GB pages for direct mapping
[    0.009178] Secure boot disabled
[    0.009179] RAMDISK: [mem 0x7bf3c000-0x7d3fffff]
[    0.009199] ACPI: Early table checksum verification disabled
[    0.009201] ACPI: RSDP 0x000000008A6BE000 000024 (v02 HPQOEM)
[    0.009205] ACPI: XSDT 0x000000008A6BE0C0 0000FC (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009210] ACPI: FACP 0x000000008A704DC8 000114 (v06 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009215] ACPI: DSDT 0x000000008A6BE248 046B7A (v02 HPQOEM SLIC-CPC 01=
072009 INTL 20160527)
[    0.009218] ACPI: FACS 0x000000008AB93080 000040
[    0.009220] ACPI: APIC 0x000000008A704EE0 0000BC (v04 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009223] ACPI: FPDT 0x000000008A704FA0 000044 (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009225] ACPI: FIDT 0x000000008A704FE8 00009C (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009228] ACPI: MCFG 0x000000008A705088 00003C (v01 HPQOEM SLIC-CPC 01=
072009 MSFT 00000097)
[    0.009231] ACPI: SSDT 0x000000008A7050C8 001B5F (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.009234] ACPI: MSDM 0x000000008A706C28 000055 (v03 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009236] ACPI: SSDT 0x000000008A706C80 000060 (v01 HPQOEM SLIC-CPC 00=
000001 INTL 20160527)
[    0.009239] ACPI: SSDT 0x000000008A706CE0 000060 (v01 HPQOEM SLIC-CPC 00=
000001 INTL 20160527)
[    0.009242] ACPI: SSDT 0x000000008A706D40 0031C6 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.009244] ACPI: SSDT 0x000000008A709F08 00241B (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009247] ACPI: HPET 0x000000008A70C328 000038 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009249] ACPI: SSDT 0x000000008A70C360 001D39 (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009252] ACPI: SSDT 0x000000008A70E0A0 000FAE (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009255] ACPI: SSDT 0x000000008A70F050 000BDF (v02 HPQOEM SLIC-CPC 00=
000000 INTL 20160527)
[    0.009257] ACPI: UEFI 0x000000008A70FC30 000042 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009260] ACPI: LPIT 0x000000008A70FC78 000094 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009262] ACPI: SSDT 0x000000008A70FD10 0027DE (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009265] ACPI: SSDT 0x000000008A7124F0 0014E2 (v02 HPQOEM SLIC-CPC 00=
000000 INTL 20160527)
[    0.009268] ACPI: DBGP 0x000000008A7139D8 000034 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009270] ACPI: DBG2 0x000000008A713A10 000054 (v00 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009273] ACPI: SSDT 0x000000008A713A68 001B67 (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009275] ACPI: DMAR 0x000000008A7155D0 000070 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009278] ACPI: VFCT 0x000000008A715640 00B284 (v01 HPQOEM SLIC-CPC 00=
000001 AMD  31504F47)
[    0.009281] ACPI: BGRT 0x000000008A7208C8 000038 (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009283] ACPI: TPM2 0x000000008A720900 000034 (v04 HPQOEM SLIC-CPC 00=
000001 AMI  00000000)
[    0.009286] ACPI: WSMT 0x000000008A720938 000028 (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009288] ACPI: Reserving FACP table memory at [mem 0x8a704dc8-0x8a704=
edb]
[    0.009289] ACPI: Reserving DSDT table memory at [mem 0x8a6be248-0x8a704=
dc1]
[    0.009290] ACPI: Reserving FACS table memory at [mem 0x8ab93080-0x8ab93=
0bf]
[    0.009291] ACPI: Reserving APIC table memory at [mem 0x8a704ee0-0x8a704=
f9b]
[    0.009292] ACPI: Reserving FPDT table memory at [mem 0x8a704fa0-0x8a704=
fe3]
[    0.009293] ACPI: Reserving FIDT table memory at [mem 0x8a704fe8-0x8a705=
083]
[    0.009293] ACPI: Reserving MCFG table memory at [mem 0x8a705088-0x8a705=
0c3]
[    0.009294] ACPI: Reserving SSDT table memory at [mem 0x8a7050c8-0x8a706=
c26]
[    0.009295] ACPI: Reserving MSDM table memory at [mem 0x8a706c28-0x8a706=
c7c]
[    0.009296] ACPI: Reserving SSDT table memory at [mem 0x8a706c80-0x8a706=
cdf]
[    0.009296] ACPI: Reserving SSDT table memory at [mem 0x8a706ce0-0x8a706=
d3f]
[    0.009297] ACPI: Reserving SSDT table memory at [mem 0x8a706d40-0x8a709=
f05]
[    0.009298] ACPI: Reserving SSDT table memory at [mem 0x8a709f08-0x8a70c=
322]
[    0.009299] ACPI: Reserving HPET table memory at [mem 0x8a70c328-0x8a70c=
35f]
[    0.009300] ACPI: Reserving SSDT table memory at [mem 0x8a70c360-0x8a70e=
098]
[    0.009300] ACPI: Reserving SSDT table memory at [mem 0x8a70e0a0-0x8a70f=
04d]
[    0.009301] ACPI: Reserving SSDT table memory at [mem 0x8a70f050-0x8a70f=
c2e]
[    0.009302] ACPI: Reserving UEFI table memory at [mem 0x8a70fc30-0x8a70f=
c71]
[    0.009303] ACPI: Reserving LPIT table memory at [mem 0x8a70fc78-0x8a70f=
d0b]
[    0.009303] ACPI: Reserving SSDT table memory at [mem 0x8a70fd10-0x8a712=
4ed]
[    0.009304] ACPI: Reserving SSDT table memory at [mem 0x8a7124f0-0x8a713=
9d1]
[    0.009305] ACPI: Reserving DBGP table memory at [mem 0x8a7139d8-0x8a713=
a0b]
[    0.009306] ACPI: Reserving DBG2 table memory at [mem 0x8a713a10-0x8a713=
a63]
[    0.009306] ACPI: Reserving SSDT table memory at [mem 0x8a713a68-0x8a715=
5ce]
[    0.009307] ACPI: Reserving DMAR table memory at [mem 0x8a7155d0-0x8a715=
63f]
[    0.009308] ACPI: Reserving VFCT table memory at [mem 0x8a715640-0x8a720=
8c3]
[    0.009309] ACPI: Reserving BGRT table memory at [mem 0x8a7208c8-0x8a720=
8ff]
[    0.009310] ACPI: Reserving TPM2 table memory at [mem 0x8a720900-0x8a720=
933]
[    0.009310] ACPI: Reserving WSMT table memory at [mem 0x8a720938-0x8a720=
95f]
[    0.009634] No NUMA configuration found
[    0.009635] Faking a node at [mem 0x0000000000000000-0x000000046dffffff]
[    0.009644] NODE_DATA(0) allocated [mem 0x46dfd52c0-0x46dffffff]
[    0.009899] Zone ranges:
[    0.009900]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.009902]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.009903]   Normal   [mem 0x0000000100000000-0x000000046dffffff]
[    0.009905]   Device   empty
[    0.009906] Movable zone start for each node
[    0.009908] Early memory node ranges
[    0.009908]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.009910]   node   0: [mem 0x0000000000100000-0x000000008a26ffff]
[    0.009911]   node   0: [mem 0x000000008dc0e000-0x000000008dc0efff]
[    0.009912]   node   0: [mem 0x0000000100000000-0x000000046dffffff]
[    0.009914] Initmem setup node 0 [mem 0x0000000000001000-0x000000046dfff=
fff]
[    0.009919] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.009940] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.012782] On node 0, zone DMA32: 14750 pages in unavailable ranges
[    0.030054] On node 0, zone Normal: 9201 pages in unavailable ranges
[    0.030146] On node 0, zone Normal: 8192 pages in unavailable ranges
[    0.031352] ACPI: PM-Timer IO Port: 0x1808
[    0.031359] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.031360] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.031361] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.031362] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.031363] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.031363] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.031364] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.031365] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.031425] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.031428] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.031429] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.031433] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.031434] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.031441] e820: update [mem 0x86b6d000-0x86bdffff] usable =3D=3D> rese=
rved
[    0.031453] TSC deadline timer available
[    0.031458] CPU topo: Max. logical packages:   1
[    0.031459] CPU topo: Max. logical dies:       1
[    0.031459] CPU topo: Max. dies per package:   1
[    0.031464] CPU topo: Max. threads per core:   1
[    0.031465] CPU topo: Num. cores per package:     8
[    0.031465] CPU topo: Num. threads per package:   8
[    0.031466] CPU topo: Allowing 8 present CPUs plus 0 hotplug CPUs
[    0.031479] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.031481] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0=
x000fffff]
[    0.031483] PM: hibernation: Registered nosave memory: [mem 0x7bf0e000-0=
x7bf0efff]
[    0.031484] PM: hibernation: Registered nosave memory: [mem 0x7bf1c000-0=
x7bf1cfff]
[    0.031485] PM: hibernation: Registered nosave memory: [mem 0x7bf1d000-0=
x7bf1dfff]
[    0.031486] PM: hibernation: Registered nosave memory: [mem 0x7bf3b000-0=
x7bf3bfff]
[    0.031488] PM: hibernation: Registered nosave memory: [mem 0x86b6d000-0=
x86bdffff]
[    0.031489] PM: hibernation: Registered nosave memory: [mem 0x88b80000-0=
x88b80fff]
[    0.031491] PM: hibernation: Registered nosave memory: [mem 0x8a270000-0=
x8a6a4fff]
[    0.031492] PM: hibernation: Registered nosave memory: [mem 0x8a6a5000-0=
x8a721fff]
[    0.031492] PM: hibernation: Registered nosave memory: [mem 0x8a722000-0=
x8ab95fff]
[    0.031493] PM: hibernation: Registered nosave memory: [mem 0x8ab96000-0=
x8dc0dfff]
[    0.031494] PM: hibernation: Registered nosave memory: [mem 0x8dc0f000-0=
x8fffffff]
[    0.031495] PM: hibernation: Registered nosave memory: [mem 0x90000000-0=
xfdffffff]
[    0.031496] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0=
xfe010fff]
[    0.031496] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0=
xfebfffff]
[    0.031497] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0=
xfec00fff]
[    0.031498] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0=
xfecfffff]
[    0.031498] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0=
xfed03fff]
[    0.031499] PM: hibernation: Registered nosave memory: [mem 0xfed04000-0=
xfedfffff]
[    0.031500] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0=
xfee00fff]
[    0.031500] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0=
xffffffff]
[    0.031502] [mem 0x90000000-0xfdffffff] available for PCI devices
[    0.031503] Booting paravirtualized kernel on bare hardware
[    0.031505] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 6370452778343963 ns
[    0.037894] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr=
_node_ids:1
[    0.038306] percpu: Embedded 67 pages/cpu s237568 r8192 d28672 u524288
[    0.038313] pcpu-alloc: s237568 r8192 d28672 u524288 alloc=3D1*2097152
[    0.038315] pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7=20
[    0.038335] Kernel command line: initrd=3D\intel-ucode.img initrd=3D\ini=
tramfs-linux-mainline.img root=3D/dev/nvme0n1p1 rw intel_iommu=3Don
[    0.038396] DMAR: IOMMU enabled
[    0.038420] printk: log buffer data + meta data: 131072 + 458752 =3D 589=
824 bytes
[    0.039623] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes, linear)
[    0.040218] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes, linear)
[    0.040315] Fallback order for Node 0: 0=20
[    0.040318] Built 1 zonelists, mobility grouping on.  Total pages: 41620=
63
[    0.040319] Policy zone: Normal
[    0.040488] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.040495] software IO TLB: area num 8.
[    0.082608] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D8, N=
odes=3D1
[    0.082644] ftrace: allocating 51623 entries in 202 pages
[    0.103975] ftrace: allocated 202 pages with 4 groups
[    0.104052] Dynamic Preempt: full
[    0.104097] rcu: Preemptible hierarchical RCU implementation.
[    0.104098] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D8.
[    0.104099] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.104100] 	Trampoline variant of Tasks RCU enabled.
[    0.104101] 	Rude variant of Tasks RCU enabled.
[    0.104101] 	Tracing variant of Tasks RCU enabled.
[    0.104102] rcu: RCU calculated value of scheduler-enlistment delay is 3=
0 jiffies.
[    0.104102] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D8
[    0.104108] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjus=
t=3D1 rcu_task_cpu_ids=3D8.
[    0.104110] RCU Tasks Rude: Setting shift to 3 and lim to 1 rcu_task_cb_=
adjust=3D1 rcu_task_cpu_ids=3D8.
[    0.104112] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb=
_adjust=3D1 rcu_task_cpu_ids=3D8.
[    0.109857] NR_IRQS: 524544, nr_irqs: 2048, preallocated irqs: 16
[    0.110145] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.110549] kfence: initialized - using 2097152 bytes for 255 objects at=
 0x(____ptrval____)-0x(____ptrval____)
[    0.110581] Console: colour dummy device 80x25
[    0.110583] printk: legacy console [tty0] enabled
[    0.110632] ACPI: Core revision 20240827
[    0.110876] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.110941] APIC: Switch to symmetric I/O mode setup
[    0.110943] DMAR: Host address width 39
[    0.110944] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.110950] DMAR: dmar0: reg_base_addr fed91000 ver 1:0 cap d2008c406604=
62 ecap f050da
[    0.110953] DMAR: RMRR base: 0x0000008b72e000 end: 0x0000008b977fff
[    0.110955] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 0
[    0.110957] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.110958] DMAR-IR: Queued invalidation will be enabled to support x2ap=
ic and Intr-remapping.
[    0.114008] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.114010] x2apic enabled
[    0.114079] APIC: Switched APIC routing to: cluster x2apic
[    0.123236] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x2b3e459bf4c, max_idle_ns: 440795289890 ns
[    0.123241] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 6002.00 BogoMIPS (lpj=3D10000000)
[    0.123261] x86/cpu: SGX disabled or unsupported by BIOS.
[    0.123269] CPU0: Thermal monitoring enabled (TM1)
[    0.123323] Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
[    0.123324] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.123328] process: using mwait in idle threads
[    0.123330] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.123332] Spectre V2 : Spectre BHI mitigation: SW BHB clearing on sysc=
all and VM exit
[    0.123333] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.123334] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.123334] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL =
on VMEXIT
[    0.123335] RETBleed: Mitigation: Enhanced IBRS
[    0.123337] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.123338] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl
[    0.123343] TAA: Mitigation: TSX disabled
[    0.123344] MMIO Stale Data: Mitigation: Clear CPU buffers
[    0.123347] SRBDS: Mitigation: Microcode
[    0.123352] GDS: Mitigation: Microcode
[    0.123356] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.123358] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.123359] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.123360] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registe=
rs'
[    0.123361] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.123362] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.123363] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.123364] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.123366] x86/fpu: Enabled xstate features 0x1f, context size is 960 b=
ytes, using 'compacted' format.
[    0.126572] Freeing SMP alternatives memory: 40K
[    0.126572] pid_max: default: 32768 minimum: 301
[    0.126572] LSM: initializing lsm=3Dcapability,landlock,lockdown,yama,bpf
[    0.126572] landlock: Up and running.
[    0.126572] Yama: becoming mindful.
[    0.126572] LSM support for eBPF active
[    0.126572] Mount-cache hash table entries: 32768 (order: 6, 262144 byte=
s, linear)
[    0.126572] Mountpoint-cache hash table entries: 32768 (order: 6, 262144=
 bytes, linear)
[    0.126572] smpboot: CPU0: Intel(R) Core(TM) i7-9700F CPU @ 3.00GHz (fam=
ily: 0x6, model: 0x9e, stepping: 0xd)
[    0.126572] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR,=
 full-width counters, Intel PMU driver.
[    0.126572] ... version:                4
[    0.126572] ... bit width:              48
[    0.126572] ... generic registers:      8
[    0.126572] ... value mask:             0000ffffffffffff
[    0.126572] ... max period:             00007fffffffffff
[    0.126572] ... fixed-purpose events:   3
[    0.126572] ... event mask:             00000007000000ff
[    0.126572] signal: max sigframe size: 2032
[    0.126572] Estimated ratio of average max frequency by base frequency (=
times 1024): 1570
[    0.126572] rcu: Hierarchical SRCU implementation.
[    0.126572] rcu: 	Max phase no-delay instances is 1000.
[    0.126572] Timer migration: 1 hierarchy levels; 8 children per group; 1=
 crossnode level
[    0.126572] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.126572] smp: Bringing up secondary CPUs ...
[    0.126572] smpboot: x86: Booting SMP configuration:
[    0.126572] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.129957] ------------[ cut here ]------------
[    0.129960] workqueue: work disable count underflowed
[    0.129962] WARNING: CPU: 1 PID: 25 at kernel/workqueue.c:4317 enable_wo=
rk+0xdc/0x100
[    0.129969] Modules linked in:
[    0.129971] CPU: 1 UID: 0 PID: 25 Comm: cpuhp/1 Not tainted 6.13.0-rc6-1=
=2E1-mainline-dirty #1 c275e5d56fcc663358af28dad0103f8555743e5b
[    0.129975] Hardware name: HP HP Pavilion Desktop TP01-0xxx/8653, BIOS F=
=2E37 10/26/2023
[    0.129976] RIP: 0010:enable_work+0xdc/0x100
[    0.129979] Code: de 2e 02 00 74 04 31 ed eb b3 48 c7 c7 58 a7 88 9d 48 =
89 54 24 10 89 44 24 0c 48 89 34 24 c6 05 85 de 2e 02 01 e8 64 5e fd ff <0f=
> 0b 31 ed 48 8b 34 24 8b 44 24 0c 48 8b 54 24 10 eb 80 e8 0c db
[    0.129981] RSP: 0000:ffff9b6dc0193e10 EFLAGS: 00010086
[    0.129983] RAX: 0000000000000000 RBX: ffff8b285dab1a40 RCX: 00000000000=
00003
[    0.129985] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 00000000000=
00001
[    0.129986] RBP: ffff9b6dc0193e28 R08: 0000000000000000 R09: ffff9b6dc01=
93c90
[    0.129987] R10: ffffffff9e2b53c8 R11: 0000000000000003 R12: 00000000000=
000c4
[    0.129989] R13: ffffffff9c3e3c70 R14: 0000000000000000 R15: ffff8b285da=
a1408
[    0.129990] FS:  0000000000000000(0000) GS:ffff8b285da80000(0000) knlGS:=
0000000000000000
[    0.129991] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.129993] CR2: 0000000000000000 CR3: 0000000185622001 CR4: 00000000003=
706f0
[    0.129994] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[    0.129995] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[    0.129997] Call Trace:
[    0.129998]  <TASK>
[    0.129999]  ? enable_work+0xdc/0x100
[    0.130002]  ? __warn.cold+0x93/0xf6
[    0.130003]  ? enable_work+0xdc/0x100
[    0.130007]  ? report_bug+0xff/0x140
[    0.130009]  ? handle_bug+0x58/0x90
[    0.130011]  ? exc_invalid_op+0x17/0x70
[    0.130012]  ? asm_exc_invalid_op+0x1a/0x20
[    0.130015]  ? __pfx_vmstat_cpu_online+0x10/0x10
[    0.130018]  ? enable_work+0xdc/0x100
[    0.130021]  vmstat_cpu_online+0x61/0x70
[    0.130024]  cpuhp_invoke_callback+0x11f/0x420
[    0.130027]  ? __pfx_smpboot_thread_fn+0x10/0x10
[    0.130028]  cpuhp_thread_fun+0xa2/0x170
[    0.130030]  smpboot_thread_fn+0xda/0x1d0
[    0.130032]  kthread+0xcf/0x100
[    0.130034]  ? __pfx_kthread+0x10/0x10
[    0.130036]  ret_from_fork+0x31/0x50
[    0.130038]  ? __pfx_kthread+0x10/0x10
[    0.130040]  ret_from_fork_asm+0x1a/0x30
[    0.130044]  </TASK>
[    0.130044] ---[ end trace 0000000000000000 ]---
[    0.130047] smp: Brought up 1 node, 8 CPUs
[    0.130047] smpboot: Total of 8 processors activated (48019.00 BogoMIPS)
[    0.131956] Memory: 16201524K/16648252K available (18432K kernel code, 2=
692K rwdata, 14428K rodata, 4292K init, 3948K bss, 431572K reserved, 0K cma=
-reserved)
[    0.133413] devtmpfs: initialized
[    0.133413] x86/mm: Memory block size: 128MB
[    0.134408] ACPI: PM: Registering ACPI NVS region [mem 0x8a722000-0x8ab9=
5fff] (4669440 bytes)
[    0.134408] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 6370867519511994 ns
[    0.134408] futex hash table entries: 2048 (order: 5, 131072 bytes, line=
ar)
[    0.134408] pinctrl core: initialized pinctrl subsystem
[    0.134408] PM: RTC time: 11:24:24, date: 2025-01-10
[    0.134408] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.134409] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.134522] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.134635] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.134641] audit: initializing netlink subsys (disabled)
[    0.134697] audit: type=3D2000 audit(1736508264.000:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.134697] thermal_sys: Registered thermal governor 'fair_share'
[    0.134697] thermal_sys: Registered thermal governor 'bang_bang'
[    0.134697] thermal_sys: Registered thermal governor 'step_wise'
[    0.134697] thermal_sys: Registered thermal governor 'user_space'
[    0.134697] thermal_sys: Registered thermal governor 'power_allocator'
[    0.134697] cpuidle: using governor ladder
[    0.134697] cpuidle: using governor menu
[    0.134697] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    0.134697] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.134697] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for =
domain 0000 [bus 00-ff]
[    0.134697] PCI: Using configuration type 1 for base access
[    0.134697] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.137600] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.137600] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.137600] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.137600] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.137600] fbcon: Taking over console
[    0.137600] ACPI: Added _OSI(Module Device)
[    0.137600] ACPI: Added _OSI(Processor Device)
[    0.137600] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.137600] ACPI: Added _OSI(Processor Aggregator Device)
[    0.192086] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    0.200402] ACPI: Dynamic OEM Table Load:
[    0.200409] ACPI: SSDT 0xFFFF8B25010C6800 000400 (v02 HPQOEM SLIC-CPC 00=
003001 INTL 20160527)
[    0.200730] ACPI: Dynamic OEM Table Load:
[    0.200730] ACPI: SSDT 0xFFFF8B25010B8000 000605 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.201634] ACPI: Dynamic OEM Table Load:
[    0.201638] ACPI: SSDT 0xFFFF8B25010E8C00 0000F4 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.202581] ACPI: Dynamic OEM Table Load:
[    0.202585] ACPI: SSDT 0xFFFF8B250184EE00 000149 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.203486] ACPI: Dynamic OEM Table Load:
[    0.203491] ACPI: SSDT 0xFFFF8B25010BF800 000724 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.204617] ACPI: Dynamic OEM Table Load:
[    0.204623] ACPI: SSDT 0xFFFF8B25010BB000 0005FC (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.205677] ACPI: Dynamic OEM Table Load:
[    0.205681] ACPI: SSDT 0xFFFF8B25010C1400 000317 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.206736] ACPI: Dynamic OEM Table Load:
[    0.206742] ACPI: SSDT 0xFFFF8B25018C0000 000AB0 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.208312] ACPI: Dynamic OEM Table Load:
[    0.208317] ACPI: SSDT 0xFFFF8B25010C4400 00030A (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.212530] ACPI: EC: EC started
[    0.212532] ACPI: EC: interrupt blocked
[    0.213121] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.213123] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle tran=
sactions
[    0.213125] ACPI: Interpreter enabled
[    0.213162] ACPI: PM: (supports S0 S3 S4 S5)
[    0.213163] ACPI: Using IOAPIC for interrupt routing
[    0.214366] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.214367] PCI: Ignoring E820 reservations for host bridge windows
[    0.215550] ACPI: Enabled 10 GPEs in block 00 to 7F
[    0.232466] ACPI: \_SB_.PCI0.XDCI.USBC: New power resource
[    0.232618] ACPI: \_SB_.PCI0.PAUD: New power resource
[    0.235075] ACPI: \SPR2: New power resource
[    0.235252] ACPI: \SPR3: New power resource
[    0.235552] ACPI: \ZPDR: New power resource
[    0.235799] ACPI: \_SB_.PCI0.SAT0.VOL0.V0PR: New power resource
[    0.236001] ACPI: \_SB_.PCI0.SAT0.VOL1.V1PR: New power resource
[    0.236198] ACPI: \_SB_.PCI0.SAT0.VOL2.V2PR: New power resource
[    0.241823] ACPI: \_SB_.PCI0.I2C1.PXTC: New power resource
[    0.248324] ACPI: \_SB_.PCI0.CNVW.WRST: New power resource
[    0.253483] ACPI: \_TZ_.FN00: New power resource
[    0.253551] ACPI: \_TZ_.FN01: New power resource
[    0.253618] ACPI: \_TZ_.FN02: New power resource
[    0.253681] ACPI: \_TZ_.FN03: New power resource
[    0.253743] ACPI: \_TZ_.FN04: New power resource
[    0.254202] ACPI: \PIN_: New power resource
[    0.254357] ACPI: \SPR0: New power resource
[    0.254413] ACPI: \SPR1: New power resource
[    0.254468] ACPI: \SPR5: New power resource
[    0.255015] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.255022] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI EDR HPX-Type3]
[    0.258281] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME AER PCIeCapability LTR DPC]
[    0.258283] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    0.259467] PCI host bridge to bus 0000:00
[    0.259472] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.259474] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.259476] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.259478] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000efff=
f window]
[    0.259479] pci_bus 0000:00: root bus resource [mem 0x90000000-0xdffffff=
f window]
[    0.259480] pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7ffff=
f window]
[    0.259482] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.259575] pci 0000:00:00.0: [8086:3e30] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.259644] pci 0000:00:01.0: [8086:1901] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.259657] pci 0000:00:01.0: PCI bridge to [bus 01-03]
[    0.259660] pci 0000:00:01.0:   bridge window [io  0x5000-0x5fff]
[    0.259662] pci 0000:00:01.0:   bridge window [mem 0xa0300000-0xa05fffff]
[    0.259667] pci 0000:00:01.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.259693] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.260295] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000 convent=
ional PCI endpoint
[    0.260304] pci 0000:00:08.0: BAR 0 [mem 0xa0922000-0xa0922fff 64bit]
[    0.260478] pci 0000:00:12.0: [8086:a379] type 00 class 0x118000 convent=
ional PCI endpoint
[    0.260509] pci 0000:00:12.0: BAR 0 [mem 0xa0921000-0xa0921fff 64bit]
[    0.260770] pci 0000:00:14.0: [8086:a36d] type 00 class 0x0c0330 convent=
ional PCI endpoint
[    0.260806] pci 0000:00:14.0: BAR 0 [mem 0xa0900000-0xa090ffff 64bit]
[    0.260946] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.261656] pci 0000:00:14.2: [8086:a36f] type 00 class 0x050000 convent=
ional PCI endpoint
[    0.261687] pci 0000:00:14.2: BAR 0 [mem 0xa0916000-0xa0917fff 64bit]
[    0.261706] pci 0000:00:14.2: BAR 2 [mem 0xa0920000-0xa0920fff 64bit]
[    0.261857] pci 0000:00:14.5: [8086:a375] type 00 class 0x080501 convent=
ional PCI endpoint
[    0.261889] pci 0000:00:14.5: BAR 0 [mem 0xa091f000-0xa091ffff 64bit]
[    0.262723] pci 0000:00:15.0: [8086:a368] type 00 class 0x0c8000 convent=
ional PCI endpoint
[    0.263277] pci 0000:00:15.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.266237] pci 0000:00:15.1: [8086:a369] type 00 class 0x0c8000 convent=
ional PCI endpoint
[    0.266815] pci 0000:00:15.1: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.269451] pci 0000:00:16.0: [8086:a360] type 00 class 0x078000 convent=
ional PCI endpoint
[    0.269484] pci 0000:00:16.0: BAR 0 [mem 0xa091c000-0xa091cfff 64bit]
[    0.269603] pci 0000:00:16.0: PME# supported from D3hot
[    0.270246] pci 0000:00:17.0: [8086:a352] type 00 class 0x010601 convent=
ional PCI endpoint
[    0.270274] pci 0000:00:17.0: BAR 0 [mem 0xa0914000-0xa0915fff]
[    0.270289] pci 0000:00:17.0: BAR 1 [mem 0xa091b000-0xa091b0ff]
[    0.270304] pci 0000:00:17.0: BAR 2 [io  0x6050-0x6057]
[    0.270319] pci 0000:00:17.0: BAR 3 [io  0x6040-0x6043]
[    0.270334] pci 0000:00:17.0: BAR 4 [io  0x6020-0x603f]
[    0.270349] pci 0000:00:17.0: BAR 5 [mem 0xa091a000-0xa091a7ff]
[    0.270431] pci 0000:00:17.0: PME# supported from D3hot
[    0.270900] pci 0000:00:1c.0: [8086:a33d] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.270957] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    0.270965] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[    0.270970] pci 0000:00:1c.0:   bridge window [mem 0xa0800000-0xa08fffff]
[    0.271118] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.271167] pci 0000:00:1c.0: PTM enabled (root), 4ns granularity
[    0.272031] pci 0000:00:1c.7: [8086:a33f] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.272089] pci 0000:00:1c.7: PCI bridge to [bus 05]
[    0.272097] pci 0000:00:1c.7:   bridge window [io  0x3000-0x3fff]
[    0.272102] pci 0000:00:1c.7:   bridge window [mem 0xa0700000-0xa07fffff]
[    0.272244] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
[    0.272287] pci 0000:00:1c.7: PTM enabled (root), 4ns granularity
[    0.273096] pci 0000:00:1d.0: [8086:a330] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.273153] pci 0000:00:1d.0: PCI bridge to [bus 06]
[    0.273164] pci 0000:00:1d.0:   bridge window [mem 0xa0600000-0xa06fffff]
[    0.273323] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.273375] pci 0000:00:1d.0: PTM enabled (root), 4ns granularity
[    0.274624] pci 0000:00:1e.0: [8086:a328] type 00 class 0x078000 convent=
ional PCI endpoint
[    0.275164] pci 0000:00:1e.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.277823] pci 0000:00:1f.0: [8086:a304] type 00 class 0x060100 convent=
ional PCI endpoint
[    0.278389] pci 0000:00:1f.3: [8086:a348] type 00 class 0x040300 convent=
ional PCI endpoint
[    0.278450] pci 0000:00:1f.3: BAR 0 [mem 0xa0910000-0xa0913fff 64bit]
[    0.278524] pci 0000:00:1f.3: BAR 4 [mem 0xa0200000-0xa02fffff 64bit]
[    0.278673] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.280082] pci 0000:00:1f.4: [8086:a323] type 00 class 0x0c0500 convent=
ional PCI endpoint
[    0.280253] pci 0000:00:1f.4: BAR 0 [mem 0xa0918000-0xa09180ff 64bit]
[    0.280467] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.280972] pci 0000:00:1f.5: [8086:a324] type 00 class 0x0c8000 convent=
ional PCI endpoint
[    0.280998] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.281185] pci 0000:01:00.0: [1002:1478] type 01 class 0x060400 PCIe Sw=
itch Upstream Port
[    0.281197] pci 0000:01:00.0: BAR 0 [mem 0xa0500000-0xa0503fff]
[    0.281209] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.281214] pci 0000:01:00.0:   bridge window [io  0x5000-0x5fff]
[    0.281217] pci 0000:01:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.281225] pci 0000:01:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.281292] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.281340] pci 0000:01:00.0: 63.008 Gb/s available PCIe bandwidth, limi=
ted by 8.0 GT/s PCIe x8 link at 0000:00:01.0 (capable of 126.024 Gb/s with =
16.0 GT/s PCIe x8 link)
[    0.281436] pci 0000:00:01.0: PCI bridge to [bus 01-03]
[    0.281477] pci 0000:02:00.0: [1002:1479] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.281498] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.281503] pci 0000:02:00.0:   bridge window [io  0x5000-0x5fff]
[    0.281506] pci 0000:02:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.281514] pci 0000:02:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.281580] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.281702] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.281748] pci 0000:03:00.0: [1002:73ff] type 00 class 0x030000 PCIe Le=
gacy Endpoint
[    0.281762] pci 0000:03:00.0: BAR 0 [mem 0x90000000-0x9fffffff 64bit pre=
f]
[    0.281771] pci 0000:03:00.0: BAR 2 [mem 0xa0000000-0xa01fffff 64bit pre=
f]
[    0.281777] pci 0000:03:00.0: BAR 4 [io  0x5000-0x50ff]
[    0.281783] pci 0000:03:00.0: BAR 5 [mem 0xa0300000-0xa03fffff]
[    0.281789] pci 0000:03:00.0: ROM [mem 0xa0400000-0xa041ffff pref]
[    0.281861] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.281919] pci 0000:03:00.0: 63.008 Gb/s available PCIe bandwidth, limi=
ted by 8.0 GT/s PCIe x8 link at 0000:00:01.0 (capable of 252.048 Gb/s with =
16.0 GT/s PCIe x16 link)
[    0.281994] pci 0000:03:00.1: [1002:ab28] type 00 class 0x040300 PCIe Le=
gacy Endpoint
[    0.282003] pci 0000:03:00.1: BAR 0 [mem 0xa0420000-0xa0423fff]
[    0.282075] pci 0000:03:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.282166] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.282329] pci 0000:04:00.0: [10ec:8168] type 00 class 0x020000 PCIe En=
dpoint
[    0.282357] pci 0000:04:00.0: BAR 0 [io  0x4000-0x40ff]
[    0.282394] pci 0000:04:00.0: BAR 2 [mem 0xa0804000-0xa0804fff 64bit]
[    0.282418] pci 0000:04:00.0: BAR 4 [mem 0xa0800000-0xa0803fff 64bit]
[    0.282581] pci 0000:04:00.0: supports D1 D2
[    0.282582] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.282891] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    0.283044] pci 0000:05:00.0: [10ec:c821] type 00 class 0x028000 PCIe En=
dpoint
[    0.283071] pci 0000:05:00.0: BAR 0 [io  0x3000-0x30ff]
[    0.283103] pci 0000:05:00.0: BAR 2 [mem 0xa0700000-0xa070ffff 64bit]
[    0.283291] pci 0000:05:00.0: supports D1 D2
[    0.283292] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.283672] pci 0000:00:1c.7: PCI bridge to [bus 05]
[    0.284044] pci 0000:06:00.0: [8086:f1a8] type 00 class 0x010802 PCIe En=
dpoint
[    0.284079] pci 0000:06:00.0: BAR 0 [mem 0xa0600000-0xa0603fff 64bit]
[    0.284633] pci 0000:00:1d.0: PCI bridge to [bus 06]
[    0.286943] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.287028] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
[    0.287111] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.287193] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.287276] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.287358] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.287440] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.287522] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.292917] ACPI: EC: interrupt unblocked
[    0.292918] ACPI: EC: event unblocked
[    0.292931] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.292932] ACPI: EC: GPE=3D0xb
[    0.292933] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC initialization comp=
lete
[    0.292935] ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions =
and events
[    0.293249] iommu: Default domain type: Translated
[    0.293249] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.293362] SCSI subsystem initialized
[    0.293368] libata version 3.00 loaded.
[    0.293368] ACPI: bus type USB registered
[    0.293368] usbcore: registered new interface driver usbfs
[    0.293368] usbcore: registered new interface driver hub
[    0.293368] usbcore: registered new device driver usb
[    0.293368] EDAC MC: Ver: 3.0.0
[    0.293582] efivars: Registered efivars operations
[    0.293582] NetLabel: Initializing
[    0.293582] NetLabel:  domain hash size =3D 128
[    0.293582] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.293582] NetLabel:  unlabeled traffic allowed by default
[    0.293582] mctp: management component transport protocol core
[    0.293582] NET: Registered PF_MCTP protocol family
[    0.293582] PCI: Using ACPI for IRQ routing
[    0.379036] PCI: pci_cache_line_size set to 64 bytes
[    0.379635] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.379647] e820: reserve RAM buffer [mem 0x7bf0e018-0x7bffffff]
[    0.379648] e820: reserve RAM buffer [mem 0x7bf1d018-0x7bffffff]
[    0.379649] e820: reserve RAM buffer [mem 0x86b6d000-0x87ffffff]
[    0.379650] e820: reserve RAM buffer [mem 0x88b80000-0x8bffffff]
[    0.379651] e820: reserve RAM buffer [mem 0x8a270000-0x8bffffff]
[    0.379652] e820: reserve RAM buffer [mem 0x8dc0f000-0x8fffffff]
[    0.379653] e820: reserve RAM buffer [mem 0x46e000000-0x46fffffff]
[    0.379927] pci 0000:03:00.0: vgaarb: setting as boot VGA device
[    0.379927] pci 0000:03:00.0: vgaarb: bridge control possible
[    0.379927] pci 0000:03:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[    0.379927] vgaarb: loaded
[    0.379971] clocksource: Switched to clocksource tsc-early
[    0.380385] VFS: Disk quotas dquot_6.6.0
[    0.380393] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.380447] pnp: PnP ACPI init
[    0.380524] system 00:00: [mem 0x40000000-0x403fffff] could not be reser=
ved
[    0.381329] system 00:01: [io  0x0a00-0x0a0f] has been reserved
[    0.381332] system 00:01: [io  0x0a10-0x0a1f] has been reserved
[    0.381333] system 00:01: [io  0x0a20-0x0a2f] has been reserved
[    0.381335] system 00:01: [io  0x0a30-0x0a3f] has been reserved
[    0.381336] system 00:01: [io  0x0a40-0x0a4f] has been reserved
[    0.381337] system 00:01: [io  0x0a50-0x0a5f] has been reserved
[    0.381339] system 00:01: [io  0x0a60-0x0a6f] has been reserved
[    0.381340] system 00:01: [io  0x0a70-0x0a7f] has been reserved
[    0.381341] system 00:01: [io  0x0a80-0x0a8f] has been reserved
[    0.381343] system 00:01: [io  0x0a90-0x0b8e] has been reserved
[    0.381344] system 00:01: [io  0x0aa0-0x0aaf] has been reserved
[    0.381345] system 00:01: [io  0x0ab0-0x0abf] has been reserved
[    0.381347] system 00:01: [io  0x0ac0-0x0acf] has been reserved
[    0.381348] system 00:01: [io  0x0ad0-0x0adf] has been reserved
[    0.381738] system 00:02: [io  0x0680-0x069f] has been reserved
[    0.381740] system 00:02: [io  0x164e-0x164f] has been reserved
[    0.381860] system 00:03: [io  0x1854-0x1857] has been reserved
[    0.382032] system 00:04: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.382034] system 00:04: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.382036] system 00:04: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.382038] system 00:04: [mem 0xe0000000-0xefffffff] has been reserved
[    0.382039] system 00:04: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.382041] system 00:04: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.382042] system 00:04: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.382044] system 00:04: [mem 0xfee00000-0xfeefffff] could not be reser=
ved
[    0.382280] system 00:05: [io  0x1800-0x18fe] could not be reserved
[    0.382283] system 00:05: [mem 0xfd000000-0xfd69ffff] has been reserved
[    0.382285] system 00:05: [mem 0xfd6c0000-0xfd6cffff] has been reserved
[    0.382286] system 00:05: [mem 0xfd6f0000-0xfdffffff] has been reserved
[    0.382288] system 00:05: [mem 0xfe000000-0xfe01ffff] could not be reser=
ved
[    0.382290] system 00:05: [mem 0xfe200000-0xfe7fffff] has been reserved
[    0.382291] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.382604] system 00:06: [io  0x2000-0x20fe] has been reserved
[    0.384726] pnp: PnP ACPI: found 8 devices
[    0.390213] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.390267] NET: Registered PF_INET protocol family
[    0.390398] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)
[    0.404991] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5,=
 131072 bytes, linear)
[    0.405014] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.405073] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes, linear)
[    0.405287] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,=
 linear)
[    0.405509] TCP: Hash tables configured (established 131072 bind 65536)
[    0.405562] MPTCP token hash table entries: 16384 (order: 6, 393216 byte=
s, linear)
[    0.405628] UDP hash table entries: 8192 (order: 7, 524288 bytes, linear)
[    0.405702] UDP-Lite hash table entries: 8192 (order: 7, 524288 bytes, l=
inear)
[    0.405774] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.405780] NET: Registered PF_XDP protocol family
[    0.405795] pci 0000:00:15.0: BAR 0 [mem 0xa0919000-0xa0919fff 64bit]: a=
ssigned
[    0.406033] pci 0000:00:15.1: BAR 0 [mem 0xa091d000-0xa091dfff 64bit]: a=
ssigned
[    0.406315] pci 0000:00:1e.0: BAR 0 [mem 0xa091e000-0xa091efff 64bit]: a=
ssigned
[    0.406584] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.406591] pci 0000:02:00.0:   bridge window [io  0x5000-0x5fff]
[    0.406595] pci 0000:02:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.406598] pci 0000:02:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.406602] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.406604] pci 0000:01:00.0:   bridge window [io  0x5000-0x5fff]
[    0.406607] pci 0000:01:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.406610] pci 0000:01:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.406614] pci 0000:00:01.0: PCI bridge to [bus 01-03]
[    0.406616] pci 0000:00:01.0:   bridge window [io  0x5000-0x5fff]
[    0.406618] pci 0000:00:01.0:   bridge window [mem 0xa0300000-0xa05fffff]
[    0.406620] pci 0000:00:01.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.406624] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    0.406632] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[    0.406639] pci 0000:00:1c.0:   bridge window [mem 0xa0800000-0xa08fffff]
[    0.406652] pci 0000:00:1c.7: PCI bridge to [bus 05]
[    0.406655] pci 0000:00:1c.7:   bridge window [io  0x3000-0x3fff]
[    0.406663] pci 0000:00:1c.7:   bridge window [mem 0xa0700000-0xa07fffff]
[    0.406676] pci 0000:00:1d.0: PCI bridge to [bus 06]
[    0.406683] pci 0000:00:1d.0:   bridge window [mem 0xa0600000-0xa06fffff]
[    0.406697] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.406698] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.406700] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.406701] pci_bus 0000:00: resource 7 [mem 0x000e0000-0x000effff windo=
w]
[    0.406702] pci_bus 0000:00: resource 8 [mem 0x90000000-0xdfffffff windo=
w]
[    0.406704] pci_bus 0000:00: resource 9 [mem 0xfc800000-0xfe7fffff windo=
w]
[    0.406705] pci_bus 0000:01: resource 0 [io  0x5000-0x5fff]
[    0.406706] pci_bus 0000:01: resource 1 [mem 0xa0300000-0xa05fffff]
[    0.406708] pci_bus 0000:01: resource 2 [mem 0x90000000-0xa01fffff 64bit=
 pref]
[    0.406709] pci_bus 0000:02: resource 0 [io  0x5000-0x5fff]
[    0.406710] pci_bus 0000:02: resource 1 [mem 0xa0300000-0xa04fffff]
[    0.406711] pci_bus 0000:02: resource 2 [mem 0x90000000-0xa01fffff 64bit=
 pref]
[    0.406713] pci_bus 0000:03: resource 0 [io  0x5000-0x5fff]
[    0.406714] pci_bus 0000:03: resource 1 [mem 0xa0300000-0xa04fffff]
[    0.406715] pci_bus 0000:03: resource 2 [mem 0x90000000-0xa01fffff 64bit=
 pref]
[    0.406717] pci_bus 0000:04: resource 0 [io  0x4000-0x4fff]
[    0.406718] pci_bus 0000:04: resource 1 [mem 0xa0800000-0xa08fffff]
[    0.406719] pci_bus 0000:05: resource 0 [io  0x3000-0x3fff]
[    0.406721] pci_bus 0000:05: resource 1 [mem 0xa0700000-0xa07fffff]
[    0.406722] pci_bus 0000:06: resource 1 [mem 0xa0600000-0xa06fffff]
[    0.407326] pci 0000:03:00.1: D0 power state depends on 0000:03:00.0
[    0.407422] PCI: CLS 64 bytes, default 64
[    0.407486] DMAR: No ATSR found
[    0.407486] DMAR: No SATC found
[    0.407488] DMAR: dmar0: Using Queued invalidation
[    0.407517] Trying to unpack rootfs image as initramfs...
[    0.407543] pci 0000:00:00.0: Adding to iommu group 0
[    0.407556] pci 0000:00:01.0: Adding to iommu group 1
[    0.407564] pci 0000:00:08.0: Adding to iommu group 2
[    0.407575] pci 0000:00:12.0: Adding to iommu group 3
[    0.407594] pci 0000:00:14.0: Adding to iommu group 4
[    0.407602] pci 0000:00:14.2: Adding to iommu group 4
[    0.407609] pci 0000:00:14.5: Adding to iommu group 4
[    0.407624] pci 0000:00:15.0: Adding to iommu group 5
[    0.407631] pci 0000:00:15.1: Adding to iommu group 5
[    0.407643] pci 0000:00:16.0: Adding to iommu group 6
[    0.407651] pci 0000:00:17.0: Adding to iommu group 7
[    0.407667] pci 0000:00:1c.0: Adding to iommu group 8
[    0.407685] pci 0000:00:1c.7: Adding to iommu group 9
[    0.407696] pci 0000:00:1d.0: Adding to iommu group 10
[    0.407707] pci 0000:00:1e.0: Adding to iommu group 11
[    0.407729] pci 0000:00:1f.0: Adding to iommu group 12
[    0.407740] pci 0000:00:1f.3: Adding to iommu group 12
[    0.407748] pci 0000:00:1f.4: Adding to iommu group 12
[    0.407757] pci 0000:00:1f.5: Adding to iommu group 12
[    0.407761] pci 0000:01:00.0: Adding to iommu group 1
[    0.407765] pci 0000:02:00.0: Adding to iommu group 1
[    0.407770] pci 0000:03:00.0: Adding to iommu group 1
[    0.407775] pci 0000:03:00.1: Adding to iommu group 1
[    0.407790] pci 0000:04:00.0: Adding to iommu group 13
[    0.407806] pci 0000:05:00.0: Adding to iommu group 14
[    0.407817] pci 0000:06:00.0: Adding to iommu group 15
[    0.408643] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.408645] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.408646] software IO TLB: mapped [mem 0x0000000082b6d000-0x0000000086=
b6d000] (64MB)
[    0.408702] platform rtc_cmos: registered platform RTC device (no PNP de=
vice found)
[    0.419637] Initialise system trusted keyrings
[    0.419646] Key type blacklist registered
[    0.419695] workingset: timestamp_bits=3D36 max_order=3D22 bucket_order=
=3D0
[    0.419779] fuse: init (API version 7.41)
[    0.419841] integrity: Platform Keyring initialized
[    0.419843] integrity: Machine keyring initialized
[    0.430737] Key type asymmetric registered
[    0.430739] Asymmetric key parser 'x509' registered
[    0.430755] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 246)
[    0.430792] io scheduler mq-deadline registered
[    0.430793] io scheduler kyber registered
[    0.430802] io scheduler bfq registered
[    0.430942] ledtrig-cpu: registered to indicate activity on CPUs
[    0.431144] pcieport 0000:00:01.0: PME: Signaling with IRQ 121
[    0.431380] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
[    0.431448] pcieport 0000:00:1c.0: AER: enabled with IRQ 122
[    0.431488] pcieport 0000:00:1c.0: DPC: enabled with IRQ 122
[    0.431490] pcieport 0000:00:1c.0: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.431795] pcieport 0000:00:1c.7: PME: Signaling with IRQ 123
[    0.431854] pcieport 0000:00:1c.7: AER: enabled with IRQ 123
[    0.431893] pcieport 0000:00:1c.7: DPC: enabled with IRQ 123
[    0.431895] pcieport 0000:00:1c.7: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.432173] pcieport 0000:00:1d.0: PME: Signaling with IRQ 124
[    0.432228] pcieport 0000:00:1d.0: AER: enabled with IRQ 124
[    0.432266] pcieport 0000:00:1d.0: DPC: enabled with IRQ 124
[    0.432267] pcieport 0000:00:1d.0: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.432659] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.433195] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input0
[    0.433216] ACPI: button: Sleep Button [SLPB]
[    0.433238] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input1
[    0.433251] ACPI: button: Power Button [PWRB]
[    0.433276] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input2
[    0.436221] ACPI: button: Power Button [PWRF]
[    0.438267] thermal LNXTHERM:00: registered as thermal_zone0
[    0.438269] ACPI: thermal: Thermal Zone [HPTZ] (30 C)
[    0.438561] thermal LNXTHERM:01: registered as thermal_zone1
[    0.438563] ACPI: thermal: Thermal Zone [TZ00] (28 C)
[    0.438769] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.440586] hpet_acpi_add: no address or irqs in _CRS
[    0.440623] Non-volatile memory driver v1.3
[    0.440624] Linux agpgart interface v0.103
[    0.471172] Freeing initrd memory: 21264K
[    0.573750] ACPI: bus type drm_connector registered
[    0.574642] ahci 0000:00:17.0: version 3.0
[    0.584993] ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 =
Gbps, SATA mode
[    0.584998] ahci 0000:00:17.0: 4/4 ports implemented (port mask 0x3c)
[    0.584999] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio slu=
m part ems deso sadm sds apst=20
[    0.603376] scsi host0: ahci
[    0.603688] scsi host1: ahci
[    0.603993] scsi host2: ahci
[    0.604174] scsi host3: ahci
[    0.604309] scsi host4: ahci
[    0.604368] scsi host5: ahci
[    0.604392] ata1: DUMMY
[    0.604393] ata2: DUMMY
[    0.604399] ata3: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a20=
0 irq 126 lpm-pol 3
[    0.604402] ata4: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a28=
0 irq 126 lpm-pol 3
[    0.604405] ata5: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a30=
0 irq 126 lpm-pol 3
[    0.604408] ata6: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a38=
0 irq 126 lpm-pol 3
[    0.604596] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.604601] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[    0.605742] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
10 quirks 0x0000000000009810
[    0.606019] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.606021] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[    0.606024] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperS=
peed
[    0.606060] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.13
[    0.606063] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.606064] usb usb1: Product: xHCI Host Controller
[    0.606066] usb usb1: Manufacturer: Linux 6.13.0-rc6-1.1-mainline-dirty =
xhci-hcd
[    0.606067] usb usb1: SerialNumber: 0000:00:14.0
[    0.606212] hub 1-0:1.0: USB hub found
[    0.606235] hub 1-0:1.0: 16 ports detected
[    0.607953] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.13
[    0.607956] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.607958] usb usb2: Product: xHCI Host Controller
[    0.607959] usb usb2: Manufacturer: Linux 6.13.0-rc6-1.1-mainline-dirty =
xhci-hcd
[    0.607961] usb usb2: SerialNumber: 0000:00:14.0
[    0.608059] hub 2-0:1.0: USB hub found
[    0.608074] hub 2-0:1.0: 8 ports detected
[    0.608849] usb: port power management may be unreliable
[    0.609168] usbcore: registered new interface driver usbserial_generic
[    0.609172] usbserial: USB Serial support registered for generic
[    0.609334] rtc_cmos rtc_cmos: RTC can wake from S4
[    0.610901] rtc_cmos rtc_cmos: registered as rtc0
[    0.611213] rtc_cmos rtc_cmos: setting system clock to 2025-01-10T11:24:=
25 UTC (1736508265)
[    0.611245] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nv=
ram
[    0.611561] intel_pstate: Intel P-state driver initializing
[    0.612162] intel_pstate: Disabling energy efficiency optimization
[    0.612163] intel_pstate: HWP enabled
[    0.612411] simple-framebuffer simple-framebuffer.0: [drm] Registered 1 =
planes with drm panic
[    0.612412] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 o=
n minor 0
[    0.622272] Console: switching to colour frame buffer device 240x67
[    0.634097] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledr=
mdrmfb frame buffer device
[    0.634227] hid: raw HID events driver (C) Jiri Kosina
[    0.634305] drop_monitor: Initializing network drop monitor service
[    0.634394] NET: Registered PF_INET6 protocol family
[    0.639136] Segment Routing with IPv6
[    0.639138] RPL Segment Routing with IPv6
[    0.639146] In-situ OAM (IOAM) with IPv6
[    0.639161] NET: Registered PF_PACKET protocol family
[    0.643236] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.643434] microcode: Current revision: 0x00000100
[    0.643436] microcode: Updated early from: 0x000000fa
[    0.643712] IPI shorthand broadcast: enabled
[    0.644846] sched_clock: Marking stable (630914333, 12784304)->(67273751=
7, -29038880)
[    0.645127] registered taskstats version 1
[    0.645717] Loading compiled-in X.509 certificates
[    0.649335] Loaded X.509 cert 'Build time autogenerated kernel key: f6ed=
cd9617e9783f7928ec27f28d89d95b5650eb'
[    0.650419] Demotion targets for Node 0: null
[    0.650602] Key type .fscrypt registered
[    0.650603] Key type fscrypt-provisioning registered
[    0.651967] integrity: Loading X.509 certificate: UEFI:db
[    0.651982] integrity: Loaded X.509 cert 'HP Inc.: HP UEFI Secure Boot D=
B 2017: d9c01b50cfcae89d3b05345c163aa76e5dd589e7'
[    0.651983] integrity: Loading X.509 certificate: UEFI:db
[    0.651993] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA =
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.651993] integrity: Loading X.509 certificate: UEFI:db
[    0.652003] integrity: Loaded X.509 cert 'Microsoft Windows Production P=
CA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.653631] PM:   Magic number: 9:260:428
[    0.655633] RAS: Correctable Errors collector initialized.
[    0.661751] clk: Disabling unused clocks
[    0.661752] PM: genpd: Disabling unused power domains
[    0.856357] usb 1-8: new high-speed USB device number 2 using xhci_hcd
[    0.910020] ata4: SATA link down (SStatus 0 SControl 300)
[    0.913406] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.913476] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.913541] ata6: SATA link down (SStatus 4 SControl 300)
[    0.916294] ata5.00: Model 'SAMSUNG MZ7TD256HAFV-000L9', rev 'DXT04L6Q',=
 applying quirks: nolpm
[    0.916305] ata5.00: LPM support broken, forcing max_power
[    0.916440] ata5.00: supports DRM functions and may not be fully accessi=
ble
[    0.916446] ata5.00: ATA-9: SAMSUNG MZ7TD256HAFV-000L9, DXT04L6Q, max UD=
MA/133
[    0.916753] ata5.00: NCQ Send/Recv Log not supported
[    0.916760] ata5.00: 500118192 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    0.918918] ata5.00: Features: Trust Dev-Sleep
[    0.919283] ata5.00: LPM support broken, forcing max_power
[    0.919489] ata5.00: supports DRM functions and may not be fully accessi=
ble
[    0.919784] ata5.00: NCQ Send/Recv Log not supported
[    0.919936] ata3.00: ATA-8: WDC WD20EARX-00PASB0, 51.0AB51, max UDMA/133
[    0.920501] ata3.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 32),=
 AA
[    0.921268] ata5.00: configured for UDMA/133
[    0.927188] ata3.00: configured for UDMA/133
[    0.927432] scsi 2:0:0:0: Direct-Access     ATA      WDC WD20EARX-00P AB=
51 PQ: 0 ANSI: 5
[    0.927936] sd 2:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 =
TB/1.82 TiB)
[    0.927945] sd 2:0:0:0: [sda] 4096-byte physical blocks
[    0.927961] sd 2:0:0:0: [sda] Write Protect is off
[    0.927966] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.927987] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    0.928021] sd 2:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
[    0.931517] ahci 0000:00:17.0: port does not support device sleep
[    0.931713] scsi 4:0:0:0: Direct-Access     ATA      SAMSUNG MZ7TD256 4L=
6Q PQ: 0 ANSI: 5
[    0.932167] sd 4:0:0:0: [sdb] 500118192 512-byte logical blocks: (256 GB=
/238 GiB)
[    0.932187] sd 4:0:0:0: [sdb] Write Protect is off
[    0.932192] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    0.932212] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    0.932259] sd 4:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
[    0.976200]  sdb: sdb1 sdb2 sdb3 sdb4
[    0.976979] sd 4:0:0:0: [sdb] supports TCG Opal
[    0.976988] sd 4:0:0:0: [sdb] Attached SCSI disk
[    0.986793] usb 1-8: New USB device found, idVendor=3D058f, idProduct=3D=
6254, bcdDevice=3D 1.00
[    0.986805] usb 1-8: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    0.988589] hub 1-8:1.0: USB hub found
[    0.988707] hub 1-8:1.0: 4 ports detected
[    1.106495] usb 1-14: new full-speed USB device number 3 using xhci_hcd
[    1.237828] usb 1-14: New USB device found, idVendor=3D0bda, idProduct=
=3Db00a, bcdDevice=3D 1.10
[    1.237842] usb 1-14: New USB device strings: Mfr=3D1, Product=3D2, Seri=
alNumber=3D3
[    1.237848] usb 1-14: Product: Bluetooth Radio=20
[    1.237852] usb 1-14: Manufacturer: Realtek=20
[    1.237856] usb 1-14: SerialNumber: 00e04c000001
[    1.316498] usb 1-8.3: new low-speed USB device number 4 using xhci_hcd
[    1.374834]  sda: sda1
[    1.375109] sd 2:0:0:0: [sda] Attached SCSI disk
[    1.378046] Freeing unused decrypted memory: 2028K
[    1.379070] Freeing unused kernel image (initmem) memory: 4292K
[    1.379114] Write protecting the kernel read-only data: 34816k
[    1.380789] Freeing unused kernel image (rodata/data gap) memory: 1956K
[    1.388643] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.388646] rodata_test: all tests were successful
[    1.388654] Run /init as init process
[    1.388654]   with arguments:
[    1.388655]     /init
[    1.388656]   with environment:
[    1.388656]     HOME=3D/
[    1.388657]     TERM=3Dlinux
[    1.415394] usb 1-8.3: New USB device found, idVendor=3D05d5, idProduct=
=3D0615, bcdDevice=3D 1.01
[    1.415397] usb 1-8.3: New USB device strings: Mfr=3D0, Product=3D1, Ser=
ialNumber=3D0
[    1.415398] usb 1-8.3: Product: KEYBOARD
[    1.429572] tsc: Refined TSC clocksource calibration: 2999.999 MHz
[    1.429575] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2b3=
e44b2357, max_idle_ns: 440795324996 ns
[    1.429656] clocksource: Switched to clocksource tsc
[    1.591845] usbcore: registered new interface driver usbhid
[    1.591847] usbhid: USB HID core driver
[    1.595587] sdhci: Secure Digital Host Controller Interface driver
[    1.595589] sdhci: Copyright(c) Pierre Ossman
[    1.598087] input: KEYBOARD as /devices/pci0000:00/0000:00:14.0/usb1/1-8=
/1-8.3/1-8.3:1.0/0003:05D5:0615.0001/input/input3
[    1.599234] nvme nvme0: pci function 0000:06:00.0
[    1.602492] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    1.602505] sdhci-pci 0000:00:14.5: enabling device (0100 -> 0102)
[    1.611549] nvme nvme0: 8/0/0 default/read/poll queues
[    1.616390]  nvme0n1: p1 p2
[    1.617174] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    1.713282] hid-generic 0003:05D5:0615.0001: input,hidraw0: USB HID v1.1=
0 Keyboard [KEYBOARD] on usb-0000:00:14.0-8.3/input0
[    1.713420] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    1.713623] input: KEYBOARD Consumer Control as /devices/pci0000:00/0000=
:00:14.0/usb1/1-8/1-8.3/1-8.3:1.1/0003:05D5:0615.0002/input/input4
[    1.766655] input: KEYBOARD System Control as /devices/pci0000:00/0000:0=
0:14.0/usb1/1-8/1-8.3/1-8.3:1.1/0003:05D5:0615.0002/input/input5
[    1.767033] hid-generic 0003:05D5:0615.0002: input,hidraw1: USB HID v1.1=
0 Device [KEYBOARD] on usb-0000:00:14.0-8.3/input1
[    1.767176] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    2.088618] EXT4-fs (nvme0n1p1): mounted filesystem 7f701c1e-4cf2-46b9-8=
8a1-184e3dfef17e r/w with ordered data mode. Quota mode: none.
[    2.266599] systemd[1]: systemd 257.2-1-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPEN=
SSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETU=
P +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM=
2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINI=
T +LIBARCHIVE)
[    2.266609] systemd[1]: Detected architecture x86-64.
[    2.269443] systemd[1]: Hostname set to <Ale-Arch>.
[    2.458688] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    2.704311] systemd-fstab-generator[306]: Mount point  is not a valid pa=
th, ignoring.
[    2.704317] systemd-fstab-generator[306]: Mount point  is not a valid pa=
th, ignoring.
[    2.704404] systemd-fstab-generator[306]: Mount point  is not a valid pa=
th, ignoring.
[    2.706845] systemd-fstab-generator[306]: Mount point  is not a valid pa=
th, ignoring.
[    2.710358] systemd-fstab-generator[306]: Mount point  is not a valid pa=
th, ignoring.
[    2.710361] systemd-fstab-generator[306]: Mount point  is not a valid pa=
th, ignoring.
[    2.710364] systemd-fstab-generator[306]: Mount point  is not a valid pa=
th, ignoring.
[    2.710411] systemd-fstab-generator[306]: Mount point  is not a valid pa=
th, ignoring.
[    2.710443] systemd-fstab-generator[306]: Mount point  is not a valid pa=
th, ignoring.
[    2.711247] systemd-fstab-generator[306]: Mount point  is not a valid pa=
th, ignoring.
[    2.711250] systemd-fstab-generator[306]: Mount point  is not a valid pa=
th, ignoring.
[    2.734690] zram: Added device: zram0
[    2.959198] systemd[1]: Configuration file /run/systemd/system/netplan-o=
vs-cleanup.service is marked world-inaccessible. This has no effect as conf=
iguration data is accessible via APIs without restrictions. Proceeding anyw=
ay.
[    3.044423] systemd[1]: Queued start job for default target Graphical In=
terface.
[    3.064737] systemd[1]: Created slice Virtual Machine and Container Slic=
e.
[    3.065475] systemd[1]: Created slice Slice /system/backrest.
[    3.065793] systemd[1]: Created slice CUPS Slice.
[    3.066680] systemd[1]: Created slice Slice /system/dirmngr.
[    3.067526] systemd[1]: Created slice Slice /system/getty.
[    3.068348] systemd[1]: Created slice Slice /system/gpg-agent.
[    3.069147] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    3.070000] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    3.070783] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    3.071643] systemd[1]: Created slice Slice /system/keyboxd.
[    3.072387] systemd[1]: Created slice Slice /system/modprobe.
[    3.073131] systemd[1]: Created slice Slice /system/nut-driver.
[    3.073904] systemd[1]: Created slice Slice /system/systemd-fsck.
[    3.074668] systemd[1]: Created slice Slice /system/systemd-zram-setup.
[    3.075237] systemd[1]: Created slice User and Session Slice.
[    3.075861] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    3.076722] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[    3.077331] systemd[1]: Expecting device /dev/disk/by-uuid/0f1ef58b-496b=
-48fd-a17b-6cbc03a2c8ee...
[    3.077349] systemd[1]: Expecting device /dev/disk/by-uuid/CAB7-E233...
[    3.077413] systemd[1]: Expecting device /dev/zram0...
[    3.078106] systemd[1]: Reached target Login Prompts.
[    3.078178] systemd[1]: Reached target Local Integrity Protected Volumes.
[    3.078914] systemd[1]: Reached target Remote File Systems.
[    3.079648] systemd[1]: Reached target Slice Units.
[    3.080396] systemd[1]: Reached target System Time Set.
[    3.081187] systemd[1]: Reached target Local Verity Protected Volumes.
[    3.082011] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    3.082800] systemd[1]: Listening on LVM2 poll daemon socket.
[    3.086910] systemd[1]: Listening on RPCbind Server Activation Socket.
[    3.086972] systemd[1]: Reached target RPC Port Mapper.
[    3.090863] systemd[1]: Listening on Process Core Dump Socket.
[    3.091427] systemd[1]: Listening on Credential Encryption/Decryption.
[    3.091766] systemd[1]: Listening on Journal Socket (/dev/log).
[    3.091882] systemd[1]: Listening on Journal Sockets.
[    3.092668] systemd[1]: Listening on Network Service Netlink Socket.
[    3.093507] systemd[1]: Listening on Userspace Out-Of-Memory (OOM) Kille=
r Socket.
[    3.094261] systemd[1]: TPM PCR Measurements was skipped because of an u=
nmet condition check (ConditionSecurity=3Dmeasured-uki).
[    3.094281] systemd[1]: Make TPM PCR Policy was skipped because of an un=
met condition check (ConditionSecurity=3Dmeasured-uki).
[    3.094347] systemd[1]: Listening on udev Control Socket.
[    3.095081] systemd[1]: Listening on udev Kernel Socket.
[    3.096069] systemd[1]: Mounting Huge Pages File System...
[    3.097315] systemd[1]: Mounting POSIX Message Queue File System...
[    3.097870] systemd[1]: Mounting NFSD configuration filesystem...
[    3.098764] systemd[1]: Mounting Kernel Debug File System...
[    3.099501] systemd[1]: Mounting Kernel Trace File System...
[    3.100636] systemd[1]: Load AppArmor profiles was skipped because of an=
 unmet condition check (ConditionSecurity=3Dapparmor).
[    3.100674] systemd[1]: Kernel Module supporting RPCSEC_GSS was skipped =
because of an unmet condition check (ConditionPathExists=3D/etc/krb5.keytab=
).
[    3.101609] systemd[1]: Starting Create List of Static Device Nodes...
[    3.102310] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling...
[    3.103868] systemd[1]: Starting Load Kernel Module configfs...
[    3.104675] systemd[1]: Starting Load Kernel Module dm_mod...
[    3.105735] systemd[1]: Starting Load Kernel Module drm...
[    3.106775] systemd[1]: Starting Load Kernel Module fuse...
[    3.107712] systemd[1]: Starting Load Kernel Module loop...
[    3.108072] systemd[1]: File System Check on Root Device was skipped bec=
ause of an unmet condition check (ConditionPathIsReadWrite=3D!/).
[    3.108106] systemd[1]: Clear Stale Hibernate Storage Info was skipped b=
ecause of an unmet condition check (ConditionPathExists=3D/sys/firmware/efi=
/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[    3.109450] systemd[1]: Starting Journal Service...
[    3.111412] systemd[1]: Starting Load Kernel Modules...
[    3.112520] systemd[1]: Starting Userspace Out-Of-Memory (OOM) Killer...
[    3.112544] systemd[1]: TPM PCR Machine ID Measurement was skipped becau=
se of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    3.113904] systemd[1]: Starting Remount Root and Kernel File Systems...
[    3.113962] systemd[1]: Early TPM SRK Setup was skipped because of an un=
met condition check (ConditionSecurity=3Dmeasured-uki).
[    3.114669] systemd[1]: Starting Load udev Rules from Credentials...
[    3.117874] loop: module loaded
[    3.117886] device-mapper: uevent: version 1.0.3
[    3.117931] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised:=
 dm-devel@lists.linux.dev
[    3.118331] systemd[1]: Starting Coldplug All udev Devices...
[    3.119197] systemd[1]: Starting Virtual Console Setup...
[    3.121040] systemd[1]: Mounted Huge Pages File System.
[    3.121125] systemd[1]: Mounted POSIX Message Queue File System.
[    3.122129] systemd[1]: Mounted Kernel Debug File System.
[    3.122946] systemd[1]: Mounted Kernel Trace File System.
[    3.124091] systemd[1]: Finished Create List of Static Device Nodes.
[    3.124928] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[    3.125043] systemd[1]: Finished Load Kernel Module configfs.
[    3.125890] systemd[1]: modprobe@dm_mod.service: Deactivated successfull=
y.
[    3.125997] systemd[1]: Finished Load Kernel Module dm_mod.
[    3.126879] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    3.126981] systemd[1]: Finished Load Kernel Module drm.
[    3.127645] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    3.127741] systemd[1]: Finished Load Kernel Module fuse.
[    3.128344] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    3.128445] systemd[1]: Finished Load Kernel Module loop.
[    3.143107] systemd-journald[345]: Collecting audit messages is disabled.
[    3.146922] systemd[1]: Finished Load udev Rules from Credentials.
[    3.146983] EXT4-fs (nvme0n1p1): re-mounted 7f701c1e-4cf2-46b9-88a1-184e=
3dfef17e r/w. Quota mode: none.
[    3.147575] systemd[1]: Finished Remount Root and Kernel File Systems.
[    3.148918] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    3.148940] sd 4:0:0:0: Attached scsi generic sg1 type 0
[    3.150369] RPC: Registered named UNIX socket transport module.
[    3.150370] RPC: Registered udp transport module.
[    3.150371] RPC: Registered tcp transport module.
[    3.150371] RPC: Registered tcp-with-tls transport module.
[    3.150371] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    3.153936] i2c_dev: i2c /dev entries driver
[    3.183259] systemd[1]: Mounting FUSE Control File System...
[    3.183743] systemd[1]: Mounting Kernel Configuration File System...
[    3.186910] systemd[1]: Starting Rebuild Hardware Database...
[    3.187657] systemd[1]: Starting Load/Save OS Random Seed...
[    3.188629] systemd[1]: Repartition Root Disk was skipped because no tri=
gger condition checks were met.
[    3.189322] systemd[1]: Starting Create Static Device Nodes in /dev grac=
efully...
[    3.189345] systemd[1]: TPM SRK Setup was skipped because of an unmet co=
ndition check (ConditionSecurity=3Dmeasured-uki).
[    3.189821] systemd[1]: Started Journal Service.
[    3.207769] systemd-journald[345]: Received client request to flush runt=
ime journal.
[    3.898915] zram0: detected capacity change from 0 to 32491520
[    3.902127] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    3.921275] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    3.927581] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: 8F1F6436-9F42-4=
2C8-BADC-0E9424F20C9A has zero instances
[    3.927584] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: 8F1F6435-9F42-4=
2C8-BADC-0E9424F20C9A has zero instances
[    3.927585] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: 7391A661-223A-4=
7DB-A77A-7BE84C60822D has zero instances
[    3.927586] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: DF4E63B6-3BBC-4=
858-9737-C74F82F821F3 has zero instances
[    3.933664] mmc0: SDHCI controller on PCI [0000:00:14.5] using ADMA 64-b=
it
[    3.937630] raid6: skipped pq benchmark and selected avx2x4
[    3.937633] raid6: using avx2x2 recovery algorithm
[    3.940834] xor: automatically using best checksumming function   avx   =
   =20
[    3.948101] EDAC ie31200: No ECC support
[    3.948132] EDAC ie31200: No ECC support
[    3.950086] intel_pmc_core INT33A1:00:  initialized
[    3.951000] intel_pch_thermal 0000:00:12.0: enabling device (0100 -> 010=
2)
[    3.977425] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[    3.980103] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    3.980256] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db1=
8c600'
[    3.986448] platform regulatory.0: Direct firmware load for regulatory.d=
b failed with error -2
[    3.986452] cfg80211: failed to load regulatory.db
[    4.012433] Adding 16245756k swap on /dev/zram0.  Priority:100 extents:1=
 across:16245756k SSDsc
[    4.103025] Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
[    4.115696] Bluetooth: Core ver 2.22
[    4.115707] NET: Registered PF_BLUETOOTH protocol family
[    4.115708] Bluetooth: HCI device and connection manager initialized
[    4.115711] Bluetooth: HCI socket layer initialized
[    4.115713] Bluetooth: L2CAP socket layer initialized
[    4.115716] Bluetooth: SCO socket layer initialized
[    4.117464] input: PC Speaker as /devices/platform/pcspkr/input/input6
[    4.126688] intel-lpss 0000:00:15.0: enabling device (0100 -> 0102)
[    4.126882] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    4.127537] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    4.130456] Creating 1 MTD partitions on "0000:00:1f.5":
[    4.130459] 0x000000000000-0x000001000000 : "BIOS"
[    4.141629] input: HP WMI hotkeys as /devices/virtual/input/input7
[    4.142049] intel-lpss 0000:00:15.1: enabling device (0100 -> 0102)
[    4.159473] idma64 idma64.1: Found Intel integrated DMA 64-bit
[    4.170160] intel-lpss 0000:00:1e.0: enabling device (0100 -> 0102)
[    4.170413] idma64 idma64.2: Found Intel integrated DMA 64-bit
[    4.195565] BTRFS: device label DATA devid 1 transid 20394 /dev/sda1 (8:=
1) scanned by mount (567)
[    4.195873] BTRFS info (device sda1): first mount of filesystem 0f1ef58b=
-496b-48fd-a17b-6cbc03a2c8ee
[    4.195879] BTRFS info (device sda1): using crc32c (crc32c-intel) checks=
um algorithm
[    4.195882] BTRFS info (device sda1): using free-space-tree
[    4.202427] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    4.202464] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    4.204951] r8169 0000:04:00.0: can't disable ASPM; OS doesn't have ASPM=
 control
[    4.205755] i2c i2c-2: Successfully instantiated SPD at 0x50
[    4.205781] dw-apb-uart.2: ttyS4 at MMIO 0xa091e000 (irq =3D 20, base_ba=
ud =3D 7500000) is a 16550A
[    4.220293] iTCO_vendor_support: vendor-support=3D0
[    4.221233] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360=
 ms ovfl timer
[    4.221235] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    4.221236] RAPL PMU: hw unit of domain package 2^-14 Joules
[    4.221237] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    4.221951] usbcore: registered new interface driver btusb
[    4.226291] Bluetooth: hci0: RTL: examining hci_ver=3D08 hci_rev=3D000c =
lmp_ver=3D08 lmp_subver=3D8821
[    4.226298] cryptd: max_cpu_qlen set to 1000
[    4.227296] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
[    4.227297] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_fw.bin
[    4.228682] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_config.bin
[    4.228757] Bluetooth: hci0: RTL: cfg_sz 10, total sz 34926
[    4.229030] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=3D6=
, TCOBASE=3D0x0400)
[    4.229208] iTCO_wdt iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=
=3D0)
[    4.229563] r8169 0000:04:00.0 eth0: RTL8168h/8111h, 9c:7b:ef:30:a7:6b, =
XID 541, IRQ 146
[    4.229566] r8169 0000:04:00.0 eth0: jumbo features [frames: 9194 bytes,=
 tx checksumming: ko]
[    4.234268] r8169 0000:04:00.0 enp4s0: renamed from eth0
[    4.235490] rtw_8821ce 0000:05:00.0: enabling device (0100 -> 0103)
[    4.236754] rtw_8821ce 0000:05:00.0: Firmware version 24.11.0, H2C versi=
on 12
[    4.241812] AES CTR mode by8 optimization enabled
[    4.243144] ee1004 2-0050: 512 byte EE1004-compliant SPD EEPROM, read-on=
ly
[    4.252491] snd_hda_intel 0000:00:1f.3: enabling device (0100 -> 0102)
[    4.252891] snd_hda_intel 0000:03:00.1: enabling device (0100 -> 0102)
[    4.253045] snd_hda_intel 0000:03:00.1: Force to non-snoop mode
[    4.262546] input: HDA ATI HDMI HDMI/DP,pcm=3D3 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input8
[    4.262583] input: HDA ATI HDMI HDMI/DP,pcm=3D7 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input9
[    4.262621] input: HDA ATI HDMI HDMI/DP,pcm=3D8 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input10
[    4.262678] input: HDA ATI HDMI HDMI/DP,pcm=3D9 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input11
[    4.262702] input: HDA ATI HDMI HDMI/DP,pcm=3D10 as /devices/pci0000:00/=
0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input12
[    4.283926] rtw_8821ce 0000:05:00.0 wlp5s0: renamed from wlan0
[    4.284335] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC671: li=
ne_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:line
[    4.284338] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[    4.284340] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0x21/0x0/=
0x0/0x0/0x0)
[    4.284341] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0
[    4.284342] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    4.284343] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=3D0x18
[    4.284344] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=3D0x19
[    4.284345] snd_hda_codec_realtek hdaudioC0D0:      Line=3D0x1b
[    4.327592] input: HDA Intel PCH Rear Mic as /devices/pci0000:00/0000:00=
:1f.3/sound/card0/input13
[    4.327631] input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:0=
0:1f.3/sound/card0/input14
[    4.327662] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1f.=
3/sound/card0/input15
[    4.327695] input: HDA Intel PCH Line Out as /devices/pci0000:00/0000:00=
:1f.3/sound/card0/input16
[    4.327725] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input17
[    4.380971] intel_tcc_cooling: Programmable TCC Offset detected
[    4.693377] Bluetooth: hci0: RTL: fw version 0x75b8f098
[    6.691816] [drm] amdgpu kernel modesetting enabled.
[    6.691943] amdgpu: Virtual CRAT table created for CPU
[    6.691952] amdgpu: Topology: Add CPU node
[    6.691983] amdgpu: Overdrive is enabled, please disable it before repor=
ting any bugs unrelated to overdrive.
[    6.692899] amdgpu 0000:03:00.0: enabling device (0106 -> 0107)
[    6.692989] [drm] initializing kernel modesetting (DIMGREY_CAVEFISH 0x10=
02:0x73FF 0x1043:0x05D5 0xC7).
[    6.693002] [drm] register mmio base: 0xA0300000
[    6.693002] [drm] register mmio size: 1048576
[    6.698104] [drm] add ip block number 0 <nv_common>
[    6.698106] [drm] add ip block number 1 <gmc_v10_0>
[    6.698107] [drm] add ip block number 2 <navi10_ih>
[    6.698108] [drm] add ip block number 3 <psp>
[    6.698109] [drm] add ip block number 4 <smu>
[    6.698109] [drm] add ip block number 5 <dm>
[    6.698111] [drm] add ip block number 6 <gfx_v10_0>
[    6.698112] [drm] add ip block number 7 <sdma_v5_2>
[    6.698112] [drm] add ip block number 8 <vcn_v3_0>
[    6.698113] [drm] add ip block number 9 <jpeg_v3_0>
[    6.698133] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from VFCT
[    6.698135] amdgpu: ATOM BIOS: 115-D534P00-100
[    6.759610] Console: switching to colour dummy device 80x25
[    6.782695] intel_rapl_common: Found RAPL domain package
[    6.782698] intel_rapl_common: Found RAPL domain core
[    6.782699] intel_rapl_common: Found RAPL domain dram
[    6.784215] amdgpu 0000:03:00.0: vgaarb: deactivate vga console
[    6.784219] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (TMZ) featu=
re disabled as experimental (default)
[    6.784259] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, f=
ragment size is 9-bit
[    6.784267] amdgpu 0000:03:00.0: amdgpu: VRAM: 8176M 0x0000008000000000 =
- 0x00000081FEFFFFFF (8176M used)
[    6.784270] amdgpu 0000:03:00.0: amdgpu: GART: 512M 0x0000000000000000 -=
 0x000000001FFFFFFF
[    6.784284] [drm] Detected VRAM RAM=3D8176M, BAR=3D256M
[    6.784285] [drm] RAM width 128bits GDDR6
[    6.784477] [drm] amdgpu: 8176M of VRAM memory ready
[    6.784480] [drm] amdgpu: 7932M of GTT memory ready.
[    6.784498] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    6.784587] [drm] PCIE GART of 512M enabled (table at 0x0000008002000000=
).
[    8.382729] amdgpu 0000:03:00.0: amdgpu: STB initialized to 2048 entries
[    8.382938] [drm] Loading DMUB firmware via PSP: version=3D0x02020020
[    8.383257] [drm] use_doorbell being set to: [true]
[    8.383267] [drm] use_doorbell being set to: [true]
[    8.383277] [drm] Found VCN firmware Version ENC: 1.33 DEC: 4 VEP: 0 Rev=
ision: 3
[    8.449989] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000=
000 for PSP TMR
[    8.552409] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is n=
ot available
[    8.569429] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta=
 ucode is not available
[    8.569458] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x000=
0000f, smu fw if version =3D 0x00000013, smu fw program =3D 0, version =3D =
0x003b3100 (59.49.0)
[    8.569467] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not match=
ed
[    8.569501] amdgpu 0000:03:00.0: amdgpu: use vbios provided pptable
[    8.615558] amdgpu 0000:03:00.0: amdgpu: SMU is initialized successfully!
[    8.616008] [drm] Display Core v3.2.310 initialized on DCN 3.0.2
[    8.616010] [drm] DP-HDMI FRL PCON supported
[    8.617254] [drm] DMUB hardware initialized: version=3D0x02020020
[    8.620354] snd_hda_intel 0000:03:00.1: bound 0000:03:00.0 (ops amdgpu_d=
m_audio_component_bind_ops [amdgpu])
[    9.061093] [drm] kiq ring mec 2 pipe 1 q 0
[    9.109820] amdgpu: HMM registered 8176MB device memory
[    9.111174] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    9.111183] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    9.111392] amdgpu: Virtual CRAT table created for GPU
[    9.111495] amdgpu: Topology: Add dGPU node [0x73ff:0x1002]
[    9.111497] kfd kfd: amdgpu: added device 1002:73ff
[    9.111513] amdgpu 0000:03:00.0: amdgpu: SE 2, SH per SE 2, CU per SH 8,=
 active_cu_number 28
[    9.111516] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng =
0 on hub 0
[    9.111517] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng =
1 on hub 0
[    9.111518] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 4 on hub 0
[    9.111519] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 5 on hub 0
[    9.111520] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 6 on hub 0
[    9.111520] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 7 on hub 0
[    9.111521] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 8 on hub 0
[    9.111522] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 9 on hub 0
[    9.111523] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 10 on hub 0
[    9.111523] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 11 on hub 0
[    9.111524] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv en=
g 12 on hub 0
[    9.111525] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 o=
n hub 0
[    9.111526] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 o=
n hub 0
[    9.111527] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng =
0 on hub 8
[    9.111527] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv en=
g 1 on hub 8
[    9.111528] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv en=
g 4 on hub 8
[    9.111529] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5=
 on hub 8
[    9.113417] amdgpu 0000:03:00.0: amdgpu: Using BACO for runtime pm
[    9.114031] [drm] Initialized amdgpu 3.59.0 for 0000:03:00.0 on minor 1
[    9.119606] fbcon: amdgpudrmfb (fb0) is primary device
[    9.119842] [drm] pre_validate_dsc:1593 MST_DSC dsc precompute is not ne=
eded
[    9.404802] Console: switching to colour frame buffer device 240x67
[    9.440310] amdgpu 0000:03:00.0: [drm] fb0: amdgpudrmfb frame buffer dev=
ice
[    9.602148] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    9.602151] Bluetooth: BNEP filters: protocol multicast
[    9.602153] Bluetooth: BNEP socket layer initialized
[    9.604523] Bluetooth: MGMT ver 1.23
[    9.609491] NET: Registered PF_ALG protocol family
[    9.760953] nvme nvme0: using unchecked data buffer
[    9.841576] block nvme0n1: No UUID available providing old NGUID
[    9.906313] Generic FE-GE Realtek PHY r8169-0-400:00: attached PHY drive=
r (mii_bus:phy_addr=3Dr8169-0-400:00, irq=3DMAC)
[   10.076556] r8169 0000:04:00.0 enp4s0: Link is Down
[   10.631873] bridge: filtering via arp/ip/ip6tables is no longer availabl=
e by default. Update your scripts to load br_netfilter if you need this.
[   10.755120] u32 classifier
[   10.755122]     Performance counters on
[   10.755123]     input device check on
[   10.755123]     Actions configured
[   12.722275] kvm: Running KVM with ignore_msrs=3D1 and report_ignored_msr=
s=3D0 is not a
               a supported configuration.  Lying to the guest about the exi=
stence of MSRs
               may cause the guest operating system to hang or produce erro=
rs.  If a guest
               does not run without ignore_msrs=3D1, please report it to kv=
m@vger.kernel.org.
[   13.575264] r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[   13.577053] r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[   15.965083] RPC: Registered rdma transport module.
[   15.965086] RPC: Registered rdma backchannel transport module.
[   16.074692] NFSD: Using nfsdcld client tracking operations.
[   16.074696] NFSD: no clients to reclaim, skipping NFSv4 grace period (ne=
t f0000000)
[   16.573534] Initializing XFRM netlink socket
[   16.673740] warning: `pmdalinux' uses wireless extensions which will sto=
p working for Wi-Fi 7 hardware; use nl80211

--43kaatzv772p76hd--

--rsh5k4coxdzlgj7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmeBSQwACgkQwEfU8yi1
JYVzZxAAjrqcJ6VSa0q4I+Zy5cHgK9UeWIfSpUq4xLMzSViV7MNWautNtRBGh9zm
UW8WOVZ+LJfXkoZc9F7ATg1ir+/688pRvOJ7WW+Bq8S1xPaloZALsi5HiHmUh2q/
AERt5g4owlzLriDqKxvhCd2VRHuRqPSt2csJmegPZq/oF9CiELQwdwS/CPphGSdB
Bt+zz2AeZSdB7f97rIxQYtN/510VdQV9OqsdZk83dCqxNzGLlpR7YP5FJH5plg2P
/YmcNQEp7/tIZVlQxVna8Sl65C8reJOXExAw63PvsPNFfoVPUJUcKiTZ++pgHmyj
5lK10f1wkOWpVFqCwCY/xXoJHsJ4u297iRgSzSsKLnMLYLKYV47m1kwMn7w9vZNb
6VhevXLxNhOmK5smWTISJ5qmBzxlYcDhB6RLG6+2ApN6a0qm1jUaxvImX8Sk+4TY
ngVYF11XY26XVAKNaV8aZsKzYLDiRgYP5HVyUSkfekqMCxsvdkWRh5Qj2IC0BmF2
7gQiBMV3f/rcULMNWNQEP1WGKF0Ut9QMUyqRnBhoagVriTVp20SzDTNDZQ7h6hF+
H2o4cpMTYxZiMo3KISpVfAxOTXXEfXa1hUATgwA7j2KE6Vr1G+KD2kq03Qh7dD/i
AWsN6pYJ5bfjrxwTMowD6sYvMajiAO3CZdefmH5JaV6Hvj22ENs=
=PMG1
-----END PGP SIGNATURE-----

--rsh5k4coxdzlgj7m--
