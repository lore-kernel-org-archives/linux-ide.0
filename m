From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH #upstream-fixes] libata: retry link resume if necessary
Date: Mon, 11 Jan 2010 14:57:26 -0800
Message-ID: <20100111225726.GA6591@kroah.com>
References: <4B4A8994.8030600@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:44664 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809Ab0AKW6H (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Jan 2010 17:58:07 -0500
Content-Disposition: inline
In-Reply-To: <4B4A8994.8030600@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, fengxiangjun <fengxiangjun@neusoft.com>, Jim Faulkner <jfaulkne@ccs.neu.edu>

On Mon, Jan 11, 2010 at 11:14:44AM +0900, Tejun Heo wrote:
> Interestingly, when SIDPR is used in ata_piix, writes to DET in
> SControl sometimes get ignored leading to detection failure.  Update
> sata_link_resume() such that it reads back SControl after clearing DET
> and retry if it's not clear.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: fengxiangjun <fengxiangjun@neusoft.com>
> Reported-by: Jim Faulkner <jfaulkne@ccs.neu.edu>
> Cc: stable@kernel.org
> ---
> Greg, although this patch should be included in -stable release in
> time, I think it should receive some more testing in devel branch for
> at least a couple of -rc cycles as it changes very fundamental part of
> hardreset protocol.  Is there a protocol for delayed inclusion into
> -stable?  If not, I'll try to remember and ping you back after some
> time but I'm almost sure that I'm gonna forget this.  :-)

I'll drop this into my "todo-stable" queue, and ping you back on this in
a few weeks.  Sound good?

thanks,

greg k-h
