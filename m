From: =?UTF-8?B?0JTQsNC90LjQu9CwINCW0YPQutC+0YbQutC40Lk=?=
	<optimusgd@gmail.com>
Subject: Re: [Bugme-new] [Bug 13001] New: PCI-DMA: Out of IOMMU space
Date: Sun, 5 Apr 2009 14:39:20 +0500
Message-ID: <db2b43030904050239t6abf1c35q216c24a215276269@mail.gmail.com>
References: <bug-13001-10286@http.bugzilla.kernel.org/>
	 <20090404114559.ce20eb9c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:21759 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755674AbZDEJjX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Apr 2009 05:39:23 -0400
Received: by fk-out-0910.google.com with SMTP id 18so682910fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 05 Apr 2009 02:39:20 -0700 (PDT)
In-Reply-To: <20090404114559.ce20eb9c.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, x86@kernel.org

2009/4/4 Andrew Morton <akpm@linux-foundation.org>:
>
> (switched to email. =C2=A0Please respond via emailed reply-to-all, no=
t via the
> bugzilla web interface).
>
> On Fri, 3 Apr 2009 09:30:19 GMT bugzilla-daemon@bugzilla.kernel.org w=
rote:
>
>> http://bugzilla.kernel.org/show_bug.cgi?id=3D13001
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Summary: PCI-DMA: Out of IO=
MMU space
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Product: Platform Specific/=
Hardware
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Version: 2.5
>> =C2=A0 =C2=A0 Kernel Version: 2.6.29-gentoo
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Platform: All
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 OS/Version: Linux
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tree: Mainline
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: NEW
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Severity: normal
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Priority: P1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Component: x86-64
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 AssignedTo: platform_x86_64@kernel-bugs.=
osdl.org
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ReportedBy: optimusgd@gmail.com
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Regression: Yes
>>
>>
>> Created an attachment (id=3D20789)
>> =C2=A0--> (http://bugzilla.kernel.org/attachment.cgi?id=3D20789)
>> hwreport generated info
>>
>> After some IO activity the "PCI-DMA: Out of IOMMU space" message app=
ear.
>> 2.6.28-gentoo-r4 work ok, so it is regression.
>
> It is indeed a regression.
>
>> Dmesg fragments:
>>
>>
>> Apr =C2=A03 13:38:46 rngmhpamd sata_nv 0000:00:05.0: PCI-DMA: Out of=
 IOMMU space for
>> 4096 bytes
>> Apr =C2=A03 13:38:46 rngmhpamd sata_nv 0000:00:05.0: PCI-DMA: Out of=
 IOMMU space for
>> 4096 bytes
>> Apr =C2=A03 13:38:46 rngmhpamd ata1: EH in SWNCQ mode,QC:qc_active 0=
x1 sactive 0x1
>> Apr =C2=A03 13:38:46 rngmhpamd ata1: SWNCQ:qc_active 0x0 defer_bits =
0x0
>> last_issue_tag 0xfafbfcfd
>> Apr =C2=A03 13:38:46 rngmhpamd dhfis 0x0 dmafis 0x0 sdbfis 0x0
>> Apr =C2=A03 13:38:46 rngmhpamd ata1: ATA_REG 0x50 ERR_REG 0x0
>> Apr =C2=A03 13:38:46 rngmhpamd ata1: tag : dhfis dmafis sdbfis sacit=
ve
>> Apr =C2=A03 13:38:46 rngmhpamd ata1.00: exception Emask 0x0 SAct 0x1=
 SErr 0x0 action
>> 0x6
>> Apr =C2=A03 13:38:46 rngmhpamd ata1.00: cmd 60/08:00:00:00:00/00:00:=
00:00:00/40 tag
>> 0 ncq 4096 in
>> Apr =C2=A03 13:38:46 rngmhpamd res 50/00:00:00:00:00/00:45:00:00:00/=
a0 Emask 0x40
>> (internal error)
>> Apr =C2=A03 13:38:46 rngmhpamd ata1.00: status: { DRDY }
>> Apr =C2=A03 13:38:46 rngmhpamd ata1: hard resetting link
>
> Are these scary-looking messages also present in 2.6.28?
>
> If so, perhaps the ata code is leaking DMA memory on the error-handli=
ng path?
>
>> Apr =C2=A03 13:38:47 rngmhpamd ata1: SATA link up 3.0 Gbps (SStatus =
123 SControl
>> 300)
>> Apr =C2=A03 13:38:47 rngmhpamd ata1.00: configured for UDMA/100
>> Apr =C2=A03 13:38:47 rngmhpamd ata1: EH complete
>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] 488397168 512-byte =
hardware
>> sectors: (250 GB/232 GiB)
>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Write Protect is of=
f
>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Mode Sense: 00 3a 0=
0 00
>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Write cache: enable=
d, read cache:
>> enabled, doesn't support DPO or FUA
>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] 488397168 512-byte =
hardware
>> sectors: (250 GB/232 GiB)
>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Write Protect is of=
f
>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Mode Sense: 00 3a 0=
0 00
>> Apr =C2=A03 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Write cache: enable=
d, read cache:
>> enabled, doesn't support DPO or FUA
>>
>> And
>>
>> Mar 31 20:56:18 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOM=
MU space
>> for 4608 bytes
>> Mar 31 20:56:18 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOM=
MU space
>> for 69632 bytes
>> Mar 31 20:56:48 rngmhpamd usb 1-4: reset high speed USB device using=
 ehci_hcd
