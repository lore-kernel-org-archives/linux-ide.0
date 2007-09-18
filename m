From: Alan Cox <alan@redhat.com>
Subject: Re: [PATCH 1/1] pata_it821x: fix lost interrupt with atapi devices
Date: Tue, 18 Sep 2007 05:14:00 -0400
Message-ID: <20070918091400.GC13425@devserv.devel.redhat.com>
References: <200709041607.l84G7KsT032647@norden.math.tntech.edu> <18141.42848.537873.349518@alkaid.it.uu.se> <20070906013929.1621849d@the-village.bc.nu> <46EE09D3.9010201@gmail.com> <46EE5033.7060708@garzik.org> <46EE68F9.9050707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:60534 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753629AbXIRJPy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Sep 2007 05:15:54 -0400
Content-Disposition: inline
In-Reply-To: <46EE68F9.9050707@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mikael Pettersson <mikpe@it.uu.se>, Jeff Norden <jeff@math.tntech.edu>, alan@redhat.com, linux-kernel@vger.kernel.org, Albert CC Lee <albertcc@tw.ibm.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Mon, Sep 17, 2007 at 01:46:01PM +0200, Tejun Heo wrote:
> failures and would really like to know what's broken.  The reason can be
> one of the following two.
> 
> 1. libata itself isn't doing anything wrong but using SCSI for mid and
> high level drivers are causing problems as more types of commands are used.
> 
> 2. Mode programming for MWDMA is broken.  This doesn't seem too likely
> as we're seeing MWDMA failures across different low level drivers but is
> still a possibility.

3 and 4

3. Libata is wrong (it is in places)

4. Old IDE uses DMA much less for ATAPI especially
