From: Grant Grundler <grundler@google.com>
Subject: Re: [Bugme-new] [Bug 13001] New: PCI-DMA: Out of IOMMU space
Date: Tue, 7 Apr 2009 13:59:38 -0700
Message-ID: <da824cf30904071359i35cd0722p85b9943c9bb5a3@mail.gmail.com>
References: <bug-13001-10286@http.bugzilla.kernel.org/>
	 <20090404114559.ce20eb9c.akpm@linux-foundation.org>
	 <db2b43030904050239t6abf1c35q216c24a215276269@mail.gmail.com>
	 <da824cf30904070914m2e9deaf8o4236fa2173480fe9@mail.gmail.com>
	 <db2b43030904070946x495cf76et2fd4571f0ac96634@mail.gmail.com>
	 <db2b43030904070952k5fe88addsa1b664fc1d4e89a9@mail.gmail.com>
	 <db2b43030904071323x296e5689q74376339d6aaec7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:16458 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758799AbZDGU7p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Apr 2009 16:59:45 -0400
Received: from spaceape11.eur.corp.google.com (spaceape11.eur.corp.google.com [172.28.16.145])
	by smtp-out.google.com with ESMTP id n37Kxe4Z008765
	for <linux-ide@vger.kernel.org>; Tue, 7 Apr 2009 13:59:42 -0700
Received: from qyk2 (qyk2.prod.google.com [10.241.83.130])
	by spaceape11.eur.corp.google.com with ESMTP id n37KxcJa007759
	for <linux-ide@vger.kernel.org>; Tue, 7 Apr 2009 13:59:39 -0700
Received: by qyk2 with SMTP id 2so1964527qyk.31
        for <linux-ide@vger.kernel.org>; Tue, 07 Apr 2009 13:59:38 -0700 (PDT)
In-Reply-To: <db2b43030904071323x296e5689q74376339d6aaec7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?0JTQsNC90LjQu9CwINCW0YPQutC+0YbQutC40Lk=?= <optimusgd@gmail.com>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, x86@kernel.org

2009/4/7 =D0=94=D0=B0=D0=BD=D0=B8=D0=BB=D0=B0 =D0=96=D1=83=D0=BA=D0=BE=D1=
=86=D0=BA=D0=B8=D0=B9 <optimusgd@gmail.com>
>
> Thank You, Grant, for Your simple questions!

Welcome!
I was just trying to point out some additional information to folks
who might understand the code. I don't in this case but was looking
for more clues.

>
> Without "allowdac" after
> couple of hours testing i cannot reproduce bug! So it is my stupid
> mistake, i don't understand Why i add this absolutely unusual
> parameter to boot string.

I thought I understood IOMMUs having written code for 4 different
implementations.
I don't understand why "allowdac" parameter exists.
dma_mask stuff should be handling this already.
Can someone explain *why* (=D0=94=D0=B0=D0=BD=D0=B8=D0=BB=D0=B0 already=
 posted the docs) this