>> and address 8
>> Mar 31 20:56:48 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOM=
MU space
>> for 11776 bytes
>> Mar 31 20:56:48 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOM=
MU space
>> for 69632 bytes
>> Mar 31 20:57:19 rngmhpamd usb 1-4: reset high speed USB device using=
 ehci_hcd
>> and address 8
>> Mar 31 20:57:19 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOM=
MU space
>> for 11776 bytes
>> Mar 31 20:57:19 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOM=
MU space
>> for 69632 bytes
>> Mar 31 20:57:50 rngmhpamd usb 1-4: reset high speed USB device using=
 ehci_hcd
>> and address 8
>> Mar 31 20:57:50 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOM=
MU space
>> for 11776 bytes
>> Mar 31 20:57:50 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOM=
MU space
>> for 69632 bytes
>> Mar 31 20:58:21 rngmhpamd usb 1-4: reset high speed USB device using=
 ehci_hcd
>> and address 8
>> Mar 31 20:58:21 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOM=
MU space
>> for 11776 bytes
>> Mar 31 20:58:21 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOM=
MU space
>> for 69632 bytes
>> Mar 31 20:58:52 rngmhpamd usb 1-4: reset high speed USB device using=
 ehci_hcd
>> and address 8
>> Mar 31 20:58:52 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOM=
MU space
>> for 11776 bytes
>> Mar 31 20:58:52 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOM=
MU space
>> for 69632 bytes
>> Mar 31 20:59:01 rngmhpamd sd 8:0:0:0: [sdc] Unhandled error code
>> Mar 31 20:59:01 rngmhpamd sd 8:0:0:0: [sdc] Result: hostbyte=3D0x07
>> driverbyte=3D0x00
>> Mar 31 20:59:01 rngmhpamd end_request: I/O error, dev sdc, sector 11=
37
>> Mar 31 20:59:01 rngmhpamd __ratelimit: 246 callbacks suppressed
>
> Do we have any debugging option for dumping the current PCI DMA
> allocations, find out where it has all gone?
>
>

Upgrade to 2.6.29-gentoo-r1 (2.6.29.1), problem is still here, can
easyly trigger it. I boot with default apperture, 64mb, and while
write to usb-hdd get this:

Apr  5 14:28:56 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOMMU
space for 65536 bytes
Apr  5 14:28:56 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOMMU
space for 65536 bytes
Apr  5 14:29:27 rngmhpamd usb 1-4: reset high speed USB device using
ehci_hcd and address 6
