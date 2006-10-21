From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix ATA passthrough handling for ATAPI devices
Date: Sat, 21 Oct 2006 17:40:27 -0400
Message-ID: <453A93CB.9000008@pobox.com>
References: <20061020050948.GF13677@htj.dyndns.org> <453A720C.6070905@pobox.com> <453A7C6B.3050108@torque.net> <453A7F6B.1010205@pobox.com> <453A8E96.9040702@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:28293 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161067AbWJUVkc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Oct 2006 17:40:32 -0400
In-Reply-To: <453A8E96.9040702@torque.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dougg@torque.net
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Douglas Gilbert wrote:
> Jeff Garzik wrote:
>> I'm talking about the changes to the implementation, which appear to
>> mistakenly allow 16-byte CDBs through to the ATAPI device, even if it
>> only supports 12-byte CDBs.
>>
>> I am quite aware of the ATA passthru SCSI command.  Heck, the spec had
>> input from me.  I'm talking about something different.

> The above were attempts to send IDENTIFY PACKET DEVICE
> to the PATAPI cd/dvd drive via the ATA PASS THROUGH
> (16 and 12) commands respectively. The first one caught
> my attention. Why did it fail with a DID_ABORT?
> 
> Whatever the reason both responses are wrong. The second
> one is wrong because
>   - the cd/dvd drive does support that opcode (the error
>     should be either not ready or incompatible format), or
>   - it didn't do the ATA PASS THROUGH (12) properly

The thread has moved on from discussing the acknowledged problem to 
discussing the solution.

To summarize my quoted email above, I'm talking about problems with the 
implementation details.  There are two engineering constraints which a 
solution must not violate:

1) The kernel must prevent 16-byte non-passthru commands from reaching 
12-byte-only ATAPI devices.

2) Existing in-the-field solutions that issue commands such as BLANK or 
a vendor-reserved 0x85 opcode must continue working, without recompile.

	Jeff


