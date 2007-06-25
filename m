From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ide/dma not working from 2.6.19 to 2.6.21
Date: Mon, 25 Jun 2007 10:10:09 +0100
Message-ID: <20070625101009.48269d6e@the-village.bc.nu>
References: <7ac1e90c0706210447k7c1bdb26y43d62e930ce7728e@mail.gmail.com>
	<467A9923.6010203@ru.mvista.com>
	<467F5127.4060006@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51646 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750718AbXFYJEv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jun 2007 05:04:51 -0400
In-Reply-To: <467F5127.4060006@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: albertcc@tw.ibm.com, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bahadir Balban <bahadir.balban@gmail.com>, linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>

> Reloading the pata_pdc2027x module then the problem goes away.
> I guess maybe somehow mdelay() is not as precise as before...

It's not the most accurate of things once power management and the like
get invovled. HT doesn't help it either. You should have get much more
accurate timing information if you query gettimeofday before/after and do
a few loops.

Alan

