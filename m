From: =?utf-8?B?UGF3ZcWCIMW7YWs=?= <pawel.zaq@gmail.com>
Subject: Re: [Bug 42679] New: DMA Read on Marvell 88SE9128 fails when	Intel's
 IOMMU is on
Date: Mon, 30 Jan 2012 23:13:02 +0100
Message-ID: <op.v8w3z0z0c3q55a@localhost>
References: <bug-42679-27@https.bugzilla.kernel.org/>
 <20120130125934.7971c815.akpm@linux-foundation.org>
 <4F270E8C.2000406@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41657 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234Ab2A3WNI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2012 17:13:08 -0500
Received: by eaal13 with SMTP id l13so1278485eaa.19
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2012 14:13:07 -0800 (PST)
In-Reply-To: <4F270E8C.2000406@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Don Dutile <ddutile@redhat.com>
Cc: linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>, bugzilla-daemon@bugzilla.kernel.org

On Mon, 30 Jan 2012 22:41:32 +0100, Don Dutile <ddutile@redhat.com> wro=
te:

> On 01/30/2012 03:59 PM, Andrew Morton wrote:
>>
>> (switched to email.  Please respond via emailed reply-to-all, not vi=
a =20
>> the
>> bugzilla web interface).
>>
>> On Sat, 28 Jan 2012 17:55:38 GMT
>> bugzilla-daemon@bugzilla.kernel.org wrote:
>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D42679
>>
>> I don't know if this is a SATA issue or intel-iommu.  Could you guys
>> please take a look?
>>
>>>             Summary: DMA Read on Marvell 88SE9128 fails when Intel'=
s =20
>>> IOMMU
>>>                      is on
>>>             Product: Memory Management
>>>             Version: 2.5
>>>            Platform: All
>>>          OS/Version: Linux
>>>                Tree: Mainline
>>>              Status: NEW
>>>            Severity: normal
>>>            Priority: P1
>>>           Component: Other
>>>          AssignedTo: akpm@linux-foundation.org
>>>          ReportedBy: pawel.zaq@gmail.com
>>>          Regression: No
>>>
>>>
>>> Created an attachment (id=3D72217)
>>>   -->  (https://bugzilla.kernel.org/attachment.cgi?id=3D72217)
>>> Output of `dmesg' command
>>>
>>> I have a MSI Z68A-GD80 B3 motherboard and when I try to enable Inte=
l's =20
>>> IOMMU
>>> (kernel booted with intel_iommu=3Don), integrated Marvell 88SE9128 =
SATA
>>> controller doesn't work.
>>>
>>> To reproduce:
>>> 1. Compile and prepare kernel with Intel IOMMU support enabled
>>> (CONFIG_INTEL_IOMMU=3Dy).
>>> 2. Reboot the computer.
>>> 3. Enter BIOS and enable VT-d.
>>> 4. Boot the kernel with intel_iommu=3Don parameter.
>>>
>>> Right after boot, kernel reports the following errors (SATA control=
ler =20
>>> is at
>>> 0b:00.0):
>>>
>>> [    2.639774] DRHD: handling fault status reg 3
>>> [    2.639782] DMAR:[DMA Read] Request device [0b:00.1] fault addr =
=20
>>> fff00000
>>> [    2.639783] DMAR:[fault reason 02] Present bit in context entry =
is =20
>>> clear
>>>
>>> After a while these entries appear:
>>>
>>> [    7.625837] ata14.00: qc timeout (cmd 0xa1)
>>> [    7.628341] ata14.00: failed to IDENTIFY (I/O error, err_mask=3D=
0x4)
>>> [    7.935483] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 3=
00)
>>> [   17.908407] ata14.00: qc timeout (cmd 0xa1)
>>> [   17.910935] ata14.00: failed to IDENTIFY (I/O error, err_mask=3D=
0x4)
>>> [   17.912276] ata14: limiting SATA link speed to 1.5 Gbps
>>> [   18.219077] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 3=
10)
>>> [   48.134607] ata14.00: qc timeout (cmd 0xa1)
>>> [   48.137508] ata14.00: failed to IDENTIFY (I/O error, err_mask=3D=
0x4)
>>> [   48.444646] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 3=
10)
>>>
>>> When there is a disk connected to the controller it does not work. =
=20
>>> When there
>>> are none, computer starts normally, apart from the huge lag caused =
by,
>>> presumably, probing the device.
>>>
>>> Since this is the secondary controller on these motherboards, to =20
>>> eliminate
>>> those symptoms you can just plug disk in one of available ports of =
the =20
>>> built-in
>>> Intel SATA controller and disable Marvell's one using BIOS. The oth=
er
>>> work-around, if you need to use eSATA capabilities of the latter, i=
s =20
>>> to disable
>>> VT-d techonology also using BIOS.
>>
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
> Well, the lspci dump in the bugzilla report doesn't show a device =20
> w/BDF=3D0b:00.1;
> so, if the SATA device (which is 0b:00.0) is spitting out 0b:00.1 as =
the =20
> source
> of any of its DMA packets, the IOMMU will fault on it, since 0b:00.1 =
=20
> didn't
> request DMA mappings (0b:00.0 did).
> I semi-recall someone else reporting this 'feature' on this list.
> Wonder if pci-quirk has to filter this case (0b:00.0 on this system m=
eans
> map for 0b:00.0 & 0b:00.1 -- ick!)
>
> do another lspci -vvv to ensure that 0b:00.1 wasn't excluded in the l=
ist.
> if it doesn't exist, then the problem is the SATA device using an =20
> unknown/unrecognized
> BDF of 0b:00.1

Yep, that's correct. I enabled all integrated peripherals on my =20
motherboard and there were still no entries with BDF 0b:00.1 in lspci -=
vvv =20
output. Should I take this problem to MSI then?

	Pawe=C5=82
