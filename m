From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/4] libata: make ata_set_mode() responsible for failure handling
Date: Mon, 13 Mar 2006 19:14:34 +0900
Message-ID: <20060313101434.GF2091@htj.dyndns.org>
References: <11422375531645-git-send-email-htejun@gmail.com> <44152F3D.50307@pobox.com> <20060313094401.GD2091@htj.dyndns.org> <441541BE.80505@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.194]:50202 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750730AbWCMKOj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 05:14:39 -0500
Received: by zproxy.gmail.com with SMTP id 13so1288578nzn
        for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 02:14:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <441541BE.80505@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Mon, Mar 13, 2006 at 04:56:14AM -0500, Jeff Garzik wrote:
> Tejun Heo wrote:
> >On Mon, Mar 13, 2006 at 03:37:17AM -0500, Jeff Garzik wrote:
> >
> >>I have the following concern with this patch (#3) however:
> >>
> >>
> >>>-static void ata_dev_set_mode(struct ata_port *ap, struct ata_device 
> >>>*dev)
> >>>+static int ata_dev_set_mode(struct ata_port *ap, struct ata_device *dev)
> >>>{
> >>>-	if (!ata_dev_present(dev) || (ap->flags & ATA_FLAG_PORT_DISABLED))
> >>>-		return;
> >>
> >>I think you drop too many ATA_FLAG_PORT_DISABLED tests in this patch, 
> >>leading the code to potentially miss a previously-flagged PORT_DISABLED 
> >>(perhaps by an LLDD).
> >>
> >
> >
> >Hmmm... the plan is to disallow LLDD's take ports or devices offline
> >from low level callbacks.  They should just let upper layer know by
> >returning failure code.
> 
> Long term that plan is fine, but you still have to deal with the 
> existing API one way or another.  ata_port_disable() is called directly 
> by a bunch of Alan's PATA drivers, and by ata_piix and sata_mv.
> 
> Thus you would either need to keep the PORT_DISABLED checks or convert 
> the drivers in question to a better API.
> 
> So just check those ata_port_disable() cases...
> 

AFAICS, ata_piix doesn't call ata_port_disable() directly, but
sata_mv() does, through mv_host_intr() -> mv_err_intr()
->mv_stop_and_reset() -> __mv_phy_reset().  I'll check the code path
such that disabled ports are handled properly.  Thanks for pointing
out.

-- 
tejun
