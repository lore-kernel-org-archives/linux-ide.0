From: Mark Lord <liml@rtr.ca>
Subject: Re: ata_std_qc_defer not good enough for FIS-based switching ?
Date: Wed, 30 Apr 2008 10:02:46 -0400
Message-ID: <48187C06.5090901@rtr.ca>
References: <48163C5D.9050605@rtr.ca> <48164AE8.4070106@rtr.ca> <481659B5.7090703@gmail.com> <48175664.5030702@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2983 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962AbYD3OCs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Apr 2008 10:02:48 -0400
In-Reply-To: <48175664.5030702@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>

Mark Lord wrote:
..
> For the first time ever, I can now *heavily* mix PIO commands
> with NCQ/non-NCQ DMA commands, to drives on an attached PM
> (well, two attached PMs even), and the thing doesn't croak.
> Woo-hoo!
> 
> 
> Time to batch up some patches for Jeff.  But sadly, just in time
> to have missed his weekly visit to linux-ide.  :)
..

Since I've just missed Jeff's weekly capture window (Mondays, it seems),
I'm holding off on the new patches while I work on getting the EH code
to fully/correctly handle (single/multiple) PMP error(s).  Currently,
it just resets the port without doing full NCQ diagnosis for PMP ports,
and that has to change.

It's a bit complex for this chip (sata_mv) architecture, but doable.
If all goes well, there'll be a full patch series out for next Monday.

Cheers

 
