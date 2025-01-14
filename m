Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A89B18A6AE;
	Tue, 14 Jan 2025 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736870838; cv=none; b=uakphqQr76ZljbAIJV3++Sq/5cOLFns6GvQ512fF0vNTNvwR3wSjjzDc3NOPNuhW04WdJXsSCMSqDvoFiWg9jkf2It10JavHQ8lxhDN1zlnDUycEl4qSYIlm9kespAvSm173FR2kfguqV0S5IoiZ5XVR9BdWUg3FPTENFDOALSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736870838; c=relaxed/simple;
	bh=zPCY7KBTKUXokiixH9v2f7oc7qpls8q7NKW/ObPQzQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jU+CjVFEOkLr+htyTaNPfILfYl8+jalbWyXZGeF3LgbdYbfrg3jYambaM+PDRJcRZbCWDe9m3HNuewuj6fKVr4jbofg7TQf+goaEc1kaD5oZp2istie3DiRa3aEemljah9ga9/zsR+4cwPZIHxQEs06WxEnJKKOGJTXHmm/7fyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=SqaRKukp; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="SqaRKukp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1736870808; x=1737475608; i=christian@heusel.eu;
	bh=m1BUHaXK7aDZ9LZBxZuf9QiO/Fhpsxstxn3NuNZnfGU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SqaRKukplP2FuvMAhjsTTBXpWbCXqUxcXLLuYFHC3uS10u4FAnW7V+LZVZREG+gV
	 CxOywEyg5So8PD/toq/j0kIVuXE+ZIa1RxTKBAKs+OQYEUjfyMH5XcgMwvrAK5cjt
	 uIMcDh/ayR3+X7U6jFeFGwpeeV5QNKeMcYcICSuiectLeo+eHMWsXL/uYnX9FsuRV
	 Z/q++Hr/qOgPtGQdn1pcYBphWs254dRpSFQgHd23DBEgM50yOBysF6E1+OKENSsVI
	 dt9GfZbgjwc54fy3yaNSxY/M5USLxPl6V+YA7uNubATY+IagaFRF9I8L1Er3Mzhik
	 oW2YhBB0GmWtw3uQxQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MLi4W-1tpOqe0jR2-00JA0N; Tue, 14
 Jan 2025 17:06:48 +0100
Date: Tue, 14 Jan 2025 17:06:46 +0100
From: Christian Heusel <christian@heusel.eu>
To: Niklas Cassel <cassel@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION][BISECTED] BU40N Blu-Ray drive broken since
 7627a0edef54
Message-ID: <67357bab-9de8-41ff-a43f-3da2ace5a814@heusel.eu>
References: <e2be6f70-dff6-4b79-bd49-70ec7e27fc1c@heusel.eu>
 <Z4EDf4ecHyfTq3Hp@x1-carbon>
 <69589dad-c0c8-4a72-9f3d-c1b0c29c96c1@heusel.eu>
 <e167b28c-94a2-45bf-8330-2487baf7199b@heusel.eu>
 <Z4U-rc3VUeegHGAg@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z7h6ajaf77v4xvnj"
Content-Disposition: inline
In-Reply-To: <Z4U-rc3VUeegHGAg@ryzen>
X-Provags-ID: V03:K1:aTfVsNeLn63UJVga9xA6gfkImpcm4oLKuau1fIQeHvehJ+/7eSE
 UUUavdIXoxH5prKVtjjPhy14cVsN9CGVUNZh+QzDwpAYnKTKNO7wWRggHYzTlN5o/5V2mnh
 tD7AoegrYsMm4SZBibf0jJ4VljPSTfEwrqMOCmec1MFB84jJv0K4+6YZJAeQlxU9HdjQoJK
 ycc42JnU7grOp84EbAejQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i7g+ledb2S0=;o1P3JsjelKM1eitG2KAt+o+BOz7
 OxzYm11UZY6d4uQyHFpDXSYvj52xYrCypUz7RiUn5Pjuw+0szn0671Z7XAz71ZVkAu6nOWdv8
 n2a0fDv5QgKximH/pzehcREEg+7yIcEkrWc+ObXg7aonVbmsKz7pyUqFzs7C9XCrV5xZNNXXu
 revmJlFf9nrx+qLGB0tvbnavn6xAqfALMrxLSIrgNzOUzAPZcZ9T89Gwk4EKMEvKPn+zMpkof
 YQ9UAZDJalXEs5bwWEaEURr2f+3+KYRiVR1XgNThFXwgFnbWNlisdxBcmRK29ViosPTFlBL2Q
 d+UNyrj5JM/VBakLlCsWc/uE7nzJC0RxbDojekrmUdpsOxd2cJiyVOvNtYxPpofPSF7Ya4ZiA
 fKENWNH+YYVmn/YdCBdly0pbxaEDAIoHV4MlyPXqKkHZQ5pAZptWRVZ1m56brgrcLI8x01337
 58cjz1PjjOwVlibKEBT0IVeFaOQAhvb67Ls1MnbfUeG6KNhudWHRbVEqdcv6PVzGzhIDMfd3j
 fQLGJVMAWA/QvHcCfp5gfO6kdUkXp3rSfUErB5M8nFSinI2JBNpmIrrUKtWM3YmcC+f4YMJg3
 ocZ40jWY4Exk51k6o7kWFdXH7BO6M1jGV5sxvx+dFPWosMBhDU5t99idXsPgsBJ9Pg9rKeT/a
 LSkSYztYRpTjNLXWA3/Wgm+iZ+3XBRJw6bexOC245ZwVnUQLU7KzSwU3NyS3ZxlgD4ApVLgZf
 Wl1GE/HeGMA92i5VYOLkVnfkHFNGBZxxvMCMERLsthDFrf2ezlFQC0QFmMLRzUQa5p736nUpK
 R+3rljFbBBAAhCuln3legrKJzF2m0GKYgAC5yFr+tBdx5ODxQ4KJYLhsllrhqASqkE//+FsTk
 wFC258loWtCw9t5ssMK9/trveDK9RsqIdERGeD4jMytG109C+ckw2yhyVIaRSyQcjCqyIyuzV
 UlI1/8Sn2ko63x3Rj0cWsMWoHDBU8eqNPMoWqqMwpLf0CQrQWdlOcw3jNozbIc/I29zSKSe/4
 LpdZtcCn2semx1W0BCVKMPSCKAYkzwg6UXp/pM9k1BuzgTeEBBcZaXpJJQsSeKb9ZbeLJKPMH
 r1S7Qlmb8o44thcHJlAr8J12AFXOMq0G4QnkUgMoa6ODrDD/ixQg==


--z7h6ajaf77v4xvnj
Content-Type: multipart/mixed; protected-headers=v1;
	boundary="ukgy5675ubv2aggz"
Content-Disposition: inline
Subject: Re: [REGRESSION][BISECTED] BU40N Blu-Ray drive broken since
 7627a0edef54
MIME-Version: 1.0


--ukgy5675ubv2aggz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Niklas,

On 25/01/13 05:26PM, Niklas Cassel wrote:
> Hello Christian,
>=20
> On Sat, Jan 11, 2025 at 05:41:10PM +0100, Christian Heusel wrote:
> > On 25/01/10 05:21PM, Christian Heusel wrote:
> > > On 25/01/10 12:24PM, Niklas Cassel wrote:
> > > > On Fri, Jan 10, 2025 at 10:04:46AM +0100, Christian Heusel wrote:
> > > >
> > > > > So if anyone has feedback on why the patch does not work or any
> > > > > alternative ideas for a solution that would be highly appreciated!
> >=20
> > So weirdly the quirk from the patch for the same kernel _does work_ when
> > the user passes the kernel parameter "ahci.mobile_lpm_policy=3D1":
> >=20
> > [   24.035361] ata4.00: Model 'HL-DT-ST BD-RE BU40N', rev '1.03', apply=
ing quirks: nolpm
> >=20
> > Any idea why that could be? Is it maybe not the device itself but the
> > controller that it connects to that is borked and in need of the quirk?
>=20
> So from the 6.6.69-1-lts log, which you claim is working, we see this:
> <dmesg-snip>
>
> Since this is running AHCI, default reset is ahci_do_hardreset() (COMRESE=
T).
>=20
> The SATA link up/link down messages are printed after resetting each port.
> We can see that we get link up on ata3 and ata5, but link is down on ata6
> and ata4.
>=20
> Seeing link down after a reset is not correct, and I think we should first
> focus on seeing link up for ata4, before knowing if we also need a quirk =
or
> not.

Thanks for your detailed explanation!

