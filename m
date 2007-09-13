From: Mark Lord <liml@rtr.ca>
Subject: Re: ATAPI tape drives broken with libata
Date: Thu, 13 Sep 2007 15:07:10 -0400
Message-ID: <46E98A5E.8080109@rtr.ca>
References: <46D5F97B.3050808@redhat.com>	<20070830005006.6951265a@the-village.bc.nu>	<46D6EC3B.8090306@redhat.com> <20070831151903.37a60ba9@the-village.bc.nu> <46E966C2.1050405@rtr.ca> <46E97FE8.5090304@rtr.ca> <46E9848E.2000704@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3034 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755115AbXIMTHL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Sep 2007 15:07:11 -0400
In-Reply-To: <46E9848E.2000704@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chuck Ebbert <cebbert@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, craig48@swbell.net


> 14:26:48 root: writing
> 14:26:54 kernel: qc_issue: CDB 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 14:26:54 kernel: qc_issue_prot: CDB 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 14:26:54 kernel: qc_issue: CDB 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 14:26:54 kernel: qc_issue_prot: CDB 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 14:26:54 kernel: qc_issue: CDB 03 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00
> 14:26:54 kernel: qc_issue_prot: CDB 03 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00
> 14:26:54 kernel: ata3: DRQ=1 with device error, dev_stat 0x59
> 14:26:54 kernel: st0: Sense Key : Illegal Request [current]
> 14:26:54 kernel: st0: Add. Sense: Invalid command operation code


One more bit of possibly helpful information here.

The last time I wrote a working ATAPI Tape driver,
it always translated SCSI opcode 0x05 (READ_BLOCK_LIMITS) into MODE_SENSE.

I don't remember why it did that, but it was necessary at the time.
So I wonder if the error above has anything to do with the READ_BLOCK_LIMITS
command that can be seen just above the TEST_UNIT_READY and REQUEST_SENSE CDBs ?

Cheers
