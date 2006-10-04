From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git patches] libata updates
Date: Wed, 04 Oct 2006 15:34:40 +0100
Message-ID: <1159972481.25772.20.camel@localhost.localdomain>
References: <20061004060212.GA4653@havoc.gtf.org>
	 <1159962434.25772.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2736 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964888AbWJDOJm
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Oct 2006 10:09:42 -0400
In-Reply-To: <1159962434.25772.19.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Ar Mer, 2006-10-04 am 12:47 +0100, ysgrifennodd Alan Cox:
> Ar Mer, 2006-10-04 am 02:02 -0400, ysgrifennodd Jeff Garzik:
> > Final libata batch for 2.6.19.  Meant to send this a couple days ago.
> > 
> > Nothing interesting:  minor bugfix, some cleanups, improved diagnostics.
> 
> Please also include the following. The first fixes support for rev c8 of
> the ALi/ULi PATA. The second keeps pcmcia in sync so ide_cs and
> pata_pcmcia are interchangable, both are only changes to constants.
> 
> Right now rev 0xC8 and higher don't work with libata but 0xc8 is in the
> field now.

Forgot

Signed-off-by: Alan Cox <alan@redhat.com>