parameter exists?
(ie use case that dma_mask APIs don't work.)

> I'm apologize to All off You for this stupid
> mindfuck. You may close the bug, because it is bug in my damn head.

My first impression: the bug is either allocdma exists instead of using
DMA API (See Documentation/DMA-API.txt) OR the documentation for
allocdma is missing warnings about "this could break your system"
and clearly specify when it should be used.

hth,
grant

>
> 2009/4/7 =D0=94=D0=B0=D0=BD=D0=B8=D0=BB=D0=B0 =D0=96=D1=83=D0=BA=D0=BE=
=D1=86=D0=BA=D0=B8=D0=B9 <optimusgd@gmail.com>:
> > Forgot reply to all, sorry
> >
> > ---------- Forwarded message ----------
> > From: =D0=94=D0=B0=D0=BD=D0=B8=D0=BB=D0=B0 =D0=96=D1=83=D0=BA=D0=BE=
=D1=86=D0=BA=D0=B8=D0=B9 <optimusgd@gmail.com>
> > Date: 2009/4/7
> > Subject: Re: [Bugme-new] [Bug 13001] New: PCI-DMA: Out of IOMMU spa=
ce
> > To: Grant Grundler <grundler@google.com>
> >
> >
> > Yes, in attachment clear dmesg, warnings in bugreport body
> >
> >>Apr =C2=A03 13:38:46 rngmhpamd sata_nv 0000:00:05.0: PCI-DMA: Out o=
f IOMMU space for 4096 bytes
> >>Apr =C2=A03 13:38:46 rngmhpamd sata_nv 0000:00:05.0: PCI-DMA: Out o=
f IOMMU space for 4096 bytes
> >
> > I got "PCI-DMA: Out of IOMMU space" while trying write data to usb =
or
> > sata hdd before all other error messages. After that usb and sata
> > drives lost. All other noise is attempts to communicate with died
> > devices.
> >
> >>Kernel command line:
> >>mce=3Dbootlog root=3D/dev/ram0 real_root=3D/dev/evms/root init=3D/l=
inuxrc
> > I'm boot from 3ware raid with evmc
> >>iommu=3Dallowdac,merge,memaper=3D3
> > This is from Documentation/x86/x86_64/boot-options.txt
> > iommu=3Dallowdac Im try to avoid DMA bug. May be that not need.
> > allowdac =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Allow double-address cy=
cle (DAC) mode, i.e. DMA >4GB.
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 DAC is used with 32-bit PCI to push a 64-bit address in
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 two cycles. When off all DMA over >4GB is forced through
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 an IOMMU or software bounce buffering.
> > merge =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Do scatter-ga=
ther (SG) merging.
> > memaper[=3D<order>] =C2=A0Allocate an own aperture over RAM with si=
ze 32MB<<order.
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (default: order=3D1, i.e. 64MB)
> > With default apperture, 64mb, DMA leak very fast, now i have
> > memaper=3D5, 1 gb, becouse i must do my job and can't rollback to 2=
=2E6.28
> > due strange mysterious problem with forcedeth nics that i can't
> > explain and solve. If solution for DMA leak will not be found, i'm =
try
> > to fill bugreport about problem with nics.
> >
> >>3w_9xxx.use_msi=3D1 snd-hda-intel.enable_msi=3D1 doevms quiet
> > I prefer use msi on that hardware.
> >>...
> >>Your BIOS doesn't leave a aperture memory hole
> >>Please enable the IOMMU option in the BIOS setup
> >>This costs you 256 MB of RAM
> >
> > xw9400 BIOS do not have IOMMU option in the BIOS setup. Now this co=
sts
> > me 1gb of ram
> >
> > Anyway, i can stable reproduce bug without all this whistlers
> >
> > 2009/4/7 Grant Grundler <grundler@google.com>:
> >> 2009/4/5 =D0=94=D0=B0=D0=BD=D0=B8=D0=BB=D0=B0 =D0=96=D1=83=D0=BA=D0=
=BE=D1=86=D0=BA=D0=B8=D0=B9 <optimusgd@gmail.com>:
> >>> 2009/4/4 Andrew Morton <akpm@linux-foundation.org>:
> >>>>
> >>>> (switched to email. =C2=A0Please respond via emailed reply-to-al=
l, not via the
> >>>> bugzilla web interface).
> >>>>
> >>>> On Fri, 3 Apr 2009 09:30:19 GMT bugzilla-daemon@bugzilla.kernel.=
org wrote:
> >>>>
> >>>>> http://bugzilla.kernel.org/show_bug.cgi?id=3D13001
> >>>>>
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Summary: PCI-DMA: Out =
of IOMMU space
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Product: Platform Spec=
ific/Hardware
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Version: 2.5
> >>>>> =C2=A0 =C2=A0 Kernel Version: 2.6.29-gentoo
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Platform: All
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 OS/Version: Linux
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tree: Mainline
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: NEW
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Severity: normal
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Priority: P1
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Component: x86-64
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 AssignedTo: platform_x86_64@kernel-=
bugs.osdl.org
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ReportedBy: optimusgd@gmail.com
> >>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Regression: Yes
> >>>>>
> >>>>>
> >>>>> Created an attachment (id=3D20789)
> >>>>> =C2=A0--> (http://bugzilla.kernel.org/attachment.cgi?id=3D20789=
)
> >>>>> hwreport generated info
> >>>>>
> >>>>> After some IO activity the "PCI-DMA: Out of IOMMU space" messag=
e appear.
> >>>>> 2.6.28-gentoo-r4 work ok, so it is regression.
> >>>>
> >>>> It is indeed a regression.
> >>>>
> >>>>> Dmesg fragments:
> >>>>>
> >>>>>
> >>>>> Apr =C2=A03 13:38:46 rngmhpamd sata_nv 0000:00:05.0: PCI-DMA: O=
ut of IOMMU space for
> >>>>> 4096 bytes
> >>
> >> The bug report has a "dmesg" attachment but I wasn't able to find =
the
> >> "Out of IOMMU space" message in the dmesg. =C2=A0Can that be corre=
cted?
> >> I was looking for IDE/SATA errors *before* the IOMMU errors.
> >>
> >> But I was surprised to find these bits:
> >> ...
> >> Kernel command line: mce=3Dbootlog root=3D/dev/ram0
> >> real_root=3D/dev/evms/root init=3D/linuxrc iommu=3Dallowdac,merge,=
memaper=3D3
> >> 3w_9xxx.use_msi=3D1 snd-hda-intel.enable_msi=3D1 doevms quiet
> >> Initializing CPU#0
> >> ...
> >> Your BIOS doesn't leave a aperture memory hole
> >> Please enable the IOMMU option in the BIOS setup
> >> This costs you 256 MB of RAM
> >> ...
> >>
> >> I'm not familiar with iommu=3D parameter nor the warning about the=
 BIOS.
> >> Any comments on that?
> >>
> >> thanks,
> >> grant
> >>
> >>>>> Apr =C2=A03 13:38:46 rngmhpamd sata_nv 0000:00:05.0: PCI-DMA: O=
ut of IOMMU space for
> >>>>> 4096 bytes
> >>>>> Apr =C2=A03 13:38:46 rngmhpamd ata1: EH in SWNCQ mode,QC:qc_act=
ive 0x1 sactive 0x1
> >>>>> Apr =C2=A03 13:38:46 rngmhpamd ata1: SWNCQ:qc_active 0x0 defer_=
bits 0x0
> >>>>> last_issue_tag 0xfafbfcfd
> >>>>> Apr =C2=A03 13:38:46 rngmhpamd dhfis 0x0 dmafis 0x0 sdbfis 0x0
> >>>>> Apr =C2=A03 13:38:46 rngmhpamd ata1: ATA_REG 0x50 ERR_REG 0x0
> >>>>> Apr =C2=A03 13:38:46 rngmhpamd ata1: tag : dhfis dmafis sdbfis =
sacitve
> >>>>> Apr =C2=A03 13:38:46 rngmhpamd ata1.00: exception Emask 0x0 SAc=
t 0x1 SErr 0x0 action
> >>>>> 0x6
> >>>>> Apr =C2=A03 13:38:46 rngmhpamd ata1.00: cmd 60/08:00:00:00:00/0=
0:00:00:00:00/40 tag
> >>>>> 0 ncq 4096 in
> >>>>> Apr =C2=A03 13:38:46 rngmhpamd res 50/00:00:00:00:00/00:45:00:0=
0:00/a0 Emask 0x40
> >>>>> (internal error)
> >>>>> Apr =C2=A03 13:38:46 rngmhpamd ata1.00: status: { DRDY }
> >>>>> Apr =C2=A03 13:38:46 rngmhpamd ata1: hard resetting link
> >>>>
> >>>> Are these scary-looking messages also present in 2.6.28?
> >>>>
> >>>> If so, perhaps the ata code is leaking DMA memory on the error-h=
andling path?
> >>>>
> >>>>> Apr =C2=A03 13:38:47 rngmhpamd ata1: SATA link up 3.0 Gbps (SSt=
atus 123 SControl
> >>>>> 300)
> >>>>> Apr =C2=A03 13:38:47 rngmhpamd ata1.00: configured for UDMA/100
> >>>>> Apr =C2=A03 13:38:47 rngmhpamd ata1: EH complete
> >>>>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] 488397168 512-=
byte hardware
> >>>>> sectors: (250 GB/232 GiB)
> >>>>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Write Protect =
is off
> >>>>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Mode Sense: 00=
 3a 00 00
