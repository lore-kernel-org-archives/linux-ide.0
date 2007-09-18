From: Alan Cox <alan@redhat.com>
Subject: Re: [PATCH 1/1] pata_it821x: fix lost interrupt with atapi devices
Date: Tue, 18 Sep 2007 05:07:15 -0400
Message-ID: <20070918090715.GA13425@devserv.devel.redhat.com>
References: <200709041607.l84G7KsT032647@norden.math.tntech.edu> <18141.42848.537873.349518@alkaid.it.uu.se> <20070906013929.1621849d@the-village.bc.nu> <46EE09D3.9010201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:58679 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968AbXIRJHx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Sep 2007 05:07:53 -0400
Content-Disposition: inline
In-Reply-To: <46EE09D3.9010201@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mikael Pettersson <mikpe@it.uu.se>, Jeff Norden <jeff@math.tntech.edu>, alan@redhat.com, linux-kernel@vger.kernel.org, Albert CC Lee <albertcc@tw.ibm.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Mon, Sep 17, 2007 at 07:00:03AM +0200, Tejun Heo wrote:
> I wonder whether we should be using similar check in generic path too.
> We have quite a few cases where MWDMA ATAPI devices choking on commands
> with small transfer sizes.  I don't think we'll experience significant
> performance regression with this applied and even if there is some, it's
> far better to have slightly slower working device.
> 
> What do you guys think?

I think to start with someone should fix the ATAPI state machine. Stick
a BUG() in the driver if dma start is called when the atapi command data 
size is zero

Alan

