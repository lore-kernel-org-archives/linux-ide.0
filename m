From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: WIN_READ_NATIVE_MAX_EXT returns incomplete result
Date: Tue, 16 Nov 2004 17:34:44 +0000
Message-ID: <20041116173444.GA27676@palantir8>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mra03.ex.eclipse.net.uk ([212.104.129.88]:25525 "EHLO
	mra03.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S262052AbUKPReq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Nov 2004 12:34:46 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mra03.ex.eclipse.net.uk (Postfix) with ESMTP id C208C2E309F
	for <linux-ide@vger.kernel.org>; Tue, 16 Nov 2004 17:34:42 +0000 (GMT)
Received: from mra03.ex.eclipse.net.uk ([127.0.0.1])
 by localhost (mra03.ex.eclipse.net.uk [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 23308-01-63 for <linux-ide@vger.kernel.org>;
 Tue, 16 Nov 2004 17:34:42 +0000 (GMT)
Received: from palantir8.mph.eclipse.net (unknown [81.168.73.77])
	by mra03.ex.eclipse.net.uk (Postfix) with ESMTP id D707C2E30BE
	for <linux-ide@vger.kernel.org>; Tue, 16 Nov 2004 17:34:41 +0000 (GMT)
Received: from mhabets by palantir8.mph.eclipse.net with local (Exim 3.36 #1 (Debian))
	id 1CU7E4-0000U4-00
	for <linux-ide@vger.kernel.org>; Tue, 16 Nov 2004 17:34:44 +0000
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I've been trying to get "Host Protected Area" to work with my 80GB
Samsung SP0802N, as I have an old BIOS.
The max LBA capacity is 156368016 sectors (0x951FC90), but I've set
that to 66055248 with the setmax utility. Without this, or a 32GB clip,
I never get past the BIOS.

Initially idedisk_check_hpa() failed to detect the difference. It
turned out that idedisk_read_native_max_address_ext() returns
0x51FC90, i.e. the first '9' is missing!

When I use idedisk_read_native_max_address() it returns the right
number.
But I'm at a loss why the _ext() version does not work.

I'm on kernel 2.6.8 and in my BIOS I have 16383/16/63 for the disk.
My IDE controller:
0000:00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev 20)

Attached are parts of dmesg output, which includes some printk's I
put in. The "hob ..." lines come from this code in
idedisk_read_native_max_address_ext():
		printk(KERN_INFO "%s: max_address_ext: high=0x%x low=0x%x\n",
				        drive->name, high, low);
		for(i=0;i<IDE_NR_PORTS;i++) {
			printk(KERN_INFO "hob %d: 0x%x, tf %d: 0x%x\n",
				         i, args.hobRegister[i],
					 i, args.tfRegister[i]);
	 	}

The 2nd attachment is dmesg output with a hack to use the non-lba48 code,
which works ok.

Any clues?

Thanks,
-- 
Martin
---------------------------------------------------------------------------
30 years from now GNU/Linux will be as redundant a term as UNIX/MERT is 
today. - Martin Habets
---------------------------------------------------------------------------

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=msg

Nov 16 15:57:28 palantir8 kernel: Linux version 2.6.8 (opendev@palantir8) (gcc version 3.3.4 (Debian 1:3.3.4-13)) #8 Tue Nov 16 15:46:38 GMT 2004
...
Nov 16 15:57:28 palantir8 kernel: Kernel command line: BOOT_IMAGE=lin68 ro root=305 pci=usepirqmask hda=stroke
Nov 16 15:57:28 palantir8 kernel: ide_setup: hda=stroke
...
Nov 16 15:57:28 palantir8 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Nov 16 15:57:28 palantir8 kernel: ALI15X3: IDE controller at PCI slot 0000:00:0f.0
Nov 16 15:57:28 palantir8 kernel: PCI: Assigned IRQ 5 for device 0000:00:0f.0
Nov 16 15:57:28 palantir8 kernel: ALI15X3: chipset revision 32
Nov 16 15:57:28 palantir8 kernel: ALI15X3: not 100%% native mode: will probe irqs later
Nov 16 15:57:28 palantir8 kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
Nov 16 15:57:28 palantir8 kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
Nov 16 15:57:28 palantir8 kernel: hda: SAMSUNG SP0802N, ATA DISK drive
Nov 16 15:57:28 palantir8 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov 16 15:57:28 palantir8 kernel: hdc: EPO CD-ROM CR-836S, ATAPI CD/DVD-ROM drive
Nov 16 15:57:28 palantir8 kernel: hdd: Maxtor 90845D4, ATA DISK drive
Nov 16 15:57:28 palantir8 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov 16 15:57:28 palantir8 kernel: hda: max request size: 128KiB
Nov 16 15:57:28 palantir8 kernel: SAMSUNG SP0802N: hpa=1, cmd_set_1=0x346b, cfs_en_1=0x3c69
Nov 16 15:57:28 palantir8 kernel: hda capacity: lba=66055248, lba_2=66055248, lba48=1.
Nov 16 15:57:28 palantir8 kernel: hda: max_address_ext: high=0 low=51fc8f
Nov 16 15:57:28 palantir8 kernel: hob 0: 0, tf 0: 0
Nov 16 15:57:28 palantir8 kernel: hob 1: 0, tf 1: 0
Nov 16 15:57:28 palantir8 kernel: hob 2: 0, tf 2: 0
Nov 16 15:57:28 palantir8 kernel: hob 3: 0, tf 3: 8f
Nov 16 15:57:28 palantir8 kernel: hob 4: 0, tf 4: fc
Nov 16 15:57:28 palantir8 kernel: hob 5: 0, tf 5: 51
Nov 16 15:57:28 palantir8 kernel: hob 6: 0, tf 6: e0
Nov 16 15:57:28 palantir8 kernel: hob 7: 0, tf 7: 50
Nov 16 15:57:28 palantir8 kernel: hob 8: 0, tf 8: 0
Nov 16 15:57:28 palantir8 kernel: hob 9: 0, tf 9: 0
Nov 16 15:57:28 palantir8 kernel: hda check_hpa: max 5373072 vs. capacity 66055248.
Nov 16 15:57:28 palantir8 kernel: hda: 66055248 sectors (33820 MB) w/2048KiB Cache, CHS=16383/255/63, (U)DMA
Nov 16 15:57:28 palantir8 kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=msg2

hda: max request size: 128KiB
SAMSUNG SP0802N: hpa=1, cmd_set_1=0x346b, cfs_en_1=0x3c69
hda capacity: lba=66055248, lba_2=66055248, lba48=1.
hda check_hpa: max 156368016 vs. capacity 66055248.
hda: Host Protected Area detected.
        current capacity is 66055248 sectors (33820 MB)
        native  capacity is 156368016 sectors (80060 MB)
hda: Host Protected Area disabled.
hda: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=16383/255/63, (U)DMA
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 hda14 >


--OgqxwSJOaUobr8KG--
