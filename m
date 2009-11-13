From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH #upstream-fixes 2/2] libata: implement ATAPI_HORKAGE_NOPIO
	and apply it to GGW-H10N
Date: Fri, 13 Nov 2009 02:14:27 -0700
Message-ID: <e9c3a7c20911130114u2212e921n83b1b77a8a49d81c@mail.gmail.com>
References: <4857313A.1000405@kernel.org> <48573174.9050103@kernel.org>
	 <20080617094354.338e186b@lxorguk.ukuu.org.uk>
	 <48578080.5030605@kernel.org> <20080617095439.GA9359@lukeross.name>
	 <20080617110450.668f37e2@lxorguk.ukuu.org.uk>
	 <4857ADC3.3040106@kernel.org> <20080618114828.GB19903@lukeross.name>
	 <4858F894.6030409@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f192.google.com ([209.85.212.192]:53189 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755689AbZKMJO1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Nov 2009 04:14:27 -0500
Received: by vws30 with SMTP id 30so871751vws.33
        for <linux-ide@vger.kernel.org>; Fri, 13 Nov 2009 01:14:28 -0800 (PST)
In-Reply-To: <4858F894.6030409@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Luke Ross <luke@lukeross.name>, Tejun Heo <tj@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Wed, Jun 18, 2008 at 4:59 AM, Jeff Garzik <jeff@garzik.org> wrote:
> I really think it's more generalized ATAPI brokenness, perhaps specif=
ic to
> AHCI.
>
> I'm going to allocate some time to dig into this, if Tejun doesn't fi=
nd the
> problem, because it's not just limited to a few models. =A0We've been=
 getting
> _tons_ of timeout bug reports, and in fact, my own AHCI-based worksta=
tion
> cannot rip audio CDs at all:
>

=2E..maybe the following is related?

I have a problem report against an ICH9R platform in ahci mode.  The
customer is trying to send 'set streaming' (0xb6) ATAPI commands to an
optical drive.  They report that it works fine with sata_mv, but the
same test fails on ahci.

ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATAPI: HL-DT-ST BD-RE  GBW-H20L, 8.B8, max UDMA/100
ata2.00: configured for UDMA/100
scsi 1:0:0:0: CD-ROM            HL-DT-ST BD-RE  GBW-H20L  8.B8 PQ: 0 AN=
SI: 5
sr0: scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
sr 1:0:0:0: Attached scsi generic sg1 type 5
[..]
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.00: cmd a0/00:00:00:1c:00/00:00:00:00:00/a0 tag 0 pio 28 out
         cdb b6 00 00 00 00 1c 00 00  00 00 00 00 00 00 00 00
         res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata2.00: status: { DRDY }
ata2: hard resetting link
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: configured for UDMA/100
ata2: EH complete

I'll try to get a reproducer, in the meantime any ideas?

Thanks,
Dan
