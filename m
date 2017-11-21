From: Mark Hounschell <markh@compro.net>
Subject: AM4 B350 chipset Sata/IDE problem
Date: Tue, 21 Nov 2017 11:01:40 -0500
Message-ID: <c007cd88-968b-96d4-78bd-be375fea520a@compro.net>
Reply-To: markh@compro.net
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

I'm running a 4.13.13 kernel on an AM4 MSI B350 Tomahawk Arctic MB. 
I have a couple of these setups and both do the same. I get this output just building
a kernel. My drives are older Seagate ST3160815AS, 3.AAD, max UDMA/133 configured
at boot time for UDMA/133 ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
I can take this very disk and boot it up on an AM3 based setup and I will not
get these messages. I also have a pci-e Sata card in this AM4 box and when
connected to it instead of the MB Sata ports, I also don't get these messages.

I don't really know where the problem is but since this is a fairly new chip set I guess
it could be a kernel issue so thought I would post it for you all.

The kernel does in fact build and run. I get no user level errors.



Nov 21 10:28:01 harley kernel: ata1.00: exception Emask 0x11 SAct 0x7ffeffff SErr 0x400000 action 0x6 frozen
Nov 21 10:28:03 harley kernel: ata1.00: irq_stat 0x48000008, interface fatal error
Nov 21 10:28:03 harley kernel: ata1: SError: { Handshk }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/00:00:00:a0:f6/08:00:0c:00:00/40 tag 0 ncq dma 1048576 ou
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/00:08:00:a8:f6/08:00:0c:00:00/40 tag 1 ncq dma 1048576 ou
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/00:10:00:b0:f6/08:00:0c:00:00/40 tag 2 ncq dma 1048576 ou
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/00:18:00:b8:f6/08:00:0c:00:00/40 tag 3 ncq dma 1048576 ou
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/00:20:00:c0:f6/08:00:0c:00:00/40 tag 4 ncq dma 1048576 ou
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/00:28:00:c8:f6/08:00:0c:00:00/40 tag 5 ncq dma 1048576 ou
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/00:30:00:d0:f6/08:00:0c:00:00/40 tag 6 ncq dma 1048576 ou
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/00:38:00:d8:f6/08:00:0c:00:00/40 tag 7 ncq dma 1048576 ou
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/00:40:00:e0:f6/08:00:0c:00:00/40 tag 8 ncq dma 1048576 ou
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/00:48:00:e8:f6/08:00:0c:00:00/40 tag 9 ncq dma 1048576 ou
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/00:50:00:f0:f6/08:00:0c:00:00/40 tag 10 ncq dma 1048576 ou
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/00:58:00:f8:f6/08:00:0c:00:00/40 tag 11 ncq dma 1048576 ou
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/00:60:00:00:f7/08:00:0c:00:00/40 tag 12 ncq dma 1048576 ou
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/10:68:d0:df:2c/00:00:0b:00:00/40 tag 13 ncq dma 8192 out
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/20:70:60:bf:2e/00:00:0b:00:00/40 tag 14 ncq dma 16384 out
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/e0:78:80:be:32/04:00:0b:00:00/40 tag 15 ncq dma 638976 out
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/e0:88:a8:95:32/03:00:0b:00:00/40 tag 17 ncq dma 507904 out
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/e8:90:88:99:32/03:00:0b:00:00/40 tag 18 ncq dma 512000 out
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/00:98:70:9d:32/04:00:0b:00:00/40 tag 19 ncq dma 524288 out
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/e8:a0:70:a1:32/03:00:0b:00:00/40 tag 20 ncq dma 512000 out
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/48:a8:58:a5:32/04:00:0b:00:00/40 tag 21 ncq dma 561152 out
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/18:b0:a0:a9:32/04:00:0b:00:00/40 tag 22 ncq dma 536576 out
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/00:b8:b8:ad:32/04:00:0b:00:00/40 tag 23 ncq dma 524288 out
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/10:c0:b8:b1:32/04:00:0b:00:00/40 tag 24 ncq dma 532480 out
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/e8:c8:c8:b5:32/04:00:0b:00:00/40 tag 25 ncq dma 643072 out
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/d0:d0:b0:ba:32/03:00:0b:00:00/40 tag 26 ncq dma 499712 out
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/c0:d8:00:88:f6/07:00:0c:00:00/40 tag 27 ncq dma 1015808 ou
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/40:e0:c0:8f:f6/00:00:0c:00:00/40 tag 28 ncq dma 32768 out
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/60:e8:00:90:f6/07:00:0c:00:00/40 tag 29 ncq dma 966656 out
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov 21 10:28:03 harley kernel: ata1.00: cmd 61/a0:f0:60:97:f6/08:00:0c:00:00/40 tag 30 ncq dma 1130496 ou
         res 40/00:30:00:d0:f6/00:00:0c:00:00/40 Emask 0x10 (ATA bus error)
Nov 21 10:28:03 harley kernel: ata1.00: status: { DRDY }
Nov 21 10:28:03 harley kernel: ata1: hard resetting link
Nov 21 10:28:03 harley kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Nov 21 10:28:03 harley kernel: ata1.00: configured for UDMA/133
Nov 21 10:28:03 harley kernel: ata1: EH complete

Regards
Mark
