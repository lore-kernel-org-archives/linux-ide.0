From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: Fix crash on repeated reset
Date: Mon, 04 Sep 2006 23:04:37 +0100
Message-ID: <1157407477.9018.0.camel@localhost.localdomain>
References: <1157378041.30801.78.camel@localhost.localdomain>
	 <20060904193807.GA6118@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14245 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964845AbWIENSv
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Sep 2006 09:18:51 -0400
In-Reply-To: <20060904193807.GA6118@rhlx01.fht-esslingen.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Ar Llu, 2006-09-04 am 21:38 +0200, ysgrifennodd Andreas Mohr:
> Hi,
> 
> On Mon, Sep 04, 2006 at 02:54:01PM +0100, Alan Cox wrote:
> >  	unsigned int sleeping	: 1;
> >  		/* BOOL: polling active & poll_timeout field valid */
> >  	unsigned int polling	: 1;
> > +	 	/* BOOL: in a polling reset situation. Must not trigger another reset yet */
> > +	unsigned	resetting  : 1;
> > +
> 
> Inconsistent variable type declarations/formatting?

Harmless but true. Updated in my tree.

Alan

