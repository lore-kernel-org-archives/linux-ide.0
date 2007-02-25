From: "Patrick Ale" <patrick.ale@gmail.com>
Subject: Re: Fwd: [LIBATA] drives not detected
Date: Sun, 25 Feb 2007 14:46:56 +0100
Message-ID: <8d158e1f0702250546lddf9748r3c210504f3e94304@mail.gmail.com>
References: <8d158e1f0702150048x4eb73acawc3c3b87d0d80a6d4@mail.gmail.com>
	 <200702241833.00199.bzolnier@gmail.com>
	 <8d158e1f0702240937p1a8b5706u951b4fa21f6e2f67@mail.gmail.com>
	 <200702241911.21030.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:15277 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964853AbXBYNrE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Feb 2007 08:47:04 -0500
Received: by wr-out-0506.google.com with SMTP id 37so244928wra
        for <linux-ide@vger.kernel.org>; Sun, 25 Feb 2007 05:47:02 -0800 (PST)
In-Reply-To: <200702241911.21030.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, albertl@mail.com, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <mlord@pobox.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On 2/24/07, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

Hoi and good afternoon :)

Okay so... this is my dmesg with the legacy IDE drivers loaded.
Please note that I still use libata for my boot drive but that the
current vs native capacity errors disapeared *sniff*, no petabytes
after all!


PDC20276: chipset revision 1
PDC20276: PLL input clock is 33542 kHz
PDC20276: 100% native mode on irq 19
    ide2: BM-DMA at 0xc800-0xc807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xc808-0xc80f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
8139too Fast Ethernet driver 0.9.28
Linux video capture interface: v2.00
hde: Maxtor 6Y160P0, ATA DISK drive
cx2388x v4l2 driver version 0.0.6 loaded
hdf: WDC WD1200JB-00DUA3, ATA DISK drive
ide2 at 0xb800-0xb807,0xbc02 on irq 19
Probing IDE interface ide3...
hdg: WDC WD1200JB-00EVA0, ATA DISK drive
hdh: ST3120022A, ATA DISK drive
ide3 at 0xc000-0xc007,0xc402 on irq 19
sata_sil 0000:00:08.0: version 2.0
ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 17 (level, low) -> IRQ 20
ata3: SATA max UDMA/100 cmd 0xF883A080 ctl 0xF883A08A bmdma 0xF883A000 irq 20
ata4: SATA max UDMA/100 cmd 0xF883A0C0 ctl 0xF883A0CA bmdma 0xF883A008 irq 20
scsi2 : sata_sil
hde: max request size: 512KiB
hde: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(133)
hde: cache flushes supported
 hde: hde1
hdf: max request size: 512KiB
hdf: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
hdf: cache flushes supported
 hdf: hdf1
hdg: max request size: 512KiB
hdg: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
hdg: cache flushes supported
 hdg: hdg1
hdh: max request size: 512KiB
hdh: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hdh: cache flushes supported
 hdh: hdh1



Patrick
