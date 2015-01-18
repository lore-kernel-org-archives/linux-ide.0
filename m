From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Queued TRIM without NCQ support
Date: Sun, 18 Jan 2015 13:47:22 -0600
Message-ID: <CADLC3L0kXCpTmh0WUhPiDffsAVMiqWOngtmrfONLa_D1mwtzOA@mail.gmail.com>
References: <54AE6A90.7030704@pr.hu>
	<54BB4FD1.5000506@gmail.com>
	<54BB6BCD.6050409@pr.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:63261 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbbARTrX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Jan 2015 14:47:23 -0500
Received: by mail-qa0-f42.google.com with SMTP id dc16so21496037qab.1
        for <linux-ide@vger.kernel.org>; Sun, 18 Jan 2015 11:47:22 -0800 (PST)
In-Reply-To: <54BB6BCD.6050409@pr.hu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Boszormenyi Zoltan <zboszor@pr.hu>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Steve Tilden <stilden@sicom.com>

On Sun, Jan 18, 2015 at 2:16 AM, Boszormenyi Zoltan <zboszor@pr.hu> wro=
te:
> 2015-01-18 07:16 keltez=C3=A9ssel, Robert Hancock =C3=ADrta:
>> On 08/01/15 05:31 AM, Boszormenyi Zoltan wrote:
>>> Hi,
>>>
>>> I came across an SSD (Transcend SSD370) that I cannot
>>> successfully e2fsck/fstrim when connected to an SATA2 interface.
>>>
>>> The problem is:
>>>
>>> [80839.972834] ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 actio=
n 0x6 frozen
>>> [80839.972845] ata9.00: failed command: DATA SET MANAGEMENT
>>> [80839.972855] ata9.00: cmd 06/01:01:00:00:00/00:00:00:00:00/a0 tag=
 8 dma 512 out
>>>           res 40/00:ff:16:62:86/00:00:00:00:00/40 Emask 0x4 (timeou=
t)
>>> [80839.972861] ata9.00: status: { DRDY }
>>> [80839.972868] ata9: hard resetting link
>>> [80841.349941] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
>>> [80841.382029] ata9.00: configured for UDMA/133
>>> [80841.382046] ata9: EH complete
>>>
>>> However, when connected to an SATA3 interface, both e2fsck and fstr=
im succeeds.
>>>
>>> The difference is below.
>>>
>>> Over SATA2:
>>>
>>> [80591.741191] ata9.00: ATA-9: TS64GSSD370, N0815B, max UDMA/133
>>> [80591.741199] ata9.00: 125045424 sectors, multi 1: LBA48
>>>
>>> Over SATA3:
>>>
>>> [83087.473254] ata5.00: ATA-9: TS64GSSD370, N0815B, max UDMA/133
>>> [83087.473267] ata5.00: 125045424 sectors, multi 1: LBA48 NCQ (dept=
h 31/32), AA
>>> [83087.473550] ata5.00: configured for UDMA/133
>>>
>>> So, the disk doesn't announce NCQ support over SATA2, only over SAT=
A3.
>>> But e2fsck still wanted to use TRIM by default and the kernel think=
s
>>> it's a good idea to send TRIM over NCQ when NCQ support is missing.
>>
>> I don't think this is the issue, because if it was trying to use que=
ued trim it would be
>> sending SEND FPDMA QUEUED, not the DATA SET MANAGEMENT command. What=
 kind of SATA2
>> interface are you using in this case, exactly?
>
> This is a Sharkoon SATA QUICKPORT DUO II eSATA bay attached to
> the eSATA interface to my ASUS M5A99X EVO mainboard, which
> is on a JMicron JMB362 controller.
>
> FYI, a Samsung 840 EVO works on the same eSATA with TRIM, both
> mke2fs and fstrim.
>
> The support at Transcend confirmed the problem over SATA2 in the mean=
time.

If we could find more details about what the problem was, we could
likely add a quirk to disable trim support. However, it's not clear if
it's actually SATA2 (i.e. 3Gbps) specific, or maybe it's something to
do with the JMicron controller or something.
