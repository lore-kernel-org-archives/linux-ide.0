From: Tejun Heo <htejun@gmail.com>
Subject: Re: CF flash PATA on libata failure to attach
Date: Fri, 29 Jun 2007 10:36:48 +0900
Message-ID: <46846230.6080908@gmail.com>
References: <11172839.post@talk.nabble.com>	<46766BD3.4040702@gmail.com> <20070618125742.28a0bc57@the-village.bc.nu> <46770edc.101d640a.4fdf.4eae@mx.google.com> <46776306.5030300@gmail.com> <4679cefc.06d7720a.0280.ffff9cce@mx.google.com> <4679EA43.4040002@gmail.com> <467a2692.17bb720a.5a14.ffffa80c@mx.google.com> <467A8F17.1080608@rtr.ca> <4680d387.24528c0a.3634.69bd@mx.google.com> <46815FF4.9040001@rtr.ca> <4681e04b.22b38c0a.78ec.6f76@mx.google.com> <46826F42.70405@rtr.ca> <4682f7a3.15538c0a.2e12.ffff8676@mx.google.com> <4683F1C9.2060505@rtr.ca> <468453f8.13578c0a.3c99.ffffa514@mx.google.com> <46845BEE.90801@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:23204 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757127AbXF2Bgy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jun 2007 21:36:54 -0400
Received: by nz-out-0506.google.com with SMTP id s18so299041nze
        for <linux-ide@vger.kernel.org>; Thu, 28 Jun 2007 18:36:53 -0700 (PDT)
In-Reply-To: <46845BEE.90801@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Andrew Hall <andrew.a.hall@gmail.com>, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>

Hello,

Mark Lord wrote:
> Here's a slightly modified hack, which should leave your SATA
> drive working as well as the CF card.
> 
> Tejun / Alan : do we really want to continue attempting mdma2
> on a modern chipset such as ICH8 ???

One thing that worries me is that we have reports where the IDE piix can
do mwdma but ata_piix can't.  I wonder whether Andrew is hitting the
same problem.

> The best mdma2 can do is the same throughput as pio4,
> and the bus occupancy is so high for mdma2 that it really
> probably isn't worthwhile -- only CF cards seem to use it
> in modern systems anyway.

There also seem to be devices which claim to support mwdma2 but pukes
when actual commands are given.  Do we know whether the other os uses
mwdma mode?

-- 
tejun
