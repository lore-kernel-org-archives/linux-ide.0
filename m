From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6.28-rc] Sata soft reset filling log
Date: Wed, 17 Dec 2008 10:13:07 +0000
Message-ID: <20081217101307.4614145d@lxorguk.ukuu.org.uk>
References: <494318F5.4060007@gawab.com>
	<20081216210251.138d3e98.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55657 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754773AbYLQKNj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Dec 2008 05:13:39 -0500
In-Reply-To: <20081216210251.138d3e98.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Justin Madru <bevicm@dslextreme.com>, lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Tue, 16 Dec 2008 21:02:51 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> 
> (cc linux-ide).
> 
> This is a post-2.6.27 regression.  Panic!
> 
> On Fri, 12 Dec 2008 18:07:49 -0800 Justin Madru <bevicm@dslextreme.com> wrote:
> 
> > I've been testing .28 (currently -rc8) and I've noticed in the logs a 
> > massive amount of the following.
> > I can confirm that the messages doesn't appear when booting into a .27 
> > kernel.
> > 
> > ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> > ata2.00: ST_FIRST: !(DRQ|ERR|DF)

Which is the first 2.6.28-rc that this appears ?
