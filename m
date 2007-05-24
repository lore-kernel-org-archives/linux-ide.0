From: "Pascal Schmidt" <pasukaru@yurusanai.de>
Subject: Re: HPT366 not enabled by kernel 2.6.21.2
Date: Fri, 25 May 2007 01:33:26 +0200 (CEST)
Message-ID: <43030.80.228.59.88.1180049606.squirrel@yurusanai.de>
References: <48969.80.228.60.226.1180041664.squirrel@yurusanai.de>
    <200705250015.02222.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753573AbXEXXdd@vger.kernel.org>
In-Reply-To: <200705250015.02222.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>
List-Id: linux-ide@vger.kernel.org


Hello again!

> The fix from Sergei (queued for 2.6.21.3) is here:
>
> http://git.kernel.org/?p=linux/kernel/git/stable/stable-queue.git;a=blob_plain;f=queue-2.6.21/hpt366-don-t-check-enablebits-for-hpt36x.patch;h=0833e0a37e23ed103a18ca93684201e1cb94a0a9
>
> [ it has already been merged into 2.6.22 tree ]

Thank you. The patch works for me.

HPT366: IDE controller at PCI slot 0000:02:0a.0
ACPI: PCI Interrupt 0000:02:0a.0[A] -> GSI 18 (level, low) -> IRQ 18
HPT366: chipset revision 1
HPT366: using 33 MHz PCI clock
HPT366: 100% native mode on irq 18
    ide2: BM-DMA at 0xd300-0xd307, BIOS settings: hde:pio, hdf:pio
ACPI: PCI Interrupt 0000:02:0a.1[A] -> GSI 18 (level, low) -> IRQ 18
HPT366: using 33 MHz PCI clock
    ide3: BM-DMA at 0xd600-0xd607, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: TOSHIBA THNCF1G02MG, CFA DISK drive
ide2 at 0xd100-0xd107,0xd202 on irq 18

-- 
Ciao,
Pascal
