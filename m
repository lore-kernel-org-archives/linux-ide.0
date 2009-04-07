From: Grant Grundler <grundler@google.com>
Subject: Re: [Bugme-new] [Bug 13001] New: PCI-DMA: Out of IOMMU space
Date: Tue, 7 Apr 2009 09:14:03 -0700
Message-ID: <da824cf30904070914m2e9deaf8o4236fa2173480fe9@mail.gmail.com>
References: <bug-13001-10286@http.bugzilla.kernel.org/>
	 <20090404114559.ce20eb9c.akpm@linux-foundation.org>
	 <db2b43030904050239t6abf1c35q216c24a215276269@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:48392 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810AbZDGQOJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Apr 2009 12:14:09 -0400
Received: from wpaz29.hot.corp.google.com (wpaz29.hot.corp.google.com [172.24.198.93])
	by smtp-out.google.com with ESMTP id n37GE4fH010562
	for <linux-ide@vger.kernel.org>; Tue, 7 Apr 2009 17:14:05 +0100
Received: from yx-out-1718.google.com (yxn6.prod.google.com [10.190.4.70])
	by wpaz29.hot.corp.google.com with ESMTP id n37GDshV029365
	for <linux-ide@vger.kernel.org>; Tue, 7 Apr 2009 09:14:03 -0700
Received: by yx-out-1718.google.com with SMTP id 6so1953845yxn.46
        for <linux-ide@vger.kernel.org>; Tue, 07 Apr 2009 09:14:03 -0700 (PDT)
In-Reply-To: <db2b43030904050239t6abf1c35q216c24a215276269@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?0JTQsNC90LjQu9CwINCW0YPQutC+0YbQutC40Lk=?= <optimusgd@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, x86@kernel.org

2009/4/5 =D0=94=D0=B0=D0=BD=D0=B8=D0=BB=D0=B0 =D0=96=D1=83=D0=BA=D0=BE=D1=
=86=D0=BA=D0=B8=D0=B9 <optimusgd@gmail.com>:
> 2009/4/4 Andrew Morton <akpm@linux-foundation.org>:
>>
>> (switched to email. =C2=A0Please respond via emailed reply-to-all, n=
ot via the
>> bugzilla web interface).
>>
>> On Fri, 3 Apr 2009 09:30:19 GMT bugzilla-daemon@bugzilla.kernel.org =
wrote:
>>
>>> http://bugzilla.kernel.org/show_bug.cgi?id=3D13001
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Summary: PCI-DMA: Out of I=
OMMU space
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Product: Platform Specific=
/Hardware
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Version: 2.5
>>> =C2=A0 =C2=A0 Kernel Version: 2.6.29-gentoo
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Platform: All
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 OS/Version: Linux
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tree: Mainline
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: NEW
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Severity: normal
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Priority: P1
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Component: x86-64
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 AssignedTo: platform_x86_64@kernel-bugs=
=2Eosdl.org
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ReportedBy: optimusgd@gmail.com
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Regression: Yes
>>>
>>>
>>> Created an attachment (id=3D20789)
>>> =C2=A0--> (http://bugzilla.kernel.org/attachment.cgi?id=3D20789)
>>> hwreport generated info
>>>
>>> After some IO activity the "PCI-DMA: Out of IOMMU space" message ap=
pear.
>>> 2.6.28-gentoo-r4 work ok, so it is regression.
>>
>> It is indeed a regression.
>>
>>> Dmesg fragments:
>>>
>>>
>>> Apr =C2=A03 13:38:46 rngmhpamd sata_nv 0000:00:05.0: PCI-DMA: Out o=
f IOMMU space for
>>> 4096 bytes

The bug report has a "dmesg" attachment but I wasn't able to find the
"Out of IOMMU space" message in the dmesg.  Can that be corrected?
I was looking for IDE/SATA errors *before* the IOMMU errors.

But I was surprised to find these bits:
=2E..
Kernel command line: mce=3Dbootlog root=3D/dev/ram0
real_root=3D/dev/evms/root init=3D/linuxrc iommu=3Dallowdac,merge,memap=
er=3D3
3w_9xxx.use_msi=3D1 snd-hda-intel.enable_msi=3D1 doevms quiet
Initializing CPU#0
=2E..
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 256 MB of RAM
=2E..

I'm not familiar with iommu=3D parameter nor the warning about the BIOS=
=2E
Any comments on that?

thanks,
grant

>>> Apr =C2=A03 13:38:46 rngmhpamd sata_nv 0000:00:05.0: PCI-DMA: Out o=
f IOMMU space for
>>> 4096 bytes
>>> Apr =C2=A03 13:38:46 rngmhpamd ata1: EH in SWNCQ mode,QC:qc_active =
0x1 sactive 0x1
>>> Apr =C2=A03 13:38:46 rngmhpamd ata1: SWNCQ:qc_active 0x0 defer_bits=
 0x0
>>> last_issue_tag 0xfafbfcfd
>>> Apr =C2=A03 13:38:46 rngmhpamd dhfis 0x0 dmafis 0x0 sdbfis 0x0
>>> Apr =C2=A03 13:38:46 rngmhpamd ata1: ATA_REG 0x50 ERR_REG 0x0
>>> Apr =C2=A03 13:38:46 rngmhpamd ata1: tag : dhfis dmafis sdbfis saci=
tve
>>> Apr =C2=A03 13:38:46 rngmhpamd ata1.00: exception Emask 0x0 SAct 0x=
1 SErr 0x0 action
>>> 0x6
>>> Apr =C2=A03 13:38:46 rngmhpamd ata1.00: cmd 60/08:00:00:00:00/00:00=
:00:00:00/40 tag
>>> 0 ncq 4096 in
>>> Apr =C2=A03 13:38:46 rngmhpamd res 50/00:00:00:00:00/00:45:00:00:00=
/a0 Emask 0x40
>>> (internal error)
>>> Apr =C2=A03 13:38:46 rngmhpamd ata1.00: status: { DRDY }
>>> Apr =C2=A03 13:38:46 rngmhpamd ata1: hard resetting link
>>
>> Are these scary-looking messages also present in 2.6.28?
>>
>> If so, perhaps the ata code is leaking DMA memory on the error-handl=
ing path?
>>
>>> Apr =C2=A03 13:38:47 rngmhpamd ata1: SATA link up 3.0 Gbps (SStatus=
 123 SControl
>>> 300)
>>> Apr =C2=A03 13:38:47 rngmhpamd ata1.00: configured for UDMA/100
>>> Apr =C2=A03 13:38:47 rngmhpamd ata1: EH complete
>>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] 488397168 512-byte=
 hardware
