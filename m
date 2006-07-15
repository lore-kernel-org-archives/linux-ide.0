From: Mark Lord <liml@rtr.ca>
Subject: Re: Errors and resets using sata_promise and libata 1.20
Date: Sat, 15 Jul 2006 09:08:38 -0400
Message-ID: <44B8E8D6.8020903@rtr.ca>
References: <1152725383.23607.5637.camel@girvin.pmc-sierra.bc.ca> <44B7D4E4.4000607@rtr.ca> <20060715065001.GA11832@localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3507 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1161281AbWGONIk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Jul 2006 09:08:40 -0400
In-Reply-To: <20060715065001.GA11832@localnet>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sr@gimp.org
Cc: Erik Frederiksen <erik_frederiksen@pmc-sierra.com>, linux-ide@vger.kernel.org

Sven Riedel wrote:
> On Fri, Jul 14, 2006 at 01:31:16PM -0400, Mark Lord wrote:
>>> ata2: status=0x50 { DriveReady SeekComplete }
>>> sdb: Current: sense key=0x0
>>>    ASC=0x0 ASCQ=0x0
>> [...]
>> Then the LLD in some cases resets the channel to clear the controller
>> state machine, but this also clears the ERR bit, giving status 0x50
>> (I believe there to be other paths to the same result as well, but have
>> not yet had time to investigate further).
>>
>> Then later in handling of the same failed command, the libata-scsi layer
>> finally has to report the error upstream, but by now it only sees 0x50
>> and has no idea what went wrong.
> 
> Is there a patch somewhere that didn't make it into the kernel yet, that we
> can try?

No.  And it's quite unfortunate, as this bug prevents proper error handling
by the SCSI layer, since libata doesn't accurately report what problem it saw.

The 2.6.18 libata EH is reputedly much improved, but may still have the same
bug (LLD reads/discards status, requiring libata-core to re-read it again after
it may have changed).

Cheers
