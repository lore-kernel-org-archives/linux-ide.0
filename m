From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: libata+SGIO:  is .dma_boundary respected?
Date: Tue, 21 Mar 2006 13:43:26 -0600
Message-ID: <1142970206.3428.12.camel@mulgrave.il.steeleye.com>
References: <441DD300.9050702@rtr.ca> <441F544A.6080301@pobox.com>
	 <441F8478.50806@rtr.ca> <441F99AC.4000200@pobox.com>
	 <442006BC.8020100@rtr.ca> <20060321184215.GJ4285@suse.de>
	 <442051A0.1050200@rtr.ca> <4420541E.3070303@pobox.com>
	 <44205484.9000702@rtr.ca> <44205525.20306@rtr.ca>
	 <20060321193538.GO4285@suse.de>  <44205642.7070302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:26285 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751497AbWCUTnl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Mar 2006 14:43:41 -0500
In-Reply-To: <44205642.7070302@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Tue, 2006-03-21 at 14:38 -0500, Jeff Garzik wrote:
> Strongly agreed.  ISTR JamesB had some concrete thoughts in that 
> direction, but they never made it beyond an IRC channel and/or a few emails.

Actually, I had a patch for it ... but it never really went anywhere.
The argument being that the machines which would actually need it didn't
use IDE anyway ...

James


