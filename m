From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ide pmac breakage
Date: Thu, 31 Jul 2008 11:09:19 +1000
Message-ID: <1217466559.11188.378.camel@pasglop>
References: <1217208596.11188.144.camel@pasglop>
	 <200807302111.54514.bzolnier@gmail.com>
	 <1217458152.11188.355.camel@pasglop>
	 <200807310248.29214.bzolnier@gmail.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:49717 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753000AbYGaBJd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Jul 2008 21:09:33 -0400
In-Reply-To: <200807310248.29214.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, petkovbb@gmail.com

On Thu, 2008-07-31 at 02:48 +0200, Bartlomiej Zolnierkiewicz wrote:
> There seems to be some confusion between warm-plugging of IDE devices
> and hot-plugging of IDE devices.
> 
> > not a single piece of HW to exercise those code path ? I don't ask you
> > to get a powermac with a media-bay, but ide_cs seems to be a pretty
> > important one that's part of what the ide maintainer should take care
> > of... And I suspect it's going to exercise the same code path as
> > mediabay.
> 
> I'm open for offers of co-maintaince of the code (which includes taking
> over particular host drivers) and since you seem to have pretty good
> insight into what ide maintainer should be doing I presume that you want
> to be added to MAINTAINERS?

Should I laugh ?

Seriously here. Those things used to work, you broke them.

It may be worthwile cleanup / improvements, but at the end of the day,
if you are the maintainer for drivers/ide, and things as fundamental as
supporting proper ide_cs seems to be totally part of your job. I'm not
saying ide_cs is broken today (though I suspect it -may- be suffering
from similar breakage to media-bay), however, I'm reacting to your
apparent lack of interest in making sure these things work.

Ben.



