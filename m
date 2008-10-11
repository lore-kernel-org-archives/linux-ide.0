From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: libata: set queue SSD flag for SSD devices
Date: Sat, 11 Oct 2008 08:36:51 +0200
Message-ID: <20081011063650.GL19428@kernel.dk>
References: <200810101904.m9AJ42Gq018897@hera.kernel.org> <20081010202515.446857cc@lxorguk.ukuu.org.uk> <20081010200528.GJ19428@kernel.dk> <20081010175508.3d1ed2a4@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:41482 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754061AbYJKGh2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Oct 2008 02:37:28 -0400
Content-Disposition: inline
In-Reply-To: <20081010175508.3d1ed2a4@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, torvalds@osdl.org

On Fri, Oct 10 2008, Arjan van de Ven wrote:
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

The block layer uses the 'non rotational' nomenclature for this, but
that's not perfect either. And neither is 'no seek', a single
"parameter" is not enough to describe the device. But it's good enough I
think, it'll be expanded later with a (bit) fuller profile.

-- 
Jens Axboe

