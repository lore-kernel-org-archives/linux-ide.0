From: Brad Campbell <brad@wasp.net.au>
Subject: Re: sata media errors not propagated? (was Re: sata_via issue)
Date: Tue, 17 Aug 2004 20:40:47 +0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4122350F.3040700@wasp.net.au>
References: <1092741447.1581.33.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:24520 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S266376AbUHQQkS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Aug 2004 12:40:18 -0400
In-Reply-To: <1092741447.1581.33.camel@localhost>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Kevin Shanahan wrote:

I have done about 15 re-compiles now with increasing numbers of printk's added and have got this far.

scsi -> libata to ata_queued_cmd

> 
> Buffer I/O error on device sdb2, logical block 7281
> ata2: command 0x25 timeout, stat 0x59 host_stat 0x1
> scsi1: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 00 03 29 f0 00 00 ec 00 
> Current sdb: sense = 70  3
> ASC=11 ASCQ= 4
> Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 0x00 0x11 0x04 
> end_request: I/O error, dev sdb, sector 207344

Here the libata layer passes the error back to scsi and everyone is happy. (uses ata_scsi_qc_complete)

> 
> Then always ends with the following:

About here, scsi passes a command down to libata, ata_queued_cmd which causes the next 3 messages.
libata never errors out here and completes the request so it all falls in a heap.
I'm going out to dinner, I'll see if I can trace it further later tonight.

> ATA: abnormal status 0x59 on port 0xB807
> ATA: abnormal status 0x59 on port 0xB807
> ATA: abnormal status 0x59 on port 0xB807

Not much help, but closing in.

Regards,
Brad
