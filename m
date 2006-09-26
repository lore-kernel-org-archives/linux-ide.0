From: Tejun Heo <htejun@gmail.com>
Subject: Re: dvd-r detection problem with port multiplier
Date: Tue, 26 Sep 2006 15:14:44 +0900
Message-ID: <4518C554.8040909@gmail.com>
References: <KMS-2137222924-2156@mail.norwalkdist.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:64901 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751017AbWIZGOu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Sep 2006 02:14:50 -0400
Received: by py-out-1112.google.com with SMTP id n25so2853254pyg
        for <linux-ide@vger.kernel.org>; Mon, 25 Sep 2006 23:14:49 -0700 (PDT)
In-Reply-To: <KMS-2137222924-2156@mail.norwalkdist.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Trent George <trent@norwalkdist.com>
Cc: linux-ide@vger.kernel.org

Hello, Trent.

Trent George wrote:
[--snip--]
> I should have mentioned that they have sata to pata bridgeboards
> on the drives.

That shouldn't change much.

> I tried rebooting, with discs in and not in the drives.
> I can send you a physical bridgeboard, or drive if it helps you...
> the samsung hard drive is on the motherboard sata controller.
> the dvd drives are on pmp on the sata_sil24 board

I have plenty of SATA and PMP hardware these days, so thanks but that 
wouldn't be necessary.

[--snip--]
> sata_sil24 0000:01:00.0: version 0.3
> ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
> PCI: Setting latency timer of device 0000:01:00.0 to 64
> ata3: SATA max UDMA/100 cmd 0xFFFFC20000020000 ctl 0x0 bmdma 0x0 irq 169
> ata4: SATA max UDMA/100 cmd 0xFFFFC20000022000 ctl 0x0 bmdma 0x0 irq 169
> scsi2 : sata_sil24
> sd 0:0:0:0: Attached scsi generic sg0 type 0
> ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 5 ports, feat 0x9/0x9
> ata3.00: hard resetting port
> ata3.00: softreset failed (timeout)
> ata3.00: follow-up softreset failed, retrying in 5 secs
> ata3.00: hard resetting port
> ata3.00: COMRESET failed (errno=3D-16)
> ata3.00: reset failed, giving up
> ata3.15: hard resetting port
> ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.00: hard resetting port
> ata3.00: softreset failed (timeout)
> ata3.00: follow-up softreset failed, retrying in 5 secs
> ata3.00: hard resetting port
> ata3.00: COMRESET failed (errno=3D-16)
> ata3.00: reset failed, giving up
> ata3.00: failed to recover link after 2 tries, disabling

Is the first port occupied?  3726 seems to fail initialization if the 
first port is not occupied.  At the moment, I'm not very sure whether 
the hardware or the driver is responsible for this.  When this happens, 
all other ports fail too which is consistent with your result.

[--snip--]
> sata_sil24 0000:01:00.0: version 0.3
> ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
> PCI: Setting latency timer of device 0000:01:00.0 to 64
> ata3: SATA max UDMA/100 cmd 0xFFFFC20000020000 ctl 0x0 bmdma 0x0 irq 169
> Losing some ticks... checking if CPU frequency changed.
> sd 0:0:0:0: Attached scsi generic sg0 type 0
> ata4: SATA max UDMA/100 cmd 0xFFFFC20000022000 ctl 0x0 bmdma 0x0 irq 169
> scsi2 : sata_sil24
> ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.00: ATAPI, max UDMA/66
> ata3.00: configured for UDMA/66
> scsi3 : sata_sil24
> ata4: SATA link down (SStatus 0 SControl 300)
>   Vendor: _NEC      Model: DVD_RW ND-3550A   Rev: 1.G3
>   Type:   CD-ROM                             ANSI SCSI revision: 05

Ah... So your ATAPI device is connected to the first port.  Can you swap 
the two and see what happens?  Does the same setup work okay on windows?

Thanks for testing.

-- 
tejun
