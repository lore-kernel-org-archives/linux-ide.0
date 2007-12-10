From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/20] dtc2278: ->io_32bit setting don't have to be
 identical for master/slave
Date: Mon, 10 Dec 2007 00:01:59 +0000
Message-ID: <20071210000159.6da64fac@the-village.bc.nu>
References: <200712092208.58494.bzolnier@gmail.com>
	<200712100015.15735.bzolnier@gmail.com>
	<20071209230736.2cdb6e44@the-village.bc.nu>
	<200712100052.28528.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36799 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751225AbXLJAHX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 19:07:23 -0500
In-Reply-To: <200712100052.28528.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On Mon, 10 Dec 2007 00:52:28 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On Monday 10 December 2007, Alan Cox wrote:
> > > There is absolutely no hardware setup done by IDE subsystem or dtc2278
> > > host driver when ->io_32bit setting is changed and since ->io_32bit setting
> > 
> > So ?
> > 
> > The original author went to great trouble to specifically enforce the
> > behaviour in question and probably did so for a reason. Would it not be
> 
> Probably so but please keep in mind the state of IDE subsystem back
> then...
> 
> > far safer to fix it by keeping that enforcement and fixing where it is
> > lost than removing it - especially if you cannot test the hardware ?
> 
> What about just enforcing ->io_32bit for both drives in ->init_hwif method
> and disallowing any futher changes with 'hwif->no_io_32bit = 1'?

Sounds fine to me. 

Alan
