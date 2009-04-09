From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PROPOSED] ata: Report 16/32bit PIO as best we can
Date: Thu, 9 Apr 2009 14:58:55 +0100
Message-ID: <20090409145855.44183fe6@lxorguk.ukuu.org.uk>
References: <20090409133221.18202.63779.stgit@t61.ukuu.org.uk>
	<49DDEF02.7090004@garzik.org>
	<20090409135323.5b2bed4b@lxorguk.ukuu.org.uk>
	<49DDF33E.6000102@garzik.org>
	<20090409141254.283d9f11@lxorguk.ukuu.org.uk>
	<49DDFBE4.40702@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53066 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753384AbZDIN7l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Apr 2009 09:59:41 -0400
In-Reply-To: <49DDFBE4.40702@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

> ap->flags is owned by EH context and only EH can change it.
> ap->pflags is for dynamic flags and can be changed under port lock by
> anyone but I forgot why I named that pflags instead of dflags.

Ok added comments to that effect to libata.h (I guess you used pflag not
dflag as ATA_DFLAG_xx is already used ?) and switched to using pflags.

Alan
