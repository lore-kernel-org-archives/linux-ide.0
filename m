From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [1/12]
Date: Mon, 14 Jun 2004 08:54:58 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040614155458.GA25461@kroah.com>
References: <200406111750.30312.bzolnier@elka.pw.edu.pl> <200406131936.08338.bzolnier@elka.pw.edu.pl> <20040614095835.GA11585@infradead.org> <200406141636.01353.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kroah.org ([65.200.24.183]:52890 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262208AbUFNQJP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jun 2004 12:09:15 -0400
Content-Disposition: inline
In-Reply-To: <200406141636.01353.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 04:36:01PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > And even if for this special hardware it's usually not doable there
> > are things like greg's fake hotplug pci driver.  So a non-__devinit pci
> > probe method is a bug, please fix them in PCI.
> 
> Greg, should I add "fake" PCI hotplug support to some IDE
> drivers just to make fake hotplug PCI driver happy?

No, not at all.  The fake hotplug pci driver is for developers.  Do not
go changing your IDE drivers just to prevent oopses from happening when
someone uses the fake hotplug pci driver.

thanks,

greg k-h
