From: Mark Lord <lkml@rtr.ca>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Sun, 19 Feb 2006 10:30:56 -0500
Message-ID: <43F88F30.1070208@rtr.ca>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F1EE4A.3050107@rtr.ca> <43F58D29.3040608@pobox.com> <200602170959.40286.lkml@rtr.ca> <20060218204340.GA2984@favonius> <43F794D8.7000406@rtr.ca> <20060219071414.GA31299@favonius>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:53157 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750715AbWBSPbB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Feb 2006 10:31:01 -0500
In-Reply-To: <20060219071414.GA31299@favonius>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sander@humilis.net
Cc: Jeff Garzik <jgarzik@pobox.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Sander wrote:
> Mark Lord wrote (ao):
>> Sander wrote:
>>> Mark Lord wrote (ao):
>>>> On Friday 17 February 2006 03:45, Jeff Garzik wrote:
>>>>> Submit a patch... 
>>>> You mean, something like this one?
>> ...
>>> [  633.449961] md: md1: sync done.
>>> [  633.456070] RAID5 conf printout:
>>> [  633.456117]  --- rd:9 wd:9 fd:0
>> ...
>>> [ 1872.338185] ata6: translated op=0x2a ATA stat/err 0xd0/00 to SCSI 
>>> SK/ASC/ASCQ 0xb/47/00
>>> [ 1872.338239] ata6: status=0xd0 { Busy }
>>> [ 5749.285084] ata8: translated op=0x2a ATA stat/err 0xd0/00 to SCSI 
>>> SK/ASC/ASCQ 0xb/47/00
>>> [ 5749.285138] ata8: status=0xd0 { Busy }
>>> [ 5906.008461] ata6: translated op=0x2a ATA stat/err 0xd0/00 to SCSI 
>>> SK/ASC/ASCQ 0xb/47/00
>>> [ 5906.008515] ata6: status=0xd0 { Busy }
...
>> SCSI opcode 0x2a is WRITE_10, so the errors are being reported
>> in response to the writes to bigfile.$i.
...
> I am using the sata_mv driver, which is beta. That might explain why it
> behaves not totally as expected in your eyes. I have no clue anyway :-)

Ahh.. that's useful to know.  I expect to be taking a long hard look
at the innards of the sata_mv code in the near future, so whatever is
wrong here just might get fixed soon.

Cheers
