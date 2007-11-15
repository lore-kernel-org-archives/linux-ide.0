From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv: hard resetting port
Date: Thu, 15 Nov 2007 14:22:29 -0500
Message-ID: <473C9C75.3060906@rtr.ca>
References: <473AC34B.8000709@wpkg.org> <473B13D6.3080202@rtr.ca> <473C1EE6.3070304@wpkg.org> <473C582E.10607@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1795 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757920AbXKOTWa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Nov 2007 14:22:30 -0500
In-Reply-To: <473C582E.10607@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, "Eric D. Mudama" <edmudama@gmail.com>

Eric D. Mudama wrote:
> On Nov 15, 2007 7:31 AM, Mark Lord <liml@rtr.ca> wrote:
>> Here, the messages fail us.  The edma_err value says that there
>> should be a non-zero value in the SErr value.  Except the messages
>> show zero there, meaning the registers were probably read in the
>> wrong sequence (some bits clear automatically on reads).
> 
> Isn't that the reset signature?
..

No, it's just funny status.  The chipset (Marvell) claims it saw
a SATA error.  But the SATA error register is all-zeros, meaning "no error".

I think somebody forgot to save the latter before clearing it,
or somebody forgot to clear the former from an earlier error.
Either way, a nuisance, but no harm done here.

> Maybe due to insufficient power the drive decided to reboot itself.
> 
> (What bits clear automatically on read, other than IRQ?)
..

Mmm.. none in this case (my mistake).



