From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Sat, 17 Mar 2007 22:39:05 +0800
Message-ID: <45FBFD89.3080308@tw.ibm.com>
References: <45F873AC.6010204@gmail.com> <45FAB270.8090909@tw.ibm.com> <45FABCE0.30907@gmail.com> <200703171429.49646.bzolnier@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:41342 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965639AbXCQOjO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Mar 2007 10:39:14 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2HEdETV018201
	for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 10:39:14 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2HEdDGf033660
	for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 08:39:13 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2HEdDtv017776
	for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 08:39:13 -0600
In-Reply-To: <200703171429.49646.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: YUP <yupadmin@gmail.com>, albertl@mail.com, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> Any news about this test?  ide-cd driver is much more forgiving for
> quirky hardware than libata+sr so please give it a try...
> 

Hi Bart,
Yarema did the run test, but the AOpen drive was connected to the PIIX
controller, which is driven by libata:

[   30.523140] ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
[   30.523202] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
[   30.523232] scsi0 : ata_piix
[   30.523249] PM: Adding info for No Bus:host0
[   30.550217] usbcore: registered new interface driver usbfs
[   30.550257] usbcore: registered new interface driver hub
[   30.550298] usbcore: registered new device driver usb
[   30.552764] USB Universal Host Controller Interface driver v3.0
[   30.640707] Linux Tulip driver version 1.1.14 (May 11, 2002)
[   30.841828] ata1.00: ATAPI, max UDMA/33
[   30.863680] Floppy drive(s): fd0 is 1.44M
[   30.940952] FDC 0 is a post-1991 82077
[   30.958682] PM: Adding info for platform:floppy.0
[   31.005533] ata1.00: configured for UDMA/33
[   31.005560] scsi1 : ata_piix
[   31.005593] PM: Adding info for No Bus:host1
[   31.172448] ATA: abnormal status 0x7F on port 0x177
[   31.333039] ata2.01: ATAPI, max MWDMA2
[   31.496799] ata2.01: configured for MWDMA2
[   31.496863] PM: Adding info for No Bus:target0:0:0
[   31.499200] scsi 0:0:0:0: CD-ROM            HP       DVD Writer 200j  1.36 PQ: 0 ANSI: 5
[   31.499214] PM: Adding info for scsi:0:0:0:0
[   31.499783] PM: Adding info for No Bus:target1:0:1
[   31.500477] scsi 1:0:1:0: CD-ROM            E-IDE    CD-ROM 56X/AKH   A80  PQ: 0 ANSI: 5
[   31.500492] PM: Adding info for scsi:1:0:1:0
...
[   31.716631] PDC20269: IDE controller at PCI slot 0000:02:01.0
[   31.716668] PDC20269: chipset revision 2
[   31.716673] PDC20269: ROM enabled at 0x30020000
[   31.726626] PDC20269: PLL input clock is 16565 kHz
[   31.756376] PDC20269: 100% native mode on irq 21
[   31.756387]     ide2: BM-DMA at 0xb000-0xb007, BIOS settings: hde:pio, hdf:pio
[   31.757010]     ide3: BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:pio, hdh:pio
[   31.757027] Probing IDE interface ide2...
[   32.044020] hde: SAMSUNG SP1203N, ATA DISK drive
[   32.044077] PM: Adding info for No Bus:ide2
[   32.388718] PM: Removing info for No Bus:vcs8
[   32.388777] PM: Removing info for No Bus:vcsa8
[   32.555258] hdf: Maxtor 6Y160P0, ATA DISK drive
[   32.611416] ide2 at 0xa000-0xa007,0xa402 on irq 21
[   32.611464] PM: Adding info for ide:2.0
[   32.611842] PM: Adding info for ide:2.1
[   32.612050] Probing IDE interface ide3...
[   33.179031] tulip0:  MII transceiver #1 config 1000 status 786d advertising 05e1.
[   33.186241] eth0: ADMtek Comet rev 17 at Port 0xb400, 00:04:5A:8A:55:7B, IRQ 21.
[   33.197996] hde: max request size: 512KiB
[   33.207974] hde: 234493056 sectors (120060 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
[   33.208614] hde: cache flushes supported
[   33.208697]  hde: hde1 hde2 hde3 hde4 < hde5 hde6 hde7 >
[   33.248309] hdf: max request size: 512KiB
[   33.248888] hdf: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(133)
[   33.249048] hdf: cache flushes supported
[   33.249097]  hdf: hdf1 hdf2 hdf3 < hdf5 hdf6 >


Hi Yurema,

Could you please redo the IDE test:
1. Connect the AOpen drive to the Promise controller.
2. Configure the IDE pdc202xx_new driver and remove the libata pata_pdc2027x driver.
3. Boot the kernel with IDE pdc202xx_new driver to see if IDE works ok with the AOpen drive?

Thanks.
--
albert

