From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: libata+SGIO:  is .dma_boundary respected?
Date: Tue, 21 Mar 2006 14:44:04 -0600
Message-ID: <1142973844.3428.22.camel@mulgrave.il.steeleye.com>
References: <441F99AC.4000200@pobox.com> <442006BC.8020100@rtr.ca>
	 <20060321184215.GJ4285@suse.de> <442051A0.1050200@rtr.ca>
	 <4420541E.3070303@pobox.com> <44205484.9000702@rtr.ca>
	 <44205525.20306@rtr.ca> <20060321193538.GO4285@suse.de>
	 <44205642.7070302@pobox.com>
	 <1142970206.3428.12.camel@mulgrave.il.steeleye.com>
	 <20060321194649.GR4285@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:4271 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932445AbWCUUp3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Mar 2006 15:45:29 -0500
In-Reply-To: <20060321194649.GR4285@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Tue, 2006-03-21 at 20:46 +0100, Jens Axboe wrote:
> Do <insert random device here> really never have segment or boundary
> restrictions outside of IDE? Seems to me that supporting that would be
> the conservative and sane thing to do.

Well the only machines that actually turn on virtual merging are sparc
and parisc.  They have a small list of "certified" devices for them,
none of which seems to have aribtrary segment boundary restrictions
(although most of them have the standard 4GB one).

When I brought this up the last time it degenerated into a slanging
match over the value of virtual merging (which no-one can seem to
provide a definitive answer to).

James


