From: Chuck Ebbert <cebbert@redhat.com>
Subject: ATAPI tape drives broken with libata
Date: Wed, 29 Aug 2007 18:55:55 -0400
Message-ID: <46D5F97B.3050808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:48691 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756903AbXH2Wz7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Aug 2007 18:55:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: craig48@swbell.net

https://bugzilla.redhat.com/show_bug.cgi?id=243568

Using kernel 2.6.22:

Aug 29 17:08:11 itox kernel: ata2.00: ATAPI: Seagate STT8000A, 5.51, max MWDMA2
Aug 29 17:08:11 itox kernel: ata2.00: configured for MWDMA2
Aug 29 17:08:11 itox kernel: scsi 1:0:0:0: Sequential-Access Seagate  STT8000A         5.51 PQ: 0 ANSI: 2
Aug 29 17:08:12 itox kernel: scsi 1:0:0:0: Attached scsi generic sg1 type 1
Aug 29 17:08:12 itox kernel: st: Version 20070203, fixed bufsize 32768, s/g segs 256
Aug 29 17:08:12 itox kernel: st 1:0:0:0: Attached scsi tape st0
Aug 29 17:08:12 itox kernel: st 1:0:0:0: st0: try direct i/o: yes (alignment 512 B)
Aug 29 17:08:12 itox kernel: ata2: DRQ=1 with device error, dev_stat 0x59
Aug 29 17:08:12 itox kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Aug 29 17:08:12 itox kernel: ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
Aug 29 17:08:12 itox kernel:          res 51/60:03:00:00:20/00:00:00:00:00/a0 Emask 0x3 (HSM violation)
Aug 29 17:08:13 itox kernel: ata2: soft resetting port
Aug 29 17:08:13 itox kernel: ata2.00: revalidation failed (errno=-2)
Aug 29 17:08:13 itox kernel: ata2: failed to recover some devices, retrying in 5 secs
Aug 29 17:08:13 itox kernel: ata2: soft resetting port
Aug 29 17:08:13 itox kernel: ata2.00: revalidation failed (errno=-2)
Aug 29 17:08:13 itox kernel: ata2: failed to recover some devices, retrying in 5 secs
Aug 29 17:08:13 itox kernel: ata2: soft resetting port
Aug 29 17:08:13 itox kernel: ata2.00: revalidation failed (errno=-2)
Aug 29 17:08:13 itox kernel: ata2.00: disabled
Aug 29 17:08:13 itox kernel: ata2: EH complete

Opening the device returns -EIO and prints this kernel message:

Aug 29 17:20:29 itox kernel: st0: Error 40000 (sugg. bt 0x0, driver bt 0x0, host bt 0x4).


17:23:45.360014 open("/dev/nst0", O_RDONLY|O_NONBLOCK) = -1 EIO (Input/output error)



The old ide drivers with ide-scsi work.