> Could you please try this patch?
>=20
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 9c76fb1ad2ec..b0bff5fe3e03 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -660,7 +660,7 @@ int sata_link_hardreset(struct ata_link *link, const =
unsigned int *timing,
>         /* Couldn't find anything in SATA I/II specs, but AHCI-1.1
>          * 10.4.2 says at least 1 ms.
>          */
> -       ata_msleep(link->ap, 1);
> +       ata_msleep(link->ap, 20 + 10 + 1);
> =20
>         /* bring link back */
>         rc =3D sata_link_resume(link, timing, deadline);
>=20
>=20
>=20
> If that works to get link up after reset, you can continue to see if the
> LPM quirk is needed or not. (And I will need to write a proper fix so
> that we sleep the correct amount of time while holding PxSCTL.DET in 1).

Sadly the patch applied on top of 6.13-rc7 did not work, atleast it did
not immediately bring the device back up again after the reset. You can
see the users full answer [here][0]. I also attached the dmesg, but as
that cuts off rather quickly I have also asked the user to do a longer
test.

> Kind regards,
> Niklas

Cheers,
Chris

[0]: https://bbs.archlinux.org/viewtopic.php?pid=3D2220082#p2220082

--ukgy5675ubv2aggz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="linux-mainline-6.13-rc7-1.1-dmesg.log"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Linux version 6.13.0-rc7-1.1-mainline-dirty (linux-mainline@=
archlinux) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU Binutils) 2.43.1) #1 SMP=
 PREEMPT_DYNAMIC Mon, 13 Jan 2025 16:56:59 +0000
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
[    0.000848] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000850] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000859] last_pfn =3D 0x46e000 max_arch_pfn =3D 0x400000000
[    0.000863] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built fr=
om 10 variable MTRRs
[    0.000865] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.001140] last_pfn =3D 0x8dc0f max_arch_pfn =3D 0x400000000
[    0.008594] esrt: Reserving ESRT space from 0x0000000088b80398 to 0x0000=
000088b80420.
[    0.008599] e820: update [mem 0x88b80000-0x88b80fff] usable =3D=3D> rese=
rved
[    0.008615] Using GB pages for direct mapping
[    0.008961] Secure boot disabled
[    0.008962] RAMDISK: [mem 0x7bf3d000-0x7d400fff]
[    0.008982] ACPI: Early table checksum verification disabled
[    0.008985] ACPI: RSDP 0x000000008A6BE000 000024 (v02 HPQOEM)
[    0.008988] ACPI: XSDT 0x000000008A6BE0C0 0000FC (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.008993] ACPI: FACP 0x000000008A704DC8 000114 (v06 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.008998] ACPI: DSDT 0x000000008A6BE248 046B7A (v02 HPQOEM SLIC-CPC 01=
072009 INTL 20160527)
[    0.009001] ACPI: FACS 0x000000008AB93080 000040
[    0.009003] ACPI: APIC 0x000000008A704EE0 0000BC (v04 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009006] ACPI: FPDT 0x000000008A704FA0 000044 (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009009] ACPI: FIDT 0x000000008A704FE8 00009C (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009012] ACPI: MCFG 0x000000008A705088 00003C (v01 HPQOEM SLIC-CPC 01=
072009 MSFT 00000097)
[    0.009014] ACPI: SSDT 0x000000008A7050C8 001B5F (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.009017] ACPI: MSDM 0x000000008A706C28 000055 (v03 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009019] ACPI: SSDT 0x000000008A706C80 000060 (v01 HPQOEM SLIC-CPC 00=
000001 INTL 20160527)
[    0.009022] ACPI: SSDT 0x000000008A706CE0 000060 (v01 HPQOEM SLIC-CPC 00=
000001 INTL 20160527)
[    0.009025] ACPI: SSDT 0x000000008A706D40 0031C6 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.009027] ACPI: SSDT 0x000000008A709F08 00241B (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009030] ACPI: HPET 0x000000008A70C328 000038 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009032] ACPI: SSDT 0x000000008A70C360 001D39 (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009035] ACPI: SSDT 0x000000008A70E0A0 000FAE (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009038] ACPI: SSDT 0x000000008A70F050 000BDF (v02 HPQOEM SLIC-CPC 00=
000000 INTL 20160527)
[    0.009040] ACPI: UEFI 0x000000008A70FC30 000042 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009043] ACPI: LPIT 0x000000008A70FC78 000094 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009045] ACPI: SSDT 0x000000008A70FD10 0027DE (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009048] ACPI: SSDT 0x000000008A7124F0 0014E2 (v02 HPQOEM SLIC-CPC 00=
000000 INTL 20160527)
[    0.009050] ACPI: DBGP 0x000000008A7139D8 000034 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009053] ACPI: DBG2 0x000000008A713A10 000054 (v00 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009056] ACPI: SSDT 0x000000008A713A68 001B67 (v02 HPQOEM SLIC-CPC 00=
001000 INTL 20160527)
[    0.009058] ACPI: DMAR 0x000000008A7155D0 000070 (v01 HPQOEM SLIC-CPC 00=
000002      01000013)
[    0.009061] ACPI: VFCT 0x000000008A715640 00B284 (v01 HPQOEM SLIC-CPC 00=
000001 AMD  31504F47)
[    0.009063] ACPI: BGRT 0x000000008A7208C8 000038 (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009066] ACPI: TPM2 0x000000008A720900 000034 (v04 HPQOEM SLIC-CPC 00=
000001 AMI  00000000)
[    0.009068] ACPI: WSMT 0x000000008A720938 000028 (v01 HPQOEM SLIC-CPC 01=
072009 AMI  00010013)
[    0.009071] ACPI: Reserving FACP table memory at [mem 0x8a704dc8-0x8a704=
edb]
[    0.009072] ACPI: Reserving DSDT table memory at [mem 0x8a6be248-0x8a704=
dc1]
[    0.009073] ACPI: Reserving FACS table memory at [mem 0x8ab93080-0x8ab93=
0bf]
[    0.009074] ACPI: Reserving APIC table memory at [mem 0x8a704ee0-0x8a704=
f9b]
[    0.009075] ACPI: Reserving FPDT table memory at [mem 0x8a704fa0-0x8a704=
fe3]
[    0.009075] ACPI: Reserving FIDT table memory at [mem 0x8a704fe8-0x8a705=
083]
[    0.009076] ACPI: Reserving MCFG table memory at [mem 0x8a705088-0x8a705=
0c3]
[    0.009077] ACPI: Reserving SSDT table memory at [mem 0x8a7050c8-0x8a706=
c26]
[    0.009078] ACPI: Reserving MSDM table memory at [mem 0x8a706c28-0x8a706=
c7c]
[    0.009078] ACPI: Reserving SSDT table memory at [mem 0x8a706c80-0x8a706=
cdf]
[    0.009079] ACPI: Reserving SSDT table memory at [mem 0x8a706ce0-0x8a706=
d3f]
[    0.009080] ACPI: Reserving SSDT table memory at [mem 0x8a706d40-0x8a709=
f05]
[    0.009081] ACPI: Reserving SSDT table memory at [mem 0x8a709f08-0x8a70c=
322]
[    0.009081] ACPI: Reserving HPET table memory at [mem 0x8a70c328-0x8a70c=
35f]
[    0.009082] ACPI: Reserving SSDT table memory at [mem 0x8a70c360-0x8a70e=
098]
[    0.009083] ACPI: Reserving SSDT table memory at [mem 0x8a70e0a0-0x8a70f=
04d]
[    0.009084] ACPI: Reserving SSDT table memory at [mem 0x8a70f050-0x8a70f=
c2e]
[    0.009084] ACPI: Reserving UEFI table memory at [mem 0x8a70fc30-0x8a70f=
c71]
[    0.009085] ACPI: Reserving LPIT table memory at [mem 0x8a70fc78-0x8a70f=
d0b]
[    0.009086] ACPI: Reserving SSDT table memory at [mem 0x8a70fd10-0x8a712=
4ed]
[    0.009087] ACPI: Reserving SSDT table memory at [mem 0x8a7124f0-0x8a713=
9d1]
[    0.009088] ACPI: Reserving DBGP table memory at [mem 0x8a7139d8-0x8a713=
a0b]
[    0.009088] ACPI: Reserving DBG2 table memory at [mem 0x8a713a10-0x8a713=
a63]
[    0.009089] ACPI: Reserving SSDT table memory at [mem 0x8a713a68-0x8a715=
5ce]
[    0.009090] ACPI: Reserving DMAR table memory at [mem 0x8a7155d0-0x8a715=
63f]
[    0.009091] ACPI: Reserving VFCT table memory at [mem 0x8a715640-0x8a720=
8c3]
[    0.009092] ACPI: Reserving BGRT table memory at [mem 0x8a7208c8-0x8a720=
8ff]
[    0.009092] ACPI: Reserving TPM2 table memory at [mem 0x8a720900-0x8a720=
933]
[    0.009093] ACPI: Reserving WSMT table memory at [mem 0x8a720938-0x8a720=
95f]
[    0.009417] No NUMA configuration found
[    0.009418] Faking a node at [mem 0x0000000000000000-0x000000046dffffff]
[    0.009427] NODE_DATA(0) allocated [mem 0x46dfd52c0-0x46dffffff]
[    0.009682] Zone ranges:
[    0.009683]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.009684]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.009686]   Normal   [mem 0x0000000100000000-0x000000046dffffff]
[    0.009687]   Device   empty
[    0.009688] Movable zone start for each node
[    0.009690] Early memory node ranges
[    0.009691]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.009692]   node   0: [mem 0x0000000000100000-0x000000008a26ffff]
[    0.009693]   node   0: [mem 0x000000008dc0e000-0x000000008dc0efff]
[    0.009694]   node   0: [mem 0x0000000100000000-0x000000046dffffff]
[    0.009697] Initmem setup node 0 [mem 0x0000000000001000-0x000000046dfff=
fff]
[    0.009701] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.009722] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.012563] On node 0, zone DMA32: 14750 pages in unavailable ranges
[    0.029840] On node 0, zone Normal: 9201 pages in unavailable ranges
[    0.029933] On node 0, zone Normal: 8192 pages in unavailable ranges
[    0.031140] ACPI: PM-Timer IO Port: 0x1808
[    0.031146] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.031148] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.031149] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.031150] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.031150] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.031151] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.031152] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.031153] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.031213] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.031215] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.031217] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.031221] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.031222] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.031228] e820: update [mem 0x86b6d000-0x86bdffff] usable =3D=3D> rese=
rved
[    0.031241] TSC deadline timer available
[    0.031245] CPU topo: Max. logical packages:   1
[    0.031246] CPU topo: Max. logical dies:       1
[    0.031247] CPU topo: Max. dies per package:   1
[    0.031251] CPU topo: Max. threads per core:   1
[    0.031252] CPU topo: Num. cores per package:     8
[    0.031253] CPU topo: Num. threads per package:   8
[    0.031253] CPU topo: Allowing 8 present CPUs plus 0 hotplug CPUs
[    0.031266] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.031268] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0=
x000fffff]
[    0.031270] PM: hibernation: Registered nosave memory: [mem 0x7bf0f000-0=
x7bf0ffff]
[    0.031272] PM: hibernation: Registered nosave memory: [mem 0x7bf1d000-0=
x7bf1dfff]
[    0.031272] PM: hibernation: Registered nosave memory: [mem 0x7bf1e000-0=
x7bf1efff]
[    0.031274] PM: hibernation: Registered nosave memory: [mem 0x7bf3c000-0=
x7bf3cfff]
[    0.031275] PM: hibernation: Registered nosave memory: [mem 0x86b6d000-0=
x86bdffff]
[    0.031277] PM: hibernation: Registered nosave memory: [mem 0x88b80000-0=
x88b80fff]
[    0.031278] PM: hibernation: Registered nosave memory: [mem 0x8a270000-0=
x8a6a4fff]
[    0.031279] PM: hibernation: Registered nosave memory: [mem 0x8a6a5000-0=
x8a721fff]
[    0.031280] PM: hibernation: Registered nosave memory: [mem 0x8a722000-0=
x8ab95fff]
[    0.031280] PM: hibernation: Registered nosave memory: [mem 0x8ab96000-0=
x8dc0dfff]
[    0.031282] PM: hibernation: Registered nosave memory: [mem 0x8dc0f000-0=
x8fffffff]
[    0.031283] PM: hibernation: Registered nosave memory: [mem 0x90000000-0=
xfdffffff]
[    0.031283] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0=
xfe010fff]
[    0.031284] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0=
xfebfffff]
[    0.031285] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0=
xfec00fff]
[    0.031285] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0=
xfecfffff]
[    0.031286] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0=
xfed03fff]
[    0.031287] PM: hibernation: Registered nosave memory: [mem 0xfed04000-0=
xfedfffff]
[    0.031287] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0=
xfee00fff]
[    0.031288] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0=
xffffffff]
[    0.031289] [mem 0x90000000-0xfdffffff] available for PCI devices
[    0.031290] Booting paravirtualized kernel on bare hardware
[    0.031292] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 6370452778343963 ns
[    0.037700] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr=
_node_ids:1
[    0.038109] percpu: Embedded 67 pages/cpu s237568 r8192 d28672 u524288
[    0.038115] pcpu-alloc: s237568 r8192 d28672 u524288 alloc=3D1*2097152
[    0.038118] pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7=20
[    0.038137] Kernel command line: initrd=3D\intel-ucode.img initrd=3D\ini=
tramfs-linux-mainline.img root=3D/dev/nvme0n1p1 rw intel_iommu=3Don
[    0.038198] DMAR: IOMMU enabled
[    0.038222] printk: log buffer data + meta data: 131072 + 458752 =3D 589=
824 bytes
[    0.039426] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes, linear)
[    0.040023] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes, linear)
[    0.040120] Fallback order for Node 0: 0=20
[    0.040123] Built 1 zonelists, mobility grouping on.  Total pages: 41620=
63
[    0.040124] Policy zone: Normal
[    0.040293] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.040300] software IO TLB: area num 8.
[    0.082375] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D8, N=
odes=3D1
[    0.082412] ftrace: allocating 51626 entries in 202 pages
[    0.103516] ftrace: allocated 202 pages with 4 groups
[    0.103591] Dynamic Preempt: full
[    0.103636] rcu: Preemptible hierarchical RCU implementation.
[    0.103637] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D8.
[    0.103638] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.103639] 	Trampoline variant of Tasks RCU enabled.
[    0.103640] 	Rude variant of Tasks RCU enabled.
[    0.103640] 	Tracing variant of Tasks RCU enabled.
[    0.103641] rcu: RCU calculated value of scheduler-enlistment delay is 3=
0 jiffies.
[    0.103641] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D8
[    0.103647] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjus=
t=3D1 rcu_task_cpu_ids=3D8.
[    0.103649] RCU Tasks Rude: Setting shift to 3 and lim to 1 rcu_task_cb_=
adjust=3D1 rcu_task_cpu_ids=3D8.
[    0.103650] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb=
_adjust=3D1 rcu_task_cpu_ids=3D8.
[    0.109390] NR_IRQS: 524544, nr_irqs: 2048, preallocated irqs: 16
[    0.109678] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.110076] kfence: initialized - using 2097152 bytes for 255 objects at=
 0x(____ptrval____)-0x(____ptrval____)
