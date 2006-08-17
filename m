From: Vlad Codrea <VladCodrea@mail.utexas.edu>
Subject: Re: Libata in 2.6.18-rc4-mm1 doesn't recognize DVD-ROM drive
Date: Thu, 17 Aug 2006 12:54:46 -0500
Message-ID: <44E4AD66.1060605@mail.utexas.edu>
References: <44E3EC71.1080200@mail.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironman.mail.utexas.edu ([128.83.32.51]:21931 "EHLO
	ironman.mail.utexas.edu") by vger.kernel.org with ESMTP
	id S932422AbWHQQp5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Aug 2006 12:45:57 -0400
In-Reply-To: <44E3EC71.1080200@mail.utexas.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Vlad Codrea wrote:
>
> Libata in 2.6.18-rc4-mm1 doesn't recognize my DVD-ROM drive, which is 
> an ATAPI TORiSAN DVD-ROM DRD-N216.

If I add "TORiSAN DVD-ROM DRD-N216" to ata_dma_blacklist[] on line 2990 
of drivers/ata/libata-core.c, I am able to mount CDs. However, md5sum 
fails for some files on the CD, and eventually the drive freezes with 
the following message. The CD is definitely good since md5sum works on 
my other computer. If having ssh access to the affected computer would 
help someone solve this error, I'd be happy to arrange that.

kernel: ata2.00: 61440 bytes trailing data
kernel: ata2: soft resetting port
kernel: ata2: port is slow to respond, please be patient
kernel: ATA: abnormal status 0xD8 on port 0x177
last message repeated 3 times
kernel: ata2.00: qc timeout (cmd 0xa1)
kernel: ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
kernel: ata2: failed to recover some devices, retrying in 5 secs
kernel: ata2: port is slow to respond, please be patient
kernel: ata2: soft resetting port
kernel: ata2: port is slow to respond, please be patient
kernel: ATA: abnormal status 0xD8 on port 0x177
last message repeated 3 times
kernel: ata2.00: qc timeout (cmd 0xa1)
kernel: ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
kernel: ata2: failed to recover some devices, retrying in 5 secs
kernel: ata2: port is slow to respond, please be patient
kernel: ata2: soft resetting port
kernel: ata2: port is slow to respond, please be patient
kernel: ATA: abnormal status 0xD8 on port 0x177
last message repeated 3 times
kernel: ata2.00: qc timeout (cmd 0xa1)
kernel: ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
kernel: ata2.00: disabled
kernel: ata2: EH complete
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 1391424
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 1391560
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 1391816
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 1392072
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 1392328
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 1392584
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 1392840
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 1391424
kernel: Reducing readahead size to 256K
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 1395092
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 1395092
kernel: Reducing readahead size to 256K
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 1396096
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 1396096
kernel: Reducing readahead size to 256K
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 260
kernel: ISOFS: unable to read i-node block
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 264
kernel: ISOFS: unable to read i-node block
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 272
kernel: ISOFS: unable to read i-node block
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 280
kernel: ISOFS: unable to read i-node block
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 288
kernel: ISOFS: unable to read i-node block
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 312
kernel: ISOFS: unable to read i-node block
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 320
kernel: ISOFS: unable to read i-node block
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 328
kernel: ISOFS: unable to read i-node block
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 336
kernel: ISOFS: unable to read i-node block
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 344
kernel: ISOFS: unable to read i-node block
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 1040
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 1040
kernel: Reducing readahead size to 256K
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 348
kernel: ISOFS: unable to read i-node block
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 516
kernel: ISOFS: unable to read i-node block
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 1044
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 1044
kernel: Reducing readahead size to 256K
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 564
kernel: ISOFS: unable to read i-node block
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 1488
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 1488
kernel: Reducing readahead size to 256K
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 2204
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 2204
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 2280
kernel: sr 1:0:0:0: SCSI error: return code = 0x00040000
kernel: end_request: I/O error, dev sr0, sector 2280
