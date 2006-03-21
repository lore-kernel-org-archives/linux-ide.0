From: Jens Axboe <axboe@suse.de>
Subject: Re: libata+SGIO:  is .dma_boundary respected?
Date: Tue, 21 Mar 2006 20:46:50 +0100
Message-ID: <20060321194649.GR4285@suse.de>
References: <441F99AC.4000200@pobox.com> <442006BC.8020100@rtr.ca> <20060321184215.GJ4285@suse.de> <442051A0.1050200@rtr.ca> <4420541E.3070303@pobox.com> <44205484.9000702@rtr.ca> <44205525.20306@rtr.ca> <20060321193538.GO4285@suse.de> <44205642.7070302@pobox.com> <1142970206.3428.12.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:278 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751531AbWCUTrI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 14:47:08 -0500
Content-Disposition: inline
In-Reply-To: <1142970206.3428.12.camel@mulgrave.il.steeleye.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Tue, Mar 21 2006, James Bottomley wrote:
> On Tue, 2006-03-21 at 14:38 -0500, Jeff Garzik wrote:
> > Strongly agreed.  ISTR JamesB had some concrete thoughts in that
> > direction, but they never made it beyond an IRC channel and/or a few
> > emails.
> 
> Actually, I had a patch for it ... but it never really went anywhere.
> The argument being that the machines which would actually need it didn't
> use IDE anyway ...

Do <insert random device here> really never have segment or boundary
restrictions outside of IDE? Seems to me that supporting that would be
the conservative and sane thing to do.

-- 
Jens Axboe

