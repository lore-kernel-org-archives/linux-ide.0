From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [rfc/patch] libata -- port configurable delays
Date: Fri, 13 May 2005 22:52:59 +0100
Message-ID: <1116021178.20545.3.camel@localhost.localdomain>
References: <20050513185850.GA5777@kvack.org> <4284FC6E.7060300@pobox.com>
	 <20050513200312.GA6555@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:24011 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262561AbVEMVyg
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 May 2005 17:54:36 -0400
In-Reply-To: <20050513200312.GA6555@kvack.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Gwe, 2005-05-13 at 21:03, Benjamin LaHaise wrote:
> > 3) IIRC some rare PATA devices don't like having their Status register 
> > banged "too hard".  No data, just a vague memory.

Not that I am aware of. There are a few ICH/PIIX variants where if you
read status during a transaction at the wrong time bad stuff occurs
including to the block on disk. That may be what you are thinking of

> > 
> > 4) It may be worthwhile to rewrite the loop to check the Status register 
> > _first_, then delay.

The 400nS delay after a command is required before status becomes valid.
This isn't about 'incorrect' devices in the command case. It is about
strictly correct behaviour and propogation/response times. For the cases
its not required and you wan to keep PCI load down then checking first
is clearly logical.

Also btw beware of PCI posting - writel/ndelay(400) isn't going to do
the right thing.