[    0.110108] Console: colour dummy device 80x25
[    0.110110] printk: legacy console [tty0] enabled
[    0.110159] ACPI: Core revision 20240827
[    0.110404] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.110467] APIC: Switch to symmetric I/O mode setup
[    0.110469] DMAR: Host address width 39
[    0.110470] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.110476] DMAR: dmar0: reg_base_addr fed91000 ver 1:0 cap d2008c406604=
62 ecap f050da
[    0.110478] DMAR: RMRR base: 0x0000008b72e000 end: 0x0000008b977fff
[    0.110481] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 0
[    0.110482] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.110484] DMAR-IR: Queued invalidation will be enabled to support x2ap=
ic and Intr-remapping.
[    0.113506] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.113507] x2apic enabled
[    0.113576] APIC: Switched APIC routing to: cluster x2apic
[    0.122710] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x2b3e459bf4c, max_idle_ns: 440795289890 ns
[    0.122715] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 6002.00 BogoMIPS (lpj=3D10000000)
[    0.122737] x86/cpu: SGX disabled or unsupported by BIOS.
[    0.122744] CPU0: Thermal monitoring enabled (TM1)
[    0.122798] Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
[    0.122799] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.122803] process: using mwait in idle threads
[    0.122805] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.122807] Spectre V2 : Spectre BHI mitigation: SW BHB clearing on sysc=
all and VM exit
[    0.122808] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.122809] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.122809] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL =
on VMEXIT
[    0.122810] RETBleed: Mitigation: Enhanced IBRS
[    0.122812] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.122813] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl
[    0.122818] TAA: Mitigation: TSX disabled
[    0.122819] MMIO Stale Data: Mitigation: Clear CPU buffers
[    0.122822] SRBDS: Mitigation: Microcode
[    0.122827] GDS: Mitigation: Microcode
[    0.122831] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.122832] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.122833] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.122834] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registe=
rs'
[    0.122835] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.122836] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.122838] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.122839] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.122840] x86/fpu: Enabled xstate features 0x1f, context size is 960 b=
ytes, using 'compacted' format.
[    0.126046] Freeing SMP alternatives memory: 40K
[    0.126046] pid_max: default: 32768 minimum: 301
[    0.126046] LSM: initializing lsm=3Dcapability,landlock,lockdown,yama,bpf
[    0.126046] landlock: Up and running.
[    0.126046] Yama: becoming mindful.
[    0.126046] LSM support for eBPF active
[    0.126046] Mount-cache hash table entries: 32768 (order: 6, 262144 byte=
s, linear)
[    0.126046] Mountpoint-cache hash table entries: 32768 (order: 6, 262144=
 bytes, linear)
[    0.126046] smpboot: CPU0: Intel(R) Core(TM) i7-9700F CPU @ 3.00GHz (fam=
ily: 0x6, model: 0x9e, stepping: 0xd)
[    0.126046] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR,=
 full-width counters, Intel PMU driver.
[    0.126046] ... version:                4
[    0.126046] ... bit width:              48
[    0.126046] ... generic registers:      8
[    0.126046] ... value mask:             0000ffffffffffff
[    0.126046] ... max period:             00007fffffffffff
[    0.126046] ... fixed-purpose events:   3
[    0.126046] ... event mask:             00000007000000ff
[    0.126046] signal: max sigframe size: 2032
[    0.126046] Estimated ratio of average max frequency by base frequency (=
times 1024): 1570
[    0.126046] rcu: Hierarchical SRCU implementation.
[    0.126046] rcu: 	Max phase no-delay instances is 1000.
[    0.126046] Timer migration: 1 hierarchy levels; 8 children per group; 1=
 crossnode level
