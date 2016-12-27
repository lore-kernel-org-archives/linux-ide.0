From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] Fix interface autodetection in legacy IDE driver (trial #2)
Date: Tue, 27 Dec 2016 18:25:18 +0100
Message-ID: <1680456.bXBqjl9psU@amdc3058>
References: <3010789.Juyl7C8p5j@amdc3058> <6997612.Sd3D1QNmYZ@amdc3058>
 <20161227.114112.712597535585873594.davem@davemloft.net>
 <CGME20161227172520epcas5p3e8ce2b1af4b5a3e1d9a42434d9c9b14f@epcas5p3.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:41424 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755656AbcL0R0L (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 27 Dec 2016 12:26:11 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OIU012LSTQA1K30@mailout3.samsung.com> for
 linux-ide@vger.kernel.org; Wed, 28 Dec 2016 02:25:22 +0900 (KST)
In-reply-to: <20161227.114112.712597535585873594.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: lramos.prof@yahoo.com.br, linux-ide@vger.kernel.org, petkovbb@gmail.com


Hi,

On Tuesday, December 27, 2016 11:41:12 AM David Miller wrote:
> From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Date: Tue, 27 Dec 2016 17:06:19 +0100
> 
> > On Tuesday, December 27, 2016 11:08:24 AM Bartlomiej Zolnierkiewicz wrote:
> >> 
> >> Hi,
> >> 
> >> On Monday, December 26, 2016 11:47:24 AM David Miller wrote:
> >> > From: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
> >> > Date: Tue, 11 Oct 2016 22:12:45 -0300
> >> > 
> >> > > This humble patch was sent one or two months before, and had no actions,
> >> > > except for a colleague reply which friendly pointed out some formatting
> >> > > problems (which were solved in a second message).
> >> > > 
> >> > > It relates to an old code, the legacy IDE driver, but the bug it
> >> > > addresses is real. The code, although rarely used, is
> >> > > still there to be compiled if one chooses to do so (like me).
> >> > > 
> >> > > Also, the fix has a very low risk of present collateral effects IMHO.
> >> > > It is already compiled and tested in some embedded machines.
> >> > > 
> >> > > So, again IMHO, it is worth be fixed.
> >> > > 
> >> > > This email is a second trial with it. I hope it can help the one or two
> >> > > guys out there which are still running the legacy IDE driver and
> >> > > haven't noticed the former email.
> >> > > 
> >> > > Best regards,
> >> > > 
> >> > > Signed-off-by: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
> >> > 
> >> > This bug was introduced by commit
> >> > 20df429dd6671804999493baf2952f82582869fa ("ide-generic: handle probing
> >> > of legacy io-ports v5") which seems poorly tested.
> >> 
> >> Please always cc: the original commit author.
> >> 
> >> > Applied and queued up for -stable, th anks.
> >> 
> >> For some reason I've never got the discussed patch from
> >> linux-ide ML though I now have found in the patchwork:
> >> 
> >> https://patchwork.ozlabs.org/patch/680975/
> >> 
> >> The patch is incorrect.  If you have PCI IDE devices (like in
> >> the case described in the situation being "fixed" by the patch)
> >> you should use the correct PCI IDE host driver for proper
> >> operation and not ide-generic host driver (the latter still can
> >> be used by using kernel parameters).
> > 
> > Moreover this patch introduces a regression.  In the situation
> > when there are no PCI IDE devices and the probing should be done
> > automatically (for the first two legacy IDE ports) it will be no
> > longer done.
> > 
> > Now back to the using correct PCI IDE host drivers - Luiz what
> > are the systems that you need this patch on?  Could you please
> > get 'lspci -nn' command output from them?
> 
> The original code before the patch in question probed the interfaces
> unconditionally, probe_mask was a static int set to "0x03".
> 
> Commit 20df429dd6671804999493baf2952f82582869fa changed the default
> behavior, as well as adding a new module parameter whose behavior
> makes no sense at all.  Inverted bit logic?  Give me a break.
> 
> Sorry, no, the fix is correct and I'm pushing it to Linus.

The "fix" is not correct and is not needed.  99% of users of ide-generic
used it by mistake and should have used the designated host drivers for
their hardware or PCI IDE generic host driver (not ide-generic one).

Alan Cox did the work on fixing this for his pata_legacy libata host
driver and later Borislav back-ported needed changes to ide-generic host
driver in commit 20df429dd6671804999493baf2952f82582869fa (in *2008*).

Also the "fix" is not a revert but a new patch which introduces a real
regression described by me in the previous mail.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