> >>>>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Write cache: e=
nabled, read cache:
> >>>>> enabled, doesn't support DPO or FUA
> >>>>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] 488397168 512-=
byte hardware
> >>>>> sectors: (250 GB/232 GiB)
> >>>>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Write Protect =
is off
> >>>>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Mode Sense: 00=
 3a 00 00
> >>>>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Write cache: e=
nabled, read cache:
> >>>>> enabled, doesn't support DPO or FUA
> >>>>>
> >>>>> And
> >>>>>
> >>>>> Mar 31 20:56:18 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out o=
f IOMMU space
> >>>>> for 4608 bytes
> >>>>> Mar 31 20:56:18 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out o=
f IOMMU space
> >>>>> for 69632 bytes
> >>>>> Mar 31 20:56:48 rngmhpamd usb 1-4: reset high speed USB device =
using ehci_hcd
> >>>>> and address 8
> >>>>> Mar 31 20:56:48 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out o=
f IOMMU space
> >>>>> for 11776 bytes
> >>>>> Mar 31 20:56:48 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out o=
f IOMMU space
> >>>>> for 69632 bytes
> >>>>> Mar 31 20:57:19 rngmhpamd usb 1-4: reset high speed USB device =
using ehci_hcd
> >>>>> and address 8
> >>>>> Mar 31 20:57:19 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out o=
f IOMMU space
> >>>>> for 11776 bytes
> >>>>> Mar 31 20:57:19 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out o=
f IOMMU space
> >>>>> for 69632 bytes
> >>>>> Mar 31 20:57:50 rngmhpamd usb 1-4: reset high speed USB device =
using ehci_hcd
> >>>>> and address 8
> >>>>> Mar 31 20:57:50 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out o=
f IOMMU space
> >>>>> for 11776 bytes
> >>>>> Mar 31 20:57:50 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out o=
f IOMMU space
> >>>>> for 69632 bytes
> >>>>> Mar 31 20:58:21 rngmhpamd usb 1-4: reset high speed USB device =
using ehci_hcd
> >>>>> and address 8
> >>>>> Mar 31 20:58:21 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out o=
f IOMMU space
> >>>>> for 11776 bytes
> >>>>> Mar 31 20:58:21 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out o=
f IOMMU space
> >>>>> for 69632 bytes
> >>>>> Mar 31 20:58:52 rngmhpamd usb 1-4: reset high speed USB device =
using ehci_hcd
> >>>>> and address 8
> >>>>> Mar 31 20:58:52 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out o=
f IOMMU space
> >>>>> for 11776 bytes
> >>>>> Mar 31 20:58:52 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out o=
f IOMMU space
> >>>>> for 69632 bytes
> >>>>> Mar 31 20:59:01 rngmhpamd sd 8:0:0:0: [sdc] Unhandled error cod=
e
> >>>>> Mar 31 20:59:01 rngmhpamd sd 8:0:0:0: [sdc] Result: hostbyte=3D=
0x07
> >>>>> driverbyte=3D0x00
> >>>>> Mar 31 20:59:01 rngmhpamd end_request: I/O error, dev sdc, sect=
or 1137
> >>>>> Mar 31 20:59:01 rngmhpamd __ratelimit: 246 callbacks suppressed
> >>>>
> >>>> Do we have any debugging option for dumping the current PCI DMA
> >>>> allocations, find out where it has all gone?
> >>>>
> >>>>
> >>>
> >>> Upgrade to 2.6.29-gentoo-r1 (2.6.29.1), problem is still here, ca=
n
> >>> easyly trigger it. I boot with default apperture, 64mb, and while
> >>> write to usb-hdd get this:
> >>>
> >>> Apr =C2=A05 14:28:56 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Ou=
t of IOMMU
> >>> space for 65536 bytes
> >>> Apr =C2=A05 14:28:56 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Ou=
t of IOMMU
> >>> space for 65536 bytes
> >>> Apr =C2=A05 14:29:27 rngmhpamd usb 1-4: reset high speed USB devi=
ce using
> >>> ehci_hcd and address 6
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe linux-i=
de" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-inf=
o.html
> >>>
> >>
> >
> >
> >
> > --
> > =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC =D0=94=
=D0=B0=D0=BD=D0=B8=D0=BB=D0=B0 =D0=96=D1=83=D0=BA=D0=BE=D1=86=D0=BA=D0=B8=
=D0=B9, =D1=81=D0=B8=D1=81=D1=82=D0=B5=D0=BC=D0=BD=D1=8B=D0=B9 =D0=B0=D0=
=B4=D0=BC=D0=B8=D0=BD=D0=B8=D1=81=D1=82=D1=80=D0=B0=D1=82=D0=BE=D1=80 =D0=
=97=D0=90=D0=9E "=D0=A0=D0=BE=D1=81=D0=BD=D0=B5=D1=84=D1=82=D0=B5=D0=B3=
=D0=B0=D0=B7=D0=BC=D0=B0=D1=88"
> >
> >
> >
> > --
> > =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC =D0=94=
=D0=B0=D0=BD=D0=B8=D0=BB=D0=B0 =D0=96=D1=83=D0=BA=D0=BE=D1=86=D0=BA=D0=B8=
=D0=B9, =D1=81=D0=B8=D1=81=D1=82=D0=B5=D0=BC=D0=BD=D1=8B=D0=B9 =D0=B0=D0=
=B4=D0=BC=D0=B8=D0=BD=D0=B8=D1=81=D1=82=D1=80=D0=B0=D1=82=D0=BE=D1=80 =D0=
=97=D0=90=D0=9E "=D0=A0=D0=BE=D1=81=D0=BD=D0=B5=D1=84=D1=82=D0=B5=D0=B3=
=D0=B0=D0=B7=D0=BC=D0=B0=D1=88"
> >
>
>
>
> --
> =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC =D0=94=D0=
=B0=D0=BD=D0=B8=D0=BB=D0=B0 =D0=96=D1=83=D0=BA=D0=BE=D1=86=D0=BA=D0=B8=D0=
=B9, =D1=81=D0=B8=D1=81=D1=82=D0=B5=D0=BC=D0=BD=D1=8B=D0=B9 =D0=B0=D0=B4=
=D0=BC=D0=B8=D0=BD=D0=B8=D1=81=D1=82=D1=80=D0=B0=D1=82=D0=BE=D1=80 =D0=97=
=D0=90=D0=9E "=D0=A0=D0=BE=D1=81=D0=BD=D0=B5=D1=84=D1=82=D0=B5=D0=B3=D0=
=B0=D0=B7=D0=BC=D0=B0=D1=88"
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
