From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: fix broken Kconfig setup
Date: Thu, 20 Oct 2005 15:14:44 +0100
Message-ID: <1129817684.15200.11.camel@localhost.localdomain>
References: <20051017044606.GA1266@havoc.gtf.org>
	 <200510170952.34174.jbarnes@virtuousgeek.org> <4353D96F.90805@pobox.com>
	 <200510171006.39206.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:56449 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751361AbVJTNqf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Oct 2005 09:46:35 -0400
In-Reply-To: <200510171006.39206.jbarnes@virtuousgeek.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, davej@redhat.com

> So sometimes the legacy IDE driver will lock up when it tries to drive 
> both ports in a combined configuration?  In that case, can't we just 
> disable the legacy IDE driver for these chips and force the use of the 
> libata version?

Now that libata is beginning to behave well I'd vote for that option,
however in kernel libata lacks several essential items for PATA feature
parity (HPA, ATAPI, suspend/resume, correct tuning). It's getting there
and I've got some more stuff waiting for Jeff, but it isn't there yet

