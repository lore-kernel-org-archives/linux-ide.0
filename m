From: Marc MERLIN <marc@merlins.org>
Subject: Re: Port Multiplier vendor mismatch '0x1095' != '0x101'
Date: Fri, 26 Aug 2011 11:44:20 -0700
Message-ID: <20110826184420.GM17614@merlins.org>
References: <20110826064050.GD17614@merlins.org> <20110826065815.GB2632@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:35949 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab1HZSoY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Aug 2011 14:44:24 -0400
Content-Disposition: inline
In-Reply-To: <20110826065815.GB2632@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, mlord@pobox.com

On Fri, Aug 26, 2011 at 08:58:15AM +0200, Tejun Heo wrote:
> Hello,
> 
> On Thu, Aug 25, 2011 at 11:40:50PM -0700, Marc MERLIN wrote:
> > ata11.15: hard resetting link
> > ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > ata11.15: Port Multiplier vendor mismatch '0x1095' != '0x101'
> > ata11.15: PMP revalidation failed (errno=-19)
> > ata11.15: hard resetting link
> > ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > ata11.15: Port Multiplier vendor mismatch '0x1095' != '0x101'
> > ata11.15: PMP revalidation failed (errno=-19)
> > ata11.15: limiting SATA link speed to 1.5 Gbps
> > ata11.15: hard resetting link
> > ata11.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> > ata11.15: Port Multiplier vendor mismatch '0x1095' != '0x101'
> > ata11.15: PMP revalidation failed (errno=-19)
> > ata11.15: failed to recover PMP after 5 tries, giving up
> > ata11.15: Port Multiplier detaching
> > ata11.00: disabled
> > ata11.01: disabled
> > ata11.02: disabled
> > ata11.03: disabled
> > ata11.04: disabled
> > ata11.00: disabled
> > ata11: hard resetting link
> > ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > ata11.15: Port Multiplier <unknown>, 0x0101:0x9669 r1, 1 ports, feat 0x96690101/0x96690101
> 
> Either the controller or port multiplier (more likely the controller)
> got completely confused.  It's basically reporting random garbage for
> the identification data for the port multiplier.  I don't know what
> went on there but probably the controller needed a strong kick in the
> butt to come back into sane state.  Anyways, there isn't much the port
> multiplier layer can do if the controller is reporting garbage for
> data read from PMP.
 
Understood. I'm glad you could read those logs better than I could :)

For that it's worth, the raid is still rebuilding 12H later and while I was
initially getting some error/warning messages on the console last night,
they have now stopped:

ata11.00: status: { DRDY }
ata11.01: exception Emask 0x100 SAct 0x1 SErr 0x0 action 0x6 frozen
ata11.01: failed command: READ FPDMA QUEUED
ata11.01: cmd 60/08:00:f7:0c:2c/00:00:56:00:00/40 tag 0 ncq 4096 in
         res 40/00:04:f7:0c:2c/00:00:56:00:00/40 Emask 0x100 (unknown error)
ata11.01: status: { DRDY }
ata11.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata11.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata11.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata11.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata11.15: exception Emask 0x100 SAct 0x0 SErr 0x400000 action 0x6 frozen
ata11.15: edma_err_cause=40000000 pp_flags=00000007
ata11.15: SError: { Handshk }
ata11.00: exception Emask 0x100 SAct 0x2 SErr 0x0 action 0x6 frozen
ata11.00: failed command: WRITE FPDMA QUEUED
ata11.00: cmd 61/f8:08:17:77:9e/03:00:5f:00:00/40 tag 1 ncq 520192 out
         res 40/00:04:0f:7b:9e/00:00:5f:00:00/40 Emask 0x100 (unknown error)
ata11.00: status: { DRDY }
ata11.01: exception Emask 0x100 SAct 0x1 SErr 0x0 action 0x6 frozen
ata11.01: failed command: READ FPDMA QUEUED
ata11.01: cmd 60/08:00:0f:7b:9e/00:00:5f:00:00/40 tag 0 ncq 4096 in
         res 40/00:04:0f:7b:9e/00:00:5f:00:00/40 Emask 0x100 (unknown error)
ata11.01: status: { DRDY }      
ata11.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata11.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata11.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen

However it looks that after the first errors downgraded my ports to 1.5G,
I'm now stuck with a much slower rebuild speed:
      [=========>...........]  recovery = 45.2% (884261384/1953511424) finish=771.1min speed=23109K/sec

Once I'm in that state, can I get back to 3G, or do I need to reboot
to get there?

> Mark, have you seen anything like this?  Could it be that the
> controller goes out of proper configuration after certain condition
> and needs to be reset/reconfigured?

I know you meant Mark Lord, but if that helps, it looks like said condition
was only reached with a drive that had a genuine error when I tried to do a
raid rebuild.

Thankfully my system has otherwise been stable so far with a fair amount of
IO on those drives / PMP / Card.

The upgrade to 3.0.1 probably didn't help much, but it can't hurt to try
that either.

Thanks for your reply,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
