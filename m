From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: How to cleanly setup legacy IDE irq ?
Date: Mon, 04 Oct 2004 11:20:23 +1000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1096852823.9539.61.camel@gaston>
References: <1096602694.11460.29.camel@gaston>
	 <200410032254.16900.bzolnier@elka.pw.edu.pl>
	 <1096846969.9516.39.camel@gaston>
	 <200410040227.14513.bzolnier@elka.pw.edu.pl>
	 <1096851939.9516.53.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:59587 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268299AbUJDBZD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Oct 2004 21:25:03 -0400
In-Reply-To: <1096851939.9516.53.camel@gaston>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org


> Ugh ? damn, that's a textboot example of crappy code ! You are
> putting interrupt routing platform knowledge in non-platform specific
> drivers, that is disgusting !

Please, don't take my harsh language to seriously, I missed adding
a couple of ;)

Just to summarize, I totally agree with you that the existing callbacks
are ugly and the way of setting up on-board controllers, especially non
PCI ones, should be to have proper controller drivers.

But as I think I made clear in previous mail, I'm just talking about
the specific issue of IRQ routing for PCI controllers set in legacy mode,
to avoid cluttering "generic" drivers with all sort of platform ifdef's
for something that has really nothing to do with the driver logic itself...  

Ben.


