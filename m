From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Queued TRIM without NCQ support
Date: Sun, 18 Jan 2015 00:16:49 -0600
Message-ID: <54BB4FD1.5000506@gmail.com>
References: <54AE6A90.7030704@pr.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:45135 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbbARGQw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Jan 2015 01:16:52 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so26627010iec.10
        for <linux-ide@vger.kernel.org>; Sat, 17 Jan 2015 22:16:51 -0800 (PST)
In-Reply-To: <54AE6A90.7030704@pr.hu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Boszormenyi Zoltan <zboszor@pr.hu>, linux-ide@vger.kernel.org
Cc: Steve Tilden <stilden@sicom.com>

On 08/01/15 05:31 AM, Boszormenyi Zoltan wrote:
> Hi,
>
> I came across an SSD (Transcend SSD370) that I cannot
> successfully e2fsck/fstrim when connected to an SATA2 interface.
>
> The problem is:
>
> [80839.972834] ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action =
0x6 frozen
> [80839.972845] ata9.00: failed command: DATA SET MANAGEMENT
> [80839.972855] ata9.00: cmd 06/01:01:00:00:00/00:00:00:00:00/a0 tag 8=
 dma 512 out
>           res 40/00:ff:16:62:86/00:00:00:00:00/40 Emask 0x4 (timeout)
> [80839.972861] ata9.00: status: { DRDY }
> [80839.972868] ata9: hard resetting link
> [80841.349941] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [80841.382029] ata9.00: configured for UDMA/133
> [80841.382046] ata9: EH complete
>
> However, when connected to an SATA3 interface, both e2fsck and fstrim=
 succeeds.
>
> The difference is below.
>
> Over SATA2:
>
> [80591.741191] ata9.00: ATA-9: TS64GSSD370, N0815B, max UDMA/133
> [80591.741199] ata9.00: 125045424 sectors, multi 1: LBA48
>
> Over SATA3:
>
> [83087.473254] ata5.00: ATA-9: TS64GSSD370, N0815B, max UDMA/133
> [83087.473267] ata5.00: 125045424 sectors, multi 1: LBA48 NCQ (depth =
31/32), AA
> [83087.473550] ata5.00: configured for UDMA/133
>
> So, the disk doesn't announce NCQ support over SATA2, only over SATA3=
=2E
> But e2fsck still wanted to use TRIM by default and the kernel thinks
> it's a good idea to send TRIM over NCQ when NCQ support is missing.

I don't think this is the issue, because if it was trying to use queued=
=20
trim it would be sending SEND FPDMA QUEUED, not the DATA SET MANAGEMENT=
=20
command. What kind of SATA2 interface are you using in this case, exact=
ly?

> I had to use "e2fsck -E nodiscard" to format it in the SATA2 interfac=
e.
>
> Is it a kernel bug? Or possibly the disk announces queued TRIM suppor=
t
> without NCQ and the kernel wants to exploit it?
>
> Please, reply-all, I am not subscribed to this list.
>
> Thanks in advance,
> Zolt=E1n B=F6sz=F6rm=E9nyi
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

