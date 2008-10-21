From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH #upstream-fixes] libata-eh: fix slave link EH
	action mask handling
Date: Tue, 21 Oct 2008 10:00:48 -0700
Message-ID: <20081021170048.GB24940@kroah.com>
References: <48FD5EE0.9040407@kernel.org> <48FD64C3.8020103@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:44915 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752070AbYJURIf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Oct 2008 13:08:35 -0400
Content-Disposition: inline
In-Reply-To: <48FD64C3.8020103@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org

On Tue, Oct 21, 2008 at 02:12:35PM +0900, Tejun Heo wrote:
> Tejun Heo wrote:
> > Slave link action mask is transferred to masater link and all the EH
> > actions are taken by the master link.  ata_eh_about_to_do() and
> > ata_eh_done() are called with ATA_EH_ALL_ACTIONS to clear the slave
> > link actions during transfer.  This always sets ATA_PFLAG_RECOVERED
> > flag causing spurious "EH complete" messages.
> > 
> > Don't set ATA_PFLAG_RECOVERED for slave link actions.
> > 
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> 
> Oops, slave link is not included in 2.6.27, so this fix doesn't need to
> go into -stable.  Stable team, please ignore this patch.  Sorry about
> the noise.

No problem, it's now ignored :)

thanks,

greg k-h
