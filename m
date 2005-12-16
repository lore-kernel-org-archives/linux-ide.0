From: Sebastian Kuzminsky <seb.kuzminsky@gmail.com>
Subject: sata_mv vs pci-x
Date: Fri, 16 Dec 2005 15:26:27 -0700
Message-ID: <7f55de720512161426l1608ed99nf57d9f231fcc10c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.203]:11749 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932542AbVLPW02 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Dec 2005 17:26:28 -0500
Received: by wproxy.gmail.com with SMTP id 57so684540wri
        for <linux-ide@vger.kernel.org>; Fri, 16 Dec 2005 14:26:27 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I've got a strange problem with a SATA card.  It works fine in one
system but not in another.  Both systems are running 2.6.15-rc5. 
lspci identifies the card as:

Marvell Technology Group Ltd. MV88SX6081 8-port SATA II PCI-X
Controller (rev 09)


The working system is a Dell PowerEdge 400SC, P4 SMT, 1 GB RAM, PCI
bus.  The driver correctly detects all the plugged-in disks and it's
fast and reliable.


The non-working system is a Dell PowerEdge 700, P4 SMT, 1 GB RAM,
PCI-X bus.  It has two 32 bit, 33 MHz PCI slots and three 64 bit, 66
MHz PCI-X slots.  The PCI-X bridge is identified by lspci as:

Intel Corporation 6300ESB 64-bit PCI-X Bridge (rev 02)


The Marvell is the only card in the system.  I get the same results in
both the PCI-X slots and the PCI slots.  The card is detected but it's
slow to detect the drives and I can't access the drives when it
finally finds them.  The errors are:

Dec 16 14:39:34 snappy kernel: ata5: dev 0 cfg 49:2f00 82:346b 83:7d01
84:4023 85:3469 86:3c01 87:4023 88:407f
Dec 16 14:39:34 snappy kernel: ata5: dev 0 ATA-7, max UDMA/133,
976773168 sectors: LBA48
Dec 16 14:39:48 snappy kernel: ata5: slow completion (cmd ef)
Dec 16 14:39:48 snappy kernel: ata5: dev 0 configured for UDMA/133
Dec 16 14:39:48 snappy kernel: scsi4 : sata_mv
Dec 16 14:39:49 snappy kernel: ata6: dev 0 cfg 49:2f00 82:346b 83:7d01
84:4023 85:3469 86:3c01 87:4023 88:407f
Dec 16 14:39:49 snappy kernel: ata6: dev 0 ATA-7, max UDMA/133,
976773168 sectors: LBA48
Dec 16 14:40:19 snappy kernel: ata6: slow completion (cmd ef)
Dec 16 14:40:19 snappy kernel: ata6: dev 0 configured for UDMA/133
Dec 16 14:40:19 snappy kernel: scsi5 : sata_mv
Dec 16 14:40:19 snappy kernel: ata7: dev 0 cfg 49:2f00 82:346b 83:7d01
84:4023 85:3469 86:3c01 87:4023 88:407f
Dec 16 14:40:19 snappy kernel: ata7: dev 0 ATA-7, max UDMA/133,
976773168 sectors: LBA48
Dec 16 14:40:49 snappy kernel: ata7: slow completion (cmd ef)
Dec 16 14:40:49 snappy kernel: ata7: dev 0 configured for UDMA/133
Dec 16 14:40:49 snappy kernel: scsi6 : sata_mv
Dec 16 14:40:50 snappy kernel: ata8: dev 0 cfg 49:2f00 82:346b 83:7d01
84:4023 85:3469 86:3c01 87:4023 88:407f
Dec 16 14:40:50 snappy kernel: ata8: dev 0 ATA-7, max UDMA/133,
976773168 sectors: LBA48
Dec 16 14:41:20 snappy kernel: ata8: slow completion (cmd ef)
Dec 16 14:41:20 snappy kernel: ata8: dev 0 configured for UDMA/133
Dec 16 14:41:20 snappy kernel: scsi7 : sata_mv
Dec 16 14:41:20 snappy kernel:   Vendor: ATA       Model: ST3500641AS 
     Rev: 2.AA