[    0.126046] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.126046] smp: Bringing up secondary CPUs ...
[    0.126046] smpboot: x86: Booting SMP configuration:
[    0.126046] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.129431] smp: Brought up 1 node, 8 CPUs
[    0.129431] smpboot: Total of 8 processors activated (48019.00 BogoMIPS)
[    0.131425] Memory: 16201524K/16648252K available (18432K kernel code, 2=
692K rwdata, 14432K rodata, 4292K init, 3948K bss, 431572K reserved, 0K cma=
-reserved)
[    0.132791] devtmpfs: initialized
[    0.132791] x86/mm: Memory block size: 128MB
[    0.133881] ACPI: PM: Registering ACPI NVS region [mem 0x8a722000-0x8ab9=
5fff] (4669440 bytes)
[    0.133881] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 6370867519511994 ns
[    0.133881] futex hash table entries: 2048 (order: 5, 131072 bytes, line=
ar)
[    0.133881] pinctrl core: initialized pinctrl subsystem
[    0.133881] PM: RTC time: 17:52:19, date: 2025-01-13
[    0.133881] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.133881] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.133991] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.134103] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.134109] audit: initializing netlink subsys (disabled)
[    0.134164] audit: type=3D2000 audit(1736790739.000:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.134164] thermal_sys: Registered thermal governor 'fair_share'
[    0.134164] thermal_sys: Registered thermal governor 'bang_bang'
[    0.134164] thermal_sys: Registered thermal governor 'step_wise'
[    0.134164] thermal_sys: Registered thermal governor 'user_space'
[    0.134164] thermal_sys: Registered thermal governor 'power_allocator'
[    0.134164] cpuidle: using governor ladder
[    0.134164] cpuidle: using governor menu
[    0.134164] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    0.134164] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.134164] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for =
domain 0000 [bus 00-ff]
[    0.134164] PCI: Using configuration type 1 for base access
[    0.134164] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.136983] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.136983] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.136983] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.136983] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.136983] fbcon: Taking over console
[    0.136983] ACPI: Added _OSI(Module Device)
[    0.136983] ACPI: Added _OSI(Processor Device)
[    0.136983] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.136983] ACPI: Added _OSI(Processor Aggregator Device)
[    0.191500] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    0.198430] ACPI: Dynamic OEM Table Load:
[    0.198430] ACPI: SSDT 0xFFFF98694100B400 000400 (v02 HPQOEM SLIC-CPC 00=
003001 INTL 20160527)
[    0.199935] ACPI: Dynamic OEM Table Load:
[    0.199941] ACPI: SSDT 0xFFFF986941002800 000605 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.200969] ACPI: Dynamic OEM Table Load:
[    0.200973] ACPI: SSDT 0xFFFF986941035000 0000F4 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.201906] ACPI: Dynamic OEM Table Load:
[    0.201910] ACPI: SSDT 0xFFFF98694184C000 000149 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.202804] ACPI: Dynamic OEM Table Load:
[    0.202808] ACPI: SSDT 0xFFFF986941004800 000724 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.203930] ACPI: Dynamic OEM Table Load:
[    0.203935] ACPI: SSDT 0xFFFF986941001800 0005FC (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.204974] ACPI: Dynamic OEM Table Load:
[    0.204979] ACPI: SSDT 0xFFFF986941009C00 000317 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.206017] ACPI: Dynamic OEM Table Load:
[    0.206021] ACPI: SSDT 0xFFFF9869418C4000 000AB0 (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.207580] ACPI: Dynamic OEM Table Load:
[    0.207584] ACPI: SSDT 0xFFFF986941008400 00030A (v02 HPQOEM SLIC-CPC 00=
003000 INTL 20160527)
[    0.211758] ACPI: EC: EC started
[    0.211759] ACPI: EC: interrupt blocked
[    0.212346] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.212349] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle tran=
sactions
[    0.212350] ACPI: Interpreter enabled
[    0.212387] ACPI: PM: (supports S0 S3 S4 S5)
[    0.212389] ACPI: Using IOAPIC for interrupt routing
[    0.213593] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.213594] PCI: Ignoring E820 reservations for host bridge windows
[    0.214772] ACPI: Enabled 10 GPEs in block 00 to 7F
[    0.231504] ACPI: \_SB_.PCI0.XDCI.USBC: New power resource
[    0.231655] ACPI: \_SB_.PCI0.PAUD: New power resource
[    0.234076] ACPI: \SPR2: New power resource
[    0.234248] ACPI: \SPR3: New power resource
[    0.234545] ACPI: \ZPDR: New power resource
[    0.234788] ACPI: \_SB_.PCI0.SAT0.VOL0.V0PR: New power resource
[    0.234989] ACPI: \_SB_.PCI0.SAT0.VOL1.V1PR: New power resource
[    0.235184] ACPI: \_SB_.PCI0.SAT0.VOL2.V2PR: New power resource
[    0.240773] ACPI: \_SB_.PCI0.I2C1.PXTC: New power resource
[    0.247204] ACPI: \_SB_.PCI0.CNVW.WRST: New power resource
[    0.252308] ACPI: \_TZ_.FN00: New power resource
[    0.252375] ACPI: \_TZ_.FN01: New power resource
[    0.252440] ACPI: \_TZ_.FN02: New power resource
[    0.252502] ACPI: \_TZ_.FN03: New power resource
[    0.252564] ACPI: \_TZ_.FN04: New power resource
[    0.253020] ACPI: \PIN_: New power resource
[    0.253174] ACPI: \SPR0: New power resource
[    0.253229] ACPI: \SPR1: New power resource
[    0.253284] ACPI: \SPR5: New power resource
[    0.253828] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.253836] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI EDR HPX-Type3]
[    0.257098] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME AER PCIeCapability LTR DPC]
[    0.257100] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    0.258284] PCI host bridge to bus 0000:00
[    0.258288] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.258291] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.258292] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.258294] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000efff=
f window]
[    0.258295] pci_bus 0000:00: root bus resource [mem 0x90000000-0xdffffff=
f window]
[    0.258297] pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7ffff=
f window]
[    0.258298] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.258390] pci 0000:00:00.0: [8086:3e30] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.258459] pci 0000:00:01.0: [8086:1901] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.258471] pci 0000:00:01.0: PCI bridge to [bus 01-03]
[    0.258474] pci 0000:00:01.0:   bridge window [io  0x5000-0x5fff]
[    0.258476] pci 0000:00:01.0:   bridge window [mem 0xa0300000-0xa05fffff]
[    0.258481] pci 0000:00:01.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.258506] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.259104] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000 convent=
ional PCI endpoint
[    0.259113] pci 0000:00:08.0: BAR 0 [mem 0xa0922000-0xa0922fff 64bit]
[    0.259285] pci 0000:00:12.0: [8086:a379] type 00 class 0x118000 convent=
ional PCI endpoint
[    0.259317] pci 0000:00:12.0: BAR 0 [mem 0xa0921000-0xa0921fff 64bit]
[    0.259580] pci 0000:00:14.0: [8086:a36d] type 00 class 0x0c0330 convent=
ional PCI endpoint
[    0.259615] pci 0000:00:14.0: BAR 0 [mem 0xa0900000-0xa090ffff 64bit]
[    0.259755] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.260460] pci 0000:00:14.2: [8086:a36f] type 00 class 0x050000 convent=
ional PCI endpoint
[    0.260490] pci 0000:00:14.2: BAR 0 [mem 0xa0916000-0xa0917fff 64bit]
[    0.260509] pci 0000:00:14.2: BAR 2 [mem 0xa0920000-0xa0920fff 64bit]
[    0.260660] pci 0000:00:14.5: [8086:a375] type 00 class 0x080501 convent=
ional PCI endpoint
[    0.260691] pci 0000:00:14.5: BAR 0 [mem 0xa091f000-0xa091ffff 64bit]
[    0.261523] pci 0000:00:15.0: [8086:a368] type 00 class 0x0c8000 convent=
ional PCI endpoint
[    0.262097] pci 0000:00:15.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.265051] pci 0000:00:15.1: [8086:a369] type 00 class 0x0c8000 convent=
ional PCI endpoint
[    0.265626] pci 0000:00:15.1: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.268232] pci 0000:00:16.0: [8086:a360] type 00 class 0x078000 convent=
ional PCI endpoint
[    0.268264] pci 0000:00:16.0: BAR 0 [mem 0xa091c000-0xa091cfff 64bit]
[    0.268383] pci 0000:00:16.0: PME# supported from D3hot
[    0.269018] pci 0000:00:17.0: [8086:a352] type 00 class 0x010601 convent=
ional PCI endpoint
[    0.269046] pci 0000:00:17.0: BAR 0 [mem 0xa0914000-0xa0915fff]
[    0.269062] pci 0000:00:17.0: BAR 1 [mem 0xa091b000-0xa091b0ff]
[    0.269077] pci 0000:00:17.0: BAR 2 [io  0x6050-0x6057]
[    0.269092] pci 0000:00:17.0: BAR 3 [io  0x6040-0x6043]
[    0.269107] pci 0000:00:17.0: BAR 4 [io  0x6020-0x603f]
[    0.269122] pci 0000:00:17.0: BAR 5 [mem 0xa091a000-0xa091a7ff]
[    0.269204] pci 0000:00:17.0: PME# supported from D3hot
[    0.269672] pci 0000:00:1c.0: [8086:a33d] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.269730] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    0.269737] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[    0.269742] pci 0000:00:1c.0:   bridge window [mem 0xa0800000-0xa08fffff]
[    0.269887] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.269929] pci 0000:00:1c.0: PTM enabled (root), 4ns granularity
[    0.270793] pci 0000:00:1c.7: [8086:a33f] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.270851] pci 0000:00:1c.7: PCI bridge to [bus 05]
[    0.270858] pci 0000:00:1c.7:   bridge window [io  0x3000-0x3fff]
[    0.270863] pci 0000:00:1c.7:   bridge window [mem 0xa0700000-0xa07fffff]
[    0.271005] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
[    0.271048] pci 0000:00:1c.7: PTM enabled (root), 4ns granularity
[    0.271844] pci 0000:00:1d.0: [8086:a330] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.271901] pci 0000:00:1d.0: PCI bridge to [bus 06]
[    0.271913] pci 0000:00:1d.0:   bridge window [mem 0xa0600000-0xa06fffff]
[    0.272070] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.272122] pci 0000:00:1d.0: PTM enabled (root), 4ns granularity
[    0.273361] pci 0000:00:1e.0: [8086:a328] type 00 class 0x078000 convent=
ional PCI endpoint
[    0.273935] pci 0000:00:1e.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.276564] pci 0000:00:1f.0: [8086:a304] type 00 class 0x060100 convent=
ional PCI endpoint
[    0.277128] pci 0000:00:1f.3: [8086:a348] type 00 class 0x040300 convent=
ional PCI endpoint
[    0.277188] pci 0000:00:1f.3: BAR 0 [mem 0xa0910000-0xa0913fff 64bit]
[    0.277263] pci 0000:00:1f.3: BAR 4 [mem 0xa0200000-0xa02fffff 64bit]
[    0.277412] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.278814] pci 0000:00:1f.4: [8086:a323] type 00 class 0x0c0500 convent=
ional PCI endpoint
[    0.278988] pci 0000:00:1f.4: BAR 0 [mem 0xa0918000-0xa09180ff 64bit]
[    0.279202] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.279696] pci 0000:00:1f.5: [8086:a324] type 00 class 0x0c8000 convent=
ional PCI endpoint
[    0.279722] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.279909] pci 0000:01:00.0: [1002:1478] type 01 class 0x060400 PCIe Sw=
itch Upstream Port
[    0.279920] pci 0000:01:00.0: BAR 0 [mem 0xa0500000-0xa0503fff]
[    0.279932] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.279938] pci 0000:01:00.0:   bridge window [io  0x5000-0x5fff]
[    0.279940] pci 0000:01:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.279948] pci 0000:01:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.280015] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.280063] pci 0000:01:00.0: 63.008 Gb/s available PCIe bandwidth, limi=
ted by 8.0 GT/s PCIe x8 link at 0000:00:01.0 (capable of 126.024 Gb/s with =
16.0 GT/s PCIe x8 link)
[    0.280158] pci 0000:00:01.0: PCI bridge to [bus 01-03]
[    0.280199] pci 0000:02:00.0: [1002:1479] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.280221] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.280225] pci 0000:02:00.0:   bridge window [io  0x5000-0x5fff]
[    0.280228] pci 0000:02:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.280236] pci 0000:02:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.280303] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.280424] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.280470] pci 0000:03:00.0: [1002:73ff] type 00 class 0x030000 PCIe Le=
gacy Endpoint
[    0.280484] pci 0000:03:00.0: BAR 0 [mem 0x90000000-0x9fffffff 64bit pre=
f]
[    0.280493] pci 0000:03:00.0: BAR 2 [mem 0xa0000000-0xa01fffff 64bit pre=
f]
[    0.280499] pci 0000:03:00.0: BAR 4 [io  0x5000-0x50ff]
[    0.280505] pci 0000:03:00.0: BAR 5 [mem 0xa0300000-0xa03fffff]
[    0.280511] pci 0000:03:00.0: ROM [mem 0xa0400000-0xa041ffff pref]
[    0.280583] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.280641] pci 0000:03:00.0: 63.008 Gb/s available PCIe bandwidth, limi=
ted by 8.0 GT/s PCIe x8 link at 0000:00:01.0 (capable of 252.048 Gb/s with =
16.0 GT/s PCIe x16 link)
[    0.280715] pci 0000:03:00.1: [1002:ab28] type 00 class 0x040300 PCIe Le=
gacy Endpoint
[    0.280724] pci 0000:03:00.1: BAR 0 [mem 0xa0420000-0xa0423fff]
[    0.280796] pci 0000:03:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.280886] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.281048] pci 0000:04:00.0: [10ec:8168] type 00 class 0x020000 PCIe En=
dpoint
[    0.281076] pci 0000:04:00.0: BAR 0 [io  0x4000-0x40ff]
[    0.281113] pci 0000:04:00.0: BAR 2 [mem 0xa0804000-0xa0804fff 64bit]
[    0.281136] pci 0000:04:00.0: BAR 4 [mem 0xa0800000-0xa0803fff 64bit]
[    0.281293] pci 0000:04:00.0: supports D1 D2
[    0.281294] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.281594] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    0.281748] pci 0000:05:00.0: [10ec:c821] type 00 class 0x028000 PCIe En=
dpoint
[    0.281774] pci 0000:05:00.0: BAR 0 [io  0x3000-0x30ff]
[    0.281807] pci 0000:05:00.0: BAR 2 [mem 0xa0700000-0xa070ffff 64bit]
[    0.281988] pci 0000:05:00.0: supports D1 D2
[    0.281989] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.282368] pci 0000:00:1c.7: PCI bridge to [bus 05]
[    0.282738] pci 0000:06:00.0: [8086:f1a8] type 00 class 0x010802 PCIe En=
dpoint
[    0.282773] pci 0000:06:00.0: BAR 0 [mem 0xa0600000-0xa0603fff 64bit]
[    0.283322] pci 0000:00:1d.0: PCI bridge to [bus 06]
[    0.285605] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.285690] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
[    0.285772] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.285854] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.285935] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.286016] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.286100] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.286182] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.291529] ACPI: EC: interrupt unblocked
[    0.291531] ACPI: EC: event unblocked
[    0.291543] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.291544] ACPI: EC: GPE=3D0xb
[    0.291546] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC initialization comp=
lete
[    0.291548] ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions =
and events
[    0.291600] iommu: Default domain type: Translated
[    0.291600] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.291600] SCSI subsystem initialized
[    0.291600] libata version 3.00 loaded.
[    0.291600] ACPI: bus type USB registered
[    0.291600] usbcore: registered new interface driver usbfs
[    0.291600] usbcore: registered new interface driver hub
[    0.291600] usbcore: registered new device driver usb
[    0.291600] EDAC MC: Ver: 3.0.0
[    0.293014] efivars: Registered efivars operations
[    0.293014] NetLabel: Initializing
[    0.293014] NetLabel:  domain hash size =3D 128
[    0.293014] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.293014] NetLabel:  unlabeled traffic allowed by default
[    0.293014] mctp: management component transport protocol core
[    0.293014] NET: Registered PF_MCTP protocol family
[    0.293014] PCI: Using ACPI for IRQ routing
[    0.377657] PCI: pci_cache_line_size set to 64 bytes
[    0.378257] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.378268] e820: reserve RAM buffer [mem 0x7bf0f018-0x7bffffff]
[    0.378269] e820: reserve RAM buffer [mem 0x7bf1e018-0x7bffffff]
[    0.378270] e820: reserve RAM buffer [mem 0x86b6d000-0x87ffffff]
[    0.378271] e820: reserve RAM buffer [mem 0x88b80000-0x8bffffff]
[    0.378273] e820: reserve RAM buffer [mem 0x8a270000-0x8bffffff]
[    0.378274] e820: reserve RAM buffer [mem 0x8dc0f000-0x8fffffff]
[    0.378274] e820: reserve RAM buffer [mem 0x46e000000-0x46fffffff]
[    0.378305] pci 0000:03:00.0: vgaarb: setting as boot VGA device
[    0.378305] pci 0000:03:00.0: vgaarb: bridge control possible
[    0.378305] pci 0000:03:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[    0.378305] vgaarb: loaded
[    0.379382] clocksource: Switched to clocksource tsc-early
[    0.379393] VFS: Disk quotas dquot_6.6.0
[    0.379393] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.379393] pnp: PnP ACPI init
[    0.379393] system 00:00: [mem 0x40000000-0x403fffff] could not be reser=
ved
[    0.380779] system 00:01: [io  0x0a00-0x0a0f] has been reserved
[    0.380782] system 00:01: [io  0x0a10-0x0a1f] has been reserved
[    0.380783] system 00:01: [io  0x0a20-0x0a2f] has been reserved
[    0.380785] system 00:01: [io  0x0a30-0x0a3f] has been reserved
[    0.380786] system 00:01: [io  0x0a40-0x0a4f] has been reserved
[    0.380787] system 00:01: [io  0x0a50-0x0a5f] has been reserved
[    0.380789] system 00:01: [io  0x0a60-0x0a6f] has been reserved
[    0.380790] system 00:01: [io  0x0a70-0x0a7f] has been reserved
[    0.380791] system 00:01: [io  0x0a80-0x0a8f] has been reserved
[    0.380793] system 00:01: [io  0x0a90-0x0b8e] has been reserved
[    0.380794] system 00:01: [io  0x0aa0-0x0aaf] has been reserved
[    0.380795] system 00:01: [io  0x0ab0-0x0abf] has been reserved
[    0.380797] system 00:01: [io  0x0ac0-0x0acf] has been reserved
[    0.380798] system 00:01: [io  0x0ad0-0x0adf] has been reserved
[    0.381188] system 00:02: [io  0x0680-0x069f] has been reserved
[    0.381190] system 00:02: [io  0x164e-0x164f] has been reserved
[    0.381308] system 00:03: [io  0x1854-0x1857] has been reserved
[    0.381478] system 00:04: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.381480] system 00:04: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.381482] system 00:04: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.381484] system 00:04: [mem 0xe0000000-0xefffffff] has been reserved
[    0.381485] system 00:04: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.381487] system 00:04: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.381488] system 00:04: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.381490] system 00:04: [mem 0xfee00000-0xfeefffff] could not be reser=
ved
[    0.381723] system 00:05: [io  0x1800-0x18fe] could not be reserved
[    0.381726] system 00:05: [mem 0xfd000000-0xfd69ffff] has been reserved
[    0.381728] system 00:05: [mem 0xfd6c0000-0xfd6cffff] has been reserved
[    0.381730] system 00:05: [mem 0xfd6f0000-0xfdffffff] has been reserved
[    0.381731] system 00:05: [mem 0xfe000000-0xfe01ffff] could not be reser=
ved
[    0.381733] system 00:05: [mem 0xfe200000-0xfe7fffff] has been reserved
[    0.381735] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.382044] system 00:06: [io  0x2000-0x20fe] has been reserved
[    0.384159] pnp: PnP ACPI: found 8 devices
[    0.389609] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.389661] NET: Registered PF_INET protocol family
[    0.389788] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)
[    0.404398] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5,=
 131072 bytes, linear)
[    0.404424] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.404482] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes, linear)
[    0.404697] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,=
 linear)
