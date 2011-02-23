From: Lars Randers <lars@nstec.dk>
Subject: Re: ExpressCard compact flash card very slow
Date: Wed, 23 Feb 2011 11:56:19 +0100
Message-ID: <AANLkTin7VByPhQ-_SNZdNgDhCoKu3j3gbtmkB9obqa4h@mail.gmail.com>
References: <4D645C59.8090406@gmail.com>
	<4D649FA2.5010204@gmail.com>
	<4D64C446.4050803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:62519 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356Ab1BWK4V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Feb 2011 05:56:21 -0500
Received: by ewy6 with SMTP id 6so1413287ewy.19
        for <linux-ide@vger.kernel.org>; Wed, 23 Feb 2011 02:56:19 -0800 (PST)
In-Reply-To: <4D64C446.4050803@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Damon Lynch <damonlynch@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

2011/2/23 Damon Lynch <damonlynch@gmail.com>:
> On 02/22/2011 11:48 PM, Robert Hancock wrote:
>>
>> The CF adapter probably doesn't support the 80-wire cable detect pro=
tocol
>> properly so the kernel thinks there's only a 40-wire cable connected=
 to it.
>> You can try libata.force=3D80c on the kernel command line and see wh=
at that
>> does.
>>
>
> It seemed to work. I got read speeds of ~55MB/s, which is ok because =
I was
> writing what was being read to an SSD.
>
> dmesg:
>
> [ =A0 =A01.651748] pata_jmicron 0000:05:00.0: PCI INT A -> GSI 19 (le=
vel, low)
> -> IRQ 19
> [ =A0 =A01.651783] pata_jmicron 0000:05:00.0: setting latency timer t=
o 64
> [ =A0 =A01.652212] scsi0 : pata_jmicron
> [ =A0 =A01.652813] scsi1 : pata_jmicron
> [ =A0 =A01.652855] ata1: PATA max UDMA/100 cmd 0x4020 ctl 0x4014 bmdm=
a 0x4000
> irq 19
> [ =A0 =A01.652857] ata2: PATA max UDMA/100 cmd 0x4018 ctl 0x4010 bmdm=
a 0x4008
> irq 19
> [ =A0 =A01.850716] ata1: FORCE: cable set to 80c
> [ =A0 =A01.850723] ata1.00: CFA: TRANSCEND, 20091215, max UDMA/133
> [ =A0 =A01.850726] ata1.00: 125059072 sectors, multi 0: LBA
> [ =A0 =A01.870111] usb 1-6: new high speed USB device using ehci_hcd =
and address
> 3
> [ =A0 =A01.890684] ata1.00: configured for UDMA/100
> [ =A0 =A01.890845] scsi 0:0:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0=
TRANSCEND
> =A02009 PQ: 0 ANSI: 5
> [ =A0 =A01.891008] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [ =A0 =A01.891020] sd 0:0:0:0: [sda] 125059072 512-byte logical block=
s: (64.0
> GB/59.6 GiB)
> [ =A0 =A01.891070] sd 0:0:0:0: [sda] Write Protect is off
> [ =A0 =A01.891073] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [ =A0 =A01.891099] sd 0:0:0:0: [sda] Write cache: disabled, read cach=
e: enabled,
> doesn't support DPO or FUA
> [ =A0 =A01.892022] =A0sda: sda1
> [ =A0 =A01.892395] sd 0:0:0:0: [sda] Attached SCSI disk
>
> What next? Can the CF reader be whitelisted by libata?
> --
I don't think thats a safe idea, as not all CF adaptors are created equ=
ally,
so I could imagine that you could easily break alot of existing machine=
s
doing so...