Dec 16 14:41:20 snappy kernel:   Type:   Direct-Access                
     ANSI SCSI revision: 05
Dec 16 14:41:20 snappy kernel:   Vendor: ATA       Model: ST3500641AS 
     Rev: 2.AA
Dec 16 14:41:20 snappy kernel:   Type:   Direct-Access                
     ANSI SCSI revision: 05
Dec 16 14:41:20 snappy kernel:   Vendor: ATA       Model: ST3500641AS 
     Rev: 2.AA
Dec 16 14:41:20 snappy kernel:   Type:   Direct-Access                
     ANSI SCSI revision: 05
Dec 16 14:41:20 snappy kernel:   Vendor: ATA       Model: ST3500641AS 
     Rev: 2.AA
Dec 16 14:41:20 snappy kernel:   Type:   Direct-Access                
     ANSI SCSI revision: 05
Dec 16 14:41:20 snappy kernel: SCSI device sda: 976773168 512-byte
hdwr sectors (500108 MB)
Dec 16 14:41:20 snappy kernel: SCSI device sda: drive cache: write back
Dec 16 14:41:20 snappy kernel: SCSI device sda: 976773168 512-byte
hdwr sectors (500108 MB)
Dec 16 14:41:20 snappy kernel: SCSI device sda: drive cache: write back
Dec 16 14:41:50 snappy kernel:  sda:<3>ata5: Entering mv_eng_timeout
Dec 16 14:41:50 snappy kernel: mmio_base f8d00000 ap f72472a8 qc
f724777c scsi_cmnd f6c61080 &cmnd f6c610c4
Dec 16 14:41:51 snappy kernel: ata5: status=0x50 { DriveReady SeekComplete }
Dec 16 14:41:51 snappy kernel: ata5: error=0x01 { AddrMarkNotFound }
Dec 16 14:41:51 snappy kernel: sda: Current: sense key: No Sense
Dec 16 14:41:51 snappy kernel:     Additional sense: No additional
sense information
Dec 16 14:41:51 snappy kernel:  unknown partition table
Dec 16 14:41:51 snappy kernel: sd 4:0:0:0: Attached scsi disk sda
Dec 16 14:41:51 snappy kernel: SCSI device sdb: 976773168 512-byte
hdwr sectors (500108 MB)
Dec 16 14:41:51 snappy kernel: SCSI device sdb: drive cache: write back
Dec 16 14:41:51 snappy kernel: SCSI device sdb: 976773168 512-byte
hdwr sectors (500108 MB)
Dec 16 14:41:51 snappy kernel: SCSI device sdb: drive cache: write back
Dec 16 14:42:21 snappy kernel:  sdb:<3>ata6: Entering mv_eng_timeout
Dec 16 14:42:21 snappy kernel: mmio_base f8d00000 ap f71f52a8 qc
f71f577c scsi_cmnd f6c61c80 &cmnd f6c61cc4
Dec 16 14:42:21 snappy kernel: ata5: Entering mv_eng_timeout
Dec 16 14:42:21 snappy kernel: mmio_base f8d00000 ap f72472a8 qc
f724777c scsi_cmnd f6c61b00 &cmnd f6c61b44
Dec 16 14:42:21 snappy kernel: ata6: status=0x50 { DriveReady SeekComplete }
Dec 16 14:42:21 snappy kernel: ata6: error=0x01 { AddrMarkNotFound }
Dec 16 14:42:21 snappy kernel: sdb: Current: sense key: No Sense
Dec 16 14:42:21 snappy kernel:     Additional sense: No additional
sense information
Dec 16 14:42:21 snappy kernel:  unknown partition table
Dec 16 14:42:21 snappy kernel: sd 5:0:0:0: Attached scsi disk sdb
Dec 16 14:42:21 snappy kernel: SCSI device sdc: 976773168 512-byte
hdwr sectors (500108 MB)
Dec 16 14:42:21 snappy kernel: ata5: status=0x50 { DriveReady SeekComplete }
Dec 16 14:42:21 snappy kernel: ata5: error=0x01 { AddrMarkNotFound }
Dec 16 14:42:21 snappy kernel: sda: Current: sense key: No Sense
Dec 16 14:42:21 snappy kernel:     Additional sense: No additional
sense information
Dec 16 14:42:21 snappy kernel: SCSI device sdc: drive cache: write back
Dec 16 14:42:21 snappy kernel: SCSI device sdc: 976773168 512-byte
hdwr sectors (500108 MB)
Dec 16 14:42:21 snappy kernel: SCSI device sdc: drive cache: write back
Dec 16 14:42:51 snappy kernel:  sdc:<3>ata5: Entering mv_eng_timeout
Dec 16 14:42:51 snappy kernel: mmio_base f8d00000 ap f72472a8 qc
f724777c scsi_cmnd f6c61080 &cmnd f6c610c4
Dec 16 14:42:52 snappy kernel: ata7: Entering mv_eng_timeout
Dec 16 14:42:52 snappy kernel: mmio_base f8d00000 ap f71f42a8 qc
f71f477c scsi_cmnd f6c61c80 &cmnd f6c61cc4
Dec 16 14:42:52 snappy kernel: ata5: status=0x50 { DriveReady SeekComplete }
Dec 16 14:42:52 snappy kernel: ata5: error=0x01 { AddrMarkNotFound }
Dec 16 14:42:52 snappy kernel: sda: Current: sense key: No Sense
Dec 16 14:42:52 snappy kernel:     Additional sense: No additional
sense information
Dec 16 14:42:52 snappy kernel: ata6: Entering mv_eng_timeout
Dec 16 14:42:52 snappy kernel: mmio_base f8d00000 ap f71f52a8 qc
f71f577c scsi_cmnd f6c61b00 &cmnd f6c61b44
Dec 16 14:42:52 snappy kernel: ata7: status=0x50 { DriveReady SeekComplete }
Dec 16 14:42:52 snappy kernel: ata7: error=0x01 { AddrMarkNotFound }
Dec 16 14:42:52 snappy kernel: sdc: Current: sense key: No Sense
Dec 16 14:42:52 snappy kernel:     Additional sense: No additional
sense information
Dec 16 14:42:52 snappy kernel:  unknown partition table
Dec 16 14:42:52 snappy kernel: sd 6:0:0:0: Attached scsi disk sdc
Dec 16 14:42:52 snappy kernel: SCSI device sdd: 976773168 512-byte
hdwr sectors (500108 MB)
Dec 16 14:42:52 snappy kernel: SCSI device sdd: drive cache: write back
Dec 16 14:42:52 snappy kernel: SCSI device sdd: 976773168 512-byte
hdwr sectors (500108 MB)
Dec 16 14:42:52 snappy kernel: SCSI device sdd: drive cache: write back
Dec 16 14:42:53 snappy kernel:  sdd:<4>ata6: status=0x50 { DriveReady
SeekComplete }
Dec 16 14:42:53 snappy kernel: ata6: error=0x01 { AddrMarkNotFound }
Dec 16 14:42:53 snappy kernel: sdb: Current: sense key: No Sense
Dec 16 14:42:53 snappy kernel:     Additional sense: No additional
sense information
Dec 16 14:43:22 snappy kernel: ata5: Entering mv_eng_timeout
Dec 16 14:43:22 snappy kernel: mmio_base f8d00000 ap f72472a8 qc
f724777c scsi_cmnd f6c61800 &cmnd f6c61844
Dec 16 14:43:23 snappy kernel: ata8: Entering mv_eng_timeout
Dec 16 14:43:23 snappy kernel: mmio_base f8d00000 ap f71dd2a8 qc
f71dd77c scsi_cmnd f6c61980 &cmnd f6c619c4
Dec 16 14:43:23 snappy kernel: ata5: status=0x50 { DriveReady SeekComplete }
Dec 16 14:43:23 snappy kernel: ata5: error=0x01 { AddrMarkNotFound }
Dec 16 14:43:23 snappy kernel: sda: Current: sense key: No Sense
Dec 16 14:43:23 snappy kernel:     Additional sense: No additional
sense information
Dec 16 14:43:23 snappy kernel: ata6: Entering mv_eng_timeout
Dec 16 14:43:23 snappy kernel: ata8: status=0x50 { DriveReady SeekComplete }
Dec 16 14:43:23 snappy kernel: ata8: error=0x01 { AddrMarkNotFound }
Dec 16 14:43:23 snappy kernel: sdd: Current: sense key: No Sense
Dec 16 14:43:23 snappy kernel:     Additional sense: No additional
sense information
Dec 16 14:43:23 snappy kernel: ata7: Entering mv_eng_timeout
Dec 16 14:43:23 snappy kernel: mmio_base f8d00000 ap f71f42a8 qc
f71f477c scsi_cmnd f6c61680 &cmnd f6c616c4
Dec 16 14:43:23 snappy kernel: mmio_base f8d00000 ap f71f52a8 qc
f71f577c scsi_cmnd f6c61500 &cmnd f6c61544
Dec 16 14:43:23 snappy kernel: ata7: status=0x50 { DriveReady SeekComplete }
Dec 16 14:43:23 snappy kernel: ata7: error=0x01 { AddrMarkNotFound }
Dec 16 14:43:23 snappy kernel: sdc: Current: sense key: No Sense
Dec 16 14:43:23 snappy kernel:     Additional sense: No additional
sense information
Dec 16 14:43:23 snappy kernel:  unknown partition table
Dec 16 14:43:23 snappy kernel: sd 7:0:0:0: Attached scsi disk sdd
Dec 16 14:43:23 snappy kernel: ata6: status=0x50 { DriveReady SeekComplete }
Dec 16 14:43:23 snappy kernel: ata6: error=0x01 { AddrMarkNotFound }
Dec 16 14:43:23 snappy kernel: sdb: Current: sense key: No Sense
Dec 16 14:43:23 snappy kernel:     Additional sense: No additional
sense information
Dec 16 14:43:53 snappy kernel: ata7: Entering mv_eng_timeout
Dec 16 14:43:53 snappy kernel: mmio_base f8d00000 ap f71f42a8 qc
f71f477c scsi_cmnd f6c61680 &cmnd f6c616c4
Dec 16 14:43:55 snappy kernel: ata5: Entering mv_eng_timeout
Dec 16 14:43:55 snappy kernel: mmio_base f8d00000 ap f72472a8 qc
f724777c scsi_cmnd f6c61980 &cmnd f6c619c4
Dec 16 14:43:55 snappy kernel: ata7: status=0x50 { DriveReady SeekComplete }
Dec 16 14:43:55 snappy kernel: ata7: error=0x01 { AddrMarkNotFound }
Dec 16 14:43:55 snappy kernel: sdc: Current: sense key: No Sense
Dec 16 14:43:55 snappy kernel:     Additional sense: No additional
sense information
Dec 16 14:43:55 snappy kernel: ata6: Entering mv_eng_timeout
Dec 16 14:43:55 snappy kernel: ata5: status=0x50 { DriveReady SeekComplete }
Dec 16 14:43:55 snappy kernel: ata5: error=0x01 { AddrMarkNotFound }
Dec 16 14:43:55 snappy kernel: sda: Current: sense key: No Sense
Dec 16 14:43:55 snappy kernel:     Additional sense: No additional
sense information
Dec 16 14:43:55 snappy kernel: ata8: Entering mv_eng_timeout
Dec 16 14:43:55 snappy kernel: mmio_base f8d00000 ap f71dd2a8 qc
f71dd77c scsi_cmnd f6c61b00 &cmnd f6c61b44
Dec 16 14:43:55 snappy kernel: mmio_base f8d00000 ap f71f52a8 qc
f71f577c scsi_cmnd f6c61500 &cmnd f6c61544
Dec 16 14:43:55 snappy kernel: ata8: status=0x50 { DriveReady SeekComplete }
Dec 16 14:43:55 snappy kernel: ata8: error=0x01 { AddrMarkNotFound }
Dec 16 14:43:55 snappy kernel: sdd: Current: sense key: No Sense
Dec 16 14:43:55 snappy kernel:     Additional sense: No additional
sense information


And on and on...  Let me know what I can do to help debug this.  I'm
motivated to get this going on my PCI-X system but I dont know how to
help...


--
Sebastian Kuzminsky
