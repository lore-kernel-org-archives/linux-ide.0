From: Marc Bevand <mb@opensc.org>
Subject: Re: [sata_sil24] v0.10 works, v0.20 doesn't
Date: Sun, 11 Sep 2005 07:00:21 +0200
Message-ID: <20050911050021.GA619@wc.epita.fr>
References: <431BC732.2010907@gmail.com> <20050905134311.GA15419@est.epita.fr> <20050905230234.GA543@htj.dyndns.org> <20050905231753.GA1003@htj.dyndns.org> <20050906011254.GA23144@est.epita.fr> <20050906015428.GA13521@htj.dyndns.org> <20050906093659.GB14270@est.epita.fr> <20050907013917.GA2803@htj.dyndns.org> <20050907093712.GA20006@est.epita.fr> <20050910135350.GA20877@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from deliver.epitech.net ([163.5.255.125]:48394 "HELO
	deliver.epitech.net") by vger.kernel.org with SMTP id S932414AbVIKFAg
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 11 Sep 2005 01:00:36 -0400
Content-Disposition: inline
In-Reply-To: <20050910135350.GA20877@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello Tejun.

Tejun Heo wrote:
| 
|  I compared original and new sil24 and here are things that are done
| differently upto the point where identify command is issued.
| 
|  a. Stuff done inside sil_init_pm() in the original driver is not done
|     in the new driver.  This includes clearing PM_EN and RESUME bits
|     in the ctrl/stat register and DVR_RST'ing the port.
| [...]
|  Here's a patch for #a.
|  This patch is on top of previous test patch which backported
| sil24_new.  Please try this one out and let me know the result.

Yes ! With this patch, my disk is recognized. Congratulations :-)
See below for the dmesg. Let me know if you want me to try anything
else. I would be happy to help you.

sata_sil24 version 0.20
ACPI: PCI Interrupt 0000:01:06.0[A] -> GSI 29 (level, low) -> IRQ 193
ata5: SATA max UDMA/100 cmd 0xFFFFC20000490000 ctl 0x0 bmdma 0x0 irq 193
ata6: SATA max UDMA/100 cmd 0xFFFFC20000492000 ctl 0x0 bmdma 0x0 irq 193
ata7: SATA max UDMA/100 cmd 0xFFFFC20000494000 ctl 0x0 bmdma 0x0 irq 193
ata8: SATA max UDMA/100 cmd 0xFFFFC20000496000 ctl 0x0 bmdma 0x0 irq 193
[ata_dev_identify     ]: issuing 0xec, dev->id is at ffff810037183510
[sil24_fill_sg        ]: filling 1 elements
[sil24_fill_sg        ]: 0000000037183510 512 80000000
[sil24_qc_issue       ]: issuing command 0xec
[ata_dev_identify     ]: Command successfully completed, sleeping 50ms
[ata_dev_identify     ]: Dumping ID
[ata_dev_identify     ]: [000] 0c5a 3fff c837 0010  0000 0000 003f 0000
[ata_dev_identify     ]: [008] 0000 0000 334a 5333  3030 5345 2020 2020
[ata_dev_identify     ]: [016] 2020 2020 2020 2020  0000 4000 0004 332e
[ata_dev_identify     ]: [024] 3138 2020 2020 5354  3331 3630 3032 3341
[ata_dev_identify     ]: [032] 5320 2020 2020 2020  2020 2020 2020 2020
[ata_dev_identify     ]: [040] 2020 2020 2020 2020  2020 2020 2020 8010
[ata_dev_identify     ]: [048] 0000 2f00 0000 0200  0200 0007 3fff 0010
[ata_dev_identify     ]: [056] 003f fc10 00fb 0110  ffff 0fff 0000 0407
[ata_dev_identify     ]: [064] 0003 0078 0078 00f0  0078 0000 0000 0000
[ata_dev_identify     ]: [072] 0000 0000 0000 0000  0002 0000 0000 0000
[ata_dev_identify     ]: [080] 007e 001b 346b 7d01  4003 3469 3c01 4003
[ata_dev_identify     ]: [088] 007f 0000 0000 fefe  0000 0000 fe00 0000
[ata_dev_identify     ]: [096] 0000 0000 0000 0000  9eb0 12a1 0000 0000
[ata_dev_identify     ]: [104] 0000 0000 0000 0000  0000 0000 0000 0000
[ata_dev_identify     ]: [112] 0000 0000 0000 0000  0000 0000 0000 0000
[ata_dev_identify     ]: [120] 0000 0000 0000 0000  0000 0000 0000 0000
[ata_dev_identify     ]: [128] 0001 9eb0 12a1 9eb0  12a1 2020 0002 42b6
[ata_dev_identify     ]: [136] 8000 008a 3c06 3c0a  ffff 07c6 0100 0800
[ata_dev_identify     ]: [144] 0ff0 1000 0002 0030  0000 0000 0000 fe06
[ata_dev_identify     ]: [152] 0000 0002 0050 008a  954f 0000 0023 000b
[ata_dev_identify     ]: [160] 0000 0000 0000 0000  0000 0000 0000 0000
[ata_dev_identify     ]: [168] 0000 0000 0000 0000  0000 0000 0000 0000
[ata_dev_identify     ]: [176] 0000 0000 0000 0000  0000 0000 0000 0000
[ata_dev_identify     ]: [184] 0000 0000 0000 0000  0000 0000 0000 0000
[ata_dev_identify     ]: [192] 0000 0000 0000 0000  0000 0000 0000 0000
[ata_dev_identify     ]: [200] 0000 0000 0000 0000  0000 0000 0000 0000
[ata_dev_identify     ]: [208] 0000 0000 0000 0000  0000 0000 0000 0000
[ata_dev_identify     ]: [216] 0000 0000 0000 0000  0000 0000 0000 0000
[ata_dev_identify     ]: [224] 0000 0000 0000 0000  0000 0000 0000 0000
[ata_dev_identify     ]: [232] 0000 0000 0000 0000  0000 0000 0000 0000
[ata_dev_identify     ]: [240] 0000 0000 0000 0000  0000 0000 0000 0000
[ata_dev_identify     ]: [248] 0000 0000 0000 0000  0000 0000 0000 dda5
ata5: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:007f
ata5: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
[sil24_qc_issue       ]: issuing command 0xef
ata5: dev 0 configured for UDMA/100
scsi4 : sata_sil24
ata6: no device found (phy stat 00000000)
scsi5 : sata_sil24
ata7: no device found (phy stat 00000000)
scsi6 : sata_sil24
ata8: no device found (phy stat 00000000)
scsi7 : sata_sil24
  Vendor: ATA       Model: ST3160023AS       Rev: 3.18
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdc: drive cache: write back
 sdc:<3>[sil24_fill_sg        ]: filling 1 elements
