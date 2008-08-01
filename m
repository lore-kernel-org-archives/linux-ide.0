From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ide pmac breakage
Date: Sat, 02 Aug 2008 08:26:18 +1000
Message-ID: <1217629578.11188.516.camel@pasglop>
References: <1217208596.11188.144.camel@pasglop>
	 <1217478322.11188.410.camel@pasglop>
	 <200807311251.02251.bzolnier@gmail.com>
	 <200808011254.02989.bzolnier@gmail.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54875 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754922AbYHAW0e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Aug 2008 18:26:34 -0400
In-Reply-To: <200808011254.02989.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, petkovbb@gmail.com

On Fri, 2008-08-01 at 12:54 +0200, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 31 July 2008, Bartlomiej Zolnierkiewicz wrote:
> 
> [...]
> 
> Sorry if my mails were a bit harsh but nobody likes to be pushed around.
> 
> [ It is not like I don't want to add proper hot-plugging support or do test
>   on more hardware but my time schedule is already tight enough and there are
>   still more fundamental things to address (which take priority). ]
> 
> > -                host->dev[0] = hws[0]->dev;
> > +                host->dev[0] = hws[0]->parent ? hws[0]->parent : hws[0]->dev;
> > 
> > Could you please try it together with my previous patch for
> > ide_device_{get,put}()?
> 
> Please test it when you have some time.

The problem in that case is access to the HW :-) I have plenty ide-pmac
based machines but only one or two old laptop (ie. Paul has one too)
with a media-bay and those are in the office. So I'll test on Monday
when I get there, unless I get a chance to pop by on Sunday but that's
unlikely.

Ben.


