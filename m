From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [1/12]
Date: Sat, 12 Jun 2004 11:34:53 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040612103453.GB26482@infradead.org>
References: <200406111750.30312.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.146.154.40] ([213.146.154.40]:59569 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264717AbUFLKez (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Jun 2004 06:34:55 -0400
Content-Disposition: inline
In-Reply-To: <200406111750.30312.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 11, 2004 at 05:50:30PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Probably some drivers are still missed because I changed only
> these drivers that I knew that there are PCI cards using them.
> 
> If you know about PCI cards using other drivers please speak up.

IMHO the PCI ->probe methods should always be __devinit.  It's rather
hard to make sure they're never every hotplugged in any way, especially
with the dynamic id adding via sysfs thing.

