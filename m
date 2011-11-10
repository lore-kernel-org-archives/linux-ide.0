From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] ata: Don't use NO_IRQ in pata_of_platform driver
Date: Thu, 10 Nov 2011 15:38:16 +0000
Message-ID: <20111110153816.239af1d7@lxorguk.ukuu.org.uk>
References: <20111110151852.GA7465@oksana.dev.rtsoft.ru>
	<20111110152606.GB3207@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60468 "EHLO
	earthlight.etchedpixels.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935163Ab1KJPhg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Nov 2011 10:37:36 -0500
In-Reply-To: <20111110152606.GB3207@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@redhat.com>, Grant Likely <grant.likely@secretlab.ca>, Randy Dunlap <rdunlap@xenotime.net>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, devicetree-discuss@lists.ozlabs.org

On Thu, 10 Nov 2011 19:26:06 +0400
Anton Vorontsov <cbouatmailru@gmail.com> wrote:

> Drivers should not use NO_IRQ; moreover, some architectures don't
> have it nowadays. '0' is the 'no irq' case.
> 
> Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>

Acked-by: Alan Cox <alan@linux.intel.com>

Alan