[    0.404918] TCP: Hash tables configured (established 131072 bind 65536)
[    0.404999] MPTCP token hash table entries: 16384 (order: 6, 393216 byte=
s, linear)
[    0.405067] UDP hash table entries: 8192 (order: 7, 524288 bytes, linear)
[    0.405145] UDP-Lite hash table entries: 8192 (order: 7, 524288 bytes, l=
inear)
[    0.405226] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.405234] NET: Registered PF_XDP protocol family
[    0.405247] pci 0000:00:15.0: BAR 0 [mem 0xa0919000-0xa0919fff 64bit]: a=
ssigned
[    0.405520] pci 0000:00:15.1: BAR 0 [mem 0xa091d000-0xa091dfff 64bit]: a=
ssigned
[    0.405788] pci 0000:00:1e.0: BAR 0 [mem 0xa091e000-0xa091efff 64bit]: a=
ssigned
[    0.406057] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.406063] pci 0000:02:00.0:   bridge window [io  0x5000-0x5fff]
[    0.406073] pci 0000:02:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.406076] pci 0000:02:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.406081] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.406083] pci 0000:01:00.0:   bridge window [io  0x5000-0x5fff]
[    0.406086] pci 0000:01:00.0:   bridge window [mem 0xa0300000-0xa04fffff]
[    0.406089] pci 0000:01:00.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.406093] pci 0000:00:01.0: PCI bridge to [bus 01-03]
[    0.406094] pci 0000:00:01.0:   bridge window [io  0x5000-0x5fff]
[    0.406097] pci 0000:00:01.0:   bridge window [mem 0xa0300000-0xa05fffff]
[    0.406099] pci 0000:00:01.0:   bridge window [mem 0x90000000-0xa01fffff=
 64bit pref]
[    0.406102] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    0.406110] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[    0.406117] pci 0000:00:1c.0:   bridge window [mem 0xa0800000-0xa08fffff]
[    0.406131] pci 0000:00:1c.7: PCI bridge to [bus 05]
[    0.406134] pci 0000:00:1c.7:   bridge window [io  0x3000-0x3fff]
[    0.406141] pci 0000:00:1c.7:   bridge window [mem 0xa0700000-0xa07fffff]
[    0.406154] pci 0000:00:1d.0: PCI bridge to [bus 06]
[    0.406160] pci 0000:00:1d.0:   bridge window [mem 0xa0600000-0xa06fffff]
[    0.406174] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.406176] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.406177] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.406179] pci_bus 0000:00: resource 7 [mem 0x000e0000-0x000effff windo=
w]
[    0.406180] pci_bus 0000:00: resource 8 [mem 0x90000000-0xdfffffff windo=
w]
[    0.406181] pci_bus 0000:00: resource 9 [mem 0xfc800000-0xfe7fffff windo=
w]
[    0.406183] pci_bus 0000:01: resource 0 [io  0x5000-0x5fff]
[    0.406184] pci_bus 0000:01: resource 1 [mem 0xa0300000-0xa05fffff]
[    0.406185] pci_bus 0000:01: resource 2 [mem 0x90000000-0xa01fffff 64bit=
 pref]
[    0.406187] pci_bus 0000:02: resource 0 [io  0x5000-0x5fff]
[    0.406188] pci_bus 0000:02: resource 1 [mem 0xa0300000-0xa04fffff]
[    0.406189] pci_bus 0000:02: resource 2 [mem 0x90000000-0xa01fffff 64bit=
 pref]
[    0.406191] pci_bus 0000:03: resource 0 [io  0x5000-0x5fff]
[    0.406192] pci_bus 0000:03: resource 1 [mem 0xa0300000-0xa04fffff]
[    0.406193] pci_bus 0000:03: resource 2 [mem 0x90000000-0xa01fffff 64bit=
 pref]
[    0.406195] pci_bus 0000:04: resource 0 [io  0x4000-0x4fff]
[    0.406196] pci_bus 0000:04: resource 1 [mem 0xa0800000-0xa08fffff]
[    0.406197] pci_bus 0000:05: resource 0 [io  0x3000-0x3fff]
[    0.406198] pci_bus 0000:05: resource 1 [mem 0xa0700000-0xa07fffff]
[    0.406200] pci_bus 0000:06: resource 1 [mem 0xa0600000-0xa06fffff]
[    0.406817] pci 0000:03:00.1: D0 power state depends on 0000:03:00.0
[    0.406882] PCI: CLS 64 bytes, default 64
[    0.406945] DMAR: No ATSR found
[    0.406946] DMAR: No SATC found
[    0.406947] DMAR: dmar0: Using Queued invalidation
[    0.406972] Trying to unpack rootfs image as initramfs...
[    0.406999] pci 0000:00:00.0: Adding to iommu group 0
[    0.407012] pci 0000:00:01.0: Adding to iommu group 1
[    0.407020] pci 0000:00:08.0: Adding to iommu group 2
[    0.407031] pci 0000:00:12.0: Adding to iommu group 3
[    0.407050] pci 0000:00:14.0: Adding to iommu group 4
[    0.407058] pci 0000:00:14.2: Adding to iommu group 4
[    0.407066] pci 0000:00:14.5: Adding to iommu group 4
[    0.407080] pci 0000:00:15.0: Adding to iommu group 5
[    0.407088] pci 0000:00:15.1: Adding to iommu group 5
[    0.407099] pci 0000:00:16.0: Adding to iommu group 6
[    0.407107] pci 0000:00:17.0: Adding to iommu group 7
[    0.407123] pci 0000:00:1c.0: Adding to iommu group 8
[    0.407134] pci 0000:00:1c.7: Adding to iommu group 9
[    0.407149] pci 0000:00:1d.0: Adding to iommu group 10
[    0.407161] pci 0000:00:1e.0: Adding to iommu group 11
[    0.407183] pci 0000:00:1f.0: Adding to iommu group 12
[    0.407192] pci 0000:00:1f.3: Adding to iommu group 12
[    0.407201] pci 0000:00:1f.4: Adding to iommu group 12
[    0.407210] pci 0000:00:1f.5: Adding to iommu group 12
[    0.407214] pci 0000:01:00.0: Adding to iommu group 1
[    0.407218] pci 0000:02:00.0: Adding to iommu group 1
[    0.407223] pci 0000:03:00.0: Adding to iommu group 1
[    0.407227] pci 0000:03:00.1: Adding to iommu group 1
[    0.407242] pci 0000:04:00.0: Adding to iommu group 13
[    0.407261] pci 0000:05:00.0: Adding to iommu group 14
[    0.407272] pci 0000:06:00.0: Adding to iommu group 15
[    0.408039] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.408040] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.408041] software IO TLB: mapped [mem 0x0000000082b6d000-0x0000000086=
b6d000] (64MB)
[    0.408089] platform rtc_cmos: registered platform RTC device (no PNP de=
vice found)
[    0.420110] Initialise system trusted keyrings
[    0.420117] Key type blacklist registered
[    0.420151] workingset: timestamp_bits=3D36 max_order=3D22 bucket_order=
=3D0
[    0.420236] fuse: init (API version 7.41)
[    0.420298] integrity: Platform Keyring initialized
[    0.420300] integrity: Machine keyring initialized
[    0.431268] Key type asymmetric registered
[    0.431269] Asymmetric key parser 'x509' registered
[    0.431284] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 246)
[    0.431324] io scheduler mq-deadline registered
[    0.431325] io scheduler kyber registered
[    0.431334] io scheduler bfq registered
[    0.431481] ledtrig-cpu: registered to indicate activity on CPUs
[    0.431692] pcieport 0000:00:01.0: PME: Signaling with IRQ 121
[    0.431932] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
[    0.432006] pcieport 0000:00:1c.0: AER: enabled with IRQ 122
[    0.432062] pcieport 0000:00:1c.0: DPC: enabled with IRQ 122
[    0.432064] pcieport 0000:00:1c.0: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.432407] pcieport 0000:00:1c.7: PME: Signaling with IRQ 123
[    0.432476] pcieport 0000:00:1c.7: AER: enabled with IRQ 123
[    0.432516] pcieport 0000:00:1c.7: DPC: enabled with IRQ 123
[    0.432517] pcieport 0000:00:1c.7: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.432813] pcieport 0000:00:1d.0: PME: Signaling with IRQ 124
[    0.432876] pcieport 0000:00:1d.0: AER: enabled with IRQ 124
[    0.432914] pcieport 0000:00:1d.0: DPC: enabled with IRQ 124
[    0.432915] pcieport 0000:00:1d.0: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.433313] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.433831] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input0
[    0.433851] ACPI: button: Sleep Button [SLPB]
[    0.433873] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input1
[    0.433886] ACPI: button: Power Button [PWRB]
[    0.433910] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input2
[    0.434074] ACPI: button: Power Button [PWRF]
[    0.436096] thermal LNXTHERM:00: registered as thermal_zone0
[    0.436099] ACPI: thermal: Thermal Zone [HPTZ] (30 C)
[    0.436396] thermal LNXTHERM:01: registered as thermal_zone1
[    0.436398] ACPI: thermal: Thermal Zone [TZ00] (28 C)
[    0.436604] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.438470] hpet_acpi_add: no address or irqs in _CRS
[    0.438505] Non-volatile memory driver v1.3
[    0.438506] Linux agpgart interface v0.103
[    0.470706] Freeing initrd memory: 21264K
[    0.571479] ACPI: bus type drm_connector registered
[    0.572381] ahci 0000:00:17.0: version 3.0
[    0.582725] ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 =
Gbps, SATA mode
[    0.582729] ahci 0000:00:17.0: 4/4 ports implemented (port mask 0x3c)
[    0.582731] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio slu=
m part ems deso sadm sds apst=20
[    0.603348] scsi host0: ahci
[    0.603665] scsi host1: ahci
[    0.603971] scsi host2: ahci
[    0.604120] scsi host3: ahci
[    0.604234] scsi host4: ahci
[    0.604430] scsi host5: ahci
[    0.604462] ata1: DUMMY
[    0.604463] ata2: DUMMY
[    0.604468] ata3: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a20=
0 irq 126 lpm-pol 3
[    0.604471] ata4: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a28=
0 irq 126 lpm-pol 3
[    0.604474] ata5: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a30=
0 irq 126 lpm-pol 3
[    0.604477] ata6: SATA max UDMA/133 abar m2048@0xa091a000 port 0xa091a38=
0 irq 126 lpm-pol 3
[    0.604731] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.604736] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[    0.605870] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
10 quirks 0x0000000000009810
[    0.606161] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.606164] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[    0.606166] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperS=
peed
[    0.606202] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.13
[    0.606205] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.606206] usb usb1: Product: xHCI Host Controller
[    0.606207] usb usb1: Manufacturer: Linux 6.13.0-rc7-1.1-mainline-dirty =
xhci-hcd
[    0.606209] usb usb1: SerialNumber: 0000:00:14.0
[    0.606362] hub 1-0:1.0: USB hub found
[    0.606382] hub 1-0:1.0: 16 ports detected
[    0.608093] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.13
[    0.608097] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.608098] usb usb2: Product: xHCI Host Controller
[    0.608100] usb usb2: Manufacturer: Linux 6.13.0-rc7-1.1-mainline-dirty =
xhci-hcd
[    0.608101] usb usb2: SerialNumber: 0000:00:14.0
[    0.608201] hub 2-0:1.0: USB hub found
[    0.608215] hub 2-0:1.0: 8 ports detected
[    0.608983] usb: port power management may be unreliable
[    0.609306] usbcore: registered new interface driver usbserial_generic
[    0.609310] usbserial: USB Serial support registered for generic
[    0.609431] rtc_cmos rtc_cmos: RTC can wake from S4
[    0.610997] rtc_cmos rtc_cmos: registered as rtc0
[    0.611309] rtc_cmos rtc_cmos: setting system clock to 2025-01-13T17:52:=
20 UTC (1736790740)
[    0.611340] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nv=
ram
[    0.611669] intel_pstate: Intel P-state driver initializing
[    0.612279] intel_pstate: Disabling energy efficiency optimization
[    0.612280] intel_pstate: HWP enabled
[    0.612531] simple-framebuffer simple-framebuffer.0: [drm] Registered 1 =
planes with drm panic
[    0.612532] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 o=
n minor 0
[    0.622390] Console: switching to colour frame buffer device 240x67
[    0.633893] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledr=
mdrmfb frame buffer device
[    0.634025] hid: raw HID events driver (C) Jiri Kosina
[    0.634097] drop_monitor: Initializing network drop monitor service
[    0.634182] NET: Registered PF_INET6 protocol family
[    0.638876] Segment Routing with IPv6
[    0.638877] RPL Segment Routing with IPv6
[    0.638884] In-situ OAM (IOAM) with IPv6
[    0.638901] NET: Registered PF_PACKET protocol family
[    0.640334] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.640545] microcode: Current revision: 0x00000100
[    0.640546] microcode: Updated early from: 0x000000fa
[    0.640801] IPI shorthand broadcast: enabled
[    0.641835] sched_clock: Marking stable (628058299, 12731955)->(66872468=
6, -27934432)
[    0.642039] registered taskstats version 1
[    0.642619] Loading compiled-in X.509 certificates
[    0.646144] Loaded X.509 cert 'Build time autogenerated kernel key: 8c3a=
f276a3f521176c68e087cb8b2ded522c945b'
[    0.647185] Demotion targets for Node 0: null
[    0.647340] Key type .fscrypt registered
[    0.647341] Key type fscrypt-provisioning registered
[    0.648657] integrity: Loading X.509 certificate: UEFI:db
[    0.648670] integrity: Loaded X.509 cert 'HP Inc.: HP UEFI Secure Boot D=
B 2017: d9c01b50cfcae89d3b05345c163aa76e5dd589e7'
[    0.648671] integrity: Loading X.509 certificate: UEFI:db
[    0.648682] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA =
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.648683] integrity: Loading X.509 certificate: UEFI:db
[    0.648692] integrity: Loaded X.509 cert 'Microsoft Windows Production P=
CA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.650275] PM:   Magic number: 9:89:896
[    0.652406] RAS: Correctable Errors collector initialized.
[    0.658591] clk: Disabling unused clocks
[    0.658592] PM: genpd: Disabling unused power domains
[    0.849504] usb 1-10: new high-speed USB device number 2 using xhci_hcd
[    0.947084] ata6: SATA link down (SStatus 4 SControl 300)
[    0.947152] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.947222] ata4: SATA link down (SStatus 0 SControl 300)
[    0.949851] ata5.00: Model 'SAMSUNG MZ7TD256HAFV-000L9', rev 'DXT04L6Q',=
 applying quirks: nolpm
