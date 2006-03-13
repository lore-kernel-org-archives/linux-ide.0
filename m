From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] libata: implement per-dev xfer masks
Date: Mon, 13 Mar 2006 15:12:21 +0900
Message-ID: <20060313061221.GA29476@htj.dyndns.org>
References: <11421469551948-git-send-email-htejun@gmail.com> <1142170646.18565.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.183]:32761 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751638AbWCMGM0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 01:12:26 -0500
Received: by pproxy.gmail.com with SMTP id d42so814082pyd
        for <linux-ide@vger.kernel.org>; Sun, 12 Mar 2006 22:12:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1142170646.18565.3.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Sun, Mar 12, 2006 at 01:37:26PM +0000, Alan Cox wrote:
> On Sul, 2006-03-12 at 16:02 +0900, Tejun Heo wrote:
> > I marked with comment where the mode filtering for low level drivers
> > should be done but I'm not sure how the interface should look like.
> 
> Currently the libata pata patch code calls a filter function if present
> which returns an updated bitmap for the mode type. I did that because we
> need to combine the cable, bridge, core and chip specific rules neatly
> and not have one forcing a mode the other cannot do.

Understood.

> > ->pre_set_mode(ap) is okay but then the LLDD should iterate over all
> > devices.  Maybe ->pre_set_mode(ap, dev) or ->filter_xfer_mask(ap, dev)?
> 
> Providing
> 
> 1.	The proposed speeds are set for both devices on the cable before the
> call.
> 2.	We reselect the speed of both devices on changedown or hotplug
> 
> then we should be just fine.

Yeap, both will hold.  I'll just leave it as it is such that filtering
callback can be added later when merging PATA code.  One concern I
have about the originally proposed ->mode_filter(ap, dev, mask, shift)
interface is that if a LLDD wants to reject all UDMA and limit some of
MWDMA, there is no way to do so.  I think it's better and easier to
filter all mode masks at once.

Thanks.

-- 
tejun
