From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/3] libata: add missing PM callbacks
Date: Tue, 6 Mar 2007 09:05:09 +0100
Message-ID: <20070306080509.GA2040@elf.ucw.cz>
References: <20070302083001.GK20322@htj.dyndns.org> <45E8B3C8.2090009@garzik.org> <45E8E749.4030406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43016 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751672AbXCFIFi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 03:05:38 -0500
Content-Disposition: inline
In-Reply-To: <45E8E749.4030406@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi!

> [cc'ing Pavel and linux-kernel, hello]
> 
> Original thread can be read from
> 
>   http://thread.gmane.org/gmane.linux.ide/16475
> 
> Jeff Garzik wrote:
> > Tejun Heo wrote:
> >> Some LLDs were missing scsi device PM callbacks while having host/port
> >> suspend support.  Add missing ones.
> >>
> >> Signed-off-by: Tejun Heo <htejun@gmail.com>
> > 
> > applied 1-3, though I agree with Alan that a non-ifdef solution should
> > be sought (by the PM & PCI people?), where possible
> 
> Agreed, CONFIG_PM ifdefs are all over low level drivers, libata or not,
> and ugly as hell.  Maybe use separate section, mark functions with
> __power and drop them at link time is a better idea.  With linker
> tricks, we can make references to __power symbols NULL.  How does it sound?

Much complexity for little gain. Who is running _without_ CONFIG_PM
these days?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
