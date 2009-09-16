From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH] ahci: restore pci_intx() handling
Date: Wed, 16 Sep 2009 08:48:07 -0700
Message-ID: <20090916154807.GA27478@kroah.com>
References: <4AB1058F.3070108@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:56287 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753657AbZIPPsQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Sep 2009 11:48:16 -0400
Content-Disposition: inline
In-Reply-To: <4AB1058F.3070108@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org, Jeff Garzik <jeff@garzik.org>, Thomas Jarosch <thomas.jarosch@intra2net.com>

On Thu, Sep 17, 2009 at 12:34:39AM +0900, Tejun Heo wrote:
> Commit a5bfc4714b3f01365aef89a92673f2ceb1ccf246 dropped explicit
> pci_intx() manipulation from ahci because it seemed unnecessary and
> ahci doesn't seem to be the right place to be tweaking it if it were.
> This was largely okay but there are exceptions.  There was one on an
> embedded platform which was fixed via firmware and now bko#14124
> reports it on a HP DL320.
> 
>   http://bugzilla.kernel.org/show_bug.cgi?id=14124
> 
> I still think this isn't something libata drivers should be caring
> about (the only ones which are calling pci_intx() explicitly are
> libata ones and one other driver) but for now reverting the change
> seems to be the right thing to do.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Thomas Jarosch <thomas.jarosch@intra2net.com>

In the future, for stuff that you want sent to stable, can you also add:
	Cc: stable <stable@kernel.org>
in this signed-off-by area?  That way, when the patch hits Linus's tree,
we get automatically notified of it and I don't have to dig back through
log files to try to find out if your commit has made it in or not.

thanks,

greg "drowning in -stable patches" k-h
