From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Possibly wrong BIO usage in ide_multwrite
Date: Mon, 5 Jan 2004 18:13:30 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200401051813.30625.bzolnier@elka.pw.edu.pl>
References: <1072977507.4170.14.camel@leto.cs.pocnet.net> <200401051747.45039.bzolnier@elka.pw.edu.pl> <20040105164902.GA3483@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:38067 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265191AbUAERKc
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Jan 2004 12:10:32 -0500
In-Reply-To: <20040105164902.GA3483@suse.de>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Christophe Saout <christophe@saout.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 05 of January 2004 17:49, Jens Axboe wrote:
> On Mon, Jan 05 2004, Bartlomiej Zolnierkiewicz wrote:
> > > calling end_request with a null sector count, ide_end_request will then
> > > take hard_nr_sectors which will end the whole request even if only one
> > > bio was finished, huh? Am I missing something here?
> >
> > No, it is used mainly to fail requests.
> >
> > This hack should be later removed with care
> > (there is some strange comment about locking).
>
> IIRC, it's due to it not always being safe to inspect rq state outside
> of ide_lock. So that makes 0 a magic value that just means 'end the
> first chunk' for ide_end_request().

Why/when it is not safe to do?

