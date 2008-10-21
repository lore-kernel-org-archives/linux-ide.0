From: Tejun Heo <htejun@gmail.com>
Subject: Re: [smartmontools-support] inactive SATA drives won't stay in standby
 or sleep, PATA models did. (fwd)
Date: Tue, 21 Oct 2008 17:55:31 +0900
Message-ID: <48FD9903.2090400@gmail.com>
References: <D73D40172004714D95D7A84AC3E68EC802282133@wdscexbe03.sc.wdc.com>	<48EBFE9B.9070503@gmail.com>	<18674.4081.839329.116533@harpo.it.uu.se>	<48F2D9A8.1030502@gmail.com>	<18683.50533.786782.474536@harpo.it.uu.se> <18685.35827.914278.413151@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:42630 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbYJUI5e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Oct 2008 04:57:34 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1069730tic.23
        for <linux-ide@vger.kernel.org>; Tue, 21 Oct 2008 01:57:32 -0700 (PDT)
In-Reply-To: <18685.35827.914278.413151@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Christian Mueller <Christian.Mueller@wdc.com>, Bruce Allen <ballen@gravity.phys.uwm.edu>, Smartmontools Mailing List <smartmontools-support@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, Mikael.
> I did a round of regression tests which identified another
> related but different problem.
> 
> In kernels 2.6.24 and 2.6.25 sata_promise would actually recover
> from the timeouts, while in kernels 2.6.26 and 2.6.27 it would not.
> Before 2.6.26 sata_promise explicitly used sata_std_hardreset, but
> in the "make reset related methods proper port operations" commit
> (a1efdaba2dbd6fb89e23a87b66d3f4dd92c9f5af), Tejun changed sata_promise
> to use the hardreset it now inherits from ata_sff_port_ops, namely
> sata_sff_hardreset. This change looks accidental. The main difference
> between these two procedures is that the sff version will poll the
> legacy status register until the port becomes ready.

Hmm... it's quite likely that I've introduced the regression but that
commit ain't it (I actually wrote a script to verify the inheritance
change doesn't actually change the function table).  What used to be
sata_std_hardreset() is now sata_sff_hardreset().  The change was made
while separating out SFF as [S]ATA as per the standard doesn't have
any way to wait for device readiness.  The TF-polling is SFF specific
and thus moved out to sata_sff_hardreset().

So, in both 2.6.24 and 2.6.25, sata_promise did wait for device
readiness after hardreset as does 2.6.26 or any later version.

> Changing sata_promise to use sata_std_hardreset in 2.6.26/.27
> makes the EH after the timeouts much more reliable. Not as
> tidy as with the previous ->prereset fix, but still working.

The only behavior change between 2.6.25 and 2.6.26 as far as
sata_promise is concerned is that hardrset is preferred over
softreset.  Here's what I think is going on.

Previously, after a timeout, libata-eh will invoke softreset and if
that works all should have been fine whether hardreset actually worked
or not.  Now, after something goes wrong, libata EH calls hardreset
and as hardreset doesn't work properly without the controller reset so
it fails.  So, the libata core layer change exposed a bug in
hardreset, which was one of the reasons why the change was made -
hardreset being the last line of defense, using it occasionally
doesn't make sense test-coverage-wise.

I agree the core layer changes can be quite confusing but they were
necessary to keep the core layer scalable.  libata now has oodles of
different types of low level drivers and things were and still are
getting quite treacherous for drivers living on the edge.

Anyways, so, please fix hardreset.  If it can't wait for device
readiness reliably, the right thing to do is to use
sata_std_hardreset() which will trigger follow-up softreset to wait
for device readiness and classify devices but if adding the controller
reset makes the hardreset more reliable, please do so.

Thanks.

-- 
tejun
