From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide pmac breakage
Date: Thu, 31 Jul 2008 02:48:28 +0200
Message-ID: <200807310248.29214.bzolnier@gmail.com>
References: <1217208596.11188.144.camel@pasglop> <200807302111.54514.bzolnier@gmail.com> <1217458152.11188.355.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:43369 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbYGaAu4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2008 20:50:56 -0400
Received: by fk-out-0910.google.com with SMTP id 18so224300fkq.5
        for <linux-ide@vger.kernel.org>; Wed, 30 Jul 2008 17:50:54 -0700 (PDT)
In-Reply-To: <1217458152.11188.355.camel@pasglop>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, petkovbb@gmail.com

On Thursday 31 July 2008, Benjamin Herrenschmidt wrote:
> On Wed, 2008-07-30 at 21:11 +0200, Bartlomiej Zolnierkiewicz wrote:
> > 
> > > Note that there shouldn't be anything fundamentally different from
> > > ide-pmac here vs. something like pcmcia IDE cards... do you have one
> > of
> > > these to test with ?
> > 
> > Nope and I really don't intend to have one.  I count on other people
> > to take some care of support for host drivers that they
> > maintain/use. ;)
> 
> Hrm... that's not a very sane approach. You have some infrastructure for
> adding / removing devices, in fact changes things in that area even, and

There seems to be some confusion between warm-plugging of IDE devices
and hot-plugging of IDE devices.

> not a single piece of HW to exercise those code path ? I don't ask you
> to get a powermac with a media-bay, but ide_cs seems to be a pretty
> important one that's part of what the ide maintainer should take care
> of... And I suspect it's going to exercise the same code path as
> mediabay.

I'm open for offers of co-maintaince of the code (which includes taking
over particular host drivers) and since you seem to have pretty good
insight into what ide maintainer should be doing I presume that you want
to be added to MAINTAINERS?
