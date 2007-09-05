From: "Eddie Hung" <eddie.hung@gmail.com>
Subject: Re: CF as IDE on ICH6M using libata
Date: Wed, 5 Sep 2007 23:03:59 +0100
Message-ID: <6f9550040709051503k5b0a07b1x3e21bae3667ce17@mail.gmail.com>
References: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>
	 <46DAB5DD.80807@gmail.com> <46DEE72B.2060702@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:48183 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754324AbXIEWEC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2007 18:04:02 -0400
Received: by mu-out-0910.google.com with SMTP id i10so3175310mue
        for <linux-ide@vger.kernel.org>; Wed, 05 Sep 2007 15:04:00 -0700 (PDT)
In-Reply-To: <46DEE72B.2060702@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Hello all,

After trying a fake Extreme IV, then an Extreme III (which doesn't
support UDMA) and then back onto another Extreme IV - I can finally
report success!

I am now using UDMA4 and enjoying speeds of 30+MB/s which is all very
nice!!! (The other X41 user who reported success was also using a UDMA
capable card)

However, I think we can conclude that ICH6M (which on the X41, has a
SATA-PATA bridge to connect a PATA drive) does not seem to support
MWDMA (especially as it is not completely supported under Windows
either - it is *incredibly* slow but does not give the same timeout
problems as with libata), nor does libata it drop down gracefully to
PIO4 when it detects these timeouts.

Thanks everybody,

Eddie

On 05/09/07, Mark Lord <liml@rtr.ca> wrote:
> Tejun Heo wrote:
> > ..
> > I don't think the device supports UDMA.  Supported transfer modes are
> > indicated in the IDENTIFY page (hdparm -I) and libata/ide would use UDMA
> > if the device reports so.  There's no black magic there.
> >
> >
>
> Some newer CF Cards have a funky way of reporting UDMA.
> Get a copy of hdparm-7.7 (sourceforge) and try "hdparm -I"
> using it, and post the output here.
>
> We may (or not) need to update libata to recognize UDMA on CF cards.
>
> Cheers
>
