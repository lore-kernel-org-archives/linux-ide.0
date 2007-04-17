From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] pci-quirks: disable MSI on RS400-200 and RS480
Date: Tue, 17 Apr 2007 08:03:31 -0700
Message-ID: <20070417150331.GA30372@suse.de>
References: <20070416045918.GI10619@htj.dyndns.org> <4624E058.8010808@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:52145 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932339AbXDQPF5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Apr 2007 11:05:57 -0400
Content-Disposition: inline
In-Reply-To: <4624E058.8010808@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torresmat@gmail.com, conke.hu@gmail.com

On Tue, Apr 17, 2007 at 10:57:28AM -0400, Jeff Garzik wrote:
> Tejun Heo wrote:
> >MSI doesn't work on RS400-200 and RS480 requiring pci=nomsi kernel
> >boot parameter for ahci to work.  This patch disables MSI on those
> >chips.
> >
> >  http://thread.gmane.org/gmane.linux.ide/17820
> >  http://thread.gmane.org/gmane.linux.ide/17516
> >  https://bugzilla.novell.com/show_bug.cgi?id=263893
> >
> >Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ACK.  Greg will apply, I presume?

Yes, I'll add this to my tree.

thanks,

greg k-h
