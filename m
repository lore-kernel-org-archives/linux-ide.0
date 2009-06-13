From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Sat, 13 Jun 2009 16:54:37 GMT
Message-ID: <200906131654.n5DGsbg3022553@demeter.kernel.org>
References: <bug-13399-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:53489 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609AbZFMQyh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Jun 2009 12:54:37 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n5DGsbaG022554
	for <linux-ide@vger.kernel.org>; Sat, 13 Jun 2009 16:54:37 GMT
In-Reply-To: <bug-13399-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13399





--- Comment #21 from Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>  2009-06-13 16:54:36 ---
On Saturday 13 June 2009 18:29:07 bugzilla-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=13399
> 
> 
> 
> 
> 
> --- Comment #20 from Borislav Petkov <bbpetkov@yahoo.de>  2009-06-13 16:29:05 ---
> Hi Bart,
> 
> thanks for analyzing this.
> 
> I'm staring at the ATA_DRQ == 0 part in cdrom_newpc_intr:
> 
>                 } else if (!blk_pc_request(rq)) {
>                         ide_cd_request_sense_fixup(drive, cmd);
>                         /* complain if we still have data left to transfer */
>                         uptodate = cmd->nleft ? 0 : 1;
>                         if (uptodate == 0)
>                                 rq->cmd_flags |= REQ_FAILED;
>                 }
>                 goto out_end;
>         }
> 
> so, in our case ide_cd_error_cmd() kills the rq prematurely and that's
> why ide_complete_rq() oopses later. And this is caused by uptodate ==

Nope, it is block layer that kills it prematurely.

There are two issues here:

* OOPS (*the*regression* which should be taken care of first)
  (cause: unexpected interaction between ide/block)

* handling of non-fully completed requests with "good" status
  (cause: stupid hardware)

> 0. Now, here's how the ATA spec (d1532v1r4b-ATA-ATAPI-7) describes the
> semantics of clearing of the DRQ bit by the drive:
> 
> "
> 5.14.5.5 DRQ (Data request)
> 
> ...
> 
> The DRQ bit shall be cleared to zero by the device:
>          1) when the last word of the data transfer occurs;
>          2) when the last word of the command packet transfer occurs for a
> PACKET command.
> "
> 
> now there's a subtlety here wrt to what am I to do as an IRQ handler
> when my drive clears the DRQ bit: do I _drain_ the last bytes remaining
> (in our case 2) or do I fail the rq straightaway. I'm pretty sure
> cmd->nleft is 2 in our case so I think that it might be only right to
> drain the device first, i.e. do
> 
>     uptodate = (cmd->nleft - thislen) ? 0 : 1;
> 
> and then later ide_pio_bytes() before completing the rq properly. Hmm?

We should drain only if the device really wants to transfer more data...

cmd->nleft is our concept, thislen reflects the hardware state.

> And yes, this is against spec since the following sentence states that
> the data can be drained only "... via DMA mode if DMARQ and DMACK- are
> asserted and BSY is set to one." but we should give it a try...
> 
> Ideas? Opinions?

Yes.  Please stop reading this stupid ATAPI spec, it is near to worthless
when it comes to the real hardware implementations/bugs..

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
