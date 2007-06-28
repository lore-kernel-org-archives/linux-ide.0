From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.22-rc6] sata_inic162x: add big fat warning about
 broken LBA48 support
Date: Thu, 28 Jun 2007 17:35:23 +0100
Message-ID: <20070628173523.045e12cb@the-village.bc.nu>
References: <4683DCD3.1040303@gmail.com>
	<87f94c370706280914v7b52a7d7k31d323b9d88da19b@mail.gmail.com>
	<4683E171.1090306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43744 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756303AbXF1Q33 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jun 2007 12:29:29 -0400
In-Reply-To: <4683E171.1090306@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Greg Freemyer <greg.freemyer@gmail.com>, Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Fri, 29 Jun 2007 01:27:29 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Greg Freemyer wrote:
> > Does it simply fail?  Or does it corrupt?
> > 
> > In my Windows experience, if you try to write data past ~128GiB and
> > you don't have LBA48 support you get a wraparound effect that causes
> > corruption of the data below ~128GiB.  I've seen it happen several
> > times under Win2K in particular.
> 
> It will probably wrap and corrupt data.  The driver is already marked
> HIGHLY EXPERIMENTAL.  Do you think we need bigger hammer

Probably if the driver has set the no lba48 flag and the drive is > 128GB
we need to clip the reported size of the volume and/or print a message
and skip it
