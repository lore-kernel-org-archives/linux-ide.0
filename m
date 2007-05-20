From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [3/5] 2.6.22-rc2: known regressions
Date: Sun, 20 May 2007 15:32:54 +0100
Message-ID: <20070520153254.12758f82@the-village.bc.nu>
References: <464F6DC9.80805@googlemail.com>
	<464F74D5.9080204@googlemail.com>
	<46502847.40204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47737 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755475AbXETOaS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 May 2007 10:30:18 -0400
In-Reply-To: <46502847.40204@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Jeff Garzik <jeff@garzik.org>, Francis Russell <francisrussell@btopenworld.com>, Robert de Rooy <robert.de.rooy@gmail.com>, Alan Cox <alan@redhat.com>, video4linux@list.redhat.com, Mauro Carvalho Chehab <mchehab@infradead.org>, Hans Verkuil <hverkuil@xs4all.nl>, Robert Fitzsimons <robfitz@273k.net>

> > Subject    : pata_via appears to incorrectly detects 40-pin cable
> > References : http://lkml.org/lkml/2007/5/17/273
> >              http://bugzilla.kernel.org/show_bug.cgi?id=8142
> > Submitter  : Francis Russell <francisrussell@btopenworld.com>
> > Status     : Unknown
> 
> Not really a regression.  Alan seems to have a general fix and I think
> we can also quirk the specific case.

Fixed in my tree not a regression. I'll try and push some bits monday
this included.

Alan
