From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git patch] libata fix
Date: Mon, 25 Sep 2006 21:27:02 +0100
Message-ID: <1159216022.11049.132.camel@localhost.localdomain>
References: <20060925193511.GA6129@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12703 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750811AbWIYUDB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Sep 2006 16:03:01 -0400
In-Reply-To: <20060925193511.GA6129@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Ar Llu, 2006-09-25 am 15:35 -0400, ysgrifennodd Jeff Garzik:
> + * Define if arch has non-standard setup.  This is a _PCI_ standard
> + * not a legacy or ISA standard.

The IRQs bit isn't.

I've got some better changes I'm testing here but they touch the PCI
core code so want to shake through -mm first I think so fine by me.

Alan

