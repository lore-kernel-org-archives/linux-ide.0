From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [1/12]
Date: Sun, 13 Jun 2004 19:36:08 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200406131936.08338.bzolnier@elka.pw.edu.pl>
References: <200406111750.30312.bzolnier@elka.pw.edu.pl> <20040612103453.GB26482@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:41924 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265232AbUFMRcF
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Jun 2004 13:32:05 -0400
In-Reply-To: <20040612103453.GB26482@infradead.org>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 12 of June 2004 12:34, Christoph Hellwig wrote:
> On Fri, Jun 11, 2004 at 05:50:30PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Probably some drivers are still missed because I changed only
> > these drivers that I knew that there are PCI cards using them.
> >
> > If you know about PCI cards using other drivers please speak up.
>
> IMHO the PCI ->probe methods should always be __devinit.  It's rather
> hard to make sure they're never every hotplugged in any way, especially
> with the dynamic id adding via sysfs thing.

I generally agree but IMO it makes no sense for i.e. piix.c.