[sil24_fill_sg        ]: 0000000034fd0000 4096 80000000
[sil24_qc_issue       ]: issuing command 0x25
 sdc1
Attached scsi disk sdc at scsi4, channel 0, id 0, lun 0
Attached scsi generic sg2 at scsi4, channel 0, id 0, lun 0,  type 0
[sil24_fill_sg        ]: filling 1 elements
[sil24_fill_sg        ]: 0000000034fd1000 4096 80000000
[sil24_qc_issue       ]: issuing command 0x25
[sil24_fill_sg        ]: filling 1 elements
[sil24_fill_sg        ]: 0000000036c78000 4096 80000000
[sil24_qc_issue       ]: issuing command 0x25
[sil24_fill_sg        ]: filling 1 elements
[sil24_fill_sg        ]: 0000000036c79000 4096 80000000
[sil24_qc_issue       ]: issuing command 0x25
[sil24_fill_sg        ]: filling 1 elements
[sil24_fill_sg        ]: 000000003d3b4000 4096 80000000
[sil24_qc_issue       ]: issuing command 0x25
[sil24_fill_sg        ]: filling 1 elements
[sil24_fill_sg        ]: 00000000334d8000 4096 80000000
[sil24_qc_issue       ]: issuing command 0x25
[sil24_fill_sg        ]: filling 5 elements
[sil24_fill_sg        ]: 0000000038fee000 4096 0
[sil24_fill_sg        ]: 000000003718e000 4096 0
[sil24_fill_sg        ]: 000000003305f000 4096 0
[sil24_fill_sg        ]: 000000003c80e000 4096 0
[sil24_fill_sg        ]: 000000003b189000 4096 80000000
[sil24_qc_issue       ]: issuing command 0x25
[sil24_fill_sg        ]: filling 1 elements
[sil24_fill_sg        ]: 000000003a52c000 4096 80000000
[sil24_qc_issue       ]: issuing command 0x25
[sil24_fill_sg        ]: filling 1 elements
[sil24_fill_sg        ]: 00000000335ab000 4096 80000000
[sil24_qc_issue       ]: issuing command 0x25
[sil24_fill_sg        ]: filling 4 elements
[sil24_fill_sg        ]: 0000000037775000 1024 0
[sil24_fill_sg        ]: 0000000037775400 1024 0
[sil24_fill_sg        ]: 0000000037775800 1024 0
[sil24_fill_sg        ]: 0000000037775c00 1024 80000000
[sil24_qc_issue       ]: issuing command 0x25
[sil24_fill_sg        ]: filling 4 elements
[sil24_fill_sg        ]: 000000003f42e000 1024 0
[sil24_fill_sg        ]: 000000003f42e400 1024 0
[sil24_fill_sg        ]: 000000003f42e800 1024 0
[sil24_fill_sg        ]: 000000003f42ec00 1024 80000000
[sil24_qc_issue       ]: issuing command 0x25
[sil24_fill_sg        ]: filling 32 elements
[sil24_fill_sg        ]: 0000000039f89000 1024 0
[sil24_fill_sg        ]: 0000000039f89400 1024 0
[sil24_fill_sg        ]: 0000000039f89800 1024 0
[sil24_fill_sg        ]: 0000000039f89c00 1024 0
[sil24_fill_sg        ]: 0000000033a20000 1024 0
[sil24_fill_sg        ]: 0000000033a20400 1024 0
[sil24_fill_sg        ]: 0000000033a20800 1024 0
[sil24_fill_sg        ]: 0000000033a20c00 1024 0
[sil24_fill_sg        ]: 0000000033952000 1024 0
[sil24_fill_sg        ]: 0000000033952400 1024 0
[sil24_fill_sg        ]: 0000000033952800 1024 0
[sil24_fill_sg        ]: 0000000033952c00 1024 0
[sil24_fill_sg        ]: 000000003937f000 1024 0
[sil24_fill_sg        ]: 000000003937f400 1024 0
[sil24_fill_sg        ]: 000000003937f800 1024 0
[sil24_fill_sg        ]: 000000003937fc00 1024 0
[sil24_fill_sg        ]: 000000003301b000 1024 0
[sil24_fill_sg        ]: 000000003301b400 1024 0
[sil24_fill_sg        ]: 000000003301b800 1024 0
[sil24_fill_sg        ]: 000000003301bc00 1024 0
[sil24_fill_sg        ]: 000000003c17d000 1024 0
[sil24_fill_sg        ]: 000000003c17d400 1024 0
[sil24_fill_sg        ]: 000000003c17d800 1024 0
[sil24_fill_sg        ]: 000000003c17dc00 1024 0
[sil24_fill_sg        ]: 00000000373d5000 1024 0
[sil24_fill_sg        ]: 00000000373d5400 1024 0
[sil24_fill_sg        ]: 00000000373d5800 1024 0
[sil24_fill_sg        ]: 00000000373d5c00 1024 0
[sil24_fill_sg        ]: 0000000033b1e000 1024 0
[sil24_fill_sg        ]: 0000000033b1e400 1024 0
[sil24_fill_sg        ]: 0000000033b1e800 1024 0
[sil24_fill_sg        ]: 0000000033b1ec00 1024 80000000
[sil24_qc_issue       ]: issuing command 0x25
[sil24_fill_sg        ]: filling 4 elements
[sil24_fill_sg        ]: 00000000388b2000 1024 0
[sil24_fill_sg        ]: 00000000388b2400 1024 0
[sil24_fill_sg        ]: 00000000388b2800 1024 0
[sil24_fill_sg        ]: 00000000388b2c00 1024 80000000
[sil24_qc_issue       ]: issuing command 0x25
[sil24_fill_sg        ]: filling 4 elements
[sil24_fill_sg        ]: 0000000033b0d000 1024 0
[sil24_fill_sg        ]: 0000000033b0d400 1024 0
[sil24_fill_sg        ]: 0000000033b0d800 1024 0
[sil24_fill_sg        ]: 0000000033b0dc00 1024 80000000
[sil24_qc_issue       ]: issuing command 0x25
[sil24_fill_sg        ]: filling 32 elements
[sil24_fill_sg        ]: 000000003e0b8000 1024 0
[sil24_fill_sg        ]: 000000003e0b8400 1024 0
[sil24_fill_sg        ]: 000000003e0b8800 1024 0
[sil24_fill_sg        ]: 000000003e0b8c00 1024 0
[sil24_fill_sg        ]: 000000003d4d1000 1024 0
[sil24_fill_sg        ]: 000000003d4d1400 1024 0
[sil24_fill_sg        ]: 000000003d4d1800 1024 0
[sil24_fill_sg        ]: 000000003d4d1c00 1024 0
[sil24_fill_sg        ]: 0000000034fce000 1024 0
[sil24_fill_sg        ]: 0000000034fce400 1024 0
[sil24_fill_sg        ]: 0000000034fce800 1024 0
[sil24_fill_sg        ]: 0000000034fcec00 1024 0
[sil24_fill_sg        ]: 000000003caeb000 1024 0
[sil24_fill_sg        ]: 000000003caeb400 1024 0
[sil24_fill_sg        ]: 000000003caeb800 1024 0
[sil24_fill_sg        ]: 000000003caebc00 1024 0
[sil24_fill_sg        ]: 0000000038132000 1024 0
[sil24_fill_sg        ]: 0000000038132400 1024 0
[sil24_fill_sg        ]: 0000000038132800 1024 0
[sil24_fill_sg        ]: 0000000038132c00 1024 0
[sil24_fill_sg        ]: 0000000039b41000 1024 0
[sil24_fill_sg        ]: 0000000039b41400 1024 0
[sil24_fill_sg        ]: 0000000039b41800 1024 0
[sil24_fill_sg        ]: 0000000039b41c00 1024 0
[sil24_fill_sg        ]: 00000000371be000 1024 0
[sil24_fill_sg        ]: 00000000371be400 1024 0
[sil24_fill_sg        ]: 00000000371be800 1024 0
[sil24_fill_sg        ]: 00000000371bec00 1024 0
[sil24_fill_sg        ]: 0000000037623000 1024 0
[sil24_fill_sg        ]: 0000000037623400 1024 0
[sil24_fill_sg        ]: 0000000037623800 1024 0
[sil24_fill_sg        ]: 0000000037623c00 1024 80000000
[sil24_qc_issue       ]: issuing command 0x25
[sil24_fill_sg        ]: filling 32 elements
[sil24_fill_sg        ]: 000000003a7d7000 1024 0
[sil24_fill_sg        ]: 000000003a7d7400 1024 0
[sil24_fill_sg        ]: 000000003a7d7800 1024 0
[sil24_fill_sg        ]: 000000003a7d7c00 1024 0
[sil24_fill_sg        ]: 0000000038964000 1024 0
[sil24_fill_sg        ]: 0000000038964400 1024 0
[sil24_fill_sg        ]: 0000000038964800 1024 0
[sil24_fill_sg        ]: 0000000038964c00 1024 0
[sil24_fill_sg        ]: 0000000038914000 1024 0
[sil24_fill_sg        ]: 0000000038914400 1024 0
[sil24_fill_sg        ]: 0000000038914800 1024 0
[sil24_fill_sg        ]: 0000000038914c00 1024 0
[sil24_fill_sg        ]: 00000000334fe000 1024 0
[sil24_fill_sg        ]: 00000000334fe400 1024 0
[sil24_fill_sg        ]: 00000000334fe800 1024 0
[sil24_fill_sg        ]: 00000000334fec00 1024 0
[sil24_fill_sg        ]: 00000000334ff000 1024 0
[sil24_fill_sg        ]: 00000000334ff400 1024 0
[sil24_fill_sg        ]: 00000000334ff800 1024 0
[sil24_fill_sg        ]: 00000000334ffc00 1024 0
[sil24_fill_sg        ]: 00000000368c0000 1024 0
[sil24_fill_sg        ]: 00000000368c0400 1024 0
[sil24_fill_sg        ]: 00000000368c0800 1024 0
[sil24_fill_sg        ]: 00000000368c0c00 1024 0
[sil24_fill_sg        ]: 00000000368c1000 1024 0
[sil24_fill_sg        ]: 00000000368c1400 1024 0
[sil24_fill_sg        ]: 00000000368c1800 1024 0
[sil24_fill_sg        ]: 00000000368c1c00 1024 0
[sil24_fill_sg        ]: 0000000034f54000 1024 0
[sil24_fill_sg        ]: 0000000034f54400 1024 0
[sil24_fill_sg        ]: 0000000034f54800 1024 0
[sil24_fill_sg        ]: 0000000034f54c00 1024 80000000
[sil24_qc_issue       ]: issuing command 0x25
[sil24_fill_sg        ]: filling 8 elements
[sil24_fill_sg        ]: 000000003b274000 4096 0
[sil24_fill_sg        ]: 000000003989e000 4096 0
[sil24_fill_sg        ]: 00000000382a8000 4096 0
[sil24_fill_sg        ]: 0000000039a5a000 4096 0
[sil24_fill_sg        ]: 000000003a7bc000 4096 0
[sil24_fill_sg        ]: 000000003a797000 4096 0
[sil24_fill_sg        ]: 000000003b236000 4096 0
[sil24_fill_sg        ]: 000000003a159000 4096 80000000
[sil24_qc_issue       ]: issuing command 0x25
[sil24_fill_sg        ]: filling 8 elements
[sil24_fill_sg        ]: 000000003b236000 4096 0
[sil24_fill_sg        ]: 0000000033878000 4096 0
[sil24_fill_sg        ]: 000000003859f000 4096 0
[sil24_fill_sg        ]: 00000000330e4000 4096 0
[sil24_fill_sg        ]: 000000003f1ce000 4096 0
[sil24_fill_sg        ]: 000000003579e000 4096 0
[sil24_fill_sg        ]: 0000000039ccc000 4096 0
[sil24_fill_sg        ]: 0000000034fdb000 4096 80000000
[sil24_qc_issue       ]: issuing command 0x25
[sil24_fill_sg        ]: filling 4 elements
[sil24_fill_sg        ]: 0000000034f55000 1024 0
[sil24_fill_sg        ]: 0000000034f55400 1024 0
[sil24_fill_sg        ]: 0000000034f55800 1024 0
[sil24_fill_sg        ]: 0000000034f55c00 1024 80000000
[sil24_qc_issue       ]: issuing command 0x25
[sil24_fill_sg        ]: filling 4 elements
[sil24_fill_sg        ]: 000000003354a000 1024 0
[sil24_fill_sg        ]: 000000003354a400 1024 0
[sil24_fill_sg        ]: 000000003354a800 1024 0
[sil24_fill_sg        ]: 000000003354ac00 1024 80000000
[sil24_qc_issue       ]: issuing command 0x25
[sil24_fill_sg        ]: filling 32 elements
[sil24_fill_sg        ]: 000000003eacb000 1024 0
[sil24_fill_sg        ]: 000000003eacb400 1024 0
[sil24_fill_sg        ]: 000000003eacb800 1024 0
[sil24_fill_sg        ]: 000000003eacbc00 1024 0
[sil24_fill_sg        ]: 000000003c230000 1024 0
[sil24_fill_sg        ]: 000000003c230400 1024 0
[sil24_fill_sg        ]: 000000003c230800 1024 0
[sil24_fill_sg        ]: 000000003c230c00 1024 0
[sil24_fill_sg        ]: 00000000338fb000 1024 0
[sil24_fill_sg        ]: 00000000338fb400 1024 0
[sil24_fill_sg        ]: 00000000338fb800 1024 0
[sil24_fill_sg        ]: 00000000338fbc00 1024 0
[sil24_fill_sg        ]: 000000003688f000 1024 0
[sil24_fill_sg        ]: 000000003688f400 1024 0
[sil24_fill_sg        ]: 000000003688f800 1024 0
[sil24_fill_sg        ]: 000000003688fc00 1024 0
[sil24_fill_sg        ]: 00000000330e1000 1024 0
[sil24_fill_sg        ]: 00000000330e1400 1024 0
[sil24_fill_sg        ]: 00000000330e1800 1024 0
[sil24_fill_sg        ]: 00000000330e1c00 1024 0
[sil24_fill_sg        ]: 000000003b5d2000 1024 0
[sil24_fill_sg        ]: 000000003b5d2400 1024 0
[sil24_fill_sg        ]: 000000003b5d2800 1024 0
[sil24_fill_sg        ]: 000000003b5d2c00 1024 0
[sil24_fill_sg        ]: 00000000382a8000 1024 0
[sil24_fill_sg        ]: 00000000382a8400 1024 0
[sil24_fill_sg        ]: 00000000382a8800 1024 0
[sil24_fill_sg        ]: 00000000382a8c00 1024 0
[sil24_fill_sg        ]: 0000000039a5a000 1024 0
[sil24_fill_sg        ]: 0000000039a5a400 1024 0
[sil24_fill_sg        ]: 0000000039a5a800 1024 0
[sil24_fill_sg        ]: 0000000039a5ac00 1024 80000000
[sil24_qc_issue       ]: issuing command 0x25
[sil24_fill_sg        ]: filling 8 elements
[sil24_fill_sg        ]: 000000003b274000 4096 0
[sil24_fill_sg        ]: 000000003968c000 4096 0
[sil24_fill_sg        ]: 0000000038ea9000 4096 0
[sil24_fill_sg        ]: 000000003a7bc000 4096 0
[sil24_fill_sg        ]: 0000000038611000 4096 0
[sil24_fill_sg        ]: 00000000371d1000 4096 0
[sil24_fill_sg        ]: 0000000034fd2000 4096 0
[sil24_fill_sg        ]: 0000000038bb0000 4096 80000000
[sil24_qc_issue       ]: issuing command 0x25

-- 
 Marc Bevand                              http://epita.fr/~bevand_m
 Computer Science School EPITA - System, Network and Security Dept.