>>> sectors: (250 GB/232 GiB)
>>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Write Protect is o=
ff
>>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Mode Sense: 00 3a =
00 00
>>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Write cache: enabl=
ed, read cache:
>>> enabled, doesn't support DPO or FUA
>>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] 488397168 512-byte=
 hardware
>>> sectors: (250 GB/232 GiB)
>>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Write Protect is o=
ff
>>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Mode Sense: 00 3a =
00 00
>>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Write cache: enabl=
ed, read cache:
>>> enabled, doesn't support DPO or FUA
>>>
>>> And
>>>
>>> Mar 31 20:56:18 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IO=
MMU space
>>> for 4608 bytes
>>> Mar 31 20:56:18 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IO=
MMU space
>>> for 69632 bytes
>>> Mar 31 20:56:48 rngmhpamd usb 1-4: reset high speed USB device usin=
g ehci_hcd
>>> and address 8
>>> Mar 31 20:56:48 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IO=
MMU space
>>> for 11776 bytes
>>> Mar 31 20:56:48 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IO=
MMU space
>>> for 69632 bytes
>>> Mar 31 20:57:19 rngmhpamd usb 1-4: reset high speed USB device usin=
g ehci_hcd
>>> and address 8
>>> Mar 31 20:57:19 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IO=
MMU space
>>> for 11776 bytes
>>> Mar 31 20:57:19 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IO=
MMU space
>>> for 69632 bytes
>>> Mar 31 20:57:50 rngmhpamd usb 1-4: reset high speed USB device usin=
g ehci_hcd
>>> and address 8
>>> Mar 31 20:57:50 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IO=
MMU space
>>> for 11776 bytes
>>> Mar 31 20:57:50 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IO=
MMU space
>>> for 69632 bytes
>>> Mar 31 20:58:21 rngmhpamd usb 1-4: reset high speed USB device usin=
g ehci_hcd
>>> and address 8
>>> Mar 31 20:58:21 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IO=
MMU space
>>> for 11776 bytes
>>> Mar 31 20:58:21 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IO=
MMU space
>>> for 69632 bytes
>>> Mar 31 20:58:52 rngmhpamd usb 1-4: reset high speed USB device usin=
g ehci_hcd
>>> and address 8
>>> Mar 31 20:58:52 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IO=
MMU space
>>> for 11776 bytes
>>> Mar 31 20:58:52 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IO=
MMU space
>>> for 69632 bytes
>>> Mar 31 20:59:01 rngmhpamd sd 8:0:0:0: [sdc] Unhandled error code
>>> Mar 31 20:59:01 rngmhpamd sd 8:0:0:0: [sdc] Result: hostbyte=3D0x07
>>> driverbyte=3D0x00
>>> Mar 31 20:59:01 rngmhpamd end_request: I/O error, dev sdc, sector 1=
137
>>> Mar 31 20:59:01 rngmhpamd __ratelimit: 246 callbacks suppressed
>>
>> Do we have any debugging option for dumping the current PCI DMA
>> allocations, find out where it has all gone?
>>
>>
>
> Upgrade to 2.6.29-gentoo-r1 (2.6.29.1), problem is still here, can
> easyly trigger it. I boot with default apperture, 64mb, and while
> write to usb-hdd get this:
>
> Apr =C2=A05 14:28:56 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of=
 IOMMU
> space for 65536 bytes
> Apr =C2=A05 14:28:56 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of=
 IOMMU
> space for 65536 bytes
> Apr =C2=A05 14:29:27 rngmhpamd usb 1-4: reset high speed USB device u=
sing
> ehci_hcd and address 6
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
