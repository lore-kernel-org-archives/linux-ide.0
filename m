From: Sven Riedel <sr@gimp.org>
Subject: Re: Errors and resets using sata_promise and libata 1.20
Date: Sat, 15 Jul 2006 08:50:01 +0200
Message-ID: <20060715065001.GA11832@localnet>
References: <1152725383.23607.5637.camel@girvin.pmc-sierra.bc.ca> <44B7D4E4.4000607@rtr.ca>
Reply-To: sr@gimp.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kamp-dsl.de ([195.62.99.42]:2450 "HELO mailout.kamp-dsl.de")
	by vger.kernel.org with SMTP id S1422816AbWGOGuF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Jul 2006 02:50:05 -0400
Received: from dsl-mail.kamp.net (mail.kamp-dsl.de [195.62.99.42])
	by sponts.dsl-backup.kamp.de (SPONTS v6.3.6) with SMTP
	id 110C70F2EBCA-0
	for <linux-ide@vger.kernel.org>; Sat, 15 Jul 2006 06:50:03 +0000
Received: from mx01.kamp-dsl.de (mail.kamp-dsl.de [195.62.99.42])
	by sponts.dsl-backup.kamp.de (SPONTS v6.3.6) with ESMTP
	id 110C70F2EB2D-0
	for <linux-ide@vger.kernel.org>; Sat, 15 Jul 2006 06:50:03 +0000
Content-Disposition: inline
In-Reply-To: <44B7D4E4.4000607@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Erik Frederiksen <erik_frederiksen@pmc-sierra.com>, linux-ide@vger.kernel.org

On Fri, Jul 14, 2006 at 01:31:16PM -0400, Mark Lord wrote:
> >ata2: status=0x50 { DriveReady SeekComplete }
> >sdb: Current: sense key=0x0
> >    ASC=0x0 ASCQ=0x0
> 
> [...]
> Then the LLD in some cases resets the channel to clear the controller
> state machine, but this also clears the ERR bit, giving status 0x50
> (I believe there to be other paths to the same result as well, but have
> not yet had time to investigate further).
> 
> Then later in handling of the same failed command, the libata-scsi layer
> finally has to report the error upstream, but by now it only sees 0x50
> and has no idea what went wrong.

Is there a patch somewhere that didn't make it into the kernel yet, that we
can try?

Regs,
Sven

-- 
Sven Riedel                      sr@gimp.org
