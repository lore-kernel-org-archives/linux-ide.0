From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv: hard resetting port
Date: Thu, 15 Nov 2007 09:31:10 -0500
Message-ID: <473C582E.10607@rtr.ca>
References: <473AC34B.8000709@wpkg.org> <473B13D6.3080202@rtr.ca> <473C1EE6.3070304@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1402 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755485AbXKOObM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Nov 2007 09:31:12 -0500
In-Reply-To: <473C1EE6.3070304@wpkg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Tomasz Chmielewski wrote:
>
> And today kernel (2.6.23.1) in the same machine have spoken to 
> not-mere-mortals again:
> 
> ata6: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata6: edma_err 0x00000020
..

Here, the messages fail us.  The edma_err value says that there
should be a non-zero value in the SErr value.  Except the messages
show zero there, meaning the registers were probably read in the
wrong sequence (some bits clear automatically on reads).

In any event, the messages that follow don't say anything about
I/O failing in any way, so again this is nothing to be concerned about
unless it happens frequently.

At this point, I would unplug/replug all of the SATA cables,
to ensure they have good connections.


> ata6: hard resetting port
> ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata6.00: configured for UDMA/133
> ata6: EH complete
> sd 5:0:0:0: [sde] 781422768 512-byte hardware sectors (400088 MB)
> sd 5:0:0:0: [sde] Write Protect is off
> sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
> sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't 
> support DPO or FUA
> 
> 
> As I understand it now, your previous translation would fit here (or 
> not, as SErr differs?):
> 
>  > Translation:
>  > "libata reset the link, and everything appeared okay,
>  > so it reissued the failed command and continued.
>  > No data loss."
> 
> But why was the port reseted? There was no CRC error as before, was there?
..

I think the error-handling code is a bit heavy handed,
in that the port reset was not actually needed in the prior case either.

But this way it is simple, consistent, and does work.
It just prints too many messages.

> What worries me is that it always happens for the same drive.
..

Twiddle with the cabling for that drive, and it will probably behave.

