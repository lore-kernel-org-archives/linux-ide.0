From: Jeff Garzik <jeff@garzik.org>
Subject: Re: ATAPI tape drives broken with libata
Date: Thu, 30 Aug 2007 00:00:46 -0400
Message-ID: <46D640EE.9050307@garzik.org>
References: <46D5F97B.3050808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60966 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701AbXH3EA6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Aug 2007 00:00:58 -0400
In-Reply-To: <46D5F97B.3050808@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, craig48@swbell.net, Alan <alan@lxorguk.ukuu.org.uk>

Chuck Ebbert wrote:
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
> Aug 29 17:08:12 itox kernel:          res 51/60:03:00:00:20/00:00:00:00:00/a0 Emask 0x3 (HSM violation)

DRQ=1 is quite unusual, and would definitely trigger the problems 
further down (that I snipped)...

	Jeff


