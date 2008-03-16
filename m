From: <drtyc@centrum.cz>
Subject: Re: excess timeouts accessing pci-sata card both ports
Date: Sun, 16 Mar 2008 01:19:21 +0100
Message-ID: <200803160119.6349@centrum.cz>
References: 0801240919.2173@centrum.cz> <200801240919.2173@centrum.cz> <200801242359.10655@centrum.cz> <200801250037.4195@centrum.cz> <200801250055.9430@centrum.cz> <47A3FB8F.4060103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1250
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1004.centrum.cz ([213.29.7.171]:46174 "EHLO
	mail1004.centrum.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbYCPCA4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Mar 2008 22:00:56 -0400
Received: by mail1004.centrum.cz id S805582397AbYCPATV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Mar 2008 01:19:21 +0100
In-Reply-To: <47A3FB8F.4060103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, drtyc@centrum.cz
Cc: linux-ide@vger.kernel.org

Hi.

Reproducible with only one disk and one card on one SATA port.
The card has 3 ports. 2 internal, 1 external. The internal closer to th=
e external and the extrenal has the problem.

Just doing cat /dev/disk > /dev/null
or any intensive IO - it happens in less then aprox 30sec.

Or setting raid speed min and max to some high number and do a resync w=
ith multiple disks can trigger similar write error.
Anyway got already 6 different cards and all behave similarly plus one =
of the internal ports is rock solid while the other has problems so I t=
ake it as falty design and RMA hoprfully last time now to legaly reques=
t money back.
______________________________________________________________
> Od: htejun@gmail.com
> Komu: drtyc@centrum.cz
> CC: linux-ide@vger.kernel.org
> Datum: 02.02.2008 06:11
> P=F8edm=ECt: Re: excess timeouts accessing pci-sata card both ports
>
>drtyc@centrum.cz wrote:
>> Removed 3 drives. Both data and power.
>> Left only port1 connected
>> It's the drive and power cable that in the first test was port2 fail=
ing
>> and in second test was port1 and ok
>> both cards plugged in and initialized.
>> third test it's the port1 alone sda working ok
>> fourth test it's the port2 alone sda failing.
>>=20
>> any idea what's wrong as this does not seem to be power related
problem.
>>=20
>> vanilla 2.6.23.14
>> sata_via module... details in the inlined emails.
>>=20
>> (4th test config)
>> ata1: SATA link down (SStatus 0 SControl 310)
>> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> ata4: SATA link down (SStatus 0 SControl 310)
>> ata5: SATA link down (SStatus 0 SControl 310)
>>=20
>> Faulty card? Both cards? Driver bug? Or design bug/incompatibility o=
n
second port?
>
>It seems like you're experiencing transmission problems on reads.
>SError value of 0x3000400 is Protocol Error, Link Sequence Error and
>Transport State Transition Error.  Hardresetting the link should usual=
ly
>recover from such conditions but error handling on via has never been
>reliable.  How easily can you trigger the problem?
>
>Thanks.
>
>--=20
>tejun
>

