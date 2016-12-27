From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] Fix interface autodetection in legacy IDE driver (trial #2)
Date: Tue, 27 Dec 2016 11:08:24 +0100
Message-ID: <3010789.Juyl7C8p5j@amdc3058>
References: <20161012011245.GA22684@giustizia>
 <20161226.114724.642220063641900983.davem@davemloft.net>
 <CGME20161227100827epcas1p264f5d5fc01ce5c8688dfefb4fc466c16@epcas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:37201 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbcL0KI3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 27 Dec 2016 05:08:29 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OIU030U29I3U960@mailout4.samsung.com> for
 linux-ide@vger.kernel.org; Tue, 27 Dec 2016 19:08:27 +0900 (KST)
In-reply-to: <20161226.114724.642220063641900983.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: lramos.prof@yahoo.com.br, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>


Hi,

On Monday, December 26, 2016 11:47:24 AM David Miller wrote:
> From: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
> Date: Tue, 11 Oct 2016 22:12:45 -0300
> 
> > This humble patch was sent one or two months before, and had no actions,
> > except for a colleague reply which friendly pointed out some formatting
> > problems (which were solved in a second message).
> > 
> > It relates to an old code, the legacy IDE driver, but the bug it
> > addresses is real. The code, although rarely used, is
> > still there to be compiled if one chooses to do so (like me).
> > 
> > Also, the fix has a very low risk of present collateral effects IMHO.
> > It is already compiled and tested in some embedded machines.
> > 
> > So, again IMHO, it is worth be fixed.
> > 
> > This email is a second trial with it. I hope it can help the one or two
> > guys out there which are still running the legacy IDE driver and
> > haven't noticed the former email.
> > 
> > Best regards,
> > 
> > Signed-off-by: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
> 
> This bug was introduced by commit
> 20df429dd6671804999493baf2952f82582869fa ("ide-generic: handle probing
> of legacy io-ports v5") which seems poorly tested.

Please always cc: the original commit author.

> Applied and queued up for -stable, th anks.

For some reason I've never got the discussed patch from
linux-ide ML though I now have found in the patchwork:

https://patchwork.ozlabs.org/patch/680975/

The patch is incorrect.  If you have PCI IDE devices (like in
the case described in the situation being "fixed" by the patch)
you should use the correct PCI IDE host driver for proper
operation and not ide-generic host driver (the latter still can
be used by using kernel parameters).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

