From: Marc Dionne <marc.c.dionne@gmail.com>
Subject: Re: Hang during boot, bisected to commit 96d60303fd
Date: Wed, 2 Jun 2010 22:11:09 -0400
Message-ID: <AANLkTikTvOU-f4bF_9aYcFCx5zyVxC-8HS1Wb4jFJSXa@mail.gmail.com>
References: <AANLkTiktNufXK_pn6mP2-zyowAIbHlUy5TGu3AtpALv-@mail.gmail.com>
	<20100603020006.GB19123@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f223.google.com ([209.85.219.223]:35401 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933518Ab0FCCLL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2010 22:11:11 -0400
In-Reply-To: <20100603020006.GB19123@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, garzik@redhat.com

On Wed, Jun 2, 2010 at 10:00 PM, Matthew Garrett <mjg59@srcf.ucam.org> =
wrote:
> On Wed, Jun 02, 2010 at 09:49:27PM -0400, Marc Dionne wrote:
>> =A0 =A0Since somewhere early in the 2.6.35 merge window I've been se=
eing a hang
>> =A0 =A0during boot. =A0The hang last roughly 30 seconds and is follo=
wed by this:
>>
>> =A0 =A0ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fro=
zen
>> =A0 =A0ata4.00: failed command: READ FPDMA QUEUED
>> =A0 =A0ata4.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 40=
96 in
>> =A0 =A0 =A0 =A0 =A0 =A0 res 40/00:00:00:00:00/00:00:00:00:00/00 Emas=
k 0x4 (timeout)
>> =A0 =A0ata4.00: status: { DRDY }
>> =A0 =A0ata4: hard resetting link
>> =A0 =A0ahci_is_device_present: status is: 80
>> =A0 =A0ahci_is_device_present: status(2) is: 3
>> =A0 =A0ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> =A0 =A0ata4.00: configured for UDMA/133
>> =A0 =A0ata4.00: device reported invalid CHS sector 0
>> =A0 =A0ata4: EH complete
>>
>> =A0 =A0The system works normally once booted. =A0I had some time to =
do a bisect
>> =A0 =A0today and it cleanly ended up pointing to this commit:
>> =A0 =A0 =A0 =A096d60303fd: ahci: Turn off DMA engines when there's n=
o device attached
>>
>> =A0 =A0Reverting the commit makes the system boot cleanly as before.=
 =A0System has
>> =A0 =A0an Intel ICH10 based board, in AHCI mode, disk is an Intel X2=
5M SSD.
>
> Hm, interesting. Jeff, any immediate ideas? I don't see this behaviou=
r
> on my ICH10. Is there actually a device on ata4?
>
> --
> Matthew Garrett | mjg59@srcf.ucam.org

Yes, ata4 is the Intel SSD:

ata4.00: ATA-7: INTEL SSDSA2MH080G1GC, 045C8610, max UDMA/133

Marc
