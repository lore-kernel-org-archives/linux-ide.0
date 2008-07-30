From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ide pmac breakage
Date: Thu, 31 Jul 2008 08:49:12 +1000
Message-ID: <1217458152.11188.355.camel@pasglop>
References: <1217208596.11188.144.camel@pasglop>
	 <200807292126.12238.bzolnier@gmail.com>
	 <1217401052.11188.318.camel@pasglop>
	 <200807302111.54514.bzolnier@gmail.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48568 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753353AbYG3Wta (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Jul 2008 18:49:30 -0400
In-Reply-To: <200807302111.54514.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, petkovbb@gmail.com

On Wed, 2008-07-30 at 21:11 +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> > Note that there shouldn't be anything fundamentally different from
> > ide-pmac here vs. something like pcmcia IDE cards... do you have one
> of
> > these to test with ?
> 
> Nope and I really don't intend to have one.  I count on other people
> to take some care of support for host drivers that they
> maintain/use. ;)

Hrm... that's not a very sane approach. You have some infrastructure for
adding / removing devices, in fact changes things in that area even, and
not a single piece of HW to exercise those code path ? I don't ask you
to get a powermac with a media-bay, but ide_cs seems to be a pretty
important one that's part of what the ide maintainer should take care
of... And I suspect it's going to exercise the same code path as
mediabay.

Ben.


