From: Frans Pop <elendil@planet.nl>
Subject: Re: cmd64x: irq 14: nobody cared - system is dreadfully slow
Date: Mon, 22 Jun 2009 05:47:54 +0200
Message-ID: <200906220547.55470.elendil@planet.nl>
References: <200906202352.33894.elendil@planet.nl> <20090621.141950.160759111.davem@davemloft.net> <200906220034.22430.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpsmtpm-eml105.kpnxchange.com ([195.121.3.9]:53547 "EHLO
	CPSMTPM-EML105.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751636AbZFVDry (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Jun 2009 23:47:54 -0400
In-Reply-To: <200906220034.22430.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org

On Monday 22 June 2009, Bartlomiej Zolnierkiewicz wrote:
> I'm really tired of this kind of hostility towards IDE changes and I
> also don't have time for such unproductive discussions.

I can see your PoV, but OTOH I think you'll have to agree that having a 
driver break very early in the 2.6.29 cycle and not finding out about it 
until 2 full cycles later is not a good thing.

Although PATA has its own problems and the whole switch from IDE to PATA 
has had much more than its fair share of issues, it is a fact that most 
distros and users _are_ switching to the PATA drivers. The only reason I 
ran into this is because Debian is one of the very few who has not yet 
done so and my U10 is one of the few boxes I run a distro kernel on.

Your and Borislav's (and others) cleanup efforts have been huge and I've 
absolutely no doubt that they have brought major structural improvements 
to the IDE subsystem. One can but wonder whether PATA would have happened 
at all if that effort had started 5 years or so earlier...

But the problem remains that getting enough (especially timely) testing 
will be an ever increasing problem for the IDE drivers, simply because 
most users, and especially those users who do kernel testing during 
development cycles, no longer use them. For that reason I think that 
David's standpoint that IDE should be treated as a purely legacy 
subsystem makes sense.

Let me finish by joining others in thanking you for your huge efforts over 
the past years and complimenting you on the graceful way you're allowing 
this maintainer change to happen. I hope you will find a new challenge in 
the kernel; it would be a great pity to lose your skills and dedication.

Cheers,
FJP
