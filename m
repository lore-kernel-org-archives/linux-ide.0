From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/4] libata: make ata_set_mode() responsible for failure handling
Date: Mon, 13 Mar 2006 18:44:01 +0900
Message-ID: <20060313094401.GD2091@htj.dyndns.org>
References: <11422375531645-git-send-email-htejun@gmail.com> <44152F3D.50307@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.180]:46872 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751206AbWCMJoH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 04:44:07 -0500
Received: by pproxy.gmail.com with SMTP id d42so844882pyd
        for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 01:44:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <44152F3D.50307@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Mon, Mar 13, 2006 at 03:37:17AM -0500, Jeff Garzik wrote:
> 
> I have the following concern with this patch (#3) however:
> 
> >-static void ata_dev_set_mode(struct ata_port *ap, struct ata_device *dev)
> >+static int ata_dev_set_mode(struct ata_port *ap, struct ata_device *dev)
> > {
> >-	if (!ata_dev_present(dev) || (ap->flags & ATA_FLAG_PORT_DISABLED))
> >-		return;
> 
> I think you drop too many ATA_FLAG_PORT_DISABLED tests in this patch, 
> leading the code to potentially miss a previously-flagged PORT_DISABLED 
> (perhaps by an LLDD).
> 

Hmmm... the plan is to disallow LLDD's take ports or devices offline
from low level callbacks.  They should just let upper layer know by
returning failure code.

Currently, during probing, the only place where disabling a port is
allowed is ->phy_reset (for compatibility), which ata_bus_probe()
interprets as no active device and reenables the port.  Later,
->error_handler() would have that power too but I don't think any
other callback should be allowed to do that.  Also, no current
in-kernel LLDD does that during probing process.

If we're gonna allow some callbacks to disable ports or devices.  I
think we need to come up with clear rules such that checks can be
performed exactly where needed.

Thanks.

-- 
tejun