[    0.949862] ata5.00: LPM support broken, forcing max_power
[    0.949988] ata5.00: supports DRM functions and may not be fully accessi=
ble
[    0.949995] ata5.00: ATA-9: SAMSUNG MZ7TD256HAFV-000L9, DXT04L6Q, max UD=
MA/133
[    0.950100] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.950305] ata5.00: NCQ Send/Recv Log not supported
[    0.950312] ata5.00: 500118192 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    0.952281] ata5.00: Features: Trust Dev-Sleep
[    0.952636] ata5.00: LPM support broken, forcing max_power
[    0.952755] ata5.00: supports DRM functions and may not be fully accessi=
ble
[    0.953047] ata5.00: NCQ Send/Recv Log not supported
[    0.955073] ata5.00: configured for UDMA/133
[    0.957562] ata3.00: ATA-8: WDC WD20EARX-00PASB0, 51.0AB51, max UDMA/133
[    0.958253] ata3.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 32),=
 AA
[    0.965468] ahci 0000:00:17.0: port does not support device sleep
[    0.966644] ata3.00: configured for UDMA/133
[    0.966897] scsi 2:0:0:0: Direct-Access     ATA      WDC WD20EARX-00P AB=
51 PQ: 0 ANSI: 5
[    0.967447] sd 2:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 =
TB/1.82 TiB)
[    0.967456] sd 2:0:0:0: [sda] 4096-byte physical blocks
[    0.967471] sd 2:0:0:0: [sda] Write Protect is off
[    0.967476] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.967497] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    0.967533] sd 2:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
[    0.967716] scsi 4:0:0:0: Direct-Access     ATA      SAMSUNG MZ7TD256 4L=
6Q PQ: 0 ANSI: 5
[    0.968186] sd 4:0:0:0: [sdb] 500118192 512-byte logical blocks: (256 GB=
/238 GiB)
[    0.968207] sd 4:0:0:0: [sdb] Write Protect is off
[    0.968211] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    0.968231] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    0.968279] sd 4:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
[    0.980114] usb 1-10: New USB device found, idVendor=3D058f, idProduct=
=3D6254, bcdDevice=3D 1.00
[    0.980127] usb 1-10: New USB device strings: Mfr=3D0, Product=3D0, Seri=
alNumber=3D0
[    0.981865] hub 1-10:1.0: USB hub found
[    0.981989] hub 1-10:1.0: 4 ports detected
[    0.985893]  sdb: sdb1 sdb2 sdb3 sdb4
[    0.986889] sd 4:0:0:0: [sdb] supports TCG Opal
[    0.986897] sd 4:0:0:0: [sdb] Attached SCSI disk
[    0.990433]  sda: sda1
[    0.990682] sd 2:0:0:0: [sda] Attached SCSI disk
[    0.993138] Freeing unused decrypted memory: 2028K
[    0.994092] Freeing unused kernel image (initmem) memory: 4292K
[    0.994133] Write protecting the kernel read-only data: 34816k
[    0.995618] Freeing unused kernel image (rodata/data gap) memory: 1952K
[    1.003947] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.003949] rodata_test: all tests were successful
[    1.003952] Run /init as init process
[    1.003953]   with arguments:
[    1.003953]     /init
[    1.003954]   with environment:
[    1.003955]     HOME=3D/
[    1.003955]     TERM=3Dlinux
[    1.099405] usb 1-14: new full-speed USB device number 3 using xhci_hcd
[    1.211316] sdhci: Secure Digital Host Controller Interface driver
[    1.211318] sdhci: Copyright(c) Pierre Ossman
[    1.216480] nvme nvme0: pci function 0000:06:00.0
[    1.218438] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    1.218453] sdhci-pci 0000:00:14.5: enabling device (0100 -> 0102)
[    1.225671] nvme nvme0: 8/0/0 default/read/poll queues
[    1.228761]  nvme0n1: p1 p2
[    1.228873] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    1.233692] usb 1-14: New USB device found, idVendor=3D0bda, idProduct=
=3Db00a, bcdDevice=3D 1.10
[    1.233694] usb 1-14: New USB device strings: Mfr=3D1, Product=3D2, Seri=
alNumber=3D3
[    1.233696] usb 1-14: Product: Bluetooth Radio=20
[    1.233697] usb 1-14: Manufacturer: Realtek=20
[    1.233697] usb 1-14: SerialNumber: 00e04c000001
[    1.235779] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    1.316167] usb 1-10.3: new low-speed USB device number 4 using xhci_hcd
[    1.415377] usb 1-10.3: New USB device found, idVendor=3D05d5, idProduct=
=3D0615, bcdDevice=3D 1.01
[    1.415392] usb 1-10.3: New USB device strings: Mfr=3D0, Product=3D1, Se=
rialNumber=3D0
[    1.415398] usb 1-10.3: Product: KEYBOARD
[    1.422121] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    1.429512] tsc: Refined TSC clocksource calibration: 3000.006 MHz
[    1.429528] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2b3=
e4b16716, max_idle_ns: 440795256380 ns
[    1.429623] clocksource: Switched to clocksource tsc
[    1.446464] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    1.451374] usbcore: registered new interface driver usbhid
[    1.451382] usbhid: USB HID core driver
[    1.451467] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    1.465030] input: KEYBOARD as /devices/pci0000:00/0000:00:14.0/usb1/1-1=
0/1-10.3/1-10.3:1.0/0003:05D5:0615.0001/input/input3
[    1.596739] hid-generic 0003:05D5:0615.0001: input,hidraw0: USB HID v1.1=
0 Keyboard [KEYBOARD] on usb-0000:00:14.0-10.3/input0
[    1.596889] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    1.597077] input: KEYBOARD Consumer Control as /devices/pci0000:00/0000=
:00:14.0/usb1/1-10/1-10.3/1-10.3:1.1/0003:05D5:0615.0002/input/input4
[    1.650072] input: KEYBOARD System Control as /devices/pci0000:00/0000:0=
0:14.0/usb1/1-10/1-10.3/1-10.3:1.1/0003:05D5:0615.0002/input/input5
[    1.650490] hid-generic 0003:05D5:0615.0002: input,hidraw1: USB HID v1.1=
0 Device [KEYBOARD] on usb-0000:00:14.0-10.3/input1
[    1.650649] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    1.828176] EXT4-fs (nvme0n1p1): mounted filesystem 7f701c1e-4cf2-46b9-8=
8a1-184e3dfef17e r/w with ordered data mode. Quota mode: none.
[    2.028314] systemd[1]: systemd 257.2-1-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPEN=
SSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETU=
P +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM=
2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINI=
T +LIBARCHIVE)
[    2.028322] systemd[1]: Detected architecture x86-64.
[    2.031894] systemd[1]: Hostname set to <Ale-Arch>.
[    2.305730] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    2.560316] systemd-fstab-generator[308]: Mount point  is not a valid pa=
th, ignoring.
[    2.560322] systemd-fstab-generator[308]: Mount point  is not a valid pa=
th, ignoring.
[    2.560402] systemd-fstab-generator[308]: Mount point  is not a valid pa=
th, ignoring.
[    2.561901] systemd-fstab-generator[308]: Mount point  is not a valid pa=
th, ignoring.
[    2.568454] systemd-fstab-generator[308]: Mount point  is not a valid pa=
th, ignoring.
[    2.568458] systemd-fstab-generator[308]: Mount point  is not a valid pa=
th, ignoring.
[    2.568461] systemd-fstab-generator[308]: Mount point  is not a valid pa=
th, ignoring.
[    2.568507] systemd-fstab-generator[308]: Mount point  is not a valid pa=
th, ignoring.
[    2.568539] systemd-fstab-generator[308]: Mount point  is not a valid pa=
th, ignoring.
[    2.570813] systemd-fstab-generator[308]: Mount point  is not a valid pa=
th, ignoring.
[    2.570816] systemd-fstab-generator[308]: Mount point  is not a valid pa=
th, ignoring.
[    2.592870] zram: Added device: zram0
[    2.847039] systemd[1]: Configuration file /run/systemd/system/netplan-o=
vs-cleanup.service is marked world-inaccessible. This has no effect as conf=
iguration data is accessible via APIs without restrictions. Proceeding anyw=
ay.
[    2.929931] systemd[1]: Queued start job for default target Graphical In=
terface.
[    2.961196] systemd[1]: Created slice Virtual Machine and Container Slic=
e.
[    2.961873] systemd[1]: Created slice Slice /system/backrest.
[    2.962148] systemd[1]: Created slice CUPS Slice.
[    2.962458] systemd[1]: Created slice Slice /system/dirmngr.
[    2.962760] systemd[1]: Created slice Slice /system/getty.
[    2.963056] systemd[1]: Created slice Slice /system/gpg-agent.
[    2.963343] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    2.963634] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    2.963921] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    2.964217] systemd[1]: Created slice Slice /system/keyboxd.
[    2.964515] systemd[1]: Created slice Slice /system/modprobe.
[    2.964809] systemd[1]: Created slice Slice /system/nut-driver.
[    2.965096] systemd[1]: Created slice Slice /system/systemd-fsck.
[    2.965388] systemd[1]: Created slice Slice /system/systemd-zram-setup.
[    2.965573] systemd[1]: Created slice User and Session Slice.
[    2.965623] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    2.965733] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[    2.965755] systemd[1]: Expecting device /dev/disk/by-uuid/0f1ef58b-496b=
-48fd-a17b-6cbc03a2c8ee...
[    2.965765] systemd[1]: Expecting device /dev/disk/by-uuid/CAB7-E233...
[    2.965774] systemd[1]: Expecting device /dev/zram0...
[    2.965790] systemd[1]: Reached target Login Prompts.
[    2.965803] systemd[1]: Reached target Local Integrity Protected Volumes.
[    2.965830] systemd[1]: Reached target Remote File Systems.
[    2.965906] systemd[1]: Reached target Slice Units.
[    2.965945] systemd[1]: Reached target System Time Set.
[    2.966011] systemd[1]: Reached target Local Verity Protected Volumes.
[    2.966095] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    2.966181] systemd[1]: Listening on LVM2 poll daemon socket.
[    2.968560] systemd[1]: Listening on RPCbind Server Activation Socket.
[    2.968592] systemd[1]: Reached target RPC Port Mapper.
[    2.973881] systemd[1]: Listening on Process Core Dump Socket.
[    2.974671] systemd[1]: Listening on Credential Encryption/Decryption.
[    2.974749] systemd[1]: Listening on Journal Socket (/dev/log).
[    2.974907] systemd[1]: Listening on Journal Sockets.
[    2.975056] systemd[1]: Listening on Network Service Netlink Socket.
[    2.975780] systemd[1]: Listening on Userspace Out-Of-Memory (OOM) Kille=
r Socket.
[    2.975843] systemd[1]: TPM PCR Measurements was skipped because of an u=
nmet condition check (ConditionSecurity=3Dmeasured-uki).
[    2.975858] systemd[1]: Make TPM PCR Policy was skipped because of an un=
met condition check (ConditionSecurity=3Dmeasured-uki).
[    2.975912] systemd[1]: Listening on udev Control Socket.
[    2.976706] systemd[1]: Listening on udev Kernel Socket.
[    2.978534] systemd[1]: Mounting Huge Pages File System...
[    2.979769] systemd[1]: Mounting POSIX Message Queue File System...
[    2.980535] systemd[1]: Mounting NFSD configuration filesystem...
[    2.981423] systemd[1]: Mounting Kernel Debug File System...
[    2.982186] systemd[1]: Mounting Kernel Trace File System...
[    2.982613] systemd[1]: Load AppArmor profiles was skipped because of an=
 unmet condition check (ConditionSecurity=3Dapparmor).
