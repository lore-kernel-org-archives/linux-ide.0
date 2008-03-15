From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/4] disk-protect: Add a REQ_TYPE_LINUX_BLOCK request handler to libata
Date: Sat, 15 Mar 2008 13:42:27 +0100
Message-ID: <20080315124227.GB4669@ucw.cz>
References: <87skzgd1zk.fsf@denkblock.local> <20080226123946.75dbe3d2@core> <87mypl8p49.fsf@denkblock.local> <20080228111349.6831925c@core> <87bq5qfm2v.fsf@denkblock.local> <20080307181750.9981.16714.stgit@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4120 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751712AbYCOMme (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Mar 2008 08:42:34 -0400
Content-Disposition: inline
In-Reply-To: <20080307181750.9981.16714.stgit@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

On Fri 2008-03-07 19:26:14, Elias Oltmanns wrote:
> Defines a generic handler to be used as the lb_request_fn() callback for
> libata managed hosts. Support for REQ_LB_OP_FREEZE and REQ_LB_OP_THAW is
> included as well.

> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>

Both this and previous patch look ok to me -- but I'm not ATA
person...

It would be nice to get them in - thinkpad x42 kills few disks a year
when running w/o active protection.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
