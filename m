From: Mark Lord <liml@rtr.ca>
Subject: Re: Errors and resets using sata_promise and libata 1.20
Date: Fri, 14 Jul 2006 13:31:16 -0400
Message-ID: <44B7D4E4.4000607@rtr.ca>
References: <1152725383.23607.5637.camel@girvin.pmc-sierra.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:48575 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1422666AbWGNRbR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Jul 2006 13:31:17 -0400
In-Reply-To: <1152725383.23607.5637.camel@girvin.pmc-sierra.bc.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Frederiksen <erik_frederiksen@pmc-sierra.com>
Cc: linux-ide@vger.kernel.org

Erik Frederiksen wrote:
> Hi everyone.  Quite regularly I get these messages popping up when I'm
> rebuilding a raid5.
> 
> ata2: status=0x50 { DriveReady SeekComplete }
> sdb: Current: sense key=0x0
>     ASC=0x0 ASCQ=0x0
..
> Is this a matter of shutting up a superfluous message, or is something
> more sinister going on here?

It is a bug in how libata (prior to 2.6.18, at least) handles errors.
The interrupt handler reads the ATA status (0x51) with the ERR bit set,
and signals that something went wrong.

Then the LLD in some cases resets the channel to clear the controller
state machine, but this also clears the ERR bit, giving status 0x50
(I believe there to be other paths to the same result as well, but have
not yet had time to investigate further).

Then later in handling of the same failed command, the libata-scsi layer
finally has to report the error upstream, but by now it only sees 0x50
and has no idea what went wrong.

And people like you and I get very confused by the bogus error mis-report.

Dunno (yet) if 2.6.18 has the same bugs.

Cheers




