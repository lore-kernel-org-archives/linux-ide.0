From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: claim ctl port for legacy SFF ports
Date: Fri, 8 Jun 2007 16:33:37 +0100
Message-ID: <20070608163337.33f2f13e@the-village.bc.nu>
References: <20070604235157.GD31462@havoc.gtf.org>
	<20070608114119.GE29122@htj.dyndns.org>
	<20070608135517.GA24346@havoc.gtf.org>
	<466963B1.4070208@gmail.com>
	<20070608142437.GA25649@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47730 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S969377AbXFHP2X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 11:28:23 -0400
In-Reply-To: <20070608142437.GA25649@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

> > Allowing legacy to be used on non-PCI systems was your idea!  Alright,
> > then we can drop a lot of junk from legacy SFF code.  Will prep another
> > patch.  Please ignore two patches in this thread.
> 
> Alan seems to be ignoring that idea, so it turned out to be useless...  :/

For the init code stuff it turns out to be useless, for the rest of the
general chip kicking it turns out to be very useful indeed.

Alan
