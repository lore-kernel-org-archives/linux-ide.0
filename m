From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ATAPI tape drives broken with libata
Date: Thu, 30 Aug 2007 00:50:06 +0100
Message-ID: <20070830005006.6951265a@the-village.bc.nu>
References: <46D5F97B.3050808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57211 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756292AbXH2Xlw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Aug 2007 19:41:52 -0400
In-Reply-To: <46D5F97B.3050808@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, craig48@swbell.net

On Wed, 29 Aug 2007 18:55:55 -0400
Chuck Ebbert <cebbert@redhat.com> wrote:

> https://bugzilla.redhat.com/show_bug.cgi?id=243568
> 
> Using kernel 2.6.22:
> 
> Aug 29 17:08:11 itox kernel: ata2.00: ATAPI: Seagate STT8000A, 5.51, max MWDMA2
> Aug 29 17:08:11 itox kernel: ata2.00: configured for MWDMA2
> Aug 29 17:08:11 itox kernel: scsi 1:0:0:0: Sequential-Access Seagate  STT8000A         5.51 PQ: 0 ANSI: 2
> Aug 29 17:08:12 itox kernel: scsi 1:0:0:0: Attached scsi generic sg1 type 1
> Aug 29 17:08:12 itox kernel: st: Version 20070203, fixed bufsize 32768, s/g segs 256
> Aug 29 17:08:12 itox kernel: st 1:0:0:0: Attached scsi tape st0
> Aug 29 17:08:12 itox kernel: st 1:0:0:0: st0: try direct i/o: yes (alignment 512 B)
> Aug 29 17:08:12 itox kernel: ata2: DRQ=1 with device error, dev_stat 0x59
> Aug 29 17:08:12 itox kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> Aug 29 17:08:12 itox kernel: ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
> Aug 29 17:08:12 itox kernel:          res 51/60:03:00:00:20/00:00:00:00:00/a0 Emask 0x3 (HSM


Device Ready, Seek Complete, Data Request, Error

DRQ and Error together is a bit odd to say the least

It then commits suicide and falls off the bus. That may be due to the
fact we use SRST on ATAPI device errors still rather than trying an ATAPI
reset first. Shouldn't matter though.

Since you are the lucky owner of the object in question can you dump the
contents of the packet command going to the device when this occurs ?

Alan
