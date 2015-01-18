From: Boszormenyi Zoltan <zboszor@pr.hu>
Subject: Re: Queued TRIM without NCQ support
Date: Sun, 18 Jan 2015 09:16:13 +0100
Message-ID: <54BB6BCD.6050409@pr.hu>
References: <54AE6A90.7030704@pr.hu> <54BB4FD1.5000506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail9.pr.hu ([87.242.0.9]:36160 "EHLO mail9.pr.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209AbbARIQ0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 18 Jan 2015 03:16:26 -0500
In-Reply-To: <54BB4FD1.5000506@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org
Cc: Steve Tilden <stilden@sicom.com>

2015-01-18 07:16 keltez=E9ssel, Robert Hancock =EDrta:
> On 08/01/15 05:31 AM, Boszormenyi Zoltan wrote:
>> Hi,
>>
>> I came across an SSD (Transcend SSD370) that I cannot
>> successfully e2fsck/fstrim when connected to an SATA2 interface.
>>
>> The problem is:
>>
>> [80839.972834] ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action=
 0x6 frozen
>> [80839.972845] ata9.00: failed command: DATA SET MANAGEMENT
>> [80839.972855] ata9.00: cmd 06/01:01:00:00:00/00:00:00:00:00/a0 tag =
8 dma 512 out
>>           res 40/00:ff:16:62:86/00:00:00:00:00/40 Emask 0x4 (timeout=
)
>> [80839.972861] ata9.00: status: { DRDY }
>> [80839.972868] ata9: hard resetting link
>> [80841.349941] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300=
)
>> [80841.382029] ata9.00: configured for UDMA/133
>> [80841.382046] ata9: EH complete
>>
>> However, when connected to an SATA3 interface, both e2fsck and fstri=
m succeeds.
>>
>> The difference is below.
>>
>> Over SATA2:
>>
>> [80591.741191] ata9.00: ATA-9: TS64GSSD370, N0815B, max UDMA/133
>> [80591.741199] ata9.00: 125045424 sectors, multi 1: LBA48
>>
>> Over SATA3:
>>
>> [83087.473254] ata5.00: ATA-9: TS64GSSD370, N0815B, max UDMA/133
>> [83087.473267] ata5.00: 125045424 sectors, multi 1: LBA48 NCQ (depth=
 31/32), AA
>> [83087.473550] ata5.00: configured for UDMA/133
>>
>> So, the disk doesn't announce NCQ support over SATA2, only over SATA=
3.
>> But e2fsck still wanted to use TRIM by default and the kernel thinks
>> it's a good idea to send TRIM over NCQ when NCQ support is missing.
>
> I don't think this is the issue, because if it was trying to use queu=
ed trim it would be
> sending SEND FPDMA QUEUED, not the DATA SET MANAGEMENT command. What =
kind of SATA2
> interface are you using in this case, exactly?

This is a Sharkoon SATA QUICKPORT DUO II eSATA bay attached to
the eSATA interface to my ASUS M5A99X EVO mainboard, which
is on a JMicron JMB362 controller.

=46YI, a Samsung 840 EVO works on the same eSATA with TRIM, both
mke2fs and fstrim.

The support at Transcend confirmed the problem over SATA2 in the meanti=
me.

>
>> I had to use "e2fsck -E nodiscard" to format it in the SATA2 interfa=
ce.
>>
>> Is it a kernel bug? Or possibly the disk announces queued TRIM suppo=
rt
>> without NCQ and the kernel wants to exploit it?
>>
>> Please, reply-all, I am not subscribed to this list.
>>
>> Thanks in advance,
>> Zolt=E1n B=F6sz=F6rm=E9nyi
>>
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe linux-ide"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>

