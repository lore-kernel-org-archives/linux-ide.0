From: Jeff Garzik <jgarzik@pobox.com>
Subject: libata and queueing (was Re: [t13] RE: comment on T10 ATA-passthru)
Date: Sun, 14 Nov 2004 19:43:22 -0500
Message-ID: <4197FBAA.5030703@pobox.com>
References: <A9B8FF43A76C0D42A80DDD73CF99BEC80548967B@azsmsx407> <20041029142539.A29944@florence.linkmargin.com> <20041029194311.GA27218@havoc.gtf.org> <20041029153953.B29944@florence.linkmargin.com> <20041029205033.GA32007@havoc.gtf.org> <20041101201240.A16317@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47539 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261387AbUKOAng
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 14 Nov 2004 19:43:36 -0500
In-Reply-To: <20041101201240.A16317@florence.linkmargin.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: linville@redhat.com, linux-ide@vger.kernel.org

Andy Warner wrote:
> Jeff Garzik wrote:
> 
>>[I ask about NCQ ...]
>>Most of the code is already written to assume that queueing is
>>active.  Turning on NCQ in libata is trivial.  Handling errors and
>>synchronization is less trivial :)
> 
> 
> I guess I'm a little gun shy here :) Remember, my induction to
> hotplug consisted of:
> 
> 	"That's because libata doesn't call the proper hot-unplug hooks.
> 	 Call those hooks, and the problem goes away."
> 
> I really don't want to hugely underestimate the effort involved.
> 
> Things that I can't quite see being in there right now
> are the low-level state machine support for queued events,
> and data structures and functions required to queue the pending
> requests.
> 
> The boundary conditions you allude to seem likely to be
> a pandora's box. Not the least of which will be ensuring
> that queued and non-queued commands never mingle. It is
> my understanding that any non-queued command will abort
> *all* pending queued commands with unpredictable results
> for data in flight.

Everything is a pandora's box :)  Nobody said storage was easy :)

My advice for any efforts, whether it's NCQ or hotplug or whatever, is: 
  post early, post often.  Design in public first, get the design nailed 
down, _then_ settle in for some testing.

One of the key problems is that a lot of the future directions and 
current methodology isn't written down, so you need to pelt me (CC'ing 
linux-ide, to share the knowledge) with email asking questions.

[side note: anyone is welcome to patch Documentation/DocBook/libata.tmpl 
with new knowledge]


Now, back to queueing specifically...

libata currently relies on the SCSI layer to handle queueing (or lack 
thereof), and to handle arbitration between master/slave in PATA 
configurations.

There is minimal infrastructure in libata for queueing:  32 commands 
(ata_queued_cmd) per ata_device, but that's mainly for storage of 
per-command metadata.

To implement queueing in libata, you'll use the current libata 
per-command infrastructure, and the SCSI mid-layer's queueing 
infrastructure in concert.  The SCSI mid-layer API is used to control 
the queue depth.  For exceptional cases such as error handling and 
non-queue-able commands, you'll return host-busy to the SCSI mid-layer 
from the libata ->queuecommand hook.

Error handling consists of knowing which commands to retry, which to 
fail, and which to partially complete.

