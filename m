From: Mark Lord <liml@rtr.ca>
Subject: Re: libata and PATA devices
Date: Thu, 11 Aug 2005 13:05:02 -0400
Message-ID: <42FB853E.4070100@rtr.ca>
References: <200508071949.03782.inform@tiker.net>	 <42F6B8CD.4050100@gmail.com>  <20050808030239.GA27502@havoc.gtf.org> <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca> <42FACCA8.6050408@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:57094 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751117AbVHKRE5
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Aug 2005 13:04:57 -0400
In-Reply-To: <42FACCA8.6050408@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Erik Slagter <erik@slagter.name>, linux-ide@vger.kernel.org

Jeff Garzik wrote:

> currently no one should be using libata for PATA support.

We emailed back and forth extensively about how this has
not been true since early this year.  Modern laptops are
using libata for the ICH6M support, simply because libata
claims that chipset, and the IDE driver does not.
These laptops are using PATA drives (eg. "FUJITSU MHV2100AH").

> Exaggeration.  We're talking about a single #define here, to enable ATAPI.

Fine for ATAPI, though it's two defines -- need to also enable DMA.
And Passthru is much bigger than a pair of #defines.

If we want more testing/feedback on them, they've got to be
put into wider use.  That simply doesn't happen when they're
tucked away in git repositories.

Sure, *I* using them from your git, but there are tons of
other people for whom that is an overly complex method,
and the result is that few of us bother.

On the other hand, some distros (eg. Ubuntu) are shipping with
Passthru included in their kernels, because it's so necessary
for things like laptop-mode.

Push some of this stuff out to the -mm tree, and maybe we'll get
more people exercising the code, and it'll progress more quickly.

"Release early, release often" -- the open source mantra.

Cheers!