[    2.982652] systemd[1]: Kernel Module supporting RPCSEC_GSS was skipped =
because of an unmet condition check (ConditionPathExists=3D/etc/krb5.keytab=
).
[    2.983556] systemd[1]: Starting Create List of Static Device Nodes...
[    2.987299] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling...
[    2.988128] systemd[1]: Starting Load Kernel Module configfs...
[    2.988919] systemd[1]: Starting Load Kernel Module dm_mod...
[    2.990020] systemd[1]: Starting Load Kernel Module drm...
[    2.990822] systemd[1]: Starting Load Kernel Module fuse...
[    2.991852] systemd[1]: Starting Load Kernel Module loop...
[    2.992662] systemd[1]: File System Check on Root Device was skipped bec=
ause of an unmet condition check (ConditionPathIsReadWrite=3D!/).
[    2.992700] systemd[1]: Clear Stale Hibernate Storage Info was skipped b=
ecause of an unmet condition check (ConditionPathExists=3D/sys/firmware/efi=
/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[    2.994210] systemd[1]: Starting Journal Service...
[    2.996478] systemd[1]: Starting Load Kernel Modules...
[    2.997609] systemd[1]: Starting Userspace Out-Of-Memory (OOM) Killer...
[    2.997631] systemd[1]: TPM PCR Machine ID Measurement was skipped becau=
se of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    2.999094] loop: module loaded
[    2.999202] systemd[1]: Starting Remount Root and Kernel File Systems...
[    2.999263] systemd[1]: Early TPM SRK Setup was skipped because of an un=
met condition check (ConditionSecurity=3Dmeasured-uki).
[    2.999936] systemd[1]: Starting Load udev Rules from Credentials...
[    3.001502] systemd[1]: Starting Coldplug All udev Devices...
[    3.002843] device-mapper: uevent: version 1.0.3
[    3.002979] systemd[1]: Starting Virtual Console Setup...
[    3.002979] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised:=
 dm-devel@lists.linux.dev
[    3.005085] systemd[1]: Mounted Huge Pages File System.
[    3.005209] systemd[1]: Mounted POSIX Message Queue File System.
[    3.006790] systemd[1]: Mounted Kernel Debug File System.
[    3.007894] systemd[1]: Mounted Kernel Trace File System.
[    3.008866] systemd[1]: Finished Create List of Static Device Nodes.
[    3.009941] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[    3.010058] systemd[1]: Finished Load Kernel Module configfs.
[    3.010238] systemd[1]: modprobe@dm_mod.service: Deactivated successfull=
y.
[    3.010335] systemd[1]: Finished Load Kernel Module dm_mod.
[    3.011026] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    3.011128] systemd[1]: Finished Load Kernel Module drm.
[    3.011912] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    3.012012] systemd[1]: Finished Load Kernel Module fuse.
[    3.013927] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    3.014028] systemd[1]: Finished Load Kernel Module loop.
[    3.014356] systemd[1]: Finished Load udev Rules from Credentials.
[    3.016607] systemd[1]: Mounting FUSE Control File System...
[    3.017171] systemd[1]: Mounting Kernel Configuration File System...
[    3.018075] systemd[1]: Repartition Root Disk was skipped because no tri=
gger condition checks were met.
[    3.018939] systemd[1]: Starting Create Static Device Nodes in /dev grac=
efully...
[    3.020844] systemd[1]: Mounted Kernel Configuration File System.
[    3.021263] systemd[1]: Mounted FUSE Control File System.
[    3.029769] EXT4-fs (nvme0n1p1): re-mounted 7f701c1e-4cf2-46b9-88a1-184e=
3dfef17e r/w. Quota mode: none.
[    3.030252] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    3.030275] sd 4:0:0:0: Attached scsi generic sg1 type 0
[    3.031157] systemd[1]: Finished Remount Root and Kernel File Systems.
[    3.031436] systemd[1]: Finished Virtual Console Setup.
[    3.031597] systemd-journald[347]: Collecting audit messages is disabled.
[    3.034654] systemd[1]: Rebuild Hardware Database was skipped because of=
 an unmet condition check (ConditionNeedsUpdate=3D/etc).
[    3.035183] i2c_dev: i2c /dev entries driver
[    3.035617] systemd[1]: Starting Load/Save OS Random Seed...
[    3.035641] systemd[1]: TPM SRK Setup was skipped because of an unmet co=
ndition check (ConditionSecurity=3Dmeasured-uki).
[    3.037815] systemd[1]: Finished Load Kernel Modules.
[    3.038199] RPC: Registered named UNIX socket transport module.
[    3.038201] RPC: Registered udp transport module.
[    3.038201] RPC: Registered tcp transport module.
[    3.038201] RPC: Registered tcp-with-tls transport module.
[    3.038202] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    3.038764] systemd[1]: Starting Apply Kernel Variables...
[    3.046324] systemd[1]: Finished Load/Save OS Random Seed.
[    3.047951] systemd[1]: Started Userspace Out-Of-Memory (OOM) Killer.
[    3.055137] systemd[1]: Finished Apply Kernel Variables.
[    3.059376] systemd[1]: Starting CLI Netfilter Manager...
[    3.067003] systemd[1]: Started Journal Service.
[    3.078509] systemd-journald[347]: Received client request to flush runt=
ime journal.
[    3.288496] zram0: detected capacity change from 0 to 32491520
[    3.306508] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    3.320803] intel_pmc_core INT33A1:00:  initialized
[    3.320854] sdhci-pci 0000:00:14.5: SDHCI controller found [8086:a375] (=
rev 10)
[    3.343692] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: 8F1F6436-9F42-4=
2C8-BADC-0E9424F20C9A has zero instances
[    3.343694] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: 8F1F6435-9F42-4=
2C8-BADC-0E9424F20C9A has zero instances
[    3.343695] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: 7391A661-223A-4=
7DB-A77A-7BE84C60822D has zero instances
[    3.343696] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: DF4E63B6-3BBC-4=
858-9737-C74F82F821F3 has zero instances
[    3.349250] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[    3.349358] mmc0: SDHCI controller on PCI [0000:00:14.5] using ADMA 64-b=
it
[    3.351604] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    3.351712] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db1=
8c600'
[    3.353976] platform regulatory.0: Direct firmware load for regulatory.d=
b failed with error -2
[    3.353979] cfg80211: failed to load regulatory.db
[    3.370730] Adding 16245756k swap on /dev/zram0.  Priority:100 extents:1=
 across:16245756k SSDsc
[    3.386843] raid6: skipped pq benchmark and selected avx2x4
[    3.386845] raid6: using avx2x2 recovery algorithm
[    3.388952] EDAC ie31200: No ECC support
[    3.388988] EDAC ie31200: No ECC support
[    3.391110] intel_pch_thermal 0000:00:12.0: enabling device (0100 -> 010=
2)
[    3.396012] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    3.399994] xor: automatically using best checksumming function   avx   =
   =20
[    3.404749] intel-lpss 0000:00:15.0: enabling device (0100 -> 0102)
[    3.412033] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    3.423542] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    3.423577] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    3.426390] intel-lpss 0000:00:15.1: enabling device (0100 -> 0102)
[    3.426599] idma64 idma64.1: Found Intel integrated DMA 64-bit
[    3.432393] i2c i2c-1: Successfully instantiated SPD at 0x50
[    3.440475] intel-lpss 0000:00:1e.0: enabling device (0100 -> 0102)
[    3.440740] idma64 idma64.2: Found Intel integrated DMA 64-bit
[    3.458368] input: PC Speaker as /devices/platform/pcspkr/input/input6
[    3.537802] iTCO_vendor_support: vendor-support=3D0
[    3.537933] r8169 0000:04:00.0: can't disable ASPM; OS doesn't have ASPM=
 control
[    3.540575] ee1004 1-0050: 512 byte EE1004-compliant SPD EEPROM, read-on=
ly
[    3.541472] Creating 1 MTD partitions on "0000:00:1f.5":
[    3.541474] 0x000000000000-0x000001000000 : "BIOS"
[    3.542150] dw-apb-uart.2: ttyS4 at MMIO 0xa091e000 (irq =3D 20, base_ba=
ud =3D 7500000) is a 16550A
[    3.551104] r8169 0000:04:00.0 eth0: RTL8168h/8111h, 9c:7b:ef:30:a7:6b, =
XID 541, IRQ 146
[    3.551108] r8169 0000:04:00.0 eth0: jumbo features [frames: 9194 bytes,=
 tx checksumming: ko]
[    3.557516] r8169 0000:04:00.0 enp4s0: renamed from eth0
[    3.608059] Bluetooth: Core ver 2.22
[    3.608087] NET: Registered PF_BLUETOOTH protocol family
[    3.608088] Bluetooth: HCI device and connection manager initialized
[    3.608090] Bluetooth: HCI socket layer initialized
[    3.608092] Bluetooth: L2CAP socket layer initialized
[    3.608094] Bluetooth: SCO socket layer initialized
[    3.620137] Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
[    3.621891] input: HP WMI hotkeys as /devices/virtual/input/input7
[    3.622496] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360=
 ms ovfl timer
