From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] Move various PCI IDs to header file
Date: Mon, 08 May 2006 10:31:59 +0200
Message-ID: <1147077120.2888.5.camel@laptopd505.fenrus.org>
References: <20060504180614.X88573@chenjesu.americas.sgi.com>
	 <20060504173722.028c2b24.rdunlap@xenotime.net> <445AE690.5030700@sgi.com>
	 <Pine.LNX.4.58.0605050926250.3161@shark.he.net>
	 <0jkn52lnu505eb26plf5o7buertimg2e6v@4ax.com>  <445EF968.3080903@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:48806 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932268AbWEHIcG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 May 2006 04:32:06 -0400
In-Reply-To: <445EF968.3080903@sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jes Sorensen <jes@sgi.com>
Cc: Grant Coady <gcoady.lk@gmail.com>, "Randy.Dunlap" <rdunlap@xenotime.net>, Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@osdl.org, jeremy@sgi.com

On Mon, 2006-05-08 at 09:55 +0200, Jes Sorensen wrote:
> Grant Coady wrote:
> > When I worked on pci_ids.h cleanup last year I didn't get a clear 
> > idea of whether moving all #defines to the one header file was 
> > desired.  Last I looked there were heaps of them scattered all 
> > over.  Is there a preferred model for placing these #defines?
> > 
> > Grant.
> 
> According to the document Randy referenced, the preferred place for
> *new* defines is to stick them in the local files where they are used.
> I don't think there is any preference for moving the out of pci_ids.h
> as it would just cause patch noise for the sake of making noise.
> 
> So much for being able to go through the pci_ids.h file to get an idea
> about whether or not a device may have a chance of being supported :(

that wasn't there ever anyway..

modules.pcimap is more like it anyway

