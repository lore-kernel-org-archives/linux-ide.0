From: Douglas Gilbert <dougg@torque.net>
Subject: Re: [PATCH] libata: fix ATA passthrough handling for ATAPI devices
Date: Sat, 21 Oct 2006 19:11:25 -0400
Message-ID: <453AA91D.8060803@torque.net>
References: <20061020050948.GF13677@htj.dyndns.org> <453A720C.6070905@pobox.com> <453A7C6B.3050108@torque.net> <453A7F6B.1010205@pobox.com> <453A8E96.9040702@torque.net> <453A93CB.9000008@pobox.com>
Reply-To: dougg@torque.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:50117 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161151AbWJUXJ7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 21 Oct 2006 19:09:59 -0400
In-Reply-To: <453A93CB.9000008@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Douglas Gilbert wrote:
>> Jeff Garzik wrote:
>>> I'm talking about the changes to the implementation, which appear to
>>> mistakenly allow 16-byte CDBs through to the ATAPI device, even if it
>>> only supports 12-byte CDBs.
>>>
>>> I am quite aware of the ATA passthru SCSI command.  Heck, the spec had
>>> input from me.  I'm talking about something different.
> 
>> The above were attempts to send IDENTIFY PACKET DEVICE
>> to the PATAPI cd/dvd drive via the ATA PASS THROUGH
>> (16 and 12) commands respectively. The first one caught
>> my attention. Why did it fail with a DID_ABORT?
>>
>> Whatever the reason both responses are wrong. The second
>> one is wrong because
>>   - the cd/dvd drive does support that opcode (the error
>>     should be either not ready or incompatible format), or
>>   - it didn't do the ATA PASS THROUGH (12) properly
> 
> The thread has moved on from discussing the acknowledged problem to
> discussing the solution.
> 
> To summarize my quoted email above, I'm talking about problems with the
> implementation details.  There are two engineering constraints which a
> solution must not violate:

> 1) The kernel must prevent 16-byte non-passthru commands from reaching
> 12-byte-only ATAPI devices.

I would prefer to see the command sent through until
it hits a transport that cannot carry a 16 byte cdb.
That transport may be in an external enclosure, or
the limitation may have been removed.

> 2) Existing in-the-field solutions that issue commands such as BLANK or
> a vendor-reserved 0x85 opcode must continue working, without recompile.

Opcodes 0x85 and 0xa1 are not vendor reserved. They have
been reserved for t10.org use since SCSI-2. Other SCSI
opcode ranges are set aside for vendor use.
The BLANK problems remains.

Doug Gilbert
