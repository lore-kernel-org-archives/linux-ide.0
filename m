From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: libata EH running when switching VTs
Date: Sat, 22 Jan 2011 10:36:15 -0600
Message-ID: <4D3B077F.7040000@gmail.com>
References: <201101221625.00775.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51413 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab1AVQgS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Jan 2011 11:36:18 -0500
In-Reply-To: <201101221625.00775.toralf.foerster@gmx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Cc: linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>

(CCing linux-ide)

On 01/22/2011 09:25 AM, Toralf F=C3=B6rster wrote:
> Hello,
>
> Henrique de Moraes Holschuh wrote at 14:11:12
>>
>> I don't even know whom to refer you to.  Maybe ask in LKML directly?=
  Use
>> the subject "libata EH running when switching VTs".  If one of those=
 VTs
>> are in X.org control, say that as well.
>
> I'm wondering why I get this in /var/log/messages w/ kernel 2.6.37 wh=
en I
> switch from VT7 (running xorg ) to VT12 (or 1 or 2 or another number)=
 and
> back:
>
>
> 2011-01-22T16:20:53.854+01:00 n22 kernel: ata1: hard resetting link
> 2011-01-22T16:20:54.163+01:00 n22 kernel: ata1: SATA link up 1.5 Gbps=
 (SStatus
> 113 SControl 300)
> 2011-01-22T16:20:54.164+01:00 n22 kernel: ata1.00: ACPI cmd
> ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
> 2011-01-22T16:20:54.164+01:00 n22 kernel: ata1.00: ACPI cmd
> f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
> 2011-01-22T16:20:54.165+01:00 n22 kernel: ata1.00: ACPI cmd
> ef/5f:00:00:00:00:a0 (SET FEATURES) succeeded
> 2011-01-22T16:20:54.165+01:00 n22 kernel: ata1.00: ACPI cmd
> ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
> 2011-01-22T16:20:54.169+01:00 n22 kernel: ata1.00: ACPI cmd
> ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
> 2011-01-22T16:20:54.169+01:00 n22 kernel: ata1.00: ACPI cmd
> f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
> 2011-01-22T16:20:54.169+01:00 n22 kernel: ata1.00: ACPI cmd
> ef/5f:00:00:00:00:a0 (SET FEATURES) succeeded
> 2011-01-22T16:20:54.169+01:00 n22 kernel: ata1.00: ACPI cmd
> ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
> 2011-01-22T16:20:54.170+01:00 n22 kernel: ata1.00: configured for UDM=
A/100
> 2011-01-22T16:20:54.171+01:00 n22 kernel: ata1: EH complete
>
>
> I'm running an almost stable Gentoo on a ThinkPad T400 with current k=
ernel
> (2.6.37, earlier shows this behaviour too)

Is that the only output you're getting? Can you post the full dmesg log=
=20
from bootup?
