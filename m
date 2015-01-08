From: Boszormenyi Zoltan <zboszor@pr.hu>
Subject: Queued TRIM without NCQ support
Date: Thu, 08 Jan 2015 12:31:28 +0100
Message-ID: <54AE6A90.7030704@pr.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail9.pr.hu ([87.242.0.9]:35527 "EHLO mail9.pr.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756393AbbAHLoy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Jan 2015 06:44:54 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Steve Tilden <stilden@sicom.com>

Hi,

I came across an SSD (Transcend SSD370) that I cannot
successfully e2fsck/fstrim when connected to an SATA2 interface.

The problem is:

[80839.972834] ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x=
6 frozen
[80839.972845] ata9.00: failed command: DATA SET MANAGEMENT
[80839.972855] ata9.00: cmd 06/01:01:00:00:00/00:00:00:00:00/a0 tag 8 d=
ma 512 out
         res 40/00:ff:16:62:86/00:00:00:00:00/40 Emask 0x4 (timeout)
[80839.972861] ata9.00: status: { DRDY }
[80839.972868] ata9: hard resetting link
[80841.349941] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[80841.382029] ata9.00: configured for UDMA/133
[80841.382046] ata9: EH complete

However, when connected to an SATA3 interface, both e2fsck and fstrim s=
ucceeds.

The difference is below.

Over SATA2:

[80591.741191] ata9.00: ATA-9: TS64GSSD370, N0815B, max UDMA/133
[80591.741199] ata9.00: 125045424 sectors, multi 1: LBA48

Over SATA3:

[83087.473254] ata5.00: ATA-9: TS64GSSD370, N0815B, max UDMA/133
[83087.473267] ata5.00: 125045424 sectors, multi 1: LBA48 NCQ (depth 31=
/32), AA
[83087.473550] ata5.00: configured for UDMA/133

So, the disk doesn't announce NCQ support over SATA2, only over SATA3.
But e2fsck still wanted to use TRIM by default and the kernel thinks
it's a good idea to send TRIM over NCQ when NCQ support is missing.
I had to use "e2fsck -E nodiscard" to format it in the SATA2 interface.

Is it a kernel bug? Or possibly the disk announces queued TRIM support
without NCQ and the kernel wants to exploit it?

Please, reply-all, I am not subscribed to this list.

Thanks in advance,
Zolt=E1n B=F6sz=F6rm=E9nyi

