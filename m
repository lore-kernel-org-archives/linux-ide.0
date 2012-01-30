From: =?utf-8?B?UGF3ZcWCIMW7YWs=?= <pawel.zaq@gmail.com>
Subject: Re: [Bug 42679] New: DMA Read on Marvell 88SE9128 fails when Intel's
 IOMMU is on
Date: Tue, 31 Jan 2012 00:44:04 +0100
Message-ID: <op.v8w77qlcc3q55a@localhost>
References: <bug-42679-27@https.bugzilla.kernel.org/>
 <20120130125934.7971c815.akpm@linux-foundation.org>
 <4F270E8C.2000406@redhat.com> <op.v8w3z0z0c3q55a@localhost>
 <20120130233211.GM24091@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60397 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab2A3XoJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2012 18:44:09 -0500
Received: by eaal13 with SMTP id l13so1299050eaa.19
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2012 15:44:07 -0800 (PST)
In-Reply-To: <20120130233211.GM24091@sequoia.sous-sol.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Don Dutile <ddutile@redhat.com>, linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org, bugzilla-daemon@bugzilla.kernel.org, David Woodhouse <dwmw2@infradead.org>

On Tue, 31 Jan 2012 00:32:11 +0100, Chris Wright <chrisw@sous-sol.org>
wrote:

> * Pawe=C5=82 =C5=BBak (pawel.zaq@gmail.com) wrote:
>> On Mon, 30 Jan 2012 22:41:32 +0100, Don Dutile <ddutile@redhat.com> =
=20
>> wrote:
>> >Well, the lspci dump in the bugzilla report doesn't show a device
>> >w/BDF=3D0b:00.1;
>> >so, if the SATA device (which is 0b:00.0) is spitting out 0b:00.1
>> >as the source
>> >of any of its DMA packets, the IOMMU will fault on it, since
>> >0b:00.1 didn't
>> >request DMA mappings (0b:00.0 did).
>> >I semi-recall someone else reporting this 'feature' on this list.
>> >Wonder if pci-quirk has to filter this case (0b:00.0 on this system=
 =20
>> means
>> >map for 0b:00.0 & 0b:00.1 -- ick!)
>> >
>> >do another lspci -vvv to ensure that 0b:00.1 wasn't excluded in the=
 =20
>> list.
>> >if it doesn't exist, then the problem is the SATA device using an
>> >unknown/unrecognized
>> >BDF of 0b:00.1
>>
>> Yep, that's correct. I enabled all integrated peripherals on my
>> motherboard and there were still no entries with BDF 0b:00.1 in
>> lspci -vvv output. Should I take this problem to MSI then?
>
> Yeah, something is not right.  Is there any BIOS control over that
> device?

As far as the BIOS is concerned I can only switch between:
- disabled,
- AHCI mode,
- IDE mode.

The problem occurs in both IDE and AHCI modes.

Apart from that I am also able to bring up RAID setup window for this =20
controller, right after turning the computer on, but since there are no=
 =20
disks connected to it there's nothing I can alter.

	Pawe=C5=82
