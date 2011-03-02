From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: libata: ATA exception error messages in pata_sch module (CONFIG_PATA_SCH)
Date: Tue, 01 Mar 2011 18:59:48 -0600
Message-ID: <4D6D9684.505@gmail.com>
References: <AANLkTikD3NOA7=zOLRaft8TL=sTgPSCHNNKgTP3AfYWD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55509 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757226Ab1CBA7v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Mar 2011 19:59:51 -0500
Received: by qwd7 with SMTP id 7so4158961qwd.19
        for <linux-ide@vger.kernel.org>; Tue, 01 Mar 2011 16:59:50 -0800 (PST)
In-Reply-To: <AANLkTikD3NOA7=zOLRaft8TL=sTgPSCHNNKgTP3AfYWD@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kushal Koolwal <kushalkoolwal@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Borislav Petkov <petkovbb@gmail.com>, linux-ide@vger.kernel.org

On 03/01/2011 05:17 PM, Kushal Koolwal wrote:
> I see the following group of exception messages (repeated 5 times)
> when a IDE CD-ROM is present along with IDE hard drive on this Intel
> Atom/Menlow  system:
>
> [    4.278671] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
> [    4.278769] ata1.00: BMDMA stat 0x64
> [    4.278856] ata1.00: failed command: READ DMA
> [    4.278950] ata1.00: cmd c8/00:20:70:ca:ab/00:00:00:00:00/e0 tag 0
> dma 16384 in
> [    4.278953]          res 51/84:00:8f:ca:ab/00:00:00:00:00/e0 Emask
> 0x10 (ATA bus error)
> [    4.279238] ata1.00: status: { DRDY ERR }
> [    4.279322] ata1.00: error: { ICRC ABRT }
> [    4.279429] ata1: soft resetting link
> [    4.656816] ata1.00: configured for UDMA/100
> [    4.688263] ata1.01: configured for UDMA/33
> [    4.689038] ata1: EH complete
> [    4.703657] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
> [    4.703749] ata1.00: BMDMA stat 0x64
> [    4.703834] ata1.00: failed command: READ DMA
> [    4.703928] ata1.00: cmd c8/00:20:70:ca:ab/00:00:00:00:00/e0 tag 0
> dma 16384 in
> [    4.703931]          res 51/84:00:8f:ca:ab/00:00:00:00:00/e0 Emask
> 0x10 (ATA bus error)
> [    4.704163] ata1.00: status: { DRDY ERR }
> [    4.704249] ata1.00: error: { ICRC ABRT }
> [    4.704355] ata1: soft resetting link
> [    5.081245] ata1.00: configured for UDMA/100
> [    5.112262] ata1.01: configured for UDMA/33
> [    5.113026] ata1: EH complete
>
> The system does boot fine ultimately and hdparm reports the correct
> max. UDMA mode permissible on the system which is UDMA2 in this case.
> The system uses 40 conductor cable. I do not see the above exception
> messages when only IDE hard drive is present.
>
> Giving the parameter libata.force=40c gets rid of these messages.

You shouldn't really use a 40-conductor cable in a system that has 
devices that support faster than UDMA mode 2. Normally the kernel would 
detect the 40-wire cable and block using faster speeds, but it seems 
like the pata_sch driver doesn't support cable detection as the 
cable_detect method is set to ata_cable_unknown (either because the 
hardware doesn't support it or the author didn't bother to implement 
it), so it can't detect this automatically.

It's possible that it works without the CD-ROM drive since there is less 
electrical noise, etc. with only one device on the cable.

>
> Attaching dmesg and lspci -vvvxxx output when both an IDE CD-ROM and
> hard drive is present. I noticed that the D0TIM Bit30 (PPE) and D0TIM
> Bit31 (USD) are both set by Linux kernel in the PCI config space of
> the IDE controller.
>
> Please let me know what other information I can provide in this regards.
>
> Kushal Koolwal

