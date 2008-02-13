From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [libata-dev #upstream-fixes] pata_legacy: don't call
	ata_host_detach() after initialization failure
Date: Wed, 13 Feb 2008 10:24:30 +0100
Message-ID: <20080213092430.GA25258@elte.hu>
References: <alpine.LFD.1.00.0802101603240.2920@woody.linux-foundation.org> <20080212081816.GA17820@elte.hu> <20080212071452.5c58ae6d@laptopd505.fenrus.org> <20080213090159.GA21614@elte.hu> <47B2B653.7020408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:38568 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932507AbYBMJZF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Feb 2008 04:25:05 -0500
Content-Disposition: inline
In-Reply-To: <47B2B653.7020408@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Mark Lord <mlord@pobox.com>, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>


* Tejun Heo <htejun@gmail.com> wrote:

> ata_host_detach() detaches an attached port and shouldn't be called on 
> a port which hasn't been attached yet.  pata_legacy incorrectly calls 
> ata_host_detach() on unattached port after initialization failure 
> causing oops.  Fix it.

thanks, i'll try this!

	Ingo
