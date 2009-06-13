From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Sat, 13 Jun 2009 18:59:53 +0200
Message-ID: <200906131859.54080.bzolnier@gmail.com>
References: <bug-13399-11633@http.bugzilla.kernel.org/> <200906131629.n5DGT7LL020589@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f206.google.com ([209.85.220.206]:55405 "EHLO
	mail-fx0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293AbZFMQyd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Jun 2009 12:54:33 -0400
Received: by fxm2 with SMTP id 2so40463fxm.37
        for <linux-ide@vger.kernel.org>; Sat, 13 Jun 2009 09:54:34 -0700 (PDT)
In-Reply-To: <200906131629.n5DGT7LL020589@demeter.kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-ide@vger.kernel.org

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
