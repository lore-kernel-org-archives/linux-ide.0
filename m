From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: libata: set queue SSD flag for SSD devices
Date: Sat, 11 Oct 2008 09:33:37 +0200
Message-ID: <1223710417.4159.11.camel@localhost.localdomain>
References: <200810101904.m9AJ42Gq018897@hera.kernel.org>
	 <20081010202515.446857cc@lxorguk.ukuu.org.uk>
	 <20081010200528.GJ19428@kernel.dk>  <20081010175508.3d1ed2a4@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:55552 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750816AbYJKHdp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Oct 2008 03:33:45 -0400
In-Reply-To: <20081010175508.3d1ed2a4@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, torvalds@osdl.org

On Fri, 2008-10-10 at 17:55 -0700, Arjan van de Ven wrote:
> On Fri, 10 Oct 2008 22:05:28 +0200
> Jens Axboe <jens.axboe@oracle.com> wrote:
> > 
> > In this specific patch, it'll do no harm at least since I very much
> > doubt we'll see a false positive. And even if, the consequences wont
> > be dire. But it does want the version check, of course.
> > 
> 
> also, is "is an ssd" the right question or is "doesn't have seek
> latency" the right one?
> (difference is.. well EMC boxes with lots of ram etc)

For libata, the is ssd is the right test.

For things like the symmetrix we probably need to look at the caching
mode page and treat it like ssd if the cache is say > 1GB or whatever
heuristic is needed.

James