[    3.622498] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    3.622499] RAPL PMU: hw unit of domain package 2^-14 Joules
[    3.622499] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    3.629502] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=3D6=
, TCOBASE=3D0x0400)
[    3.629610] iTCO_wdt iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=
=3D0)
[    3.629976] cryptd: max_cpu_qlen set to 1000
[    3.638383] rtw_8821ce 0000:05:00.0: enabling device (0100 -> 0103)
[    3.641261] rtw_8821ce 0000:05:00.0: Firmware version 24.11.0, H2C versi=
on 12
[    3.642466] usbcore: registered new interface driver btusb
[    3.644852] AES CTR mode by8 optimization enabled
[    3.645833] snd_hda_intel 0000:00:1f.3: enabling device (0100 -> 0102)
[    3.646175] snd_hda_intel 0000:03:00.1: enabling device (0100 -> 0102)
[    3.646269] snd_hda_intel 0000:03:00.1: Force to non-snoop mode
[    3.651552] Bluetooth: hci0: RTL: examining hci_ver=3D08 hci_rev=3D000c =
lmp_ver=3D08 lmp_subver=3D8821
[    3.652529] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
[    3.652530] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_fw.bin
[    3.653165] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_config.bin
[    3.653230] Bluetooth: hci0: RTL: cfg_sz 10, total sz 34926
[    3.656320] input: HDA ATI HDMI HDMI/DP,pcm=3D3 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input8
[    3.656363] input: HDA ATI HDMI HDMI/DP,pcm=3D7 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input9
[    3.656389] input: HDA ATI HDMI HDMI/DP,pcm=3D8 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input10
[    3.656412] input: HDA ATI HDMI HDMI/DP,pcm=3D9 as /devices/pci0000:00/0=
000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input11
[    3.656446] input: HDA ATI HDMI HDMI/DP,pcm=3D10 as /devices/pci0000:00/=
0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input12
[    3.672933] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC671: li=
ne_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:line
[    3.672938] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[    3.672939] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0x21/0x0/=
0x0/0x0/0x0)
[    3.672941] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0
[    3.672941] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    3.672942] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=3D0x18
[    3.672943] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=3D0x19
[    3.672944] snd_hda_codec_realtek hdaudioC0D0:      Line=3D0x1b
[    3.689562] input: HDA Intel PCH Rear Mic as /devices/pci0000:00/0000:00=
:1f.3/sound/card0/input13
[    3.689617] input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:0=
0:1f.3/sound/card0/input14
[    3.689670] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1f.=
3/sound/card0/input15
[    3.689721] input: HDA Intel PCH Line Out as /devices/pci0000:00/0000:00=
:1f.3/sound/card0/input16
[    3.689772] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input17
[    3.694141] rtw_8821ce 0000:05:00.0 wlp5s0: renamed from wlan0
[    3.755142] intel_tcc_cooling: Programmable TCC Offset detected
[    4.118633] Bluetooth: hci0: RTL: fw version 0x75b8f098
[    4.255413] BTRFS: device label DATA devid 1 transid 20440 /dev/sda1 (8:=
1) scanned by mount (598)
[    4.259971] BTRFS info (device sda1): first mount of filesystem 0f1ef58b=
-496b-48fd-a17b-6cbc03a2c8ee
[    4.259980] BTRFS info (device sda1): using crc32c (crc32c-intel) checks=
um algorithm
[    4.259983] BTRFS info (device sda1): using free-space-tree
[    6.063298] [drm] amdgpu kernel modesetting enabled.
[    6.063451] amdgpu: Virtual CRAT table created for CPU
[    6.063460] amdgpu: Topology: Add CPU node
[    6.063489] amdgpu: Overdrive is enabled, please disable it before repor=
ting any bugs unrelated to overdrive.
[    6.065428] amdgpu 0000:03:00.0: enabling device (0106 -> 0107)
[    6.065564] [drm] initializing kernel modesetting (DIMGREY_CAVEFISH 0x10=
02:0x73FF 0x1043:0x05D5 0xC7).
[    6.065608] [drm] register mmio base: 0xA0300000
[    6.065609] [drm] register mmio size: 1048576
[    6.070693] [drm] add ip block number 0 <nv_common>
[    6.070696] [drm] add ip block number 1 <gmc_v10_0>
[    6.070697] [drm] add ip block number 2 <navi10_ih>
[    6.070698] [drm] add ip block number 3 <psp>
[    6.070699] [drm] add ip block number 4 <smu>
[    6.070700] [drm] add ip block number 5 <dm>
[    6.070701] [drm] add ip block number 6 <gfx_v10_0>
[    6.070702] [drm] add ip block number 7 <sdma_v5_2>
[    6.070703] [drm] add ip block number 8 <vcn_v3_0>
[    6.070704] [drm] add ip block number 9 <jpeg_v3_0>
[    6.070728] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from VFCT
[    6.070731] amdgpu: ATOM BIOS: 115-D534P00-100
[    6.115566] intel_rapl_common: Found RAPL domain package
[    6.115583] intel_rapl_common: Found RAPL domain core
[    6.115584] intel_rapl_common: Found RAPL domain dram
[    6.126181] Console: switching to colour dummy device 80x25
[    6.147272] amdgpu 0000:03:00.0: vgaarb: deactivate vga console
[    6.147276] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (TMZ) featu=
re disabled as experimental (default)
[    6.147310] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, f=
ragment size is 9-bit
[    6.147317] amdgpu 0000:03:00.0: amdgpu: VRAM: 8176M 0x0000008000000000 =
- 0x00000081FEFFFFFF (8176M used)
[    6.147319] amdgpu 0000:03:00.0: amdgpu: GART: 512M 0x0000000000000000 -=
 0x000000001FFFFFFF
[    6.147332] [drm] Detected VRAM RAM=3D8176M, BAR=3D256M
[    6.147333] [drm] RAM width 128bits GDDR6
[    6.147483] [drm] amdgpu: 8176M of VRAM memory ready
[    6.147486] [drm] amdgpu: 7932M of GTT memory ready.
[    6.147502] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    6.147587] [drm] PCIE GART of 512M enabled (table at 0x0000008002000000=
).
[    7.577629] amdgpu 0000:03:00.0: amdgpu: STB initialized to 2048 entries
[    7.577846] [drm] Loading DMUB firmware via PSP: version=3D0x02020020
[    7.578177] [drm] use_doorbell being set to: [true]
[    7.578187] [drm] use_doorbell being set to: [true]
[    7.578198] [drm] Found VCN firmware Version ENC: 1.33 DEC: 4 VEP: 0 Rev=
ision: 3
[    7.644926] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000=
000 for PSP TMR
[    7.747176] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is n=
ot available
[    7.764188] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta=
 ucode is not available
[    7.764211] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x000=
0000f, smu fw if version =3D 0x00000013, smu fw program =3D 0, version =3D =
0x003b3100 (59.49.0)
[    7.764220] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not match=
ed
[    7.764257] amdgpu 0000:03:00.0: amdgpu: use vbios provided pptable
[    7.810463] amdgpu 0000:03:00.0: amdgpu: SMU is initialized successfully!
[    7.810899] [drm] Display Core v3.2.310 initialized on DCN 3.0.2
[    7.810901] [drm] DP-HDMI FRL PCON supported
[    7.812145] [drm] DMUB hardware initialized: version=3D0x02020020
[    7.815110] snd_hda_intel 0000:03:00.1: bound 0000:03:00.0 (ops amdgpu_d=
m_audio_component_bind_ops [amdgpu])
[    8.250509] [drm] kiq ring mec 2 pipe 1 q 0
[    8.293339] amdgpu: HMM registered 8176MB device memory
[    8.294691] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    8.294702] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    8.295149] amdgpu: Virtual CRAT table created for GPU
[    8.295313] amdgpu: Topology: Add dGPU node [0x73ff:0x1002]
[    8.295315] kfd kfd: amdgpu: added device 1002:73ff
[    8.295331] amdgpu 0000:03:00.0: amdgpu: SE 2, SH per SE 2, CU per SH 8,=
 active_cu_number 28
[    8.295334] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng =
0 on hub 0
[    8.295335] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng =
1 on hub 0
[    8.295336] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 4 on hub 0
[    8.295337] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 5 on hub 0
[    8.295338] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 6 on hub 0
[    8.295339] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 7 on hub 0
[    8.295339] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 8 on hub 0
[    8.295340] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 9 on hub 0
[    8.295341] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 10 on hub 0
[    8.295342] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 11 on hub 0
[    8.295342] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv en=
g 12 on hub 0
[    8.295343] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 o=
n hub 0
[    8.295344] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 o=
n hub 0
[    8.295345] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng =
0 on hub 8
[    8.295346] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv en=
g 1 on hub 8
[    8.295346] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv en=
g 4 on hub 8
[    8.295347] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5=
 on hub 8
[    8.296442] amdgpu 0000:03:00.0: amdgpu: Using BACO for runtime pm
[    8.297052] [drm] Initialized amdgpu 3.59.0 for 0000:03:00.0 on minor 1
[    8.302545] fbcon: amdgpudrmfb (fb0) is primary device
[    8.302872] [drm] pre_validate_dsc:1593 MST_DSC dsc precompute is not ne=
eded
[    8.608355] Console: switching to colour frame buffer device 240x67
[    8.643601] amdgpu 0000:03:00.0: [drm] fb0: amdgpudrmfb frame buffer dev=
ice
[    8.851767] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    8.851770] Bluetooth: BNEP filters: protocol multicast
[    8.851772] Bluetooth: BNEP socket layer initialized
[    8.856038] Bluetooth: MGMT ver 1.23
[    8.860258] NET: Registered PF_ALG protocol family
[    9.038777] nvme nvme0: using unchecked data buffer
[    9.098214] block nvme0n1: No UUID available providing old NGUID
[    9.109508] Generic FE-GE Realtek PHY r8169-0-400:00: attached PHY drive=
r (mii_bus:phy_addr=3Dr8169-0-400:00, irq=3DMAC)
[    9.276286] r8169 0000:04:00.0 enp4s0: Link is Down
[    9.881822] bridge: filtering via arp/ip/ip6tables is no longer availabl=
e by default. Update your scripts to load br_netfilter if you need this.
[   10.024703] u32 classifier
[   10.024705]     Performance counters on
[   10.024705]     input device check on
[   10.024706]     Actions configured
[   11.982560] kvm: Running KVM with ignore_msrs=3D1 and report_ignored_msr=
s=3D0 is not a
               a supported configuration.  Lying to the guest about the exi=
stence of MSRs
               may cause the guest operating system to hang or produce erro=
rs.  If a guest
               does not run without ignore_msrs=3D1, please report it to kv=
m@vger.kernel.org.
[   12.769751] r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[   12.771418] r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[   15.219554] RPC: Registered rdma transport module.
[   15.219557] RPC: Registered rdma backchannel transport module.
[   15.326918] NFSD: Using nfsdcld client tracking operations.
[   15.326925] NFSD: no clients to reclaim, skipping NFSv4 grace period (ne=
t f0000000)
[   15.760300] Initializing XFRM netlink socket
[   15.856374] warning: `pmdalinux' uses wireless extensions which will sto=
p working for Wi-Fi 7 hardware; use nl80211

--ukgy5675ubv2aggz--

--z7h6ajaf77v4xvnj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmeGi5YACgkQwEfU8yi1
JYWhrA//Ukg1H+f0buv6sJA9qAX5VoBdUXhiNBsMEmZ4Ll/EPFCVtaCuatVqvSZa
pWsDR16BLd+m9CInjNdTOZRCmPCi7fBvf51a4bcmaNpypnkQ4vgzraRJT/kDNEcf
hNPzWT0s/Gi7ljDM4EJnHgByHZtBlei3Ge/qFvWB4Zu4ENtZm9ZRNbR2WJULcn2f
noxTUFeAAlJ94hO5pLF6Im4/yrq1IM+t2BfFb919dznQO7063qRRcHo5HgwT8mrn
LLQQMYmLCSC45IsvqMQs5SFzvsYatk9oKhEYU4DXchPlEUAJfk5no3N5LbBr+98b
C5OAWA3OFSgxfC7kf7z4oJqrgTv8mv+xIGQUcuhdLE22bXpYjfdEuwqsfjtJoB1m
DT6VlKDEH+hVoL/x/dhLHBq+Su3P1HNYLAMPb6npnqsj2tXzrfn+DDgoSD2Lw5/c
uBEjlb/VIDS53GN6FsQ0hY0ncKlOYp34JfEnno4IoLsCCeeNFX17cZLjvS4aWaVR
YAuLFa9aEJXzQOWY85DFEh9ie9qqDWftgd326ODh/RvnXpcVmQjG2nvRMFnDDPBF
BxnhNbOq/4dOmUI8ME95ONFnG6g/pgrdwjZ53Vb2F0bEM7Yd18Sixh9lPuvByCQ6
ChKd/+FtvNNJjLNktxfEA0coXrHM8HNmqCOgM89NmNIAmkuYl+k=
=+aQC
-----END PGP SIGNATURE-----

--z7h6ajaf77v4xvnj--
